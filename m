Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3959FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAD220830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mnvx0r7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCBTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:19:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38901 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfDCBTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:19:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so7268317pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kSolIjpcS4KFmbpQ8n1/1zYx9/KPxw6Rm4TltMR98RE=;
        b=Mnvx0r7fCA3AF0FQVGTl6TDoJZtlKSVFgPQ4QNQtmbF/oKApQZk0ojEk1ae+qrLQhy
         StTVMKie0Hf/WXlo4XWxKc3qAiO/4NsilGMcasObnL5kBdlnWCtBeWYjAOsKeLR6O0AU
         zxP9E+5n4uobsLBhCf86BC89A1zi7mp46UmBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kSolIjpcS4KFmbpQ8n1/1zYx9/KPxw6Rm4TltMR98RE=;
        b=tC1JHhxWWWbSB2PaCH6sM1gPn4sRAWUQXWh/iwLLicQmVnYlpe/C72Eej7mERR3Pvv
         796e8BT6/cvAiqwnFmnrz5S5+Qpef0y+2XF+S3Ceu6VQfCZdeNHE+5WV8Ddqe2HICsRC
         YBw/rGy4OV8GyuySCfQIVFbBorVY2xScotioPdk/CS40ku7Su901u61cXUdbqnuf10mt
         f6apdhWbnTbW7hIytwzCYAb9R4YddgBAKr1xzJnS2uQJGLZj3u0qCispWVCE4zGT8Nvk
         xwYhP+TRTDdh6ySCWqQ9+th8B4cmaGTX0CpBAYMO37yO1BzrD9LTvnsdnJV8dFFUwHKq
         aUzw==
X-Gm-Message-State: APjAAAX+hv0f/sWiroNMnseM6I3LvKmMy0J9n0s70GYNvgTzdwOeT9aq
        Fjpm8i/ET+6otULzPJ/iZHLlhw==
X-Google-Smtp-Source: APXvYqyihJc8gSfv03BZorpE/lldfFnsE3vrY4rP9rGMmMdKcithPLeAaC7qFSTeLWXB6rbeq9QI6g==
X-Received: by 2002:a63:554b:: with SMTP id f11mr11120511pgm.77.1554254340513;
        Tue, 02 Apr 2019 18:19:00 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 4sm19589046pfn.159.2019.04.02.18.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 18:18:59 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v6 4/9] dt-bindings: i2c: iproc: make 'interrupts' optional
Date:   Tue,  2 Apr 2019 18:18:25 -0700
Message-Id: <20190403011830.3254-5-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403011830.3254-1-ray.jui@broadcom.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the binding document to make the 'interrupts' property optional.
For certain revisions of the I2C controller (e.g., iProc NIC I2C), I2C
interrupt is unwired to the interrupt controller. In such case, this
'interrupts' property should be left unspecified, and driver will fall
back to polling mode

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index 81f982ccca31..7a32bf81bfa9 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
@@ -9,9 +9,6 @@ Required properties:
     Define the base and range of the I/O address space that contain the iProc
     I2C controller registers
 
-- interrupts:
-    Should contain the I2C interrupt
-
 - clock-frequency:
     This is the I2C bus clock. Need to be either 100000 or 400000
 
@@ -21,6 +18,14 @@ Required properties:
 - #size-cells:
     Always 0
 
+Optional properties:
+
+- interrupts:
+    Should contain the I2C interrupt. For certain revisions of the I2C
+    controller, I2C interrupt is unwired to the interrupt controller. In such
+    case, this property should be left unspecified, and driver will fall back
+    to polling mode
+
 Example:
 	i2c0: i2c@18008000 {
 		compatible = "brcm,iproc-i2c";
-- 
2.17.1

