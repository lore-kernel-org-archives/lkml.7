Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE07C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F0C217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrCzRXON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfEUQLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:11:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53058 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbfEUQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:11:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so3582377wmm.2;
        Tue, 21 May 2019 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcynCO3Bhnyyyh0AzkuL7DAz7yiCtTiW/mLXsFC4qdg=;
        b=YrCzRXON/0Vpkv9VFfnH6p1V3nggv/XRBoBPsx+/vqNSV/s+pu9R6XK+Hki1MeKXVW
         iOGxBpY077JEobnVKhTOfi+3VNke0nn8+CBJ+6RMQgVF13yL9mF58lbebM+srWUv5Ueg
         wtq1dzjsCXbsJC34G8ddp6z6u4O0ALYJbv0DY8YbsesAgEjukZJX+OV7OOF8M8/wXK9g
         +18b+uxQzEKtktq6PDkGvCDZQAyNx3bhgElXQN/NYDo821mt7JsqhHJ2tH1JJGKwc6V4
         ZnBBhOp7m8/U1xHIe+bNL1LXtKSr2t+xK+KGDrUju6zr127Tm3Ui+E56cxeDNrKttAPL
         2Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcynCO3Bhnyyyh0AzkuL7DAz7yiCtTiW/mLXsFC4qdg=;
        b=Vyp9aNZSqM2713pWP5CmyenFxQYoN4lsNuRTz9P8QlVqv5vxE9HZASya40TJZcaTDS
         BCSU0wR8i8m7TEWRISihlidT8/uaG8p0BIymIyJYRK1p3gcKCqtPFNkcaw2TfOgqyDzg
         C+rvOXHxWtUQCxhG2D4MRZ6jLjYP7fvQmh9y/qxbOHzANpGrvBeIHUwQbw74S7jPeMHY
         Jtezi0MAOuZh594EZJjFcVyS7VsdLO7NnYTJQqAz5ObW8WQRnDgoujKks7FQZO0I9zmr
         8K0uOyq/3UFw6nw1Je+qsLJusjNAFnslm43Cd9tQAX4mRCp8XCN5/eawvuGC0BLLf+FV
         83TA==
X-Gm-Message-State: APjAAAXez1EpXGeVvycfXk1cdQf2PoNrYQgvYkz5NBclB3kepxG62lDu
        4sHHn5DxE7MtFnll4NAfUeo=
X-Google-Smtp-Source: APXvYqynBK31B9gGuYlYbOmFDLrVXZyQ7MV/LPrhgtP4OE0MWCnSyrxl5VmWGWjgIOMTzPaP4WdGOw==
X-Received: by 2002:a7b:c76b:: with SMTP id x11mr4416026wmk.22.1558455069253;
        Tue, 21 May 2019 09:11:09 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id n63sm3891094wmn.38.2019.05.21.09.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 09:11:08 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 1/6] drm: panfrost: add optional bus_clock
Date:   Tue, 21 May 2019 18:10:57 +0200
Message-Id: <20190521161102.29620-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has an ARM Mali-T720 MP2 which required a bus_clock.

Add an optional bus_clock at the init of the panfrost driver.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 3b2bced1b015..ccb8eb2a518c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -55,11 +55,33 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 	if (err)
 		return err;
 
+	pfdev->bus_clock = devm_clk_get_optional(pfdev->dev, "bus");
+	if (IS_ERR(pfdev->bus_clock)) {
+		dev_err(pfdev->dev, "get bus_clock failed %ld\n",
+			PTR_ERR(pfdev->bus_clock));
+		return PTR_ERR(pfdev->bus_clock);
+	}
+
+	if (pfdev->bus_clock) {
+		rate = clk_get_rate(pfdev->bus_clock);
+		dev_info(pfdev->dev, "bus_clock rate = %lu\n", rate);
+
+		err = clk_prepare_enable(pfdev->bus_clock);
+		if (err)
+			goto disable_clock;
+	}
+
 	return 0;
+
+disable_clock:
+	clk_disable_unprepare(pfdev->clock);
+
+	return err;
 }
 
 static void panfrost_clk_fini(struct panfrost_device *pfdev)
 {
+	clk_disable_unprepare(pfdev->bus_clock);
 	clk_disable_unprepare(pfdev->clock);
 }
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 56f452dfb490..8074f221034b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -66,6 +66,7 @@ struct panfrost_device {
 
 	void __iomem *iomem;
 	struct clk *clock;
+	struct clk *bus_clock;
 	struct regulator *regulator;
 	struct reset_control *rstc;
 
-- 
2.17.1

