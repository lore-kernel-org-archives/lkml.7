Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B245DC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE3B251C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189574;
	bh=d0ynFPtdGmt3C0L85voa+MD7+1VbO0i7QBEovZkzBqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hu6JWPvP8wT9Fg3zDQ67md5ctnszS/QoNlknnjdElGRoCOGk9gvDfIiBQe19q/8/O
	 ANuXUlxxAaswNI34fJoBBMKtxqlj3Wuy9TQjZ1DyWx9jTiEYOlP/Gyyj1C5FitU0QT
	 DvlwT8ngkHGGM3RtDTIpXX15H4ITgScBVvZtFo+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfE3EMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730695AbfE3DQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:30 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F5B245EA;
        Thu, 30 May 2019 03:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186189;
        bh=d0ynFPtdGmt3C0L85voa+MD7+1VbO0i7QBEovZkzBqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2TMeZUwWv7hnmnuNJoO6JwzqZCTZ+zjjtwItb55mHfiZbD8U8v7WALT018M9V4rUx
         sQrOSdHvqZEo8XFZjzR7Dz5EuXnYkvk3XZWD/SnNCbsvTVI3SLyBhpP7UcCop2ssdU
         rA/cNHT8CJtVGR4CFT6TeLRgaKBgZ8QMZKMWOxrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mac Chiang <mac.chiang@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/276] ASoC: Intel: kbl_da7219_max98357a: Map BTN_0 to KEY_PLAYPAUSE
Date:   Wed, 29 May 2019 20:03:36 -0700
Message-Id: <20190530030529.129690606@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



