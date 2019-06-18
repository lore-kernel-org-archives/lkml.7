Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF20EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF3221479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eTLQc07P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfFRSph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:45:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42063 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730073AbfFRSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:45:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so3844366plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jQCPKFxQyeSljUm6aB/gqdIOd3dtcUj6g8UhIWN1Is8=;
        b=eTLQc07PucKs+X7BOPweNGE+V+Q9FmEWSs8OWmT7a5cmubwmy2LVuja1aiT3ZV4mYe
         AYCQ1hHwNCGgGe2HNK41ICyUFLMpjAswoA9BVxN2YzEGiQPBBscEQoZyQKGhIb+JoUAp
         BHwZBRhCBo6lonJBzzgVZ9OHHuP8THWAtX7Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jQCPKFxQyeSljUm6aB/gqdIOd3dtcUj6g8UhIWN1Is8=;
        b=pCwTWs+sBzvp4hzxrZaHNXB76Sqr4kMiV81kFiSvOGVX82XooRw/fYcqR5+3eVkaWm
         OrDk4zIA7+Z/YL16B46LAC3PxkIykJd/WLMtYzYvVLG+Y91EahOSaLxlTSewz7jz3TF/
         QG/YZYJdZAJ425oVpvKd4RZj+kt1RlsbGBQ33tuGqKV8CDwxOhaMqAnl+2Otcb/zNSeE
         ClFyN6JLPhwvzVD3bjffyERXGFB6CMw5MXTTLYcQ+x5ELiZu9eBrrE5CL9soEuB0WTCX
         lQr74/FoFCSttpF4kUAbfnAl+lCeGCDRzFQP8+ZVyPR6YDiUKIs23HIAvbJiIiXLQ4xY
         uKJA==
X-Gm-Message-State: APjAAAXG2OpiOWiLZDEiiixneJcd8vXqGAdL+fqgC3tNUvk38kiM0qfg
        dl3gvOICflP9FWD2lLzu3T6mdQ==
X-Google-Smtp-Source: APXvYqzdyMQm5ebsWKiLT9a2PALu7WQE/3ZGEacfk5lHvzhAmUbdQoYOrxUvz1QdNdOGzC4K4Ppfkw==
X-Received: by 2002:a17:902:e282:: with SMTP id cf2mr93052072plb.301.1560883536360;
        Tue, 18 Jun 2019 11:45:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g1sm847758pjx.22.2019.06.18.11.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:45:35 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Pavel Machek <pavel@ucw.cz>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] Revert "ARM: dts: rockchip: set PWM delay backlight settings for Minnie"
Date:   Tue, 18 Jun 2019 11:45:31 -0700
Message-Id: <20190618184531.1137-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 288ceb85b505c19abe1895df068dda5ed20cf482.

The commit assumes that the minnie panel is a AUO B101EAN01.1 (LVDS
interface), however it is a AUO B101EAN01.8 (eDP interface). The eDP
panel doesn't need the 200 ms delay.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes in v2:
- updated commit message with details about the source of the
  confusion
- added Enric's "Reviewed-by" tag
---
 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 468a1818545d..28cbe07f96ec 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -86,8 +86,6 @@
 			240 241 242 243 244 245 246 247
 			248 249 250 251 252 253 254 255>;
 	power-supply = <&backlight_regulator>;
-	post-pwm-on-delay-ms = <200>;
-	pwm-off-delay-ms = <200>;
 };
 
 &emmc {
-- 
2.22.0.410.gd8fdbe21b5-goog

