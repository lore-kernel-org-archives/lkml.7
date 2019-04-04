Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC07CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC0020855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uWRc+fU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfDDLSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:18:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54626 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbfDDLR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:17:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so2558056wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Vn9RR550Eyl4ELYsr1mmHgCuBIbCpOqQ6bfLv4sARg=;
        b=uWRc+fU0O+nKHBDEQJJXZ7Z2j7snQLXa/BT8codA7325VHzO8/xA/fSJHg2ARzNjtb
         sDQrVIfah0PZxPEavE4ijLEa12EnW7HzSY1MER2Ey8l1qtZVnwIHbVZuFiK5zxAZRoao
         DiBgtqs07mEyREAAd4ip1Ixy5fNWyhexonV5VEPCfOfhj/emGycOHa1kGym4ppaIk7FF
         ju/44J11q9bIq6xFUh1QMaBcp1V6Ql2U2j/rA+5uY5Ta2bIOBJ7Jco9Dr5Ly1TeLaFzF
         Uo5HPCCGTjhERrzBEU0ocbptHeOMQ/OPdWeALZZg8ZYI2JfpzusG6VVDFfYls2O5JEQb
         vUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Vn9RR550Eyl4ELYsr1mmHgCuBIbCpOqQ6bfLv4sARg=;
        b=D0SI4VSbtgU+EJk1ydkUFL/+pDBEAGTltFxP5RUsWYJ18lMyKS8WnwKXlmSQCjyng9
         vEwIJGIFT1iFkNvn76Lv4QIOWmnjIyPYiUEg2KC4zWPLEoree4OCFIEwuXLjk1kRjL01
         a/9Xao3Q1LAgrgFLgPle0XJbe6Lke6OOScR3VPomNRc74dlbkkoWbkbYP3IwQYdHAVRu
         M796lmRI5b9VtGIL+MOeDqa87iMmerUzGG91+5lLZje59UKY3RUu6GigO+BzJkNwm6+r
         itP/cMuUD2PRkHHRFaiMff/TfJq8g14EXZ+CgiFpoVQ3bDrHu9EHTYj8SEAR1V/9Oba8
         r+xw==
X-Gm-Message-State: APjAAAWwrXB1tXyG9TyfYMjqtP73ZZn+HARvKbRf2NT8t38OO2pdtNfz
        3CpgcqKHwwOadIXj8efv09Mrqg==
X-Google-Smtp-Source: APXvYqz1ZAXalx43MSQ/mSwlII9JoTKJQx4QnyxFvl27QsSvAlkGdELj6N9F7OAQA6rSrCzd3iZ4hw==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr3611271wml.34.1554376674104;
        Thu, 04 Apr 2019 04:17:54 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id z23sm9024771wma.0.2019.04.04.04.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 04:17:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 6/6] ASoC: meson: axg-tdmout: add g12a support
Date:   Thu,  4 Apr 2019 13:17:33 +0200
Message-Id: <20190404111733.28705-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404111733.28705-1-jbrunet@baylibre.com>
References: <20190404111733.28705-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The axg tdmout driver just need a different skew offset to operate
correctly on the g12a SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdmout.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/meson/axg-tdmout.c b/sound/soc/meson/axg-tdmout.c
index 3984818e2a7c..527bfc4487e0 100644
--- a/sound/soc/meson/axg-tdmout.c
+++ b/sound/soc/meson/axg-tdmout.c
@@ -243,10 +243,23 @@ static const struct axg_tdm_formatter_driver axg_tdmout_drv = {
 	},
 };
 
+static const struct axg_tdm_formatter_driver g12a_tdmout_drv = {
+	.component_drv	= &axg_tdmout_component_drv,
+	.regmap_cfg	= &axg_tdmout_regmap_cfg,
+	.ops		= &axg_tdmout_ops,
+	.quirks		= &(const struct axg_tdm_formatter_hw) {
+		.invert_sclk = true,
+		.skew_offset = 2,
+	},
+};
+
 static const struct of_device_id axg_tdmout_of_match[] = {
 	{
 		.compatible = "amlogic,axg-tdmout",
 		.data = &axg_tdmout_drv,
+	}, {
+		.compatible = "amlogic,g12a-tdmout",
+		.data = &g12a_tdmout_drv,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_tdmout_of_match);
-- 
2.20.1

