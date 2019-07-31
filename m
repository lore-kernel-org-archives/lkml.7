Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500CBC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBB6206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YV/R5BSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfGaUaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:30:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52188 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbfGaU3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:29:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so62182535wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eN7cVd81RI8zQ0Y9k2UD2x6CFiI8Tg5XhL9VySum/g=;
        b=YV/R5BSMFAh570iRGRBD+cQsWsJMFzQ9gG4bGL/RfB32IWA8XWQeNI5O0Thy2ZYp3D
         0R9pHt+GGiTfp0GJbd7ldKYk/cGLe4sDDFbAxLUywQ8JpeGf04r2+4aXtZvWA41ZNgOz
         Ga687vg1J/lEgYqb2BK7TqMePNgA5tMCBoqMtIiqAwNmUj2veS08uPt9qYWEw79ufpms
         AMsxqa5tQzIjPGAQZVtrImgh9ifM/d/sWBl+iDfNP3djoNjHT+3jg9gOeiztVzXdAMMR
         oLeGbEuGiUBJv17NIERP3qXzZA1aIXI6F5E9+wMnlf8vPQuU5shUVedUGy5fClF3LwLm
         V/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eN7cVd81RI8zQ0Y9k2UD2x6CFiI8Tg5XhL9VySum/g=;
        b=N4pSIg1gp33XgVtPo50NlSBfMiFqqGrHIXYve7md4WHMwPuHHzfFEgxOGpX8yKa07v
         wbBy/IlmJBl0J5tBBjyiXpFxHntWvUB+2DwZfTfqbq++i3xej8ueTHqvuUqqLVnNWZuG
         Rt/NHv4dv/kB4x9MKKz8oLa30wgOvf7Kxc109RTwjQ/J6NsiJx3OJTRwtknWlKPfxCox
         uHyjyj6yBu6uz3ghlAA/YpwxBH/Qzb/tXCOEU0yw58wwbGKr4AySDu/T06PosUS+8deX
         Pm9vWpYWu75pTqRvZtkcrZzZ5+AlySJT/Gy2mtTGGciaOJQBQ73yqEbT73g0pRKM7vmE
         NWKw==
X-Gm-Message-State: APjAAAU/06OYnzST0pyCkSB+UJakvjEIgxXUP2cofuRTi/vm1n4Pk9Me
        X0/QzrNzHeLLiTr20WG3VmJSLA==
X-Google-Smtp-Source: APXvYqzNwzPOT8ikRcH8Z10UCUrFJdD9U7xIkEr2QVEDWI8Dja3e2Osr7FtBYRKIc8wpPjGJiXNCVg==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr37876401wmk.36.1564604991184;
        Wed, 31 Jul 2019 13:29:51 -0700 (PDT)
Received: from localhost.localdomain (19.red-176-86-136.dynamicip.rima-tde.net. [176.86.136.19])
        by smtp.gmail.com with ESMTPSA id i18sm91905591wrp.91.2019.07.31.13.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 13:29:50 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v4 09/13] arm64: dts: qcom: msm8916: Add the clocks for the APCS mux/divider
Date:   Wed, 31 Jul 2019 22:29:25 +0200
Message-Id: <20190731202929.16443-10-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
References: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the clocks that feed the APCS mux/divider instead of using
default hardcoded values in the source code.

The driver still supports the previous bindings; however with this
update it we allow the msm8916 to access the parent clock names
required by the driver operation using the device tree node.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5ea9fb8f2f87..96dc7a12aa94 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -429,7 +429,8 @@
 			compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
 			reg = <0xb011000 0x1000>;
 			#mbox-cells = <1>;
-			clocks = <&a53pll>;
+			clocks = <&gcc GPLL0_VOTE>, <&a53pll>;
+			clock-names = "aux", "pll";
 			#clock-cells = <0>;
 		};
 
-- 
2.22.0

