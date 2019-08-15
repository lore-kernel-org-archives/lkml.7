Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27052C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58F7205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889311;
	bh=1kVNtADiy23Obq0tpxB6iCSDs13M7dQ6sxYkfYZvf7Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0qscV2ut8Wtw2CePDR6mVpncrM+TK4hxBwp9ValzTFUnA0fhf/ACo4qdDcpVa1HF8
	 n5dsnfy19A65gdpHInPrnopv1X87RcEkK8fE+mRZJFZ2aUQO+WowiOmPf01wiBDaAd
	 AZqOF2l3RM3URd6KrURLtb4e7hWP5f59lz1ExpmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfHORPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:10 -0400
Received: from mail-wr1-f98.google.com ([209.85.221.98]:42379 "EHLO
        mail-wr1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbfHOROa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:30 -0400
Received: by mail-wr1-f98.google.com with SMTP id b16so2848112wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=KWUuHNaeuLnP3/JiAYH55pf1los9RRnsI3012c89ha8=;
        b=g/BKtK45mkDcTLVm2WOxcGvfKAblk/00eUBC+k7uKo9wBdSfUn0469l3FrQ51+mvTn
         ij7QefDfbK4vAsMZq/ZCfOsSBaeX+le3EKpzVrKSZtBwJngznTMlLZlLpwMvQa+sSFjO
         Q2nBNpYhJ86YHeVEBXlmcA8pX+s0vTVF4Vu98ZOQFpXBfMfwCPd4PXB874yCvI8OHaov
         7fSRs2ftl66KiJ+OdLHpjARYjlANpy4/Mu/r4l/fyPdC3/WYL2M1eFKrDExxq7G/8UeM
         ex7EKYsxQsUflSpyEJIwgdNZzPhizL6nFSfGxK5UqO2JjZs26qtrDeHDh6lG1y179V0n
         lOYg==
X-Gm-Message-State: APjAAAWN8mFIppu39NWEAMWRjoC+/g2MkuB4g/8uJ2II4erTdzZe+b1j
        RorMpW55vnxDzDXXy7v0A+rSIv1XU+qJtlfaayp3ds1p4fBXUuUFYAf+4a35d89wQw==
X-Google-Smtp-Source: APXvYqwWDvl7fMqBHpJtlbdFiqytWl7O/XHWKPee2tCAd0zJbkiaCCfr3WgkbS1PijRiJdEJ1PqDf7oVgqUx
X-Received: by 2002:adf:aa8d:: with SMTP id h13mr6910152wrc.307.1565889267900;
        Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id e16sm10188wma.1.2019.08.15.10.14.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKV-00052P-Ij; Thu, 15 Aug 2019 17:14:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 19EF52742BD6; Thu, 15 Aug 2019 18:14:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, info@metux.net,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: es8328: Fix copy-paste error in es8328_right_line_controls" to the asoc tree
In-Reply-To: <20190815092300.68712-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171427.19EF52742BD6@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es8328: Fix copy-paste error in es8328_right_line_controls

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

From 630742c296341a8cfe00dfd941392025ba8dd4e8 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:23:00 +0800
Subject: [PATCH] ASoC: es8328: Fix copy-paste error in
 es8328_right_line_controls

It seems 'es8328_rline_enum' should be used
in es8328_right_line_controls

Fixes: 567e4f98922c ("ASoC: add es8328 codec driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815092300.68712-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 822a25a8f53c..69b81e704127 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -228,7 +228,7 @@ static const struct soc_enum es8328_rline_enum =
 			      ARRAY_SIZE(es8328_line_texts),
 			      es8328_line_texts);
 static const struct snd_kcontrol_new es8328_right_line_controls =
-	SOC_DAPM_ENUM("Route", es8328_lline_enum);
+	SOC_DAPM_ENUM("Route", es8328_rline_enum);
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
-- 
2.20.1

