Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95439C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2A32173E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hyZVfm0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405392AbfITI7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:59:44 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35182 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbfITI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:59:44 -0400
Received: by mail-pg1-f176.google.com with SMTP id a24so3468364pgj.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fl7tvYNwHE+ftYPEVIMQMzgm5oG99WNIuJI3GxZgUsA=;
        b=hyZVfm0sFvnfaVQ8yA97zAHqoWuJ7+HR/2+eWXOyui1BFw6qlUB9f6vMq+kKuLsiA8
         OBIaI5j/gM9V8KHksAR8fWJEpJgawjRYNS88Ea1YGS21kOK56j8DU5YpyzqqL+8IXwiG
         YJTqMcklLsVrIbiCcrpICEEFsmW0JbG3X1KGLjxJHBIBDnifxUco/NWjDfIlI/bePnrJ
         dH+SsPUMJfqh/jZWhd2RwSxI8c1KRL3fxgGyNnkNT6xqNMNGoBxECIlYE57tlnqriDqa
         oQ+WuCYAEFr/C9eYGbbvAz/n+gfcyfoI3V0rZfSqXJLMyNGzEp8K/ZUZjcB/J/Q1BEj6
         cuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fl7tvYNwHE+ftYPEVIMQMzgm5oG99WNIuJI3GxZgUsA=;
        b=J1UAFGTwoH/mM498FZ+pr7c7TyHpPnMV1AefOT+HNGVn5MI2aSKQkYR8V5Nh7OPJfI
         21UVfBKkWLoQ2KxAgBV+06VyWJTo8tdo1spTXKKLoonsPYtziyHXyq3g/WQMC5WZBbvy
         laH51HzwX1/lX9f+IvJ2CmRX7LX9en6Puif3gLS7jA1n/O4Ylng2r34OF+hGtwCaUV1F
         //Q+fDRzY+rOLs08dMMf0n+Zn1+LzsCzPlT5Q3WM+mB6T3fI18cZ+Vln4sEREVFtpu9b
         qkOUmM6ed0OmNEXS6rzjR0tzR0G6JX/meij37ZiYuCfkevZCCAnlRAqmOpmubkoiz9x2
         D9+A==
X-Gm-Message-State: APjAAAUc5pgt667A6MFGfMqa6M2+6cmTJWn7Ma/3LABkZtIXEh7cni4a
        aHZx3mSBf43SNMQ9R/eZqJHhQg==
X-Google-Smtp-Source: APXvYqzmet1EfGHuUHqh6NTQ1lvfZsx/K1gCHSn3id2QMeiTRQkBQBnhD+Yp5VeV4ljcAy19JYpMFQ==
X-Received: by 2002:a17:90a:aa0a:: with SMTP id k10mr3457599pjq.18.1568969983538;
        Fri, 20 Sep 2019 01:59:43 -0700 (PDT)
Received: from localhost.localdomain (36-228-113-219.dynamic-ip.hinet.net. [36.228.113.219])
        by smtp.gmail.com with ESMTPSA id h3sm1144046pgb.13.2019.09.20.01.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 01:59:42 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] dmaengine: sf-pdma: Add platform dma driver
Date:   Fri, 20 Sep 2019 16:58:59 +0800
Message-Id: <20190920085930.19380-1-green.wan@sifive.com>
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

[Expected test result]
[ 7756.975356] dmatest: dma0chan0-copy0: summary 11208260 tests, 0 failures 36207.82 iops 579325 KB/s (0)
[ 7756.984093] dmatest: dma0chan1-copy0: summary 11206263 tests, 0 failures 36007.36 iops 576117 KB/s (0)
[ 7756.993453] dmatest: dma0chan2-copy0: summary 10929638 tests, 0 failures 33984.39 iops 543750 KB/s (0)
[ 7757.003008] dmatest: dma0chan3-copy0: summary 11204208 tests, 0 failures 35759.65 iops 572154 KB/s (0)

Green Wan (3):
  dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
  riscv: dts: add support for PDMA device of HiFive Unleashed Rev A00
  dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  |  55 ++
 MAINTAINERS                                   |   6 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |   7 +
 drivers/dma/Kconfig                           |   2 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/sf-pdma/Kconfig                   |   6 +
 drivers/dma/sf-pdma/Makefile                  |   1 +
 drivers/dma/sf-pdma/sf-pdma.c                 | 623 ++++++++++++++++++
 drivers/dma/sf-pdma/sf-pdma.h                 | 124 ++++
 9 files changed, 825 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
 create mode 100644 drivers/dma/sf-pdma/Kconfig
 create mode 100644 drivers/dma/sf-pdma/Makefile
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.c
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.h

-- 
2.17.1

