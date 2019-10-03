Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC58C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F4C217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bByRo3SH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfJCJKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:10:11 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:41336 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfJCJKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:10:10 -0400
Received: by mail-pl1-f181.google.com with SMTP id t10so1194584plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iMtypI6KAEMcJ9rYi5Q4bPpiz/5ORhxuJ1l1aCrdEbI=;
        b=bByRo3SHUyhiwyJbLrcdfQjTPirjMvPtcf3RppEl/w+VbKdFA+wURYYRn+SB1WOfU/
         rJLBKRm7f1HTY51dvB7v+Y/HISSu/LTvBi1DfHBOryRw8YQKyEYepfaWNIWhZaG5TdjV
         mxJlgkgGDEg2gQlcg8mwuaYalNfMlpkEkMJcNENJY18VVOtaLK1H8vj46wCYyj7fecNd
         X1N5BMAXzLLPDM1/akeRy3dfp2JQJjJa43RMVQxAblSamCTlQ0opAXWffIqBkPDHJsK5
         bzupQuUdQu0EeZJhXIS/Ch7CiIWM1TXwVneZFQSmT5BKm72MgWVWDRAswjQ9OpLEGcf7
         vM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iMtypI6KAEMcJ9rYi5Q4bPpiz/5ORhxuJ1l1aCrdEbI=;
        b=cmv63ccIYKyqtawOdqVZrYP3vdhHxHMYUvg1ZYdgsB43Ah+St13VpKmBi3OrlF0b29
         q2YiZpOk2haPo5PRhNIhVuiDMngC2bo3VtV2uc7vZnDOW8mq3eGgr8wzPmWMT8QBgd6b
         1SFoJE7CGLYEJQpdgtGSdK8H6l/veVlYN6pa9J0bqz48FDaC8zXYdeyn+vhsIZM6yDYg
         h0L3lPm245zX2QJRfGmIA8USwKucn9YsrhBlblu9FWqkCkk124L94TM/K6uo0BpBME2E
         h4BhEu5zXVRKTdrTGMPdNpwpkIDsifdAiFqI15v9RKSaoh8ptimhhm6uID91dolBiAgt
         5F2g==
X-Gm-Message-State: APjAAAX7GVWa+yoUmCyVNFoMRWq+VyewsFiGMtc6QlCMX3DJ55DpJLG7
        74o5/6Y/SZE/zQFx1y0e7KDXHQ==
X-Google-Smtp-Source: APXvYqzyE9oM4lS/SzNWMKW5+lppU+ud83w4p3tCW57BC7S0wD+m/pVotdICLfarV0z6n6L75nCJTA==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4mr8164748pls.142.1570093808283;
        Thu, 03 Oct 2019 02:10:08 -0700 (PDT)
Received: from localhost.localdomain (111-241-164-136.dynamic-ip.hinet.net. [111.241.164.136])
        by smtp.gmail.com with ESMTPSA id f128sm3445422pfg.143.2019.10.03.02.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 02:10:07 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
To:     linux-hackers@sifive.com
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
Subject: [PATCH v4 0/4] dmaengine: sf-pdma: Add platform dma driver
Date:   Thu,  3 Oct 2019 17:09:00 +0800
Message-Id: <20191003090945.29210-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
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
 drivers/dma/sf-pdma/sf-pdma.c                 | 601 ++++++++++++++++++
 drivers/dma/sf-pdma/sf-pdma.h                 | 124 ++++
 9 files changed, 803 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
 create mode 100644 drivers/dma/sf-pdma/Kconfig
 create mode 100644 drivers/dma/sf-pdma/Makefile
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.c
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.h

-- 
2.17.1

