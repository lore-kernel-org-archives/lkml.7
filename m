Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA0C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE25229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AObi35zU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGZMIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:08:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45233 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfGZMIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:08:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so24431008pfq.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cbwmacy9vNq4B+n0PukpHrIPl4ScNgVEPcJ32HL8owE=;
        b=AObi35zUYJig2WeybEddiDzaj/fnCxwM2Qj8U5BZrRxfR7DqT4XA6WSF7zyiUwBiqg
         7yBr/+X/fyFPhrst6RV5yT7Jak4QkmSzMlIGvboPQSv6DlB5VgLqLjkRyDrp1/cFZCE5
         paPvLI+dXkBmqIhc5bCOvjWN7Fk+X7xb919Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cbwmacy9vNq4B+n0PukpHrIPl4ScNgVEPcJ32HL8owE=;
        b=PzEu1+jT2CGXJJ6QuuBwmbPSXF6BM7gIxDc/yHQWFOELBaGYTP5CxiyADQ+iRrfuqw
         AY8IYykWqzDHqiLb8/oXY5tWkTRxTDqH5vTqeeLuCAiXhrr+QSmkfagz4VG+RpBiwFWW
         oPiOnerSVnuBJLlt5G9OpFuBViUsmvys70BMGWJ7iUdEA16DfUvWqesGcyiDR4Jr2rAS
         szlEr1TRK9HMT5vovdbZFwwyYeUkGDfOKgtehnbdmGHDjNMyXSTI21RRWdz1lXEgHAXY
         31wUDLqHZqnW2vqvnsuwldTgO+DFhniJLsNiL2rp47YznSTtajXpnMpOuVOFNf4oisgF
         6VMA==
X-Gm-Message-State: APjAAAUFLGy9qYIcl+dzLFJQ9tvsyA9FNCyuy2jvItZAqV4TA3G/ddvJ
        4LCz/kK585HtZlIwdcFXGbj+Do2YlIc=
X-Google-Smtp-Source: APXvYqz9ldY9m4MPhE5vPXUihPALYRe2GG7mFkrh7mMDn8k9KRoYh+ADGCd1vq8cRpZmJBcyhGuM9A==
X-Received: by 2002:a17:90a:bc0c:: with SMTP id w12mr65162344pjr.111.1564142920570;
        Fri, 26 Jul 2019 05:08:40 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id m20sm54800981pff.79.2019.07.26.05.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 05:08:39 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org, mka@chromium.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2] ASoC: rockchip: i2s: Revert "ASoC: rockchip: i2s: Support mono capture"
Date:   Fri, 26 Jul 2019 20:08:33 +0800
Message-Id: <20190726120833.186833-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit db51707b9c9aeedd310ebce60f15d5bb006567e0.

Commit db51707b9c9a ("ASoC: rockchip: i2s: Support mono capture")
adds support of mono capture to rockchip_i2s_dai.

However, I2S controller is still generating a 2-channel stream
because it only supports even number of channels.
When user space reads the data and assumes it is a mono stream,
the rate will be slowed down.

Revert the change so the DAI no longer claims that mono capture
is supported.

Fixes: db51707b9c9a ("ASoC: rockchip: i2s: Support mono capture")
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 0a34d0eb8dba..88ebaf6e1880 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -326,7 +326,6 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 		val |= I2S_CHN_4;
 		break;
 	case 2:
-	case 1:
 		val |= I2S_CHN_2;
 		break;
 	default:
@@ -459,7 +458,7 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
 	},
 	.capture = {
 		.stream_name = "Capture",
-		.channels_min = 1,
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = (SNDRV_PCM_FMTBIT_S8 |
@@ -659,7 +658,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	}
 
 	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
-		if (val >= 1 && val <= 8)
+		if (val >= 2 && val <= 8)
 			soc_dai->capture.channels_max = val;
 	}
 
-- 
2.22.0.709.g102302147b-goog

