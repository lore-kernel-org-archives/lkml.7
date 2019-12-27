Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C304C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35460206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OlKS4xut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfL0SEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:04:11 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:38886 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727814AbfL0SEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:04:00 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9191842CEE;
        Fri, 27 Dec 2019 18:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1577469839; bh=utiNwzAlM6dfaS8d9tVWHPbqHgFQQV58Tm5uUozf5Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OlKS4xutPRXQS5dZjujy5Yy9mZrhlFCVPJ1RSJGzoM7pL0bUekWRcNUAm2aKLRfSV
         t8WCXEa5IXccZdcz0v2qmtcP9O35pWlhxYZKREyP1TxJohu2Rv0l6TPAigqSYxg1en
         DTXyag6f5P2VchWsdjhy4FneMLIDdLTf3BJWV0pWMco/qKrmMP3xCaxa/N/pKoKDh7
         BSjosoBBVtu1XXrSSatWge+wAonVEyPqOuEGp95sA7EPWhqS4Q3y9c7mGV09n46aiA
         CrdpQlIxNl6E9FApPQpye/HPgxUxbuAzb3hXUVnNhSAhLWUOwDC3VkPD3mH/7o0/vj
         7RFsVE2aaDLLw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.65])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0AF33A005F;
        Fri, 27 Dec 2019 18:03:57 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 5/5] ARC: allow userspace DSP applications to use AGU extensions
Date:   Fri, 27 Dec 2019 21:03:47 +0300
Message-Id: <20191227180347.3579-6-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to run DSP-enabled userspace applications with AGU
(address generation unit) extensions we additionally need to
save and restore following registers at context switch:
 * AGU_AP*
 * AGU_OS*
 * AGU_MOD*

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                |  7 +++++++
 arch/arc/include/asm/arcregs.h  | 12 ++++++++++++
 arch/arc/include/asm/dsp-impl.h | 23 +++++++++++++++++++++++
 arch/arc/include/asm/dsp.h      | 12 ++++++++++--
 arch/arc/kernel/setup.c         | 14 ++++++++++++++
 5 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index c3210754a3d2..c27bb7900ebd 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -439,6 +439,13 @@ config ARC_DSP_USERSPACE
 	help
 	  DSP extension presence in HW, support save / restore DSP registers to
 	  run DSP-enabled userspace applications
+
+config ARC_DSP_AGU_USERSPACE
+	bool "Support DSP with AGU for userspace apps"
+	select ARC_HAS_ACCL_REGS
+	help
+	  DSP and AGU extensions presence in HW, support save / restore DSP
+	  and AGU registers to run DSP-enabled userspace applications
 endchoice
 
 config ARC_IRQ_NO_AUTOSAVE
diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index a713819cab3c..9f6abed8a336 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -130,6 +130,18 @@
 #define ARC_AUX_DSP_CTRL	0x59F
 #define ARC_AUX_DSP_FFT_CTRL	0x59E
 
+#define ARC_AUX_AGU_BUILD	0xCC
+#define ARC_AUX_AGU_AP0		0x5C0
+#define ARC_AUX_AGU_AP1		0x5C1
+#define ARC_AUX_AGU_AP2		0x5C2
+#define ARC_AUX_AGU_AP3		0x5C3
+#define ARC_AUX_AGU_OS0		0x5D0
+#define ARC_AUX_AGU_OS1		0x5D1
+#define ARC_AUX_AGU_MOD0	0x5E0
+#define ARC_AUX_AGU_MOD1	0x5E1
+#define ARC_AUX_AGU_MOD2	0x5E2
+#define ARC_AUX_AGU_MOD3	0x5E3
+
 #ifndef __ASSEMBLY__
 
 #include <soc/arc/aux.h>
diff --git a/arch/arc/include/asm/dsp-impl.h b/arch/arc/include/asm/dsp-impl.h
index 7b640a680dfc..d352be2d9f07 100644
--- a/arch/arc/include/asm/dsp-impl.h
+++ b/arch/arc/include/asm/dsp-impl.h
@@ -100,6 +100,21 @@ static inline void arc_dsp_save_restore(struct task_struct *prev,
 
 	DSP_AUX_SAVE_RESTORE(saveto, readfrom, DSP_BFLY0, zero);
 	DSP_AUX_SAVE_RESTORE(saveto, readfrom, DSP_FFT_CTRL, zero);
+
+#ifdef CONFIG_ARC_DSP_AGU_USERSPACE
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_AP0, zero);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_AP1, zero);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_AP2, zero);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_AP3, zero);
+
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_OS0, zero);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_OS1, zero);
+
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_MOD0, zero);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_MOD1, zero);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_MOD2, zero);
+	DSP_AUX_SAVE_RESTORE(saveto, readfrom, AGU_MOD3, zero);
+#endif /* CONFIG_ARC_DSP_AGU_USERSPACE */
 }
 
 #else /* !ARC_DSP_SAVE_RESTORE_REGS */
