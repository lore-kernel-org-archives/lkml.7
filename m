Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E8C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB252089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889276;
	bh=16JlRblzjUCGrFp3I3r/WmQOcfcspEShu4ihuTj7ZoE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=NC5OyX5tvSRe/ULTorPV4sHDAHbv/4gD89lcmGV71OgXBDjLmoRlCdEsHNdwuHvw/
	 ar5iujjGGZde7mzoOOjx7fiFAWDt7Oqd44RQe3NWAa+UHZP2IYzXUKLI60wsENi3eG
	 jumHCfZJYEb5R4T1oJhDibW4N6F5yZ1qNnd0esns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfHOROf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:35 -0400
Received: from mail-wr1-f100.google.com ([209.85.221.100]:35398 "EHLO
        mail-wr1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbfHORO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:29 -0400
Received: by mail-wr1-f100.google.com with SMTP id k2so2876743wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=dXH5iCrajVuHNaQjRFbCRi3wnS4PzGsd3NOsiMm0Dhs=;
        b=fJPOou7DPmoSekaNTKWz2svNRKwJDryECvk8Tum6HIjW091FFyDZH6XoyBe7H93nJ2
         mr9dblmAIXAS5YqEhvPcNMbcqThKg4xQhk3e1aLLwiO27atlnR79+Mx5oWzDSLqn3Bn9
         oiaq5kSaqER0Np8AngY+hdGXMlWKYr38ilaHfPVMs0/smbliyPYzLPqQSUmhDIRxMsjN
         cV/8KjEa4PVInGDncKzA9VOuWNVi9rCQlSiMfppIvhml7EefbEAy0rPhRKDcQRkX5Y8W
         M0nzxpzxl8J1Gz1qICpBMFhUzVUCcrx5fe8ppIq6X+/gk5RIA8vJER9VS7IIcdRzCr4f
         2kAQ==
X-Gm-Message-State: APjAAAWLeyvcOEoti6WM+oGBx5GM0N86pAIZlRLtKJULpN1CEILnqCIL
        AaIemGE9IaW/cqInIi63G0yfri0bD4I8CiAYlUTMDspnvuj23ZimNhUtghwumYtwaQ==
X-Google-Smtp-Source: APXvYqzdUat/m0ESOjrmVH6XsjvmuVYd5FZiZgx9NSQRpwZI4Y9N9JZMF8QNa37wGKT1mshgc86AuIZ3pySu
X-Received: by 2002:a5d:4310:: with SMTP id h16mr6602997wrq.212.1565889267391;
        Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id c128sm12461wma.50.2019.08.15.10.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKV-00052G-3O; Thu, 15 Aug 2019 17:14:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 93A0C2742B9E; Thu, 15 Aug 2019 18:14:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Hulk Robot <hulkci@huawei.com>, info@metux.net,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        perex@perex.cz, tglx@linutronix.de, tiwai@suse.com
Subject: Applied "ASoC: wm8737: Fix copy-paste error in wm8737_snd_controls" to the asoc tree
In-Reply-To: <20190815091920.64480-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171426.93A0C2742B9E@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm8737: Fix copy-paste error in wm8737_snd_controls

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

From 554b75bde64bcad9662530726d1483f7ef012069 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:19:20 +0800
Subject: [PATCH] ASoC: wm8737: Fix copy-paste error in wm8737_snd_controls

sound/soc/codecs/wm8737.c:112:29: warning:
 high_3d defined but not used [-Wunused-const-variable=]

'high_3d' should be used for 3D High Cut-off.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2a9ae13a2641 ("ASoC: Add initial WM8737 driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20190815091920.64480-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8737.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 0c246fb5e5ac..7a3f9fbe8d53 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -167,7 +167,7 @@ SOC_DOUBLE("Polarity Invert Switch", WM8737_ADC_CONTROL, 5, 6, 1, 0),
 SOC_SINGLE("3D Switch", WM8737_3D_ENHANCE, 0, 1, 0),
 SOC_SINGLE("3D Depth", WM8737_3D_ENHANCE, 1, 15, 0),
 SOC_ENUM("3D Low Cut-off", low_3d),
-SOC_ENUM("3D High Cut-off", low_3d),
+SOC_ENUM("3D High Cut-off", high_3d),
 SOC_SINGLE_TLV("3D ADC Volume", WM8737_3D_ENHANCE, 7, 1, 1, adc_tlv),
 
 SOC_SINGLE("Noise Gate Switch", WM8737_NOISE_GATE, 0, 1, 0),
-- 
2.20.1

