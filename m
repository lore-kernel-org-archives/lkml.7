Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA014C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C010120820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qp0yJe04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfIDLgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:36:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50748 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfIDLgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:36:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id c10so2945850wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uuq1eCLagqB7It6aGbezur+IR8biDO9SazdI7cqdaFI=;
        b=qp0yJe04jx2ivZeuIXUwlhAyXXeFSfk5tgqH6oCkHR05lDEik9mPR5v9927SPGcRcF
         Bqpd9uYWbP1lsr+hb7QvkpYLluhnrev870vk1hyz6CstDwPiqkr8mp4/e4g5uP5dShX8
         xdt0ym7tbVmwYwx2pgRVRGsEZ8C1evHUk9FGitl/8RMxdTyfqj6zxtwcIzKPbnKHu2ay
         q7f/9kZ1lQ7dZpPPtuumZ9QoFlwEHWVriNgD+6IQtn2ystKcFOD1L8ahTB72/zQlOPjj
         vijaYPmPpyVFjezLg3cx8drAtt4pP5Fz+cYk5fH1mE2O8yX+nvUAM681Qx1ltYOUjSXv
         zQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uuq1eCLagqB7It6aGbezur+IR8biDO9SazdI7cqdaFI=;
        b=B9CxMuCptvRK9Z6QjfR0EWzuJUJQd7aQZhIr5/7/OUoExhsHEoo7TDIph1tKOo115S
         JYAANHESXUYNRaPe14ND7tDc9yTUBcFOpJ04bfNpxLWIJjcfclpylJkgBIQ/sdfx8lWQ
         IXlZ07NgnyFWVkhP14P5b0frTA48MkZtpRW9M02rUy+SebVuOOQAbk1wxVAQRCSb2u1i
         gm6JFLiyJqbS5moxbyofELEaHsHl4mWwXEywUgtOhCYiEqYfjQFUT7Zx+oY1cLEcZG0A
         1QBOeSvY2vMUVRdqXir5zcMtteVBMYJ0TVaRfNN3mSBP6EQKdSo+zBCG2WUn6PDHIJJe
         yJJQ==
X-Gm-Message-State: APjAAAViydgEblveucz/hj9kC6piriG+vJPv5bCmlu8bfV8RT6RwbLq4
        waX9NBzSk0c1r3LU7j8fcjVnMA==
X-Google-Smtp-Source: APXvYqxrVXn7NXLmsW+n0aD02675Wv9vt7hSV40SwdLs0RB8oNmnK6HhJ+4q7rd/GnqwtFaz3fRPdA==
X-Received: by 2002:a7b:c8ca:: with SMTP id f10mr3812956wml.36.1567596978030;
        Wed, 04 Sep 2019 04:36:18 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id d9sm10823933wrc.39.2019.09.04.04.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 04:36:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/2] dt-bindings: soc: qcom: Provide option to select FIFO mode
Date:   Wed,  4 Sep 2019 12:36:13 +0100
Message-Id: <20190904113613.14997-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904113613.14997-1-lee.jones@linaro.org>
References: <20190904113613.14997-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used when DMA is not available or the best option.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index dab7ca9f250c..b0e71c07e604 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -40,6 +40,7 @@ Required properties:
 Optional property:
 - clock-frequency:	Desired I2C bus clock frequency in Hz.
 			When missing default to 100000Hz.
+- qcom,geni-se-fifo:	Selects FIFO processing - as opposed to DMA.
 
 Child nodes should conform to I2C bus binding as described in i2c.txt.
 
-- 
2.17.1

