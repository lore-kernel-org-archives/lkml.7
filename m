Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5577CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3882146E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuQO63fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfHSBMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:12:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33682 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfHSBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 21:12:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id q10so139631oij.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 18:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ov1ZoZUrJZ+JTAyOesjjuMheROZh7OUlKOkkFfcWSmM=;
        b=PuQO63fcEHlAV3z+KIhb2fK+YHgCVOytT5BLCOUxEG+WOTv/m1l1EbREdhu7BTB1/e
         2lEugBzzYuQ3RARXhmLl7f0wR52+H+sJ+g6ykRpu9SKtlrG/49lqM/FN2UjOVUSY+7xe
         yceL8Pc+9u2iDyi1he/C9OV+VDuAq+pcjzjMRfl08R5bZHJmdoBfhlqjj+xmcEyulQzX
         IzufRym/SicpzSjl4M8Eazo9OzmJJhDWjdSWtvqNXzqydmU1uIom2IWmRScDBduYpfuo
         +Pl/O6yhmJiolgACWc1FrRVuxo03hRIzb9QB1+l2CyM3SDOPdAtkMJ70gL8hQHZGJ1qr
         N+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ov1ZoZUrJZ+JTAyOesjjuMheROZh7OUlKOkkFfcWSmM=;
        b=NUy2GMynkyPrCjt8NZ/xkPUBIuTz6ZCHXOoqLGCE2v38zrkKKsUcgEvxj95/lIaTAT
         BsfduVzQIyAlxAzX3nYea64Qy6mYQ6//f/88GfnpaF0/c78WoySm6akR4+dDurq40bGl
         W8bVKpenLZJLqp/lucMZKLs6KLjWQEo7Nc/p6uxZYhrIZ5NNdkPtrW/7QmUpEwFTBRiT
         2dvNzFGrDx3CdFOuE5gL6c2jyzv1GluGpxxNCtawzbN/I9XWENAeSO7pCKCE7SMeHTuS
         ZyUxqmiryr6N3iei6Hahbnq5XzOoUmgQMY2BvSREZb2GIk0wmepoP6Ao9IZOqyE2jzrA
         yqhg==
X-Gm-Message-State: APjAAAX9b2sGJ9Y3Ometiwkjf9kjN1kVT8SqmUDlzl8kXw7C/gl3dyzw
        u4jDm/RdTumuScO845OGJmXvKBvPhZeQGNlcyFvYaQ==
X-Google-Smtp-Source: APXvYqwxl7uQW9abq10zcmDLy6ySg2n3jMUJMx+nhGPCckStL47p9PBss4h2uQ1pOsifpVcVP2Fp+jRw01mcnP2OZVc=
X-Received: by 2002:aca:5b05:: with SMTP id p5mr2043065oib.6.1566177163319;
 Sun, 18 Aug 2019 18:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <1870ea18729f93fb36694affaf7e9443733dd988.1564035575.git.baolin.wang@linaro.org>
 <20190727182709.037fc595@archlinux> <CAMz4kuLLSYw0JRLRVN-JegxZcK1bdv4K2m4mVu7oep6xfb+xxg@mail.gmail.com>
 <20190805145037.0a03f21e@archlinux> <CAMz4kuK4GFfOi3vGvFOLdRfmqrwVLDs5CN+Xp_it3jG4=iKi=w@mail.gmail.com>
 <20190811090251.5fbd7d75@archlinux> <CAMz4ku+ansL1RJScmJRsvKR-dJVLNjAZqgTFqRSEJWQSYUy_Sg@mail.gmail.com>
 <20190818202704.69e95a4d@archlinux>
In-Reply-To: <20190818202704.69e95a4d@archlinux>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 19 Aug 2019 09:12:32 +0800
Message-ID: <CAMz4ku+k0c3EF5u-tJ6BBD2-78O7UwULzOmxjOs5u9bO_xBcFw@mail.gmail.com>
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

