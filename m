Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3FDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1241206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C0sXUDY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfC1RSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:18:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36914 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfC1RSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:18:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id q6so5257605pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vt45JTo9+c6j8dWNrO0OHz+tpId79deEfwrm9YqjVA=;
        b=C0sXUDY310SL/SQYeRt4iQe5a7IZUNKd2ajEsEMma+zuySpcP46oeny6KE9+HvqCCb
         fN8X9jGjPYtVY98XypzXk7M779imEhiwyHtsPbCogehzomsLOXt5a0NgUr3tZU+p50UY
         GsxEaaAIt0s/GZv1v0PtUwNUIWSAb8nqrs8FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vt45JTo9+c6j8dWNrO0OHz+tpId79deEfwrm9YqjVA=;
        b=gxCRf2R70jyxpW7BeM8+H1lnP5hPEbkWCZYInqAgUNzkcf/BsJOcOW+BsSVctoG26i
         hdMGq8TbQa/wEalLY/NrCD1/i7kFew7JQ55w/yU+5aIl52gdXPnxHEq6GDzgr0p7h5js
         h2teoKViznU7DQTRpJ5iyji+bxaiTMQcIb2VTSwKAEClpY8h5LrKzGtm0bphnBfgHObl
         X2m3QjIlS4soRar9PECAgwXDY5CljGSVaL6edQI98AP3euYbHSVXDdSXkr01IlXiJRon
         uqJ6nMFSJeD0PpXRnJm/GBudkXljyF+sl7KYiTAKjGzfHGwIQ2JDDElkp28P/MpY4M9g
         eXHA==
X-Gm-Message-State: APjAAAUJRIHHiw868oseIP6lGb6GrpVEfREHsFZ+FD7LlY5IuHaHqc1k
        AaKbi4gM6bqZkFaPu5xLGsq9Ew==
X-Google-Smtp-Source: APXvYqy6oeccNYbpih420nJpkiSJvEecbt9/dnOQ+Wdy7u1wEm70eNYUBkQD9q8fhTg2nXIVeJ/zvQ==
X-Received: by 2002:a17:902:7587:: with SMTP id j7mr25505653pll.304.1553793483508;
        Thu, 28 Mar 2019 10:18:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r10sm31699414pfn.188.2019.03.28.10.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:18:02 -0700 (PDT)
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
Subject: [PATCH v4 7/7] ARM: dts: rockchip: Specify rk3288-veyron-minnie's display timings
Date:   Thu, 28 Mar 2019 10:17:10 -0700
Message-Id: <20190328171710.31949-8-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190328171710.31949-1-dianders@chromium.org>
References: <20190328171710.31949-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like rk3288-veyron-jerry, we want to be able to use one of the
fixed PLLs in the system to make the pixel clock for minnie.

Specifying these timings matches us with how the display is used on
the downstream Chrome OS kernel.  See https://crrev.com/c/323211.

Unlike jerry, this CL actually changes the timings (though not the
pixel clock) that is used when using the upstream kernel.  Booting up
a minnie shows that it ended up with a 66.67 MHz pixel clock but it
was still using the porches/blankings it would have wanted for a 72.5
MHz pixel clock.

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

