Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC615C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827492086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889345;
	bh=uCv3ANlGiU6HiTvN6P1xDsEf/xeUttNkNP6wPePSrHg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dr+l8szETrz5VLq7b8iKkzI7DcGTwQscgjPPi+/UN9fGd885R2KoPm792FApBleVv
	 gsS0uQ0mraJ+r+QcTi4QQl3c5fTWXfTUqqO7Vwopwbm3UMh1+o9fzuJ1dwgH22Sqiy
	 P4yTa3f+/2s+w5oB1oEu8pwldr02oIKct2nyv1UA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbfHORPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:44 -0400
Received: from mail-wr1-f98.google.com ([209.85.221.98]:42378 "EHLO
        mail-wr1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbfHORO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:26 -0400
Received: by mail-wr1-f98.google.com with SMTP id b16so2847958wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=LkRo0LEpuvWQLdD7RS5Oy9z1REDgwUldokEQpfRcGzw=;
        b=QF7EPGFrRW5EyBRufxe1wpKZC0IaLGntQujuNv7OFiVldoFkpK4ldy4vnwXsghK+ab
         leIyM889h0SfUOelNpJEBb6OrReULYwjyC3dZvMaKZaxFWi8Pmq+MIdETHUt9sws2E9Y
         oNKFqCoSJX4UtOYZqosh5xaP7PIJol62bgI4pZJ0JA2nbyKl3j/gFv8kI9NumZbYTi2a
         ZG45zWB4Oh/purnj4kpAPkL8zlWgTDH32j3VQm0xk3PVdY3t3uWkKtJngwh/dCnwTgN9
         Tr3iDRS6JviPO4zoNsQJqpRqQ/QcEvwSomYaAJz7eDjWG3XEBm9SOpBGTIRsI5YJdxMk
         UEtA==
X-Gm-Message-State: APjAAAVLZUOoe4MYuZYIoZZzH2hl1VVSAjryOd79Y22U+Ox4uCPZOO3e
        EsBpgwkOTGhSo/K00f2E1SzhnRNqQdl3iGvGbZbgItpUPKWRvTmA1vNbe73A47bl3A==
X-Google-Smtp-Source: APXvYqwbgDkBSeusiCNHGIa5V444ZMTjGNsPfmPdlvjykZ+7aqKz5HZiNp4zQdXJ2talNWx4jCvTzou2WIG0
X-Received: by 2002:adf:b64e:: with SMTP id i14mr6661321wre.248.1565889264640;
        Thu, 15 Aug 2019 10:14:24 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id c128sm12460wma.50.2019.08.15.10.14.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:24 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKS-00051Y-BD; Thu, 15 Aug 2019 17:14:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BA3862742BC7; Thu, 15 Aug 2019 18:14:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     allison@lohutok.net, alsa-devel@alsa-project.org,
        broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        kstewart@linuxfoundation.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: tlv320aic23: remove unused variable 'tlv320aic23_rec_src'" to the asoc tree
In-Reply-To: <20190815091534.57780-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171423.BA3862742BC7@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:23 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320aic23: remove unused variable 'tlv320aic23_rec_src'

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

From ab0ac2707784a966927c229752849c343bd1dbbf Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:15:34 +0800
Subject: [PATCH] ASoC: tlv320aic23: remove unused variable
 'tlv320aic23_rec_src'

sound/soc/codecs/tlv320aic23.c:70:29: warning:
 tlv320aic23_rec_src defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815091534.57780-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic23.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 080a840c987a..f8e2f4b74db3 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -67,8 +67,6 @@ static SOC_ENUM_SINGLE_DECL(rec_src_enum,
 static const struct snd_kcontrol_new tlv320aic23_rec_src_mux_controls =
 SOC_DAPM_ENUM("Input Select", rec_src_enum);
 
-static SOC_ENUM_SINGLE_DECL(tlv320aic23_rec_src,
-			    TLV320AIC23_ANLG, 2, rec_src_text);
 static SOC_ENUM_SINGLE_DECL(tlv320aic23_deemph,
 			    TLV320AIC23_DIGT, 1, deemph_text);
 
-- 
2.20.1

