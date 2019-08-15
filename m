Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F3C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56772086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889342;
	bh=WSahoaraeoIHtYb3SiLBs5WOQxQYZvJgo0XK1tUHLnQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0EBIo04h33VGAiKaxDUmW3xNa2iFZf3wIBimEVZBHyABSjSzaIhs79Z6kS0lW0KkP
	 RPQVVadBO24qr+6lgoLccFSyNfNi0w8fDsVZKYPjuGnP4ykkZz+t5QUz0TaCJRe6bc
	 rAoZ3o2qHmyHlm8DFJbJRJ3QKpZXeXI18/teAAnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfHORO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:27 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:36207 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731408AbfHOROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:25 -0400
Received: by mail-wm1-f97.google.com with SMTP id g67so1865017wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=YrQsEFJ5XC+2bOl3bLXcIx2i2ZGtQ6HBlicu0o4QGgQ=;
        b=hVvr1xSyeDeYV/DjW/5I/gG/SS2ttSoEz4HZn83FI9phF5rI0tkX7Q+A8EPI+i/2Sp
         Bjw6wI4BfY+yKXouJBhfPM6uAAF943MgssMYKPlYdjXHc08bu8r4BGLo5fyhEd7nuXv5
         cMSZVJ6f0PJDdUtWDqaGSqq2Hll6F64YklSYioQkSoRg7t09OwA+qWTfjOiCapUHlGfz
         vo1DlCdj81msdxcG0BGisivhrrPxlLbQefFydvui4r920fyxVUG+48Zul3l3vHIpdhct
         f6AuBgEaHcmQDIXlFkDSCAo3zh7i9K3caROBVCtgfati/CkBAS0uXz2E2vjze110TiNO
         z/ag==
X-Gm-Message-State: APjAAAUjbea7dpzAeSNS49BSG35RMrMXX+fLdglByG+GJV03JAle5JZb
        qKEOU1/GmAtx/AtF8vA3+qZEXQpNDneYov/DoIyRLQOS20Q1OcC8QyTWZPanxwfV8g==
X-Google-Smtp-Source: APXvYqx1iRICMh93BpRXmF4AKcbCLW2jBBmcjI1MuOMZKItMXpIxLf8pu1aQLiSHmmf/yIjcZ4c3/NU4swrd
X-Received: by 2002:a1c:18d:: with SMTP id 135mr3701132wmb.171.1565889263498;
        Thu, 15 Aug 2019 10:14:23 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id n10sm55657wrs.49.2019.08.15.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:23 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKR-00051G-4X; Thu, 15 Aug 2019 17:14:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AB4402742B9E; Thu, 15 Aug 2019 18:14:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, brian.austin@cirrus.com,
        broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: cs42l56: remove unused variable 'adc_swap_enum'" to the asoc tree
In-Reply-To: <20190815092436.34632-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171422.AB4402742B9E@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:22 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l56: remove unused variable 'adc_swap_enum'

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

From e33d565795930d0341bb946aec457a814ccd53e6 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:24:36 +0800
Subject: [PATCH] ASoC: cs42l56: remove unused variable 'adc_swap_enum'

sound/soc/codecs/cs42l56.c:206:30: warning:
 adc_swap_enum defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815092436.34632-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l56.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index b4d7627525f9..ac569ab3d30f 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -199,14 +199,6 @@ static const struct soc_enum beep_bass_enum =
 	SOC_ENUM_SINGLE(CS42L56_BEEP_TONE_CFG, 1,
 			ARRAY_SIZE(beep_bass_text), beep_bass_text);
 
-static const char * const adc_swap_text[] = {
-	"None", "A+B/2", "A-B/2", "Swap"
-};
-
-static const struct soc_enum adc_swap_enum =
-	SOC_ENUM_SINGLE(CS42L56_MISC_ADC_CTL, 3,
-			ARRAY_SIZE(adc_swap_text), adc_swap_text);
-
 static const char * const pgaa_mux_text[] = {
 	"AIN1A", "AIN2A", "AIN3A"};
 
-- 
2.20.1

