Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A119922419
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="br9zeWUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfKTLlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:41:10 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44341 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbfKTLlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:41:09 -0500
Received: by mail-pj1-f65.google.com with SMTP id w8so3999334pjh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xa375NGyNLSVnAvUIhiexdZMHOh3jJr15Iilt7lsROI=;
        b=br9zeWUDYiYk6Bp4Q3ti8c8xmEnL2VphTTq3kUzwTmCugAMDslZGGCegVcP/lF5cS4
         Mj3jiArvXS0+ppM7ifUaogwgsY2W1Y2/AHlZaZGkr32mY1I6foTkauKWjQGT1F+Bu53t
         5Vh3BZgvvrWEkI4HzzZdpZ5AIVvx73SIUXMVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xa375NGyNLSVnAvUIhiexdZMHOh3jJr15Iilt7lsROI=;
        b=kUsUU9VTnIfKsJ3jI6bNg9kZGykERWKzH4RNLnkGn58NcLugbX7SOVMSVz7ybjDDPa
         glxODefWtKnES+ZodErDcidWebFn6O+oqYE/y+BnW1kmy8Kj5UT4HkwyhINcotzJWdqZ
         CxBxIl9tf681afHsojvUTDeIuyVQk45rv1Rbc1dTw4ySFBmQKMG03U7W9rAVisp60C30
         h2X0u+sH42UO9I6G488eteVkNSevcOlpgbf9+0p0koM9SnEuhWAOj9Tz1UI3/+O3stu6
         G/IGDCp79qYV9FfXMLY8W2f4/ZbJ1houaiSJSNQrV32h47xIlEPu3Jfb36DvncUUL9J5
         k8Tg==
X-Gm-Message-State: APjAAAVjV/aeo5woHwkVY/zu9ZX+PXXoZMIF1L1i13De94V94d47Hy/9
        JhkJ0H6QhBgILtZRmrPM4FGe/w==
X-Google-Smtp-Source: APXvYqx7Lv1/ePIi9JWMgF5xDVKBWDF1PPS99Tf2BlcWR98xDepPj+Num/8WUU4ze3qL6xGCcEZiSw==
X-Received: by 2002:a17:902:6807:: with SMTP id h7mr2384938plk.230.1574250068020;
        Wed, 20 Nov 2019 03:41:08 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id h185sm13492850pgc.87.2019.11.20.03.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:41:07 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/5] dt-bindings: arm: rockchip: Add Rock Pi N10 binding
Date:   Wed, 20 Nov 2019 17:09:21 +0530
Message-Id: <20191120113923.11685-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191120113923.11685-1-jagan@amarulasolutions.com>
References: <20191120113923.11685-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi N10 is a Rockchip RK3399Pro based SBC, which has
- VMARC RK3399Pro SOM (as per SMARC standard) from Vamrs.
- Compatible carrier board from Radxa.

VMARC RK3399Pro SOM need to mount on top of carrier board
for making Rock PI N10 SBC.

Add dt-bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 51aa458833a9..63d34520c72f 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -423,6 +423,11 @@ properties:
           - const: radxa,rockpi4
           - const: rockchip,rk3399
 
+      - description: Radxa Rock Pi N10
+        items:
+          - const: radxa,rockpi-n10
+          - const: rockchip,rk3399pro
+
       - description: Radxa Rock2 Square
         items:
           - const: radxa,rock2-square
-- 
2.18.0.321.gffc6fa0e3

