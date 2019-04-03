Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41DDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D63A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDCNmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:42:18 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:57256 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfDCNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:42:08 -0400
Received: from sugar.zhang?rock-chips.com (unknown [192.168.167.12])
        by regular1.263xmail.com (Postfix) with ESMTP id 732897E0;
        Wed,  3 Apr 2019 21:41:54 +0800 (CST)
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
        Wed, 03 Apr 2019 21:41:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a84fdd7a72d4c7f95f2d02ddc5c09822>
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
Subject: [PATCH v1 02/12] ASoC: rockchip: pdm: using left justified store mode
Date:   Wed,  3 Apr 2019 21:40:46 +0800
Message-Id: <1554298856-59028-3-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set left justified store mode default.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 1 +
 sound/soc/rockchip/rockchip_pdm.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 8a2e3bb..360ebf2 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -135,6 +135,7 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(pdm->regmap, PDM_HPF_CTRL,
 			   PDM_HPF_LE | PDM_HPF_RE, PDM_HPF_LE | PDM_HPF_RE);
 	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, PDM_CLK_EN, PDM_CLK_EN);
+	regmap_update_bits(pdm->regmap, PDM_CTRL0, PDM_MODE_MSK, PDM_MODE_LJ);
 
 	val = 0;
 	switch (params_format(params)) {
diff --git a/sound/soc/rockchip/rockchip_pdm.h b/sound/soc/rockchip/rockchip_pdm.h
index 886b48d1..00a8fa1 100644
--- a/sound/soc/rockchip/rockchip_pdm.h
+++ b/sound/soc/rockchip/rockchip_pdm.h
@@ -42,6 +42,9 @@
 
 /* PDM CTRL0 */
 #define PDM_PATH_MSK		(0xf << 27)
+#define PDM_MODE_MSK		BIT(31)
+#define PDM_MODE_RJ		0
+#define PDM_MODE_LJ		BIT(31)
 #define PDM_PATH3_EN		BIT(30)
 #define PDM_PATH2_EN		BIT(29)
 #define PDM_PATH1_EN		BIT(28)
-- 
2.7.4



