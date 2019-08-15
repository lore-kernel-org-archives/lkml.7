Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C2C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35562086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889350;
	bh=YC9orWkxl6JBavR2cQH+4NgMPC4Js+BCeeh/pMbtc4M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kMwLpIXaP1b8PR0ZnMgYcnuQUCC5RTTBOJe6k1jO8gOrrpqG1FdjP7+FUOur/IIGj
	 fs0VhIV7hDBntFmTIRYf5UBXg59j64WpB12emgxdUtKW0DetsxRLTspZCFgp4Sh6tz
	 e5YD5/H8WBLu8WBLqaULoC1yZTfoLmzOpWtXf53Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbfHORPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:49 -0400
Received: from mail-wm1-f100.google.com ([209.85.128.100]:50342 "EHLO
        mail-wm1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbfHORO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:26 -0400
Received: by mail-wm1-f100.google.com with SMTP id v15so1882278wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=KkPpDRxBh4y4Ugsa/l+moUzY5JvfhTqXMrzYyAMXcys=;
        b=Z6hMxLQfQA2AQVSOdESL2oSXHhJbgFA6j1q+lUpITflnvgMPS6U0mQzHD2fx1jFp0R
         OgXlp0UmVydCxsYHsPNAdy+Z/BiWaoZrqmPt44RN/vKgaj8C25ZeRSDEt5wCi4QOUsrF
         Iz5wPQ8ju5DJoZA8NPd2DZvvahKfGM84hw4N/5eH+SpgixPymEfQRXIFHiVBWc48H7UI
         cvvwtUWUTKeNxYpEhiQLwudXTy2WIsOgyYVkea0pc2McdTk6No+bLv4QEK2llDO/HbBn
         EXJ6/2zXVklA8ueHF+2eMTQfHtStM5aUa5N+KqVJduRLPZbezKE/UcvFrhaHbRAB4A28
         xb0w==
X-Gm-Message-State: APjAAAWi85B+F9TDuCF2VZbxzmJb3YYxfdaW97U+Xlqc+EEMWNKvrZC4
        hIZqMVWS03s2f8UyXHw9GOAmuVLQ/9S5oUCWajMR/cJQ53RkYYewS3tq9FCGhZaOVQ==
X-Google-Smtp-Source: APXvYqxL31/i+9qxWSQ9K0DwiRE3HvKdRQbaqHhmRhxUp+ImMJz5EPYbVHkr6XpYVk+FdqMC5l2hb8BOQuqO
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr3617574wmm.119.1565889264018;
        Thu, 15 Aug 2019 10:14:24 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id x63sm13450wmb.9.2019.08.15.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:23 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKR-00051R-PY; Thu, 15 Aug 2019 17:14:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 318EC2742BD6; Thu, 15 Aug 2019 18:14:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        gustavo@embeddedor.com, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: es8328: remove unused variable 'pga_tlv'" to the asoc tree
In-Reply-To: <20190815092056.28724-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171423.318EC2742BD6@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:23 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es8328: remove unused variable 'pga_tlv'

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

From 97d39be9ce5befc2e36f15d0df33832e0f633565 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:20:56 +0800
Subject: [PATCH] ASoC: es8328: remove unused variable 'pga_tlv'

sound/soc/codecs/es8328.c:102:35: warning:
 pga_tlv defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815092056.28724-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 822a25a8f53c..4a3d303fedfb 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -99,7 +99,6 @@ static SOC_ENUM_SINGLE_DECL(adcpol,
 
 static const DECLARE_TLV_DB_SCALE(play_tlv, -3000, 100, 0);
 static const DECLARE_TLV_DB_SCALE(dac_adc_tlv, -9600, 50, 0);
-static const DECLARE_TLV_DB_SCALE(pga_tlv, 0, 300, 0);
 static const DECLARE_TLV_DB_SCALE(bypass_tlv, -1500, 300, 0);
 static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 300, 0);
 
-- 
2.20.1

