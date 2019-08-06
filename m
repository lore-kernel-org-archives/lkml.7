Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3489AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACD320B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gstrFwaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfHFHj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:39:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34552 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFHj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:39:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so90271724otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 00:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIZEerWqkr3qP4GjJoYs3qISFZdQGgzjOqxk6I3KMeU=;
        b=gstrFwaNmRcqW1esc/wFUaKf0bDVNM6DzjH2sCuYPctxXt2d7aoWkv713NojGJEX+9
         kK7eBc9XhVGFl7P2zAnoPEVGCFDNOdv2IS7rCR/5C8OBN2QP2IyCsXhSrvPZGGzIXwRD
         Fm0Bj+3CPwSw+sp/jMR8J308iNm85eb60s2/VubFTHn+6IHIXt0T0baSthIfKo+ubX9o
         Sfy3/WKp1V38zcPuzHW8VTdEy5R0tML/L4z0KwmP2XOFNtiRMa5wVrQ7Pdn3zBah+Njj
         birdnRYUN5AxqkHupAD7YE253FjJTogLRkcdsCeXQ/ZeoDAelAprqogTCvXNcAgf8SMs
         BaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIZEerWqkr3qP4GjJoYs3qISFZdQGgzjOqxk6I3KMeU=;
        b=FC2P5JrP2pKz/gwckNLY9LTjsOT0g38EhPlcQvMTzPMGpttJaw1Ynv/a+lNCwnlKVi
         FdQ7IbwMB2bpGjoxedugSSJSVPqbxFazkMnSnrHHgkdeycxs7BbiKSetUOzQA8q3l2gr
         TizDed9AmmN8OLrSFFn58MQcKJz3jLJrpUqz9f/zkaxQAM/QDHqn5eFKFB44QaZsAPkT
         /M7zqUYZY9e7QFoE0AXr9JR3+y783Wc+jIUsbdLL1SY6BBQNIfLEsPoxjHaI2AjwNpwA
         YuK6K/Egn1D+tG8e49dXypWq1H5occhXkAmOCLmdcwA58591I9fRETjlBzXy2LOXCbUb
         yuJw==
X-Gm-Message-State: APjAAAVwNvj5g3jDV+f24KRO85SExgebB5wTcjIqkPlfhEqdZBng1+bc
        IOxhB8RQtVynPIwcLqlRIFDyjs+VHioJKYXJ4XBEXg==
X-Google-Smtp-Source: APXvYqyV2qPn+A7HJOH/Tr5TclR9N20jVLWbCl1u7l8zu9WJl+qjvblTgBP+1uMO0BtNrkCyz3d3/BVZCAXhfLgSWrE=
X-Received: by 2002:a9d:1718:: with SMTP id i24mr1707633ota.269.1565077196930;
 Tue, 06 Aug 2019 00:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <1870ea18729f93fb36694affaf7e9443733dd988.1564035575.git.baolin.wang@linaro.org>
 <20190727182709.037fc595@archlinux> <CAMz4kuLLSYw0JRLRVN-JegxZcK1bdv4K2m4mVu7oep6xfb+xxg@mail.gmail.com>
 <20190805145037.0a03f21e@archlinux>
In-Reply-To: <20190805145037.0a03f21e@archlinux>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 6 Aug 2019 15:39:45 +0800
Message-ID: <CAMz4kuK4GFfOi3vGvFOLdRfmqrwVLDs5CN+Xp_it3jG4=iKi=w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: sc27xx: Change to polling mode to read data
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@unisoc.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Mon, 5 Aug 2019 at 21:50, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 29 Jul 2019 10:19:48 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
> > Hi Jonathan,
> >
> > On Sun, 28 Jul 2019 at 01:27, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Thu, 25 Jul 2019 14:33:50 +0800
> > > Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > > From: Freeman Liu <freeman.liu@unisoc.com>
> > > >
> > > > On Spreadtrum platform, the headphone will read one ADC channel multiple
> > > > times to identify the headphone type, and the headphone identification is
> > > > sensitive of the ADC reading time. And we found it will take longer time
> > > > to reading ADC data by using interrupt mode comparing with the polling
> > > > mode, thus we should change to polling mode to improve the efficiency
> > > > of reading data, which can identify the headphone type successfully.
> > > >
> > > > Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > >
> > > Hi,
> > >
> > > My concerns with this sort of approach is that we may be sacrificing power
> > > efficiency for some usecases to support one demanding one.
> > >
> > > The maximum sleep time is 1 second (I think) which is probably too long
> > > to poll a register for in general.
> >
> > 1 second is the timeout time, that means something wrong when reading
> > the data taking 1 second, and we will poll the register status every
> > 500 us.
> > From the testing, polling mode takes less time than interrupt mode
> > when reading ADC data multiple times, so polling mode did not
> > sacrifice power
> > efficiency.
>
> Hmm.  I'll go with a probably on that, depends on interrupt response
> latency etc so isn't entirely obvious.  Faster response doesn't necessarily
> mean lower power.
>
> >
> > > Is there some way we can bound that time and perhaps switch between
> > > interrupt and polling modes depending on how long we expect to wait?
> >
> > I do not think the interrupt mode is needed any more, since the ADC
> > reading is so fast enough usually. Thanks.
> The reason for interrupts in such devices is usually precisely the opposite.
>
> You do it because things are slow enough that you can go to sleep
> for a long time before the interrupt occurs.
>
> So question becomes whether there are circumstances in which we are
> running with long timescales and would benefit from using interrupts.

From our testing, the ADC version time is usually about 100us, it will
be faster to get data if we poll every 50us in this case. But if we
change to use interrupt mode, it will take millisecond level time to
get data. That will cause problems for those time sensitive scenarios,
like headphone detection, that's the main reason we can not use
interrupt mode.

For those non-time-sensitive scenarios, yes, I agree with you, the
interrupt mode will get a better power efficiency. But ADC driver can
not know what scenarios asked by consumers, so changing to polling
mode seems the easiest way to solve the problem, and we've applied
this patch in our downstream kernel for a while, we did not see any
other problem.

Thanks for your comments.

-- 
Baolin Wang
Best Regards
