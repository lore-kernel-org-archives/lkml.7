Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422DDC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FFB20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122304;
	bh=hYUfsW0L/9lk8I7RgCsHnsruaZp2MEdg3A4yuinmzlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AOmAWQBHBQaaMr/jfc3vEkpQ5mRYxOIMKrZO7zJMcX1clk2iur220vhDFu4u61N1V
	 IgSKWE8g909DnVd1FLcWM4PKcV+SY7CTqrB95ViHjmhpGLOB+g4YFQVvnHOh99NmDI
	 kipZ4Jy91f4SX32TdO1be/PDyobYTur9g9MPy+/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393349AbfJCRFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732751AbfJCQkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:40:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CCC2133F;
        Thu,  3 Oct 2019 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120810;
        bh=hYUfsW0L/9lk8I7RgCsHnsruaZp2MEdg3A4yuinmzlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tY6zZHMwuLemGi1nkpVUan24LjFcrtUa4jZYj5WwAqiVK9KBvm5hqoweDr5ZWn8RA
         DbXDepVzM9rvMWrRrbcr64m0cGNLLIc5fjeN48JZDxHC7NiwSSrpY9pKTooL0txuUI
         FcedF796m8USynwIOkYQHsi4yeOCaq19DkaLcBN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 046/344] ASoC: sgtl5000: Fix of unmute outputs on probe
Date:   Thu,  3 Oct 2019 17:50:11 +0200
Message-Id: <20191003154544.672573891@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

[ Upstream commit 631bc8f0134ae9620d86a96b8c5f9445d91a2dca ]

To enable "zero cross detect" for ADC/HP, change
HP_ZCD_EN/ADC_ZCD_EN bits only instead of writing the whole
CHIP_ANA_CTRL register.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Link: https://lore.kernel.org/r/20190719100524.23300-6-oleksandr.suvorov@toradex.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index a6a4748c97f9d..aad9eca41587e 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1288,6 +1288,7 @@ static int sgtl5000_probe(struct snd_soc_component *component)
 	int ret;
 	u16 reg;
 	struct sgtl5000_priv *sgtl5000 = snd_soc_component_get_drvdata(component);
+	unsigned int zcd_mask = SGTL5000_HP_ZCD_EN | SGTL5000_ADC_ZCD_EN;
 
 	/* power up sgtl5000 */
 	ret = sgtl5000_set_power_regs(component);
@@ -1315,9 +1316,8 @@ static int sgtl5000_probe(struct snd_soc_component *component)
 	       0x1f);
 	snd_soc_component_write(component, SGTL5000_CHIP_PAD_STRENGTH, reg);
 
-	snd_soc_component_write(component, SGTL5000_CHIP_ANA_CTRL,
-			SGTL5000_HP_ZCD_EN |
-			SGTL5000_ADC_ZCD_EN);
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_CTRL,
+		zcd_mask, zcd_mask);
 
 	snd_soc_component_update_bits(component, SGTL5000_CHIP_MIC_CTRL,
 			SGTL5000_BIAS_R_MASK,
-- 
2.20.1



