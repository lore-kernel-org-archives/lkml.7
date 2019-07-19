Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCB3C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42CA21873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfGSSGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:06:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41208 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbfGSSGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:06:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A114028C53E
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, dianders@chromium.org,
        cychiang@chromium.org, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] SoC: rockchip-max98090: Remove MICBIAS as supply of input pin IN34
Date:   Fri, 19 Jul 2019 20:05:58 +0200
Message-Id: <20190719180558.11459-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ec0d23b295b9 ("ASoC: rockchip-max98090: Fix the Headset Mic
route.") moved the MICBIAS widget to supply Headset Mic but forget to
remove the MICBIAS widget to supply IN34 which is not really needed, so
remove that path so we have:

   IN34 <==== Headset MIC <==== MICBIAS

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 sound/soc/rockchip/rockchip_max98090.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 782e534d4c0d..1af1147c3da3 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -45,7 +45,6 @@ static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route rk_audio_map[] = {
 	{"IN34", NULL, "Headset Mic"},
-	{"IN34", NULL, "MICBIAS"},
 	{"Headset Mic", NULL, "MICBIAS"},
 	{"DMICL", NULL, "Int Mic"},
 	{"Headphone", NULL, "HPL"},
-- 
2.20.1

