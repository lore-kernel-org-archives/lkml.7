Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C87C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4B221530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsv5gJl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFULQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:16:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46844 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfFULQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:16:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so3420570pfy.13;
        Fri, 21 Jun 2019 04:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KMyXv5aakUqqkMZrvi++eRfv70/KfjHLYwh+rLZXzWg=;
        b=qsv5gJl+MMjFjLl6q60KT5vpch2f6ZLYb+7BzlP50HQ/8+LY1SZoelxfS45G4prSXP
         M0BH3/HsELaYFRN0Utwi/uINzNXSRExFaBnR3RBr6b8MK+1DaYjMLMOsSsrHZMug8rIS
         Zj5F1mf1roU56bjCSihvM5gOtX/x4SAYU85qjBD5eUmL+O0Nx6qJhAdTlbCNWqG2SXRI
         50Ij1AOsMsM5sgYY9aY8aLPr0pG0zcYHY7X1CAzL30TOv9RDGOM8DpYeCmKnAC75hVj8
         1lvMMZPSv/ViO0Z/6aDEgik+fu2FPqXsDTnzXVlBMY0UneMwanA6l78dTVotju8tFhbn
         giHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KMyXv5aakUqqkMZrvi++eRfv70/KfjHLYwh+rLZXzWg=;
        b=QTt56C6uswQqmI7YLn0f8w5uI2UA7Oxpnok1hJffA54iyxVc6kqwJw/CDwxuA/xqqj
         glYTKk2ZIk1SyYRqQaKS3VUaLwrYx3yQNHm3oG9MWRyjlQJqGwgopFyO7uJP8xK2VHyO
         cxTovIkxhG8vfzrwxpNweZNrMAr78ALObWjLQlJi2w2JOZHahrJhIbcFd9IOseSWoEli
         WeV4B+s8O0nlcfO5PTG1pALrAJQMbVSkTGf+QBqUehfQPnkym7pcO5lj+js+2pahK7iY
         9i5GHBi1PVO9u8QEg7Obsm+QRT5PpkFiUuHjcnjY/9AkdG7kcG3OpQ4eHEAEsbz0XGZI
         IKPg==
X-Gm-Message-State: APjAAAVeXjUbTonl7Z1FWKnoin3P7vRiPFDtuiC5U1xDfgAaAfj8oeRD
        935GfqUajajSYgF3c7YrkdM=
X-Google-Smtp-Source: APXvYqzYNtXxb4tzWuDYvtdWaeALgnRgqk7i5JnGPvjR757T4G/qDe0ZN4RVho1fH/Ibw4XCUdjIDg==
X-Received: by 2002:a17:90a:9291:: with SMTP id n17mr5871711pjo.66.1561115788928;
        Fri, 21 Jun 2019 04:16:28 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id w4sm2405737pfw.97.2019.06.21.04.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 04:16:28 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch 5/5] Documentation: DT bindings AST2500 DMA UART driver
Date:   Fri, 21 Jun 2019 16:47:35 +0530
Message-Id: <1561115855-4186-6-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
References: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---
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

