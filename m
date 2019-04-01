Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C982C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA5520880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDAQNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:13:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727190AbfDAQNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:13:22 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [10.3.19.207])
        by Forcepoint Email with ESMTP id 1B79FED198CD8D75EBAA;
        Tue,  2 Apr 2019 00:13:19 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 2 Apr 2019
 00:13:15 +0800
Date:   Mon, 1 Apr 2019 17:13:04 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-usp@googlegroups.com>
Subject: Re: Work on iio: stating: frequency: ad9832
Message-ID: <20190401171304.00005954@huawei.com>
In-Reply-To: <20190401142529.xgkqmndinctiro3l@smtp.gmail.com>
References: <20190401142529.xgkqmndinctiro3l@smtp.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 11:25:29 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hello,
> 
> I was looking for some work on staging: iio: ad9832 and made some
> observations while reading the driver.
> 
> Apparently it had no devicetree documentation so I tried to elaborate
> one. 
> It uses a platform_data variable to load external clock
> frequency (I tried to make it use linux's clock framework).
Good.

> Some device attributes don't seem to be standardized on
> Documentation/ABI/testing/sysfs-bus-iio and there's no specific ABI
> for ad9832 nearby nor at staging/iio/Documentation. So maybe those
> missing ABI could be documented.
Beware. It's an old driver, so it may be that we actually want to change
it's ABI rather than documenting what is there (I have haven't looked!)

> The device has to set some internal registers to operate correctly,
> AD9832_FREQXHM and AD9832_PHASEXH, would it be feasible to set iio
> chanels for this?

What are they?  If they correspond to output channels in some sensible
way then maybe...

> I couldn't understand why checkpatch.pl gave errors on IIO_DEV_ATTR_*
> macros. To me they seem to have no problem.
> Also it has that platform_data to be moved to include/linux/iio. Is
> there any special reason for it not being there already? Which are
> the criterions a platform_data need to satisfy to be put there?
A driver moving out of staging shouldn't have platform data. It needs
to be converted over to more modern mechanisms.   We don't have a problem
supporting platform data for devices that have old school device files
already in tree, but that shouldn't be the case for a driver in staging.

Hence we can clean it up and move forward with just DT bindings.
> 
> I'm sending a patchset with some things I've already done.
Cool. I'll look at those later in the week if no one beats me to them.

> 
> Is there something else that could be done in this device driver?
> Please, tell if I've forgotten something.

I'll take a look, but it may be a little while before I do.
Hopefully someone else gets there first!

Jonathan

> 
> Any advice is welcome.
> Thanks,
> 
> Marcelo


