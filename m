Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C764C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627B022CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoDzl5dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfGZNZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:25:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43830 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfGZNZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:25:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so24788263pgv.10;
        Fri, 26 Jul 2019 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DCfqG2JMRKwxzIsSj479KFdZDqfmx3j+5mtM0thRZ58=;
        b=LoDzl5dV4EQI2pUj8qVRXOAIoTnhZqceQpnFZnYzGnjVxpbtUcLiRPGuN6wt1cfrk8
         9puIruzvHJiQfOZv5PZZd+FF2dgvSd71Ci1ZZsjg7m86JizzgmNPqKMYoXdTIvJXHsOq
         NwrVoe5f9PBdtRH6N66l5YJxfuFP/gD2F802dhFBTC1SiuwOy1MruAO0NLhYsCq4wZOf
         W0p7+pUa1PZq7pPtfk6RsgItcl4726Ceg/Hk1AB1UoURdYRIUBJi5U5lW32rWnPFVBmL
         ZLWuVXX3k3ADP/NhY8j8zdnTzj7neDsmjmOy8n4vuaEr5QmFHjVNvBHoTOFwObaHUPMG
         zgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DCfqG2JMRKwxzIsSj479KFdZDqfmx3j+5mtM0thRZ58=;
        b=dSgZbhFaPOd6smCzXFf27KK8rhKxAHLgrpl/aWCEdzEMboGPCcyFgng1ihvC0mRV+A
         vgcWDsCTRn2dBH48ZJ/Nj6yf1unzuE+3R6NyYCxE1/9iYHUodk7PPCZGSW1JC6ITmqMB
         UlrbbOA+mDh9l9iP+BJdGA3m2wIu6hUmHUv6L6BjW7/w/wfqMcH3brU6Bz5FkvEsmemQ
         SAFE52FWnbEl3fsC+jKWSNszuRVOGguxoYR3alQ1kA7GcnGTrSIf7BbjB32rKeBO8lXD
         OIIY6LeohitMqOXzT+ztndkfx/wqTDwUXeSmnf1m6s6g6TKMB3bSEgoUBZSbSIdBH0eR
         umrg==
X-Gm-Message-State: APjAAAV7AezxmRLSzgXevXT5lRbGKk/IWKyzSWW38DKky9ODOa3exO47
        jHPkvMcvnVqmrcqnQF5jWTY=
X-Google-Smtp-Source: APXvYqxJ0TvnmiWTXBEyq2/z1dvr4VEXVLgB/9ZQJw4kX1R9wOUtS6Lanafe6ZYS4kpvndxZEF77AQ==
X-Received: by 2002:a65:5b8e:: with SMTP id i14mr90112067pgr.188.1564147546371;
        Fri, 26 Jul 2019 06:25:46 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id k36sm54544603pgl.42.2019.07.26.06.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 06:25:45 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch v4 5/5] Documentation: DT bindings AST2500 DMA UART driver
Date:   Fri, 26 Jul 2019 18:57:20 +0530
Message-Id: <1564147640-30753-6-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
References: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

documentation for Dt bindings for DMA based UARTs in AST2500

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---

Changes in v4:
-
Changes in v3:
- change logs added

.../bindings/serial/ast2500-dma-uart.txt      | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt b/Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt
new file mode 100644
index 000000000000..6ebc60b51d4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt
@@ -0,0 +1,43 @@
+DT Bindings DMA UART for AST25XX:
+
+node for DMA controller:
+                       ast_uart_sdma: uart_sdma@1e79e000 {
+                               compatible = "aspeed,ast-uart-sdma";
+                               reg = <0x1e79e000 0x400>;
+                               interrupts = <50>;
+                               status = "disabled";
+                       };
+this node  doesn't binds with any driver.
+DMA controller is handled as a separate SW layer,
+and is included in the same driver.
+This DMA controller node is included in DT
+just for Register and interrupt details
+
+
+
+node for DMA-UARTS :
+
+
+Required properties:
+
+- compatible: "aspeed,ast-sdma-uart"
+- reg: The base address of the UART register bank
+- interrupts: should contain interrupt specifier.
+- clocks: Clock driving the hardware;
+- pinctrl-0 : list of pinconfigurations
+- dma-channel: channel of DMA-controller which is used
+
+Example:
+
+	dma_uart1: dma_uart1@1e783000{
+        compatible = "aspeed,ast-sdma-uart";
+        reg = <0x1e783000 0x1000>;
+        reg-shift = <2>;
+        interrupts = <9>;
+        clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+        dma-channel = <0>;
+        no-loopback-test;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_txd1_default &pinctrl_rxd1_default>;
+        status = "disabled";
+        };
-- 
2.17.1

