Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3060AC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E1320679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gr2P6VZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfHMHoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:44:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41744 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfHMHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:44:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so40473529pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGWISY3VrJOIlFf6UspJXH4MK7kN0CsW/Y8ULJ0Kwsg=;
        b=gr2P6VZATnnB9+lPemtkV6oz7hDqDZRqLEIsHSwg3T/hclit7LQRxjp93NpWl2MES2
         Um+PzAS1Kko5EqOad+bjxXZKqx+uymm1exp3k8E1foMXH74iYttXfc4Iy13TYyEllztv
         hUB/V1Le4fDSi6DYbcaFO7khLFTIlpHwS5Qy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGWISY3VrJOIlFf6UspJXH4MK7kN0CsW/Y8ULJ0Kwsg=;
        b=eHraWCI/xDeRddSiEVdKI5OENlK75R07ZfratELi9ttJm+mNTKY5ACR/ypjCnmCMwg
         Td/59FLwOm1QDdUdL8tpbJPea5k8b8KFeCoEIYwbx27BpE6OjQUjZr/jrTA5ZXRf1r5r
         KJNO3W9INcnWpR5Gt2mgKQTrEELpAvito2ZLTjyoO3yqUm+USLIDB5K4zwEKpIQYrfBv
         xZFxRiPAjM5pfF71eqrHd1jOmr6ZL+bYoxreR8WIH/8ZesjKxgsHbCqM8q9/oKpWsBFG
         3Gmsh9gh1JJPgurBXEkUV3NY7EQdK7cfrTLkO5AsIep+pqw1o/gAVwVIuhAi4PbJw7Ph
         uSeA==
X-Gm-Message-State: APjAAAUpACzyTZsfghxnPvT0xNrPVawEScr2Svox/oxgci4BKFTNdeYj
        rwCcbC6j96yNYQkvln52lNBngsK7j7M=
X-Google-Smtp-Source: APXvYqzkzDTF0AwWSIcaHQgPLZiwdVjeEy+ci5i4EwVLcCB8uW8sIMX56ixAY+7bZj0RLkfelhwRAg==
X-Received: by 2002:a63:db45:: with SMTP id x5mr16250861pgi.293.1565682283264;
        Tue, 13 Aug 2019 00:44:43 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id p3sm682260pjo.3.2019.08.13.00.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 00:44:42 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        zhengxing@rock-chips.com, cain.cai@rock-chips.com,
        eddie.cai@rock-chips.com, jeffy.chen@rock-chips.com,
        enric.balletbo@collabora.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: rockchip: rockchip_max98090: Set period size to 240
Date:   Tue, 13 Aug 2019 15:44:30 +0800
Message-Id: <20190813074430.191791-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From stress testing of arecord, we found that period size
greater than ~900 will bring pl330 to DYING state and
can not recover within 100 iterations.
The result is that arecord will stuck and get I/O error,
and issue can not be recovered until reboot.

This issue does not happen when period size is small.
Set constraint of period size to 240 to prevent such issue.
With the constraint, there will be no issue after 2000 iterations.

We can revert this patch once the root cause is found
in rockchip's pl330 implementation.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 7b0c21fa6dca..0097df1fae66 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -137,8 +137,19 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int rk_aif1_startup(struct snd_pcm_substream *substream)
+{
+	/*
+	 * Set period size to 240 because pl330 has issue
+	 * dealing with larger period in stress testing.
+	 */
+	return snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 240, 240);
+}
+
 static const struct snd_soc_ops rk_aif1_ops = {
 	.hw_params = rk_aif1_hw_params,
+	.startup = rk_aif1_startup,
 };
 
 SND_SOC_DAILINK_DEFS(hifi,
-- 
2.23.0.rc1.153.gdeed80330f-goog

