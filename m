Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C7CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A443208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="F6soTgTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfDWSUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:20:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58493 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWSUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:20:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3NIJoZv2224691
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Apr 2019 11:19:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3NIJoZv2224691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556043591;
        bh=/FdTcnc5D+eXxgi/Yny9wbVEWLvWhdH0vAH6M7OzgOo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=F6soTgTXv/a2lJ0Pi8J8toSs34ICyE4jMyx11YADxlxQEpqPUpOVPf/Xgn4QoSi//
         PtfpbqmuRuc+QMIKQe2qzLu4kdtcg1+6p6WY9Cbn/7i4Mmdb3EwD3DlINWgAkYM8YW
         VUGEQj13XFVApJXBmuwCrZdD7VRLKxkXNybPG58G5b9iOM2mddUN6IY5iXyjcYdk05
         2yBiLnoV3OHDytHS5c5T/fDmR1rYNcSpgtj1rH83Sz87bBsuPqa+CfPIeZYm1ylX/T
         Poc1Vws2aOuIOTAeDDzTADvsbG79W5pHShnLFvgpgeliRAPf52n5JXm7hV0+APbAUd
         +2dkAnaalMC9w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3NIJoYt2224688;
        Tue, 23 Apr 2019 11:19:50 -0700
Date:   Tue, 23 Apr 2019 11:19:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-71a84402b93e5fbd8f817f40059c137e10171788@git.kernel.org>
Cc:     rafal@milecki.pl, tglx@linutronix.de, yazen.ghannam@amd.com,
        x86@kernel.org, james.morse@arm.com, Shirish.S@amd.com,
        qiuxu.zhuo@intel.com, mchehab@kernel.org, vishal.l.verma@intel.com,
        linux-edac@vger.kernel.org, keescook@chromium.org,
        clemej@gmail.com, mingo@redhat.com, bp@suse.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        puwen@hygon.cn, tony.luck@intel.com
Reply-To: tglx@linutronix.de, rafal@milecki.pl, x86@kernel.org,
          yazen.ghannam@amd.com, vishal.l.verma@intel.com,
          mchehab@kernel.org, qiuxu.zhuo@intel.com, Shirish.S@amd.com,
          james.morse@arm.com, clemej@gmail.com, keescook@chromium.org,
          linux-edac@vger.kernel.org, mingo@redhat.com, mingo@kernel.org,
          hpa@zytor.com, bp@suse.de, puwen@hygon.cn, tony.luck@intel.com,
          arnd@arndb.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190325163410.171021-2-Yazen.Ghannam@amd.com>
References: <20190325163410.171021-2-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE/AMD: Don't report L1 BTB MCA errors on some
 family 17h models
Git-Commit-ID: 71a84402b93e5fbd8f817f40059c137e10171788
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  71a84402b93e5fbd8f817f40059c137e10171788
Gitweb:     https://git.kernel.org/tip/71a84402b93e5fbd8f817f40059c137e10171788
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Mon, 25 Mar 2019 16:34:22 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 23 Apr 2019 18:16:07 +0200

x86/MCE/AMD: Don't report L1 BTB MCA errors on some family 17h models

AMD family 17h Models 10h-2Fh may report a high number of L1 BTB MCA
errors under certain conditions. The errors are benign and can safely be
ignored. However, the high error rate may cause the MCA threshold
counter to overflow causing a high rate of thresholding interrupts.

In addition, users may see the errors reported through the AMD MCE
decoder module, even with the interrupt disabled, due to MCA polling.

Clear the "Counter Present" bit in the Instruction Fetch bank's
MCA_MISC0 register. This will prevent enabling MCA thresholding on this
bank which will prevent the high interrupt rate due to this error.

Define an AMD-specific function to filter these errors from the MCE
event pool so that they don't get reported during early boot.

Rename filter function in EDAC/mce_amd to avoid a naming conflict, while
at it.

 [ bp: Move function prototype to the internal header and
   massage/cleanup, fix typos. ]

Reported-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "clemej@gmail.com" <clemej@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Morse <james.morse@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Shirish S <Shirish.S@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Cc: <stable@vger.kernel.org> # 5.0.x: c95b323dcd35: x86/MCE/AMD: Turn off MC4_MISC thresholding on all family 0x15 models
Cc: <stable@vger.kernel.org> # 5.0.x: 30aa3d26edb0: x86/MCE/AMD: Carve out the MC4_MISC thresholding quirk
Cc: <stable@vger.kernel.org> # 5.0.x: 9308fd407455: x86/MCE: Group AMD function prototypes in <asm/mce.h>
Cc: <stable@vger.kernel.org> # 5.0.x
Link: https://lkml.kernel.org/r/20190325163410.171021-2-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c      | 52 ++++++++++++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/core.c     |  3 +++
 arch/x86/kernel/cpu/mce/internal.h |  6 +++++
 drivers/edac/mce_amd.c             |  4 +--
 4 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e64de5149e50..d904aafe6409 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -563,33 +563,59 @@ out:
 	return offset;
 }
 
