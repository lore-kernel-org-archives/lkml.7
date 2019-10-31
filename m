Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3345CCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EDD21734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m98kdvgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfJaSi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:38:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40304 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfJaSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:38:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id e3so959159plt.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=G1RY5BCmh8InAkONRa9lruWuMsHWqlSh2+WDeebx0SM=;
        b=m98kdvgI2S5N3BmltWHCwwfREQrCi3jfMjxrtZJQoT4Vuf7vAtpC/4SgaAghY1rIHz
         W5SlSO1a8egz+YPhwpCV2VFbOQI3JetjehPvT/rZcRaCMRYWQDl01crsyaz7YKQUwp3c
         uuZZVRFQWcRyEFxVU5DlE3VQ658SZxumOVmIIiCSydl8KrV0t4/iuNuiVWgMNBGcTwNK
         LDQKWnC+3Hv/1GDr91mhI9Svv6FFJOiTNy1KJAw59kmD6Qj6bw5gAabaHBEy3NRwdCVW
         zWru3O2N7V8t5tP3q7SCgoZe8xM0ApLmS8Jr+nI9PBp0PzsmnI2cBAE4LNTw/32CsT0C
         Skug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=G1RY5BCmh8InAkONRa9lruWuMsHWqlSh2+WDeebx0SM=;
        b=XZ5aGufMNuS+08oDVaf51XkLJo1EnsjqwMFBbeLYgnMSYBJeUHal7gvGNpNFgi+ntX
         LWDE39lPXYAlZHnERCmpmeHl9BC8ZFBmeMdyTu6IDaEaMGM+DvEsX/25Vo1gQKOrpzYH
         WO4VLb7997otAtQACWzllTC/1gmQVQ43io7kP63qSqxAmw763fNOPTFVVkdIqyexkQV6
         Dg1cgI5bzADvUUG1SwckBErYHvoYX5oA7Sv4LSiqqJ8TMYfH4uxIs8Ta/Dt9tjLUVmJb
         ZcZbBy8qgmfSNx+GawoYwi9xD5nttueqBDGWvXBuEhPXjLGC4mj8LT/XsSvkfLQiGo0m
         A1kg==
X-Gm-Message-State: APjAAAW6/Pe9RppUInNFjkbB5WToQ83NZVrh9TML/PtcJnkIJ2X/zg5b
        hfD1u9+UVeyQjKOqIltZnLI02RnFMQZjZA==
X-Google-Smtp-Source: APXvYqwisWREQ3gJDfHQtkfaf6SuHqNIjaIRxilpaofB9+ABWSCmhK1USBUY5Zw4bz4/KWlT+rGwWw==
X-Received: by 2002:a17:902:6802:: with SMTP id h2mr7814361plk.135.1572547104331;
        Thu, 31 Oct 2019 11:38:24 -0700 (PDT)
Received: from localhost ([49.248.58.234])
        by smtp.gmail.com with ESMTPSA id d4sm6747792pjs.9.2019.10.31.11.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:38:23 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v7 08/15] arm64: dts: sdm845: thermal: Add interrupt support
Date:   Fri,  1 Nov 2019 00:07:32 +0530
Message-Id: <5a96df48e546576f90081bbde218e7cff88ae8ce.1572526427.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupts for each of the two tsens controllers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f406a4340b05..0990d5761860 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2950,6 +2950,8 @@
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
 			      <0 0x0c222000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -2958,6 +2960,8 @@
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */
 			      <0 0x0c223000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <8>;
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

