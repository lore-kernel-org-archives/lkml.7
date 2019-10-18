Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EADCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C0A20869
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVDJqeiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394352AbfJRSd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:33:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33624 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394205AbfJRSd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:33:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so7288468wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTy5f2+zY9spxEP1tzucC058EkWg/q4aswm6QPb2oF8=;
        b=WVDJqeiQYZtH8hMM+aXz0b4B3qmg0/C8GHS3Y81PPaEmhwXFfwl8SfTtRMuZjNubb3
         m6cCeKKkHeqwn71IIO50qf6q1obwl93SEh+GpPs2FwyRrwjFwcG0SPatLwlF4sG0kj1p
         p/P3HfZljB3iekyAnxJMgLM1qQn+o/fugsMezmvSABMaXwIvODfjs4CcbV1xZSPMxozD
         kf6sap/+C7IRy8scXVPNTohcP7Q5TzcpK7vB58dH+0UYVfnUgVHJzwRKty3rAWSGli30
         xLz5Cy3sY/fOI9EzzW0AYr/VZHjGWGtvVC+3dBORbo5/s9U9RGnSFEXXk4kI8XdMnxlb
         UTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTy5f2+zY9spxEP1tzucC058EkWg/q4aswm6QPb2oF8=;
        b=d9IugJYYWGKmU0/MojKFWO/dTPuRfkb3LdxRxGP/7pROSSJFGrp9WmixEj9NbrCJgz
         rjRprqlkDhHrrvNZXbviU8N1wgKqa/h9sfRNI3kV1COgrj+jV5HHJKFFGmw3orxfGQkX
         rlh8hTh/E2+xlUQ9Vo1nPVbEzofILQTCoaCj/tPnTrQthCNixZVZuFEn+RgH4pMf2nU+
         CVrm6Kbbs5tCB+anFpww+na5q2kUcS682eduuN4WwxKt7yJASU4uAlZyg1MbGV+l9LZt
         kE/1ocDU8xIfDpab5Z0qUqmEOBK+CQiHZonDy6alqItAhkPfzDyUHFC5hkdvr20I+Nvv
         uuVQ==
X-Gm-Message-State: APjAAAXg5GTbnftFaxM0Hi6X1qDv+qdmBdVYLp0l6Z4adR7m4dH9V7Nj
        dfC0+RzPdSfUwdC172Rk2usC5rmqXau3kzEtr4b1ow==
X-Google-Smtp-Source: APXvYqwgIWYJJDAiGtxfixr8mMv75c1FwoNJKCZXJXp4Ve9GiF2P8nizw0jQz33xCf4hgFZlBAN+LuklCLockt8bYo4=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr9356659wrr.50.1571423604842;
 Fri, 18 Oct 2019 11:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com> <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com> <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com> <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
 <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 18 Oct 2019 11:33:13 -0700
Message-ID: <CALAqxLWpjgoj5Zni=FCnTWwR6JyCAjY=W6gQvjCG8aLQvGavXQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, nd <nd@arm.com>,
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

On Fri, Oct 18, 2019 at 2:55 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
> On Thu, Oct 17, 2019 at 01:57:45PM -0700, John Stultz wrote:
> > On Thu, Oct 17, 2019 at 12:29 PM Andrew F. Davis <afd@ti.com> wrote:
> > > On 10/17/19 3:14 PM, John Stultz wrote:
> > > > But if the objection stands, do you have a proposal for an alternative
> > > > way to enumerate a subset of CMA heaps?
> > > >
> > > When in staging ION had to reach into the CMA framework as the other
> > > direction would not be allowed, so cma_for_each_area() was added. If
> > > DMA-BUF heaps is not in staging then we can do the opposite, and have
> > > the CMA framework register heaps itself using our framework. That way
> > > the CMA system could decide what areas to export or not (maybe based on
> > > a DT property or similar).
> >
> > Ok. Though the CMA core doesn't have much sense of DT details either,
> > so it would probably have to be done in the reserved_mem logic, which
> > doesn't feel right to me.
> >
> > I'd probably guess we should have some sort of dt binding to describe
> > a dmabuf cma heap and from that node link to a CMA node via a
> > memory-region phandle. Along with maybe the default heap as well? Not
> > eager to get into another binding review cycle, and I'm not sure what
> > non-DT systems will do yet, but I'll take a shot at it and iterate.
> >
> > > The end result is the same so we can make this change later (it has to
> > > come after DMA-BUF heaps is in anyway).
> >
> > Well, I'm hesitant to merge code that exposes all the CMA heaps and
> > then add patches that becomes more selective, should anyone depend on
> > the initial behavior. :/
>
> How about only auto-adding the system default CMA region (cma->name ==
> "reserved")?

Great minds... :)

> And/or the CMA auto-add could be behind a config option? It seems a
> shame to further delay this, and the CMA heap itself really is useful.

thanks
-john