+bool amd_filter_mce(struct mce *m)
+{
+	enum smca_bank_types bank_type = smca_get_bank_type(m->bank);
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	u8 xec = (m->status >> 16) & 0x3F;
+
+	/* See Family 17h Models 10h-2Fh Erratum #1114. */
+	if (c->x86 == 0x17 &&
+	    c->x86_model >= 0x10 && c->x86_model <= 0x2F &&
+	    bank_type == SMCA_IF && xec == 10)
+		return true;
+
+	return false;
+}
+
 /*
- * Turn off MC4_MISC thresholding banks on all family 0x15 models since
- * they're not supported there.
+ * Turn off thresholding banks for the following conditions:
+ * - MC4_MISC thresholding is not supported on Family 0x15.
+ * - Prevent possible spurious interrupts from the IF bank on Family 0x17
+ *   Models 0x10-0x2F due to Erratum #1114.
  */
-void disable_err_thresholding(struct cpuinfo_x86 *c)
+void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 {
-	int i;
+	int i, num_msrs;
 	u64 hwcr;
 	bool need_toggle;
-	u32 msrs[] = {
-		0x00000413, /* MC4_MISC0 */
-		0xc0000408, /* MC4_MISC1 */
-	};
+	u32 msrs[NR_BLOCKS];
+
+	if (c->x86 == 0x15 && bank == 4) {
+		msrs[0] = 0x00000413; /* MC4_MISC0 */
+		msrs[1] = 0xc0000408; /* MC4_MISC1 */
+		num_msrs = 2;
+	} else if (c->x86 == 0x17 &&
+		   (c->x86_model >= 0x10 && c->x86_model <= 0x2F)) {
 
-	if (c->x86 != 0x15)
+		if (smca_get_bank_type(bank) != SMCA_IF)
+			return;
+
+		msrs[0] = MSR_AMD64_SMCA_MCx_MISC(bank);
+		num_msrs = 1;
+	} else {
 		return;
+	}
 
 	rdmsrl(MSR_K7_HWCR, hwcr);
 
 	/* McStatusWrEn has to be set */
 	need_toggle = !(hwcr & BIT(18));
-
 	if (need_toggle)
 		wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
 
 	/* Clear CntP bit safely */
-	for (i = 0; i < ARRAY_SIZE(msrs); i++)
+	for (i = 0; i < num_msrs; i++)
 		msr_clear_bit(msrs[i], 62);
 
 	/* restore old settings */
@@ -604,12 +630,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	unsigned int bank, block, cpu = smp_processor_id();
 	int offset = -1;
 
-	disable_err_thresholding(c);
-
 	for (bank = 0; bank < mca_cfg.banks; ++bank) {
 		if (mce_flags.smca)
 			smca_configure(bank, cpu);
 
+		disable_err_thresholding(c, bank);
+
 		for (block = 0; block < NR_BLOCKS; ++block) {
 			address = get_block_address(address, low, high, bank, block);
 			if (!address)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 80b8c6bff8ed..5112a50e6486 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1777,6 +1777,9 @@ static void __mcheck_cpu_init_timer(void)
 
 bool filter_mce(struct mce *m)
 {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return amd_filter_mce(m);
+
 	return false;
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b822a645395d..a34b55baa7aa 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -176,4 +176,10 @@ extern struct mca_msr_regs msr_ops;
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
 
+#ifdef CONFIG_X86_MCE_AMD
+extern bool amd_filter_mce(struct mce *m);
+#else
+static inline bool amd_filter_mce(struct mce *m)			{ return false; };
+#endif
+
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 0a1814dad6cf..bb0202ad7a13 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1004,7 +1004,7 @@ static inline void amd_decode_err_code(u16 ec)
 /*
  * Filter out unwanted MCE signatures here.
  */
-static bool amd_filter_mce(struct mce *m)
+static bool ignore_mce(struct mce *m)
 {
 	/*
 	 * NB GART TLB error reporting is disabled by default.
@@ -1038,7 +1038,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
-	if (amd_filter_mce(m))
+	if (ignore_mce(m))
 		return NOTIFY_STOP;
 
 	pr_emerg(HW_ERR "%s\n", decode_error_status(m));
