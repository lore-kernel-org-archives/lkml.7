Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3589CCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FAC20650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ky5zw8Br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfJaSik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:38:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43444 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbfJaSii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:38:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id 3so4946905pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aMdrJzILxuSr5g6YT+uoh2+W6L6BuGxRIbKk0lFLJqE=;
        b=ky5zw8BrhKjOq5PB9CX6M7JcJcee0wQzZvClB7rN/0BkDTbxI2OJvuN9t/KG6z3dMO
         /Md9+UdzQHWzheYBk8zSY3L+/CBqbQTjfGm4RZVQLtK0oyotTESrxsCa63z3BsFjHpzm
         tfdWsqpwHLile/bwnxuwhBE7GTdzoLatHXipLArihmzrHnwdKOLlCDLk4igLht1iJGtl
         l0T45Y4Ohu4r5dlgAYomF0wLzuvZ1h4Slu6SxISK3r5zH/b/Els4KvCRbQuxhETZNJky
         ZnI/P180SHO2M7og0G89CzsJCae+Ez1LZvrG1i4k/xPKrEK//0YYwaTDvcjyxII4K49A
         a81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aMdrJzILxuSr5g6YT+uoh2+W6L6BuGxRIbKk0lFLJqE=;
        b=YkX+ir9GMW7V18ssHaU+ebL/it0pvcJrBEyQNym1s8NjH6uerv2yKBFJFdSXOmb40O
         GoRuyyehp0KwAekYcVO2UO4llol5mFU85P93o+G5vYNGTojtk8RE2obfOSjgqoSC3zhe
         9pMZmCuAdJDUN7j7hR9Bf0ZzSe+E7zbXpYL1fdjTzXxAtf9TIOwwSg9pcc8oDvZjpLGl
         jBhA2hgJFi8ESiGDw1whk1O1R4Mzsfs+GdS9wm9RhXVMbvEM9ib9xoaV82EIbWnJB2n8
         NbD912IO4UU05WlQjkBdlSWA0ciqd6oS/Ic44y7YmBHCnbBhZV22nngH9BzZUof4ZR+p
         9WsQ==
X-Gm-Message-State: APjAAAWv/ZBt5VRY1IHFx1TMLyw08HfWc9G8quimuvZZZWcgrmTLbjai
        kh7c2DuxFOnOK4ISPBRifNuWJt0HdQVfgg==
X-Google-Smtp-Source: APXvYqyaOu761Su0gt/rthTGFVYQl4Zz7k4JdP1DxFjOS4wsatvGYfvAgkmIt5GHQmwvgRSXF8IG8A==
X-Received: by 2002:a65:670d:: with SMTP id u13mr7825488pgf.19.1572547117004;
        Thu, 31 Oct 2019 11:38:37 -0700 (PDT)
Received: from localhost ([49.248.58.234])
        by smtp.gmail.com with ESMTPSA id f185sm4716195pfb.183.2019.10.31.11.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:38:36 -0700 (PDT)
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
Subject: [PATCH v7 11/15] arm64: dts: qcs404: thermal: Add interrupt support
Date:   Fri,  1 Nov 2019 00:07:35 +0530
Message-Id: <63d6b0b8bba0d217c2f7bb4240c587ead933b6be.1572526427.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupt for the tsens controller.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index a97eeb4569c0..b6a4e6073936 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -290,6 +290,8 @@
 			nvmem-cells = <&tsens_caldata>;
 			nvmem-cell-names = "calib";
 			#qcom,sensors = <10>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

