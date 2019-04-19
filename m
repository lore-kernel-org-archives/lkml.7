Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BED6C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CBB21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfDSAHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:07:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:54535 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfDSAHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:07:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 17:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,367,1549958400"; 
   d="scan'208";a="150585596"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2019 17:07:45 -0700
Date:   Thu, 18 Apr 2019 17:07:45 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190419000745.GA12291@agluck-desk>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418232910.GR27160@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 01:29:10AM +0200, Borislav Petkov wrote:
> Which reminds me, Tony, I think all those debugging files "pfn"
> and "array" and the one you add now, should all be under a
> CONFIG_RAS_CEC_DEBUG which is default off and used only for development.
> Mind adding that too pls?

Patch below, on top of previous patch.  Note that I didn't move "enable"
into the RAS_CEC_DEBUG code. I think it has some value even on
production systems.  It is still in debugfs (which many production
systems don't mount) so I don't see that people are going to be randomly
using it to disable the CEC.

-Tony


From ac9d8c9bf7b38e18dcffdd41f8fcf0f07c632cd3 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Thu, 18 Apr 2019 16:46:55 -0700
Subject: [PATCH] RAS/CEC: Move CEC debug features under a CONFIG_RAS_CEC_DEBUG
 option

The pfn and array files in /sys/kernel/debug/ras/cec are intended
for debugging the CEC code itself. They are not needed on production
systems, so the default setting for this CONFIG option is "n".

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/ras/Kconfig | 10 ++++++++++
 drivers/ras/cec.c    | 13 ++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/ras/Kconfig b/arch/x86/ras/Kconfig
index a9c3db125222..7fde8d55e394 100644
--- a/arch/x86/ras/Kconfig
+++ b/arch/x86/ras/Kconfig
@@ -11,3 +11,13 @@ config RAS_CEC
 
 	  Bear in mind that this is absolutely useless if your platform doesn't
 	  have ECC DIMMs and doesn't have DRAM ECC checking enabled in the BIOS.
+
+config RAS_CEC_DEBUG
+	bool "Debugging"
+	default n
+	depends on RAS_CEC
+	---help---
+	  Add extra files to /sys/kernel/debug/ras/cec to test the correctable
+	  memory error feature. "pfn" is a writable file that allows user to
+	  simulate an error in a particular page frame. "array" is a read-only
+	  file that dumps out the current state of all pages logged so far.
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index a2ceedcd8516..ff880a5c289a 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -118,7 +118,9 @@ static struct ce_array {
 } ce_arr;
 
 static DEFINE_MUTEX(ce_mutex);
+#ifdef CONFIG_RAS_CEC_DEBUG
 static u64 dfs_pfn;
+#endif
 
 /* Amount of errors after which we offline */
 static unsigned int count_threshold = COUNT_MASK;
@@ -364,6 +366,7 @@ static int u64_get(void *data, u64 *val)
 	return 0;
 }
 
+#ifdef CONFIG_RAS_CEC_DEBUG
 static int pfn_set(void *data, u64 val)
 {
 	*(u64 *)data = val;
@@ -372,6 +375,7 @@ static int pfn_set(void *data, u64 val)
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(pfn_ops, u64_get, pfn_set, "0x%llx\n");
+#endif
 
 static int decay_interval_set(void *data, u64 val)
 {
@@ -411,6 +415,7 @@ static int enable_set(void *data, u64 val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(enable_ops, u64_get, enable_set, "%lld\n");
 
+#ifdef CONFIG_RAS_CEC_DEBUG
 static int array_dump(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
@@ -459,10 +464,14 @@ static const struct file_operations array_ops = {
 	.llseek	 = seq_lseek,
 	.release = single_release,
 };
+#endif
 
 static int __init create_debugfs_nodes(void)
 {
-	struct dentry *d, *pfn, *decay, *count, *array, *enable;
+	struct dentry *d, *decay, *count, *enable;
+#ifdef CONFIG_RAS_CEC_DEBUG
+	struct dentry *pfn, *array;
+#endif
 
 	d = debugfs_create_dir("cec", ras_debugfs_dir);
 	if (!d) {
@@ -470,6 +479,7 @@ static int __init create_debugfs_nodes(void)
 		return -1;
 	}
 
+#ifdef CONFIG_RAS_CEC_DEBUG
 	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
 	if (!pfn) {
 		pr_warn("Error creating pfn debugfs node!\n");
@@ -481,6 +491,7 @@ static int __init create_debugfs_nodes(void)
 		pr_warn("Error creating array debugfs node!\n");
 		goto err;
 	}
+#endif
 
 	decay = debugfs_create_file("decay_interval", S_IRUSR | S_IWUSR, d,
 				    &timer_interval, &decay_interval_ops);
-- 
2.19.1

