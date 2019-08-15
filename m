Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D89DC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20470217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889267;
	bh=yCqAVEZ0FIhkYGDwC+9y6ayI/bAS8UwnSSx9xs+/DMs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kHwEpouXPdWv9SMUsQ8GiuxwAAVuWM1oHcSO2XIkU/ljDLXO397GqvLxQnzY/Iq9F
	 vH4VW22E/jUnQtK3pgOabxjWrKbzon+b9EXJRHryjYx14uvRE632J1ccMPdlzfUH5F
	 t2l4gNK26qgrAU3ksZtlVdnZLTy2BjmSUvt4wHpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfHORO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:26 -0400
Received: from mail-wm1-f100.google.com ([209.85.128.100]:53895 "EHLO
        mail-wm1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbfHOROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:25 -0400
Received: by mail-wm1-f100.google.com with SMTP id 10so1879515wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=qLZh8IhwQg9ydE/0+1Zpu/OWvv9AdAPsrO/K7o4vHUY=;
        b=sejYDkW8Vg0AE2kHwZ+ZBsQWFw1B/bhTJ0iA8XyJnw/LdnNm+8KWQPdxLce103L5jU
         T7/2ZOecEsOFRyCeD0bI3czUPjyrPbNB2o1fKUPZdy0+p9fO2tcJSJGAU4d8kUEAt0zh
         gNZgt8h3rq8ixn4hU1d1RNQsPA1z1gaVoWfz8+UeSEXUcTMiOaathp5TbkGhuV4xSup1
         VhVmdwDXGVMk70leFIEEnr5BWIhc1axVC3IlMnwL9LOiTtXH4ivJdmJdggMrj/GJswPH
         +WGxk8pR6IfxeiOwJcsNV7igAUDoa438mJhTcF2T+rKMFPMTV3/CliHJL8HEOW7+gEKP
         58Fg==
X-Gm-Message-State: APjAAAUsqU6bRS4Zu5qxV8OZ/4ZbkAwSVmytpi8kQSP6ssyCqtYNXFK3
        0ZlZzbOcykFwcZlVng93iTKB2nZ34IGovgaAP6senK/GBJSVvFCN1lv6yQ+jNCHiuw==
X-Google-Smtp-Source: APXvYqwus8sMCeDcfNR/ErhO8PCbz1Pe+ABOtdCF2IXdy17QHyMub/fGageBGCgGJjKNz/akKGnSpIKz8V40
X-Received: by 2002:a1c:2dcf:: with SMTP id t198mr3503302wmt.147.1565889264289;
        Thu, 15 Aug 2019 10:14:24 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id i11sm56780wrr.50.2019.08.15.10.14.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:24 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKS-00051S-1K; Thu, 15 Aug 2019 17:14:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 74DB42742B9E; Thu, 15 Aug 2019 18:14:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     afd@ti.com, alsa-devel@alsa-project.org, broonie@kernel.org,
        colin.king@canonical.com, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: tlv320aic31xx: remove unused variable 'cm_m_enum'" to the asoc tree
In-Reply-To: <20190815091738.21680-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171423.74DB42742B9E@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:23 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320aic31xx: remove unused variable 'cm_m_enum'

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

From 6d6376b143d59ab1b8635807c78d224d03580418 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:17:38 +0800
Subject: [PATCH] ASoC: tlv320aic31xx: remove unused variable 'cm_m_enum'

sound/soc/codecs/tlv320aic31xx.c:261:29: warning:
 cm_m_enum defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815091738.21680-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 26a4f6cd3288..df627a08def9 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -258,7 +258,6 @@ static SOC_ENUM_SINGLE_DECL(mic1rp_p_enum, AIC31XX_MICPGAPI, 4,
 static SOC_ENUM_SINGLE_DECL(mic1lm_p_enum, AIC31XX_MICPGAPI, 2,
 	mic_select_text);
 
-static SOC_ENUM_SINGLE_DECL(cm_m_enum, AIC31XX_MICPGAMI, 6, mic_select_text);
 static SOC_ENUM_SINGLE_DECL(mic1lm_m_enum, AIC31XX_MICPGAMI, 4,
 	mic_select_text);
 
-- 
2.20.1

