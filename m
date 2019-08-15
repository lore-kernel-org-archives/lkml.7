Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26581C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAC3218A4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889270;
	bh=uKoGEPY98dNdLMrAuaO6mohlY4GUTcjm/fBpY9pJylQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dnRYtGWetM6Pwvfszvv8hD+gNZaAvzWQcsyyLYpahP9wRMyjZDeLn4do1hudtjt+U
	 W4iTSe/oS0fDwd8Z5b0NMcVvJaGd+NH/eA+0K2RDis1AJHbPWVphIoeYKpI5Y9yuxr
	 LQR/owsQyz2u5iFmj+BxUf9InksuDn8zLwO7e+Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfHORO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:28 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:45476 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731322AbfHOROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:25 -0400
Received: by mail-wr1-f97.google.com with SMTP id q12so2831067wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=qovknBoKtVI0RTqSEtazh/DeoHQ6VEX0soV/hE572Po=;
        b=UnXnh7tdrfe0mgPquvCXBUmpq0xfKenZ1Np309p9ZKycPkZil0Fw9QnwYLTriTlvkI
         2vtrwvAD2uUxZ3gccZMBgRZiJHZsvAs+ut6utH6NCW2rugbTtyMjE2TIkTPWP6Pegh0p
         YNc5V4+5WihwF3lZWSuQ7ZGrNa7lLk7mZTZFhQRTNCJRJVBUkQvNLv1Ak2s0N2t2vp0D
         wu+rKpWTCvvA9ykRLltxkSQRW4cH7ypKvSldMM5fn0svQPwO1ruO3VWf24WbOS1QQm/4
         7juSocthqJmJVy5cnAOSzWUVaGRYpPvcAZduCqTit7D1MbDvWi2Gu/Ey0JslkojbeaaC
         /jjA==
X-Gm-Message-State: APjAAAUuyjoeGt3sMKbeeiRDv1lQF6ehM0ngq8GhV9Lpc1EeS9VP2RHx
        UF6zme6rt8msPh3JWPdru7dtD9ANw3HEfEGiAZNrpmcTYEAzU/2Z+n9y3ex5dkrJdw==
X-Google-Smtp-Source: APXvYqybw93ta4b+RPK07+rB4C4lUSDM+YPhjy1BY+u+bpMfB8ECRx2wugyWxHtLkI0dSr7g13tXxPdZyyXr
X-Received: by 2002:a5d:678a:: with SMTP id v10mr6334633wru.116.1565889263262;
        Thu, 15 Aug 2019 10:14:23 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id 35sm68304wri.7.2019.08.15.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:23 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKQ-00051D-UT; Thu, 15 Aug 2019 17:14:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 69F812742BD6; Thu, 15 Aug 2019 18:14:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, kstewart@linuxfoundation.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com
Subject: Applied "ASoC: 88pm860x: remove unused variables 'pcm_switch_controls' and 'aif1_mux'" to the asoc tree
In-Reply-To: <20190815092547.29564-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171422.69F812742BD6@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:22 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: 88pm860x: remove unused variables 'pcm_switch_controls' and 'aif1_mux'

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

From 12f0bfadf69bb154052722e7e4e5cd1639044c76 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:25:47 +0800
Subject: [PATCH] ASoC: 88pm860x: remove unused variables 'pcm_switch_controls'
 and 'aif1_mux'

sound/soc/codecs/88pm860x-codec.c:533:38: warning:
 pcm_switch_controls defined but not used [-Wunused-const-variable=]
sound/soc/codecs/88pm860x-codec.c:560:38: warning:
 aif1_mux defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815092547.29564-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/88pm860x-codec.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index e982722b448e..00b2c43d28a1 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -529,10 +529,6 @@ static const struct snd_kcontrol_new pm860x_snd_controls[] = {
  * DAPM Controls
  */
 
-/* PCM Switch / PCM Interface */
-static const struct snd_kcontrol_new pcm_switch_controls =
-	SOC_DAPM_SINGLE("Switch", PM860X_ADC_EN_2, 0, 1, 0);
-
 /* AUX1 Switch */
 static const struct snd_kcontrol_new aux1_switch_controls =
 	SOC_DAPM_SINGLE("Switch", PM860X_ANA_TO_ANA, 4, 1, 0);
@@ -549,17 +545,6 @@ static const struct snd_kcontrol_new lepa_switch_controls =
 static const struct snd_kcontrol_new repa_switch_controls =
 	SOC_DAPM_SINGLE("Switch", PM860X_DAC_EN_2, 1, 1, 0);
 
-/* PCM Mux / Mux7 */
-static const char *aif1_text[] = {
-	"PCM L", "PCM R",
-};
-
-static SOC_ENUM_SINGLE_DECL(aif1_enum,
-			    PM860X_PCM_IFACE_3, 6, aif1_text);
-
-static const struct snd_kcontrol_new aif1_mux =
-	SOC_DAPM_ENUM("PCM Mux", aif1_enum);
-
 /* I2S Mux / Mux9 */
 static const char *i2s_din_text[] = {
 	"DIN", "DIN1",
-- 
2.20.1

