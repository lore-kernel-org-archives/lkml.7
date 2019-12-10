Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C50DC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0FD207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575984218;
	bh=iC6lE/bN9KCKBSnTvhQqsXgQUC9ynpk6CQ6HHU9OSHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=L3PE9lAUyWZ4wPOyLaV4Dm4ko4i/YfqZiTSkX1/w4+JQX+r9fR0YgpoIxCxgwnhst
	 onI7JpmQYK9xdMTUHrVrAmaZ3HjHwj0X66fgRc4MMJaOtLBp2SRzyDOXk42A8eAkSw
	 luz/9XU00fr+P+aeTHoRS8dARqDAA4FOHLKlkGvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLJNXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:23:37 -0500
Received: from foss.arm.com ([217.140.110.172]:44154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfLJNXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:23:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ECA61396;
        Tue, 10 Dec 2019 05:23:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E387D3F52E;
        Tue, 10 Dec 2019 05:23:34 -0800 (PST)
Date:   Tue, 10 Dec 2019 13:23:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        kuninori.morimoto.gx@renesas.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: Don't create separate link when platform is present" to the asoc tree
In-Reply-To: <20191209135353.17427-1-daniel.baluta@nxp.com>
Message-Id: <applied-20191209135353.17427-1-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card: Don't create separate link when platform is present

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

From 5525cf07d15f7c7eab619707627c31aa8e39dff1 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Mon, 9 Dec 2019 15:53:53 +0200
Subject: [PATCH] ASoC: simple-card: Don't create separate link when platform
 is present

In normal sound case all DAIs are detected as CPU-Codec.
simple_dai_link_of supports the presence of a platform but it counts
it as a CPU DAI resulting in the creation of an extra link.

Adding a platform property to a link description like:

simple-audio-card,dai-link {
	cpu {
		sound-dai = <&sai1>;
	};
	plat {
		sound-dai = <&dsp>;
	};
	codec {
		sound-dai = <&wm8960>;
	}

will result in the creation of two links:
	* sai1 <-> wm8960
	* dsp  <-> wm8960

which is obviously not what we want. We just want one single link
with:
	* sai1 <-> wm8960 (and platform set to dsp).

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20191209135353.17427-1-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 10b82bf043d1..55e9f8800b3e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -371,6 +371,7 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 	do {
 		struct asoc_simple_data adata;
 		struct device_node *codec;
+		struct device_node *plat;
 		struct device_node *np;
 		int num = of_get_child_count(node);
 
@@ -381,6 +382,9 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 			ret = -ENODEV;
 			goto error;
 		}
+		/* get platform */
+		plat = of_get_child_by_name(node, is_top ?
+					    PREFIX "plat" : "plat");
 
 		/* get convert-xxx property */
 		memset(&adata, 0, sizeof(adata));
@@ -389,6 +393,8 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 
 		/* loop for all CPU/Codec node */
 		for_each_child_of_node(node, np) {
+			if (plat == np)
+				continue;
 			/*
 			 * It is DPCM
 			 * if it has many CPUs,
-- 
2.20.1

