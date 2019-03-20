Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308DAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058C121873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MlAMyX5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCTUOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:14:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37334 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfCTUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:14:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so2594112pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hp4Jwra8sW2ZJSDFgSFps3KEk5Cy8kXn9Jxt4Fgsuac=;
        b=MlAMyX5JYcKg3R9nMP7fej4tApEpYE+ouo8ez9+E56ACnK6aZYdW+vc4jsCNBegF2A
         +afYxDlXD4+bbZxXxOr2Rhp7gdp/UsArPhwVMi18ktgtxcUdY1Xm2I9CWRiuM3TzdmFE
         99WZpk/3xGZjLsnzQGOcpUGyz9HELpFdFU/uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hp4Jwra8sW2ZJSDFgSFps3KEk5Cy8kXn9Jxt4Fgsuac=;
        b=Q4+YZLbBYJZCh5Tg4s7boSI4ybf5hxUb5BD8hwmOm1bql2Qs/enz4HODAFDMrFE3BH
         7yJFGWiMvcC4OEml+DTButrNTbs4Au2QIrHbz4km0p/ooTKFrZ//7wxV1oMIW4btcb5b
         QLRPSGkPFvFE+N1JQ8E8wujhr3uEsq3d0faTk88T6XXLY7JYnVulilG8wy4GQRUhDD0u
         6yBwRg+BGXPpx+u7enpdOSIHOEQABm0gq1X3GQJWdVK2VSkc6uyCv2NBu/L99ptXVwE8
         VQ2EWqq7zzm1ISPyr+H3eZiKaxfwksL2V4ezTfz6JFwqaXCTwtBupqY96RsrtkZglDs5
         mdEQ==
X-Gm-Message-State: APjAAAWpNCIdakkdWbvL4HBwWJteZtaegXHAa30p5mBraofml/OAWsUk
        kq5luE1hnatR+O6GekKHvp3Y0A==
X-Google-Smtp-Source: APXvYqw/ldDFSf4W8BjbtxL7tqDsxeLt8XQ1cW4nPUpxd240cYASZN+W0OsX/LdnVBVIECVvZbAtjA==
X-Received: by 2002:a17:902:ba98:: with SMTP id k24mr25137491pls.185.1553112874033;
        Wed, 20 Mar 2019 13:14:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z77sm6220388pfi.155.2019.03.20.13.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:14:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] ARM: dts: rockchip: Remove #address/#size-cells from rk3288 mipi_dsi
Date:   Wed, 20 Mar 2019 13:14:01 -0700
Message-Id: <20190320201402.114309-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190320201402.114309-1-dianders@chromium.org>
References: <20190320201402.114309-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are pointless.  As dtc points out:
  Warning (avoid_unnecessary_addr_size):
  /mipi@ff960000:
  unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Let's remove them.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 79cd3c53e737..99a7620bddac 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1119,8 +1119,6 @@
 		clock-names = "ref", "pclk";
 		power-domains = <&power RK3288_PD_VIO>;
 		rockchip,grf = <&grf>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		status = "disabled";
 
 		ports {
-- 
2.21.0.225.g810b269d1ac-goog

