Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B6C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2542133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Hg2CCl48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfE0NWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46155 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfE0NWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so16908723wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1CiRqWREkgXuihOBunUI3fz+CBkOdeZkmwsLz+vnX0Y=;
        b=Hg2CCl48NNB6AMXkrTWKa8IdPcIBCv4b8IP+DMrhifc8ubYGhMOkLQyDLeWo1LLLZu
         JjN42+xp70/Pq4+VvnuCgjCMy/fujF0c5f9W+02piqOcWB6Vuq6txI+u/Qy7+sDhh9tI
         J3HJIJ4xRyWnBOLDLZ0ZNjq9saFTrJe+p4mGJ2WI1pa1UCWbWHskqAlTPksoWQGPl6q3
         gtzJglAvTqLuWJXateDZ/fmZHv9A5d8CUlk8xc3cCXdQrJVSMd0TBaGGEuWiF3opdJfI
         doDO5PCC5S7u50ZOE1D+dRos4HDFw4O0CYZhd6VXJ4eQRKXg59Q1YJdhmTBggPvZ73dx
         8TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CiRqWREkgXuihOBunUI3fz+CBkOdeZkmwsLz+vnX0Y=;
        b=NKrSDv+P34aYyjyoooh2Gy1Ohnji6nt2lzaf4oUA1JK37l7elYtcKxbRZ+fZxnY/MY
         CYFk5nTkFutkNOoTM0AhrqYQ9jGQ4Z6J1C66um6UwI0JrYtEuilFWVXnuB7OequRf0ju
         MrRG4osm1tTuNh9zf3/IDz2bgSW6lrkm2ddD+InuxsVYlkiT/2tPE05l0kPGz+ccGWZY
         umIhogUwofxq48VK4ADO++UwGhZjsU3GgoJutdGnOfIlRg2Vp9cahoTSS3Aq23Da/PVl
         2rr1i5lCeZGCfdLO3gqybCO32fP4dPH3WzNu0CkqfwAdDbamhZsUPIJgOL521wHjBHI5
         0u7Q==
X-Gm-Message-State: APjAAAU5YUgjNk3fEXhyi3WzvP6/yFeUxvpYyyM9Tx55UMJcB3wFMDn7
        4c36UcOpQm8G/k3cs9ID2+tYHg==
X-Google-Smtp-Source: APXvYqzC4VmNhq9v3nbo8eE5sL9A319fsc//sxkeiH4qYeTzgim31C30hxhgbJLRajqBnZV/wSwEmw==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr3774964wru.72.1558963326098;
        Mon, 27 May 2019 06:22:06 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 04/10] arm64: dts: meson-gxbb-wetek: enable bluetooth
Date:   Mon, 27 May 2019 15:21:54 +0200
Message-Id: <20190527132200.17377-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

This enables Bluetooth support for the following models:

AP6335 in the WeTek Hub rev1 - BCM4335C0.hcd
AP6255 in the WeTek Hub rev2 - BCM4345C0.hcd
AP6330 in the WeTek Play 2 - BCM4330B1.hcd

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index 45e306da2154..9ef6858779c1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -249,6 +249,19 @@
 	vqmmc-supply = <&vddio_boot>;
 };
 
+/* This is connected to the Bluetooth module: */
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 /* This UART is brought out to the DB9 connector */
 &uart_AO {
 	status = "okay";
-- 
2.21.0

