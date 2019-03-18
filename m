Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C2CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF8620693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="t9MvNlOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfCRKFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37216 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfCRKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so3538020wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ffLSiIBKhAZEtCPU3WfiQte2GBnhMcDRzZ1LFjIZ1s=;
        b=t9MvNlOy3+rjGhT5bWMuvzz6dMy1bnIhlVEsDaXd32jB8OdBptfjUzyZ6Mastth1Xa
         WTFy8/J+hzWDycng7Hp71b1mkv8JaOnX/xljfs2OsQhieXsBZQz0ye79Yc3143y8GZg/
         nuCCLHuFtv6yG85hyoaSHxX5PUEu0C754EzKa7czKAWJXw+QZzv6ttQfL73ByrvG8AcA
         Df8Fj/aytEFflpJZWsaS7ux89buJScDHFxTbCTpqdFX0otATEM5p2IE9Bij0R3Em9mdS
         e4oK0vHYXHW1RgoCSHM9FKRJnxFnCfqdS7iTCfJPNQaqr5fCTvWEH82QSCBftfVT6wvd
         ZGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ffLSiIBKhAZEtCPU3WfiQte2GBnhMcDRzZ1LFjIZ1s=;
        b=PHsTV4gIulP2GwkEa73B1wGBLJET1O/28FvrYNHs2fHPYu8+SIwYR94PUm6LoPi3Ye
         Z4cjBwem9GDa8/fk90Ees13xr1Spbd5xCbkE96g0uxkdofGK8CXWy39QSuCzrnyurNo7
         hXnUFny4NtUVZQjuhn19QxbAthy8KwsKQRv3ovN0H9rIud0gv6d8R/oQVXvEQGTdKNO8
         biS9+aM2Wx5BZLSHHjbDJvLgC29EHujiOJCMGb1UcMtfXmfoWGGGvJw1iuJph6BTXl8K
         nQm5US0ksY57ZveyAs2VXJsUYb3K2vD6iSKzl5sUxCaFU5UUKOUBen7dPrno0Eoi6Gqs
         ubBw==
X-Gm-Message-State: APjAAAXHAyZNPVLhIja+iwKiL9CV4lGuj86h0JyEAVWxL+2eVVGkBOc3
        8k3JKnr6/Izg7PXYoQyJklzL+Q==
X-Google-Smtp-Source: APXvYqxB+vufFtnxr8h5ptDHe6SYvw6JH0nlHKjFR+QB0kxtua+cRcc16MeL6hiURQaV2NeLGF/xlg==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr10093647wmc.63.1552903501947;
        Mon, 18 Mar 2019 03:05:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 02/11] arm64: dts: meson-g12a-sei510: add uart_AO pinctrl
Date:   Mon, 18 Mar 2019 11:04:49 +0100
Message-Id: <20190318100458.5619-3-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 6a7c3241862a..63c515fe4996 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -35,4 +35,6 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
-- 
2.20.1

