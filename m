Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BB7CA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C28208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VRinFB+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbfJ1H5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:57:40 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:36261 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731140AbfJ1H5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:57:40 -0400
Received: by mail-pg1-f173.google.com with SMTP id j22so345532pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0tOD6xTgafBMzD/bQT7mA2BK+hDrqf70u3fKrnf/Mq8=;
        b=VRinFB+OJkAI+0T8PjMCYoRQof4sh3mxSQmc2bhFFpv5fQnmTVGIpuPnVScat+4NDl
         ZfRqSL4DtLJ9PjAZwFTE/XRKr4Bk1fpmj9A9em4QCzb4LfkN5SdZoXeOGc3DLup8wy/H
         IF7JO+Bh9BZmkQ5Pm0SqNPbOxgL3IJGtRmuPB/z3oWOEJp0ycpzuH64hWYIPpWd+spaC
         x7+S+69A4ONXZxmM5bQnJFxLEtv+K8ExMnoogG3mcYRaEsRDXB4hYOE53bNQCmiZHvVn
         9ladJtnMbBlAT+rQYn/+3maNCNUOUCEMApRmhSl/25xXFr+LpUW3gmtshzX79xsMhb3Y
         b0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0tOD6xTgafBMzD/bQT7mA2BK+hDrqf70u3fKrnf/Mq8=;
        b=pdzyDZ87cKOe9WMo8DmJIUMZ8YII+S1DmxpzaWqcP8yMN0MMv0x7u95U+1LQkovYch
         OO91eLfP78xZysQycUpB/SfrfIyLmNJuCFuYQ05Xi3WWC3RYAN63GhyK99yDh+FdVywO
         Czg6RkJi9ZqxPZKzt0/36ejfgjBM0Vdh99xdrQFWXkYP/bDnyRHg8tl7E7YuwqFhBXO3
         fgz/qFwvqmhgaKBodYCgrzRX0aORzFF847Tk1xiMViC6C2YgNAo2c29DMXDolk+mqVpW
         Vx2Kj+CrgeBmfp9wsFDD8xNfJFktXWMmcdGI9P8mRORntgfcu9Sh+/F/EgDDzVORZ5Q1
         41QQ==
X-Gm-Message-State: APjAAAVAQzbRIhCIUGbnacP1BX8C0q9GUQdOBMThRnqezGEKBiuzFM/C
        k46j6r9aAZEOMVZqsQLE7lBNyA==
X-Google-Smtp-Source: APXvYqz+AAFzlNhGkv597kxEls8SCGWc37dH13XlmSzuhKJPPkYP/vWnh+D92sxsTEH0WNQUaCTWjA==
X-Received: by 2002:a63:4b54:: with SMTP id k20mr19750139pgl.70.1572249459319;
        Mon, 28 Oct 2019 00:57:39 -0700 (PDT)
Received: from localhost.localdomain (111-241-170-106.dynamic-ip.hinet.net. [111.241.170.106])
        by smtp.gmail.com with ESMTPSA id y36sm9504752pgk.66.2019.10.28.00.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 00:57:38 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] dmaengine: sf-pdma: Add platform dma driver
Date:   Mon, 28 Oct 2019 15:56:19 +0800
Message-Id: <20191028075658.12143-1-green.wan@sifive.com>
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
[  267.563323] dmatest: dma0chan0-copy0: summary 45629 tests, 0 failures 38769.01 iops 309661 KB/s (0)
[  267.572427] dmatest: dma0chan1-copy0: summary 45863 tests, 0 failures 40286.85 iops 321643 KB/s (0)
[  267.581392] dmatest: dma0chan2-copy0: summary 45975 tests, 0 failures 41178.48 iops 328740 KB/s (0)
[  267.590542] dmatest: dma0chan3-copy0: summary 44768 tests, 0 failures 38560.29 iops 307726 KB/s (0)

Green Wan (4):
  dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
  riscv: dts: add support for PDMA device of HiFive Unleashed Rev A00
  dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00
  MAINTAINERS: Add Green as SiFive PDMA driver maintainer

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  |  55 ++
 MAINTAINERS                                   |   6 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |   7 +
 drivers/dma/Kconfig                           |   2 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/sf-pdma/Kconfig                   |   6 +
 drivers/dma/sf-pdma/Makefile                  |   1 +
 drivers/dma/sf-pdma/sf-pdma.c                 | 602 ++++++++++++++++++
 drivers/dma/sf-pdma/sf-pdma.h                 | 123 ++++
 9 files changed, 803 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
 create mode 100644 drivers/dma/sf-pdma/Kconfig
 create mode 100644 drivers/dma/sf-pdma/Makefile
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.c
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.h


base-commit: d6d5df1db6e9d7f8f76d2911707f7d5877251b02
-- 
2.17.1

