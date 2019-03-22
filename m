Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F416BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DCC2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254575;
	bh=KU2DaMtQSA3Tr4VMa0/WnZyRZYgXiE1eSM8VMujiefg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZfwBI+PYvWBKO0CMfmAJAfgwdnE6ezc/nRp4BG1Mju36312hSuRk2MusM/A4SlwX8
	 dnV6E7G9zSso+9iDVHUIPZDNh9mwWl//wp+TeiiKn5fPu3lG3uyK6imGPb0NfXmrBl
	 BpEGj+Zgw7VO1uRt64x5DeDgrlO5A/Klpf6Z0r3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfCVLgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbfCVLgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:36:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9D5421934;
        Fri, 22 Mar 2019 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254571;
        bh=KU2DaMtQSA3Tr4VMa0/WnZyRZYgXiE1eSM8VMujiefg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbdc+X+pL925k5xnJBbVaZV8pxJwQimRkgzbN95ra+Hu2z7R55ram0fwWBDvWUauT
         rKCEl90/cm4Za1MPS8iMpcg/nPRaS/9OWzFUvUsVYuTwkvmA3mwTJpAKAxRKWaN80z
         vzIiiQWaVZYFxnUv6J5JbTF6pZwuS7bIj43rOSLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 4.4 152/230] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode
Date:   Fri, 22 Mar 2019 12:14:50 +0100
Message-Id: <20190322111247.337704339@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: S.j. Wang <shengjiu.wang@nxp.com>

commit cc29ea007347f39f4c5a4d27b0b555955a0277f9 upstream.

The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
wrong register, correct it.

Fixes 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Ackedy-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/fsl/fsl_esai.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -394,7 +394,8 @@ static int fsl_esai_set_dai_fmt(struct s
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		/* Data on rising edge of bclk, frame high, right aligned */
-		xccr |= ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCR_xWA;
+		xccr |= ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP;
+		xcr  |= ESAI_xCR_xWA;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* Data on rising edge of bclk, frame high, 1clk before data */
@@ -451,12 +452,12 @@ static int fsl_esai_set_dai_fmt(struct s
 		return -EINVAL;
 	}
 
-	mask = ESAI_xCR_xFSL | ESAI_xCR_xFSR;
+	mask = ESAI_xCR_xFSL | ESAI_xCR_xFSR | ESAI_xCR_xWA;
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, xcr);
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR, mask, xcr);
 
 	mask = ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCCR_xFSP |
-		ESAI_xCCR_xFSD | ESAI_xCCR_xCKD | ESAI_xCR_xWA;
+		ESAI_xCCR_xFSD | ESAI_xCCR_xCKD;
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR, mask, xccr);
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR, mask, xccr);
 


