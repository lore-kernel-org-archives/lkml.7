Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DDBC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED8C204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MmDEdzRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfDSTTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:19:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53942 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDSTTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:19:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so7161821wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MCTEvmabwYzI3ci+NujQrB/hypflAW8OQ75e8/ggXfk=;
        b=MmDEdzRcl9DaSM0D19sHLRP9UUgUb3DU9U/mKJ4uV0lViP+8Df/cara5+dwmvId2vi
         WCLQOT1S9LX6lveDGKTjokIESoUs5zV+Yvi2kw6zAVVXQxJinyhsP81cBiz3+fbe0KXq
         ib3QilCDqnukXnjqqNJxDG7lbKiTmelD2kCgZCXW6E3bamJvWp+dJHAKTUt9EIDg5PJO
         AsDxgXHM9sRx+3nZAzUT1J9faizEapC+cpYUkDdC4uGnPeBtXmOu2wab7KpbQzOGQDRM
         YwN/fvrXryGp/kH7lktMqf7IosiwgS0IQxI/hbqoi3Y+bV/6gjxR+f9ffx6d6suPdsih
         gDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MCTEvmabwYzI3ci+NujQrB/hypflAW8OQ75e8/ggXfk=;
        b=UQAsES6YMd2d0n7KC2cH+m0PMigIsIOzw+AAgBQbAosMKtOr4aHQwyyG3gfGPBSITN
         cd7TbA+0tTHO/N5U26wI/ggPZR/kR+EqhUT9S3+I1o2ESNGQgmD8azYL/XiiI9Dsd5o1
         QGSv/cYT2GADLJtn8CY1ZDgnIJyrJAi5EmlMwCS+YqikzHC31+2AyZVANuYZ5jfCj5aA
         Sf4Ckygkwgawx4XAjPqJYmvmpS9OJECNvkR0IJM6sJi4BmNLyEou9+tHtNYhY3dM8Nwk
         1qjN6XOB4Qf03ITzLTe4fE3itOzbhT2KUeYtVQRBo6rTEPY9CTMqLIVwqReRzz5+3p2E
         DEUA==
X-Gm-Message-State: APjAAAVCKY2vv1xu5uJpIBWmJmRIYoA31sVtDxX9Wa9K3xE+8HkK6WLV
        NYrmbi3mofZig+6tL8fdVGHrPC5Ztmc=
X-Google-Smtp-Source: APXvYqz4to8wAVskrNWhKtpXeo1y+/84uKbi75fWJa+XAgG68NFzqtWiTfz7vu78hoCS57ktmCjphQ==
X-Received: by 2002:a1c:6502:: with SMTP id z2mr1745391wmb.119.1555662904613;
        Fri, 19 Apr 2019 01:35:04 -0700 (PDT)
Received: from localhost.localdomain (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id t76sm5700147wmt.8.2019.04.19.01.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 01:35:03 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de,
        xuwei5@hisilicon.com, mturquette@baylibre.com, sboyd@kernel.org,
        yuq825@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, lima@lists.freedesktop.org
Subject: [PATCH v2 1/6] dt-bindings: gpu: mali-utgard: add hisilicon,hi6220-mali compatible
Date:   Fri, 19 Apr 2019 09:32:56 +0100
Message-Id: <1555662781-22570-2-git-send-email-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
References: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hisilicon hi6220 uses a Mali-450MP4 with 4 PPs, so add
a compatible for it.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 3f128e4..2a16b0c 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -21,6 +21,7 @@ Required properties:
       + rockchip,rk3228-mali
       + rockchip,rk3328-mali
       + stericsson,db8500-mali
+      + hisilicon,hi6220-mali
 
   - reg: Physical base address and length of the GPU registers
 
@@ -91,6 +92,10 @@ to specify one more vendor-specific compatible, among:
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

