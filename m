Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80543C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5213B21871
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9qAjoSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfCPCQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:16:19 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37685 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPCQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:16:19 -0400
Received: by mail-yw1-f68.google.com with SMTP id w66so8794591ywd.4;
        Fri, 15 Mar 2019 19:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NMeP2IkzSEftRMF6nNz8Vv+P/xn7p6xmxsCj+g6jPfw=;
        b=K9qAjoSo/ugPBviM2sPkOLrP1WIBlXl9ECbxx1e76dDter/U9dYMomQnZv0uOG7zdV
         Ho2vyDwxSBqfblUY3XODtKilw1P35MYgcr9SymW/W6E365RkgNwgUS7/jDozmpvByWSe
         cI6NvX0SnBZtbTbQGEfdJlyzpLBOF2eDDHqmLTA/UpumlmC0S0FMJYq8hymZjcQUU1Eh
         JupIiSuiAfM0ZgHciI2ANf5B+Qs6kE5njuD4wT4Jjip7Ys035GZvs8E87aEbaSaK8IQQ
         XKBjY4Kse3kq6KxRFQnXELJYwDYQRmDvLD/gsSU3nGtvvCCRb1dU79yHOC1S7kV8+s3I
         A2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NMeP2IkzSEftRMF6nNz8Vv+P/xn7p6xmxsCj+g6jPfw=;
        b=jePbO0lqCimqfUZKpIlGOPigSVZm9Qt6t6kOa7g7VT603e5nXsi334dKqNRH9gUH8B
         vL4keul0cRFmTq/RaE/9aXLz3z0mo4+3vWIJKPWfL2zpeBveDbx9kYCDY6pf82RLAA3A
         PH3zcYLVHIFRzk9YWsUVm3ChTPTXeHwTYx+wXSx7vBnsGwVHgt5N8/GqCKCWDZvg1gyX
         xy7qETTSPtxd/rWDwZbkk/E+mXYiGdEHr1GhgwomoHFwZOzWXPPXW8hAy0S097eJYkZn
         LzSVUHl5qBHZo1SCabImAmYvFK9kpW1FzcbLRFkvZs4IVhsmNyItuTj66EU3FQtgC7ox
         Imgw==
X-Gm-Message-State: APjAAAWPb1sIeNIf/3hSb+qdm5ZjMaRBu470JHspPAGUGicgZpT+WXDf
        iMCyTAtkD9rwXgbJiYOxT+c=
X-Google-Smtp-Source: APXvYqxOniiMVtEoj8kEZ3Narq4Ag3pwHJWHmjta2JzJj7IK2x/GoqVK82sOvjqn2LTTd3jchkN+vA==
X-Received: by 2002:a81:77d7:: with SMTP id s206mr5400460ywc.30.1552702578195;
        Fri, 15 Mar 2019 19:16:18 -0700 (PDT)
Received: from renatolg ([186.220.21.102])
        by smtp.gmail.com with ESMTPSA id q9sm1729785ywq.88.2019.03.15.19.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 19:16:18 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:16:13 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v5 11/11] staging: iio: ad7780: add device tree binding
Message-ID: <fce522fbe69b6d5ab8f06c70d18cf097f256711c.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1552700652.git.renatogeh@gmail.com>
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

