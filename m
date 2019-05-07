Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5889205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ClkS187g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfEGPPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:15:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41646 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfEGPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:15:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id l132so3868936pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:from:to:subject:date:message-id:in-reply-to:references;
        bh=hsW4nLPXM+q/uY8MZYS1nps05YO+5x2cf5Nbss6qqYE=;
        b=ClkS187gzhi/j1pAPSt6DjelbgpPXv7fjPdfzDV5qJFZvVL/W1eB6MRvaIHMkL1YlF
         pAjVyMroQ4MkU/9oeDSWhJa17pUefKXId6mr8kgz0EEGuZQFP91sS1XfCqcXs47UF9rQ
         7dEymJY2nJgMLXRvZ0fz7wBEFuXsMuNoe8NdOShlmskNuDYYeOiJ8Tzj34QdKU5d8j4r
         ENTIm4l6tM2JOx2x+Lg4mIDkpXINbB8YaavDO/p+RBL4hjLoibx0xK8XVVqWMnaC7MdM
         DOogTingeVjfEUlirlITsKl3ddLCz/Y6H7rIgtRBx0P0UXMf6Ql3bnHCqLwkJSmQ09Of
         PJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=mime-version:x-gm-message-state:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=hsW4nLPXM+q/uY8MZYS1nps05YO+5x2cf5Nbss6qqYE=;
        b=K5YQV5Kcli38lMATSwTz20mYuEe/TigC9d3jhoWzTNGn5BPA8nXaULFqslHhJz2EpZ
         L2skOrNKXCMOdRQ8ukZH5A8FdMGEmUA/hfyB12YlG8B/MYbaIxoYKa63z6D0zT3kxU62
         sA6lcN5o7pfx6Q08OL4ctdBzPKaAGuBhDSBpLlaRtY8MOf0d2+SSzFidy+kprH4fambC
         Ccl4VkqPe019taBs8JdknyE02StAgkyVGg4dzdcxgERqCTRb1HujGaxJC0sx4l7awvsn
         FsTpElU7eT7nsyXu2TgVZ0V9y+edIxh8FYBgrZeMWQ/BsDqG2xf0IALS60KMvk54VUCW
         K9EQ==
MIME-Version: 1.0
X-Gm-Message-State: APjAAAXOEJIM0TIMDN1lWHOBzl+4QOaa3Oxeyk4AcUS9EAY4ssLqzQZI
        BoWxwr77WWinieuZ8owjXf8ssgXWjtoKMoOxapH392DcGAiRnIPklSYNQeBGZsYTh1MzHRTfYmu
        F/vsax8OLLiu5Fq5slQ==
X-Google-Smtp-Source: APXvYqxmlABOO00POLT4NWe6l6j+ZCfYLjr32u7zp94znUQbwT5xkhl7TAvUrQu4mpR/mTRnSdE+1g==
X-Received: by 2002:aa7:8046:: with SMTP id y6mr42416829pfm.251.1557242140707;
        Tue, 07 May 2019 08:15:40 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id 2sm5397398pgc.49.2019.05.07.08.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 08:15:40 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 v2 1/3] dt-bindings: i2c: extend existing opencore bindings.
Date:   Tue,  7 May 2019 20:45:06 +0530
Message-Id: <1557242108-13580-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
References: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FU540-C000 specific device tree bindings to already
available i2-ocores file. This device is available on
HiFive Unleashed Rev A00 board.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
index 17bef9a..f6bcf90 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
@@ -2,6 +2,7 @@ Device tree configuration for i2c-ocores
 
 Required properties:
 - compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
+                    "sifive,fu540-c000-i2c" or "sifive,i2c0"
 - reg             : bus address start and address range size of device
 - interrupts      : interrupt number
 - clocks          : handle to the controller clock; see the note below.
@@ -67,3 +68,22 @@ or
 			reg = <0x60>;
 		};
 	};
+or
+	/*
+	  An Opencore based I2C node in FU540-C000 chip from SiFive
+	  This chip has a hardware erratum for broken IRQ
+	  so it's recommended not to define interrupt in the device node
+	*/
+	i2c@10030000 {
+			compatible = "sifive,i2c0","sifive,fu540-c000-i2c";
+			reg = <0x0 0x10030000 0x0 0x1000>;
+			reg-names = "i2c-control";
+			clocks = <&tlclk>;
+			clock-frequency = <100000>;
+
+			reg-shift = <2>;
+			reg-io-width = <1>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+	};
-- 
1.9.1


-- 
The information transmitted is intended only for the person or entity to 
which it is addressed and may contain confidential and/or privileged 
material. If you are not the intended recipient of this message please do 
not read, copy, use or disclose this communication and notify the sender 
immediately. It should be noted that any review, retransmission, 
dissemination or other use of, or taking action or reliance upon, this 
information by persons or entities other than the intended recipient is 
prohibited.
