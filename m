Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5837C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B3B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ggYWu6M0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfCYJkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:40:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51264 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbfCYJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:39:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so8099762wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1H3HhuutqaciX5XVa5YZyQWcZq+QYJmYc29n+3rNfQQ=;
        b=ggYWu6M0lcYH0SFGGbjyR07csG5yA9YAqfV5f+dVtqAhewryPwGROqC8IVkUNb+IhQ
         IjuLZnavwp8UPNFc0MIw0FBqt9kB5P/JGFPNryKY6CVefvSyZ6krItF1GGBmhd/NTWID
         pJ6698x8x03W5w9bpbq8VxE8n1Hk9zf07zFe/l6l1TBMLw3Ro2rcypdxyisfDZbXmbd9
         X/8KmVSfETGhT69cMPuWkXmJxJNe4lo/6B5lXd3jPMmOIFUChLCEVCT6+Ouptl41inJr
         bVhhftRXXGHTVMrd+JRpsQD3ywy8DGMYdjL0NBS5arGmyyZPaT9CK22tWmH3wte0bLdk
         5xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1H3HhuutqaciX5XVa5YZyQWcZq+QYJmYc29n+3rNfQQ=;
        b=YROFhvTGKPmtx1p6rrDMBlfsidgDcPqlUOCLd1Ur/pKdWMo031L9oDBvyuXuh6uUzZ
         4x5hc0FnbloSxALtJo49yP8TkL00Hb+nOQQULcB/9e5G2UwICHlUQyNJHIwS5MpAN1/C
         L07YRmwVrZvZvydRYcj9c4H0HiZB8JEnChD1VHqv8pA5VU+u7pV9YfNPAe+Wo9/FmFPQ
         IX4xKtdWEhUxkog0i0uYbRCr8r7cxmVLOw1Svl+930noK1h2aJweS3KMcKdyLua/OEj3
         8Hfr9xAtmDMWtIGIAYCz9kpGyIy6TjOKMTjNwCOlPvDE7PiYmduc3cE/jOIhdDHsp1MV
         ZSJA==
X-Gm-Message-State: APjAAAUUW8njf1UOvy59q2EtEcGgqgchg5a2MAG1XMab0Vf/y7agQ3OQ
        Nx/cXyGYqu/0TN79FzFqpBRxZA==
X-Google-Smtp-Source: APXvYqzEsEVmvUFoI3dm4C24sHpiaLCRoewBE6PNEECQ7c/KJ1zbK0yqsySzVvFoGLhx+bvU3y7etQ==
X-Received: by 2002:a1c:5f89:: with SMTP id t131mr4620764wmb.145.1553506789720;
        Mon, 25 Mar 2019 02:39:49 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k14sm13044652wmj.26.2019.03.25.02.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 02:39:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 3/8] dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
Date:   Mon, 25 Mar 2019 10:39:38 +0100
Message-Id: <20190325093943.29138-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325093943.29138-1-narmstrong@baylibre.com>
References: <20190325093943.29138-1-narmstrong@baylibre.com>
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
2.21.0

