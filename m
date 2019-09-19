Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA17EC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A169D218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mx/H2l9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfISF7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:59:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43436 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbfISF7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:59:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id u72so1217111pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dgIbwimAQkKlSbgSJtp+/dbeJWRHJe81c9/KX+VIXkA=;
        b=Mx/H2l9leg+629kRjV3+tiwLwEZ6F/KyzkTl6eX6RY6pupN7Xff6M+EMKN3/umfHHv
         HmSV3r/hM3awiSBfYWeH90K1//aKCBjTFLn/gPz3lxOaDgNLBzpUK7wrxNcfXYErKz8g
         nsTJ0SR/Q/V4XtK45n45CopPBtRiqMp2T1I8kzCNJGshf/cpYzRdMy/eAkFwQ/z1C+W2
         1c5sezQKa7URE96MzFNDmVYH0xmRkV2wR+X+qwfHRkjdcZsILECVvf+Y26Kgw5UN3bEE
         Q8uN0RDphMiawxn+MfbqqNbCI4Qd5qRYk+AbiMWqRFzZoIRNffJosT82jbm6SqEb/lVW
         Li+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dgIbwimAQkKlSbgSJtp+/dbeJWRHJe81c9/KX+VIXkA=;
        b=Zt+pn2XHrFjiCBUgQsF2elIMMYvAQeLIvIe5zqqMqk1fgFc0Zl4+1kI5ZuWzPssq5I
         4umETM7EHTWJnr7JDogiiuwKRv9xKqh03Dk1c3u80EYVuWdfet/AjtBZPZILKrwB3beh
         3M8FwhCs+sm29CkY8ctLvbGp+/UVB5v9Fmyg7/KUpuOrbnRtsb4Dcg6GZp/TG6HBZDRE
         K8PAfZmReWEkuFNxeROig3tE714kTL1ncaYddYERL4HvA97EuutGMsbC6FKRxS4KhbOu
         JGG6yNI75ebqM01YUXXEjc36AYECjfGOYlhEAUCwWEIOC9GTHlIn1i/7A/4wCEKeynmT
         Sd1Q==
X-Gm-Message-State: APjAAAU+iH05z/y+NtvUrVW1ovj6VJTQS+8a59V+3B1q43fZjjexRjtM
        8KYA1nHGJ4igMb3GafjxdKyeTQ==
X-Google-Smtp-Source: APXvYqxU2SNk/ft+XHxPveItevSjUrywmPGWEbwcAe5zoy/dD14xqkRCRTvVutRSRRzgDKhfZ0fp7w==
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr7711967pgt.30.1568872745170;
        Wed, 18 Sep 2019 22:59:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c127sm9666027pfb.5.2019.09.18.22.59.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 22:59:03 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add MMC software queue support
Date:   Thu, 19 Sep 2019 13:58:44 +0800
Message-Id: <cover.1568864712.git.baolin.wang@linaro.org>
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

Changes from v2:
 - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
 instead adding 'struct sqhci_host', which is only used by software queue.

Changes from v1:
 - Add request_done ops for sdhci_ops.
 - Replace virtual command queue with software queue for functions and
 variables.
 - Rename the software queue file and add sqhci.h header file.

Baolin Wang (3):
  mmc: Add MMC software queue support
  mmc: host: sdhci: Add request_done ops for struct sdhci_ops
  mmc: host: sdhci-sprd: Add software queue support

 drivers/mmc/core/block.c      |   61 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   25 ++-
 drivers/mmc/host/Kconfig      |    9 ++
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/sdhci-sprd.c |   26 ++++
 drivers/mmc/host/sdhci.c      |   12 +-
 drivers/mmc/host/sdhci.h      |    2 +
 drivers/mmc/host/sqhci.c      |  344 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sqhci.h      |   53 +++++++
 include/linux/mmc/host.h      |    3 +
 11 files changed, 537 insertions(+), 12 deletions(-)
 create mode 100644 drivers/mmc/host/sqhci.c
 create mode 100644 drivers/mmc/host/sqhci.h

-- 
1.7.9.5

