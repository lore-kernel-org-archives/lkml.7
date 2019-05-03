Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C021C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16CD205ED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfECPMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:12:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36304 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:12:31 -0400
Received: by mail-io1-f68.google.com with SMTP id d19so5490686ioc.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 08:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CF8N/5bH9mP8p8WPGotj2YYJsVMv1K8SQ1f707Zbjo4=;
        b=q6h3Q/qlU4RGWy1QvhedS/gS/4vmXhQTlXA9f8gRqhjzQXF8CZi/dYBKy1B7MrcRbS
         aoLc2gj1ZsvZCIXDE/UyhsvO8Nifm2XCTqDvgCKFZy3oGNQARD1UPaFUcfbT4Z/c07K6
         wg8+Df0Xm2Kmyx8IdKvIB/ry5MVmiSr4nazF5iEn/xrnRDG1/6MSsypU98lbt0+L+8xx
         q/nnB9P3ow6rHOCSB+OqlxEWEOWsG2KQ+YEy0tkoSi9IS5O2YYS6QeXKqa2rataDcs6C
         Xix7EnJjo1SfexawCeQtC8/3bqr7jzHuwn8+G5GqU76WQtI3mbbdZCP4iKDpUtSiEBpd
         +BXA==
X-Gm-Message-State: APjAAAXWka00MLNcs/llO3xHJFfniVZhOZz7agMLvGxkVrJAGS5gS4X2
        3BvTvwc565TyUOCh3GMG75EX1Q==
X-Google-Smtp-Source: APXvYqxduEy9iQxHiPvJoUOmAmrO8KP2BfJTkDc6odSaqfbP3/DXE0HDtBDBOHp3TOSQDRv945R1BQ==
X-Received: by 2002:a6b:da0a:: with SMTP id x10mr1833611iob.90.1556896350152;
        Fri, 03 May 2019 08:12:30 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id k22sm873491iog.10.2019.05.03.08.12.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 08:12:29 -0700 (PDT)
Date:   Fri, 3 May 2019 09:12:24 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     djkurtz@chromium.org, hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Raul Rangel <rrangel@chromium.org>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Message-ID: <20190503151224.GA3650@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501175457.195855-1-rrangel@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 11:54:56AM -0600, Raul E Rangel wrote:
> I am running into a kernel panic. A task gets stuck for more than 120
> seconds. I keep seeing blkdev_close in the stack trace, so maybe I'm not
> calling something correctly?
> 
> Here is the panic: https://privatebin.net/?8ec48c1547d19975#dq/h189w5jmTlbMKKAwZjUr4bhm7Q2AgvGdRqc5BxAc=
> 
> I sometimes see the following:
> [  547.943974] udevd[144]: seq 2350 '/devices/pci0000:00/0000:00:14.7/mmc_host/mmc0/mmc0:0001/block/mmcblk0/mmcblk0p1' is taking a long time
> 
> I was getting the kernel panic on a 4.14 kernel: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f3dc032faf4d074f20ada437e2d081a28ac699da/drivers/mmc/host
> So I'm guessing I'm missing an upstream fix.
> 
So I tried these patches on the 5.1 with the memory leak patch applied:
https://patchwork.kernel.org/patch/10927541/

Everything works as expected:
    mmc0: new high speed SDHC card at address 0001
    mmcblk0: mmc0:0001 00000 7.41 GiB
     mmcblk0: p1 p2
    mmc0: card status changed during reset
    mmc0: card was removed during reset
    mmc0: tried to HW reset card, got error -123
    print_req_error: I/O error, dev mmcblk0, sector 2072 flags 80700
    print_req_error: I/O error, dev mmcblk0, sector 2073 flags 80700
    mmc0: card 0001 removed

    mmc0: new high speed SDHC card at address 0001
    mmcblk0: mmc0:0001 00000 7.41 GiB
     mmcblk0: p1 p2
    mmc0: card status changed during reset
    mmc0: card was removed during reset
    mmc0: tried to HW reset card, got error -123
    print_req_error: I/O error, dev mmcblk0, sector 12584832 flags 80700
    print_req_error: I/O error, dev mmcblk0, sector 12584833 flags 80700
    mmc0: card 0001 removed
    Buffer I/O error on dev mmcblk0p2, logical block 369904, async page read

    mmc0: new high speed SDHC card at address 0001
    mmcblk0: mmc0:0001 00000 7.41 GiB
     mmcblk0: p1 p2
    mmc0: card 0001 removed

I also ran another test. Using the DUT with a GPIO to randomly toggle the
CD pin I was able to get 4k+ iterations without any problems. So I think
the patches are good.

    --- Iteration 4506 ----
    Disconnecting card
    [ 7444.370169] mmc0: card 0001 removed
    Connecting Card and sleeping for 0.31476s
    [ 7444.682177] mmc0: new high speed SDHC card at address 0001
    [ 7444.719038] mmcblk0: mmc0:0001 00000 7.41 GiB
    [ 7444.727375]  mmcblk0: p1 p2
    Card Disconnected
    [ 7444.831896] mmc0: Card removed during transfer!
    [ 7444.831914] mmc0: Resetting controller.
    --- Iteration 4507 ----
    Connecting Card and sleeping for 0.30259s
    [ 7445.033649] mmc0: card 0001 removed
    Card Disconnected
    [ 7445.307008] mmc0: error -123 whilst initialising SD card
    --- Iteration 4508 ----
    Connecting Card and sleeping for 0.24827s
    Card Disconnected
    [ 7445.716033] mmc0: Card removed during transfer!
    [ 7445.716052] mmc0: Resetting controller.
    [ 7445.716489] mmc0: error -123 whilst initialising SD card
    --- Iteration 4509 ----
    Connecting Card and sleeping for 0.14132s
    Card Disconnected
    --- Iteration 4510 ----
    Connecting Card and sleeping for 0.26001s
    Card Disconnected
    [ 7446.436079] mmc0: error -123 whilst initialising SD card
    Connecting card to verify if it died
    [ 7446.906804] mmc0: new high speed SDHC card at address 0001
    [ 7446.933631] mmcblk0: mmc0:0001 00000 7.41 GiB
    [ 7446.949224]  mmcblk0: p1 p2
    SDHC still functional

Should I send the patches out again without the RFC tag?

I'll keep trying to track down the hung task I was seeing on 4.14. But I
don't think that's related to these patches. I might just end up
backporting the blk-mq patches to our 4.14 branch since I suspect that
fixes it.

Thanks,
Raul
