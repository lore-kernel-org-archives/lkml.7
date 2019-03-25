Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0213C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F07420879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VCrGc7kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfCYKPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:15:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38166 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbfCYKPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:15:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so1987618wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGh/bbaqKCOThumggThLrmBLJwz7e2gPGPo9vmyZO80=;
        b=VCrGc7kUfYbEsXw57eNOQBuESMeV7hUKZmhur24iWOCjJ50V48ECW2JvtLV4EDD3W2
         /Rpj6jo0wOT3y/H2apFAsA7wjj+WLRJbcPeRCPrIXSL3117rWHXnWEmJmH7n28s6AJ4q
         eYmgs/Wol7d3EUoh+1FaD5OilsO76Ees3oyw9hzwVF4aEQsVfcM6PWSszAtLV3QmDWZa
         rjOANiaWNewsRD18cIaYoXR4bKR8dmT/qXBOYfGNVgJwXaD3CqspR65rGowmfKwnXrUq
         t6urzobbXJkj2tggyiIxzpcAQ1yDwtS6AmXMifXLHYr9cx0Qz1OHvJiPt/hC4fdfuIPs
         RDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGh/bbaqKCOThumggThLrmBLJwz7e2gPGPo9vmyZO80=;
        b=TpNMbotK9GLTTz+un3bEqP0YBD0LKpo4fBl5LZProl05a6aRWGwgMGuKA+7S7hIkwt
         BkflPDqqfihXBJKwA0ApXk9/10Ln/jf70XNw2eA1wTvO5Nq2EmIYJ3fl3Kq0mMbtPzj/
         V1OxEwG8oC0oISrPMIuDLLdL3cpBmi2HuFAv6LAImiy0Vl2WzPLAyNjGIBoKMuNZX7Ct
         4OyyZNS3G6rS6l0fQQBAemq+gDsAWTqJlEc2eFaXwVsEhPb6lo5+q88I5KYHZr4vaBs6
         uDaE0crZH6H2b7JOUXUfGRgEl3B0fvpFAyCjpbtkXLMBdXfOXiuX0SViszosgivFX6h6
         509w==
X-Gm-Message-State: APjAAAWM60yMD6ucht6L+lYfyfQPTpq3uYO4tNwbSxsuQ1CoG4g8cVWS
        xo450u/g+CGy8MtR/o7Ofom5CBiT80GLKQ==
X-Google-Smtp-Source: APXvYqxofpZWT8De35Lex7hD5td6XL5zU8jbsjN+raCsd5szalnxYOmVxw3xkD+0cKZLAXbE47+/9g==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr14381359wrq.209.1553508902317;
        Mon, 25 Mar 2019 03:15:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v14sm20049484wrr.20.2019.03.25.03.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:15:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 6/6] arm64: dts: meson-g12a-x96-max: Enable USB
Date:   Mon, 25 Mar 2019 11:14:53 +0100
Message-Id: <20190325101453.3009-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325101453.3009-1-narmstrong@baylibre.com>
References: <20190325101453.3009-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB2 and USB3 Host ports on the X96 Max Set-Top-Box.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 0a6919523ba9..b5b88262c06a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -107,3 +107,8 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.21.0

