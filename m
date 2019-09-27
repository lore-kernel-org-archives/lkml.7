Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BEFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5C8217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbx4msmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfI0JdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:33:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40854 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0JdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:33:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so1816775ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBKBSoCXyPsaFcR3Bk4+exS1wpAq9IzVjY6FOFa5Qus=;
        b=rbx4msmhxYJrSCYeNkekKBwHoxx5KbgI9AAebr77wDShVXeXn9yKVTm5T+zxZQtib/
         preBoc0nFg9dtEimugwYKTuM+TJP7koWNzuUqtUApTY2zAqPYPOHhE7WC9EZomYOkVE6
         pM9qNFLCvNMj4fkvSFkm+6L3luXxl0XI4LRmq5nxwqnv9RjCNTi5FJQ10Rt3NlYtSCrn
         4J06yKorKbpOuKUcVXNU2yamj9bU3/GF9ar2lh8wxUAgmwJa+lrowGvxi6xmBfIT/De6
         GHgzJwjvnWmbDOPb6pyObvfrBTOmCdDhfSu3CyPIyxO1Jw94U4N8kM8RKbYYHjnavDNg
         V/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBKBSoCXyPsaFcR3Bk4+exS1wpAq9IzVjY6FOFa5Qus=;
        b=Mvt12vH1sdz5fKH38Ngy67vsmZ2DckISaQDXRMj+HCCxS+iDqNcEkpDPyu12OniQr7
         mdlrUsjjAzvjQVQsnPF04+7HheBDS/diqfgnyKgUIpX2XuK7mRXAxCy2Ro3kqCMb1Pjr
         0kNPigI1lyLDvwB7QfRDS8SlAhcYXy/RRzwa8Mk7dyJHI2HAcZBEL1EGEguoZx8B9ZAt
         gu8GfWFIH8wDouAAn6o8vb5u1XrCCxVgTJjfKz4IDm5skcK8+qFOOd0lucdJ5AuZXyjo
         7Z/r2o9VB91EAX9vu3PWGad24XJcGiMUt78Zo67tIsJ5OaYpoVESWjp30S1bnbL4v9FD
         WIPg==
X-Gm-Message-State: APjAAAUF01cvdTviQrFTfGWjfSxu4ESsUFYgB03/uW4nFkh5yZulgaSU
        sj8peHFTNTgPrBQZ9m0dOXHJzc1/LSZ6vjorP5GiUw==
X-Google-Smtp-Source: APXvYqy7L+6YwETGDEt884ftynzvaDxKyXbsDYw6nDNqTSb7EWD9E/kQch7+pjdA05qvNdug0nMMAelxl/qkUUtJN5g=
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr2032854ljj.18.1569576795305;
 Fri, 27 Sep 2019 02:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568864712.git.baolin.wang@linaro.org> <CAMz4kuKFYCcY_Wh4mntwoSNgk5=QQvkV7zC-RpAWgdJpM2-4HA@mail.gmail.com>
 <f6f147df-510b-f1ec-0745-a9c7eed67b84@intel.com>
In-Reply-To: <f6f147df-510b-f1ec-0745-a9c7eed67b84@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 27 Sep 2019 17:33:03 +0800
Message-ID: <CAMz4kuLGUybpYfESCerYo3DuzhK+WjjbuZ7XwCyeh=S7vxBh9A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add MMC software queue support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
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

On Thu, 26 Sep 2019 at 20:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 26/09/19 12:43 PM, Baolin Wang wrote:
> > Hi Adrian and Ulf,
> >
> > On Thu, 19 Sep 2019 at 13:59, Baolin Wang <baolin.wang@linaro.org> wrote:
> >>
> >> Hi All,
> >>
> >> Now the MMC read/write stack will always wait for previous request is
> >> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> >> or queue a work to complete request, that will bring context switching
> >> overhead, especially for high I/O per second rates, to affect the IO
> >> performance.
> >>
> >> Thus this patch set will introduce the MMC software command queue support
> >> based on command queue engine's interfaces, and set the queue depth as 2,
> >> that means we do not need wait for previous request is completed and can
> >> queue 2 requests in flight. It is enough to let the irq handler always
> >> trigger the next request without a context switch and then ask the blk_mq
> >> layer for the next one to get queued, as well as avoiding a long latency.
> >>
> >> Moreover we can expand the MMC software queue interface to support
> >> MMC packed request or packed command instead of adding new interfaces,
> >> according to previosus discussion.
> >>
> >> Below are some comparison data with fio tool. The fio command I used
> >> is like below with changing the '--rw' parameter and enabling the direct
> >> IO flag to measure the actual hardware transfer speed in 4K block size.
> >>
> >> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read
> >>
> >> My eMMC card working at HS400 Enhanced strobe mode:
> >> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> >> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> >> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> >> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> >> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
> >>
> >> 1. Without MMC software queue
> >> I tested 3 times for each case and output a average speed.
> >>
> >> 1) Sequential read:
> >> Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
> >> Average speed: 28.7MiB/s
> >>
> >> 2) Random read:
> >> Speed: 18.2MiB/s, 8.9MiB/s, 15.8MiB/s
> >> Average speed: 14.3MiB/s
> >>
> >> 3) Sequential write:
> >> Speed: 21.1MiB/s, 27.9MiB/s, 25MiB/s
> >> Average speed: 24.7MiB/s
> >>
> >> 4) Random write:
> >> Speed: 21.5MiB/s, 18.1MiB/s, 18.1MiB/s
> >> Average speed: 19.2MiB/s
> >>
> >> 2. With MMC software queue
> >> I tested 3 times for each case and output a average speed.
> >>
> >> 1) Sequential read:
> >> Speed: 44.1MiB/s, 42.3MiB/s, 44.4MiB/s
> >> Average speed: 43.6MiB/s
> >>
> >> 2) Random read:
> >> Speed: 30.6MiB/s, 30.9MiB/s, 30.5MiB/s
> >> Average speed: 30.6MiB/s
> >>
> >> 3) Sequential write:
> >> Speed: 44.1MiB/s, 45.9MiB/s, 44.2MiB/s
> >> Average speed: 44.7MiB/s
> >>
> >> 4) Random write:
> >> Speed: 45.1MiB/s, 43.3MiB/s, 42.4MiB/s
> >> Average speed: 43.6MiB/s
> >>
> >> Form above data, we can see the MMC software queue can help to improve the
> >> performance obviously.
> >>
> >> Any comments are welcome. Thanks a lot.
> >>
> >> Changes from v2:
> >>  - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
> >>  instead adding 'struct sqhci_host', which is only used by software queue.
> >>
> >> Changes from v1:
> >>  - Add request_done ops for sdhci_ops.
> >>  - Replace virtual command queue with software queue for functions and
> >>  variables.
> >>  - Rename the software queue file and add sqhci.h header file.
> >
> > Do you have any comments for this patch set except the random config
> > building issue that will be fixed in the next version? Thanks.
>
> Pedantically, swhci is not a host controller interface, so the name still
> seems inappropriate. Otherwise I haven't had time to look at it, sorry.

OK. I will talk with Ulf to think about a good name. Thanks.

-- 
Baolin Wang
Best Regards
