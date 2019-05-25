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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2157BC28CBF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6AE20862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHLkAWb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfEYQXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:23:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34328 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfEYQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:23:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so12827877wrt.1;
        Sat, 25 May 2019 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5uUaYKFKqVciIG3lVseFyzbyz6GKlPhTPtvbtba51oA=;
        b=bHLkAWb9RfaNiXMj3sBfSi6dpURjsbFlzSAaDE8K334xT29EiBpmbLYA0Gk6IdaNIb
         2mZY4BDMqGmHswFGwX20J00imoNKgA8vT1DSgaJR437fnNk6ylUGk6Zm7+Yp2ih11lDm
         vbHzXF7kJFN6bEXymy0y1E3n/OU+uW9HJTHTFeahfVhQeYY5QVo4o9+M6yY0n71WdKfV
         b9BtKnuVccwPam5ipRCVE7iP0vV8f/cOEGMjjNVIOH5/FckfXzpBxNcPKNV/MBHWOs6K
         ZBxdukjjSbTsNYLW5IDaUvM1BDTjNL8l9/QPT3cg8xtaUpQxOPG7zjKdk7GIeW6Mf7hj
         /FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5uUaYKFKqVciIG3lVseFyzbyz6GKlPhTPtvbtba51oA=;
        b=k82GuDoBqnEJleXaZJZG9u4BUmQbGFG4f/+HMhdiuAO5gOZJOo///0QXEGrzGo51cF
         n+UnBRmpLt9g1J0Uroy6xh4gEVP5zseqxwqK8wOPFk/G6i4K3E6eLt3x8wGun7AVOctI
         K3D9YBfpbal3Yf1aaUP48V+R8AOZpsWxpPSI8C9kq1QrlaIWhMiSp3I6HPoU4zbTVHkD
         ASGVuS1uxhFLy5QKvUjmWUNE/4GxN6ctMZQiCTj+appsgO9Hpu3Qff4XvS9ecxn8mF9E
         sXL9OsfXFTcPHmSPRyjXsis4xwnU7HflXbH0kaB9uE4qzoMhj+/vNgUzUKkNZ4aySsTU
         jLYQ==
X-Gm-Message-State: APjAAAVR8esFGD1BSB5dydQEWAoWPUlr3nhcH/f3+znmCEsBvD4eLhBP
        J5vXaTxuEstjnved9PwQJ9g=
X-Google-Smtp-Source: APXvYqwkPqO3mn4ga/iil/wlxyKMkJ5pDpNfzOJHHLu+QPgmwmExfzMvPXSHTN8LXOo1cqiuCvs5UA==
X-Received: by 2002:a05:6000:1c6:: with SMTP id t6mr18063975wrx.236.1558801415765;
        Sat, 25 May 2019 09:23:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id k184sm13194409wmk.0.2019.05.25.09.23.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 09:23:35 -0700 (PDT)
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
Subject: [PATCH v3 4/7] ASoC: sun4i-spdif: Add support for H6 SoC
Date:   Sat, 25 May 2019 18:23:20 +0200
Message-Id: <20190525162323.20216-5-peron.clem@gmail.com>
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

Allwinner H6 has a different mapping for the fifo register controller.

Actually only the fifo TX bit is used in the drivers.

Use the freshly introduced quirks to make this drivers compatible with
the Allwinner H6.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 8317bbee0712..86bf6a99703f 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -75,6 +75,18 @@
 	#define SUN4I_SPDIF_FCTL_RXOM(v)		((v) << 0)
 	#define SUN4I_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
 
+#define SUN50I_H6_SPDIF_FCTL (0x14)
+	#define SUN50I_H6_SPDIF_FCTL_HUB_EN		BIT(31)
+	#define SUN50I_H6_SPDIF_FCTL_FTX		BIT(30)
+	#define SUN50I_H6_SPDIF_FCTL_FRX		BIT(29)
+	#define SUN50I_H6_SPDIF_FCTL_TXTL(v)		((v) << 12)
+	#define SUN50I_H6_SPDIF_FCTL_TXTL_MASK		GENMASK(19, 12)
+	#define SUN50I_H6_SPDIF_FCTL_RXTL(v)		((v) << 4)
+	#define SUN50I_H6_SPDIF_FCTL_RXTL_MASK		GENMASK(10, 4)
+	#define SUN50I_H6_SPDIF_FCTL_TXIM		BIT(2)
+	#define SUN50I_H6_SPDIF_FCTL_RXOM(v)		((v) << 0)
+	#define SUN50I_H6_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
+
 #define SUN4I_SPDIF_FSTA	(0x18)
 	#define SUN4I_SPDIF_FSTA_TXE			BIT(14)
 	#define SUN4I_SPDIF_FSTA_TXECNTSHT		(8)
@@ -438,6 +450,12 @@ static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks = {
 	.has_reset	= true,
 };
 
+static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks = {
+	.reg_dac_txdata = SUN8I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN50I_H6_SPDIF_FCTL_FTX,
+	.has_reset      = true,
+};
+
 static const struct of_device_id sun4i_spdif_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-spdif",
@@ -451,6 +469,10 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
 		.compatible = "allwinner,sun8i-h3-spdif",
 		.data = &sun8i_h3_spdif_quirks,
 	},
+	{
+		.compatible = "allwinner,sun50i-h6-spdif",
+		.data = &sun50i_h6_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
-- 
2.20.1

