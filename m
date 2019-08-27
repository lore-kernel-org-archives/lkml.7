Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BE8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE88220673
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BE6d8+Dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfH0MO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:14:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40383 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbfH0MOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:14:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id h3so11698266pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=q/b/VLKZJJ+9pBx+Ox6PYhFH2ZDvAGWlbSTEh3xNQEw=;
        b=BE6d8+DnSOLyJiEO1FnF2ECV9qpThQL38lOhrGVasd9zmpb1jWlpeLJ5NJDY+p/buW
         QFrkuswzUm40vnmWVn2IxbZapzX/L4xwW21FEZvu46TQ9PfJV8unb3P2H72Hay/bsnXH
         VTMCdugJZS9SouZyX6s70w0GC+8Xfd7AQZ7RzsWM75398FJyQtBOnSzznZwVvVGs1zTN
         Kw5RM4PvRUnqiiMPX8N1p7HfhKm4u6KeV449kQYTztb7ZNrUU8R3iO7rr1IWTfzbSsco
         AjkKkdb3/cPZcFPUYFzlwHiK3R3mSU0hHyY8OYUpEHFj8NxMlBaI4jgiOe+ccPt10arn
         Iwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=q/b/VLKZJJ+9pBx+Ox6PYhFH2ZDvAGWlbSTEh3xNQEw=;
        b=CjPs53AyFnGngY5QI6Dj2dy7/MhnX5cbWF+uKiTz+35WmbVApYHO6Ip8CBCUJbT96n
         quitMPdLqRrvDCq7URo2xC/JX35Zm4RjI87HpJZERlZb82ioVgzYrViQo5aKx5Ooff9J
         foiJluY2E4BzgUadL2bFPFwULr9oVA4oGBcXFL85r1anWRgWH5CBZTqg9tcJ/yGBdPef
         8uLHKO7tHH5WR1Gn8sZIjvq8F3wHPeBVO+SAY0GFAUEZ59kdrMUw2xpGzUTdZkg+CPlV
         uY+wqSxo1wuHDe+PGHZvGCxSTwL2MtiwDWyVxvOKLb3nRDm1rDn9PAdSCNuERliKE2+b
         p5GQ==
X-Gm-Message-State: APjAAAV9UEZQEmbecCwQEm1h3QYkYEuYuJz6SDKEetPfrVXAuHbiXrCt
        ocw5Hil/YtcPriWy5OeeFQXobY+ho+74tQ==
X-Google-Smtp-Source: APXvYqyjUwvai+wzXfNU0BUV7EnDa+ctRLJCg0pyCkaXxiQIL473tdXue66xAU5eDLzA404jon2tKA==
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr23440638plp.113.1566908092569;
        Tue, 27 Aug 2019 05:14:52 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id y23sm24679653pfr.86.2019.08.27.05.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:14:51 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 07/15] dt: thermal: tsens: Document interrupt support in tsens driver
Date:   Tue, 27 Aug 2019 17:44:03 +0530
Message-Id: <66ac3d3707d6296ef85bf1fa321f7f1ee0c02131.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define two new required properties to define interrupts and
interrupt-names for tsens.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 673cc1831ee9d..686bede72f846 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -22,6 +22,8 @@ Required properties:
 
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
 - #qcom,sensors: Number of sensors in tsens block
+- interrupts: Interrupts generated from Always-On subsystem (AOSS)
+- interrupt-names: Must be one of the following: "uplow", "critical"
 - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
 nvmem cells
 
@@ -40,6 +42,9 @@ tsens0: thermal-sensor@c263000 {
 		reg = <0xc263000 0x1ff>, /* TM */
 			<0xc222000 0x1ff>; /* SROT */
 		#qcom,sensors = <13>;
+		interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "uplow";
+
 		#thermal-sensor-cells = <1>;
 	};
 
@@ -51,5 +56,8 @@ tsens: thermal-sensor@4a9000 {
 		nvmem-cells = <&tsens_caldata>;
 		nvmem-cell-names = "calib";
 		#qcom,sensors = <10>;
+		interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "uplow";
+
 		#thermal-sensor-cells = <1>;
 	};
-- 
2.17.1

