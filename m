Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4E7C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B0D2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889273;
	bh=CQYXPmqNgyBCJKmcj/Zy12G/LFd31ztZh6klDKhZ5Es=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XqsCTIiqQAIVlxeaVLV8KK4EwdF5MFQDfy0jpCsHONqzz1RVsRMktxm96L0WIHXpI
	 ISvTmQ61ewYrcCF62pXKYtJ1LZ2A//GbShToIHqAHNj86rvWpt/bJiNuljcLG/U9lr
	 A3YCfet4SS8Ta5UL93JEQy17DIDvW0uhrAw4imPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfHOROc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:32 -0400
Received: from mail-ed1-f99.google.com ([209.85.208.99]:33547 "EHLO
        mail-ed1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbfHORO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:27 -0400
Received: by mail-ed1-f99.google.com with SMTP id s15so2738191edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=j3Q6C7993gw6V8zvZYR0NFmKhWxVJbQ4l/W0JiwHC9Q=;
        b=cN4HV8CuFyVAS9XmPHF3w0b+9iZ1lW91jBG/jy4eDstR/+96CkUA7p6zYG1x2ZU5L7
         ToCV1Cqdz6EfeB001XE5gqZiNkKAeAGzApTD/RSkePIFT/+x8bGBwMaE0pQ3AOvGx82i
         2+0m4/WtI5/9mjnhUWyNCV4M5qEVjxtYHbdbtL3Tqqe2EinN4X9rc6GUgeyq5lg42HV5
         DO9CxkmNNkQ1shMAc9iknB3SVdPUDd2F1WhOTjy5W+qpWKqVXQaXQDTukDTHyjEBY4my
         qduEAthj6io5t4fZKUTiEHPQTOgCL63p9yhSEB0OJtkrdNTC2CI4OkL/rm77D3jazmGX
         ws2g==
X-Gm-Message-State: APjAAAWKeW429XzyK4H7b1k+YUsgDvVkkT0ANkXdFXoYyMgDHJRobZ/e
        Okutlg4nQkF56LIZFb2NVkAYLxbg/rXxbrNc3NLxw5l1og9zcWs5mlBO2uAkbgyTlw==
X-Google-Smtp-Source: APXvYqxYCczx8aCgUzMwXHJLZGCZ8Smxka+++sWR3i8SWs5jr4tlRb4aLr4f8DeZ9fgCmju0gYCNJk8tYRvS
X-Received: by 2002:a17:906:8409:: with SMTP id n9mr5377393ejx.128.1565889266284;
        Thu, 15 Aug 2019 10:14:26 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id ha1sm11470ejb.8.2019.08.15.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:26 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKU-00051z-0r; Thu, 15 Aug 2019 17:14:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8EDFE2742BD6; Thu, 15 Aug 2019 18:14:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        perex@perex.c, tiwai@suse.com
Subject: Applied "ASoC: mediatek: mt8183-mt6358-ts3a227-max98357: remove unused variables" to the asoc tree
In-Reply-To: <20190813144122.67676-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171425.8EDFE2742BD6@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: mt8183-mt6358-ts3a227-max98357: remove unused variables

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

From d59170b42610c7cbc6e96431ca8357a8bdbf592b Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 13 Aug 2019 22:41:22 +0800
Subject: [PATCH] ASoC: mediatek: mt8183-mt6358-ts3a227-max98357: remove unused
 variables

sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c:50:1: warning:
 mt8183_mt6358_ts3a227_max98357_dapm_widgets defined but not used [-Wunused-const-variable=]
sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c:55:1: warning:
 mt8183_mt6358_ts3a227_max98357_dapm_routes defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190813144122.67676-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c   | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 53f54078f78c..272766c1b859 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -46,16 +46,6 @@ static int mt8183_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static const struct snd_soc_dapm_widget
-mt8183_mt6358_ts3a227_max98357_dapm_widgets[] = {
-	SND_SOC_DAPM_OUTPUT("IT6505_8CH"),
-};
-
-static const struct snd_soc_dapm_route
-mt8183_mt6358_ts3a227_max98357_dapm_routes[] = {
-	{"IT6505_8CH", NULL, "TDM"},
-};
-
 static int
 mt8183_mt6358_ts3a227_max98357_bt_sco_startup(
 	struct snd_pcm_substream *substream)
-- 
2.20.1

