Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E524AC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC2120657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kz7mySpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfFGOg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:36:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43190 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbfFGOgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:36:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id r18so2399169wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIRxpsMoY3xfY+o4Dg8OGtpln2zFz/QoSQ1BbOA5d+M=;
        b=kz7mySpc/RfdxVdkBQIYBkCWZMf8J3Og77Hoxh7p5O6+zgLmVsYzLm7DipWdAe3DuJ
         o/KJNHuFuImq4fp7mbIYnBI507eBLQf1psgW1UQa2jT17TTYteWuBqxiIO1yapVdgFje
         E8mqlAnV2O2ZeVVc2va+OxN1JLKMDAXRXaFEOVZ6yh+KiEKpuYMpwimq7MjwKQMMkf9j
         4+1nF1o8ZcycaP49aLc/rX5WPUovWcC+RvzZtD2TaYOhwcqaV6Ot9dHEp8Zj4JeNRlCG
         9xX8SHNsFnWiYHozpDV1mXIhQxoCUIld4PS2jTK/3+mamedw0YnaFUQkKzc0vh3OoBYD
         0brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yIRxpsMoY3xfY+o4Dg8OGtpln2zFz/QoSQ1BbOA5d+M=;
        b=EJTWY6tU1m+tUpQEc+2Td27IZOXCni6rLWTAPqWO1x+dfC3ukAUYXwTwYh8gP89uEt
         HsON1sHlKU2aTywwdowEpNvxd32ltn5dH0AmrV7CDKKUluHyX7L0Pv95SITCB7R2lbyG
         2K8xiTuDyEEFTYP/VatBtQ6eCEl4Zhm7ZYZd7UllWfAzv5SqtNGyah0X8k6WoRrZLDh3
         Gn/FNt31XT/+m/QzgDiRGBOREWPZAFe6sXeE46jyPEUTXjGn38DaMKlKPZLwgx+eN+gb
         AlLa1aCBIZ59zteoO+2UNRsxfoVX8EZhir5SEcDLSz9DMAlqNQ0T9LyIFwm2SEXI6qvv
         gsjQ==
X-Gm-Message-State: APjAAAVcqyvPYzLIMFupGkv9PBXZOJs7P+cX14yUz5JAcdSGzK0frhQh
        te/W020gVZ5Mrl5EtGXOFoSR7g==
X-Google-Smtp-Source: APXvYqxA6g/fwxm6qy/SKZY+pPoIKIGaOBpCG937P/3hBCQn2OsjvKVjainHghklDxT+45l3Inz2CQ==
X-Received: by 2002:adf:ee4a:: with SMTP id w10mr22558075wro.311.1559918183223;
        Fri, 07 Jun 2019 07:36:23 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t63sm2999829wmt.6.2019.06.07.07.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 07:36:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/4] arm64: dts: meson-g12a-sei510: add 32k clock to bluetooth node
Date:   Fri,  7 Jun 2019 16:36:15 +0200
Message-Id: <20190607143618.32213-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607143618.32213-1-narmstrong@baylibre.com>
References: <20190607143618.32213-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32k low power clock is necessary for the bluetooth part of the
combo module to initialize correctly, simply add the same clock we
use for the sdio pwrseq.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index eac57d997e0b..3e0e119c13ce 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -530,6 +530,8 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 		vbat-supply = <&vddao_3v3>;
 		vddio-supply = <&vddio_ao1v8>;
 	};
-- 
2.21.0

