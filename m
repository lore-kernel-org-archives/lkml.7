Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A21C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55792084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTmBF9Ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfJGKLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:11:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38932 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfJGKK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:10:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id e1so7913263pgj.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ERqIOKakQGLjInDRvAedMR7AaZNxUUgWN7Nn/dFXW3w=;
        b=nTmBF9EkHgs5UmnhmN0Q+0jbo2Gs/CvFqezpp83LtQ/OvJkcfpqFVUVVFoHDH5zVIU
         6KW2dZit83ws6Wk8ymClNCEq4eZMRarsMxzXqMQIROca7IPlcMrOQzecDlSP4zFbGNKH
         ggZB5mVInKxVNsB8ANhJbO++HEyKiBHZVM25xQKk7XfQZHfe9ceZzB/ieC3Dse/kmQvA
         kWMA9AntTCuAekow6pg8WC65DXMm1oNcbh6BYyHAQQnaa16AWATMxIcXwmgyrRHVmsnC
         yHp7Gl8jukwhz8msKVFta1XWIFx4gJ6JdqFx7LBjeN5lVTkkppE0mDwWdCNUPWDV8zSj
         ygxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ERqIOKakQGLjInDRvAedMR7AaZNxUUgWN7Nn/dFXW3w=;
        b=kEmrJqY77OGobGAmz6fanyci94v4JLj/UPShe+uCbOpk4DIOlfbHIyaf2ae23o+MDK
         fq+FtBv81vZjNo8mFieSm5I8zCfH8yZW9qreHO6RyP5M3bxwItuNXcvG8eFjB2mAlnXB
         81tqbcfFmNJh+g3EPmCwOgUv2XfOGHWeEK4QgwGTl8YqUn+/j08vvlLo1Pfz5QHdEdEh
         rdOW6xCkZuNGs4Cds0AIQU+IRNFw5V8NsZPEiwtCaSJsJei0u+hpDDSqBpyfHzAXlnaE
         ucnn4q32iuE4+xVdNEuRFyeIgw56kaH1kjvLOIq6w9eIkStgPbrEvQNUSnR8Pi5G0ASM
         S8nw==
X-Gm-Message-State: APjAAAVn1yP1osMDOGuw/EH09GxhN7EWec8Lt8pfgfUl5GapS1THP/Ra
        ko6oGY0yZnOx6qMVfoDttbVQ
X-Google-Smtp-Source: APXvYqyb/5tYBVyOuvCN5oePoRjDrJOcZqVo9dWFxVwhAfY/XuYbMQttdfNeerQzgBBYT8EN7n2e/g==
X-Received: by 2002:aa7:953c:: with SMTP id c28mr31981236pfp.106.1570443058066;
        Mon, 07 Oct 2019 03:10:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:801:5b45:54fa:fc3f:2c55:c2df])
        by smtp.gmail.com with ESMTPSA id z4sm17465132pfn.45.2019.10.07.03.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 03:10:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Date:   Mon,  7 Oct 2019 15:40:26 +0530
Message-Id: <20191007101027.8383-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
References: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Analog Devices ADUX1020 Photometric
sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/iio/light/adux1020.txt           | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/adux1020.txt

diff --git a/Documentation/devicetree/bindings/iio/light/adux1020.txt b/Documentation/devicetree/bindings/iio/light/adux1020.txt
new file mode 100644
index 000000000000..e896dda30e36
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/adux1020.txt
@@ -0,0 +1,22 @@
+Analog Devices ADUX1020 Photometric sensor
+
+Link to datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADUX1020.pdf
+
+Required properties:
+
+ - compatible: should be "adi,adux1020"
+ - reg: the I2C address of the sensor
+
+Optional properties:
+
+ - interrupts: interrupt mapping for IRQ as documented in
+   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example:
+
+adux1020@64 {
+	compatible = "adi,adux1020";
+	reg = <0x64>;
+	interrupt-parent = <&msmgpio>;
+	interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.17.1

