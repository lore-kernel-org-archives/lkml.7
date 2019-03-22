Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D39BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9B720657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253929;
	bh=Zlg2yA4wrKA+4rCgP3GtrJX7oQT7aSTY0+q+YwJOtdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yf3uGe7BgQEQsGod26pfEIOQ9/aaM132Ay1B8XwG6h9eMQyhpka27mLWyW60aPeWL
	 v3mVd2xGQLkOqkW51ecIMus2lU4chRKJ3swAmvhhhPjXnUBpy/Xq/8iNr9/5ENmcfO
	 OGKZ6y8oiYgOSiQa+pxUgsMLrzfqc/JPDkNtnkr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfCVLZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbfCVLZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:25:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF98218A2;
        Fri, 22 Mar 2019 11:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253924;
        bh=Zlg2yA4wrKA+4rCgP3GtrJX7oQT7aSTY0+q+YwJOtdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzPHKNy8RZXkEdIT2qijg9hIzNi7Ensd3CPH1nWoF80blAK5S1uOM3SXdqj75lexJ
         4ov0TiVTnWzwdX1SreE1wwILFGYt8adv7V6ijCG2gs67yt85wp9IwI7YQAV4kwNpJ8
         VJHQ9r4px2LgMcBXjVBNTfV+OK6+HiTyzeVshupY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 3.18 096/134] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode
Date:   Fri, 22 Mar 2019 12:15:09 +0100
Message-Id: <20190322111217.100204236@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 