On Mon, 19 Aug 2019 at 03:27, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 12 Aug 2019 10:37:44 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
> > On Sun, 11 Aug 2019 at 16:03, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Tue, 6 Aug 2019 15:39:45 +0800
> > > Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > > Hi Jonathan,
> > > >
> > > > On Mon, 5 Aug 2019 at 21:50, Jonathan Cameron <jic23@kernel.org> wrote:
> > > > >
> > > > > On Mon, 29 Jul 2019 10:19:48 +0800
> > > > > Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > >
> > > > > > Hi Jonathan,
> > > > > >
> > > > > > On Sun, 28 Jul 2019 at 01:27, Jonathan Cameron <jic23@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, 25 Jul 2019 14:33:50 +0800
> > > > > > > Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > >
> > > > > > > > From: Freeman Liu <freeman.liu@unisoc.com>
> > > > > > > >
> > > > > > > > On Spreadtrum platform, the headphone will read one ADC channel multiple
> > > > > > > > times to identify the headphone type, and the headphone identification is
> > > > > > > > sensitive of the ADC reading time. And we found it will take longer time
> > > > > > > > to reading ADC data by using interrupt mode comparing with the polling
> > > > > > > > mode, thus we should change to polling mode to improve the efficiency
> > > > > > > > of reading data, which can identify the headphone type successfully.
> > > > > > > >
> > > > > > > > Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> > > > > > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > My concerns with this sort of approach is that we may be sacrificing power
> > > > > > > efficiency for some usecases to support one demanding one.
> > > > > > >
> > > > > > > The maximum sleep time is 1 second (I think) which is probably too long
> > > > > > > to poll a register for in general.
> > > > > >
> > > > > > 1 second is the timeout time, that means something wrong when reading
> > > > > > the data taking 1 second, and we will poll the register status every
> > > > > > 500 us.
> > > > > > From the testing, polling mode takes less time than interrupt mode
> > > > > > when reading ADC data multiple times, so polling mode did not
> > > > > > sacrifice power
> > > > > > efficiency.
> > > > >
> > > > > Hmm.  I'll go with a probably on that, depends on interrupt response
> > > > > latency etc so isn't entirely obvious.  Faster response doesn't necessarily
> > > > > mean lower power.
> > > > >
> > > > > >
> > > > > > > Is there some way we can bound that time and perhaps switch between
> > > > > > > interrupt and polling modes depending on how long we expect to wait?
> > > > > >
> > > > > > I do not think the interrupt mode is needed any more, since the ADC
> > > > > > reading is so fast enough usually. Thanks.
> > > > > The reason for interrupts in such devices is usually precisely the opposite.
> > > > >
> > > > > You do it because things are slow enough that you can go to sleep
> > > > > for a long time before the interrupt occurs.
> > > > >
> > > > > So question becomes whether there are circumstances in which we are
> > > > > running with long timescales and would benefit from using interrupts.
> > > >
> > > > From our testing, the ADC version time is usually about 100us, it will
> > > > be faster to get data if we poll every 50us in this case. But if we
> > > > change to use interrupt mode, it will take millisecond level time to
> > > > get data. That will cause problems for those time sensitive scenarios,
> > > > like headphone detection, that's the main reason we can not use
> > > > interrupt mode.
> > > >
> > > > For those non-time-sensitive scenarios, yes, I agree with you, the
> > > > interrupt mode will get a better power efficiency. But ADC driver can
> > > > not know what scenarios asked by consumers, so changing to polling
> > > > mode seems the easiest way to solve the problem, and we've applied
> > > > this patch in our downstream kernel for a while, we did not see any
> > > > other problem.
> > > >
> > > > Thanks for your comments.
> > >
> > > OK. It's not ideal but sometimes such is life ;)
> >
> > Thanks for your understanding :)
> >
> > >
> > > So last question - fix or not?  If a fix, can I have a fixes tag
> > > please.
> >
> > This is a bigger patch, I am afraid it can not be merged into stable
> > kernel, and original code can work at most scenarios. So I think no
> > need add stable tag for this patch. Thanks.
> >
> Fair enough.  Needed a bit of merge effort as crossed with a generic
> cleanup patch it seems.
>
> Anyhow, hopefully I got it right.

I checked you are right.

>
> Pushed out as testing for the autobuilders to play with it.

Thanks.

-- 
Baolin Wang
Best Regards
