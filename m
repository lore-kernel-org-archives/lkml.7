Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED4CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2350B22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566305700;
	bh=5jRpA2Fa56LnJEg0pg0kUW6RZnZlUFkB2qaU98iaQGY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1SQeOXnhfGfutt2hfkprzv+ZNbZH9L46leMXhi2nNOH14vD7dWWq4YRhHgEG6xDRf
	 Tv1ssZHYUQrn7BQax9GtXQbVwVogzW54aLomuciXgcvAtg30STS7/n0/o8KZWxi1ZB
	 Z1imJzm96SxwvSb1EtlBTYnNpTY5VPRidHfajqJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfHTMy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:54:59 -0400
Received: from mail-wr1-f99.google.com ([209.85.221.99]:43000 "EHLO
        mail-wr1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbfHTMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:54:58 -0400
Received: by mail-wr1-f99.google.com with SMTP id b16so12282166wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=OOt4IqCTKjc4kL7SLf/udmDIHzSd6i//mvrhfYwtNus=;
        b=pqhmEM23CD6o+rwLwj08/Nm8hvygi18NFTxkDMbYsWMw7FD9XeRDzEIdh/q4lsL/C8
         DIkUQVO4Mhh8qLmWCDEMpjNFrPRInrJY4z72Fd+T2JOT1zniUl7PpxxI1UCj4l4rSTaa
         vYKZeNcXx2UkOLgR/nZReT0jGgiwcjvy0+wU+8qdhdOC79SnwX7OmW5SooWNX4rsXhLD
         LuEbiwaNUpPHQNdB5b8G2sS1HUFGaQFrxQSwuW2t/I/QzCdWGvLgFriQiNHtA9VAWSKT
         D2sZlR5Ud4H+BCVZOyxRJDYIue8tpyMLmgSAF6YUz99Te8kH6N6uDaBpYyk3MksD/GyR
         NuTA==
X-Gm-Message-State: APjAAAURdPNcG+/VrBoKbpHGqFROAWbWD4i0R/32XQ7ZprSbClPhE711
        2AGrpfQW2hYZHHufDpeNr8jydmINGi5Wf+Kz7nVOAyUf5y52ODYG/SbjPZ+tyqJ0/w==
X-Google-Smtp-Source: APXvYqzE8OuONFaCn4iaMvy5NR3jibFQ56MCWMLu1F8nQR1KcJNG2lQEbBekp1lfPUIy731ekEybfMDnk8pt
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr8437925wrs.23.1566305695604;
        Tue, 20 Aug 2019 05:54:55 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id c1sm324295wrn.65.2019.08.20.05.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:54:55 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03f5-0002Dl-2Y; Tue, 20 Aug 2019 12:54:55 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 23AD32742ABD; Tue, 20 Aug 2019 13:54:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     alsa-devel@alsa-project.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Applied "ASoC: uniphier: Fix double reset assersion when transitioning to suspend state" to the asoc tree
In-Reply-To: <1566281764-14059-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820125454.23AD32742ABD@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 13:54:54 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: Fix double reset assersion when transitioning to suspend state

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From c372a35550c8d60f673b20210eea58a06d6d38cb Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 20 Aug 2019 15:16:04 +0900
Subject: [PATCH] ASoC: uniphier: Fix double reset assersion when transitioning
 to suspend state

When transitioning to supend state, uniphier_aio_dai_suspend() is called
and asserts reset lines and disables clocks.

However, if there are two or more DAIs, uniphier_aio_dai_suspend() are
called multiple times, and double reset assersion will cause.

This patch defines the counter that has the number of DAIs at first, and
whenever uniphier_aio_dai_suspend() are called, it decrements the
counter. And only if the counter is zero, it asserts reset lines and
disables clocks.

In the same way, uniphier_aio_dai_resume() are called, it increments the
counter after deasserting reset lines and enabling clocks.

Fixes: 139a34200233 ("ASoC: uniphier: add support for UniPhier AIO CPU DAI driver")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1566281764-14059-1-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-cpu.c | 31 +++++++++++++++++++++----------
 sound/soc/uniphier/aio.h     |  1 +
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index ee90e6c3937c..2ae582a99b63 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -424,8 +424,11 @@ int uniphier_aio_dai_suspend(struct snd_soc_dai *dai)
 {
 	struct uniphier_aio *aio = uniphier_priv(dai);
 
-	reset_control_assert(aio->chip->rst);
-	clk_disable_unprepare(aio->chip->clk);
+	aio->chip->num_wup_aios--;
+	if (!aio->chip->num_wup_aios) {
+		reset_control_assert(aio->chip->rst);
+		clk_disable_unprepare(aio->chip->clk);
+	}
 
 	return 0;
 }
@@ -439,13 +442,15 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 	if (!aio->chip->active)
 		return 0;
 
-	ret = clk_prepare_enable(aio->chip->clk);
-	if (ret)
-		return ret;
+	if (!aio->chip->num_wup_aios) {
+		ret = clk_prepare_enable(aio->chip->clk);
+		if (ret)
+			return ret;
 
-	ret = reset_control_deassert(aio->chip->rst);
-	if (ret)
-		goto err_out_clock;
+		ret = reset_control_deassert(aio->chip->rst);
+		if (ret)
+			goto err_out_clock;
+	}
 
 	aio_iecout_set_enable(aio->chip, true);
 	aio_chip_init(aio->chip);
@@ -458,7 +463,7 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 
 		ret = aio_init(sub);
 		if (ret)
-			goto err_out_clock;
+			goto err_out_reset;
 
 		if (!sub->setting)
 			continue;
@@ -466,11 +471,16 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 		aio_port_reset(sub);
 		aio_src_reset(sub);
 	}
+	aio->chip->num_wup_aios++;
 
 	return 0;
 
+err_out_reset:
+	if (!aio->chip->num_wup_aios)
+		reset_control_assert(aio->chip->rst);
 err_out_clock:
-	clk_disable_unprepare(aio->chip->clk);
+	if (!aio->chip->num_wup_aios)
+		clk_disable_unprepare(aio->chip->clk);
 
 	return ret;
 }
@@ -619,6 +629,7 @@ int uniphier_aio_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->rst);
 
 	chip->num_aios = chip->chip_spec->num_dais;
+	chip->num_wup_aios = chip->num_aios;
 	chip->aios = devm_kcalloc(dev,
 				  chip->num_aios, sizeof(struct uniphier_aio),
 				  GFP_KERNEL);
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index ca6ccbae0ee8..a7ff7e556429 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -285,6 +285,7 @@ struct uniphier_aio_chip {
 
 	struct uniphier_aio *aios;
 	int num_aios;
+	int num_wup_aios;
 	struct uniphier_aio_pll *plls;
 	int num_plls;
 
-- 
2.20.1

