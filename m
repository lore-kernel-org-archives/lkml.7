Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA758C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEC52086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889323;
	bh=V0HN4+vpnqwlBH0IBF5ZoLZgbOeKS1TfgysuiMqIPfk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YSfwTs/dd7Uub+aKg89OLyWlHAnit4Uw8Rc0n+59WoxEMW2t27x52HfTjsCMp4KbP
	 cVFlFLyq+Vsu3HdNM29VevP+5o1DuPcLudj2wz6eVYT9a5upAmfUUQG0UeqPq9Pjs+
	 43BCTdj3sJQaYIdFCB7rAjUM49AQPeCcKfDplMws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfHORPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:22 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:55213 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731622AbfHORO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:29 -0400
Received: by mail-wm1-f97.google.com with SMTP id p74so1872601wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=H42j7NEHlsPF3r/4bj3RbhLYDdVkIJ1yMKu66UQkvI4=;
        b=oAzAkgNq0tPv4IhytmlfcgQvgtPa7T1FE4lOmKoYWLPh4+hJnKZVBgcOYDHTNFvVmL
         b+Sh+QyaG3QuyNTzRlkITX6rncVlmJ+2AmZBWBjlOLUO53FEII7LTggXB6s+fRiBvdQr
         UYrpAdSWlb5cZKS06Q/ionazQSi5h7PELm4nzxfclip2OKAb+Ms10O9zeu5Eqy1yL4+e
         kvtCA+bHZg/0kxVZ4r86GaKGM+FAPon1bsmvzMuwuC6vhHat/2/8FGCprwvkzApT0Tx9
         ZUfgl+Mc6Rpe22NKmkWGIDQakrgn1VhSMUX14mMYeWQdCRASqpBLt6RhCLKiGhTt6+2W
         A9tw==
X-Gm-Message-State: APjAAAX6B2BVrfavPJNbK1xuTVpAKYuTSSKfKD8kN4EUQrudQTHgTCJD
        BDaxVVRSjUrDjRm4FmiksatHi5vK9eJJghp9Fph084cU0GDehBR9PoHODgG1PlXeyw==
X-Google-Smtp-Source: APXvYqwMVHN1Cq4FcYozfOJt19P1x3Rl/aGkIkoFGx/zDiL5eHAyaKLoPUmxO54xTdVQEi0Sywi2RctYSaIS
X-Received: by 2002:a1c:f702:: with SMTP id v2mr3843515wmh.114.1565889267826;
        Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id 9sm7523wmf.3.2019.08.15.10.14.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKV-00052K-EL; Thu, 15 Aug 2019 17:14:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CED5D2742BC7; Thu, 15 Aug 2019 18:14:26 +0100 (BST)
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
Message-Id: <20190815171426.CED5D2742BC7@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs4349: Use PM ops 'cs4349_runtime_pm'

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

From 9b4275c415acca6264a3d7f1182589959c93d530 Mon Sep 17 00:00:00 2001
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

