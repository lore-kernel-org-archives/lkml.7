Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F58C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1902084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889338;
	bh=ctUbV7JxrNVk9HoV3nEQo6wBmJ5JwkPT5GPsRedYEKw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=z2QY8RCBXPNu6bQV1F+ZFn/4JGy5isj6DZWuPtyAX4ugtxwN6prTgChR2Ec33YV8i
	 K5Dh3jI9/DarsCwhgnmDd6fl/jaFAp+jd0DIzCxmi9lUPxvBYt0bNkDj8/g3WEMFr/
	 smDsyoKzYwRVrl3d5D8I0bewmuwsuX6pOT+4nY7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbfHORPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:37 -0400
Received: from mail-wr1-f99.google.com ([209.85.221.99]:39935 "EHLO
        mail-wr1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731520AbfHORO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:27 -0400
Received: by mail-wr1-f99.google.com with SMTP id t16so2862097wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=hvo1EnWObIjc8cgzVjI5oyqc1tcm26PERJDdCuksuoA=;
        b=aNYhm6q6mbY28BjQlaRvsa+N4JZK4dCcOWLYJ4PjgkRKzBeMo198yBuZpC8hv0ENNW
         khirHKmAilByQK+uvj6XZ5ny8RHbkpCX5rxnTrZy6fld7nnxzvYLA/iFUSO3mJbuZOOP
         E2F8ACY/cGTeGy5gU2l7jZOH707UhTIcaQm/gZOTjeHeMA/GoAT+f+fJox+sZpLvJxzd
         U8WeAjLarVqRvixPEeri4enHbQkZoaZP0EHoA+zWQNP/nv//mmWJyHuBXWLFzHvTALSr
         OQFRn/tDS1cCwVi8Mjr9U+diqR0toWd/rLHJaUMUg+A2SjX1DklnR9ccDV4Yc94+LRwf
         5Awg==
X-Gm-Message-State: APjAAAW+qEXAh7tyu5vyR1eLEpuXB/R3TsXWKbmuXU+K0ryeWGZztZ07
        g0fAmxqW2k2ai194oSrdIIROVaiwSDbgbbpybuW2Xk+wZE+RDDWPAK2hw9R5yZVjng==
X-Google-Smtp-Source: APXvYqwPO9IMVEuBbyw4spZ+oufd8pC6QxP/EfFndhhHqyb1phYS9Uuz9ATo8LbYLMleuuu60dgsG8rzObRo
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr4504460wrn.223.1565889265464;
        Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id l2sm71317wrm.9.2019.08.15.10.14.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKT-00051i-3B; Thu, 15 Aug 2019 17:14:25 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 81F622742BC7; Thu, 15 Aug 2019 18:14:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, brian.austin@cirrus.com,
        broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: cs4349: Use PM ops 'cs4349_runtime_pm'" to the asoc tree
In-Reply-To: <20190815090157.70036-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171424.81F622742BC7@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs4349: Use PM ops 'cs4349_runtime_pm'

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

From bed7f1469f08fd123cdec7a351ef0d875feadcf6 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:01:57 +0800
Subject: [PATCH] ASoC: cs4349: Use PM ops 'cs4349_runtime_pm'

sound/soc/codecs/cs4349.c:358:32: warning:
 cs4349_runtime_pm defined but not used [-Wunused-const-variable=]

cs4349_runtime_pm ops already defined, it seems
we should enable it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e40da86 ("ASoC: cs4349: Add support for Cirrus Logic CS4349")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815090157.70036-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4349.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 09716fab1e26..3381209a882d 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -378,6 +378,7 @@ static struct i2c_driver cs4349_i2c_driver = {
 	.driver = {
 		.name		= "cs4349",
 		.of_match_table	= cs4349_of_match,
+		.pm = &cs4349_runtime_pm,
 	},
 	.id_table	= cs4349_i2c_id,
 	.probe		= cs4349_i2c_probe,
-- 
2.20.1

