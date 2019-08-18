Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9FBC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F072146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bf2zep6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfHRJem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:34:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50617 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfHRJej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:34:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so517162wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZhMjRQVUEje4pWcMn5B2XzOL8/LIS1Q9fLZX8B7OoI=;
        b=bf2zep6GD+VRN6hhSFmRjy2pIhRR/mwUeg6DjcBhVNJKQS4Z5PEHtOpb64Rqtf4EYM
         e6DEBvwS+ip+M5K3vuIvpHj2UjJkM5bFRXtOD9QUEbmrFFBNSfJmkLr+JRQESnMlls3L
         QENqVfohnM9UjhqfZxL1inzFN52+NlFlg2k6YptPDpBAkpZ7rpMURGhyxyW/lN/maCPb
         nc+dob8vS0dXb5kA3nYdQseeVPhCahZK/U3KAwrPpCtx8ZVh/8M4DzoiDkGNVWfPJQw3
         Jq/Cc3fhRdYTN5ym2zpp1krci6nFjn8ztAKb00vM53fLaZP7+Y1o5YSsZw68NdfQJg3K
         3FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZhMjRQVUEje4pWcMn5B2XzOL8/LIS1Q9fLZX8B7OoI=;
        b=fEJs0XapoMD1p0yiGsKEmtmnx0/oZxqmltXf0PLSob7ezo+qXrS+ApGJDJzA/I1bIy
         J4QTquizGLpuJcBkWNpyPcfSfAzEdV3ixdh9douNmKe3KkzlQJ+EHOwWhHT3Hyr1E8kV
         MQG8v6uMBqUe1lcCflU7Rx/xSftj7F9NcOdSkX1P9uNxlt+BW8308qtq0mEqkyC8mQ5c
         +ee5hMS6oa3PzEnfknK2KFuAyNT1df22i4bp134omd+jb+d50z7IQicPCjWx3bImCaR8
         /Ch8WKUYitjMRxwyi/6C6fkIHSADJu+jEP4UOT2wHQswucVT3tO7INxQMZm6XYAVkS+I
         E0BQ==
X-Gm-Message-State: APjAAAU6U2w1O3qj20KsM91OHqszSK3Dzpn4Jo6NeGEprYMx7TPhL/e3
        vVgSx6sClYabUFnysbaC2K08lw==
X-Google-Smtp-Source: APXvYqxv0sdBufS/JlM7yrMIhyTAi9PqAT+A7XGqZoDDWj+wHkGmlmorC9p8VTyShsfPTfym085sUw==
X-Received: by 2002:a05:600c:2487:: with SMTP id 7mr15310383wms.141.1566120877029;
        Sun, 18 Aug 2019 02:34:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w13sm25042828wre.44.2019.08.18.02.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:34:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/7] dt-bindings: imx-ocotp: Add i.MX8MN compatible
Date:   Sun, 18 Aug 2019 10:33:39 +0100
Message-Id: <20190818093345.29647-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
References: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add compatible for i.MX8MN and add i.MX8MM/i.MX8MN to the description.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 96ffd06d2ca8..904dadf3d07b 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -2,7 +2,7 @@ Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
 i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-i.MX7D/S, i.MX7ULP and i.MX8MQ SoCs.
+i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM and i.MX8MN SoCs.
 
 Required properties:
 - compatible: should be one of
@@ -16,6 +16,7 @@ Required properties:
 	"fsl,imx7ulp-ocotp" (i.MX7ULP),
 	"fsl,imx8mq-ocotp" (i.MX8MQ),
 	"fsl,imx8mm-ocotp" (i.MX8MM),
+	"fsl,imx8mn-ocotp" (i.MX8MN),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
-- 
2.21.0

