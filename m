Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D982120700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfC0MRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:17:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51805 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbfC0MRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:17:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2RCGJEf2849234
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Mar 2019 05:16:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2RCGH9f2849230;
        Wed, 27 Mar 2019 05:16:17 -0700
Date:   Wed, 27 Mar 2019 05:16:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-006c077041dc73b9490fffc4c6af5befe0687110@git.kernel.org>
Cc:     mingo@redhat.com, yazen.ghannam@amd.com, vishal.l.verma@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@suse.de, puwen@hygon.cn, x86@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, hpa@zytor.com
Reply-To: tony.luck@intel.com, x86@kernel.org, linux-edac@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@redhat.com, bp@suse.de,
          yazen.ghannam@amd.com, vishal.l.verma@intel.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org, puwen@hygon.cn
In-Reply-To: <20180727214009.78289-1-Yazen.Ghannam@amd.com>
References: <20180727214009.78289-1-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Handle varying MCA bank counts
Git-Commit-ID: 006c077041dc73b9490fffc4c6af5befe0687110
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

Commit-ID:  006c077041dc73b9490fffc4c6af5befe0687110
Gitweb:     https://git.kernel.org/tip/006c077041dc73b9490fffc4c6af5befe0687110
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 27 Jul 2018 16:40:09 -0500
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 27 Mar 2019 13:12:49 +0100

x86/mce: Handle varying MCA bank counts

Linux reads MCG_CAP[Count] to find the number of MCA banks visible to a
CPU. Currently, this number is the same for all CPUs and a warning is
shown if there is a difference. The number of banks is overwritten with
the MCG_CAP[Count] value of each following CPU that boots.

According to the Intel SDM and AMD APM, the MCG_CAP[Count] value gives
the number of banks that are available to a "processor implementation".
The AMD BKDGs/PPRs further clarify that this value is per core. This
value has historically been the same for every core in the system, but
that is not an architectural requirement.

Future AMD systems may have different MCG_CAP[Count] values per core,
so the assumption that all CPUs will have the same MCG_CAP[Count] value
will no longer be valid.

Also, the first CPU to boot will allocate the struct mce_banks[] array
using the number of banks based on its MCG_CAP[Count] value. The machine
check handler and other functions use the global number of banks to
iterate and index into the mce_banks[] array. So it's possible to use an
out-of-bounds index on an asymmetric system where a following CPU sees a
MCG_CAP[Count] value greater than its predecessors.

Thus, allocate the mce_banks[] array to the maximum number of banks.
This will avoid the potential out-of-bounds index since the value of
mca_cfg.banks is capped to MAX_NR_BANKS.

Set the value of mca_cfg.banks equal to the max of the previous value
and the value for the current CPU. This way mca_cfg.banks will always
represent the max number of banks detected on any CPU in the system.

This will ensure that all CPUs will access all the banks that are
visible to them. A CPU that can access fewer than the max number of
banks will find the registers of the extra banks to be read-as-zero.

Furthermore, print the resulting number of MCA banks in use. Do this in
mcheck_late_init() so that the final value is printed after all CPUs
have been initialized.

Finally, get bank count from target CPU when doing injection with mce-inject
module.

 [ bp: Remove out-of-bounds example, passify and cleanup commit message. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20180727214009.78289-1-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/core.c   | 22 +++++++---------------
 arch/x86/kernel/cpu/mce/inject.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e558ca77cfe8..c3498732ba28 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1481,13 +1481,12 @@ EXPORT_SYMBOL_GPL(mce_notify_irq);
 static int __mcheck_cpu_mce_banks_init(void)
 {
 	int i;
-	u8 num_banks = mca_cfg.banks;
 
-	mce_banks = kcalloc(num_banks, sizeof(struct mce_bank), GFP_KERNEL);
+	mce_banks = kcalloc(MAX_NR_BANKS, sizeof(struct mce_bank), GFP_KERNEL);
 	if (!mce_banks)
 		return -ENOMEM;
 
-	for (i = 0; i < num_banks; i++) {
+	for (i = 0; i < MAX_NR_BANKS; i++) {
 		struct mce_bank *b = &mce_banks[i];
 
 		b->ctl = -1ULL;
@@ -1501,28 +1500,19 @@ static int __mcheck_cpu_mce_banks_init(void)
  */
 static int __mcheck_cpu_cap_init(void)
 {
-	unsigned b;
 	u64 cap;
+	u8 b;
 
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
 
 	b = cap & MCG_BANKCNT_MASK;
-	if (!mca_cfg.banks)
-		pr_info("CPU supports %d MCE banks\n", b);
-
-	if (b > MAX_NR_BANKS) {
-		pr_warn("Using only %u machine check banks out of %u\n",
-			MAX_NR_BANKS, b);
+	if (WARN_ON_ONCE(b > MAX_NR_BANKS))
 		b = MAX_NR_BANKS;
-	}
 
-	/* Don't support asymmetric configurations today */
-	WARN_ON(mca_cfg.banks != 0 && b != mca_cfg.banks);
-	mca_cfg.banks = b;
+	mca_cfg.banks = max(mca_cfg.banks, b);
 
 	if (!mce_banks) {
 		int err = __mcheck_cpu_mce_banks_init();
-
 		if (err)
 			return err;
 	}
@@ -2481,6 +2471,8 @@ EXPORT_SYMBOL_GPL(mcsafe_key);
 
 static int __init mcheck_late_init(void)
 {
+	pr_info("Using %d MCE banks\n", mca_cfg.banks);
+
 	if (mca_cfg.recovery)
 		static_branch_inc(&mcsafe_key);
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 8492ef7d9015..3f82afd0f46f 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -46,8 +46,6 @@
 static struct mce i_mce;
 static struct dentry *dfs_inj;
 
-static u8 n_banks;
-
 #define MAX_FLAG_OPT_SIZE	4
 #define NBCFG			0x44
 
@@ -570,9 +568,15 @@ err:
 static int inj_bank_set(void *data, u64 val)
 {
 	struct mce *m = (struct mce *)data;
+	u8 n_banks;
+	u64 cap;
+
+	/* Get bank count on target CPU so we can handle non-uniform values. */
+	rdmsrl_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap);
+	n_banks = cap & MCG_BANKCNT_MASK;
 
 	if (val >= n_banks) {
-		pr_err("Non-existent MCE bank: %llu\n", val);
+		pr_err("MCA bank %llu non-existent on CPU%d\n", val, m->extcpu);
 		return -EINVAL;
 	}
 
@@ -665,10 +669,6 @@ static struct dfs_node {
 static int __init debugfs_init(void)
 {
 	unsigned int i;
-	u64 cap;
-
-	rdmsrl(MSR_IA32_MCG_CAP, cap);
-	n_banks = cap & MCG_BANKCNT_MASK;
 
 	dfs_inj = debugfs_create_dir("mce-inject", NULL);
 	if (!dfs_inj)
