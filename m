Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A20DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CD1218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfCUWNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:13:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:21560 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfCUWNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:13:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="309277290"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2019 15:13:39 -0700
Date:   Thu, 21 Mar 2019 15:13:39 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Message-ID: <20190321221339.GA32323@agluck-desk>
References: <CAK8P3a0aDdEt323i=z4BGuh71ntPqm-L33U4q+FiQOdMUin6wg@mail.gmail.com>
 <20190314110413.GA32277@zn.tnic>
 <20190314215952.GA303@agluck-desk>
 <20190315094341.GA12523@zn.tnic>
 <20190315155718.GA17775@agluck-desk>
 <20190315173720.GC12523@zn.tnic>
 <20190315174956.GA20831@agluck-desk>
 <20190315180206.GD12523@zn.tnic>
 <20190315181108.GA21111@agluck-desk>
 <CAK8P3a2CFyF5wExbZPb20E56sJ=3DpsP+0m2Px6D5Sw_L3pKXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2CFyF5wExbZPb20E56sJ=3DpsP+0m2Px6D5Sw_L3pKXA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Kbuild failed on the kernel configurations below:

  CONFIG_ACPI_NFIT=y
  CONFIG_EDAC_DEBUG=y
  CONFIG_EDAC_SKX=m
  CONFIG_EDAC_I10NM=y
         or
  CONFIG_ACPI_NFIT=y
  CONFIG_EDAC_DEBUG=y
  CONFIG_EDAC_SKX=y
  CONFIG_EDAC_I10NM=m

