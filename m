Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BF9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A0A2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfDDD6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:58:07 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:52476 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfDDD6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:58:07 -0400
Received: from sugar.zhang?rock-chips.com (unknown [192.168.167.183])
        by regular1.263xmail.com (Postfix) with ESMTP id 6ACDC3DB;
        Thu,  4 Apr 2019 11:58:04 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17431T140464758023936S1554350281830449_;
        Thu, 04 Apr 2019 11:58:03 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ae620a0f13d9e1032142e2f15afa8a8d>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     heiko@sntech.de, broonie@kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 12/12] ASoC: rockchip: pdm: Correct PDM_CTRL0 reg value
Date:   Thu,  4 Apr 2019 11:57:57 +0800
Message-Id: <1554350277-24561-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the wrong reg value for rk322x/rk322xh,
cuz there is no STORE JUSTIFIED MODE on it.

on rk322x/rk322xh, the same bit means PDM_MODE/RESERVED,
if the bit is set to RESERVED, the controller will not work.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index e89beeb..6c0f242 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -210,7 +210,9 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(pdm->regmap, PDM_HPF_CTRL,
 			   PDM_HPF_LE | PDM_HPF_RE, PDM_HPF_LE | PDM_HPF_RE);
 	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, PDM_CLK_EN, PDM_CLK_EN);
-	regmap_update_bits(pdm->regmap, PDM_CTRL0, PDM_MODE_MSK, PDM_MODE_LJ);
+	if (pdm->version != RK_PDM_RK3229)
+		regmap_update_bits(pdm->regmap, PDM_CTRL0,
+				   PDM_MODE_MSK, PDM_MODE_LJ);
 
 	val = 0;
 	switch (params_format(params)) {
@@ -468,7 +470,8 @@ static const struct regmap_config rockchip_pdm_regmap_config = {
 };
 
 static const struct of_device_id rockchip_pdm_match[] = {
-	{ .compatible = "rockchip,pdm", },
+	{ .compatible = "rockchip,pdm",
+	  .data = (void *)RK_PDM_RK3229 },
 	{ .compatible = "rockchip,px30-pdm",
 	  .data = (void *)RK_PDM_RK3308 },
 	{ .compatible = "rockchip,rk1808-pdm",
-- 
2.7.4



