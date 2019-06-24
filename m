Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AA9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612AB20644
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f+kqTndK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfFXOtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:49:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51544 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfFXOtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:49:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so13110579wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:references:reply-to:message-id:mime-version;
        bh=+1HDQZviZEdEBIaZ3+cqb2NOlWyANG1RyMLvCgYrlxQ=;
        b=f+kqTndKvKQtaO3uX+rPt78/8vXst8PI3NwjdbB1DABotaFBkHQIV/ydAjoVPhg0Jv
         I2o7qcH/kgyDbaPjhUwHSYcYOQ1yhR2jAIoeV8Yj+hFpdXd7vJUlAja6IZmU2KHUwDqu
         tPvfg05GytpLRIkXHEmKbkwKSQ3Tx2d/zbi8yEa8QCRcQIUur0lj3GsxW+eizD1wdI3o
         dgLsliZhzNRKCBjgNgwmg6A3J5pXwmfgmB9aPfLtLodYBL+RQTEix6ezIZ67blO10OPx
         YJyEaUSR1/QcRZcvtvcARhuvkSCDUHz3S6/R9U5nEJ0ZfjHASF00lpJEOyf8O1YLLdTz
         weiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:reply-to
         :message-id:mime-version;
        bh=+1HDQZviZEdEBIaZ3+cqb2NOlWyANG1RyMLvCgYrlxQ=;
        b=mN6gTdIPgLqr7MntdUrWE8vHly61xNagVmLfGHf5AMVfkDJ524ryfU/7rQZ9kPA6Cf
         pw3v9GUb/+hdsTshRLQOD0KzkmlpFsY3pzcsshYxCdD9UnluuMj2iD6Wy7xrT4axWLr9
         8zaQo0KFjiX7bnBOfAU/ZgNIAbi8jw6+rRY5wLnfSSF0WLyAqj8YDre/jKHe2KNfDa4d
         7Nr2Mt3RS862jLswkCQeP/AVYkHDkN+c3jxeFXobSIIS7ZQfugg9eO4Pm3008O4HzxpB
         Hv0fpDv3QZp1ZrfESaDgFKXznuu7dC6Qj3/XaO7WNiiFI554nbZsE1sHaPXNjUiXloRf
         hTkQ==
X-Gm-Message-State: APjAAAWiTdep1nonPCR6LXBG4PZuGj3J64eXeW/aWu9odWZ24SeEOZgR
        FXQllfGI0yeB61jwhlbv2nS/rw==
X-Google-Smtp-Source: APXvYqyKFT1ZDPov7FN01BjdxpOOg83+Hng//XfE/Nmzv8hToft5RZH9KSY96c9YR1WZPkYlwxu+Iw==
X-Received: by 2002:a1c:343:: with SMTP id 64mr17222141wmd.116.1561387751980;
        Mon, 24 Jun 2019 07:49:11 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k82sm10654558wma.15.2019.06.24.07.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:49:11 -0700 (PDT)
From:   Julien Masson <jmasson@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: [PATCH 8/9] drm: meson: add macro used to enable HDMI PLL
Date:   Mon, 24 Jun 2019 16:49:04 +0200
References: <86zhm782g5.fsf@baylibre.com>
Reply-To: <86zhm782g5.fsf@baylibre.com>
Message-ID: <86o92n82e1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add new macro HHI_HDMI_PLL_CNTL_EN which is used to enable
HDMI PLL.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/gpu/drm/meson/meson_vclk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index e7c2b439d0f7..be6e152fc75a 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -96,6 +96,7 @@
 #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
 
 #define HHI_HDMI_PLL_CNTL	0x320 /* 0xc8 offset in data sheet */
+#define HHI_HDMI_PLL_CNTL_EN	BIT(30)
 #define HHI_HDMI_PLL_CNTL2	0x324 /* 0xc9 offset in data sheet */
 #define HHI_HDMI_PLL_CNTL3	0x328 /* 0xca offset in data sheet */
 #define HHI_HDMI_PLL_CNTL4	0x32C /* 0xcb offset in data sheet */
@@ -468,7 +469,7 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
 
 		/* Enable and unreset */
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
-				   0x7 << 28, 0x4 << 28);
+				   0x7 << 28, HHI_HDMI_PLL_CNTL_EN);
 
 		/* Poll for lock bit */
 		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL,
-- 
2.17.1

