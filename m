Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E281C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6139B22DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566306864;
	bh=9E8uAleOGp5n2zm0vCcxaJ21dJnR0FKJgcRfmqJelA4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mdZ9xPcZhjhglvI+6yeAJubh3aIOusNh6AdXLuF5EtOBxcTUd8WGSDuT/4Wut+M1m
	 CAAAQbCWc0TYegFLUcIzQsvcUvrgu+eM3wfEa0fzNZq5+zodcVVg+X6CZDpF/fDU6u
	 gowBS7hV/Qck38pPhO2I2p6fYHhkla7BaDIcpPY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfHTNOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:14:23 -0400
Received: from mail-ed1-f98.google.com ([209.85.208.98]:44710 "EHLO
        mail-ed1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfHTNOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:14:23 -0400
Received: by mail-ed1-f98.google.com with SMTP id a21so6266210edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=BYoaNoNja4u98w2kXvMP/MUDpoHYTxfFi7Q/oIlgrlE=;
        b=pcRAC/TuVWtsxLtz6XCA8DxDww7RknTGbp5mjOOUwu9jRKDfaWrFXXU1SmsHIb2ch2
         PvE4F2f2euXzC6X4HOac2qNxln9FNPTh0Cemz9jbloRO57L/1cKLQWgE65zlBs2vFgI3
         FpUO/e+aR1RLJxwQUnmfaJgxXobO3bdvFglWljmqRb7ZRkfEMuItXRMECD3KXKZV+IPG
         3Ss9w2473bQyVsCM4CRlwZCrQs+FVz01WlX+DotemNSGUU9XmhDQY89IcFHUi4l4oYQm
         ggB9twkCtOHW4p6+HOat2g+OMG/vGc0jdVuygO7S03HgX+37C8+fdcFFHS7RoZZTevBl
         pCfA==
X-Gm-Message-State: APjAAAUCWdFZlk7wCsAkNZh8acEFycVhPZmTHVQEt8TcESI30AMXsLjD
        OlMRmb/vy/cdpcQEBkgN2KFhnGrCIFcMNjKFh5vI2nuus1ZeYDF6heHmw/eGaL9Omw==
X-Google-Smtp-Source: APXvYqyKcpevus3kXrnRv6TSHjIyqj7wzbZAyoOcm4ZjncAzX0Hy3PuyrSNpVfCDjh0XWWTjGorhykMqdITu
X-Received: by 2002:a17:906:244c:: with SMTP id a12mr25500765ejb.288.1566306861396;
        Tue, 20 Aug 2019 06:14:21 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id x21sm104334ejs.98.2019.08.20.06.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:21 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03xt-0002LU-00; Tue, 20 Aug 2019 13:14:21 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5E336274314C; Tue, 20 Aug 2019 14:14:20 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: g12a-tohdmitx: require regmap mmio" to the asoc tree
In-Reply-To: <20190820123510.22491-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131420.5E336274314C@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:20 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: g12a-tohdmitx: require regmap mmio

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

From 351b31002c1853af078ebfffd4b67bfc3d19e3dd Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 20 Aug 2019 14:35:10 +0200
Subject: [PATCH] ASoC: meson: g12a-tohdmitx: require regmap mmio

The tohdmitx glue uses regmap MMIO so it should require it.

Fixes: c8609f3870f7 ("ASoC: meson: add g12a tohdmitx control")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190820123510.22491-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 63b38c123103..2e3676147cea 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -87,6 +87,7 @@ config SND_MESON_AXG_PDM
 
 config SND_MESON_G12A_TOHDMITX
 	tristate "Amlogic G12A To HDMI TX Control Support"
+	select REGMAP_MMIO
 	imply SND_SOC_HDMI_CODEC
 	help
 	  Select Y or M to add support for HDMI audio on the g12a SoC
-- 
2.20.1

