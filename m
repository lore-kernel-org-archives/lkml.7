Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B6FC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099D92087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfD0HLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:11:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35202 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfD0HKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 03:10:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DFA2A1A002F;
        Sat, 27 Apr 2019 09:10:35 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D20831A000B;
        Sat, 27 Apr 2019 09:10:35 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 51C2C205ED;
        Sat, 27 Apr 2019 09:10:35 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
        camelia.groza@nxp.com, leoyang.li@nxp.com
Cc:     davem@davemloft.net, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 1/9] soc/fsl/qman: fixup liodns only on ppc targets
Date:   Sat, 27 Apr 2019 10:10:23 +0300
Message-Id: <20190427071031.6563-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

ARM SoCs use SMMU so the liodn fixup done in the qman driver is no
longer making sense and it also breaks the ICID settings inherited
from u-boot. Do the fixups only for PPC targets.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 2 +-
 drivers/soc/fsl/qbman/qman_priv.h | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 109b38de3176..a6bb43007d03 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -596,7 +596,7 @@ static int qman_init_ccsr(struct device *dev)
 }
 
 #define LIO_CFG_LIODN_MASK 0x0fff0000
-void qman_liodn_fixup(u16 channel)
+void __qman_liodn_fixup(u16 channel)
 {
 	static int done;
 	static u32 liodn_offset;
diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
index 75a8f905f8f7..04515718cfd9 100644
--- a/drivers/soc/fsl/qbman/qman_priv.h
+++ b/drivers/soc/fsl/qbman/qman_priv.h
@@ -193,7 +193,14 @@ extern struct gen_pool *qm_cgralloc; /* CGR ID allocator */
 u32 qm_get_pools_sdqcr(void);
 
 int qman_wq_alloc(void);
-void qman_liodn_fixup(u16 channel);
+#ifdef CONFIG_FSL_PAMU
+#define qman_liodn_fixup __qman_liodn_fixup
+#else
+static inline void qman_liodn_fixup(u16 channel)
+{
+}
+#endif
+void __qman_liodn_fixup(u16 channel);
 void qman_set_sdest(u16 channel, unsigned int cpu_idx);
 
 struct qman_portal *qman_create_affine_portal(
-- 
2.17.1

