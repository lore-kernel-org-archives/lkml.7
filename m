Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7230C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0362214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zDLfJXO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfDWIvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:51:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40407 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfDWIvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:51:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so17856031wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1H3HhuutqaciX5XVa5YZyQWcZq+QYJmYc29n+3rNfQQ=;
        b=zDLfJXO39CUmp95Ai/ksmyDI9XHay6nQzRnKtjQ2i8UHKXeEP28qNnthrBCPqTV4Uy
         y/G1NORz8CVzk9Cu3mTyeTzg+7R+PwWGjtLX7L34SmMDghYjE0BfEhd50CGEGTVFUp7S
         kGYdeldsWFA2dm0/bxlQLIJyBDFu6GkNkK89t5k2Hj09sr3L4tKuxOksYZLq3oYwRFTK
         JOohS6Hr9Fb64gzVB/Q8ULzq1kA0pAlMW0LU5zLT00kp+DLcHCd49p/MBc7zEHAZ+xUG
         RtbGZ2Cra3TB2hNpZ8vP+oMnBPGopX6EZsWb/5ox5neyRCCg5q5pfydTs7OIkJuyh4PE
         PjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1H3HhuutqaciX5XVa5YZyQWcZq+QYJmYc29n+3rNfQQ=;
        b=DtI7V+FlMxvBq6xzXu8sJVp/b87ua6MOVc6uoB8NS/Wvd5RHVL1ieI0zwj8p2q4YCU
         HQUno3k0LBSIpm6d+CWhUjxwN/f5kgIh9CPqSeUWAV95Ke/Uf9/AOi2wHqYKCPk2Rcay
         1sV8VvKFpBYgdAXAFTeW2wQQSorcZ0K6+0Ef61HZLvwtg1beGpSlSJ+b5IX0DXb32U4b
         gE+Zp9BOMU/vq3iwi+CZr98HU4PPHNbx/5uUcwEU5Ep3AW0UoJfHR8Rrj7Th12d5XBYK
         cXsmecDL16M55/5R8wbkCsklWMq8oT/SQwKEUM1bS+cYZ9hvyOS9hWpnLnwF0UUNjC15
         0xbQ==
X-Gm-Message-State: APjAAAVGnGq7iAzOJPoYmrW2V6rJQ6NRoEJEx4KFsCPWNRzBq0YU1v0a
        wqvkC7i4+t9xp7VtKRx5XjMf4A==
X-Google-Smtp-Source: APXvYqz7WYQn3ddhxQGgEV0tPmUF4XhHH+DjXXbgvObw/DvJbVNAIQR7c5flZU8nKuvJ6DfIpMCjlg==
X-Received: by 2002:a7b:c3c9:: with SMTP id t9mr1315184wmj.131.1556009491848;
        Tue, 23 Apr 2019 01:51:31 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b8sm12515566wrr.64.2019.04.23.01.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 01:51:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        chunfeng.yun@mediatek.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
Date:   Tue, 23 Apr 2019 10:51:24 +0200
Message-Id: <20190423085127.3863-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423085127.3863-1-narmstrong@baylibre.com>
References: <20190423085127.3863-1-narmstrong@baylibre.com>
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

