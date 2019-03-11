Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC03C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8352084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xjm19XfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfCKJ4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:56:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34333 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfCKJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id f14so4320235wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xc6TAi3Hh+qeOL4saESoM75HmTfiu/18FSF6TCAEiY8=;
        b=xjm19XfNfCS7KEJ7sSM7HS0WXvcWEegjXgv3l6mPS6jY+FAuYBxyiXEMypQtlKnSKj
         pMP0Igaabw8t5gBK83w8ZuGu1hpzkV+wAohlcMFQikwZOuDqPeKdeHGqaqjqLlPJW1EK
         f/TKwCL1nWkCB/bPNZBoOaFw3mDTs0P4E0vZ4sPQeziKq/T2m+cddgPucxRZB9EXOxmq
         VK4/wf/bqV32vW8JtUsx2RSnL47E9IyMGv8g58WCw81Bn4rPBJI9rDjxeXdlnXAX16Os
         pV7HczhEKTCyE5519Avu8gx/3wTda6qUXs3QfibVwRlPJSv7FTmKx8ov+fmFBSzhdmAw
         /R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xc6TAi3Hh+qeOL4saESoM75HmTfiu/18FSF6TCAEiY8=;
        b=PYjNmOpy/63MNF4B20JF7iHfW2gMD6+AwzGSyZicbmnJjBOimsgwfffvwvpuDRD+oD
         ZjhqlzNCleI6D83TSb+4/Mj3UWLm9Nhe0cWIHmM5dc2MWrvpKprGK2gBywp1MB4xGJvL
         wH8a7VGBJAQh7gNvmeGhpJdRsSRzOOs48qUGSSAXmf0SUlVKEVkamJ/q8ySCDd247N1I
         OQT9+s+19r8s78BOF1niIuVYspH8Nd3bcQqb/DvYrgrojf74vDxkFXzaVZ79Qh8n/t61
         GzeFSK1DjbUeyypaPJxr2fXgcMlEvWkutXt/Tj7Sglrxh1V1wSg+0/wGJQIVfw8Zw28/
         wjuQ==
X-Gm-Message-State: APjAAAXvjXmzskNYX6//1xVmXmI9C9v6bkcRIBwkRSKehNpVx5JcPPCD
        Q30r/eikFufKsYnobJTSt/3shg==
X-Google-Smtp-Source: APXvYqzLahKurVD0KnSDQYMIGe3vOtIceOe0rIUlpNrHOWc5PH7u02E3ym5CHSITyz1DXzlgbmr5XQ==
X-Received: by 2002:adf:f88f:: with SMTP id u15mr13249571wrp.117.1552298182652;
        Mon, 11 Mar 2019 02:56:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] arm64: dts: meson-g12a-x96-max: Enable BT Module
Date:   Mon, 11 Mar 2019 10:56:09 +0100
Message-Id: <20190311095613.11371-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Bluetooth Module on the X96 Max Set-Top-Box.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 21e5de48613e..61606601fb4f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -88,6 +88,18 @@
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
2.20.1

