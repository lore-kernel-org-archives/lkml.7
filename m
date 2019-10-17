Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A5ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9165E21848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cZ4QO9rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503423AbfJQTO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:14:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43417 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfJQTO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:14:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so3596441wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 12:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvGIqAYge04E8FhX6sBpxVjaOFRt097ptSHTXXfneKk=;
        b=cZ4QO9rlkFXmbsu9Pg73hXjoos4HnGGzGTdFGgn+xOCCdXRtpg7LeIGvGwTIoMw9ir
         yPYX4zU3b+IOKDprgcX3V8YeiNv30hdK6FHrTtEblw/9jIvucazynts8Sm3w3iojII4f
         jcj12a7NBzmuMuqo3yHpRCONapbJ1WK8dRrAyKAdayuMMu+7uJUkazi4jizlRLHW0irZ
         3h6WKcrxwBzmFh8TNXtOB5l2toN2kdgDknHB4W0h+kSyemLc3smo+gaf4+lOHEdJm0ue
         dHoM6ia55QGIvtmY/fZIOYCG4C4mXDGng8Ii+Q9ffHwREpGZqO4j2bk6AYo+krBvd/hk
         +2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvGIqAYge04E8FhX6sBpxVjaOFRt097ptSHTXXfneKk=;
        b=gx5oBjbBSF24XOmGZMx/bVIFz/OYY+zuGJTBVLOXkmAlyCaPmOX0L9CvKg8yLPH6n5
         kam+kheA/B/6RMjWDNlm785k8QRsDjjZ2ROYMVbN4fzJKmTS8UkolK7CFswPZQWTOiwa
         dVH23vHn/8M+3p2benEK2UcTd04QHKWpAFitFox46/NCwqOcLVoIVFfxX8CFlGVUM/n3
         +Fk67wortXyZ04asB3FgZvWHzeNjpu9JKr5xEbG572RLtoEgStoB2+WdUlOzYc//xLo7
         dYB9uCburB4rf8OY7NLtRXnWoPVhibWmThs6ru1ltjffF/PMclowmV2r5tuEQgV2xi1L
         wlWw==
X-Gm-Message-State: APjAAAWnrTvuuhmSvgXidBp31FIdFdEqydH5m7tdCYWdtB0XqJMJRzi+
        9M8RtHsRrjZXC1McbEydkeQbWt/8ByQGaEuSMbUxSA==
X-Google-Smtp-Source: APXvYqzFbMnUb/1t8V7j8o3XbJVHjhBH3R49CMB7RWahl1YDxZElbr2au0kf7JnoH8msqWOMy4ukXdU7uCeiYlCR/l4=
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr1030503wrx.105.1571339666625;
 Thu, 17 Oct 2019 12:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com> <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
In-Reply-To: <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 17 Oct 2019 12:14:14 -0700
Message-ID: <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Pratik Patel <pratikp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:41 AM Andrew F. Davis <afd@ti.com> wrote:
> On 10/14/19 5:07 AM, Brian Starkey wrote:
> > Hi Andrew,
> >
> > On Wed, Oct 09, 2019 at 02:27:15PM -0400, Andrew F. Davis wrote:
> >> The CMA driver that registers these nodes will have to be expanded to
> >> export them using this framework as needed. We do something similar to
> >> export SRAM nodes:
> >>
> >> https://lkml.org/lkml/2019/3/21/575
> >>
> >> Unlike the system/default-cma driver which can be centralized in the
> >> tree, these extra exporters will probably live out in other subsystems
> >> and so are added in later steps.
> >>
> >> Andrew
> >
> > I was under the impression that the "cma_for_each_area" loop in patch
> > 4 would do that (add_cma_heaps). Is it not the case?
> >
>
> For these cma nodes yes, I thought you meant reserved memory areas in
> general.

Ok, sorry I didn't see this earlier, not only was I still dropped from
the To list, but the copy I got from dri-devel ended up marked as
spam.

> Just as a side note, I'm not a huge fan of the cma_for_each_area() to
> begin with, it seems a bit out of place when they could be selectively
> added as heaps as needed. Not sure how that will work with cma nodes
> specifically assigned to devices, seems like we could just steal their
> memory space from userspace with this..

So this would be a concern with ION as well, since it does the same
thing because being able to allocate from multiple CMA heaps for
device specific purpose is really useful.
And at least with dmabuf heaps each heap can be given its own
permissions so there's less likelihood for any abuse as you describe.

And it also allows various device cma nodes to still be allocated from
using the same interface (rather then having to use a custom driver
ioctl for each device).

But if the objection stands, do you have a proposal for an alternative
way to enumerate a subset of CMA heaps?

thanks
-john
