Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2E0C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C2821655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUuIF6rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbfFYKnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:43:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43404 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfFYKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:43:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so8611976plb.10;
        Tue, 25 Jun 2019 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rkU+SjzCEWdgQCPJHmPaU3HbLqD9ceb7FSy53eQ0IIE=;
        b=kUuIF6rHI5NKBa5iWf2twpG18ea8+rZHSY1Kax01fxVPvrvjYf9h+7itV2ANaHaT4S
         0wXmGNs1c1XvV5YWxiFZW5J2iynhf+YLlkfLnTN3QQoY5KN3oqXr6/A1Gv/VVY08ZVB2
         Y/OSPQMKwzsVXe7KuIbBd6CiXikmUoYcJ35JT1qV1fHn++ZnWK+Yr9ley14eD+aVuD79
         DLycYsfIqXwGL+rz1pPWUF+Hgk05kzp+3w8ys2UzNednQ1E0ptHsiIprP9o4zN2aUguG
         K8GzkUQB7pvVNBp1Hi+eJjU/Qnz3CE+DYOyz82XW/46iAn7D9hYHXJJHM2AGVMynzFpe
         Zd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rkU+SjzCEWdgQCPJHmPaU3HbLqD9ceb7FSy53eQ0IIE=;
        b=oESAx17mpGUdkFBliSQgQbriZDSZAe7Iny2MzbGUB41ONxsvSclJxKBH/VKnNBQpX4
         R1IQXz96oMdf9tT2oXFPuuUSXGY+ghEhzJisGIETgz/HwG3gtDW/9FQvS3YUx0lEUMd3
         LX/8edDw0122As31RdABu0P0nmPf09bWwT/yM9XYG+J7JWkHxSS6cbKIfjCYJZe1fqUO
         DaAFuMsQX8/3n5ooJu9lte4Vj2kZgiyJYLg1jcWKyqPV1ronhVnPr0wklGO3bJnkvqd+
         i7rrnGrqWhyjVqFZhGTJfG3cMl5jYTsraPNRBHBF5OrPRHUoYiCJOqWfBvJ/biTRs0Ds
         bLUw==
X-Gm-Message-State: APjAAAU17tWbbgsLLZl8wSHr3Jzx3NjSmi09Z4a/Gz5wNQD0Jwj/PcKk
        apC9xu76nm6bbDV/fuMIGDo=
X-Google-Smtp-Source: APXvYqzZn/CgQDrn7rDPGw4KYvyAuYwZGm7rkrHHdSrHZZfcaTfeRmErNwWLBQ9WwkiMPzzf74Eh1g==
X-Received: by 2002:a17:902:4201:: with SMTP id g1mr45846094pld.300.1561459396428;
        Tue, 25 Jun 2019 03:43:16 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id 14sm22026759pfj.36.2019.06.25.03.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 03:43:15 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch v3 5/5] Documentation: DT bindings AST2500 DMA UART driver
Date:   Tue, 25 Jun 2019 16:14:36 +0530
Message-Id: <1561459476-14268-6-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

documentation for Dt bindings for DMA based UARTs in AST2500

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---

Changes in v3:
- change logs added

.../bindings/serial/ast2500-dma-uart.txt      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt b/Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt
new file mode 100644
index 000000000000..6f01ddecba56
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt
@@ -0,0 +1,40 @@
+
+node for DMA controller:
+                       ast_uart_sdma: uart_sdma@1e79e000 {
+                               compatible = "aspeed,ast-uart-sdma";
+                               reg = <0x1e79e000 0x400>;
+                               interrupts = <50>;
+                               status = "disabled";
+                       };
+this node  doesn't binds with any driver.
+DMA controller is handled as a separate SW layer,and is included in the same driver.
+This DMA controller node is included in DT just for Register base and interrupt details
+
+
+
+node for DMA-UART :
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
+                 dma_uart1: dma_uart1@1e783000{
+                          compatible = "aspeed,ast-sdma-uart";
+                          reg = <0x1e783000 0x1000>;
+                          reg-shift = <2>;
+                          interrupts = <9>;
+                          clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+                          dma-channel = <0>;
+                          no-loopback-test;
+                          pinctrl-names = "default";
+                          pinctrl-0 = <&pinctrl_txd1_default &pinctrl_rxd1_default>;
+                          status = "disabled";
+                       };
-- 
2.17.1

