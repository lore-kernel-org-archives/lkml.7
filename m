Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9902C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27B52084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDCNmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:42:10 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:53640 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfDCNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:42:07 -0400
Received: from sugar.zhang?rock-chips.com (unknown [192.168.167.12])
        by regular1.263xmail.com (Postfix) with ESMTP id DD3C872E;
        Wed,  3 Apr 2019 21:42:00 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P16332T140353604671232S1554298910639057_;
        Wed, 03 Apr 2019 21:41:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <85396c55356a271af3d3755537b4e0d8>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     heiko@sntech.de, broonie@kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/12] ASoC: rockchip: pdm: optimize clear logic
Date:   Wed,  3 Apr 2019 21:40:48 +0800
Message-Id: <1554298856-59028-5-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to reset controller every time, do this
once in pdm_probe.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 8c1be59..abbb6d7 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -183,9 +183,6 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 				   val);
 		regmap_update_bits(pdm->regmap, PDM_DMA_CTRL, PDM_DMA_RDL_MSK,
 				   PDM_DMA_RDL(16));
-		regmap_update_bits(pdm->regmap, PDM_SYSCONFIG,
-				   PDM_RX_MASK | PDM_RX_CLR_MASK,
-				   PDM_RX_STOP | PDM_RX_CLR_WR);
 	}
 
 	return 0;
@@ -355,6 +352,7 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case PDM_SYSCONFIG:
+	case PDM_FIFO_CTRL:
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
 		return true;
@@ -438,6 +436,7 @@ static int rockchip_pdm_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
+	rockchip_pdm_rxctrl(pdm, 0);
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register pcm: %d\n", ret);
-- 
2.7.4