Failed log:
  ...
  CC [M]  drivers/edac/skx_common.o
  ...
  .../skx_common.o:.../skx_common.c:672: undefined reference to `__this_module'

That is because if one of the two drivers {skx|i10nm}_edac is built-in
and the other one is built as a module, the shared file skx_common.c is
built to an object in module style by kbuild. Therefore, when linking for
vmlinux, the '__this_module' symbol used in debugfs isn't defined.

Fix it by moving all debugfs code from skx_common.c to {skx|i10nm}_base.c
respectively. Thus, skx_common.c is a module independent file which doesn't
refer to '__this_module' symbol anymore.

Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server processors")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Arnd: I couldn't get your Kconfig trick (to disallow mixing module with
builtin) working.  Qiuxu made this better cleanup of the skx_common.c file that
moves out all of the debugfs bits, and adds a comment to the top of the
file warning future developers of the mixed mode issue.

 drivers/edac/i10nm_base.c | 52 +++++++++++++++++++++++++++++++++++++--
 drivers/edac/skx_base.c   | 50 ++++++++++++++++++++++++++++++++++++-
 drivers/edac/skx_common.c | 51 +++++---------------------------------
 drivers/edac/skx_common.h |  8 ------
 4 files changed, 105 insertions(+), 56 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index c334fb7c63df..6f06aec4877c 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -181,6 +181,54 @@ static struct notifier_block i10nm_mce_dec = {
 	.priority	= MCE_PRIO_EDAC,
 };
 
+#ifdef CONFIG_EDAC_DEBUG
+/*
+ * Debug feature.
+ * Exercise the address decode logic by writing an address to
+ * /sys/kernel/debug/edac/i10nm_test/addr.
+ */
+static struct dentry *i10nm_test;
+
+static int debugfs_u64_set(void *data, u64 val)
+{
+	struct mce m;
+
+	pr_warn_once("Fake error to 0x%llx injected via debugfs\n", val);
+
+	memset(&m, 0, sizeof(m));
+	/* ADDRV + MemRd + Unknown channel */
+	m.status = MCI_STATUS_ADDRV + 0x90;
+	/* One corrected error */
+	m.status |= BIT_ULL(MCI_STATUS_CEC_SHIFT);
+	m.addr = val;
+	skx_mce_check_error(NULL, 0, &m);
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
+
+static void setup_i10nm_debug(void)
+{
+	i10nm_test = edac_debugfs_create_dir("i10nm_test");
+	if (!i10nm_test)
+		return;
+
+	if (!edac_debugfs_create_file("addr", 0200, i10nm_test,
+				      NULL, &fops_u64_wo)) {
+		debugfs_remove(i10nm_test);
+		i10nm_test = NULL;
+	}
+}
+
+static void teardown_i10nm_debug(void)
+{
+	debugfs_remove_recursive(i10nm_test);
+}
+#else
+static inline void setup_i10nm_debug(void) {}
+static inline void teardown_i10nm_debug(void) {}
+#endif /*CONFIG_EDAC_DEBUG*/
+
 static int __init i10nm_init(void)
 {
 	u8 mc = 0, src_id = 0, node_id = 0;
@@ -249,7 +297,7 @@ static int __init i10nm_init(void)
 
 	opstate_init();
 	mce_register_decode_chain(&i10nm_mce_dec);
-	setup_skx_debug("i10nm_test");
+	setup_i10nm_debug();
 
 	i10nm_printk(KERN_INFO, "%s\n", I10NM_REVISION);
 
@@ -262,7 +310,7 @@ static int __init i10nm_init(void)
 static void __exit i10nm_exit(void)
 {
 	edac_dbg(2, "\n");
-	teardown_skx_debug();
+	teardown_i10nm_debug();
 	mce_unregister_decode_chain(&i10nm_mce_dec);
 	skx_adxl_put();
 	skx_remove();
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index adae4c848ca1..a5c8fa3a249a 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -540,6 +540,54 @@ static struct notifier_block skx_mce_dec = {
 	.priority	= MCE_PRIO_EDAC,
 };
 
+#ifdef CONFIG_EDAC_DEBUG
+/*
+ * Debug feature.
+ * Exercise the address decode logic by writing an address to
+ * /sys/kernel/debug/edac/skx_test/addr.
+ */
+static struct dentry *skx_test;
+
+static int debugfs_u64_set(void *data, u64 val)
+{
+	struct mce m;
+
+	pr_warn_once("Fake error to 0x%llx injected via debugfs\n", val);
+
+	memset(&m, 0, sizeof(m));
+	/* ADDRV + MemRd + Unknown channel */
+	m.status = MCI_STATUS_ADDRV + 0x90;
+	/* One corrected error */
+	m.status |= BIT_ULL(MCI_STATUS_CEC_SHIFT);
+	m.addr = val;
+	skx_mce_check_error(NULL, 0, &m);
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
+
+static void setup_skx_debug(void)
+{
+	skx_test = edac_debugfs_create_dir("skx_test");
+	if (!skx_test)
+		return;
+
+	if (!edac_debugfs_create_file("addr", 0200, skx_test,
+				      NULL, &fops_u64_wo)) {
+		debugfs_remove(skx_test);
+		skx_test = NULL;
+	}
+}
+
+static void teardown_skx_debug(void)
+{
+	debugfs_remove_recursive(skx_test);
+}
+#else
+static inline void setup_skx_debug(void) {}
+static inline void teardown_skx_debug(void) {}
+#endif /*CONFIG_EDAC_DEBUG*/
+
 /*
  * skx_init:
  *	make sure we are running on the correct cpu model
@@ -619,7 +667,7 @@ static int __init skx_init(void)
 	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
 	opstate_init();
 
-	setup_skx_debug("skx_test");
+	setup_skx_debug();
 
 	mce_register_decode_chain(&skx_mce_dec);
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 0e96e7b5b0a7..6b11d6f4ae07 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -3,6 +3,12 @@
  * Common codes for both the skx_edac driver and Intel 10nm server EDAC driver.
  * Originally split out from the skx_edac driver.
  *
+ * This file is used for both {skx|i10nm}_edac drivers. If one of them is
+ * built-in and the other one is built as a module, this file is built to
+ * an object in module style by kbuid. Therefore, to avoid linking errors
+ * from undefined module symbols, please don't add any functionality which
+ * would involve modules (e.g., debugfs code) to this file.
+ *
  * Copyright (c) 2018, Intel Corporation.
  */
 
@@ -644,48 +650,3 @@ void skx_remove(void)
 		kfree(d);
 	}
 }
-
-#ifdef CONFIG_EDAC_DEBUG
-/*
- * Debug feature.
- * Exercise the address decode logic by writing an address to
- * /sys/kernel/debug/edac/dirname/addr.
- */
-static struct dentry *skx_test;
-
-static int debugfs_u64_set(void *data, u64 val)
-{
-	struct mce m;
-
-	pr_warn_once("Fake error to 0x%llx injected via debugfs\n", val);
-
-	memset(&m, 0, sizeof(m));
-	/* ADDRV + MemRd + Unknown channel */
-	m.status = MCI_STATUS_ADDRV + 0x90;
-	/* One corrected error */
-	m.status |= BIT_ULL(MCI_STATUS_CEC_SHIFT);
-	m.addr = val;
-	skx_mce_check_error(NULL, 0, &m);
-
-	return 0;
-}
-DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
-
-void setup_skx_debug(const char *dirname)
-{
-	skx_test = edac_debugfs_create_dir(dirname);
-	if (!skx_test)
-		return;
-
-	if (!edac_debugfs_create_file("addr", 0200, skx_test,
-				      NULL, &fops_u64_wo)) {
-		debugfs_remove(skx_test);
-		skx_test = NULL;
-	}
-}
-
-void teardown_skx_debug(void)
-{
-	debugfs_remove_recursive(skx_test);
-}
-#endif /*CONFIG_EDAC_DEBUG*/
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index d25374e34d4f..d18fa98669af 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -141,12 +141,4 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 
 void skx_remove(void);
 
-#ifdef CONFIG_EDAC_DEBUG
-void setup_skx_debug(const char *dirname);
-void teardown_skx_debug(void);
-#else
-static inline void setup_skx_debug(const char *dirname) {}
-static inline void teardown_skx_debug(void) {}
-#endif /*CONFIG_EDAC_DEBUG*/
-
 #endif /* _SKX_COMM_EDAC_H */
-- 
2.19.1

