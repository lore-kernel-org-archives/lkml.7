Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB2CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879112070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wQB2iOYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfCRKFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38858 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfCRKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so16296562wrm.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWvS9QxnFmdXHeokNJBgpYlCnjX8I5tKgKMXO5N+5pU=;
        b=wQB2iOYsrdwO3a7AdPyp8JrnfiSSUF22RMHTYOCjS9tyK07DzXX6IASMrqYXnrQNVy
         3X9LHor2cknXREwQ24Wt1qqE54PE2AWieema41QBqGJaWoc3kLxSS6h0Gy3EOVMtw3kV
         JN5wrp23jHI/W822CBU82kvi5T8ioYEGEsZiGVNyWCSEQBF1h6Po+bwRxqkDSPl/zGyO
         yi/39jY+F8hcDmMHrNkW06tBsnrebhLS2KJqQmNTVt90yckwqi6I92FxjHXWJXME8HUC
         GR/rWzKRm4w3+Xo367QY57fEQzqQFrtZa+U7GEtT+JlYz7HvEWU7WJxwHDHFhQ/Sid7J
         8bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWvS9QxnFmdXHeokNJBgpYlCnjX8I5tKgKMXO5N+5pU=;
        b=QUmG0hgdvnMM5ul0mLdvD7TSFF85hQXLOnS/8Mf+R7bnwvvIM5+YwK6wY6lL9uVwDi
         OBc1Lo7QMgaxqpg1PHxT0dSqcOW7CuhwamDLMeOFo7UTYZuWT5BGngDZcfLH+CpTKhIA
         2YzshrVCDsq075pLt+rapoNWCoUeBYcGE0FoXYKWNgsfIVIjVo2Gq/12ILRVLBOrvboJ
         iKxi736h63r8j6OFqVo07fMAIcZn4eXKrbHNPIFDQO7I2nMG+egjryoySHZSIGIGt7aN
         OoiIfT8Nh5Hfa3yQ0aMb5lt1cqPyx87no8VIVmq9vpYc+bU1uit07VffXpTZzsVqzCm/
         f1bg==
X-Gm-Message-State: APjAAAVGf8rbAish9IlaiL5z221ylfjMZBmoCtA4vKtzHT+JNcbTcdAp
        5e+qVUKqZ8Sf9dWCO7+rJ8CsFA==
X-Google-Smtp-Source: APXvYqzi2PdGTcKwPJao/OW19AdYl7B3Arz3pwMvPZ5GfB65baLNEK0eKNlRPO1ypR8xwgY3Vb4FzA==
X-Received: by 2002:adf:9cc4:: with SMTP id h4mr10919218wre.327.1552903500946;
        Mon, 18 Mar 2019 03:05:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 01/11] arm64: dts: meson-g12a-u200: add uart_AO pinctrl
Date:   Mon, 18 Mar 2019 11:04:48 +0100
Message-Id: <20190318100458.5619-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl on the always-enabled debug UART AO.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index c44dbdddf2cf..f2afd0bf3e28 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -25,5 +25,7 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
 
-- 
2.20.1

