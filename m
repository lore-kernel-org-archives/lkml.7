Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05971C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19E2205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggTiLMIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfDSSpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:45:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32772 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfDSSph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:45:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so9480458wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+1RhXgibSnIdgZgBtIFJvFDwIprDWg0GFwO76wEX90=;
        b=ggTiLMIo2MMiAErRNCHRkXFT4doB1OuzZsQ3lhdY35FZ7JO88Z/8xWeE27m/Z/BcJz
         8TfOXyjmmYMTJBU9qzBMD0PabNOWATKdkLUA6QE3y9jgPqHLf67+CW48qTYM/3PsSNot
         YHh8+I8S/K643QlO7BGUnT/iKRlc6CcfpjK+adXPACUvXYEZtNePPOYq/S9AeesFB7Uj
         ieWoZB3rS69TZejgh8hnIyW8ykUqdVqaXUdqpmFCdKkY0RUe7IYRc3OEQdFkfY58aBeQ
         8Rg5rSUD1fXBjE0X5ecd4e3AJ9dvUi3/xyRBXqa9nSAK35ZFcD80YCHW6rIlm2045Ux8
         8taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+1RhXgibSnIdgZgBtIFJvFDwIprDWg0GFwO76wEX90=;
        b=Jj68eF3Chi/tqdVg7jUd1Ft9HqdtIgt5C2wVp9N8FJfC4ipTwzZcNDGiryfa0JxMfv
         FAlO4OXtQe0pbg93U7/tlJ1cv7fd8ibfrjqmhCc83U6Zm6fJwNp/1ZWWwPl99ovfA3Qf
         YYeWPAgkLUEoJSfVBxSczzDHdxBDGoRo/k/JswHPQrT2+xrYwP1nNTBr8S7IAeDOOxnF
         KVCC1hdF4WYNa6dGLq777XNMYvHuINJfbfizhex8QERPd4hBrtLKP0H2LZ4wsi3glzHl
         Q3y+iZY7Hu2q3eXV1oy2NZu9S+RyAHVEcVPLzhnwCxJQm4NimbgdYF/teVd00LG4e1Z3
         wqjg==
X-Gm-Message-State: APjAAAWWDugom6MSwVrbBN4561HrE5KPs+xzZT+IfYboV0tRU7LQ+INZ
        oYveWOGoVZfVnZ1ukcyiY4mE57wKlwU=
X-Google-Smtp-Source: APXvYqxGOL6NBipSMdJ5FdFtE7FShaEaFP4/LYJ8fD6dQ5oq2G5QK8hZF07N9rHyxM4oFFuBMdlMkQ==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr1753287wmb.47.1555662907167;
        Fri, 19 Apr 2019 01:35:07 -0700 (PDT)
Received: from localhost.localdomain (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id t76sm5700147wmt.8.2019.04.19.01.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 01:35:06 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de,
        xuwei5@hisilicon.com, mturquette@baylibre.com, sboyd@kernel.org,
        yuq825@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, lima@lists.freedesktop.org
Subject: [PATCH v2 3/6] arm64: dts: hisilicon: Add Mali-450 MP4 GPU DT entry
Date:   Fri, 19 Apr 2019 09:32:58 +0100
Message-Id: <1555662781-22570-4-git-send-email-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
References: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi6220 has a Mali450 MP4 so lets add it into the DT.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index aec9e37..2defc19 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -1019,6 +1019,43 @@
 			clock-names = "apb_pclk";
 			cpu = <&cpu7>;
 		};
+
+		mali: gpu@f4080000 {
+			compatible = "hisilicon,hi6220-mali", "arm,mali-450";
+			reg = <0x0 0xf4080000 0x0 0x00040000>;
+			interrupt-parent = <&gic>;
+			interrupts =	<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pp2",
+					  "ppmmu2",
+					  "pp3",
+					  "ppmmu3";
+			clocks = <&media_ctrl HI6220_G3D_CLK>,
+				 <&media_ctrl HI6220_G3D_PCLK>;
+			clock-names = "core", "bus";
+			assigned-clocks = <&media_ctrl HI6220_G3D_CLK>,
+					  <&media_ctrl HI6220_G3D_PCLK>;
+			assigned-clock-rates = <500000000>, <144000000>;
+			reset-names = "ao_g3d", "media_g3d";
+			resets = <&ao_ctrl AO_G3D>, <&media_ctrl MEDIA_G3D>;
+		};
 	};
 };
 
-- 
2.7.4

