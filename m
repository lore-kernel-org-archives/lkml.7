Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE14C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85FB22CBA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O1Xy4Ph8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390711AbfGYQ06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:26:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33788 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390652AbfGYQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:26:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so23551379plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gG/c1rZYP/Lhsi0EI5Q4hiD7HEHYOFL8aq+0uJtZefc=;
        b=O1Xy4Ph8788g0Z4Il0vBcgtmO+JIakNribPM/6yKvje4aoJHvcCGsZdzzp0FNjNYhQ
         4/C2bAEJWnOSbANDuRkOqXzad7ebkfoVQe1Q3CAibxLHWGjYgShslvKDqYwTz5htwpVZ
         YVL3rwRVRSqsyKqZk6uCqe7iigXw6VDQRDhTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gG/c1rZYP/Lhsi0EI5Q4hiD7HEHYOFL8aq+0uJtZefc=;
        b=gTfXyIYNswHf8EIee+z6KcqNRlwJGJrPU6KOgyKXY6wNcbUcztIw55qZNMaHxdv6px
         WgprFlkl9YWc0IXUBUILRKBamGEvt0PCF8qLppkQ6BnfQRa06z3Jr07i5lYKEaHfgdKc
         f5fmwsQ/PIkX8qWt4ApIdWIsaGPKAaWCKuox4M+PRRCQ2amtNcEnVTbk+4OdY9+eDn7l
         A1tFbhBOULQf3E+oYFj9PE0xyOaxFAj2rknQuz6I754ZClmlfpLFERxLUEt7DFaWei0S
         WrDDlZRlTkZMCQNM4BQcwa1HZUFpwHKNv+YhVqik73PNdA5uVgh5ZwElqZvLlptBKyQM
         L/hA==
X-Gm-Message-State: APjAAAVrL81BhA8QHHx1/SeZSDKxd4b6vC3v8dDTW6z98N8i5LlDaVAP
        CHybyfADL+xmpziCrz8ZQusVwQ==
X-Google-Smtp-Source: APXvYqzte4K3dxMRHhTLkufFdXK9mPLrT5LC6RPLbefenNQRXKuDKLMvv88/r5XkgwQzItAZBCEeOw==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr86920964ply.251.1564072012666;
        Thu, 25 Jul 2019 09:26:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a5sm43394436pjv.21.2019.07.25.09.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:26:52 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 3/5] dt-bindings: ARM: dts: rockchip: Add bindings for rk3288-veyron-{fievel,tiger}
Date:   Thu, 25 Jul 2019 09:26:40 -0700
Message-Id: <20190725162642.250709-4-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190725162642.250709-1-mka@chromium.org>
References: <20190725162642.250709-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fievel is a Chromebox and Tiger a Chromebase with a 10" display and
touchscreen. Tiger and Fievel are based on the same board.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added to the series
---
 .../devicetree/bindings/arm/rockchip.yaml     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 34865042f4e4..01eb1e107ea6 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -128,6 +128,21 @@ properties:
           - const: google,veyron
           - const: rockchip,rk3288
 
+      - description: Google Fievel (AOPEN Chromebox Mini)
+        items:
+          - const: google,veyron-fievel-rev8
+          - const: google,veyron-fievel-rev7
+          - const: google,veyron-fievel-rev6
+          - const: google,veyron-fievel-rev5
+          - const: google,veyron-fievel-rev4
+          - const: google,veyron-fievel-rev3
+          - const: google,veyron-fievel-rev2
+          - const: google,veyron-fievel-rev1
+          - const: google,veyron-fievel-rev0
+          - const: google,veyron-fievel
+          - const: google,veyron
+          - const: rockchip,rk3288
+
       - description: Google Gru (dev-board)
         items:
           - const: google,gru-rev15
@@ -311,6 +326,21 @@ properties:
           - const: google,veyron
           - const: rockchip,rk3288
 
+      - description: Google Tiger (AOpen Chromebase Mini)
+        items:
+          - const: google,veyron-tiger-rev8
+          - const: google,veyron-tiger-rev7
+          - const: google,veyron-tiger-rev6
+          - const: google,veyron-tiger-rev5
+          - const: google,veyron-tiger-rev4
+          - const: google,veyron-tiger-rev3
+          - const: google,veyron-tiger-rev2
+          - const: google,veyron-tiger-rev1
+          - const: google,veyron-tiger-rev0
+          - const: google,veyron-tiger
+          - const: google,veyron
+          - const: rockchip,rk3288
+
       - description: Haoyu MarsBoard RK3066
         items:
           - const: haoyu,marsboard-rk3066
-- 
2.22.0.709.g102302147b-goog