@@ -114,5 +129,13 @@ static inline bool dsp_exist(void)
 	return !!bcr.ver;
 }
 
+static inline bool agu_exist(void)
+{
+	struct bcr_generic bcr;
+
+	READ_BCR(ARC_AUX_AGU_BUILD, bcr);
+	return !!bcr.ver;
+}
+
 #endif /* __ASEMBLY__ */
 #endif /* __ASM_ARC_DSP_IMPL_H */
diff --git a/arch/arc/include/asm/dsp.h b/arch/arc/include/asm/dsp.h
index 68507f04dea4..1619cf9c6d28 100644
--- a/arch/arc/include/asm/dsp.h
+++ b/arch/arc/include/asm/dsp.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_ARC_DSP_H
 #define __ASM_ARC_DSP_H
 
-#if defined(CONFIG_ARC_DSP_USERSPACE)
+#if defined(CONFIG_ARC_DSP_USERSPACE) || defined(CONFIG_ARC_DSP_AGU_USERSPACE)
 #define ARC_DSP_SAVE_RESTORE_REGS	1
 #endif
 
@@ -15,7 +15,8 @@
 
 /* some defines to simplify config sanitize in kernel/setup.c */
 #if defined(CONFIG_ARC_DSP_KERNEL) 	|| \
-    defined(CONFIG_ARC_DSP_USERSPACE)
+    defined(CONFIG_ARC_DSP_USERSPACE)	|| \
+    defined(CONFIG_ARC_DSP_AGU_USERSPACE)
 #define ARC_DSP_HANDLED			1
 #else
 #define ARC_DSP_HANDLED			0
@@ -23,6 +24,8 @@
 
 #if defined(CONFIG_ARC_DSP_USERSPACE)
 #define ARC_DSP_OPT_NAME		"CONFIG_ARC_DSP_USERSPACE"
+#elif defined(CONFIG_ARC_DSP_AGU_USERSPACE)
+#define ARC_DSP_OPT_NAME		"CONFIG_ARC_DSP_AGU_USERSPACE"
 #else
 #define ARC_DSP_OPT_NAME		"CONFIG_ARC_DSP_KERNEL"
 #endif
@@ -35,6 +38,11 @@
  */
 struct dsp_callee_regs {
 	unsigned long DSP_BFLY0, DSP_FFT_CTRL;
+#ifdef CONFIG_ARC_DSP_AGU_USERSPACE
+	unsigned long AGU_AP0, AGU_AP1, AGU_AP2, AGU_AP3;
+	unsigned long AGU_OS0, AGU_OS1;
+	unsigned long AGU_MOD0, AGU_MOD1, AGU_MOD2, AGU_MOD3;
+#endif
 };
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 30d31579c51d..17d58ec69113 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -398,11 +398,22 @@ static void chk_opt_strict(char *opt_name, bool hw_exists, bool opt_ena)
 		panic("Disable %s, hardware NOT present\n", opt_name);
 }
 
+static void chk_opt_weak(char *opt_name, bool hw_exists, bool opt_ena)
+{
+	if (!hw_exists && opt_ena)
+		panic("Disable %s, hardware NOT present\n", opt_name);
+}
+
 #define CHK_OPT_STRICT(opt_name, hw_exists)				\
 ({									\
 	chk_opt_strict(#opt_name, hw_exists, IS_ENABLED(opt_name));	\
 })
 
+#define CHK_OPT_WEAK(opt_name, hw_exists)				\
+({									\
+	chk_opt_weak(#opt_name, hw_exists, IS_ENABLED(opt_name));	\
+})
+
 static void arc_chk_core_config(void)
 {
 	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
@@ -448,6 +459,9 @@ static void arc_chk_core_config(void)
 
 		present = dsp_exist();
 		chk_opt_strict(ARC_DSP_OPT_NAME, present, ARC_DSP_HANDLED);
+
+		present = agu_exist();
+		CHK_OPT_WEAK(CONFIG_ARC_DSP_AGU_USERSPACE, present);
 	}
 }
 
-- 
2.21.0

