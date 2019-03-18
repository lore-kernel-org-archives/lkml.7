Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB920989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DReQPySj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfCRTk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:40:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39792 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbfCRTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:40:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so4282179wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2JfdqFXp8iuXVye70C9d3w4ZqFPTHaTQ8J8t0YbTu9k=;
        b=DReQPySjh1iT14vrYdRq4k3rIyvb6ERMHn3nqWL0HTq09GVLAv0G0gIjD3mxbB5Dit
         qCApTZeJ+pGl5N2sdueVX8z3nbxMFb3ltjhLZ/rYxJK239l0nmJNea86Cwr5A8XFcM9m
         SvwzHiEaAXmps68lAl2cxzYxdKnShZ2M+7UEzig1iGpBmVJWulrTs6WJJUEB4SbKFtGV
         oMvk6Zr6Yuz0Jji0hhfCUgcR/xYUR32T5AQ/wRSLpwGjLrKbefgjQ+NfzuN8bNGzlhuv
         JDDXZkAubo30r1UZ9AuybQjawrtlU5xuic0VyQ1pALbcXmvQHr2dfauKwxr8mizI3FUQ
         28PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2JfdqFXp8iuXVye70C9d3w4ZqFPTHaTQ8J8t0YbTu9k=;
        b=FB1otWwlrLYO2CUR0ekSlYK9xtAhuSA8G/Exr6lSygRSWcW1YDiB0oH8dG2w8mG7Z0
         XFSFAVK/fLEsqFcWhaBu4fzllsL/F/+H233+rgdfbP5JngIHkKLNsJ57pCeXvd+o6AAH
         GMptXlL2C71DndEz2ntraYRGYcpS7r24TjE7tVDtzOmkk+CyBbHE+piF2sTP7FZstLi1
         Mnv0swEEJLfKxh/XJGwqodEdD2BQ6+c9SboKStvAIKwYKMSY/M1T2L/+b52L2jOfB++X
         tGuT2Opgr5e7B6WlKbOx9kZWg/gVOjhINUzbtQmhT6Ei3R7STK6plpvreNVCJGjI0K3q
         utlg==
X-Gm-Message-State: APjAAAUNFh6i0bgVaFRNPUGm0fkcuNXz+91gcZoIEH8ybXLioooK4IHV
        8x2AhY1zMilElTAtvMVM1JzBuA==
X-Google-Smtp-Source: APXvYqxtxld460gm3Iezg2jFI+vIsB9NvFYgb/CFpti9a13qJNEW/TIzlkiMMuX4yFJh5Bjdh3OKYQ==
X-Received: by 2002:adf:f846:: with SMTP id d6mr14198160wrq.53.1552938054999;
        Mon, 18 Mar 2019 12:40:54 -0700 (PDT)
Received: from localhost.localdomain (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id s10sm4583941wrv.56.2019.03.18.12.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 12:40:54 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, p.zabel@pengutronix.de, xuwei5@hisilicon.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     john.stultz@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        yuq825@gmail.com
Subject: [PATCH v1 1/6] dt-bindings: gpu: mali-utgard: add hisilicon,hi6220-mali compatible
Date:   Mon, 18 Mar 2019 19:38:46 +0000
Message-Id: <1552937931-23050-2-git-send-email-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org>
References: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hisilicon hi6220 uses a Mali-450MP4 with 4 PPs, so add
a compatible for it.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index ae63f09..936a20a 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -23,6 +23,7 @@ Required properties:
       + rockchip,rk3228-mali
       + rockchip,rk3328-mali
       + stericsson,db8500-mali
+      + hisilicon,hi6220-mali
 
   - reg: Physical base address and length of the GPU registers
 
@@ -97,6 +98,10 @@ to specify one more vendor-specific compatible, among:
       * interrupt-names and interrupts:
         + combined: combined interrupt of all of the above lines
 
+  - hisilicon,hi6220-mali
+    Required properties:
+      * resets: phandles to the reset lines for the GPU
+
 Example:
 
 mali: gpu@1c40000 {
-- 
2.7.4

