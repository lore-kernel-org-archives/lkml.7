Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B78C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E052070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578499119;
	bh=qy092igyMYcoN7tTQE0LDmbLXIXTCH+RwAX4kuK+pZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Ev4FVvZN39oT9M1IvEEqQ9fOR1FY/sDHHdR6/QlYGm/0t+EhKuH1HmQ+pW62G+2Gj
	 L7xfrcF5OSdPnjz9i3VQNKkPk9POSvzdPYiFOBf5x1xLNQSl0IaCuCu/SoZzyDcXLV
	 BrEdxxl8P3yb5OjPolFELc7aYTHoQfCd7PzpPWug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgAHP6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:58:38 -0500
Received: from foss.arm.com ([217.140.110.172]:46528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbgAHP6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:58:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4192F31B;
        Wed,  8 Jan 2020 07:58:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C11DB3F534;
        Wed,  8 Jan 2020 07:58:37 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:58:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Allison Randal <allison@lohutok.net>, alsa-devel@alsa-project.org,
        Angus Ainslie (Purism) <angus@akkea.ca>,
        Enrico Weigelt <info@metux.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Applied "ASoC: gtm601: fix build warning" to the asoc tree
In-Reply-To: <20200107214846.1284981-1-arnd@arndb.de>
Message-Id: <applied-20200107214846.1284981-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: gtm601: fix build warning

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 599b10193c77e4b8a68192b3b277a01e8b467043 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 7 Jan 2020 22:48:35 +0100
Subject: [PATCH] ASoC: gtm601: fix build warning

The driver produces warnings without CONFIG_OF, and makes
no sense without it either:

sound/soc/codecs/gtm601.c:50:34: error: 'bm818_dai' defined but not used [-Werror=unused-variable]
 static struct snd_soc_dai_driver bm818_dai = {
                                  ^~~~~~~~~
sound/soc/codecs/gtm601.c:32:34: error: 'gtm601_dai' defined but not used [-Werror=unused-variable]
 static struct snd_soc_dai_driver gtm601_dai = {
                                  ^~~~~~~~~~

Remove the #ifdef check to avoid the warning.

Fixes: 057a317a8d94 ("ASoC: gtm601: add Broadmobi bm818 sound profile")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20200107214846.1284981-1-arnd@arndb.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/gtm601.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index 7f05ebcb88d1..ae9e1c70ca57 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -87,14 +87,12 @@ static int gtm601_platform_probe(struct platform_device *pdev)
 			(struct snd_soc_dai_driver *)dai_driver, 1);
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id gtm601_codec_of_match[] = {
 	{ .compatible = "option,gtm601", .data = (void *)&gtm601_dai },
 	{ .compatible = "broadmobi,bm818", .data = (void *)&bm818_dai },
 	{},
 };
 MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
-#endif
 
 static struct platform_driver gtm601_codec_driver = {
 	.driver = {
-- 
2.20.1

