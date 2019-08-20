Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CD9C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C05A22DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322876;
	bh=M8ziiHawBDJIFvaq4ePVQ5w1UmOI8EhIiIbe8FGVjXg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bkqt7GXq8npAepbIFFsWRKudKZ9EnBQQm6hUGcHxKUNFU4sUG8Xwl6lMx4GwtdH/4
	 YnY2nV5KVFWsEHAuYmpHOcz3OLtH89AaWvVz0W75GhR+8nXQbBwsMxstBNbsP8sbOc
	 v5ZST6fvPDkCT2DxCWR0JkiRHKF3XnvG5SRiQsaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfHTRlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:15 -0400
Received: from mail-ed1-f98.google.com ([209.85.208.98]:40293 "EHLO
        mail-ed1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbfHTRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:10 -0400
Received: by mail-ed1-f98.google.com with SMTP id h8so7276439edv.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=/mqpDzcS3+X/d+CLoW8OHJyCRQemfYM/MA2QWwnt6tY=;
        b=HZTXDhTfhbhcadFEV6xcinYQz5nO6x/xVchVTy36Q1gGMf8tyHrSnZBB9TfprojJsf
         zba+f6R79cjbk7B8VijSj+24UGPsukrmcIfC+7bM8RKwFyQxFtF7YaPB1Pgb8yBrtWRL
         1Fho5/32z/MfHWz5uh5n11RmbJ9/5dgJYltdJ2uODEOASDaK3cGxBgPku4AfuaiiDg4d
         T3P0ebps1SW4Na8fNFfVZtqYWOo5sCIbwdPG2XJOK69I8US16+oan6/VR82tsCCGqAW3
         8zUEmHKH+0czOESWvBhsGs8FGk7Pc6bAAWaZBNaZQNxqujkThhpZr4rsRdpAXz2uP9g/
         CdGw==
X-Gm-Message-State: APjAAAW8QWzHW0ZHuyTiWPi2EGrJhRC+6LL/4SBcHoyYK5PtAWKs7UJV
        fazW2jTQTT18adpN5KdcT7WPZSOJp9/4oj8ScAaplLN3ofs3hAIdouneDiLJvZzvXQ==
X-Google-Smtp-Source: APXvYqw6Fl7XGGqQfeDN+eZtJ3gDBv05g3yacXEOBc4ciwS8/AVJWQS0dnujn26bMIrIPIF44RLP5sIRzaOO
X-Received: by 2002:a17:906:28ce:: with SMTP id p14mr27161262ejd.306.1566322868428;
        Tue, 20 Aug 2019 10:41:08 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id y41sm238580ede.25.2019.08.20.10.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:08 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0884-00033W-3j; Tue, 20 Aug 2019 17:41:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 718392742B4A; Tue, 20 Aug 2019 18:41:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Register regmap and PCM before our component" to the asoc tree
In-Reply-To: <67e303f37f141ef73ce9ed47d7f831b63c694424.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174107.718392742B4A@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Register regmap and PCM before our component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From bf283a05c09b58db83afbb1a8a3c6a684c56c1bb Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:08 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Register regmap and PCM before our component

So far the regmap and the dmaengine PCM are registered after our component
has been, which means that our driver isn't properly initialised by then.

Let's fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/67e303f37f141ef73ce9ed47d7f831b63c694424.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 7fa5c61169db..85c3b2c8cd77 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1148,11 +1148,9 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &sun4i_i2s_component,
-					      &sun4i_i2s_dai, 1);
+	ret = sun4i_i2s_init_regmap_fields(&pdev->dev, i2s);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not register DAI\n");
+		dev_err(&pdev->dev, "Could not initialise regmap fields\n");
 		goto err_suspend;
 	}
 
@@ -1162,9 +1160,11 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = sun4i_i2s_init_regmap_fields(&pdev->dev, i2s);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &sun4i_i2s_component,
+					      &sun4i_i2s_dai, 1);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not initialise regmap fields\n");
+		dev_err(&pdev->dev, "Could not register DAI\n");
 		goto err_suspend;
 	}
 
-- 
2.20.1

