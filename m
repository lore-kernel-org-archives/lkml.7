Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01823C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22152081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAmPrs68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392187AbfIFDwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:52:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34553 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbfIFDwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:52:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id r12so3416592pfh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 20:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qCgqKjYV/ykBBNtF/kBQMkf0USvwkXzoDwAmbizekWY=;
        b=RAmPrs68cn+hLe8nUZSnXgqPLaMYpsTBpNHfgjrHCPV30r8RxiLMrOav8Ey+Acdjou
         r9s1Ua/hl0bEq4xJsv1adw+D4D5rj8CRc7ItJPJ8PM9ArI8TOyDWcz8WoEQgpQLkGSjA
         bEtuT/2ysMGo+1LF8aqQ82l84J4qr7RZHsqxyNqOI+YCxkwZ2Gob0zo9SLLjG0pnBHRE
         YObTUrUVRKrLZlkMGFxy1VuoIy+ZJGnD1mih5FaDWEt8GuRWdXFhb22HqQ5QClT2uVg2
         bPI2Zmoems/YQTs4jGGihDwr6zeJSr7kWvNlrW6m+gMiSuV7vFF70q9TiZrQTiCotgBU
         i8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qCgqKjYV/ykBBNtF/kBQMkf0USvwkXzoDwAmbizekWY=;
        b=ryG/ZhXy665GZTPDdeuEezJXKT/O8zEh+Z1zHtgVeytvQk6THGd2xQiwoa4gEd4vVH
         ht8xT8IKPTL/yygqRnl06K7TF4nN6qJH5LjUd3WQ4JYlTpkSiWBgVOjTQuhJsvom7WJ8
         gKUuxcL/JRcaJ5Y2h1+HMdxPobhLqcMiadkPrMqTtnstoyZ6Wmd58AELcH2vPUMZnYff
         ev1kX1CIk0kIYNePFIc27CZwvjGNqa/plrw2LjW6idUgM59bDsAp3xqUCt8gY3GQsEOy
         ZysphAmxtXTQmY5UWBaEhV/SvQn7l70QE/bYhtD3mmMVWmBRMfoucGQHjT6S1nnR9ec/
         lV+A==
X-Gm-Message-State: APjAAAXkF2Z7gp1pqzuNwNHKuNhp9myX9z7wzCykAMenOGdkF8vLaWjE
        IUqsSn8K03xJyE41g1yLozymAA==
X-Google-Smtp-Source: APXvYqwUcQBMYbSf9bfcASLVOcXBu22We0wWM1dXWNmWDumoReA9NP+rMDwTlToGeIMLRyrZn/yXgg==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr6204814pgp.368.1567741960616;
        Thu, 05 Sep 2019 20:52:40 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j7sm4205770pfi.96.2019.09.05.20.52.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 20:52:39 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add MMC virtual command queue support
Date:   Fri,  6 Sep 2019 11:51:58 +0800
Message-Id: <cover.1567740135.git.baolin.wang@linaro.org>
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

Thus this patch set will introduce the virtual command queue support,
and set the queue depth as 2, that means we do not need wait for previous
request is completed and can queue 2 requests in flight. It is enough to
let the irq handler always trigger the next request without a context
switch and then ask the blk_mq layer for the next one to get queued,
as well as avoiding a long latency.

Moreover we can expand the virtual command queue interface to support
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

1. Without virtual command queue
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

2. With virtual command queue
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

Form above data, we can see the virtual command queue can help to improve the
performance obviously.

Any comments are welcome. Thanks a lot.

Baolin Wang (4):
  mmc: host: cqhci: Move the struct cqhci_slot into header file
  mmc: Add virtual command queue support
  mmc: host: sdhci-sprd: Add virtual command queue support
  mmc: host: sdhci: Add virtual command queue support

 drivers/mmc/core/block.c      |   62 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   25 ++-
 drivers/mmc/host/Kconfig      |    9 ++
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/cqhci-virt.c |  346 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.c      |   10 --
 drivers/mmc/host/cqhci.h      |   45 +++++-
 drivers/mmc/host/sdhci-sprd.c |   16 ++
 drivers/mmc/host/sdhci.c      |    7 +-
 include/linux/mmc/host.h      |    1 +
 11 files changed, 512 insertions(+), 23 deletions(-)
 create mode 100644 drivers/mmc/host/cqhci-virt.c

-- 
1.7.9.5

