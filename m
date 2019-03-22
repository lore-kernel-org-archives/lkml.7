Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B26C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F0C218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lrtSK9Aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfCVQwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:52:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43976 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfCVQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:52:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so1911444pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wY/T7bTulpPWrqCp7ceXPYlFk65OzAXhK7CekfQXmK8=;
        b=lrtSK9Aw86HshxgPVg/YdXPdlbFutjnqD8UmcqLJEcvOatw8l9iHlBBsUWI3B8Z3q3
         9MZgYcGklxrcgimrXnf5O02mcNnmRYwBZjlB8v4voljOj2SyrbtM3HJ7wagkVDpGGpeX
         K1pSsA29lPxiAIzOItFckod0OfqOOEJ5vvZ/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wY/T7bTulpPWrqCp7ceXPYlFk65OzAXhK7CekfQXmK8=;
        b=e3HoEumO6xxlxVJd8HTVKYAU44Wh8EBZ9vNCauIOKPMDCUTF//oS6ony2x4jf6VGwj
         7pww10WqJXX4brVv35uQ3k6A8o+3nwJr04Jcv6a+URsslLpqD00OJ6BS76oONVXHgaX3
         LUmeV8/jXgqUDayx+LJB4Y0LN6PYEhn90IM4wq3ODPPCvffMX+5ZjVgrWteZ2Vv7C8He
         07pZTiDfhkZiTzJfLdJHWV/yceFH2O8ixx4v5gfdLcsDwGFsmEGIJuKuTaF6uYqi2s9i
         ZoTpNu/BaVFswL5h7TipYdw6OTigmPlwN3lgNOYr6U4JJy0d9yVcdJv9LfnYkvjkSliI
         6NuA==
X-Gm-Message-State: APjAAAUlWsL6gX46hj8g53D1ylZax0tdj3HhRf3FFwCO3zXbkXqrwykX
        gth4EpLm3qZ7ASSTrp0gsi5kVQ==
X-Google-Smtp-Source: APXvYqxcjsXz0hy+Yza36eaEa4CJdV2qKWk+8eMebC19TGRqGDH5ErFHGprCk5FCC12Fg8dnX20rAg==
X-Received: by 2002:a63:1723:: with SMTP id x35mr9570272pgl.364.1553273567930;
        Fri, 22 Mar 2019 09:52:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p25sm3669481pfd.13.2019.03.22.09.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 09:52:47 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: rockchip: Add dvs-gpios to rk3288-veyron-jerry
Date:   Fri, 22 Mar 2019 09:52:09 -0700
Message-Id: <20190322165209.196926-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the rk3288-jerry device tree was first submitted we left out the
dvs-gpios because I pointed out that the property "dvs-gpios" wasn't
yet supported upstream [1].  Soon after that the property was added in
commit bad47ad2eef3 ("regulator: rk808: fixed the overshoot when
adjust voltage").  ...but we forgot to go back and add the property to
the jerry device tree file.  Let's do so now.

NOTE: without this patch, jerry is likely still stable (thanks to the
fallback of making many small jumps in the rk808 regulator code) but
it'll take quite a bit longer to make voltage transitions.

[1] https://lore.kernel.org/linux-arm-kernel/CAD=FV=WwFgjzbk9xF5TU_ie6UnHQMyrZ176D4+jJTWWOoaKC2Q@mail.gmail.com/

Fixes: f3ee390e4ef2 ("ARM: dts: rockchip: add veyron-jerry board")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-jerry.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
index 2ba89895c33a..cc3019dc38e1 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
@@ -61,7 +61,9 @@
 
 &rk808 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pmic_int_l>;
+	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
+	dvs-gpios = <&gpio7 RK_PB4 GPIO_ACTIVE_HIGH>,
+		    <&gpio7 RK_PB7 GPIO_ACTIVE_HIGH>;
 
 	regulators {
 		mic_vcc: LDO_REG2 {
-- 
2.21.0.392.gf8f6787159e-goog

