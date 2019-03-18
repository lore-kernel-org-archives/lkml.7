Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF167C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E35F2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NbOqExCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfCRKMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:12:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53309 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfCRKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:12:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id e74so12306458wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUW/0oX1GPWgNe1zd7vEv15Hxq4TFiRMZCgKm/8ULe4=;
        b=NbOqExCGZ0ZWcv6OK56p0ISNDwMEj+I7eqERXUL9LeI4+57DTlyMcCnT8+bf1VatR7
         ENDvdMHT9j90jipmnxLmGn46t0eIFP4pS8oQLLpgIM8ts7+qtofkedOAPjF0q+eFJn3a
         3dzD6DPrJx+I2rSm+A5qvuYy7HOAVbF6gfqR/NkyIpItSS04bd75RRx7Fl7Cxd7pGzWY
         0xHDS8sgMCV6I+Qk6OSieye5gLU+PH0U92NkxBgmJK35GRgf2FDsA2NVC9O5P1nUGY+2
         GX+BT2DvBGkDwgFBsIzmPd5AWUr+0NRV+V40/Wcvr12pV8tUEE/Tnx6fscyZ1xY+LnA4
         LwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUW/0oX1GPWgNe1zd7vEv15Hxq4TFiRMZCgKm/8ULe4=;
        b=J1d6Y3sv+6EUrxqVgOHHKgO5MzUPeQoukXLfh5pJ+MVMeVnxFEkEmRMWDtkF6y2m1x
         EEEVRnPeJ18mZLU85hHxTR5P6SQtyI7aZ83Ypdjl0TzqgoaZKvxhmoMzDphybiEGHkYa
         c4JLi8CnjoTKVtkOqNbL58bDgu4btFekiWIegxRxV3yhdXrPuHZlOMAdTLE7bMwOP8yP
         NwtfIU38/FO/zWSSYVWmwhRn/lJJi/6CysxAJhkao9MuRISmwkwdFe09d9XAzTHEtR3D
         158XophTVcAlXufSO9CzNQcpNV7Fl8gXxAfb4Ez6lkLv9EW9px98iZLS7hFCxwNwRxsz
         jFkg==
X-Gm-Message-State: APjAAAWyMhpXA7dIK2G9qBcc9ngakLiOSXxZtTsPhT58hbSpF+BeDXdd
        zYHolwmRjSTlsuSXZpEkTcl00w==
X-Google-Smtp-Source: APXvYqx6NYeyh64Qt5sdHoPOjHpVXK780Jxx0ATdpoL2SKpw8hLl8FQkmM1vyuXbv6ErBoD+z5PQgA==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr3810546wmc.146.1552903919268;
        Mon, 18 Mar 2019 03:11:59 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z8sm6697855wrl.59.2019.03.18.03.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:11:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/8] dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
Date:   Mon, 18 Mar 2019 11:11:48 +0100
Message-Id: <20190318101153.7531-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318101153.7531-1-narmstrong@baylibre.com>
References: <20190318101153.7531-1-narmstrong@baylibre.com>
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

