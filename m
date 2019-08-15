Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202FEC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F572084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889321;
	bh=wuCyLKB65cEdh1j+2STrvKTR8nB98C5ntLd/YxOV6N0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JiubHvT28y5kouoMCk4dg9Meyyd8B0sKj/R5akrG1+5u/GqNIbH2Aifq30WCTttd8
	 wF6EmBeZiWie2YaT8xOzcQSiaIsnKQFYgD6GiMORg7EUGlbsl0jAXEBvoHUVzP1f8h
	 An87hmotGUNHez5R0TIAEbEY4sQhW13slhq6a7W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfHORO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:29 -0400
Received: from mail-wr1-f100.google.com ([209.85.221.100]:38488 "EHLO
        mail-wr1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbfHORO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:26 -0400
Received: by mail-wr1-f100.google.com with SMTP id g17so2869387wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=q2b27kNIK6EqgSJpM3zfR9hAioAbBxEiISceYvWjTXE=;
        b=jA0ooqhU/LMo0ahmfH1SatsPj6sMrofAPchfbt+voyZN9dP5J6euTvglj362SY0Dpd
         9pLYZg7g2n0VckX/j+bwi/0ao9SUiNSlUVPMKgrgBwG/XzMGdoqu+s/0Vvhc2N6nppgX
         c3ZliPxa6I3HlHmhlNEAJQmyvCCbewtebb73C62rtCOlSSnpyLozwDPUV1i9th05l1Yb
         hLgKMexDG0rjsuy4bsEpbVJ1VCspr90CweuwPdzvATOWrVeCTTQig/eB5XHWWW2XVGiG
         S3lvPh9ehFDJxb+XaDkhfSwFp553TRZztdvUIzrCqds4LbBC8ictPCVHFxmQxoA9MIA7
         i/CQ==
X-Gm-Message-State: APjAAAX6Fwwo/W9Wc7Ksn4s9VZhi4Pi+GKeLPX2vf389uzAqcSqseTG7
        OPI8yiLC2DmD0N/I2NCrWTu+gDS+c+pC6gEqmOmLzOUYu2O6XmrwWVIjCj1GkmjrZQ==
X-Google-Smtp-Source: APXvYqzOz+Zqdf+HSDNjzGbbh9zF2epB8ziADuAl2ufBlIUuKwF+X8RjGSMHN6MqxNFhp+aitzIJF7ZNxJOD
X-Received: by 2002:a5d:6a45:: with SMTP id t5mr6944280wrw.228.1565889265011;
        Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id b7sm61334wrv.31.2019.08.15.10.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKS-00051c-It; Thu, 15 Aug 2019 17:14:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 034DC2742BD6; Thu, 15 Aug 2019 18:14:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, bardliao@realtek.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: rt1011: remove unused variable 'dac_vol_tlv' and 'adc_vol_tlv'" to the asoc tree
In-Reply-To: <20190815090602.9000-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171424.034DC2742BD6@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:23 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt1011: remove unused variable 'dac_vol_tlv' and 'adc_vol_tlv'

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

From 5b366753c1c12feead0ae53b45482f569ed5399c Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:06:02 +0800
Subject: [PATCH] ASoC: rt1011: remove unused variable 'dac_vol_tlv' and
 'adc_vol_tlv'

sound/soc/codecs/rt1011.c:981:35: warning:
 dac_vol_tlv defined but not used [-Wunused-const-variable=]
sound/soc/codecs/rt1011.c:982:35: warning:
 adc_vol_tlv defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815090602.9000-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1011.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 638abcaf52b3..fa34565a3938 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -978,9 +978,6 @@ static bool rt1011_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -9435, 37, 0);
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1739, 37, 0);
-
 static const char * const rt1011_din_source_select[] = {
 	"Left",
 	"Right",
-- 
2.20.1

