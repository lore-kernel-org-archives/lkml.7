Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B690C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C82206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wK9nb2xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKKHfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:35:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38070 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfKKHfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:35:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id c13so10100884pfp.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 23:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N0j02+Va0C16JEjBX5OE+cbOU9+TiW36MdYFngXdC6E=;
        b=wK9nb2xCvMLxbclKU1/3bng7vqnyYGI39pi7noeOmitJLWFV3vf1TzIqiW3IkS6VjN
         l/fdKaozziBjweBF4rZIf3akH6U91D6T/qqqXFRpCJAbpb6h7RGyPcVnbeK25O5rizFj
         ss+yHVduSxWqUl07HJi3QfpQRqi9qk9Q1oA+chao2s2taV7z1pDLVxQUvyYdB1zoH7/X
         6e6SqVEgmWsj8j0DqKKrEsxPpU2M+To/Mm5TkEqdF91e4s4AWKA9omlx0rfxjsXG7wLX
         uGuDzr5iepjE5w6RFrFrqEg2kav9shazpWxLiQE3SLfDZySnfBJtq6820Ih4oVnmPjRN
         bl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N0j02+Va0C16JEjBX5OE+cbOU9+TiW36MdYFngXdC6E=;
        b=Su4bLjPRsrQ3SJIMc0zL/yW++4soXWaIS4vDUfuHt2hqIvrH3kbbnJkL+Gf6m+Cbxp
         KlrSMw53yg9HR6h7IFs+x5CN/SbY3j0emU/TYQaU8HKkJOdqfvFiTPjRM9AXHWf8mG3t
         QQBo0rMou+fHPy3g+dvSzHMWeGaVMbM43/74dYL1+oXkakIh+Ua4i28tIn++8P87zZPD
         T8Pz3I/YI3M5wUSu1m/aR4yQbvY414coMrXhEU48UY0x1YoxnbmMWuUdCBTJ8RZ9mqHO
         5w3hLkT/N/iBMl8VqLRSkYmhFLgRaLoMFSZiEmCHQgmb0HHA2s8V3zw5Pry8G+WMZq7R
         YbgQ==
X-Gm-Message-State: APjAAAXle8kqfiQQ6NmCrvNPCfN7Qh7cYQsdLanHkigGQxNquSMpGeCp
        JqoG6eeEPRLXral0ewHyFt93qQ==
X-Google-Smtp-Source: APXvYqz6JzHETVqcxJkOK0cNO/1faSYI41RKw6t3aOIHZMW3LYPFXKa6lvWRXvpq76/2isGS66q+Hw==
X-Received: by 2002:a62:e811:: with SMTP id c17mr27878536pfi.136.1573457710798;
        Sun, 10 Nov 2019 23:35:10 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c184sm17345285pfc.159.2019.11.10.23.35.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Nov 2019 23:35:09 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] Add MMC software queue support
Date:   Mon, 11 Nov 2019 15:33:56 +0800
Message-Id: <cover.1573456283.git.baolin.wang@linaro.org>
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

Hi Ulf,

This patch set was pending for a while, and I've tested it several times and
have not found any recessions. Hope this patch set can be merged into v5.5
if no objection from you, since I still have some patches introducing the
packed request depend on the mmc software queue as we talked before.
Thanks a lot.

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
  mmc: host: sdhci-sprd: Add software queue support
  mmc: host: sdhci: Add a variable to defer to complete requests if
    needed

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

