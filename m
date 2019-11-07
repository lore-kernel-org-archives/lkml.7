Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09EAC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7914F2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AENY4Zn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbfKGIvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:51:19 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38994 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbfKGIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:51:17 -0500
Received: by mail-pf1-f174.google.com with SMTP id x28so2122991pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wRSTyomOLDs6+V2ErS/oC2G/L0RCS7+9Zv3fKuKSwjg=;
        b=AENY4Zn7wWImtkMCK8pNWAF3xkH4Ggiw1TeVZZxn9N/m3I9ECcqWZRo9NQ5hL0QkJg
         shLGmQ5htRKCntK70+mrIQrYdjDkXtZRGb74kwMGdBnXwe0157esau6X+mvIx2H8zVci
         OQPdZ2mMtn3hXqhVt0EpSx3KH8CtJe9hEWKNRY3RTcksLc5+XYyIXKYesCQjgrgLuM7p
         uPKdrE/M3TlAqRQ7v9JiBAjML52fJx+wbJHSQ5Y5mLRvxkVaM6DJZgUmKpvGUjDYTV4F
         V0GILPJtIgLLGMmfa4JwKqG7z2cvCCUn2dkpa+B1H/34P32Eu0x4unmgoEPAzUoIt8N4
         e+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wRSTyomOLDs6+V2ErS/oC2G/L0RCS7+9Zv3fKuKSwjg=;
        b=NCKANoXMbf/WeWifBbSVKbqD6jFofJm0HMo+DVgooIUw7l5+Vpo7+ny93tbTc418dC
         7XdKp+0uS21QRKc4TDm01SJQUHWSI3CnbudBczkzbqmz6+hRTSyy/1GA7fI+cf/h8y7t
         7wFfIDTuX6pjawQGKCwWxfHh85Veg5J8+fDEt1dGFqf1Kl/btQpVcGv5w7Pnr5z2+bB3
         FzLFnnjPEDxqMjPMuCSjjNLORo3vSewir31iciR4Z338Wb8S28xUtFk5Cph8QXpNPtWK
         zQ2EnXZiF+zbIjvsI5JblnesVK+9tXTEV6oFK9cGFhsbLw1sQBsetdLuAU8/aYwJKEFT
         1uGA==
X-Gm-Message-State: APjAAAWj2e2uwPrFJyyqvy+fH9sZMA3PSayarYLkrsUIejLJjRX65ZgI
        VwT5d76MGNCKnsS8NOg9wu2oNQ==
X-Google-Smtp-Source: APXvYqzxRxALH7Vn3Ne9JafqSo4E0XcubLLZEaYFdKNvjVDn83JWCsE0Y+Sf1Krx0b4nDU5Fy1/CqQ==
X-Received: by 2002:a63:2d43:: with SMTP id t64mr3037018pgt.428.1573116676572;
        Thu, 07 Nov 2019 00:51:16 -0800 (PST)
Received: from localhost.localdomain (36-228-119-18.dynamic-ip.hinet.net. [36.228.119.18])
        by smtp.gmail.com with ESMTPSA id a33sm2402361pgb.57.2019.11.07.00.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 00:51:15 -0800 (PST)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] dmaengine: sf-pdma: Add platform dma driver
Date:   Thu,  7 Nov 2019 16:49:18 +0800
Message-Id: <20191107084955.7580-1-green.wan@sifive.com>
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

[Changelog]
 - v6 patch
   . Remove incorrect reviewer and fix commit number
   . Revise sf_pdma_desc_residue() to report residue according to cookie. The tx
     could be in completed, in-progress state or still in pending list.
   . Refer to fsl-edma.c to free irq and kill tasklet before exit.
   . Minor fixes include left-justisfied, empty line and unnecessary line.

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
 drivers/dma/sf-pdma/sf-pdma.c                 | 621 ++++++++++++++++++
 drivers/dma/sf-pdma/sf-pdma.h                 | 122 ++++
 9 files changed, 821 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
 create mode 100644 drivers/dma/sf-pdma/Kconfig
 create mode 100644 drivers/dma/sf-pdma/Makefile
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.c
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.h


base-commit: 4dd58158254c8a027f2bf5060b72ef64cafa3b9d
-- 
2.17.1

