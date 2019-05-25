Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36EDC282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7907720862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCL66DnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEYQXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:23:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39821 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfEYQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:23:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so7865190wma.4;
        Sat, 25 May 2019 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfqUAOYPvDzhcNc+tjW6jBBWsXQUQMy7ncklrPlMEZg=;
        b=aCL66DnQKCJFGF7Sny1qI110miKIWTxt7QW1iSoRit3Mo5jspnYicZoXoQfgUflTpn
         nL6BhP1dmM+LagcQyqPghQws4BzN0DNqSTXisfQSiQF26TeDElGIYaCOXH6Xy/5djSLp
         Aea8coHm1Qg3oR0BmfdgzqYXVNUie1jX/vbcAGGcwDR7J9AcFH5sDqjUJIZrOFrLuzb4
         u0bGKcTMGLWvkKx9WubIYANjkLlsgz++UOw3dQHpff9U/sp0W9OjFqUx7L54Pf6QfBZM
         9Ti/JJvL7T1GY8wbnAxFjY7+cbqxYzr+e1HZAwznhbu/sGK+bEIjL3I46nVozFwseSEk
         UaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfqUAOYPvDzhcNc+tjW6jBBWsXQUQMy7ncklrPlMEZg=;
        b=ciDLYkx3WY1xTvAgTT6I1vVVCs+w+4nkV+pEoilWC+vsWjO2Q3sYPmqNFXdW0KAncC
         i/b/H9v1kUhNZOV461nOhSeT/Na94Eu8FUPofQQ5lAGeaZz+QcAM9bQovryWq27zcm5G
         JJtGTWOKh69cEqMkvv8Zxjqs+dK4AaDdXvIRe6viXTh1nEmxp+L5BmcQz6JN4URJ2D2g
         BewQQFB1oDMhO35FakNPyNh3umGEn8kJtzHNLlQ/HoHRjtBtHRhXbZ4XKtMKlBp8EjrH
         RHbELAaiFtrhsJQQvVrj3d4qpy7gDhBCh3azf4HCV/D4Dj13scf4FG0c5sJQjcgu4xtd
         9v5A==
X-Gm-Message-State: APjAAAX0zBU7p/McbGCurQjPQ+kOrnO8H1p5frShBy3o9A/9mX3PUGc3
        gn4/Ey+BRe1b9Ha+IEHObTFzhHB0BIZPBg==
X-Google-Smtp-Source: APXvYqyXeydx+UFeVN5TqubaJQaFnJKueyJjEY/3Q6lja+t2vhfPzJbWHUyyD43HepFrNIoanUPkqw==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr3998765wma.147.1558801413382;
        Sat, 25 May 2019 09:23:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id k184sm13194409wmk.0.2019.05.25.09.23.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 09:23:32 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 2/7] ASoC: sun4i-spdif: Move quirks to the top
Date:   Sat, 25 May 2019 18:23:18 +0200
Message-Id: <20190525162323.20216-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525162323.20216-1-peron.clem@gmail.com>
References: <20190525162323.20216-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quirks are actually defines in the middle of the file with
short explanation.

Move this at the top and add a section to have coherency with
sun4i-i2s.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index b4af4aabead1..b6c66a62e915 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -161,6 +161,17 @@
 #define SUN4I_SPDIF_SAMFREQ_176_4KHZ		0xc
 #define SUN4I_SPDIF_SAMFREQ_192KHZ		0xe
 
+/**
+ * struct sun4i_spdif_quirks - Differences between SoC variants.
+ *
+ * @reg_dac_tx_data: TX FIFO offset for DMA config.
+ * @has_reset: SoC needs reset deasserted.
+ */
+struct sun4i_spdif_quirks {
+	unsigned int reg_dac_txdata;
+	bool has_reset;
+};
+
 struct sun4i_spdif_dev {
 	struct platform_device *pdev;
 	struct clk *spdif_clk;
@@ -405,11 +416,6 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 	.name = "spdif",
 };
 
-struct sun4i_spdif_quirks {
-	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
-	bool has_reset;
-};
-
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
 };
-- 
2.20.1

