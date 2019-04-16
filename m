Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FE6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136FF2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfDPGfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:35:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:15139 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfDPGfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:35:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 23:35:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,355,1549958400"; 
   d="scan'208";a="143098685"
Received: from aubrey-lkp.sh.intel.com ([10.239.97.113])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2019 23:34:58 -0700
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v15 1/3] /proc/pid/status: Add support for architecture specific output
Date:   Tue, 16 Apr 2019 14:32:48 +0800
Message-Id: <20190416063250.7514-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture specific information of the running processes could
be useful to the userland. Add support to examine process architecture
specific information externally.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linux API <linux-api@vger.kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/proc/array.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2edbb657f859..87bc7e882d35 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -96,6 +96,11 @@
 #include <asm/processor.h>
 #include "internal.h"
 
+/* Add support for architecture specific output in /proc/pid/status */
+#ifndef	arch_proc_pid_status
+#define	arch_proc_pid_status(m, task)
+#endif
+
 void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 {
 	char *buf;
@@ -424,6 +429,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cpus_allowed(m, task);
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
+	arch_proc_pid_status(m, task);
 	return 0;
 }
 
-- 
2.21.0

