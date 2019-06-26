Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C6C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A6E205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561521053;
	bh=trAJRYMsW7mYtFLtD9y9stdKjKGvaJ2zZufxV8nukII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PwLvzYwZNiBwuxVBj53l0staEwm+orezlPo4WBdUnNtbOX9Jd2oZsYx2gppSUs1bk
	 ck8I46wikBtIGLpYk3NibtIQ6efHEt9bxScwbP20453MJGebnNQkOT3suKZHJaAedo
	 Qxn+1u6enWW5p3tSsA5clBPX4WUZW+dQ0TtrGGDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfFZDuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfFZDln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:41:43 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFF8E2146E;
        Wed, 26 Jun 2019 03:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520502;
        bh=trAJRYMsW7mYtFLtD9y9stdKjKGvaJ2zZufxV8nukII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwGjzGsyXAaUemVjnRcuCvWCi27D99VUR29wO80XNgdeUutlwIi1mu6+j6n6wsh8t
         nPglkifVcOryUJba9V1d1z5/817/PuCOYZhH9qAshXfw6jpCEDfpG0WSj3GuYGegJF
         +EvHtNmmN5Ltm7ZddjFh4Blpep0zT/uneUxgIZTk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 11/51] ASoC: sun4i-codec: fix first delay on Speaker
Date:   Tue, 25 Jun 2019 23:40:27 -0400
Message-Id: <20190626034117.23247-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034117.23247-1-sashal@kernel.org>
References: <20190626034117.23247-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georgii Staroselskii <georgii.staroselskii@emlid.com>

[ Upstream commit 1f2675f6655838aaf910f911fd0abc821e3ff3df ]

Allwinner DAC seems to have a delay in the Speaker audio routing. When
playing a sound for the first time, the sound gets chopped. On a second
play the sound is played correctly. After some time (~5s) the issue gets
back.

This commit seems to be fixing the same issue as bf14da7 but
for another codepath.

This is the DTS that was used to debug the problem.

&codec {
        allwinner,pa-gpios = <&r_pio 0 11 GPIO_ACTIVE_HIGH>; /* PL11 */
        allwinner,audio-routing =
                "Speaker", "LINEOUT";

        status = "okay";
}

Signed-off-by: Georgii Staroselskii <georgii.staroselskii@emlid.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 15d08e343b47..28d2f7713f8d 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1329,6 +1329,15 @@ static int sun4i_codec_spk_event(struct snd_soc_dapm_widget *w,
 	gpiod_set_value_cansleep(scodec->gpio_pa,
 				 !!SND_SOC_DAPM_EVENT_ON(event));
 
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		/*
+		 * Need a delay to wait for DAC to push the data. 700ms seems
+		 * to be the best compromise not to feel this delay while
+		 * playing a sound.
+		 */
+		msleep(700);
+	}
+
 	return 0;
 }
 
-- 
2.20.1

