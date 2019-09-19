Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7749AC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423A921928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CtQFocnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbfISH0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:26:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46011 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731873AbfISH0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:26:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id 4so1340000pgm.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LT2z44LmrD8QiD0ZavUH6kqFzDYzxRxS7Yx8XNbtmgg=;
        b=CtQFocnZL4WmYuwxWCYhyEntS5rlt+d1KJfZ+HqgKSog1hBrz8eBhoC7C/vROml3Oh
         AS++a3QV9CsqrBUzgONj0CPB5SzjdH18bMPKvGgPA/TopigokdBDKHJTdr2MO1vdwu9A
         oyCWz79UboRAvyHMV8QE2A7lSeDLGuy7FrLbe9azF3v/ppn5HSRegEli0MrxXI71FkLn
         7yfJlz4wFoUsQnY8gyFCjw+j4+J/lNhR4t6muGEMsg+gZJDjn/b2iBzpZqO4xYbYZDtE
         6QkI5t16FOK6ssoLnkapKTHBxwKZrINNCZ9xNk6K4eQVuS85UDsRcxDa4Ln//yQ10cn8
         PDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LT2z44LmrD8QiD0ZavUH6kqFzDYzxRxS7Yx8XNbtmgg=;
        b=WaeP/uqAfG+fMXUCkKjSWOmiFnMfoAsO1asTHhkLnn1Uq/LlBQNW2PpYEb0q0L9GcT
         2I1Zc6nG0mgX79FQuqo0FKoDMf9YneJSCUJarXd1QIOO8Kx4sfLZa3wzl+fG24YNj/hP
         MU8QUJFEULqdu2MQUo3a+q67vd99uoA5UC+Om8rNgeEmdq3kKZ7uql++d417WoNcbcWg
         v3AjfUxfjksUGg0DSbi2RnuVZwIoG+EXW7N23AQSj/EoOj8Pp00+hYlK4Tsw7oucdZ/0
         ObkS4TN7ZAuRIZow4PVLwp7yk8IxNlKARUsr/8sxX8lCPR9OfrK9ftaoaeHKjqpTohA8
         eaPQ==
X-Gm-Message-State: APjAAAUbUgYV7hFvzrhIZEu9Mr4/YaQd1GABjD3RqYcDHu28IQzht05b
        BKSftyaQey9vnlMXvC4wLsKYog==
X-Google-Smtp-Source: APXvYqzj/tUGOJg5wnHc5YqepfesJlG4rD39ze0qs4Fw4GBM+v3Y4zCzaZ44ydGQGaexDNA219KQ3A==
X-Received: by 2002:a63:3c46:: with SMTP id i6mr7623466pgn.18.1568878004335;
        Thu, 19 Sep 2019 00:26:44 -0700 (PDT)
Received: from localhost.localdomain (36-228-113-219.dynamic-ip.hinet.net. [36.228.113.219])
        by smtp.gmail.com with ESMTPSA id b2sm10453620pfd.81.2019.09.19.00.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 00:26:43 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] dmaengine: sf-pdma: Add platform dma driver
Date:   Thu, 19 Sep 2019 15:26:03 +0800
Message-Id: <20190919072634.1885-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDMA driver support for SiFive HiFive Unleashed RevA00 board. Mainly follows
DMAengine controller doc[1] to implement and take other DMA drivers as reference.
Such as

  - drivers/dma/fsl-edma.c
  - drivers/dma/dw-edma/
  - drivers/dma/pxa-dma.c

Using DMA test client[2] to test. Detailed datasheet is doc[3]. Driver supports:

 - 4 physical DMA channels, share same DONE and error interrupt handler. 
 - Support MEM_TO_MEM
 - Tested by DMA test client
 - patches include DT Bindgins document and dts for fu450-c000 SoC. Separate dts
   patch for easier review and apply to different branch or SoC platform.
 - retry 1 time if DMA error occurs.

[Reference Doc]
 [1] ./Documentation/driver-api/dmaengine/provider.rst
 [2] ./Documentation/driver-api/dmaengine/dmatest.rst
 [3] https://static.dev.sifive.com/FU540-C000-v1.0.pdf 

[Simple steps to test of DMA Test client]
 $ echo 1 > /sys/module/dmatest/parameters/iterations
 $ echo dma0chan0 > /sys/module/dmatest/parameters/channel
 $ echo dma0chan1 > /sys/module/dmatest/parameters/channel
 $ echo dma0chan2 > /sys/module/dmatest/parameters/channel
 $ echo dma0chan3 > /sys/module/dmatest/parameters/channel
 $ echo 1 > /sys/module/dmatest/parameters/run

Green Wan (3):
  dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
  riscv: dts: add support for PDMA device of HiFive Unleashed Rev A00
  dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  |  63 ++
 MAINTAINERS                                   |   6 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |   7 +
 drivers/dma/Kconfig                           |   2 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/sf-pdma/Kconfig                   |   6 +
 drivers/dma/sf-pdma/Makefile                  |   1 +
 drivers/dma/sf-pdma/sf-pdma.c                 | 623 ++++++++++++++++++
 drivers/dma/sf-pdma/sf-pdma.h                 | 124 ++++
 9 files changed, 833 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
 create mode 100644 drivers/dma/sf-pdma/Kconfig
 create mode 100644 drivers/dma/sf-pdma/Makefile
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.c
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.h

-- 
2.17.1

