Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0514FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B4A20652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfCFR6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:58:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:38930 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfCFR6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:58:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 09:58:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,448,1544515200"; 
   d="scan'208";a="121536057"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga006.jf.intel.com with ESMTP; 06 Mar 2019 09:58:08 -0800
Date:   Wed, 6 Mar 2019 09:58:08 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Message-ID: <20190306175808.GA30016@agluck-desk>
References: <20190305132147.3739133-1-arnd@arndb.de>
 <20190305143453.GC8256@zn.tnic>
 <CAK8P3a2kSrTkTespcBGr6oYi8nvriS9pwtM2nQ7gCxVB+TzLog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2kSrTkTespcBGr6oYi8nvriS9pwtM2nQ7gCxVB+TzLog@mail.gmail.com>
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
always built to an object in module style by kbuild. Therefore, when
linking for vmlinux, the '__this_module' symbol isn't defined.

Fix it by moving the DEFINE_SIMPLE_ATTRIBUTE() from skx_common.c to
skx_base.c and i10nm_base.c, where the '__this_module' is always defined
whatever it's built-in or built as a module.

Test the patch with following configurations:

  CONFIG_ACPI_NFIT=y
  CONFIG_EDAC_DEBUG=[y|n]

  +------------------------------------+
  |  skx_edac  |  i10nm_edac  | Build  |
  |------------|--------------|--------|
  |     m      |      m       |   ok   |
  |------------|--------------|--------|
  |     m      |      y       |   ok   |
  |------------|--------------|--------|
  |     y      |      m       |   ok   |
  |------------|--------------|--------|
  |     y      |      y       |   ok   |
  +------------------------------------+

Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server processors")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

This seems cleaner than adding all the EXPORTs to skx_common.c
I also tried a build with the 0x8A152468-config.gz that Arnd
supplied.

 drivers/edac/i10nm_base.c | 4 +++-
 drivers/edac/skx_base.c   | 4 +++-
 drivers/edac/skx_common.c | 7 +++----
 drivers/edac/skx_common.h | 7 +++++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index c334fb7c63df..57ae2c6d5958 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -181,6 +181,8 @@ static struct notifier_block i10nm_mce_dec = {
 	.priority	= MCE_PRIO_EDAC,
 };
 
+DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
+
 static int __init i10nm_init(void)
 {
 	u8 mc = 0, src_id = 0, node_id = 0;
@@ -249,7 +251,7 @@ static int __init i10nm_init(void)
 
 	opstate_init();
 	mce_register_decode_chain(&i10nm_mce_dec);
-	setup_skx_debug("i10nm_test");
+	setup_skx_debug("i10nm_test", &fops_u64_wo);
 
 	i10nm_printk(KERN_INFO, "%s\n", I10NM_REVISION);
 
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index adae4c848ca1..1748f627ca6c 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -540,6 +540,8 @@ static struct notifier_block skx_mce_dec = {
 	.priority	= MCE_PRIO_EDAC,
 };
 
+DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
+
 /*
  * skx_init:
  *	make sure we are running on the correct cpu model
@@ -619,7 +621,7 @@ static int __init skx_init(void)
 	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
 	opstate_init();
 
-	setup_skx_debug("skx_test");
+	setup_skx_debug("skx_test", &fops_u64_wo);
 
 	mce_register_decode_chain(&skx_mce_dec);
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 0e96e7b5b0a7..f75af7ff5515 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -653,7 +653,7 @@ void skx_remove(void)
  */
 static struct dentry *skx_test;
 
-static int debugfs_u64_set(void *data, u64 val)
+int debugfs_u64_set(void *data, u64 val)
 {
 	struct mce m;
 
@@ -669,16 +669,15 @@ static int debugfs_u64_set(void *data, u64 val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
 
-void setup_skx_debug(const char *dirname)
+void setup_skx_debug(const char *dirname, const struct file_operations *fops)
 {
 	skx_test = edac_debugfs_create_dir(dirname);
 	if (!skx_test)
 		return;
 
 	if (!edac_debugfs_create_file("addr", 0200, skx_test,
-				      NULL, &fops_u64_wo)) {
+				      NULL, fops)) {
 		debugfs_remove(skx_test);
 		skx_test = NULL;
 	}
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index d25374e34d4f..637867e0952c 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -142,10 +142,13 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 void skx_remove(void);
 
 #ifdef CONFIG_EDAC_DEBUG
-void setup_skx_debug(const char *dirname);
+int debugfs_u64_set(void *data, u64 val);
+void setup_skx_debug(const char *dirname, const struct file_operations *fops);
 void teardown_skx_debug(void);
 #else
-static inline void setup_skx_debug(const char *dirname) {}
+static inline int debugfs_u64_set(void *data, u64 val) { return -ENOENT; }
+static inline void setup_skx_debug(const char *dirname,
+				   const struct file_operations *fops) {}
 static inline void teardown_skx_debug(void) {}
 #endif /*CONFIG_EDAC_DEBUG*/
 
-- 
2.19.1

