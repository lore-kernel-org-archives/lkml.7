Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47B5C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 04:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808E922BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 04:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hm635lZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfGZEmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 00:42:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43356 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfGZEmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 00:42:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so23860402pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 21:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eq62dV3aG3jd/W9zqRWfepVRB8FhgcYvUn8Cc6l9GkA=;
        b=Hm635lZZN0RARpzAb9ayexcKn9YXj1XlLee2lITYorBDY2KOsISLHVejwgEYcg6Nc0
         ZqhT1sHlG9s/X0ETZP/JU0sFKEZfCI/zwx6FZHpw1WBMbMM+jyC+fd8EFxcdysy7wZMH
         YYPvEnctY6Zda/l2Cl2oxKrjCh5ExnnUiBHjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eq62dV3aG3jd/W9zqRWfepVRB8FhgcYvUn8Cc6l9GkA=;
        b=mUFqQvoPnuio6E3b7qaDhCxJdHwC1FdZ8wJPe3XtP7IMDLWFEoPyk6ou74bmdIM0Hx
         MQD53rY0wX9kAfAEYRQgvBmIMI6GFuFUVx/qxUORnka4MjgUClYX9VfcpCVnp6suahum
         o6uL8pidg+gG6+yS4B72tlZyjusYob0IU2NTTu2gi/wszeMjsEevBTiJEm+ofZe9vHHL
         tSYiJ2CDGMGM1iKfVqeZafA1NZka84jQ+xWQmG5Q7NkJ8E3mjNbP0uVXvgppPvY++8Gr
         zsD+KNMqWnPSHZ6t+rOVpgjhTWm7UttwYHTZo5bYKFqbZi2zhfwHiPgXSZCaMUosn2ST
         T/cg==
X-Gm-Message-State: APjAAAWp4UvnH1FAbnTOne5boQ0XRp6kTzhG+4zbEkm6MaTX0sBfap+r
        BwqiJO6IzlgQJkmz8WydN5HetWmkbco=
X-Google-Smtp-Source: APXvYqzyDNFdueHohA8SGN1O6dmRutvK/f1c35LtOqHGnJFqaLCJWNkNKPAQTGdjzMb/377e4SAgXA==
X-Received: by 2002:a17:90a:9905:: with SMTP id b5mr98357683pjp.70.1564116135769;
        Thu, 25 Jul 2019 21:42:15 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id t7sm41702252pjq.15.2019.07.25.21.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 21:42:14 -0700 (PDT)
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
Subject: [PATCH] Revert "ASoC: rockchip: i2s: Support mono capture"
Date:   Fri, 26 Jul 2019 12:42:02 +0800
Message-Id: <20190726044202.26866-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit db51707b9c9aeedd310ebce60f15d5bb006567e0.

Previous discussion in

https://patchwork.kernel.org/patch/10147153/

explains the issue of the patch.
While device is configured as 1-ch, hardware is still
generating a 2-ch stream.
When user space reads the data and assumes it is a 1-ch stream,
the rate will be slower by 2x.

Revert the change so 1-ch is not supported.
User space can selectively take one channel data out of two channel
if 1-ch is preferred.
Currently, both channels record identical data.

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

