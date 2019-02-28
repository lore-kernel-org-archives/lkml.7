Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE3C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1102171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQR+qDtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbfB1O0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:26:39 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47022 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732966AbfB1O0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:26:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id z25so23598580qti.13;
        Thu, 28 Feb 2019 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NMeP2IkzSEftRMF6nNz8Vv+P/xn7p6xmxsCj+g6jPfw=;
        b=sQR+qDtc8jyLsD5XL9nIDbQ8lVGl854SLtlpi6Aeq2X6lAixeiEEL4KjPd5basebBd
         xI0exudRxd6vzI0W2Kb/Uz171EncvAqV36P7dev9sPHcpKaKTPD3frAhfclpUQHfjJTl
         /XzoyWT7zINSgZXH74KLKJGgOsCvds8ZJqj+1bXTDobE3YhIcnrB9RyuaI0qwdVFWDP8
         /y4RLV6fJn28qiB/qEe3dqacjYBy6IZASevAQugDFPnNV1aCqCz12LvWcy63JKzviEGG
         /G+5clmktRrU76b37jvN6mF+objE+CJ51lSAZY/vMHzdJK25TXAQ7frzkbLC8kbi/0oS
         viiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NMeP2IkzSEftRMF6nNz8Vv+P/xn7p6xmxsCj+g6jPfw=;
        b=KQMPgxY97Q2B7fnMkA5MvRRxZcEuk1Cf5H7RUzJyj7fMTegUd6JsMN0rIfeg2rib31
         Z2FlJLa8kgelHdZM50UsgUFbyb81ua/0u/dbEqXNTSmLAkjpUgkLzgTlt7Puo5CTm0c+
         5o0chY+/ku6zn9NQ+YadHkcWlZszojS2dVFnjfJxELPJ2kbSvt5exuo+gfhjciO7au4Q
         5gMDUkhve1drEHk4v1Yrww5qU4TSECGZink5Pr3ZJygoR8O9MMMkXpn8/F3ZScT+3JNW
         J4m1ARKJg3tpzCeQRUTX9aGd0fS2JhqANr5yG3jEPj4f61ZRFVouYt9FSpaEvIYfoj7b
         y74g==
X-Gm-Message-State: APjAAAWvCOTUIq8GAzrPCj34QOUZoRjHcx4LxUHV04c2TDQcu0a2Uv0k
        NchNIV8HeL1mXrEkcG2IoH4=
X-Google-Smtp-Source: APXvYqzkIG/AukRKqyW66hRHpX5dMPnkXmYJ+bjeA0ml8TGONocgZ0ekvecIPlygYWo27xVtDnoGrg==
X-Received: by 2002:a0c:bd15:: with SMTP id m21mr6560189qvg.246.1551363994191;
        Thu, 28 Feb 2019 06:26:34 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id r68sm9554072qkd.68.2019.02.28.06.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:26:33 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:26:28 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v4 9/9] staging: iio: ad7780: add device tree binding
Message-ID: <ac8955ea9d903c106535d76549ff9802f527f4f6.1551358569.git.renatogeh@gmail.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1551358569.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a device tree binding for the ad7780 driver.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 .../bindings/iio/adc/adi,ad7780.txt           | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
new file mode 100644
index 000000000000..440e52555349
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
@@ -0,0 +1,48 @@
+* Analog Devices AD7170/AD7171/AD7780/AD7781
+
+Data sheets:
+
+- AD7170:
+	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
+- AD7171:
+	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
+- AD7780:
+	* https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
+- AD7781:
+	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
+
+Required properties:
+
+- compatible: should be one of
+	* "adi,ad7170"
+	* "adi,ad7171"
+	* "adi,ad7780"
+	* "adi,ad7781"
+- reg: spi chip select number for the device
+- vref-supply: the regulator supply for the ADC reference voltage
+
+Optional properties:
+
+- powerdown-gpios:  must be the device tree identifier of the PDRST pin. If
+		    specified, it will be asserted during driver probe. As the
+		    line is active high, it should be marked GPIO_ACTIVE_HIGH.
+- adi,gain-gpios:   must be the device tree identifier of the GAIN pin. Only for
+		    the ad778x chips. If specified, it will be asserted during
+		    driver probe. As the line is active low, it should be marked
+		    GPIO_ACTIVE_LOW.
+- adi,filter-gpios: must be the device tree identifier of the FILTER pin. Only
+		    for the ad778x chips. If specified, it will be asserted
+		    during driver probe. As the line is active low, it should be
+		    marked GPIO_ACTIVE_LOW.
+
+Example:
+
+adc@0 {
+	compatible =  "adi,ad7780";
+	reg =	      <0>;
+	vref-supply = <&vdd_supply>
+
+	powerdown-gpios  = <&gpio 12 GPIO_ACTIVE_HIGH>;
+	adi,gain-gpios   = <&gpio  5 GPIO_ACTIVE_LOW>;
+	adi,filter-gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
+};
-- 
2.21.0

