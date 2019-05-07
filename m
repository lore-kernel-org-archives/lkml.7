Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB121C46460
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC636206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZWz8Ne1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEGL5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:57:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39973 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfEGL5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:57:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so2666302wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1rHCx6L3GXgpLSY85OBaF3yHPOjpl8Cwfh6FO8D2O4I=;
        b=ZWz8Ne1bpYs9dwxkTuB7UuqVVop0CvuA6m7QtVT8rMJydQmuiN0iEFu30bYGtnRZgb
         OxZ4kIt8i2PKuPs97ocwBqQ8mVNGjIeGHXBa26X2PmmNBwAb2nNldL2uigf76+mGp/YG
         JG5I10GW7ZDutGdJxdpPyrKdtUu7/j30CY0DOJANXkwvWuXHY2IxNuMDfbx3YHZqos61
         GqtHRvNESm0D1M7y6CxMxZAvz+Sa1eoHoRNrJ2GvXw2XFETwLM8mDBM5JdHPptLe3MfJ
         ah9zKSzhIlaybeaXTlWJOSf89aZpRVftDNiLERlgJzO91gkEloeXdZiydTfoC5PNVEtQ
         TM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1rHCx6L3GXgpLSY85OBaF3yHPOjpl8Cwfh6FO8D2O4I=;
        b=RXWzwRAH7o2puUSWjW2BUu7wKXEahfCxSoKjJ95ymFw2hySmUuGCGbYXWxdpfD9zRI
         dAnPvYjfuxGgU7MeTl96JBUbzpIGfJ/rm5Y3CLaK4a+ZBLBSNTq7afwy5Aq3Nj5or4HG
         gVqDwy7OOvQ7Cs9GSXkMUpFTnFn/wmo9DQ24VpQt2SIFv9YoCrt9SjOAaUEpISaJ62gi
         mIrUeLydcO+InGaNTwI0uWOb4JeM9KvCBx12SgXR3fy3aChrSJ8iPUMJZ2eTrDHg/qXP
         lsyW1gJ1Cg1xMsi+pLYaN+X+QFQHD7+/wApZegL4VAdawiAvMM+4mBg73JRX9H17uvz0
         jIEw==
X-Gm-Message-State: APjAAAVbbMFGlQA3DWTcqijvHWT5UpDaV7OIvdhw3NsyAF6OeeyJoUv7
        cMMhGGxyyIPS+/zXU3uuMjiqGQ==
X-Google-Smtp-Source: APXvYqxtuwhQYKKyA7f4ToySm0WEeeU5OY1VRRVJPndZ8+M+fJBt3j4+IzmJcv5g2FbvKSe8xYt5VQ==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr8778721wrw.152.1557230254753;
        Tue, 07 May 2019 04:57:34 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s11sm7120274wrb.71.2019.05.07.04.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 04:57:34 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] pinctrl: meson: g12a: add DS bank value
Date:   Tue,  7 May 2019 13:57:26 +0200
Message-Id: <20190507115726.23714-7-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507115726.23714-1-glaroque@baylibre.com>
References: <20190507115726.23714-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add drive-strength bank register and bit value for G12A SoC

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-g12a.c | 36 +++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index d494492e98e9..3475cd7bd2af 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -1304,28 +1304,28 @@ static struct meson_pmx_func meson_g12a_aobus_functions[] = {
 };
 
 static struct meson_bank meson_g12a_periphs_banks[] = {
-	/* name  first  last  irq  pullen  pull  dir  out  in */
-	BANK("Z",    GPIOZ_0,    GPIOZ_15, 12, 27,
-	     4,  0,  4,  0,  12,  0,  13, 0,  14, 0),
-	BANK("H",    GPIOH_0,    GPIOH_8, 28, 36,
-	     3,  0,  3,  0,  9,  0,  10,  0,  11,  0),
-	BANK("BOOT", BOOT_0,     BOOT_15,  37, 52,
-	     0,  0,  0,  0,  0, 0,  1, 0,  2, 0),
-	BANK("C",    GPIOC_0,    GPIOC_7,  53, 60,
-	     1,  0,  1,  0,  3, 0,  4, 0,  5, 0),
-	BANK("A",    GPIOA_0,    GPIOA_15,  61, 76,
-	     5,  0,  5,  0,  16,  0,  17,  0,  18,  0),
-	BANK("X",    GPIOX_0,    GPIOX_19,   77, 96,
-	     2,  0,  2,  0,  6,  0,  7,  0,  8,  0),
+	/* name  first  last  irq  pullen  pull  dir  out  in  ds */
+	BANK_DS("Z",    GPIOZ_0,    GPIOZ_15, 12, 27,
+		4,  0,  4,  0,  12,  0,  13, 0,  14, 0, 5, 0),
+	BANK_DS("H",    GPIOH_0,    GPIOH_8, 28, 36,
+		3,  0,  3,  0,  9,  0,  10,  0,  11,  0, 4, 0),
+	BANK_DS("BOOT", BOOT_0,     BOOT_15,  37, 52,
+		0,  0,  0,  0,  0, 0,  1, 0,  2, 0, 0, 0),
+	BANK_DS("C",    GPIOC_0,    GPIOC_7,  53, 60,
+		1,  0,  1,  0,  3, 0,  4, 0,  5, 0, 1, 0),
+	BANK_DS("A",    GPIOA_0,    GPIOA_15,  61, 76,
+		5,  0,  5,  0,  16,  0,  17,  0,  18,  0, 6, 0),
+	BANK_DS("X",    GPIOX_0,    GPIOX_19,   77, 96,
+		2,  0,  2,  0,  6,  0,  7,  0,  8,  0, 2, 0),
 };
 
 static struct meson_bank meson_g12a_aobus_banks[] = {
-	/* name  first  last  irq  pullen  pull  dir  out  in  */
-	BANK("AO",   GPIOAO_0,  GPIOAO_11,  0, 11,
-	     3,  0,  2, 0,  0,  0,  4, 0,  1,  0),
+	/* name  first  last  irq  pullen  pull  dir  out  in  ds */
+	BANK_DS("AO", GPIOAO_0, GPIOAO_11, 0, 11, 3, 0, 2, 0, 0, 0, 4, 0, 1, 0,
+		0, 0),
 	/* GPIOE actually located in the AO bank */
-	BANK("E",   GPIOE_0,  GPIOE_2,   97, 99,
-	     3,  16,  2, 16,  0,  16,  4, 16,  1,  16),
+	BANK_DS("E", GPIOE_0, GPIOE_2, 97, 99, 3, 16, 2, 16, 0, 16, 4, 16, 1,
+		16, 1, 0),
 };
 
 static struct meson_pmx_bank meson_g12a_periphs_pmx_banks[] = {
-- 
2.17.1

