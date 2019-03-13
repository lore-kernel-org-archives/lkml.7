Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7B2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11DF217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504343;
	bh=nq9Bko9S1CKLAk3t+egy2xB9qjrwqSKS65N9awoqub4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qXk7+bjSc0ntcozGG0fgzOUJ3/qXjl82zBnQrCab3f4zcNywOSM2UbNAotrBIZZms
	 r6O/fnDpJ74V04h2FpgEAnBn09hka4ZuUL9VncoruiZHaESYENzPQ1rCoz3RkcZtDZ
	 HqWoYnLahK6H73lVqDJJh8lqlmUezcMJFa/LxhN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfCMTMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfCMTMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2078620693;
        Wed, 13 Mar 2019 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504340;
        bh=nq9Bko9S1CKLAk3t+egy2xB9qjrwqSKS65N9awoqub4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0bya6NbGbmo2Gd9nIiK6AHoz01maSGlsXqEqph1s2i5r/N1KJcynBqBXmTFyucaa
         H71NNca/VeLiJy2xSGewT5TuCDNOObNOdMdJMYMAsjAgxUEQtJmmCdxlb14o3/diJ/
         2kYZREGZuCRbh7Aj1aQHNmx9hujdsxoIyqzK5YBw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 48/60] ARCv2: don't assume core 0x54 has dual issue
Date:   Wed, 13 Mar 2019 15:10:09 -0400
Message-Id: <20190313191021.158171-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
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
index 80dd1a716ca7..184a5d1bf28d 100644
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

