Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA0CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EF9217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfIBN5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:57:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:34043 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731080AbfIBN5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:57:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:57:34 -0700
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="189563848"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:57:32 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id F408521150;
        Mon,  2 Sep 2019 16:57:25 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i4mpo-00067j-U5; Mon, 02 Sep 2019 16:57:32 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v5 11/11] lib/test_printf: Add tests for %pfw printk modifier
Date:   Mon,  2 Sep 2019 16:57:32 +0300
Message-Id: <20190902135732.23455-12-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for the %pfw printk modifier using software nodes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_printf.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 944eb50f38625..9c6d716979fb1 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -22,6 +22,8 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 
+#include <linux/property.h>
+
 #include "../tools/testing/selftests/kselftest_module.h"
 
 #define BUF_SIZE 256
@@ -588,6 +590,40 @@ flags(void)
 	kfree(cmp_buffer);
 }
 
+static void __init fwnode_pointer(void)
+{
+	const struct software_node softnodes[] = {
+		{ .name = "first", },
+		{ .name = "second", .parent = &softnodes[0], },
+		{ .name = "third", .parent = &softnodes[1], },
+		{ NULL /* Guardian */ },
+	};
+	const char * const full_name = "/second/third";
+	const char * const full_name_second = "/second";
+	const char * const second_name = "second";
+	const char * const third_name = "third";
+	int rval;
+
+	rval = software_node_register_nodes(softnodes);
+	if (rval) {
+		pr_warn("cannot register softnodes; rval %d\n", rval);
+		return;
+	}
+
+	test(full_name_second, "%pfw",
+	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
+	test(full_name, "%pfw",
+	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
+	test(full_name, "%pfwf",
+	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
+	test(second_name, "%pfwP",
+	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
+	test(third_name, "%pfwP",
+	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
+
+	software_node_unregister_nodes(softnodes);
+}
+
 static void __init
 test_pointer(void)
 {
@@ -610,6 +646,7 @@ test_pointer(void)
 	bitmap();
 	netdev_features();
 	flags();
+	fwnode_pointer();
 }
 
 static void __init selftest(void)
-- 
2.20.1

