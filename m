Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B69FC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6DE2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PfiRWyhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfHRJeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:34:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50621 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfHRJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:34:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so517263wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3B6AxKAVmhTH5yjifOlS2cxjq6vLW/Jkk4lzyfrHej0=;
        b=PfiRWyhj3EoaKk4s24rEBm7ogBIuGodXl7gBoK84Adcotull3MSruCNobdbhPjSDmZ
         GD1ELNu2P9eLsrfZTPMkyIdVhQeMAH76qaNO+JZV00+VuS2H/9sdYrwWEjzRGc0Z1tdP
         8gsN2kOp3ufy0SuN6yUuF9ur6FC7zevwWPQklPmB/Ir0hn6lXkRymXQovCSAqKx09ztx
         k+jC66LKglw185k9lJk8BgizZi5oTvWzkmQETG0tmkohdG8wi8EAxd4a4o1QAn9lnWHC
         9knAnTHHfgty6ThUhkrttHmhlesrHKbb02WMr+mT/wehL2+aLbX3ZlAmzItymUFaYMXV
         nt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3B6AxKAVmhTH5yjifOlS2cxjq6vLW/Jkk4lzyfrHej0=;
        b=oyygkwFU91zcC8DkSKg26LUjmbZj/zJlScCnIXb26vn8Y41+sFrWHfHkrgldLtaAS8
         WPTzsV9oISBJKnTziO2VdiA+FLjeKyUHyqtIuBWozeLtjmIIv33o8T4u1gWM2muMbj7n
         CedXrFX927O5z68t93vt8m8tj7IqITPBDPlVb7yUX7yqH1SPmVY9ZAkV72zJD8e3EPCU
         DMVQhO4H99sa+Y023u/wdt/XgWqaQT5zksr3BJkMjdJxzMvZ+vKLkVRS7RHiAxrxIbHg
         4ahCfFc42URnVPmhMtGUpXezQHUKY/wUVybuwakNmgmrqyX2k3nsNeSFEe+jDYTAoeFl
         Dr6w==
X-Gm-Message-State: APjAAAWPHlvuoedS7WrF0v28Ni2HkVVyRpSK/vSl80yJjWMKI33gH65Q
        c4r7/RwUoEhoj4tZ8OTL2d89NQ==
X-Google-Smtp-Source: APXvYqwtA2W/G8LiNZduDB03kgUguKjsViE8hOgX4YrmfUvgW+yQBP5lWy27TJqm1IGFyULuYxoEGQ==
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr15935750wmf.161.1566120881919;
        Sun, 18 Aug 2019 02:34:41 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w13sm25042828wre.44.2019.08.18.02.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:34:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/7] dt-bindings: fsl: scu: add new compatible string for ocotp
Date:   Sun, 18 Aug 2019 10:33:44 +0100
Message-Id: <20190818093345.29647-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
References: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Add new compatible string "fsl,imx8qm-scu-ocotp" into binding
doc  for i.MX8 SCU OCOTP driver.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index a575e42f7fec..c149fadc6f47 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -136,7 +136,9 @@ Required properties:
 OCOTP bindings based on SCU Message Protocol
 ------------------------------------------------------------
 Required properties:
-- compatible:		Should be "fsl,imx8qxp-scu-ocotp"
+- compatible:		Should be one of:
+			"fsl,imx8qm-scu-ocotp",
+			"fsl,imx8qxp-scu-ocotp".
 - #address-cells:	Must be 1. Contains byte index
 - #size-cells:		Must be 1. Contains byte length
 
-- 
2.21.0

