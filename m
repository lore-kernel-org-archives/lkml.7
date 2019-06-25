Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D498C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6540A2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfFYUFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:05:18 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57408 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfFYUFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:05:17 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 50EBE1A087B;
        Tue, 25 Jun 2019 22:05:15 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 44ACC1A1025;
        Tue, 25 Jun 2019 22:05:15 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E57ED205E5;
        Tue, 25 Jun 2019 22:05:14 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts/gdb: add lx-genpd-summary command
Date:   Tue, 25 Jun 2019 23:05:11 +0300
Message-Id: <f9ee627a0d4f94b894aa202fee8a98444049bed8.1561492937.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is like /sys/kernel/debug/pm/pm_genpd_summary except it's
accessible through a debugger.

This can be useful if the target crashes or hangs because power domains
were not properly enabled.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 scripts/gdb/linux/genpd.py | 83 ++++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py |  1 +
 2 files changed, 84 insertions(+)
 create mode 100644 scripts/gdb/linux/genpd.py

diff --git a/scripts/gdb/linux/genpd.py b/scripts/gdb/linux/genpd.py
new file mode 100644
index 000000000000..6ca93bd2949e
--- /dev/null
+++ b/scripts/gdb/linux/genpd.py
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) NXP 2019
+
+import gdb
+import sys
+
+from linux.utils import CachedType
+from linux.lists import list_for_each_entry
+
+generic_pm_domain_type = CachedType('struct generic_pm_domain')
+pm_domain_data_type = CachedType('struct pm_domain_data')
+device_link_type = CachedType('struct device_link')
+
+
+def kobject_get_path(kobj):
+    path = kobj['name'].string()
+    parent = kobj['parent']
+    if parent:
+        path = kobject_get_path(parent) + '/' + path
+    return path
+
+
+def rtpm_status_str(dev):
+    if dev['power']['runtime_error']:
+        return 'error'
+    if dev['power']['disable_depth']:
+        return 'unsupported'
+    _RPM_STATUS_LOOKUP = [
+        "active",
+        "resuming",
+        "suspended",
+        "suspending"
+    ]
+    return _RPM_STATUS_LOOKUP[dev['power']['runtime_status']]
+
+
+class LxGenPDSummary(gdb.Command):
+    '''Print genpd summary
+
+Output is similar to /sys/kernel/debug/pm_genpd/pm_genpd_summary'''
+
+    def __init__(self):
+        super(LxGenPDSummary, self).__init__('lx-genpd-summary', gdb.COMMAND_DATA)
+
+    def summary_one(self, genpd):
+        if genpd['status'] == 0:
+            status_string = 'on'
+        else:
+            status_string = 'off-{}'.format(genpd['state_idx'])
+
+        slave_names = []
+        for link in list_for_each_entry(
+                genpd['master_links'],
+                device_link_type.get_type().pointer(),
+                'master_node'):
+            slave_names.apend(link['slave']['name'])
+
+        gdb.write('%-30s  %-15s %s\n' % (
+                genpd['name'].string(),
+                status_string,
+                ', '.join(slave_names)))
+
+        # Print devices in domain
+        for pm_data in list_for_each_entry(genpd['dev_list'],
+                        pm_domain_data_type.get_type().pointer(),
+                        'list_node'):
+            dev = pm_data['dev']
+            kobj_path = kobject_get_path(dev['kobj'])
+            gdb.write('    %-50s  %s\n' % (kobj_path, rtpm_status_str(dev)))
+
+    def invoke(self, arg, from_tty):
+        gdb.write('domain                          status          slaves\n');
+        gdb.write('    /device                                             runtime status\n');
+        gdb.write('----------------------------------------------------------------------\n');
+        for genpd in list_for_each_entry(
+                gdb.parse_and_eval('&gpd_list'),
+                generic_pm_domain_type.get_type().pointer(),
+                'gpd_list_node'):
+            self.summary_one(genpd)
+
+
+LxGenPDSummary()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index eff5a48ac026..a504f511e752 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -33,5 +33,6 @@ else:
     import linux.rbtree
     import linux.proc
     import linux.constants
     import linux.timerlist
     import linux.clk
+    import linux.genpd
-- 
2.17.1

