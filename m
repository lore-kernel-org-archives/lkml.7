Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D85C3A59F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 05:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DCB2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 05:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj/pTK8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfHRFR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 01:17:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36938 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfHRFR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 01:17:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id 129so5251459pfa.4;
        Sat, 17 Aug 2019 22:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iEatzND/aC5crywDjtqzdYBxGGvNVlFaCiZdi1PIp/M=;
        b=bj/pTK8rTnK0G2wb6zgmdgsYOAMH86NodQ39afYDG8wewHPtmXKLlwBC06mZMVT8m1
         DHDHU29mG3bRxDlLByV9B4jX6ypaDh1wxHMlHA7lYl3ZjocUqJfdRXiKpuy+u8LENkzd
         Cux/JbVNv0VGO+TeL+4pLi55El7LD2wmcCPqXCREGx5XznI0q/m4uT/bf67l3ZaGdnXv
         OO7TyHxhaTsgevKgBQKXnbh+UWCLZeaKQjmw2Yqc2pXanIVzyyhKLISG5sG/uGfu2QlN
         K2Qomkp/izzwhVWgYNX9Fwtjhtz6Smo4xSHvjaQZzCicTutoDiX8PVjh/Je68d/cooAU
         H6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iEatzND/aC5crywDjtqzdYBxGGvNVlFaCiZdi1PIp/M=;
        b=ZzBJzeTtRzVoVRxQ8oYLRdV0IJOqG08rhLsZp7/4Sqk+FbCyjwkScfLhX+5+Jngq4V
         naGkoBEkOQGJhqIJcxitgVCyi5pbAhPEnmPPxk1Fiboj9a8vAVfvxtf5Ni63QOf7S9oy
         BV+ZA89zm5l401hhhuaBqw9i4BDTRJcF/ccCIE8aPHfZ7z4GqHsHNM/jExcV95teXJis
         pIe9helQ590+fks4Y4Bko/VrjDuNqQCSCP2OkK5HBlofi5OHUamqlcM1iRaKw/bvdzV3
         3XzJcqixLEKXA6TutT3TvT6CoqmoJDMsAHWCZMYeQ2EDtmiBvtBLRSTiAqMT+qMOV0L0
         DKSA==
X-Gm-Message-State: APjAAAVtmRkQ0ZZ+RzrUZ2afe+jlbaupocvGJpDRPJW7whkQmrl/jxWM
        d5uAJIayADM7PhDaVHbIHhbGr5fa
X-Google-Smtp-Source: APXvYqxPs3xRYAWZAfHHfrG4KT/BjwTX0VXpuewNXGxuYyDrzmpuRKY6yGRtyoFfkm3kx1dfqWg0Yg==
X-Received: by 2002:a17:90a:b016:: with SMTP id x22mr15275516pjq.116.1566105477716;
        Sat, 17 Aug 2019 22:17:57 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id j5sm11599982pfi.104.2019.08.17.22.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 22:17:57 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext Milbeaut HDMAC bindings
Date:   Sun, 18 Aug 2019 00:17:54 -0500
Message-Id: <20190818051754.17548-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818051647.17475-1-jassisinghbrar@gmail.com>
References: <20190818051647.17475-1-jassisinghbrar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Document the devicetree bindings for Socionext Milbeaut HDMAC
controller. Controller has upto 8 floating channels, that need
a predefined slave-id to work from a set of slaves.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 .../bindings/dma/milbeaut-m10v-hdmac.txt      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt

diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
new file mode 100644
index 000000000000..f0960724f1c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
@@ -0,0 +1,32 @@
+* Milbeaut AHB DMA Controller
+
+Milbeaut AHB DMA controller has transfer capability bellow.
+ - device to memory transfer
+ - memory to device transfer
+
+Required property:
+- compatible:       Should be  "socionext,milbeaut-m10v-hdmac"
+- reg:              Should contain DMA registers location and length.
+- interrupts:       Should contain all of the per-channel DMA interrupts.
+                     Number of channels is configurable - 2, 4 or 8, so
+                     the number of interrupts specfied should be {2,4,8}.
+- #dma-cells:       Should be 1. Specify the ID of the slave.
+- clocks:           Phandle to the clock used by the HDMAC module.
+
+
+Example:
+
+	hdmac1: dma-controller@1e110000 {
+		compatible = "socionext,milbeaut-m10v-hdmac";
+		reg = <0x1e110000 0x10000>;
+		interrupts = <0 132 4>,
+			     <0 133 4>,
+			     <0 134 4>,
+			     <0 135 4>,
+			     <0 136 4>,
+			     <0 137 4>,
+			     <0 138 4>,
+			     <0 139 4>;
+		#dma-cells = <1>;
+		clocks = <&dummy_clk>;
+	};
-- 
2.17.1

