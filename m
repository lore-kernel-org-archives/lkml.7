Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5351C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CA322CBA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cc4FhF/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGYWT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:19:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41749 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfGYWTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:19:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so23829944pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=amjpNRleha+KN/EuHRyzTUgCt6MkSmYthRSSTGRJeLk=;
        b=cc4FhF/zO5NxWck5NRRbEzVCBekK3ZlKjGzUReO9izSEdqV9t/vA0x8UlJcDEYNz9S
         gFdGWsMoYXFnoOrsbhwgJFKIg+JQD9DdqJCL24K4mszOrf4QsAR4GscI5ZJoteuJfqLD
         plgixsXge/LHkeiMYc2lX34OH6pQbQ0gqridn1qii9eWgGbUAwRcw42Qe5nx0SNvfvei
         LVamvvA/gmzss9Agus4cbSGg4rUlZ19FgNss8J6wMkNVx1z8h1bnYBZOJ9To6cjRISVY
         e7IEw43MEAoTp11jeowtIAG5+DYli8+dhDKZ6GTwXWfJHk7L9rXDSLR6EIlzgtWjLk69
         d3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=amjpNRleha+KN/EuHRyzTUgCt6MkSmYthRSSTGRJeLk=;
        b=GOT1W3m+Kux+Exips9djlE5DsYwYL6oCmAxp4uygbotTpACCsOlKBNg5aRS0gBaNMy
         MVPePDgT/5wzgs4EPQ9ENr33K1bEybF9F92WEWAmsMcRTts4pyAOOp3jXY6TRPHFL+Bg
         lbNntI0QErKpkcdauKh2TZ+h1vWVY3rVfbKo4u8qBHMPV70b9fWgym2pjlFjG3F3SYFL
         0s+lFsGgFYfCmpasHrflFW87n5Djq5AC42RSUrk9kfPeJ1lhI0nDjxCQ1L7GhnRVYzOk
         4/E26UVHURiFTc77lpv92XjA5tnRf63WYCDxdxUFFe14pD83gPwd5V3LJp6di6o/4spO
         oQFg==
X-Gm-Message-State: APjAAAWHMqW/sa5gdPaIioNsqoCofKCIR112sHz6yDqabI+OZoV1WGM7
        f1Y6QJinxhXB7H/dqtjUxuzSKSbw6xnO8g==
X-Google-Smtp-Source: APXvYqzTJsiFKu9NIQp8XByePsHuTBie+TyiE7Ko6FeqH3s31ixG9OJlPkCgk8n/UIiQyF6EAKi5RA==
X-Received: by 2002:a17:902:106:: with SMTP id 6mr94863155plb.64.1564093163818;
        Thu, 25 Jul 2019 15:19:23 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id x26sm65297712pfq.69.2019.07.25.15.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:23 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 07/15] dt: thermal: tsens: Document interrupt support in tsens driver
Date:   Fri, 26 Jul 2019 03:48:42 +0530
Message-Id: <72bce036fa8cba3db6e5ba82249837ee46e9c077.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define two new required properties to define interrupts and
interrupt-names for tsens.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 673cc1831ee9..3d3dd5dc6d36 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -22,6 +22,8 @@ Required properties:
 
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
 - #qcom,sensors: Number of sensors in tsens block
+- interrupts: Interrupts generated from Always-On subsystem (AOSS)
+- interrupt-names: The name of the interrupt e.g. "tsens0", "tsens1"
 - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
 nvmem cells
 
@@ -40,6 +42,9 @@ tsens0: thermal-sensor@c263000 {
 		reg = <0xc263000 0x1ff>, /* TM */
 			<0xc222000 0x1ff>; /* SROT */
 		#qcom,sensors = <13>;
+		interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tsens0";
+
 		#thermal-sensor-cells = <1>;
 	};
 
-- 
2.17.1

