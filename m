Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB78C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC7120693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sr77n9xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfDKXW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:22:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34112 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDKXWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:22:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so4143428plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dL9JtcZ92ryYmPw47PdDoJyrwRFQyhVA65jTVCpTryA=;
        b=Sr77n9xkvP4TmRJRlFx+/1VN6Dgqc6UfpixQ1GSApsVFnAs2CAIlHTRNhdSholz9gh
         E0W/+rxbcVE4Sk0kKEJSjJpEwqo5SmT4ONkdLlVl5L8LcEwOiD3OcJKhzY3/nbzjJaM3
         2T1pIxq/6DDdtBkR22oAPqRH86BRG7IpZdKSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dL9JtcZ92ryYmPw47PdDoJyrwRFQyhVA65jTVCpTryA=;
        b=FAhC7WuPV3oXU4c8n3dj6nr3O5iUqeCtjr6PbORwJrfW/2sgBq0fWU86Kbj5hBPUd2
         LW9mCAnD7Q5bAlv852qjmaA4qr++pAVntTkxN1vwFMfgy3W2QhzltcfTdiTxH4xUL/FL
         ExPlZa4Gj8dBqI390T/iFXzC4t9GgzzUCUcBcWHydLZw3vT3jTOsupgj/OPCHm8t/dJT
         uwPxAXUkYY/D8VBOLahe/vo7wCjH5mIvz471ktRsmVb5mlkJRSxe8n9PccIWrX3arVgH
         otTv4Rd7T7IXU3ZZlcCYCd+ZKwFaLQT3QAbLOMUMoz7ojp8772M9OdAyfN3urN01exdh
         QX4A==
X-Gm-Message-State: APjAAAVe8EqcMoaiVYexkTCW4XPC3kR8trASHkQmyCDH3FdRz9QNDAuC
        eb4P9WKFhoWw13yyMQ09SRHLDw==
X-Google-Smtp-Source: APXvYqxR3xzpG4aO7AHfUFf+3SjHVnPXZxk4DrkkC1n22Mku+W8I6WVCHkI9MtZMNBQwKnm8EptMEA==
X-Received: by 2002:a17:902:e684:: with SMTP id cn4mr51769749plb.71.1555024973170;
        Thu, 11 Apr 2019 16:22:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y20sm37288903pfe.188.2019.04.11.16.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 16:22:52 -0700 (PDT)
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
Subject: [PATCH 5/5] ARM: dts: rockchip: vdd_gpu off in suspend for rk3288-veyron
Date:   Thu, 11 Apr 2019 16:21:57 -0700
Message-Id: <20190411232157.55125-5-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190411232157.55125-1-dianders@chromium.org>
References: <20190411232157.55125-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At some point long long ago the downstream GPU driver would crash if
we turned the GPU off during suspend.  For some context you can see:

https://chromium-review.googlesource.com/#/c/215780/5..6/arch/arm/boot/dts/rk3288-pinky-rev2.dts

At some point in time not too long after that got fixed.

It's unclear why the GPU is left enabled during suspend on the
mainline kernel.  Everything seems fine if I turn this off, so let's
do it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 279d7f4ecce0..1252522392c7 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -217,8 +217,7 @@
 				regulator-max-microvolt = <1250000>;
 				regulator-ramp-delay = <6001>;
 				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
+					regulator-off-in-suspend;
 				};
 			};
 
-- 
2.21.0.392.gf8f6787159e-goog

