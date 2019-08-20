Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B334EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827FB22DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566306867;
	bh=WX8SYzOKfj8Y410Nu+KbECJUJCHYCgaNqFFZooWkBzk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PgYIUelpRFEwu7k4F/iT3QYJOAAXe7PPRtFeZV/ZnbIxysiTVJIYv/ZTV0sdjwxjk
	 OLGxC7Lw7ZGduydMutHjF26fRVMAW0hul0VLJ6tDAZY0mvxhfeUMAHIxv+C0RS0k/W
	 W3FwDjCE7rrvdlK8De2DY6JNgBe2K4+cfYqnn5P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfHTNO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:14:26 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:39539 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfHTNOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:14:23 -0400
Received: by mail-wm1-f97.google.com with SMTP id i63so2604346wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=cXZ1tHQdDxSofQjcKdrjJTywasB4IlhStZwyyxo9TFM=;
        b=nn1Oqse/IuJFROUTHuKn4QVXm8r7/2sQkXQ3JrKQm9/JusQmQkwnfiB6Ar7tV2yk1s
         rwvNzkkF6YbdR31Xrdyae17rGA8I15/4k8Nb0PXPasDstf/Ox0L7qoiKCj01ybHQxWXG
         tCBGaJa8UAfClUdVqyrIcDbOiLvTutiMCYpHQT0Avl2HE9773slqGloNlhLKyMuGCS5N
         4eMCKr7CbJBdCeUkACZTDRLDqLhlr9e9CzFSvKk8cyAKdr5IhA4CW+qJlbazc5RdMHs4
         sWwJQB2GcPFj2eIQmKYDWPSaOX8BUBJg1Vh/IWkDOT8TPq6HwtqmcTjh0M0nz/jx8h+g
         +qaA==
X-Gm-Message-State: APjAAAVhujoiUNp7YXfDHPyANqTvHEKBxQjCASdkKvtdDDDxuVe7jt1a
        LudTUr9yJABsIVjbYK1+JSpz/VyKYPx2imo25Lpb3Hkdvk0DmESPFEj37e2vpCTfxQ==
X-Google-Smtp-Source: APXvYqxbIWlIIY6vy6Hz/M5p3K6g8eUuS/jQgXheRopkkCtxO9zXJuYdqyXbbvWI7Lk8cz3eUMoOjQivwHMY
X-Received: by 2002:a1c:be15:: with SMTP id o21mr25428618wmf.140.1566306861563;
        Tue, 20 Aug 2019 06:14:21 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id j11sm372426wrb.64.2019.08.20.06.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:21 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03xt-0002LW-7M; Tue, 20 Aug 2019 13:14:21 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8F31F274314E; Tue, 20 Aug 2019 14:14:20 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-tdm-formatter: free reset on device removal" to the asoc tree
In-Reply-To: <20190820123413.22249-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131420.8F31F274314E@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:20 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-tdm-formatter: free reset on device removal

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

From 18dd62ae3bc31baa0473e4a09e46c02e0bdc57a0 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 20 Aug 2019 14:34:13 +0200
Subject: [PATCH] ASoC: meson: axg-tdm-formatter: free reset on device removal

Use the devm variant to get the formatter reset so it is properly freed
on device removal

Fixes: 751bd5db5260 ("ASoC: meson: axg-tdm-formatter: add reset")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190820123413.22249-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdm-formatter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 2e498201139f..1a0bf9d3836d 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -327,7 +327,7 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	}
 
 	/* Formatter dedicated reset line */
-	formatter->reset = reset_control_get_optional_exclusive(dev, NULL);
+	formatter->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(formatter->reset)) {
 		ret = PTR_ERR(formatter->reset);
 		if (ret != -EPROBE_DEFER)
-- 
2.20.1

