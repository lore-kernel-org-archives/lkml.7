Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05489C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 23:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9DE206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 23:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hijO8nHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbfFJXhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 19:37:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37047 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390656AbfFJXho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 19:37:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh12so4261991plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 16:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwvhwkI8F4zvLVsJwAGnKk3UZTvA+WVT+qCBY1uqWqg=;
        b=hijO8nHj6AanoC+to/aLESdGAjYajAq/Wwo6ROP8Jh065ysj+O/VWUY+CjGk1QGNLO
         Nzjj4CGR7IV5n0DZhEvJ8T9VttRm3HNbJ8f655p8CVolKCbEHYeRHF0Q7pT55hBt7oMM
         UA5ufOa5wv1gkQHsFvqsinxJo7kP1Tysa/l1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwvhwkI8F4zvLVsJwAGnKk3UZTvA+WVT+qCBY1uqWqg=;
        b=K3FiSmJP25kkrA3lgnkPGF6sq9MWu/G2WI7lBLQmRZg6QAfhOCPROBTsYJf7w4w2XM
         WuFCDVcTJMwzhibMVjJXJRMoAoS8G33Thz4+R7KU8wO7K2pNdBgVVWHLL2Wdo2AXRdLx
         w7xjiQm8lDuAQRc5I+z+8KGQU6/0kzAFfdChpOfNXzShJCmdr1NkDRShlkPuc7/zAH+8
         s3oSnTEEO6w5FYf+Q1Byz2JUXitPVylVuzhA58frNAjvrUqYb2bbVJxglQUeR8Je4oUd
         nu2HDEWW5EIZDAlj1/fhuUpNoES66GFe+J68HqUUqH5du9w5nZxmE1psDitPkkemcTdO
         63hQ==
X-Gm-Message-State: APjAAAXl6br7WfoDbrEdtCSr26BRm6Wcp9oY3Umi6CBnT2BQchomrcU8
        keFfXIb4+uDTASnJenVHJpdxPA==
X-Google-Smtp-Source: APXvYqxzuWk+HHUFs0uzAZUj3UB9CiltN6z/LVO8neBboHeE9VutR2V17/0JmmVYiipinsqCD9j37w==
X-Received: by 2002:a17:902:7581:: with SMTP id j1mr72670630pll.23.1560209864163;
        Mon, 10 Jun 2019 16:37:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q144sm8898518pfc.103.2019.06.10.16.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:37:43 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness' property
Date:   Mon, 10 Jun 2019 16:37:38 -0700
Message-Id: <20190610233739.29477-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional 'max-brightness' property, which is used to specify
the number of brightness levels (max-brightness + 1) when the node
has no 'brightness-levels' table.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
index 64fa2fbd98c9..98f4ba626054 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
@@ -27,6 +27,9 @@ Optional properties:
                             resolution pwm duty cycle can be used without
                             having to list out every possible value in the
                             brightness-level array.
+  - max-brightness: Maximum brightness value. Used to specify the number of
+                    brightness levels (max-brightness + 1) when the node
+                    has no 'brightness-levels' table.
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 [1]: Documentation/devicetree/bindings/gpio/gpio.txt
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

