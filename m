Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5691CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E6420836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHRn7Wfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCDI70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:59:26 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35181 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfCDI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:59:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so2625233pgd.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SoDrBkOVmuphE2/VhZKfVicoMfni0jnwyrCgTRIYWJk=;
        b=vHRn7WfmmcjbMKbDgJAxFrMwTtR4pr5yXTZCJDGEL9XU/z/asD02xruTX1KdmXRfs/
         YfWASs4bGdQhOsDQbQLS+TdibC9Szq7NhH/0hj6UO3Y3ElLZ2kSzzlr9xZp3dBJmUZcO
         /jJ+V9Svp7zPLEmy1ORd7TOrbMgG0XBJdVY9EFh3GlflwPqctG1rzZA7xFWQdkvP3JnU
         o8Avm0LkqhUq2T9Kbr6TnCwXhiUt4LXjKV64sg4domxUb8HG7v85RZGgpD+o4Mu3MWlR
         bMijj3XHxdcVqDjaT8PZSdJBQ2MIablfaNLtRjcFXQkivv4aGWky7+NT0/ZJmfwjEBKu
         LKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SoDrBkOVmuphE2/VhZKfVicoMfni0jnwyrCgTRIYWJk=;
        b=Dtetq6AjR47w5yALqbkG5dAPIYWuFddjGtX0kpmOhKWoMYX2NUI1mN+Gixef4sHXil
         8/jX3c0v0khwqNYc0GSnRinzO6D6o/YIkn+T2Ea7+/bESo5g5uagy+ZPMNPivUlCtlj4
         EHa2CGF/BBs18b5HXRzce6Gr2HPRv+Dz4OZmelKNHe3xHBnONVcHVZVT2yysEeKamRNi
         8VrPz/RRUN2BVrq6Z/R4Jcm/YMTplKx72iSPuH+CRH6HaJ9gTS/Omep/Gcq4lNENmHic
         YcUt92XxZeMlxu7Cfpc+lAmyNkexlmDoq19XiCLvtwOigj7NDcOjhxvtnoxuqedDOx4O
         q0Og==
X-Gm-Message-State: APjAAAXh2c+r+RVKTL7kBKYeg8dcnjoIst+++q7VNdz8I4c1VIxC4TZf
        sUB/wYgLZ4JE/cJoGgZWHWf6nw==
X-Google-Smtp-Source: APXvYqzRuhiLEu1ZkhG7wq/nUC4TxZ203xoAuaIUm09zSeO9yy9lobadFRTWZYLD1XJb/UmGWlEOqw==
X-Received: by 2002:a17:902:2702:: with SMTP id c2mr19131834plb.239.1551689964194;
        Mon, 04 Mar 2019 00:59:24 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k8sm7395523pgg.75.2019.03.04.00.59.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 00:59:23 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: serial: sprd: Add dma properties to support DMA mode
Date:   Mon,  4 Mar 2019 16:58:23 +0800
Message-Id: <5ef1bbcf1d78829f28377a599d81d0adc7d61ef1.1551689518.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

This patch adds dmas and dma-names properties for the UART DMA mode.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/serial/sprd-uart.txt       |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
index 6eb5863..9607dc6 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
@@ -15,12 +15,18 @@ Required properties:
   UART clock and source clock are optional properties, but enable clock
   is required.
 
+Optional properties:
+- dma-names: Should contain "rx" for receive and "tx" for transmit channels.
+- dmas: A list of dma specifiers, one for each entry in dma-names.
+
 Example:
 	uart0: serial@0 {
 		compatible = "sprd,sc9860-uart",
 			     "sprd,sc9836-uart";
 		reg = <0x0 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		dma-names = "rx", "tx";
+		dmas = <&ap_dma 19>, <&ap_dma 20>;
 		clock-names = "enable", "uart", "source";
 		clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
 	};
-- 
1.7.9.5

