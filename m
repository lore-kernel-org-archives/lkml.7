Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8527C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35EE20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/97p16K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfEOPbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:31:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38955 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfEOPbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:31:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so48284plm.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3PFiqZYr2ENWnUsVIDRAvDI9vPaKjuSp1u756KP9Zc=;
        b=j/97p16K6USW9gvsVhnnSbeJKIGOU2uRr7jmAEgKinUYFiWyG93vD7TP1OavOB43ii
         x0SPgsjsCnTt3YLr7odjlnWViICJu2ezBCI5wFhCe/tkhjv0T7I1+3kFjyP4mvx8hQZo
         3xrjDpWFqq5Y56WcevT7zGob4l8tm/ffewKBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3PFiqZYr2ENWnUsVIDRAvDI9vPaKjuSp1u756KP9Zc=;
        b=L+qk/O2hRWqbNbahgfrePOBGX5SpXXiiBzGPTEdDWkS3ekbMm8aZ6l3jUuzE9CbXHC
         Me3VrOdSnG/+EcF1sWQwN3a8qaeimUnJFvRBfBUnnBacUgQJ4ZlV0l7fWgR1wy2hRiRS
         T4NB73tqwgU7feuPxCaXJ8I/lkc5mfp2xKLN8wL02UWm7PvPdTmyy1WOhYHVeDtyL4Kq
         g37lXZ39S4/hny7llAf8Yt4xo6gbI+2vamxQ+YXURRZF+nobb095+aQ5Hx7HU8VbEOtF
         sNvuZlRnPsEP3WnPiJfWDfYDzEjsLgtYhsY5rZtyHYwNu9BcTheuT4AwuQhdH8hWH7TW
         CCww==
X-Gm-Message-State: APjAAAWTRt9uizSY50SvbR1Zkh0dbqZWJMyqPSHSGvCxyLoSV8Tizsq+
        pFiN8prj2uiDn9hEnDR//+wgHQ==
X-Google-Smtp-Source: APXvYqwpHJFwd0RE9EmEOM2wbZSpYfXI5Ha19P2vHpWhNU4WtqcFTMR9WH76eVdT2labGFxPVWZPRQ==
X-Received: by 2002:a17:902:e683:: with SMTP id cn3mr21744646plb.86.1557934294758;
        Wed, 15 May 2019 08:31:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id c189sm5260671pfg.46.2019.05.15.08.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 08:31:34 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] dts: rockchip: raise GPU trip point temperature for veyron to 72.5 degC
Date:   Wed, 15 May 2019 08:31:26 -0700
Message-Id: <20190515153127.24626-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This value matches what is used by the downstream Chrome OS 3.14
kernel, the 'official' kernel for veyron devices.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 1252522392c7..169da06e1c09 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -446,6 +446,14 @@
 	status = "okay";
 };
 
+&gpu_thermal {
+	trips {
+		gpu_alert0: gpu_alert0 {
+			temperature = <72500>; /* millicelsius */
+		};
+	};
+};
+
 &pinctrl {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <
-- 
2.21.0.1020.gf2820cf01a-goog

