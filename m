Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DA2C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B622081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VgR98wkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfEBWyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:54:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45617 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfEBWy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:54:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id i21so1712492pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CT2YSqm9uY9lqkZxGu6xlzES7pBl2nIZjVIbCk84sRc=;
        b=VgR98wkKNANONfnbGrr9lcgFpOWUbpb8QW082Rc0rd/NK6ECJCvh6hOqvAFNGLwSuu
         a8kF9gsAk1gebx8VNGwe5TlF2czJn/t03cJrXt1krC8478dvOLahHngkZ6ZhXYl2ShXg
         ySGidUHXGZuJTt2LfafwCVBx7w9d6c5+uFKhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CT2YSqm9uY9lqkZxGu6xlzES7pBl2nIZjVIbCk84sRc=;
        b=ESuRz8QS9wCgEyEXDpBZbXrRcG/gHpkCR6gt818pU9sOSlbVlUBxeWsiASNhGho1Mn
         2jCGoxPmNKsLkHrDu16g7/US9Hr8achtENXVV92KugW4RhSiOPII8+4DEvO2ffDbByTf
         TBGzaE/plZd1dcY1pVs9Vr5HjuPSvFiH4ZWhW9iuCOjSswoecvcTqnWN8eTUxsX9vstx
         ks0/Xhs0sI6qxGVH1GBn1bIu0ags3aylZdh+Uk1gElFaMAAVvGp9FVAlvjFn/si2We7i
         eshNQpbd5R2H9JaNmek9f7ZjZq+EqHClQ+thfmAV/VRiakD72BuFdrQluPvqGGtI+bQJ
         U2kA==
X-Gm-Message-State: APjAAAXBgzVnf/98CIwibl0tn3C+eOwmmnGFNk0Mb+qq/4xKGa5O0bin
        ePbE7RxCFsTdleYMeN0P9Bnugg==
X-Google-Smtp-Source: APXvYqzTiOjbZQBE1y3q6em7X3hoV/eO9e264Ryqoxbr49JQ0+yN737erpxGaSnUtNHQVlpHiZsYFQ==
X-Received: by 2002:a62:164f:: with SMTP id 76mr7040966pfw.172.1556837668900;
        Thu, 02 May 2019 15:54:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v15sm264736pff.105.2019.05.02.15.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 15:54:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] ARM: dts: rockchip: Add HDMI i2c unwedging for rk3288-veyron
Date:   Thu,  2 May 2019 15:53:36 -0700
Message-Id: <20190502225336.206885-5-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190502225336.206885-1-dianders@chromium.org>
References: <20190502225336.206885-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Veyron uses the builtin i2c controller that's part of dw-hdmi.  Hook
up the unwedging feature.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index e1bee663d2c5..340b276b6333 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -163,8 +163,9 @@
 };
 
 &hdmi {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "unwedge";
 	pinctrl-0 = <&hdmi_ddc>;
+	pinctrl-1 = <&hdmi_ddc_unwedge>;
 	status = "okay";
 };
 
-- 
2.21.0.1020.gf2820cf01a-goog

