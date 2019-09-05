Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74740C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469F52082E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3M2iaYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfIEHwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:52:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39976 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfIEHwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:52:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id t9so1629885wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8QTtt8+sGnSqf2GZqqr6eKF9qx6336YqhCVxZTe4hN4=;
        b=P3M2iaYypKmONmySetZUFaEg2hS2Zw4ANUaBhR6r5Ydm74kgAH+IhORp1ZlSO3+SvG
         bPCT3dkX2yVgIb96qqnsLFsYvscdlxnkL5q7N2vsbXFwuzu0KFsjgL2cm4cVMQIVCiHg
         E3HyFv/qZeAvK2dR5fvXAwdJ6ohLBAUxXUlpSrnwZygHBjnfzUXN7K/XTGA3fFhhPMLp
         aef7z4TL+zPCwYLGdxAx8P883nSG9rZIhxXDy0ApUIjVYUWVdz2yX3BC0F3ldwajVhor
         yFM9sHNlHvSqgAqu2mpD6gLSQXdhjL2FV5gmXWXcKoqfAWr8dBPfgBb+lndVXZwEXGIy
         zv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8QTtt8+sGnSqf2GZqqr6eKF9qx6336YqhCVxZTe4hN4=;
        b=dK3LjFbAC+RcbyxwuVaso1PhzFo2ibPWcwKqGcGJSJOsLQaaDM+t1cXcoBX36VAUBj
         gOvyYwtGm4tvZU5Fmd6jNTilCT95SsD9nTULGfIZpPYc7MS+hz4xLzb0vCQ3BcNS5Efb
         9Q90MLuVmmwpi/fvPBh2yXU0wjJjwzsX/0YrIV388pykoU1TT/9QHbT3iVkWyv3FernU
         WBoDC8jtrxqxyQm+44iTgDz0K2QSrKphIhHhxTWfWZctljd+UPs85Jhq0Qmau8l2nZYh
         ufKfTyBuE/wCBOjgP/zJvzX3DEol+ONiFqL45qk/BaZCj8htpdHpGrLMKTk572N5HQg9
         p/Jg==
X-Gm-Message-State: APjAAAUWrhiZEEV3/N4kBFS6JTM/3rjyjdAjqVMY/u1hktlh8iGIHsyZ
        Em5DyC7w61XPbJdh60JsaED3hw==
X-Google-Smtp-Source: APXvYqwzQVlp8PCbFWrdVBA5xmrr3ZHShk2IdYXuGYRwilcld1G0FXOEOyA9G0LVuEDXC8E5xXtsSg==
X-Received: by 2002:a1c:7919:: with SMTP id l25mr1454666wme.23.1567669937202;
        Thu, 05 Sep 2019 00:52:17 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id a13sm3418784wrf.73.2019.09.05.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 00:52:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, wsa@the-dreams.de, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/2] dt-bindings: soc: qcom: Provide option to disable DMA
Date:   Thu,  5 Sep 2019 08:52:12 +0100
Message-Id: <20190905075213.13260-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used when DMA is not available or the best option.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index dab7ca9f250c..a14889ee76b0 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -40,6 +40,7 @@ Required properties:
 Optional property:
 - clock-frequency:	Desired I2C bus clock frequency in Hz.
 			When missing default to 100000Hz.
+- qcom,geni-se-no-dma:	Prevents the use of DMA in the Geni SE.
 
 Child nodes should conform to I2C bus binding as described in i2c.txt.
 
-- 
2.17.1

