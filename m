Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0FCC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B15218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BWYV3U42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfGCMH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:07:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54669 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:07:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so1938665wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nDWpJDfpOQfXawVusespJk2SyBgud3JYRZ5ZXC0wU4=;
        b=BWYV3U428Gc8QR7aKZY4nWtDDgoYNuQo2A3i0xocI7A1OdX/bXOHlzZbpoM9HpZmu5
         w2eYh3sthQswiY9VQBzBrJA/+2OlKshkF9G/8p28Jf9knhlhOXiQd6jE/8WJgbvP5mzO
         8jyDCL1dq/c999yNYGKrDCJssPk/zSlvY4AQrzN68K3tX50+QFWAfb6I+LneNIxK1CVp
         75CXk6f1JvxnxN6ria/lK5C9QmHE3C1pGG2a+/8V7UjhZ7VtfjD2HVJp8v3+ICLd3189
         6Ocyz1v/BB5Zms/+78h+0r1N4ckL3eh/r0S3CTS9XS8F6LUiDwoZSOUpilo/CwiEA7JP
         C7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nDWpJDfpOQfXawVusespJk2SyBgud3JYRZ5ZXC0wU4=;
        b=DUJkRJBjDHuCvTNav/SVpmDpNrsErd+cn6sN3C1dtqFNSxW/tV81zrI0KtJPjDFDmw
         0dfcx5AOsm5ec5La/MgTtC4+4K9df+uwKvPAB0aOxsyzb+B4MvJ8GEw6JhuGKO/+9hqt
         2zau1/LYr+HIv9yyBC+v6UgJ0sxB0Mm7gZ5JUCYe1e9wCBDLjlcITMtHrDvBiDUUNAzr
         DVQBVFUCQ/lk0ZT9KVZO0IRW4lkTYdBAv2yNlOXWtmAiJ5iQ6jyK7L6uVMk7NzZyg2ZA
         spzd3D2wmcJWKTH5oUZkXtse1lmXvwfxFqQRG7die1UKcLJ2paaX93Z7V5C7Rr54QD2S
         NATw==
X-Gm-Message-State: APjAAAVzX0ycsgtbKFRyPXAmVUpoEahmyN2BP9avjm9jjX7lzFuFsLji
        VjjLryCr86s5ud5VvABYJXOCkQ==
X-Google-Smtp-Source: APXvYqzol6Ot5n5vTIYz4kULwGeZdgCKUF/deXcHiE+/rQ3Rb/Lb4EzxU0wc9AZz6JzdmHnS4EQ/7g==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr8190423wma.100.1562155674760;
        Wed, 03 Jul 2019 05:07:54 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z126sm2767638wmb.32.2019.07.03.05.07.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 05:07:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 1/2] ASoC: meson: axg-tdm-formatter: add reset to the bindings documentation
Date:   Wed,  3 Jul 2019 14:07:48 +0200
Message-Id: <20190703120749.32341-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703120749.32341-1-jbrunet@baylibre.com>
References: <20190703120749.32341-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional reset property to the tdm formatter bindings. The
dedicated reset line is present on some SoC families, such as the g12a.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-tdm-formatters.txt           | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
index 3b94a715a0b9..8835a43edfbb 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
@@ -15,11 +15,15 @@ Required properties:
   * "lrclk"    : sample clock
   * "lrclk_sel": sample clock input multiplexer
 
-Example of TDMOUT_A on the A113 SoC:
+Optional property:
+- resets: phandle to the dedicated reset line of the tdm formatter.
+
+Example of TDMOUT_A on the S905X2 SoC:
 
 tdmout_a: audio-controller@500 {
 	compatible = "amlogic,axg-tdmout";
 	reg = <0x0 0x500 0x0 0x40>;
+	resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
 	clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
 		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
 		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
-- 
2.21.0

