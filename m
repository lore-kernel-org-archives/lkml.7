Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC5C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfCMF6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:58:06 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:47262 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfCMF6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:58:06 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h3wtv-0001ro-OG from Jiada_Wang@mentor.com ; Tue, 12 Mar 2019 22:58:03 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 12 Mar 2019 22:57:59 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <geert@linux-m68k.org>
CC:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH 5/5] ASoC: rsnd: dma: use extended audio dmac registers when available
Date:   Wed, 13 Mar 2019 14:58:11 +0900
Message-ID: <20190313055811.26135-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of SoCs have both basic and extended dmac registers set
basic set only supports busif0 ~ busif3, in order to use
busif4 ~ busif7, extended audio dmac registers need to be used.

This patch changes to use extended dmac registers set when it is
available in device-tree.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 0324a5c39619..905502ccedba 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -830,7 +830,10 @@ int rsnd_dma_probe(struct rsnd_priv *priv)
 	/*
 	 * for Gen2 or later
 	 */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "audmapp");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "extaudmapp");
+	if (!res)
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "audmapp");
 	dmac = devm_kzalloc(dev, sizeof(*dmac), GFP_KERNEL);
 	if (!dmac || !res) {
 		dev_err(dev, "dma allocate failed\n");
-- 
2.19.2

