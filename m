Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F47C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E7B20856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558555353;
	bh=iNmR0JZ46jXVV6tOtn7wO2t8f/KBToboSyKHCBh9JPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X0QxLa1elCJzOZQSXkhDHtkAqWu01MGZw0vWGunrLQbM94PvsDOspyaEeM7zmyeDu
	 zI2g3DJwLLEIL17HfnqgWZFafr+XoB1o5oWy3l+rbtBDsCPMn6trV698jrvN8BO7wS
	 8XbF9kzle7WnI/yy38049ic1NOZbqpONy8UemVew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfEVUCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbfEVTV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:21:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A3922177E;
        Wed, 22 May 2019 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558552917;
        bh=iNmR0JZ46jXVV6tOtn7wO2t8f/KBToboSyKHCBh9JPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3WSFNYFEJPVr4g0wQyPmo2GW1etpy8x+qFIzxI84UhUckTfzEsdSCVXV3pNjjvoX
         HT/znsHSiLe8wL3RMnYY4trEBGCgp47osDhc12qc9yUeOljfv2d4MPgsjfoxMdfATj
         PMM4CSYgptxS2WpvYTxWYr3d99BHDW69Y/BhRn6k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mac Chiang <mac.chiang@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 028/375] ASoC: Intel: kbl_da7219_max98357a: Map BTN_0 to KEY_PLAYPAUSE
Date:   Wed, 22 May 2019 15:15:28 -0400
Message-Id: <20190522192115.22666-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192115.22666-1-sashal@kernel.org>
References: <20190522192115.22666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mac Chiang <mac.chiang@intel.com>

[ Upstream commit 16ec5dfe0327ddcf279957bffe4c8fe527088c63 ]

On kbl_rt5663_max98927, commit 38a5882e4292
    ("ASoC: Intel: kbl_rt5663_max98927: Map BTN_0 to KEY_PLAYPAUSE")
    This key pair mapping to play/pause when playing Youtube

The Android 3.5mm Headset jack specification mentions that BTN_0 should
be mapped to KEY_MEDIA, but this is less logical than KEY_PLAYPAUSE,
which has much broader userspace support.

For example, the Chrome OS userspace now supports KEY_PLAYPAUSE to toggle
play/pause of videos and audio, but does not handle KEY_MEDIA.

Furthermore, Android itself now supports KEY_PLAYPAUSE equivalently, as the
new USB headset spec requires KEY_PLAYPAUSE for BTN_0.
https://source.android.com/devices/accessories/headset/usb-headset-spec

The same fix is required on Chrome kbl_da7219_max98357a.

Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 38f6ab74709d0..07491a0f8fb8b 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -188,7 +188,7 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	jack = &ctx->kabylake_headset;
 
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
-- 
2.20.1

