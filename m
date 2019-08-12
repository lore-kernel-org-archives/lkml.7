Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD08DC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E03208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEerFixs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfHLJos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:44:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42275 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfHLJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:44:45 -0400
Received: by mail-ot1-f65.google.com with SMTP id j7so11756795ota.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emXyL+F/wH+sxcGpBQLqfGU1iXCvM/vOXIvgqLtgxVw=;
        b=CEerFixsNPVgu4xuOp6LvT5B0xdS4k5KLsyzpVfx39lh843gi/HnvK0KE7tgTPaO+t
         ALx9YKmBhJVROWOLV+aUTanVB4YKNKkdGVrLRNetC2f6QwZrdwaKHvRzdC4rkJzgKpVm
         bDGLSvkZ40MspeI71wmPX69UH7IMnR2nM5whHAajB8Cx0o6CRFYq4DKGlOV8UuU+9FED
         QrZu1vw9AJu1Z1diu0agKw1zGaR1b3oLslx/ErXOaI5+TfXrr97s7EQbq7oenKPVcaE1
         cZpr/n4Dk5M3cVnGRTyOhiUNNyY4O3uYxKUL7m4zVCXjfJmO4vbNjgdxTT2Gt9FDiUPi
         QwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emXyL+F/wH+sxcGpBQLqfGU1iXCvM/vOXIvgqLtgxVw=;
        b=jEv4xmVfYeeAd9eeAbPI3AwbLr5Iuf1mpg5WsjOz9keMk8xFQ7evCUSUYMKgJmxL2X
         8diCg1Ld5WAYHw0FG2J+e1EFdKQJMtLgfXMNT3Vr+fVjow2tbFxMXbazQeY4Gtp9O8+B
         0D/tJCt3KKRQusvgxd7wOfxL+KEful7yW/iyXiOIQuWXTulz1KMVRw1bisq8eMQqVY35
         FgZk0UoQ0/yIVEeYJaNaoOa0OL0xN6uk7MTb1xr6yif5cBV5DodIqu3KkxpRuWaj47zC
         FXAuNPVeERNdTf0dVehbh/I1v2h0vjF3fclAQngOD2QQ0VLSaFE3tU1qmDr5s7Cp7NH0
         s4Yg==
X-Gm-Message-State: APjAAAW6B1Ex0aPM1PMF39oz2r4VcCu0dV+APiGEdrLTx8EMC8chWQBR
        nEZXgIrOeF8bGPg0Ua+2z8y5an6NY6Gpwg+hwlLhtw==
X-Google-Smtp-Source: APXvYqwWOv/ymhTFLZiVDkMOSdWGJprk2GoYXetlvKNrzuA1w0diqLPVVDEIfu/+KUTqgspj9Rw2jp49mIcg6q9JnSY=
X-Received: by 2002:a9d:590d:: with SMTP id t13mr19125502oth.281.1565603084896;
 Mon, 12 Aug 2019 02:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563782844.git.baolin.wang@linaro.org> <CAMz4ku+NjcqLY0tWRxrBCRUnkpyWih42LYieKaf0FO6WsqO2vA@mail.gmail.com>
 <8abff7d6-0a3e-efe7-e8ec-9309fada9121@intel.com>
In-Reply-To: <8abff7d6-0a3e-efe7-e8ec-9309fada9121@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 12 Aug 2019 17:44:33 +0800
Message-ID: <CAMz4kuKri79CtVA=g7Mzoda_fQBYAEXDzL77RGw7g+e0F48jcw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Add MMC packed function
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, 12 Aug 2019 at 16:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 12/08/19 8:20 AM, Baolin Wang wrote:
> > Hi,
> >
> > On Mon, 22 Jul 2019 at 21:10, Baolin Wang <baolin.wang@linaro.org> wrote:
> >>
> >> Hi All,
> >>
> >> Now some SD/MMC controllers can support packed command or packed request,
> >> that means it can package multiple requests to host controller to be handled
> >> at one time, which can improve the I/O performence. Thus this patchset is
> >> used to add the MMC packed function to support packed request or packed
> >> command.
> >>
> >> In this patch set, I implemented the SD host ADMA3 transfer mode to support
> >> packed request. The ADMA3 transfer mode can process a multi-block data transfer
> >> by using a pair of command descriptor and ADMA2 descriptor. In future we can
> >> easily expand the MMC packed function to support packed command.
> >>
> >> Below are some comparison data between packed request and non-packed request
> >> with fio tool. The fio command I used is like below with changing the
> >> '--rw' parameter and enabling the direct IO flag to measure the actual hardware
> >> transfer speed.
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
> >> 1. Non-packed request
> >> I tested 3 times for each case and output a average speed.
> >>
> >> 1) Sequential read:
> >> Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
> >> Average speed: 28.7MiB/s
>
> This seems surprising low for a HS400ES card.  Do you know why that is?

I've set the clock to 400M, but it seems the hardware did not output
the corresponding clock. I will check my hardware.

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
> >> 2. Packed request
> >> In packed request mode, I set the host controller can package maximum 10
> >> requests at one time (Actually I can increase the package number), and I
> >> enabled read/write packed request mode. Also I tested 3 times for each
> >> case and output a average speed.
> >>
> >> 1) Sequential read:
> >> Speed: 165MiB/s, 167MiB/s, 164MiB/s
> >> Average speed: 165.3MiB/s
> >>
> >> 2) Random read:
> >> Speed: 147MiB/s, 141MiB/s, 144MiB/s
> >> Average speed: 144MiB/s
> >>
> >> 3) Sequential write:
> >> Speed: 87.8MiB/s, 89.1MiB/s, 90.0MiB/s
> >> Average speed: 89MiB/s
> >>
> >> 4) Random write:
> >> Speed: 90.9MiB/s, 89.8MiB/s, 90.4MiB/s
> >> Average speed: 90.4MiB/s
> >>
> >> Form above data, we can see the packed request can improve the performance greatly.
> >> Any comments are welcome. Thanks a lot.
> >
> > Any comments for this patch set? Thanks.
>
> Did you consider adapting the CQE interface?

I am not very familiar with CQE, since my controller did not support
it. But the MMC packed function had introduced some callbacks to help
for different controllers to do packed request, so I think it is easy
to adapt the CQE interface.

-- 
Baolin Wang
Best Regards
