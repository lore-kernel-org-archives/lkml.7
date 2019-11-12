Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10025C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CAE20674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="runphloX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKLWSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:18:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33044 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfKLWSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:18:32 -0500
Received: from zn.tnic (p200300EC2F0F7D00610FFA679789BEE6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:7d00:610f:fa67:9789:bee6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B7631EC0CBD;
        Tue, 12 Nov 2019 23:18:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573597111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=UoA311kDDrv23Vi9ZXwtTdXBhjRUJ2zRhsoTMiTDdk8=;
        b=runphloXvNAayqWVhuAvVlmKoGHRR1DrYcEHyc8OPfWU5YdY5+s2pQ1+fRX08v3wkJvqWN
        haU/RGQml2EiFodJF+2cVkwHRDWLYvP6jCrlQlmgGmz+1XWWyIlaLNxFpbrtZr64PnIni6
        tD4H58Ku8Tw9DYVYw7Zvp7XQYGl2GN0=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] x86/bugs: Move enum taa_mitigations to bugs.c
Date:   Tue, 12 Nov 2019 23:18:22 +0100
Message-Id: <20191112221823.19677-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... because it is used only there.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
---
 arch/x86/include/asm/processor.h | 7 -------
 arch/x86/kernel/cpu/bugs.c       | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 54f5d54280f6..6e0a3b43d027 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -988,11 +988,4 @@ enum mds_mitigations {
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
index 4c7b0fa15a19..513a7f807412 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -273,6 +273,13 @@ early_param("mds", mds_cmdline);
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
-- 
2.21.0

