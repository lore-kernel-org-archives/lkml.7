Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD0ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272A62067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfN7WGSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfJUKgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:36:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34733 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbfJUKga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:36:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so8190071pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=raRv91SuwpaXlGeT2wU6HLI9/SHJRwKCyqG5FDUj7WM=;
        b=dfN7WGSgkXXOa/URlH/ad/gRg6gnfjIsMBdB5HASF7KGk6e3vgPOKuBUdrQonzvxbl
         ZabWSM5RBGxt9NZhV2CYQS7Re/oJH5LHCS76bWGl3dYzeWFKFBemK6203svGG9zzeErK
         R7SubW3IktLLP9997uvwDu5MDI/8VHhY0dVMH+OBFiRIeKkawfreLDLFufFg++ep0JJu
         8aTHfZcuchruuOfibLzKpvpmuCJQOD9bfiZHBFbS7MXOhnnwVBPG41CS9RisyJfs2Dui
         lLPGF0KkbdVE34XIzLU+DIbaUYZBrC2+83vdWkUscpdsWoFc7H15PLXEPR/klZ1ea5qr
         NC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=raRv91SuwpaXlGeT2wU6HLI9/SHJRwKCyqG5FDUj7WM=;
        b=fW3IfojY9OcFnJKzMJdI8Xmtj5GSgZyNnHPKGxreYhuef3CobEZC1gLNcZAlQGf/0s
         8pHdtDfJUpppczpLyiLq53n/109e9YN9F80EHihvpeKplkbZ2ZtcgQOfCPz7nm9VZhEK
         a0cDNtg3M9mpkcOmaciPz9i3ELCzDR+LzS6KGwpmVITNp5D8kh1wuP7X55EyBJhdLS/Z
         4Vxk8dd62ENkqwrbIHOSDrHVyun/68/Jt+B/drrBr1mHB0KUhmjhrn4I3L+kARUj4yG+
         PiWgVrpRBOK4Vnsrb4+LSzucFKzfg9WjddiWzUY0YgWG8820IcXVTGDILfxPYTPhQVXz
         E8lA==
X-Gm-Message-State: APjAAAU+7otTlo/gGOsWg7kfYQI7TMghU2oWZxIeY1sT2nOM3pB6WCq1
        RwWFmDagnnu3aFKkNsuyogphiJt5r/NoNA==
X-Google-Smtp-Source: APXvYqwCpYHYXSMroItXhbGj9D6u5ioe8pubcuLdwxrRirA+DapJicFWgsOu+QaSERbHJmDVv7rX+g==
X-Received: by 2002:a17:90a:86c7:: with SMTP id y7mr26839634pjv.82.1571654189240;
        Mon, 21 Oct 2019 03:36:29 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id y22sm13192289pjn.12.2019.10.21.03.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:36:28 -0700 (PDT)
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
Subject: [PATCH v6 13/15] arm64: dts: msm8916: thermal: Add interrupt support
Date:   Mon, 21 Oct 2019 16:05:32 +0530
Message-Id: <88eff964b708c8aff57b24370d2e14389ace09e9.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupt for the tsens controller.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8686e101905cc..807f86a4535e0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -816,6 +816,8 @@
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
 			#qcom,sensors = <5>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

