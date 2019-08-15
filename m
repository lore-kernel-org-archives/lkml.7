Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB22C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214402133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889272;
	bh=JIjr1fddUiYUMmvs1uzjtYWEJJp+L+PUxa7Rn3ClMFM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Jxuvk3W787ANRubyJ7AMBUJyhdHShg2aZW4HVejhMNG5xeOGPRQoQ0onY9+Q3CwxA
	 L7+tWuTTqKeC0J6ls/ORSdws+z0tuzJ2FdYGSIGW+Uxqj1Y+x7ZNSaYmVfNKHcy27n
	 Gh3Bw92W8iESFvM2VNXXtyiUV2NG4ewjxVEB6txs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfHOROb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:31 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:45477 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbfHORO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:27 -0400
Received: by mail-wr1-f97.google.com with SMTP id q12so2831179wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=hSu/SLnQ2ByBr5pdkyn5uB1emX/lLSkUY37nX1yG4go=;
        b=cmkdtUDkPME7EgkjAUtO0FQXQoyj4FQ+PZBa26pi6SVqwvLVmC5KGP59OqrvRmYtn/
         bDXlxzn7wYCQszlzdZtVcGGJSdMcv1X98r7ZxgDBFOO0X+/HMlgVRCbrnDbpTe4dEqpI
         NdjyyRzhbVLpbeXY1Akdgsexubvkc3tjmAOEiL+vtSfbhedgr1t/zpw24MWLuu+xwvpM
         1IQR1E+Eb+ptcs5NrYdukpwI/NUUKyenvo3i2YCJtSEROxnGKR+M1H/g+jF2in+hZPPS
         ac39mAQ1giYX47Bsf++bYDgQVbP0MUgxU142ke3iEuJabW/iej0L+2WYhFxYuDUrXf+Q
         csjA==
X-Gm-Message-State: APjAAAWNkmE2m6VGyAdIFxswycGqQ+hqixA3wqdBDVUvigEPCDE+S/8k
        48Y+QtIXbETHATsWIRZoWDc79WPmbp3j8pEV8T6BUqhAX8UcmgSipHW8oToxyAV3yw==
X-Google-Smtp-Source: APXvYqyzs4bzOJy9UjY85Ntaekkn/sUNlavyIQBsoxeAByy98K5scrReehdsP3FDc/HaeAnYfxxc7rZnA2nr
X-Received: by 2002:adf:f54a:: with SMTP id j10mr6641463wrp.220.1565889265735;
        Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id k3sm51635wrw.32.2019.08.15.10.14.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKT-00051n-D2; Thu, 15 Aug 2019 17:14:25 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C54642742BD6; Thu, 15 Aug 2019 18:14:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, brian.austin@cirrus.com,
        broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: cs42l73: remove unused variables 'vsp_output_mux' and 'xsp_output_mux'" to the asoc tree
In-Reply-To: <20190815085454.30384-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171424.C54642742BD6@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l73: remove unused variables 'vsp_output_mux' and 'xsp_output_mux'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From c25b456dc579298ac0ed7304f7d06a66288e96df Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 16:54:54 +0800
Subject: [PATCH] ASoC: cs42l73: remove unused variables 'vsp_output_mux' and
 'xsp_output_mux'

sound/soc/codecs/cs42l73.c:276:38: warning:
 vsp_output_mux defined but not used [-Wunused-const-variable=]
sound/soc/codecs/cs42l73.c:279:38: warning:
 xsp_output_mux defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815085454.30384-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l73.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index a81739367109..36089f8bcf0a 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -273,12 +273,6 @@ static SOC_ENUM_SINGLE_DECL(xsp_output_mux_enum,
 			    CS42L73_MIXERCTL, 4,
 			    cs42l73_spo_mixer_text);
 
-static const struct snd_kcontrol_new vsp_output_mux =
-	SOC_DAPM_ENUM("Route", vsp_output_mux_enum);
-
-static const struct snd_kcontrol_new xsp_output_mux =
-	SOC_DAPM_ENUM("Route", xsp_output_mux_enum);
-
 static const struct snd_kcontrol_new hp_amp_ctl =
 	SOC_DAPM_SINGLE("Switch", CS42L73_PWRCTL3, 0, 1, 1);
 
-- 
2.20.1

