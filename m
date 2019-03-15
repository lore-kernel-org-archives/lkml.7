Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD79BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B289B218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCORt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:49:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:43088 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfCORt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:49:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 10:49:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="134393136"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2019 10:49:56 -0700
Date:   Fri, 15 Mar 2019 10:49:56 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Message-ID: <20190315174956.GA20831@agluck-desk>
References: <CAK8P3a2kSrTkTespcBGr6oYi8nvriS9pwtM2nQ7gCxVB+TzLog@mail.gmail.com>
 <20190306175808.GA30016@agluck-desk>
 <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
 <20190313230137.GA12529@agluck-desk>
 <CAK8P3a0aDdEt323i=z4BGuh71ntPqm-L33U4q+FiQOdMUin6wg@mail.gmail.com>
 <20190314110413.GA32277@zn.tnic>
 <20190314215952.GA303@agluck-desk>
 <20190315094341.GA12523@zn.tnic>
 <20190315155718.GA17775@agluck-desk>
 <20190315173720.GC12523@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315173720.GC12523@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 06:37:20PM +0100, Borislav Petkov wrote:
> I think the shared code should not have any reference to modules because
> it is supposed to be a library. Can you move the THIS_MODULE out of the
> common file and into the actual module?


Yes - Qiuxu did that already ... patch reposted below.

-Tony


From f9c656177e07fe5e978b09e5795a2a84a27bd54c Mon Sep 17 00:00:00 2001
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Date: Wed, 6 Mar 2019 09:59:14 +0800
Subject: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error

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

