Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58172C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6CC20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0OPa+98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfDAOiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:38:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41396 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAOiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:38:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so10816562qta.8;
        Mon, 01 Apr 2019 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LB2Pb49enkgEC2sTTtSTqSYnVG/+rCFKbnT65xSw2Ic=;
        b=n0OPa+98bsbCDqcmJhrL5+C34NEuogMgxtUTeCrLnxndH9UA1GD8uIEV4JNXoSpJJi
         q1MblY3E3bIDoHwjjHHMgZlMz5RJcta2vknkaEYwhNScKLY75nkrVnwSwOAaFOWDfEJA
         kVm22ldeBgTVyDA5BoeAW/Pcajbpv22gPpwcT/rNnZDO77OgXa5/Giok03FgFq4+rbHm
         8hLKyI8Ky/wI5Rn0ILhz89gQOHRT6NokLYMASeT+S07sV4P7hHkvyDIfdXBJ2TZa0BK9
         VmFh5EbYsOSHWRuUimHDyqMzvLlNsAlVSZg4liUH/fFs2BDKKcspY0SO6FZcohzGqcve
         ujuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LB2Pb49enkgEC2sTTtSTqSYnVG/+rCFKbnT65xSw2Ic=;
        b=ekm/0bBEmKi/AVfRISkwlHJPbbFlg+SpwnWvRFhWaOrzeTY8gCI8kK6blrS59sdnOA
         GSA8+74zA3RjWo780HMmFwwqa9pahoJSjV6IYrRWrr25PAjRc2BjCv/tvSYybn0pzGRQ
         Q3ciRadMEAlEwDVEx99GqxiZs2vqmNSTKTxFVWVLb0UkwJLKPrQ8Z+BQsoP9fU4YHkkJ
         CG029OS4MUuNafvgHszeKByQlrGOPtMbASu8QhjZ+pn0evkUUmUtAaYzdyiaHfQfZvtN
         vUHs+UKRlvltT/t+GL5w3YyYuzKACtbcMRXe8IMXJWlj/xOhbDzDn9gY45qb4+rFV7Z7
         3/yw==
X-Gm-Message-State: APjAAAUD/g83ms9KX4dpn6QfR0A+7mKcN+mQZSqS3qHOPL6Q8TWrP0wp
        KfmQkur6S6lMJ0GEhAE8X90=
X-Google-Smtp-Source: APXvYqxBm/95hgwj/lL/t0G6lUG0Bz7FN26X6tms54NKYdmKy/hpUMHyJnIwCiffdkP3ag8lv/Ap6w==
X-Received: by 2002:aed:3ffa:: with SMTP id w55mr51313284qth.142.1554129492488;
        Mon, 01 Apr 2019 07:38:12 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id t129sm5431244qkc.24.2019.04.01.07.38.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 07:38:12 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:38:07 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 4/4] staging: iio: ad9832: add devicetree documentation
Message-ID: <20190401143807.xlz32drk367ogcxh@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree documentation for the ad9832 direct digital
synthesizer, waveform generator.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../bindings/iio/frequency/ad9832.txt         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/ad9832.txt

diff --git a/Documentation/devicetree/bindings/iio/frequency/ad9832.txt b/Documentation/devicetree/bindings/iio/frequency/ad9832.txt
new file mode 100644
index 000000000000..6a35fdff5a48
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/ad9832.txt
@@ -0,0 +1,26 @@
+Analog Devices AD9832 Direct Digital Synthesizer, Waveform Generator
+
+Data sheet:
+https://www.analog.com/media/en/technical-documentation/data-sheets/AD9832.pdf
+
+Required properties:
+	- compatible : Must be "adi,ad9832"
+	- reg : SPI chip select number for the device
+	- spi-max-frequency = Max SPI frequency to use (< 25000000)
+	- clocks : The clock reference for the DDS output
+	- clock-names : Must be "mclk"
+
+Optional properties:
+	- avdd-supply:  Definition of the regulator used as analog supply
+	- dvdd-supply : Definition of the regulator used as digital supply
+
+Example:
+	adi9832-dds@0 {
+		compatible = "adi,ad9832";
+		reg = <0>;
+		spi-max-frequency = <25000000>;
+		clocks = <&ad9832_mclk>;
+		clock-names = "mclk";
+		avdd-suppy = <&avdd>;
+		dvdd-suppy = <&dvdd>;
+	};
-- 
2.20.1

