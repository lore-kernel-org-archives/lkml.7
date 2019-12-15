Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B85C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A1D2072B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfLOKSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 05:18:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51109 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfLOKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 05:18:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1igQyi-0005PA-F9; Sun, 15 Dec 2019 11:18:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E356A1C2836;
        Sun, 15 Dec 2019 11:18:19 +0100 (CET)
Date:   Sun, 15 Dec 2019 10:18:19 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/bugs: Move enum taa_mitigations to bugs.c
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112221823.19677-1-bp@alien8.de>
References: <20191112221823.19677-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <157640509981.30329.6388376575952582932.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     72c2ce9867d9e8535f8c29eb6d842d1caad281af
Gitweb:        https://git.kernel.org/tip/72c2ce9867d9e8535f8c29eb6d842d1caad281af
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 12 Nov 2019 21:58:57 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 14 Dec 2019 16:06:33 +01:00

x86/bugs: Move enum taa_mitigations to bugs.c

... because it is used only there.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20191112221823.19677-1-bp@alien8.de
---
 arch/x86/include/asm/processor.h | 7 -------
 arch/x86/kernel/cpu/bugs.c       | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0340aad..7c071f8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -1015,11 +1015,4 @@ enum mds_mitigations {
 	MDS_MITIGATION_VMWERV,
 };
 
-enum taa_mitigations {
-	TAA_MITIGATION_OFF,
-	TAA_MITIGATION_UCODE_NEEDED,
-	TAA_MITIGATION_VERW,
-	TAA_MITIGATION_TSX_DISABLED,
-};
-
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8bf6489..ed54b3b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -286,6 +286,13 @@ early_param("mds", mds_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"TAA: " fmt
 
+enum taa_mitigations {
+	TAA_MITIGATION_OFF,
+	TAA_MITIGATION_UCODE_NEEDED,
+	TAA_MITIGATION_VERW,
+	TAA_MITIGATION_TSX_DISABLED,
+};
+
 /* Default mitigation for TAA-affected CPUs */
 static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
 static bool taa_nosmt __ro_after_init;
