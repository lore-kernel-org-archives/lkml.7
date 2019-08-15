Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE13C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436F8205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889352;
	bh=oSvmXiLO/EWWpPrqvhCsHsG2X+AkvcbxKbDwQLBXB/0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GQPU/WEreIw/hSJRB4o8Okgn5oH+GM7BaaUIEaTj7aPct0shHfN+RA8MuATg56H9B
	 PlLciZb/UPlKBkGvMm7cMI0o1HjJpexlR1s3z79BshJpP9r1R3g+C8baxGRadz9NEp
	 xXTKq4abxPiqrZwGdgIqj+t2/ivFTH327+T6Lxh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbfHORPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:51 -0400
Received: from mail-wr1-f98.google.com ([209.85.221.98]:43353 "EHLO
        mail-wr1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731493AbfHORO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:26 -0400
Received: by mail-wr1-f98.google.com with SMTP id y8so2836923wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=8OKTosr+JapOEyKfTFu5/cIoWSDJg3p0VdlQDgNuNVQ=;
        b=LLjmpTnXEZoe/Zwuu5K+ngxq0/QWUAL2Oaqd6NFiPrndc3jf1XxQc+gInuiE7Ipedr
         4E7GgiB4dhasqc6tZ5FGNxPbL+75x1m+jL2khpFzYB/G6KWFYnOI99jWUjcsEAuH5MIj
         Cy4+fOVUOnf2SoFEwcjm/z4/ZiqS2eIeXDKArflQDIOo9LCd7incwl61deWTPbem+J1S
         WTlbBpUzCPXR0OkxY8TTQAqD0/6a3nyeDK2z9zhG1Xbm5t1Sn/D+ddKnyel/L54lVJuD
         JHQbHUosxz/LXWTAmgM+kdw0SCWpEJSfiuX9VvD4BtkfH/CRD5ux0NfWxd8hM/zCYNgO
         jPxQ==
X-Gm-Message-State: APjAAAVl0oHR/UJBx4vJsEacxJczS0GYxfeY3TxFn7jIio8ePGr0VyTS
        iNWwJqfLcQs+Y3NnoAGq5TQgK73j0+hbXFyJW+rkam8ZEEOwQFoievfogzG3SPxkCA==
X-Google-Smtp-Source: APXvYqyFff08HZqpINQezwtCcVwX7DUZ5s6kk7CY/pdV4LdEuXHc8dJVbAquvNC4Dzb1jfopyWtKL7V3K3UB
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr6337203wrx.296.1565889263829;
        Thu, 15 Aug 2019 10:14:23 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id d26sm57082wrb.30.2019.08.15.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:23 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKR-00051M-IF; Thu, 15 Aug 2019 17:14:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EA7D62742BC7; Thu, 15 Aug 2019 18:14:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, info@metux.net,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: es8328: Fix copy-paste error in es8328_right_line_controls" to the asoc tree
In-Reply-To: <20190815092300.68712-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171422.EA7D62742BC7@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:22 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es8328: Fix copy-paste error in es8328_right_line_controls

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

From d63887bc4f50fede7013bda7c733d58ecc43efc1 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:23:00 +0800
Subject: [PATCH] ASoC: es8328: Fix copy-paste error in
 es8328_right_line_controls

It seems 'es8328_rline_enum' should be used
in es8328_right_line_controls

Fixes: 567e4f98922c ("ASoC: add es8328 codec driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815092300.68712-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 4a3d303fedfb..fdf64c29f563 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -227,7 +227,7 @@ static const struct soc_enum es8328_rline_enum =
 			      ARRAY_SIZE(es8328_line_texts),
 			      es8328_line_texts);
 static const struct snd_kcontrol_new es8328_right_line_controls =
-	SOC_DAPM_ENUM("Route", es8328_lline_enum);
+	SOC_DAPM_ENUM("Route", es8328_rline_enum);
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
-- 
2.20.1

