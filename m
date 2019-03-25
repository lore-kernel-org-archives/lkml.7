Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6EFC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC66120879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bmxFBhui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfCYKP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:15:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38157 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbfCYKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:14:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so1987379wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fb9NUdP7aJF7aVxwxVvvXLo3BssoKq3ad2sMWdbhWKU=;
        b=bmxFBhuixM6Y0aQvp2OBhII92c5CZu8zoWhG/Djr/Wxs/v8UvKJ87mHwoAKaCcdo9p
         Qx5p9MY1c0eAPBQZFOJZuuySRiD+ECspZzTKvJxvz8IRD9ecuik2m6wZsrfOY0UX2dVj
         uZwvF9REAIHlamsFymFw4Be4Xak11G8f/lHswwxSSpCaUsblW88IDGelk4kL8twO2kSA
         qgTYyB1+aMHENtxHesc8NqsbDG3gXBJV2FM9KXTyWvW+CpjrJM0O+d0p+t+2lPpuJYTi
         rSgn3LGxJOVcRhYzEgcxlMXRTCmkyumtop+q+dOmYQ2NQpk2Ziv7J/SbrZ+X3c3k/uhw
         O9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fb9NUdP7aJF7aVxwxVvvXLo3BssoKq3ad2sMWdbhWKU=;
        b=aKpjsBR7THnBP91XUIPwoBjQ7vc/zvkUJUgJDXgyIlypi3NxEvGtcpMs0F1GFTDO8f
         XoDMA9v8TOr03JV575ecYRxy9bFd7OIGQqjRtwQ0NWUyo+VCPyrDI/5x2HD2G5L/pVnd
         y7WMqTker4DGVfxsvjLK/HmKA2iPb0wrLQJWdOLJtT0STSuGpLavw3/L+bpHpkE6QsDI
         Aekna02zmrpe14b57OI5pyKC/3ptvgzpf6vOPGyKmZz1jtED3t9SbvZ9ZJuf4OM1R3AN
         xSNl/ifjA9cbVh7SejWFPdCKRH3TXCJCrN86/ZlRju8+0Kvc1MfN4Y/ldSYBVxgfKki2
         vTmw==
X-Gm-Message-State: APjAAAWmaunl/Miule70bdu1oMtNi++F0bTk0rplWi8BHeE3ikISm4CN
        0+tovYT73z1ovPoZF/Qyi4jKea+qvEFcVA==
X-Google-Smtp-Source: APXvYqxF30zrGpFl8CxlnpmOCpgJMoeWFt44u6hTpiCPoqtxuQ9V5obSJwcmGhPo544k0LTu+MC62g==
X-Received: by 2002:a5d:6b10:: with SMTP id v16mr10165366wrw.294.1553508898035;
        Mon, 25 Mar 2019 03:14:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v14sm20049484wrr.20.2019.03.25.03.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:14:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/6] arm64: dts: meson-g12a-x96-max: Enable BT Module
Date:   Mon, 25 Mar 2019 11:14:49 +0100
Message-Id: <20190325101453.3009-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325101453.3009-1-narmstrong@baylibre.com>
References: <20190325101453.3009-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Bluetooth Module on the X96 Max Set-Top-Box.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 0ba28491e2b0..0a6919523ba9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -90,6 +90,18 @@
 	};
 };
 
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.21.0

