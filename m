Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D6BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BE72171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfDDD5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:57:17 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:33054 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfDDD5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:57:16 -0400
Received: from sugar.zhang?rock-chips.com (unknown [192.168.167.70])
        by regular1.263xmail.com (Postfix) with ESMTP id 4827A755;
        Thu,  4 Apr 2019 11:57:14 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5380T140554337773312S1554350230917190_;
        Thu, 04 Apr 2019 11:57:13 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <1692031030d50d4299684085f0c8431a>
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
Subject: [PATCH v1 11/12] ASoC: rockchip: pdm: Mark RXFIFO_DATA as volatile and precious
Date:   Thu,  4 Apr 2019 11:57:08 +0800
Message-Id: <1554350228-24440-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks RXFIFO_DATA as precious to avoid being read
outside a call from the driver, such as regmap debugfs

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 955cdc2..e89beeb 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -415,6 +415,7 @@ static bool rockchip_pdm_rd_reg(struct device *dev, unsigned int reg)
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
 	case PDM_DATA_VALID:
+	case PDM_RXFIFO_DATA:
 	case PDM_VERSION:
 		return true;
 	default:
@@ -429,6 +430,17 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
 	case PDM_FIFO_CTRL:
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
+	case PDM_RXFIFO_DATA:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rockchip_pdm_precious_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case PDM_RXFIFO_DATA:
 		return true;
 	default:
 		return false;
@@ -451,6 +463,7 @@ static const struct regmap_config rockchip_pdm_regmap_config = {
 	.writeable_reg = rockchip_pdm_wr_reg,
 	.readable_reg = rockchip_pdm_rd_reg,
 	.volatile_reg = rockchip_pdm_volatile_reg,
+	.precious_reg = rockchip_pdm_precious_reg,
 	.cache_type = REGCACHE_FLAT,
 };
 
-- 
2.7.4



