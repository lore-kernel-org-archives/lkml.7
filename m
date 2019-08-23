Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8BBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF282166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GmV8Y1qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393566AbfHWJEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:04:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50305 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393504AbfHWJE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:04:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so8202637wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKHSL2TvLdzeYTHakHcSzedmEttI2anacBGRuNcRBkU=;
        b=GmV8Y1qAC14OzfTnstiQTLtSRJ4eKTZc3RCsEia7V/22Us2/TJ6DvracJKrPIOyt0V
         XSWI5ru9VfHDziUruw6sVNCura20aXsw6/OFD+G8Vl6ER+1uaJK3gjk/bs9F/JOojCnA
         NQM6+A3A4avL9YZKxlcRqquhPsVqoR2MaOUU6Su+2xeJJYA6vFWXsv4T9cfqlBvrU3Qw
         7+lilrgMdKAYBbmZ/U/p2dANT24xBrDEr8LHFqmDpq9O5q0qrGywSyMQhqIlGJy4yzu6
         05x1HRk2ngC9gFNXeDvtN3UR39CssrFA71aRJk/3PQR39v+lXHrEDfef0SLrv6ZG49M6
         bK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKHSL2TvLdzeYTHakHcSzedmEttI2anacBGRuNcRBkU=;
        b=NC6dreN9J2U90lax4gZZ7NPg55dIiM72D3EB73YovWrxP6FhsUSR0HLM3Rj2NGw3TA
         /aRSiYGsYEozWR5lgdWTy1lA4jdkQy5DTVZ3Pto0M4D/bEHqu8/o0gN1SUuH4A4Slvwu
         kaeQUgtcI9Sxnsvayl8ViBVNQo8hzy6vtn6++8xr3n+/a9OcSjnB52HeMSqkK6RVTXg/
         2nNQshRNqOG5qJeIBUpKSEcNmaeEQrLkV2cQUa8OqIHcnpG5Acy4QBTPN3d2Sqt6I4YV
         g8zC/Abduo2wlf7qLZhdMGVEC9pH1Rx7JEm4ZmUwXhXP/NXnYseLR6w3LLfeep07INWN
         IYXQ==
X-Gm-Message-State: APjAAAXU1xfL5CQwAUqtZukBgt6DZOzgxn2VCtTkb8Gi3gXQtbFmaPsG
        oj/L2fQrLiZJUT0YxpHU41lbBQ==
X-Google-Smtp-Source: APXvYqyNRvGj3V0YbEVMpMvc8XkM8d3DsccgAZV4aJwajw0WiCJWsTm7i1pRBnGymWb8H802qYaLHw==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr3941416wme.147.1566551065315;
        Fri, 23 Aug 2019 02:04:25 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x26sm1625544wmj.42.2019.08.23.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:04:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: dts: meson-sm1-sei610: add USB support
Date:   Fri, 23 Aug 2019 11:04:18 +0200
Message-Id: <20190823090418.17148-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823090418.17148-1-narmstrong@baylibre.com>
References: <20190823090418.17148-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB properties for the Amlogic SM1 Based SEI610 Board in order to
support the USB DRD Type-C port and the USB3 Type A port.

The USB DRD Type-C controller uses the ID signal to toggle the USB role
between the DWC3 Host controller and the DWC2 Device controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 66bd3bfbaf91..36ac2e4b970d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -321,3 +321,8 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "otg";
+};
-- 
2.22.0

