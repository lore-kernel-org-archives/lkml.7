Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE7C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C42824655
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468639;
	bh=M5YR3Aja1kN2HFjnI1fjDZZmVPUiQ4RWomKcTuwqkyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I/Zo8Ra85UV0KtjPhhbBiYd4DCz4N1jw57WTrD0UCY1vwGmO0ASORzjv0vkUyPgrs
	 6CZQgP7rnDCLKe50pCARflBT9frDg7xpzZp1RC+IapWDBqBkoRrBeLJNvmeywxs2Wz
	 f/yL00fW+WeMbfFzmMfKVzvgnn0ezPjOS2y4WZR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfL0Rn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:43:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfL0Rnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:43:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6993921D7E;
        Fri, 27 Dec 2019 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468635;
        bh=M5YR3Aja1kN2HFjnI1fjDZZmVPUiQ4RWomKcTuwqkyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWIZ6NB6AvJzbESLu3n0aK/WW0FXLma1q0xSjUuj+yQRn/OWwZVhyiyAOLFt0NR+C
         jaF7PC5d9a95uf0IRRM1Y3Sgq/udetS5FV4yZ5rvdrxLQp5A2wgiijbwY40h8NSwrW
         vGnOlo/CR0mEkrjJYHRr5TauN2xZMy7kI7odCyF8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 02/84] ASoC: max98090: remove msleep in PLL unlocked workaround
Date:   Fri, 27 Dec 2019 12:42:30 -0500
Message-Id: <20191227174352.6264-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzung-Bi Shih <tzungbi@google.com>

[ Upstream commit acb874a7c049ec49d8fc66c893170fb42c01bdf7 ]

It was observed Baytrail-based chromebooks could cause continuous PLL
unlocked when using playback stream and capture stream simultaneously.
Specifically, starting a capture stream after started a playback stream.
As a result, the audio data could corrupt or turn completely silent.

As the datasheet suggested, the maximum PLL lock time should be 7 msec.
The workaround resets the codec softly by toggling SHDN off and on if
PLL failed to lock for 10 msec.  Notably, there is no suggested hold
time for SHDN off.

On Baytrail-based chromebooks, it would easily happen continuous PLL
unlocked if there is a 10 msec delay between SHDN off and on.  Removes
the msleep().

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20191122073114.219945-2-tzungbi@google.com
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max98090.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c3b28b2f4b10..f8c8b9decab6 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2132,10 +2132,16 @@ static void max98090_pll_work(struct work_struct *work)
 
 	dev_info_ratelimited(component->dev, "PLL unlocked\n");
 
+	/*
+	 * As the datasheet suggested, the maximum PLL lock time should be
+	 * 7 msec.  The workaround resets the codec softly by toggling SHDN
+	 * off and on if PLL failed to lock for 10 msec.  Notably, there is
+	 * no suggested hold time for SHDN off.
+	 */
+
 	/* Toggle shutdown OFF then ON */
 	snd_soc_component_update_bits(component, M98090_REG_DEVICE_SHUTDOWN,
 			    M98090_SHDNN_MASK, 0);
-	msleep(10);
 	snd_soc_component_update_bits(component, M98090_REG_DEVICE_SHUTDOWN,
 			    M98090_SHDNN_MASK, M98090_SHDNN_MASK);
 
-- 
2.20.1

