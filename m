Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D9FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F0921855
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504478;
	bh=zsvoVk4M2FpIGjZuzM3G5RhHgf2UKu0ah1hHzXuybW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I8murmLaDFVXFB7ObE0cni5TVkDuuoWE9UuxnSJ9ChVoPwpkDkjB5PS69cUXsa8TZ
	 cb/dCcd47pd+oERB1qt+vUmLFxnsPrb2ptddV7K4G1HRDyQs/HEor/N7Ij1fprOIy4
	 gKAwHybGFTeYsX5HEfxgWXWvoeoQmPw+9dU5ZoJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfCMTOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbfCMTOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:14:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFEC2075C;
        Wed, 13 Mar 2019 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504475;
        bh=zsvoVk4M2FpIGjZuzM3G5RhHgf2UKu0ah1hHzXuybW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZrnS2wV1nkW6X1oo2nXjjTrpD4H/GYsS0PwEReSNdlZtp+oYWFwgMhCTZFk6+M7D
         QxqdrgS3C3liWy1w1JZDkEuPXloZaO6N7XacF+tLGuUZcnCf0SJRmIm15GPPTxPU4C
         L7J78oIWlx3S07uip7QchFY/IcwFul7fUg88/oWM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 36/48] ARCv2: don't assume core 0x54 has dual issue
Date:   Wed, 13 Mar 2019 15:12:38 -0400
Message-Id: <20190313191250.158955-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

[ Upstream commit 7b2e932f633bcb7b190fc7031ce6dac75f8c3472 ]

The first release of core4 (0x54) was dual issue only (HS4x).
Newer releases allow hardware to be configured as single issue (HS3x)
or dual issue.

Prevent accessing a HS4x only aux register in HS3x, which otherwise
leads to illegal instruction exceptions

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/arcregs.h |  8 ++++++++
 arch/arc/kernel/setup.c        | 26 +++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 49bfbd879caa..bdbdaef902eb 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -151,6 +151,14 @@ struct bcr_isa_arcv2 {
 #endif
 };
 
+struct bcr_uarch_build_arcv2 {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int pad:8, prod:8, maj:8, min:8;
+#else
+	unsigned int min:8, maj:8, prod:8, pad:8;
+#endif
+};
+
 struct bcr_mpy {
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	unsigned int pad:8, x1616:8, dsp:4, cycles:2, type:2, ver:8;
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 62a30e58441c..3320ca2fe20f 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -196,13 +196,29 @@ static void read_arc_build_cfg_regs(void)
 		cpu->bpu.num_pred = 2048 << bpu.pte;
 
 		if (cpu->core.family >= 0x54) {
-			unsigned int exec_ctrl;
 
-			READ_BCR(AUX_EXEC_CTRL, exec_ctrl);
-			cpu->extn.dual_enb = !(exec_ctrl & 1);
+			struct bcr_uarch_build_arcv2 uarch;
 
-			/* dual issue always present for this core */
-			cpu->extn.dual = 1;
+			/*
+			 * The first 0x54 core (uarch maj:min 0:1 or 0:2) was
+			 * dual issue only (HS4x). But next uarch rev (1:0)
+			 * allows it be configured for single issue (HS3x)
+			 * Ensure we fiddle with dual issue only on HS4x
+			 */
+			READ_BCR(ARC_REG_MICRO_ARCH_BCR, uarch);
+
+			if (uarch.prod == 4) {
+				unsigned int exec_ctrl;
+
+				/* dual issue hardware always present */
+				cpu->extn.dual = 1;
+
+				READ_BCR(AUX_EXEC_CTRL, exec_ctrl);
+
+				/* dual issue hardware enabled ? */
+				cpu->extn.dual_enb = !(exec_ctrl & 1);
+
+			}
 		}
 	}
 
-- 
2.19.1

