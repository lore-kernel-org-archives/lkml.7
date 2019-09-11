Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668A9C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36455206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2nPb2Ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfIKNPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:15:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42968 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfIKNPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:15:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id w22so13648724pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vtC3RazXzeFZetJddN0/LRTlwPvo9DJjWZdotj+TRx4=;
        b=M2nPb2Ez0HjNcUp+BHaiCNfkWF6hykMlJ14HyWMHQCsYNT68/6MYRHhGYTVlh8nrca
         JsIDHwsnt7MeGfREMA4zA9G8PssI9JQ0AutJMaHOelzPBUK1IUjcjsWCHugFhfAYBQ02
         GhDIyM4jYcEzDvHtytUgVYrXm4HNj9h1SvQG9eQ4koaLQEyOCetDcRFiTEobq6rl31qP
         BKHMaD0YTE91VWGr6pkJukv9dqOTXZn6buFwBQZOtZFoRcXd1OJzmu+AJ02s45q79fka
         SjRmWMpc0lo54y2ihJLxKT/7nwJsesJIZEVCk8Bzlr7QCJO/S7CjnfeKv+ejg5OT5w0n
         uzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vtC3RazXzeFZetJddN0/LRTlwPvo9DJjWZdotj+TRx4=;
        b=X89bfHO29h75sbNzQK0OeaE8ymY3k9vVrscNOnMNv77U9VkNhs2+fZuFaqanxr23wb
         UWhPvDAUqsJt4IbK+1/SebI/k3olL8IBCr34TPgqHZsnmFzmmGzQsadLQ56sIKvEe6LX
         iGTe3Sle4VzK2fG0nmM0AyYJR0HBk45qER9qyIjQp6wG/831z8GoWdQ0x1dkY2gY65aO
         sPSXvOTgEHbBZgTMuZPHo3k57KUYkJYjSGG1k3l1On7i2wWS+Fcw8ayxeemGJn3q6LAa
         XJ8IqBa7YD251Cvi1UCDGXxsU4K+iUdzaub9JahNtNkg14Evdql4J3e7kUDDc6Paed4q
         GxTA==
X-Gm-Message-State: APjAAAVAV1zAA1MIdzR4LeEtmhfWQgPvfhrytUGZHbBQ4AwMb263+ytF
        tQyPT7hHcydx/zT9/X4ExJivVg==
X-Google-Smtp-Source: APXvYqyIQMGYC4Wx0HmfyI10qNNUAaz17fVKaZnhq3xD8841c5N4lw0IeH/ZClcAX5YgPHNeo6Z+Gg==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr5471391pjo.119.1568207704284;
        Wed, 11 Sep 2019 06:15:04 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e21sm6420120pgr.43.2019.09.11.06.14.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 06:15:03 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Add MMC software queue support
Date:   Wed, 11 Sep 2019 21:14:39 +0800
Message-Id: <cover.1568206300.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Now the MMC read/write stack will always wait for previous request is
completed by mmc_blk_rw_wait(), before sending a new request to hardware,
or queue a work to complete request, that will bring context switching
overhead, especially for high I/O per second rates, to affect the IO
performance.

Thus this patch set will introduce the MMC software command queue support
based on command queue engine's interfaces, and set the queue depth as 2,
that means we do not need wait for previous request is completed and can
queue 2 requests in flight. It is enough to let the irq handler always
trigger the next request without a context switch and then ask the blk_mq
layer for the next one to get queued, as well as avoiding a long latency.

Moreover we can expand the MMC software queue interface to support
MMC packed request or packed command instead of adding new interfaces,
according to previosus discussion.

Below are some comparison data with fio tool. The fio command I used
is like below with changing the '--rw' parameter and enabling the direct
IO flag to measure the actual hardware transfer speed in 4K block size.

./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read

My eMMC card working at HS400 Enhanced strobe mode:
[    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB 
[    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
[    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
[    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)

1. Without MMC software queue
I tested 3 times for each case and output a average speed.

1) Sequential read:
Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
Average speed: 28.7MiB/s

2) Random read:
Speed: 18.2MiB/s, 8.9MiB/s, 15.8MiB/s
Average speed: 14.3MiB/s

3) Sequential write:
Speed: 21.1MiB/s, 27.9MiB/s, 25MiB/s
Average speed: 24.7MiB/s

4) Random write:
Speed: 21.5MiB/s, 18.1MiB/s, 18.1MiB/s
Average speed: 19.2MiB/s

2. With MMC software queue
I tested 3 times for each case and output a average speed.

1) Sequential read:
Speed: 44.1MiB/s, 42.3MiB/s, 44.4MiB/s
Average speed: 43.6MiB/s

2) Random read:
Speed: 30.6MiB/s, 30.9MiB/s, 30.5MiB/s
Average speed: 30.6MiB/s

3) Sequential write:
Speed: 44.1MiB/s, 45.9MiB/s, 44.2MiB/s
Average speed: 44.7MiB/s

4) Random write:
Speed: 45.1MiB/s, 43.3MiB/s, 42.4MiB/s
Average speed: 43.6MiB/s

Form above data, we can see the MMC software queue can help to improve the
performance obviously.

Any comments are welcome. Thanks a lot.

Changes from v1:
 - Add request_done ops for sdhci_ops.
 - Replace virtual command queue with software queue for functions and
 variables.
 - Rename the software queue file and add sqhci.h header file.

Baolin Wang (4):
  mmc: host: cqhci: Move the struct cqhci_slot into header file
  mmc: Add MMC software queue support
  mmc: host: sdhci: Add request_done ops for struct sdhci_ops
  mmc: host: sdhci-sprd: Add software queue support

 drivers/mmc/core/block.c      |   61 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   25 ++-
 drivers/mmc/host/Kconfig      |    9 ++
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/cqhci.c      |   10 --
 drivers/mmc/host/cqhci.h      |   17 +-
 drivers/mmc/host/sdhci-sprd.c |   26 ++++
 drivers/mmc/host/sdhci.c      |   12 +-
 drivers/mmc/host/sdhci.h      |    2 +
 drivers/mmc/host/sqhci.c      |  345 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sqhci.h      |   35 +++++
 include/linux/mmc/host.h      |    3 +
 13 files changed, 536 insertions(+), 23 deletions(-)
 create mode 100644 drivers/mmc/host/sqhci.c
 create mode 100644 drivers/mmc/host/sqhci.h

-- 
1.7.9.5

