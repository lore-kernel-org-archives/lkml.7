Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBB0C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CED206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="auDUl3sS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfETToU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:44:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55840 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfETToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:44:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so533468wmb.5;
        Mon, 20 May 2019 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NNG/0jX2tQvBjgyfc63hvEhbSuCoeNSX6UlPy2BEBSQ=;
        b=auDUl3sSdVbyOeXw5DD5WCYPTNmu1dlib8WeEvITLoBql3UtvBxuvw2y6JUCJzN3QM
         wVWo6tRt3Q0Qz9i5sdcZ/vnWa6Zylat8exT2pL2yu7565j4oFvXbZ4M8P/5D3j8WApgK
         2Yb8qJpl9q50Lin7/XMdYrA8+1+GoICQ2Sm0SVzujLBe2lSN5Nn/pmjo29WFINL7NB4q
         +wKrXaqlE0bEu1I1N/jGeoptuAo+uanT+2OkHuVMHsMorjo5161LG81FBVdgiFkOW5bo
         Jd7mDml8ngE8uur5Ul0bnpw1c5lo4JXbPFqzR5Hxa7vciJFVBfrBcUWHWFuwrF3MBaS9
         Ci6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNG/0jX2tQvBjgyfc63hvEhbSuCoeNSX6UlPy2BEBSQ=;
        b=dfbYygKcp9h4qYuwD0wJAvB1Ma7TYPwju/pxdlxe5UqJMVkcktZeova5Mnj9UQa1Er
         OJ5uB9LvbuNjkAYFHkT6EtoNd4/mwLBVTEj/KPLPF6+j9Qjhe+gaNZabCskI78qJjUdr
         0DYasmdq+Sr465rTP2tbaWFODycUsFho77jfi7ZR03aalcqQwe46MZpBSPvx2NFxE+zH
         m1zX1bV95D3nyjnyoz5AlVcWVb98tdAJXSBlIplsC+6839jUP/BJ9hQXs3QcKO0jgDB7
         xuYFOu0ATDMvMcV38px9c2vBqfiXp2CxXFLgmTkxQihbePdIa+gT/sq9AoK6XsntKYx+
         4bNg==
X-Gm-Message-State: APjAAAUkl3j74s3XZXoOR2uznJQdxoYpavzmb4B/TsWTGOD5bnVHf5HE
        Vw82SzSwNiPhNPqbPdWbjzA=
X-Google-Smtp-Source: APXvYqxBL083Bt88/sIpYQeNID/JQmp32Qn9K//NrQQJwjMErFkLuDlMgEaBWN4mSwUuH3Ajk3gpWQ==
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr644485wmc.12.1558381445895;
        Mon, 20 May 2019 12:44:05 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id p8sm9135352wro.0.2019.05.20.12.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:44:05 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        mjourdan@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/5] soc: amlogic: canvas: add support for Meson8, Meson8b and Meson8m2
Date:   Mon, 20 May 2019 21:43:50 +0200
Message-Id: <20190520194353.24445-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
References: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The canvas IP on Meson8, Meson8b and Meson8m2 is mostly identical to the
one on GXBB and newer. The only known difference so far is that that the
"endianness" bits are not supported on Meson8m2 and earlier.

Add new compatible strings and a check in meson_canvas_config() to
validate that the endianness bits cannot be configured on the 32-bit
SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/soc/amlogic/meson-canvas.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
index be95a37c3fec..c655f5f92b12 100644
--- a/drivers/soc/amlogic/meson-canvas.c
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -35,6 +35,7 @@ struct meson_canvas {
 	void __iomem *reg_base;
 	spinlock_t lock; /* canvas device lock */
 	u8 used[NUM_CANVAS];
+	bool supports_endianness;
 };
 
 static void canvas_write(struct meson_canvas *canvas, u32 reg, u32 val)
@@ -86,6 +87,12 @@ int meson_canvas_config(struct meson_canvas *canvas, u8 canvas_index,
 {
 	unsigned long flags;
 
+	if (endian && !canvas->supports_endianness) {
+		dev_err(canvas->dev,
+			"Endianness is not supported on this SoC\n");
+		return -EINVAL;
+	}
+
 	spin_lock_irqsave(&canvas->lock, flags);
 	if (!canvas->used[canvas_index]) {
 		dev_err(canvas->dev,
@@ -172,6 +179,8 @@ static int meson_canvas_probe(struct platform_device *pdev)
 	if (IS_ERR(canvas->reg_base))
 		return PTR_ERR(canvas->reg_base);
 
+	canvas->supports_endianness = of_device_get_match_data(dev);
+
 	canvas->dev = dev;
 	spin_lock_init(&canvas->lock);
 	dev_set_drvdata(dev, canvas);
@@ -180,7 +189,10 @@ static int meson_canvas_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id canvas_dt_match[] = {
-	{ .compatible = "amlogic,canvas" },
+	{ .compatible = "amlogic,meson8-canvas", .data = (void *)false, },
+	{ .compatible = "amlogic,meson8b-canvas", .data = (void *)false, },
+	{ .compatible = "amlogic,meson8m2-canvas", .data = (void *)false, },
+	{ .compatible = "amlogic,canvas", .data = (void *)true, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, canvas_dt_match);
-- 
2.21.0

