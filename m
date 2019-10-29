Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745F9CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C2F20650
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvOHSokW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbfJ2FoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 01:44:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41222 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731904AbfJ2FoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:44:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id p26so4589386pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 22:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lciJKt3/MVKIj4ulDK5kkho2JlstyUhvmpM1PFt8rPE=;
        b=dvOHSokWoI5Nijdu3h6b+rN/jyf0YROWTdLLl2HmbYAW8l2l8EoMD5MYHoGU3X78YT
         lqi96O7J3hMSxwAW1G2MB+B5vP7SjTG7yOGAZI/osS2iUfZftRmfbw226OAu5Xf61/t0
         QdiOfv2OxhQK/G+haC0ZszdPect+xsfkndWBrfp389Omkc7Ra3reXxCMYvwnU1T/hoMe
         JThhajwhWg7u58HrUZAlAPCoP6AO7+L8cOz/vPX5rwG1czjPHOq5bY1A24lGj+li997u
         To8a6YhRVRQ50pWiYex6vZ/sy13nt/HASw6TVJBtbC2Ii8GPjTsUKmcP5xfEHIjBTj92
         Kfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lciJKt3/MVKIj4ulDK5kkho2JlstyUhvmpM1PFt8rPE=;
        b=BYGvDkhp/QfIdpml7Rz5yfOahgliddrv0aXDfL3j+6WGf2TZjNKstqmX/ZiqCGd10J
         81odFTBQiAUXxaYmALmh+jGnnF3t9XnmyeOBN4nqoudw9dbtqppt2V5W/sxzVkAH9lNA
         yQLv7Mm6nVUgxBRRMaiz1RebqQ+JF0GamPNlpBIPzImkhDczWcMGIjN6p3EfcDwMyA3o
         04WPIci1YCc9gVxySmdtBAxeZ9snCCQ5sZZGiROQzG5njQ1KqRIb1nGcZrS8nn/384ku
         /GaOIJazNewLis2n5+yYrfH/o9oDUr+EuKVFq7ikxO8EPzZsxznxGDtsvuXiqaxl2Y4H
         YaGg==
X-Gm-Message-State: APjAAAUWurzwCL537ocIdQ4c+K3yeuzyElNI0O0kyQyjQePJkKGMnPzU
        yPK9TTNsJEuVEQFBMsW34pJVsQ==
X-Google-Smtp-Source: APXvYqxD8BMX0z0y9VjQak6wiyEZTR91LyleajY9XVvsSDV5MAZz5tS+biXlQDeDbn8QQYxxyk1udw==
X-Received: by 2002:a63:4a48:: with SMTP id j8mr11216609pgl.221.1572327851380;
        Mon, 28 Oct 2019 22:44:11 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm12026231pfi.113.2019.10.28.22.44.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 22:44:09 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Add MMC software queue support
Date:   Tue, 29 Oct 2019 13:43:18 +0800
Message-Id: <cover.1572326519.git.baolin.wang@linaro.org>
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
based on command queue engine's interfaces, and set the queue depth as 32
to allow more requests can be be prepared, merged and inserted into IO
scheduler, but we only allow 2 requests in flight, that is enough to let
the irq handler always trigger the next request without a context switch,
as well as avoiding a long latency.

Moreover we can expand the MMC software queue interface to support
MMC packed request or packed command instead of adding new interfaces,
according to previosus discussion.

Below are some comparison data with fio tool. The fio command I used
is like below with changing the '--rw' parameter and enabling the direct
IO flag to measure the actual hardware transfer speed in 4K block size.

./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=1G --group_reporting --numjobs=20 --name=test_read

My eMMC card working at HS400 Enhanced strobe mode:
[    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB 
[    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
[    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
[    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)

1. Without MMC software queue
I tested 5 times for each case and output a average speed.

1) Sequential read:
Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
Average speed: 59.66MiB/s

2) Random read:
Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
Average speed: 27.04MiB/s

3) Sequential write:
Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
Average speed: 69.68MiB/s

4) Random write:
Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
Average speed: 35.96MiB/s

2. With MMC software queue
I tested 5 times for each case and output a average speed.

1) Sequential read:
Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
Average speed: 60.68MiB/s

2) Random read:
Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
Average speed: 31.36MiB/s

3) Sequential write:
Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
Average speed: 71.66MiB/s

4) Random write:
Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
Average speed: 68.76MiB/s

Form above data, we can see the MMC software queue can help to improve some
performance obviously for random read and write, though no obvious improvement
for sequential read and write.

Any comments are welcome. Thanks a lot.

Changes from v4:
 - Add a seperate patch to introduce a variable to defer to complete
 data requests for some host drivers, when using host software queue.

Changes from v3:
 - Use host software queue instead of sqhci.
 - Fix random config building issue.
 - Change queue depth to 32, but still only allow 2 requests in flight.
 - Update the testing data.

Changes from v2:
 - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
 instead adding 'struct sqhci_host', which is only used by software queue.

Changes from v1:
 - Add request_done ops for sdhci_ops.
 - Replace virtual command queue with software queue for functions and
 variables.
 - Rename the software queue file and add sqhci.h header file.

Baolin Wang (4):
  mmc: Add MMC host software queue support
  mmc: host: sdhci: Add request_done ops for struct sdhci_ops
  mmc: host: sdhci-sprd: Add software queue support
  mmc: host: sdhci: Add a variable to defer to complete data requests
    if needed

 drivers/mmc/core/block.c      |   61 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   33 +++-
 drivers/mmc/host/Kconfig      |    8 +
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/mmc_hsq.c    |  344 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmc_hsq.h    |   30 ++++
 drivers/mmc/host/sdhci-sprd.c |   26 ++++
 drivers/mmc/host/sdhci.c      |   14 +-
 drivers/mmc/host/sdhci.h      |    3 +
 include/linux/mmc/host.h      |    3 +
 11 files changed, 523 insertions(+), 13 deletions(-)
 create mode 100644 drivers/mmc/host/mmc_hsq.c
 create mode 100644 drivers/mmc/host/mmc_hsq.h

-- 
1.7.9.5

