Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7E021841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GID1U+7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCVTni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:43:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44384 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfCVTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:43:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so2179134pgj.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 12:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xSSgrAiaxxZWP96mScjr4lKlzDB+sWWxKBZYp0XXBvs=;
        b=GID1U+7zvvk4Cp+XBZmnvuJwtIGqIUW9IuFQzLDJDhXI7goWxaOl5f3rtvDB1MY+om
         6R734TCKc7gUL3RDbRiIc7r94Tp6GiaEZSMN9GMyXFqfNy24pRIHfsupDTRe2+NH52ck
         3UvYUIASP7FjA8sBEpb5pe+XaMYVaGMUleJkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xSSgrAiaxxZWP96mScjr4lKlzDB+sWWxKBZYp0XXBvs=;
        b=PohElViBgG29egClpUVjGdJ2OM051hAHig5Q7A88svWjITKF0hDZ0HNm5D5MNBueQ/
         hIYn2asGD3YiQ1Po4Xd9Zycy6QCpUi8hVIl1fRpRD4I3DgxNSovzd6UnNz6dDBhx7YVA
         Tz6dSqQxBhQcmNdW3cHRFmqw/ukBO71q4A5WfI+mhBvmm0eQtj8Hb4IG6x+eF8Rax/oX
         CzXC8CsRDnxwm4MMmp0+F1qgvfrBQQzhBZT2wuO3/nnohokM9X5M1e7ONumuFe6bkw1a
         GYtIcjyXGz+eTXUgPKR51ws1rzUFxOVKtV+jBVTSJfZ5245eE2zK0FDuapfv4wTbnlYV
         lpGg==
X-Gm-Message-State: APjAAAWnKdCGRwK03184P1P5WrbhZLoQRN7u0wqrUwtrY8XcX8Y0HHIe
        rJs3rVjfF1Ss+b1z3M4XDmVEaA==
X-Google-Smtp-Source: APXvYqxi032oy4o5c3ll0psvqt+Z7Cr2NoGUKGXbO7Te6I5vD52aW3VT2D1zFHD5W5eOgpniux1jag==
X-Received: by 2002:a63:5ec2:: with SMTP id s185mr10482116pgb.27.1553283817235;
        Fri, 22 Mar 2019 12:43:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o3sm9699274pgv.50.2019.03.22.12.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 12:43:36 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alexis Ballier <aballier@gentoo.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: ARM: dts: rockchip: Add bindings for rk3288-veyron-mighty
Date:   Fri, 22 Mar 2019 12:43:09 -0700
Message-Id: <20190322194310.61365-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mighty is basically the same Chromebook as Jaq but it has a full-sized
SD slot and some different (slightly more rugged) plastics around it.
Like Jaq, Mighty may show up with various different brandings but all
of them have the same board inside.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 0161b4a66586..89f386852bc8 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -147,7 +147,7 @@ properties:
           - const: google,gru
           - const: rockchip,rk3399
 
-      - description: Google Jaq (Haier Chromebook 11 and more)
+      - description: Google Jaq (Haier Chromebook 11 and more w/ uSD)
         items:
           - const: google,veyron-jaq-rev5
           - const: google,veyron-jaq-rev4
@@ -200,6 +200,17 @@ properties:
           - const: google,veyron
           - const: rockchip,rk3288
 
+      - description: Google Mighty (Haier Chromebook 11 and more w/ SD)
+        items:
+          - const: google,veyron-mighty-rev5
+          - const: google,veyron-mighty-rev4
+          - const: google,veyron-mighty-rev3
+          - const: google,veyron-mighty-rev2
+          - const: google,veyron-mighty-rev1
+          - const: google,veyron-mighty
+          - const: google,veyron
+          - const: rockchip,rk3288
+
       - description: Google Minnie (Asus Chromebook Flip C100P)
         items:
           - const: google,veyron-minnie-rev4
-- 
2.21.0.392.gf8f6787159e-goog

