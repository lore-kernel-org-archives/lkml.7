Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17544C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D532E20693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TPS/dpoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfDKXXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:23:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36119 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfDKXWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:22:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so4181952pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 16:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyUtO6FBL1xGO1LJ/Cb0qrWJLFLRp1Daf+h1sPg+o68=;
        b=TPS/dpoQuEcPL74mFmY5Uu60oJSHdAOiKPcubSb51l+oOx9K6r+U5YweUjegwXEhNk
         Ak+ZDNB5BJbm2Dwp5VgYogWw3aqICJd/kHSUrL/fEc0SKuJbzjOtBFUEJ+kiljE4vK5e
         FMpSlLeSusSGvEg82D+uwsy5EklfJ/Gm9EAJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyUtO6FBL1xGO1LJ/Cb0qrWJLFLRp1Daf+h1sPg+o68=;
        b=RGe3adb74akxR7OI9TlBVFSXiFXvrHZNrLfHCKLqgu8vzRkuWV+iJJEfztCisICH0m
         eSwGzYATgeqn4INOdQQBvZLio5Gtx8A10Sxnw5eEepSEudcbKOVHFPBKvJWWQoLkDOGn
         PrTv2vrWeZ22vnjnoSv+NK3IBm7hX9p0G7fCfUpmLa9dCGqxhG70qeRaNxOd5L0oc9Dz
         cn6tTq976D+T/5OET9veIgzJfioc0hna8tvMESpHq0BPZq6H1Ipkr6tsgGS8QsryW9jy
         iOTc+SwCtD0yh3oYstI+WXGwjSV9ihqOc3WS8fgeXZGB+QYrp/cCVfd8aXVixqqYMd12
         vD2g==
X-Gm-Message-State: APjAAAWVEMosS61Waa5hzDtqfedeT0tTNhHaF2OAd+HZqnxm1pkRAmqx
        /5FqY9Es1uFLvIUs/M1Z3YTvJQ==
X-Google-Smtp-Source: APXvYqzs4AKfNFevOdhKmdg8KcOTyRngwms5IiA0+9tyh468oqtIH4NxO2YYemeRS8vq4ZNVmBoUdQ==
X-Received: by 2002:a62:2fc7:: with SMTP id v190mr51345536pfv.10.1555024972090;
        Thu, 11 Apr 2019 16:22:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y20sm37288903pfe.188.2019.04.11.16.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 16:22:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     dbasehore@chromium.org, amstan@chromium.org,
        linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        mka@chromium.org, ryandcase@chromium.org,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] ARM: dts: rockchip: vcc33_ccd off in suspend for rk3288-veyron-chromebook
Date:   Thu, 11 Apr 2019 16:21:56 -0700
Message-Id: <20190411232157.55125-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190411232157.55125-1-dianders@chromium.org>
References: <20190411232157.55125-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per my comments when the device tree for rk3288-veyron-chromebook
first landed:

> Technically I think vcc33_ccd can be off since we have
> 'needs-reset-on-resume' down in the EHCI port (this regulator is for
> the USB webcam that's connected to the EHCI port).
>
>  ...but leaving it on for now seems fine until we get suspend/resume
> more solid.

It's probably about time to do it right.

[1] https://lore.kernel.org/linux-arm-kernel/CAD=FV=U37Yx8Mqk75_x05zxonvdc3qRMhqp8TyTDPWGHqSuRqg@mail.gmail.com/

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index b9cc90f0f25c..fbef34578100 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -176,8 +176,7 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-state-mem {
-				regulator-on-in-suspend;
-				regulator-suspend-microvolt = <3300000>;
+				regulator-off-in-suspend;
 			};
 		};
 	};
-- 
2.21.0.392.gf8f6787159e-goog

