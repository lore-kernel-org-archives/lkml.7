Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5FBC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADBD21744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578343863;
	bh=nowxDL/wEe6QGoYZLMRzw1fn68QIa64IJB6h8HhpGPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=JY6ZuPR58X4xoniDZlDlemTSZY6Gj4nwOyreOJiR4C4WYiAwGw7sAebUzGGTOhiy6
	 Xql1EYdlgx5tram9kgKzjWRtKp0wDk8617dtSufmPM/Nc9TTLYAI/GoUuURTi0tvu2
	 Kdx64JUhz5i7qx21FlkKbkoX8LJqTGRxuS2+CFj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgAFUvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:51:02 -0500
Received: from foss.arm.com ([217.140.110.172]:49212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgAFUvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:51:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A46106F;
        Mon,  6 Jan 2020 12:51:00 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 230483F534;
        Mon,  6 Jan 2020 12:50:59 -0800 (PST)
Date:   Mon, 06 Jan 2020 20:50:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Applied "ASoC: rt5640: Fix NULL dereference on module unload" to the asoc tree
In-Reply-To: <20200106014707.11378-1-digetx@gmail.com>
Message-Id: <applied-20200106014707.11378-1-digetx@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5640: Fix NULL dereference on module unload

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 89b71b3f02d8ae5a08a1dd6f4a2098b7b868d498 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Mon, 6 Jan 2020 04:47:07 +0300
Subject: [PATCH] ASoC: rt5640: Fix NULL dereference on module unload

The rt5640->jack is NULL if jack is already disabled at the time of
driver's module unloading.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Link: https://lore.kernel.org/r/20200106014707.11378-1-digetx@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index adbae1f36a8a..747ca248bf10 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2432,6 +2432,13 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
 {
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
+	/*
+	 * soc_remove_component() force-disables jack and thus rt5640->jack
+	 * could be NULL at the time of driver's module unloading.
+	 */
+	if (!rt5640->jack)
+		return;
+
 	disable_irq(rt5640->irq);
 	rt5640_cancel_work(rt5640);
 
-- 
2.20.1

