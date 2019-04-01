Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102732146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PuwiY+gD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfDAR7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:59:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41224 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbfDARSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id d1so3118009plj.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=92at8vUta2fC2XN1pKFFPCkHFJWYYJixqtIuh16qRd8=;
        b=PuwiY+gDlXPS2BRq9eoaWfWDB2j1H9/9kFlbWKpKuyv8x775CHcSkF9PtohFS4L/AN
         MebDQWa6TzOmQI9Eube6euAXCCKTMrw6qMGxcM5K/N5P4sbK1MUGLtfvv7yQniVwylxv
         55ROovHraJqtpI0gXazttyeJFmpeBD8bAjIVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92at8vUta2fC2XN1pKFFPCkHFJWYYJixqtIuh16qRd8=;
        b=AjJIGyRHitOEFkrewY/KjmjfRsaXL4+cRkAZDlM+YwKYB2S4gmjr+mGsKSq5fbZYQY
         hd/pT2gmd1lvN9fed30D6e93f0zsi3JqtYXUoSeaw2I7yPQpEcj7zeorJk53gjIjDo8T
         FxuVKMOYWzdt/teJ8yY4chA7cbzaK4WUKDTz365dSYlgwCqyx3nPWFGYwcCLPAAd1tsm
         Sj6Vel2vY0a8x/tejcEmqGPKyePYS+LbtM9Nl48XdTvKz+Mn3+8mRc8no8uFZeE417pi
         pJ81bnPm43GHV5UOpRAVsp6ImXnkAbWV44itwK3hv2ifwV9RDIUgV9rW5t1ltP+LjgTy
         8/nQ==
X-Gm-Message-State: APjAAAUNn9vG05XQLGuqfvii+cGOMTVQUwGs0suvgCArgE0TbLqsf9FA
        YGmy4Xb5ciu9a0pEMYxOu9JV4Q==
X-Google-Smtp-Source: APXvYqwXPIDZF3EjTK+apAxCXhBFSTWfuVlSfZa4zc0Zr6UCqPiw0E8+9YtFgMTzXnmJco5r2/Nunw==
X-Received: by 2002:a17:902:b217:: with SMTP id t23mr66226168plr.184.1554139081162;
        Mon, 01 Apr 2019 10:18:01 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y12sm31370112pgq.64.2019.04.01.10.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:18:00 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 7/7] ARM: dts: rockchip: Specify rk3288-veyron-minnie's display timings
Date:   Mon,  1 Apr 2019 10:17:24 -0700
Message-Id: <20190401171724.215780-8-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190401171724.215780-1-dianders@chromium.org>
References: <20190401171724.215780-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like we did for rk3288-veyron-chromebook, we want to be able to
use one of the fixed PLLs in the system to make the pixel clock for
minnie.

Specifying these timings matches us with how the display is used on
the downstream Chrome OS kernel.  See https://crrev.com/c/323211.

Unlike what we did for rk3288-veyron-chromebook, this CL actually
changes the timings (though not the pixel clock) that is used when
using the upstream kernel.  Booting up a minnie shows that it ended up
with a 66.67 MHz pixel clock but it was still using the
porches/blankings it would have wanted for a 72.5 MHz pixel clock.

NOTE: compared to the downstream kernel, this seems to cause a
slightly different result reported in the 'modetest' command on a
Chromebook.  The downstream kernel shows:
  1280x800 60 1280 1298 1330 1351 800 804 822 830 66667

With this patch we have:
  1280x800 59 1280 1298 1330 1351 800 804 822 830 66666

Specifically modetest was reporting 60 Hz on the downstream kernel but
the upstream kernel does the math and comesup with 59 (because we
actually achieve 59.45 Hz).  Also upstream doesn't round the Hz up
when converting to kHz--it seems to truncate.

ALSO NOTE: when I look at the EDID from the datasheet, I see:
  -hsync -vsync
...but it seems like we've never actually run with that so I've
continued leaving that out.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- It's not just jerry, it's most rk3288 Chromebooks (Heiko)

Changes in v4:
- rk3288-veyron-minnie patch new for v4.

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index ca7512ade222..8179cf9f6e98 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -144,6 +144,18 @@
 	power-supply= <&panel_regulator>;
 
 	/delete-node/ panel-timing;
+
+	panel-timing {
+		clock-frequency = <66666667>;
+		hactive = <1280>;
+		hfront-porch = <18>;
+		hback-porch = <21>;
+		hsync-len = <32>;
+		vactive = <800>;
+		vfront-porch = <4>;
+		vback-porch = <8>;
+		vsync-len = <18>;
+	};
 };
 
 &rk808 {
-- 
2.21.0.392.gf8f6787159e-goog

