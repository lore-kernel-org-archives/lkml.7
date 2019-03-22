Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B15AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8D72075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255195;
	bh=X/+e4QUYdyJx2t5KISyYuIOA4kNFQUVGeiV2QOdjhus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xIDPn6umdpVDj7ZPGrQ6ZnY940/rPQLJO7lS/zIcgw5lW1bqXpXHl2pVe4e8rB/L5
	 28HvdUy2i/jH7kQMoSLJWuOYBGp6oR41c2W5snKoSi0AtoiIm8ogzBk2i0F9wWlZss
	 hzGt9AxQvrN0ROBmHo7XAdyFQceMInGVnD1F8mew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbfCVLqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbfCVLqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:46:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BFE62075E;
        Fri, 22 Mar 2019 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255190;
        bh=X/+e4QUYdyJx2t5KISyYuIOA4kNFQUVGeiV2QOdjhus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fh8Q/vFVBS+trHeQAhrL6lqBh6zzpGV8siNBKltBhPawJlyBPDLO3mDTEQxQ9xexS
         Mp4OiAHXshGQW+6N02umTS1zzHuxyKQFzbfD6fp9/EFxPGqfXl6wKc0y1L7qpO0tdx
         rIsxFD+elxDZcY0K8Cj7oXbKbWOddala4vZ3xFBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 4.14 003/183] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode
Date:   Fri, 22 Mar 2019 12:13:51 +0100
Message-Id: <20190322111242.058346720@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -395,7 +395,8 @@ static int fsl_esai_set_dai_fmt(struct s
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		/* Data on rising edge of bclk, frame high, right aligned */
-		xccr |= ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCR_xWA;
+		xccr |= ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP;
+		xcr  |= ESAI_xCR_xWA;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* Data on rising edge of bclk, frame high, 1clk before data */
@@ -452,12 +453,12 @@ static int fsl_esai_set_dai_fmt(struct s
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
 


