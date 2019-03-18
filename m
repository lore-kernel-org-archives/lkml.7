Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A2B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="THnHA3w3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfCRN1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:27:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36713 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfCRN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:27:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so12529900wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUW/0oX1GPWgNe1zd7vEv15Hxq4TFiRMZCgKm/8ULe4=;
        b=THnHA3w3FzLurmZzpwYlGNfgWIpW4AYGQKVB7htGKxgXPnizpZxKtgY10dgBYjCGKF
         gTzsnpfMNYYm9okNuty/qRNY+s6wPALhxdE/x3WgtdhrnP/RXLE4nsLCXtZo1P+FndjU
         ZrHD9NifrbkAawPa3y3hYPg/7QgtKoazTc1BK5zEIuwozdLhZ7Qo3EmRN9ZICPGFbWP8
         aLla3WOX7cz1lghhc4D0Zo3ZC7HwqJdo3ESnB7M6RNDJDqQB8oslbIVQ1Q11fDjmWawP
         FjHoLRA0kAeqEk9M5ucAmc08txFAlRN4CPaPDsEsyNsDrjcfl2EJr/U/BlxsS2txkDAL
         EEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUW/0oX1GPWgNe1zd7vEv15Hxq4TFiRMZCgKm/8ULe4=;
        b=eezSWdZjNy6JQpeIQ8aiRo2d+RwZ3IGVIYfZV0JbRZNX6DSAQP/RFrysksFAzMt6+S
         QzX4Njob5VKp/By0wViSA5py6ITtBnqaiScrZP+IvlZKfeSqEOTX1NGf1B4p6yAAr6SW
         Sr6V0ASnmdFGPPnxr9XZkZerhpoz9BX6pG0YmLdb5coeRERkad7N4AUqe1LvsXaYzMPJ
         KmHeZvQ0PBwNiPEwwy2YWPxKt2aUSFBxoZASXobmpyNmBol07wLuh8GpPqzJ8un3VOZ6
         MIFLSHtxvCzsn/Txf7+si9mU/k3fHwOuK8LLsbLgOfjzYPWKvtTBeu9FsQKgImfdAK45
         Jcpw==
X-Gm-Message-State: APjAAAVUllSMuEoXBzj3S2bK42KfHvFnSKtJxwm/rN5j9lAIbznJBHij
        qQfzptiXOIoey+fa4PqSkvVbHA==
X-Google-Smtp-Source: APXvYqxJYs1Pz/F/7+Pb8RKw4p5MJp3cMMuRa6H3DMuE5wC9SsJdkHoi/xktVkk9wUpYCKkDn+uqfA==
X-Received: by 2002:adf:eac9:: with SMTP id o9mr817933wrn.85.1552915621285;
        Mon, 18 Mar 2019 06:27:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j128sm10421601wmb.43.2019.03.18.06.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 06:27:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/8] dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
Date:   Mon, 18 Mar 2019 14:26:50 +0100
Message-Id: <20190318132655.30040-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318132655.30040-1-narmstrong@baylibre.com>
References: <20190318132655.30040-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the specific compatible string for the DWC2 IP found in the
Amlogic G12A SoC Family.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 6dc3c4a34483..e150b7b227c9 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -14,6 +14,7 @@ Required properties:
   - "amlogic,meson8-usb": The DWC2 USB controller instance in Amlogic Meson8 SoCs;
   - "amlogic,meson8b-usb": The DWC2 USB controller instance in Amlogic Meson8b SoCs;
   - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
+  - "amlogic,meson-g12a-usb": The DWC2 USB controller instance in Amlogic G12A SoCs;
   - "amcc,dwc-otg": The DWC2 USB controller instance in AMCC Canyonlands 460EX SoCs;
   - snps,dwc2: A generic DWC2 USB controller with default parameters.
   - "st,stm32f4x9-fsotg": The DWC2 USB FS/HS controller instance in STM32F4x9 SoCs
-- 
2.20.1

