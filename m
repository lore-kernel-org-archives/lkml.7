Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FE1C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370C222BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zphj+cWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfGYO2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:28:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37553 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfGYO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:28:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PESJhp1040333
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:28:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PESJhp1040333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064899;
        bh=P/dG25HbVo5pH+ZUCoISKq6lnL+rzajresLSvbXO8AI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zphj+cWvc9f+H3o3PNWQ0Z+Ck+8m2cExhovYt5gtpm5NdPClv4+ePXZLl5EPI7iHV
         Zf8DxMvdIgoXUwVSejzp4+vWjAUtRp8OqRrc9pg86F7dqFWJGhbPBZrRs+DUeAQzpm
         RkgxGXbf/0sukzQXuTCROUwb3glrDdu7MrWWoU+FqLOxWvXBOW38I8nv9HtPhTP/sP
         MN2Wv52+7miX+DTVxtqRIf4Qrwi9lzOtViut75Lmc3aaUez2ruzfpWkd0AT0IiyaUG
         tceCWuuIG7de/Fsu1vKa+EfUfy81ke4IJXtpSQRmeKDmOv/LYwkvvVvGKh/UGGfbXT
         +qcln7xQ3WZ+w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PESHwl1040329;
        Thu, 25 Jul 2019 07:28:17 -0700
Date:   Thu, 25 Jul 2019 07:28:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-9c92374b631d233abf5bd355cb4253d3d83d5578@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190722105219.910317273@linutronix.de>
References: <20190722105219.910317273@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/cpu: Move arch_smt_update() to a neutral place
Git-Commit-ID: 9c92374b631d233abf5bd355cb4253d3d83d5578
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

Commit-ID:  9c92374b631d233abf5bd355cb4253d3d83d5578
Gitweb:     https://git.kernel.org/tip/9c92374b631d233abf5bd355cb4253d3d83d5578
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:17 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:59 +0200

x86/cpu: Move arch_smt_update() to a neutral place

arch_smt_update() will be used to control IPI/NMI broadcasting via the
shorthand mechanism. Keeping it in the bugs file and calling the apic
function from there is possible, but not really intuitive.

Move it to a neutral place and invoke the bugs function from there.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.910317273@linutronix.de

---
 arch/x86/include/asm/bugs.h  | 2 ++
 arch/x86/kernel/cpu/bugs.c   | 2 +-
 arch/x86/kernel/cpu/common.c | 9 +++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bugs.h b/arch/x86/include/asm/bugs.h
index 542509b53e0f..794eb2129bc6 100644
--- a/arch/x86/include/asm/bugs.h
+++ b/arch/x86/include/asm/bugs.h
@@ -18,4 +18,6 @@ int ppro_with_ram_bug(void);
 static inline int ppro_with_ram_bug(void) { return 0; }
 #endif
 
+extern void cpu_bugs_smt_update(void);
+
 #endif /* _ASM_X86_BUGS_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 66ca906aa790..6d9636c2ca51 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -700,7 +700,7 @@ static void update_mds_branch_idle(void)
 
 #define MDS_MSG_SMT "MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.\n"
 
-void arch_smt_update(void)
+void cpu_bugs_smt_update(void)
 {
 	/* Enhanced IBRS implies STIBP. No update required. */
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 11472178e17f..1ee6598c5d83 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1945,3 +1945,12 @@ void microcode_check(void)
 	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
 	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 }
+
+/*
+ * Invoked from core CPU hotplug code after hotplug operations
+ */
+void arch_smt_update(void)
+{
+	/* Handle the speculative execution misfeatures */
+	cpu_bugs_smt_update();
+}
