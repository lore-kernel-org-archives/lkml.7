Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099FC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFF0222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbJ2K+Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfIZJnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:43:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37918 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfIZJnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:43:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id u28so1191742lfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yAXbi1kQL65EW9pnlFXhlULd5JRhvbLrJCWrVe1hoo=;
        b=gbJ2K+Ne2p+hO4PyjXqNtD3JczKjoTHX8OneizOzA9MyAK5gP40dLfLd4u/zg1vx20
         WIcSZ12sv/1+w0FWITvV6fe+N2kmDeI3v93ZW/qep1BFXcCIpMoKXgGj58XzPg9NW9HS
         rN4Vk+yMRB/ZUj9heBIn51Xjk3Hzd0Z8pe7FJsccPYA6BYMtjJF+AG7QmhZfmfBGLToL
         kIxCHEDJFtCjx8Epj1qwhW2squVrc6Zlx/rnYgZfrRt1R7eF6aJeGAUz7sr0Qxpu9n8K
         VCuUiOpiKrA17/qGffqEGcrcobZMmM7+WNRFYAIIg0NRZwTiQ0Afis2UTYCjFOjmTYGP
         a9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yAXbi1kQL65EW9pnlFXhlULd5JRhvbLrJCWrVe1hoo=;
        b=kHM2Ue1XhTy2mcofCF5lialeCNohA1C5WDFPobrED2YSHWOUSB0TBNFcDyxbLZ151B
         8UzaDJYoMIBN5TfRrw2riI/QHV+z8qfmTkVKGUwseiK/xwge7CnHikoWagCsW+qPNtLv
         7GTcam1R1Xs9X814A7CK4LC5xoZfNPLoa2uxOpUa51N8M26OW8HtsWMlqosGVUtbq9sm
         9DsEctT1Q2wi3CqwMcKrU7fCLq9Y2RzW1gHLJir7jKbihOBBUhZrzj3PQts7PM7oE+X1
         USZxSRJPNm7TQ+oiioAy3jyornZS2xHKqryUUrm9B37I8qAqCXxyE3WaHxv1qAly6fWA
         2yUQ==
X-Gm-Message-State: APjAAAVYI6lymXnW29TbwRf9jDqK2fdmMxb6Sz2VPPrICMdjqwqDErID
        pUU4W1996TOGP01p8524wymDTNcBvyIToy71H5r5KQ==
X-Google-Smtp-Source: APXvYqwINsxTd+wz0PkojUGo4Tn1d8LEgRIu3BnKISBmJx8BD/HqiPolw3uGVNUJY9tKqt9rMwcBCB1YJhLlr2fFQv4=
X-Received: by 2002:ac2:5983:: with SMTP id w3mr1543168lfn.121.1569491009569;
 Thu, 26 Sep 2019 02:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568864712.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1568864712.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 26 Sep 2019 17:43:17 +0800
Message-ID: <CAMz4kuKFYCcY_Wh4mntwoSNgk5=QQvkV7zC-RpAWgdJpM2-4HA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add MMC software queue support
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian and Ulf,

On Thu, 19 Sep 2019 at 13:59, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi All,
>
> Now the MMC read/write stack will always wait for previous request is
> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> or queue a work to complete request, that will bring context switching
> overhead, especially for high I/O per second rates, to affect the IO
> performance.
>
> Thus this patch set will introduce the MMC software command queue support
> based on command queue engine's interfaces, and set the queue depth as 2,
> that means we do not need wait for previous request is completed and can
> queue 2 requests in flight. It is enough to let the irq handler always
> trigger the next request without a context switch and then ask the blk_mq
> layer for the next one to get queued, as well as avoiding a long latency.
>
> Moreover we can expand the MMC software queue interface to support
> MMC packed request or packed command instead of adding new interfaces,
> according to previosus discussion.
>
> Below are some comparison data with fio tool. The fio command I used
> is like below with changing the '--rw' parameter and enabling the direct
> IO flag to measure the actual hardware transfer speed in 4K block size.
>
> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read
>
> My eMMC card working at HS400 Enhanced strobe mode:
> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
>
> 1. Without MMC software queue
> I tested 3 times for each case and output a average speed.
>
> 1) Sequential read:
> Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
> Average speed: 28.7MiB/s
>
> 2) Random read:
> Speed: 18.2MiB/s, 8.9MiB/s, 15.8MiB/s
> Average speed: 14.3MiB/s
>
> 3) Sequential write:
> Speed: 21.1MiB/s, 27.9MiB/s, 25MiB/s
> Average speed: 24.7MiB/s
>
> 4) Random write:
> Speed: 21.5MiB/s, 18.1MiB/s, 18.1MiB/s
> Average speed: 19.2MiB/s
>
> 2. With MMC software queue
> I tested 3 times for each case and output a average speed.
>
> 1) Sequential read:
> Speed: 44.1MiB/s, 42.3MiB/s, 44.4MiB/s
> Average speed: 43.6MiB/s
>
> 2) Random read:
> Speed: 30.6MiB/s, 30.9MiB/s, 30.5MiB/s
> Average speed: 30.6MiB/s
>
> 3) Sequential write:
> Speed: 44.1MiB/s, 45.9MiB/s, 44.2MiB/s
> Average speed: 44.7MiB/s
>
> 4) Random write:
> Speed: 45.1MiB/s, 43.3MiB/s, 42.4MiB/s
> Average speed: 43.6MiB/s
>
> Form above data, we can see the MMC software queue can help to improve the
> performance obviously.
>
> Any comments are welcome. Thanks a lot.
>
> Changes from v2:
>  - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
>  instead adding 'struct sqhci_host', which is only used by software queue.
>
> Changes from v1:
>  - Add request_done ops for sdhci_ops.
>  - Replace virtual command queue with software queue for functions and
>  variables.
>  - Rename the software queue file and add sqhci.h header file.

Do you have any comments for this patch set except the random config
building issue that will be fixed in the next version? Thanks.

>
> Baolin Wang (3):
>   mmc: Add MMC software queue support
>   mmc: host: sdhci: Add request_done ops for struct sdhci_ops
>   mmc: host: sdhci-sprd: Add software queue support
>
>  drivers/mmc/core/block.c      |   61 ++++++++
>  drivers/mmc/core/mmc.c        |   13 +-
>  drivers/mmc/core/queue.c      |   25 ++-
>  drivers/mmc/host/Kconfig      |    9 ++
>  drivers/mmc/host/Makefile     |    1 +
>  drivers/mmc/host/sdhci-sprd.c |   26 ++++
>  drivers/mmc/host/sdhci.c      |   12 +-
>  drivers/mmc/host/sdhci.h      |    2 +
>  drivers/mmc/host/sqhci.c      |  344 +++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sqhci.h      |   53 +++++++
>  include/linux/mmc/host.h      |    3 +
>  11 files changed, 537 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/mmc/host/sqhci.c
>  create mode 100644 drivers/mmc/host/sqhci.h
>
> --
> 1.7.9.5
>


-- 
Baolin Wang
Best Regards
