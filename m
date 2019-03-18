Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBE0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CF6206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q0JML7oH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfCRJ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:59:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40711 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfCRJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:59:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id u10so9541529wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Zt6AwaPAgZDNLcSER68fIKEFrzS+LlLMT/Gvy9mGmk=;
        b=q0JML7oHfrD7GvId8BK6zPlW9aZtX3O5Os5XUHrdFA3ETLFQjkca8hGagR63tUukoc
         SMlWuQg6Vsd0FUfwE7jEacBBxei7V5438jBJ7fcr4O6qZGHRK2I7jAVztPBla6ZpONPr
         IciBI7P6xr+Vr4lceXq2m4mNCYjaICjUi4urXZxHCAqXf4s5T0JfNe898DXzDLYGg4uD
         AsOCp+ntl7F5dxLr2gtaFbuCNyAys54jwljzH1jC3X4Q/BU2KMcKuOS0RR7ngOktHlc7
         m9x1ycz7a1g8a7wLHQYdQsDW5pOsa8CQUSHRz52JCojv8SHZ1e9sZdR7vfiz7Uc2Ayxw
         r+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Zt6AwaPAgZDNLcSER68fIKEFrzS+LlLMT/Gvy9mGmk=;
        b=Q5+XbDQmT71eRHsdu0k7A3jM1VPzGV775r4oWJwZNjdCEtMkd0ehjyBn5dduKs/CFx
         9/MhmtQoKaPvtrkR9dFLOijdm8OizRTbbZKK42Urxz8WpZO+LBOQ7hj9RLUlhJ45LLMp
         n/szkjNtQp/rZcvhuaXKx8GVGhNWylysih3RdzTwhaZEbo08cb1lx+u9yk34TETOWtgo
         2+uDTysl/O2Sp6g6RORPYQ5OUUuMm/BRFYhOgIxmp+bBQFLzP9TY4jAcClXVvhn/jx1v
         geuA97148YJmtZHnLhtKnWkvvQjH2Q5pASGhIDOfLCNTE7sKdaNYfPjoaEkfzUaSc6iz
         zhiA==
X-Gm-Message-State: APjAAAUgYo7Jz5Z+v/WyC6maTawcp70zNOuG+FfvSio07KYdHLq9YGm9
        qnxq537ymDSM/QohsQnqzCtodg==
X-Google-Smtp-Source: APXvYqzqWOqyB09bRcsadj/pFffAnHaKhkwCmZg3ya+8MFcxY7KtwNzjFySKIEAzGkWOBmbE0eYYiw==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr3162129wmb.110.1552903140400;
        Mon, 18 Mar 2019 02:59:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g8sm5459034wro.77.2019.03.18.02.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 02:58:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 6/8] arm64: dts: meson: g12a: Add SAR ADC node
Date:   Mon, 18 Mar 2019 10:58:49 +0100
Message-Id: <20190318095851.4062-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318095851.4062-1-narmstrong@baylibre.com>
References: <20190318095851.4062-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the SAR ADC controller node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 992751024366..a99c13ee724a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/g12a-clkc.h>
+#include <dt-bindings/clock/g12a-aoclkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -270,6 +271,20 @@
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			saradc: adc@9000 {
+				compatible = "amlogic,meson-g12a-saradc",
+					     "amlogic,meson-saradc";
+				reg = <0x0 0x9000 0x0 0x48>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>,
+					 <&clkc_AO CLKID_AO_SAR_ADC>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_CLK>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_SEL>;
+				clock-names = "clkin", "core", "adc_clk", "adc_sel";
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller@ffc01000 {
-- 
2.20.1

