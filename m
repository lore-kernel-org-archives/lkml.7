Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AEAC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936842173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdDW/OIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbfDQRa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:30:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53094 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733042AbfDQRaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:30:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so4348726wma.2;
        Wed, 17 Apr 2019 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kdl2HLHW70ntA/K0rj6AA2zlxJSYSzmovpJ45Rbdc0c=;
        b=WdDW/OIqEWCV869Zlk47vlcYn69NFnuxXYOpNiTsMOhdeW065WuDvBIpj46z4eey+Z
         CSm7Y3XIxb4jPKAoVGNj4DcZBmuRSV3ngRJqpCnoZB7bi9eyhRXz3YyX3GBBabZaU9bM
         CBDBtsa1q1jc9HJoS432wV4kQLwoLJ/na8JQ6DU/mk/M1gHMGRQeQ6HFUQXFeedkppB4
         Q0rB1hvII6Fhul7M97Vcnnyahkr5oYk7Xb/uq9KXUB3UuQN/nIhx3/HZFlKWhPFld4Ha
         4ocMhF8XsgwhtXfvVqdRSWCFaUEn9n3bhxpQ8QzW17cG0ikBycV2DKOGdezphkQJCqcS
         pnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kdl2HLHW70ntA/K0rj6AA2zlxJSYSzmovpJ45Rbdc0c=;
        b=ifuqWjLLTW/FW1hUnxfq56tgNlFdynqi2G9omN0+HWg743hVGjjsrFDedX/Vty9WUd
         SGxjLN4qj6VjbfW+EVvoYZmZ1oR/NErdIOgcZGXS/QXoFx16YOpu+de5tmrhKlR15wC0
         pBCivVeo72Gug0c+TT/ve51Oeb5swP70Xh9oAjJKVbKm5GG2F1JM4/NtCtlvEsl68yLy
         IFp5Ce1vMO0IkP4OeahrQ1+aU2ykvp6udkFN+QgBmrc0ANHYx7DDJhpHK24RCVu7Ml6R
         4EKSIaHm95Wyz79wH52/xSo7JTSEB5U+jQpdyWCMD4cnZHqrYHgl7IIkswtwwWkw7QCK
         qhAg==
X-Gm-Message-State: APjAAAXcJQXisGzDdX6N7tEd2IglzM6ss8Rjx49Za3l1s/QeB9a1xdvx
        WK6YiE1qELwrG2mTqj60beI=
X-Google-Smtp-Source: APXvYqwyGY/wOiRSL0RJvXiA2emmo4L2E5scQmpjfBKtPTcLAMkig5bTub9IXtPSi7Ty8GxNH1cD2A==
X-Received: by 2002:a7b:cb16:: with SMTP id u22mr601497wmj.60.1555522223267;
        Wed, 17 Apr 2019 10:30:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id c6sm2669306wmb.21.2019.04.17.10.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:30:22 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 3/8] dt-bindings: gpu: mali-midgard: Add h6 mali gpu compatible
Date:   Wed, 17 Apr 2019 19:30:26 +0200
Message-Id: <20190417173031.9920-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417173031.9920-1-peron.clem@gmail.com>
References: <20190417173031.9920-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the H6 mali compatible in the dt-bindings to later support
specific implementation.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt         | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 2e8bbce35695..4bf17e1cf555 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -15,6 +15,7 @@ Required properties:
     + "arm,mali-t860"
     + "arm,mali-t880"
   * which must be preceded by one of the following vendor specifics:
+    + "allwinner,sun50i-h6-mali"
     + "amlogic,meson-gxm-mali"
     + "rockchip,rk3288-mali"
     + "rockchip,rk3399-mali"
@@ -49,9 +50,15 @@ Vendor-specific bindings
 ------------------------
 
 The Mali GPU is integrated very differently from one SoC to
-another. In order to accomodate those differences, you have the option
+another. In order to accommodate those differences, you have the option
 to specify one more vendor-specific compatible, among:
 
+- "allwinner,sun50i-h6-mali"
+  Required properties:
+  - clocks : phandles to core and bus clocks
+  - clock-names : must contain "core" and "bus"
+  - resets: phandle to GPU reset line
+
 - "amlogic,meson-gxm-mali"
   Required properties:
   - resets : Should contain phandles of :
-- 
2.17.1

