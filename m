Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06C3C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27411208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ambwp4oD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfDWSUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:20:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWSUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:20:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3NIJ9Zq2224630
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Apr 2019 11:19:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3NIJ9Zq2224630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556043550;
        bh=BSsOEMwVxZx0AA71pToWRkMowGhYUoQwJsg7muj5cqc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ambwp4oDZ82jZEKihOVByVjera0e5qNW4mnWN4lUCUwlJnqEm1N6E/CE+GbsfDrOh
         dyHaVBtAJVP7UsOc76E/tDIAQzMpQCli+6Gq4+IP6hoz3liRR7TwrntkiJPf/UVcV2
         1btUU/WRq91oTbjFZTXfaBHhAqD+ChHJfEkn63XITpo2mI1eNY+clphFP+QIBJ6LZp
         A0h8fiRJn/HPDivU6/gskMh1rytOKbT6kcbs+02qVheZBtndqxTa6vUnJR833o0wbE
         +NOjo9pTtpcKyZAKMG65ShP58qADVH1fQA2CDj74idhnEzwOq0ELZLyP/crVmXNyON
         /cpXKeBxdYr6w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3NIJ7022224625;
        Tue, 23 Apr 2019 11:19:07 -0700
Date:   Tue, 23 Apr 2019 11:19:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-45d4b7b9cb88526f6d5bd4c03efab88d75d10e4f@git.kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        rafal@milecki.pl, tglx@linutronix.de, mingo@kernel.org,
        tony.luck@intel.com, hpa@zytor.com, Shirish.S@amd.com,
        arnd@arndb.de, vishal.l.verma@intel.com, puwen@hygon.cn,
        qiuxu.zhuo@intel.com, bp@suse.de, yazen.ghannam@amd.com,
        clemej@gmail.com
Reply-To: x86@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
          rafal@milecki.pl, mingo@kernel.org, tglx@linutronix.de,
          tony.luck@intel.com, hpa@zytor.com, Shirish.S@amd.com,
          vishal.l.verma@intel.com, puwen@hygon.cn, arnd@arndb.de,
          qiuxu.zhuo@intel.com, yazen.ghannam@amd.com, bp@suse.de,
          clemej@gmail.com
In-Reply-To: <20190325163410.171021-1-Yazen.Ghannam@amd.com>
References: <20190325163410.171021-1-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE: Add an MCE-record filtering function
Git-Commit-ID: 45d4b7b9cb88526f6d5bd4c03efab88d75d10e4f
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

Commit-ID:  45d4b7b9cb88526f6d5bd4c03efab88d75d10e4f
Gitweb:     https://git.kernel.org/tip/45d4b7b9cb88526f6d5bd4c03efab88d75d10e4f
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Mon, 25 Mar 2019 16:34:22 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 23 Apr 2019 18:04:47 +0200

x86/MCE: Add an MCE-record filtering function

Some systems may report spurious MCA errors. In general, spurious MCA
errors may be disabled by clearing a particular bit in MCA_CTL. However,
clearing a bit in MCA_CTL may not be recommended for some errors, so the
only option is to ignore them.

An MCA error is printed and handled after it has been added to the MCE
event pool. So an MCA error can be ignored by not adding it to that pool
in the first place.

Add such a filtering function.

 [ bp: Move function prototype to the internal header and massage. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "clemej@gmail.com" <clemej@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: "rafal@milecki.pl" <rafal@milecki.pl>
Cc: Shirish S <Shirish.S@amd.com>
Cc: <stable@vger.kernel.org> # 5.0.x
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190325163410.171021-1-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/core.c     | 5 +++++
 arch/x86/kernel/cpu/mce/genpool.c  | 3 +++
 arch/x86/kernel/cpu/mce/internal.h | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3e081428117c..80b8c6bff8ed 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1775,6 +1775,11 @@ static void __mcheck_cpu_init_timer(void)
 	mce_start_timer(t);
 }
 
+bool filter_mce(struct mce *m)
+{
+	return false;
+}
+
 /* Handle unconfigured int18 (should never happen) */
 static void unexpected_machine_check(struct pt_regs *regs, long error_code)
 {
diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index 3395549c51d3..64d1d5a00f39 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -99,6 +99,9 @@ int mce_gen_pool_add(struct mce *mce)
 {
 	struct mce_evt_llist *node;
 
+	if (filter_mce(mce))
+		return -EINVAL;
+
 	if (!mce_evt_pool)
 		return -EINVAL;
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index af5eab1e65e2..b822a645395d 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -173,4 +173,7 @@ struct mca_msr_regs {
 
 extern struct mca_msr_regs msr_ops;
 
+/* Decide whether to add MCE record to MCE event pool or filter it out. */
+extern bool filter_mce(struct mce *m);
+
 #endif /* __X86_MCE_INTERNAL_H__ */
