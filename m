Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEBAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA922067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flTpeJ6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKRKnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:43:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36300 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfKRKnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:43:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so10210805pfd.3;
        Mon, 18 Nov 2019 02:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YFWPz4VjngB4WcWRhp+GayJ3egNUwl75kCWknKTrpjA=;
        b=flTpeJ6IGcAwrNK3w7KuN1nd1p+ugDvJ3J7ZfJEnJoSArZYNUQhnK1c26QNaJeo7M6
         CiPubxYAJ4b144lL2jnjsixdjYA8iAygwrv44/uSgQ9nDTa2isMj+ynecpesNobPcfqZ
         7Q7mg40I3jwqVgy6KOuRbt1kl+iCJtP9arpM8/uCob9f3lq3/ckgsvFCK5MxSf0xgF05
         bXTUdDKM63g8W2Q2vRV9FcoF9dBqhcqQu2yzhXbl5NQmJCOsvUfp+fOe/K3IfXn+18Yg
         A+gu9TnK2QzEb54lW33h4ayr7Nj024gAB1VyVnHQokndIsiwP1qcYNp5zzFb8/bzOsr1
         gXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YFWPz4VjngB4WcWRhp+GayJ3egNUwl75kCWknKTrpjA=;
        b=AEWLRXGMr/nhVDW+06OO5athqjhwjAg1noa/e9folGMrf3lmgwkc909zA+yiimw2iJ
         mY0NeSB3TCmgW2Yqv8cD49duI6T/eEEW1qdu7GeKr5Rs1uYURiwdh9kjWfPs6SGoNB5N
         LmA4FgMBSTiaLRk+AddHr3gZ0BElDt2BftAxpTiNbFJ+XgqNe3NrZr9LmWg26+gu5ItQ
         LTjzdA74jcswU9MjsD6GDln6EPVJ4ahOXu4GHKF6fH3Sl5WSLFqhXZTL1BLfVcWZiOh2
         ivswA2dFxU2w6FNOutQpsZhE7gIK6fF2uzF1+6zIPi59JBKJH1L+1ZwGAeuLWC6mxMXr
         VvGg==
X-Gm-Message-State: APjAAAXfVGQ7JTAAhhUG9EWbLTw95104dM/e1upRDFcX78fBAaixGGy7
        lRIWPzF9pVDS+yGIn7DgS5fKEDM2
X-Google-Smtp-Source: APXvYqzrsgek7IZ24FSghkwbtQSaPZGBn8nzVVo8Yado4MXmFT1FWzOTB+2KxvzKP5hMacx8uY8WRQ==
X-Received: by 2002:a63:b24:: with SMTP id 36mr18677014pgl.30.1574073819212;
        Mon, 18 Nov 2019 02:43:39 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c13sm19343905pfo.5.2019.11.18.02.43.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Nov 2019 02:43:38 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] Add MMC software queue support
Date:   Mon, 18 Nov 2019 18:43:18 +0800
Message-Id: <cover.1574073572.git.baolin.wang7@gmail.com>
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

Changes from v6:
 - Change the patch order and set host->always_defer_done = true for the
 Spreadtrum host driver.

Changes from v5:
 - Modify the condition of defering to complete request suggested by Adrian.

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
  mmc: host: sdhci: Add a variable to defer to complete requests if
    needed
  mmc: host: sdhci-sprd: Add software queue support

 drivers/mmc/core/block.c      |   61 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   33 +++-
 drivers/mmc/host/Kconfig      |    8 +
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/mmc_hsq.c    |  344 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmc_hsq.h    |   30 ++++
 drivers/mmc/host/sdhci-sprd.c |   28 ++++
 drivers/mmc/host/sdhci.c      |   14 +-
 drivers/mmc/host/sdhci.h      |    3 +
 include/linux/mmc/host.h      |    3 +
 11 files changed, 525 insertions(+), 13 deletions(-)
 create mode 100644 drivers/mmc/host/mmc_hsq.c
 create mode 100644 drivers/mmc/host/mmc_hsq.h

-- 
1.7.9.5

