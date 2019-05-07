Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8135DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51908214AE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mNEn/Vr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEGL6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:58:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfEGL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:57:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id o4so21954690wra.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iSJwm6tn+7I484rTSQE+9G4s/2gB2UbS4DNi3jkBUBM=;
        b=mNEn/Vr/31eZbnej6Dg0h/hnFDWLlkBcEwMYlTvgR2fZfYHhc8C86b8PHfbQ10RhzE
         OTskncyXPrt0dQjKrKukwuPSxLnLMTzkzUR2z/Jkxb/a+6WDwCVt4lv3ZaF820tYaIob
         tuf16F2dSjNiqPkH5gm9OnbrpTFTKxf6LyzurPi+Va86c17sUsuCrBpGchuK5J17m5xO
         rg4PXE6327aNDlU7NbYNzBVWS91nqt5zldFzY21IhWqlP4FsirL85mUIAQg6/3AB0z9/
         NmnLL1w7VliMQj8ox1Vj6xZ0AB6ypbombWuknSOgJ9y351oasZ0zgBY6yh9HlysKvuq5
         8wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iSJwm6tn+7I484rTSQE+9G4s/2gB2UbS4DNi3jkBUBM=;
        b=QhYT6esPgWBZZgEIZt3iBjOmZ/wDCGcpK956+kcHwReJ0Ts0azPXpoxlbghrwo9Gx+
         0o/WNbgqEzOu3JmWT1lYADlao+HtUpBahZZ2+xxIHFv+yJfQbA9BMxjndXH4kHDyGLJs
         4r+kMaqWcgmVo3HlF8pOq7tTtKCR6pOi7fKqrnd9417b6Btzsd5+pZQLVi6/1zJv1mRW
         uQvjbX7Hl/x6VJc4X9JSV6IMyk4lkavZGGhU8DHvgNyG5Mz/+yq9Nsz9R91p8wE2pebP
         /5Vhg5ee5oOwMTvIJVQN9ryytaJg4xXGyo7II8PiuLNQSnCeJKwj2BWoT0s+ZYTVhuKm
         3CQg==
X-Gm-Message-State: APjAAAWXupiQeMjGq1jHNuJm87059aQv/fRc40c5BG6K+9LGQCOEpTXJ
        YgAmc2pRF7iqyfdIe2ZKVAnubA==
X-Google-Smtp-Source: APXvYqxDAVU5GNWwoSpkR+LWWEpkvnXYCivvCs72/0tzaSmpcVNC5sOdYuZ8yVIH+uK3uM0DEJJXRw==
X-Received: by 2002:adf:eb50:: with SMTP id u16mr10188307wrn.54.1557230251531;
        Tue, 07 May 2019 04:57:31 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s11sm7120274wrb.71.2019.05.07.04.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 04:57:30 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] dt-bindings: pinctrl: meson: Add drive-strength-microamp property
Date:   Tue,  7 May 2019 13:57:23 +0200
Message-Id: <20190507115726.23714-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507115726.23714-1-glaroque@baylibre.com>
References: <20190507115726.23714-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional drive-strength-microamp property

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index a47dd990a8d3..a7618605bf1e 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -51,6 +51,10 @@ Configuration nodes support the generic properties "bias-disable",
 "bias-pull-up" and "bias-pull-down", described in file
 pinctrl-bindings.txt
 
+Optional properties :
+ - drive-strength-microamp: Drive strength for the specified pins in uA.
+			    This property is only valid for G12A and newer.
+
 === Example ===
 
 	pinctrl: pinctrl@c1109880 {
-- 
2.17.1

