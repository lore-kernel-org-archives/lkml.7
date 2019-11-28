Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DFAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D708C21781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574947112;
	bh=B3J4j9P6T8W8+74YGpWBPAqoS5DOTMDVbSd6fdFj3D4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=lyT9+psfDbr9SfVSnvhvT5Lw3AXdzuKrg/DwCt2vo9lTfH4PG84vm/9RZsXFXJ2LU
	 D2YtY47h00AlCJNb5omE72eqVaEoZMJUO3QDCIW+8jU4/o/HhsvsO0lzo3tsezWPy7
	 rLkV1aYzbjtMm9VYSYyK4rZvrxKlrixb7YpmMd8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK1NSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:18:31 -0500
Received: from foss.arm.com ([217.140.110.172]:35188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1NSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:18:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FCD131B;
        Thu, 28 Nov 2019 05:18:30 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F38E63F52E;
        Thu, 28 Nov 2019 05:18:29 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:18:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: wm8904: fix automatic sysclk configuration" to the asoc tree
In-Reply-To: <20191122232532.22258-1-michael@walle.cc>
Message-Id: <applied-20191122232532.22258-1-michael@walle.cc>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm8904: fix automatic sysclk configuration

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

From 2a0bda276c64212e517cc1d65cf65719a9ab1ef6 Mon Sep 17 00:00:00 2001
From: Michael Walle <michael@walle.cc>
Date: Sat, 23 Nov 2019 00:25:32 +0100
Subject: [PATCH] ASoC: wm8904: fix automatic sysclk configuration

The simple-card tries to signal the codec to disable rate constraints,
see commit 2458adb8f92a ("SoC: simple-card-utils: set 0Hz to sysclk when
shutdown"). This wasn't handled by the codec, instead it would set the
FLL frequency to 0Hz which isn't working. Since we don't have any rate
constraints just ignore this request.

Fixes: 13409d27cb39 ("ASoC: wm8904: configure sysclk/FLL automatically")
Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20191122232532.22258-1-michael@walle.cc
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8904.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 2a7d23a5daa8..d191d81850ee 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1806,6 +1806,12 @@ static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	switch (clk_id) {
 	case WM8904_CLK_AUTO:
+		/* We don't have any rate constraints, so just ignore the
+		 * request to disable constraining.
+		 */
+		if (!freq)
+			return 0;
+
 		mclk_freq = clk_get_rate(priv->mclk);
 		/* enable FLL if a different sysclk is desired */
 		if (mclk_freq != freq) {
-- 
2.20.1

