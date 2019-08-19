Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF54CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C505F20644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="deXVNLoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfHSXsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:48:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39721 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbfHSXst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:48:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id z3so1736107pln.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0FuLv5Zr+cxHC18qV9Ymv7B49a2IFYwtbEueh1KcEvM=;
        b=deXVNLoyRrdJV5151g0Pj2weOCcEQHbEb21VCS8oSn05nF5EWXO9webwpbjy4Ut3Zb
         3LSfDRu3+aJpOCzDEYIVK/trRJQl9rWYVgr0C/70/2k5lL9thzLvbgE1/YlLFwfUC9PC
         AqobLGMOtXBzxKYNOADY2/q7xlXvU9X8WF8Qz38M1Kcr7CUYCQhz/rrLZpUAiCw3ZDf7
         Z/kgAzyvZ7IF1DyrR1/RsoVJfai1gZ61jtd0thGL3aQfQqPoAIGFiH/u+bbc5jurbxDt
         JJqD4iWqPTL/Od+crWcr/D4G55rsMq/iBL64vZpIVxsIVSuexFhkgweWd6XQ+bASDQUP
         x7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0FuLv5Zr+cxHC18qV9Ymv7B49a2IFYwtbEueh1KcEvM=;
        b=tStST3hyKboxEiY8FlDluN24PXMd0wyrCidi6x2KpJPECyri9IO9TgywXodwfTFpY/
         8AXRPp/+9ZrKi/2xnF8TD2ig5tXkWV/5pbEARYhq3NX7IJ50A2AjEBXS8lfGlkmZKntg
         o08zwiyJiPjUte2OM8e6gM40crdbhKJnDkoHeA3TzxYdIYAKXxHiVuAJ0faO5eWb0afP
         BUcQdL4zyxDomrx/RSO2twxX+z6cFTHf+r+nmvL9NRZp5chhRjg0xU2TX+UEcmeRq/Oh
         WTKi0MxNcD4miMWd1iikDGnHFA9WYDvRXKPKRfUDLrR3A4lG4MkupiMnZF/s/FusyyVP
         p8eQ==
X-Gm-Message-State: APjAAAXE2HFV8VQ5uspVuF6AayRZwwwLdPfR1sf7ssuMZF/GharvBKUT
        uoz8GSm1EM9/6j2e2AAm2t0n1i22edc=
X-Google-Smtp-Source: APXvYqwS90/sOsmy9exLtni67ANg3PZmELosaPRMBAbUykexQdBfrAbKQp74SAYJ2MucrBWI+jCC/Q==
X-Received: by 2002:a17:902:e30b:: with SMTP id cg11mr25695004plb.335.1566258527616;
        Mon, 19 Aug 2019 16:48:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 185sm18769681pfa.170.2019.08.19.16.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:48:46 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 1/3] dt-bindings: gpu: mali-utgard: add hisilicon,hi6220-mali compatible
Date:   Mon, 19 Aug 2019 23:48:38 +0000
Message-Id: <20190819234840.37786-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234840.37786-1-john.stultz@linaro.org>
References: <20190819234840.37786-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Griffin <peter.griffin@linaro.org>

The Hisilicon hi6220 uses a Mali-450MP4 with 4 PPs, so add
a compatible for it.

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index b352a6851a06..ba895efe3039 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -24,6 +24,7 @@ Required properties:
       + rockchip,rk3228-mali
       + rockchip,rk3328-mali
       + stericsson,db8500-mali
+      + hisilicon,hi6220-mali
 
   - reg: Physical base address and length of the GPU registers
 
@@ -98,6 +99,10 @@ to specify one more vendor-specific compatible, among:
       * interrupt-names and interrupts:
         + combined: combined interrupt of all of the above lines
 
+  - hisilicon,hi6220-mali
+    Required properties:
+      * resets: phandles to the reset lines for the GPU
+
 Example:
 
 mali: gpu@1c40000 {
-- 
2.17.1

