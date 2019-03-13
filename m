Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB46020854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HoH/ElsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfCMWbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:31:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53795 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCMWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:31:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so902585wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmlIKVfFOkr+0DVdiaZ8qrs6XLjwcXZVokU38BGo0ok=;
        b=HoH/ElsLa3slr0X2/xfcXBpo8hvUF2gnTUfnZnXh2sCFRuGIA30Vj32T4Vr68Y9EqH
         1xcRMplxTKIGE3/INScSpB+SGqlLAs57j1dteZf72p6jMXRk+u/iko47PVYWLVAaZCCO
         Au+0u5NjiV9TseQ6sJcIwTDwbn1vi+nZQtqRlVBBN5IO3ynOTmpd/ZrXMtuJptyBmska
         qIz4Wa33X5x3SkS5qIbT2jX+ZbBp9mE4OcSQWHNmcxXmsSYrsn99qNMBFaHLiC7/yxRq
         OZJhX5Oq5kKWkVzPvoHUoqc5LRG/TtJcpe9rjGZbxHmPsCxkAuGaDR2Fd7ZFWY2kh9t7
         BYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmlIKVfFOkr+0DVdiaZ8qrs6XLjwcXZVokU38BGo0ok=;
        b=JXOG7XYcbrgJKPAXxgyv0syXrdTLR97RfR5KgQx4VsZt6kPbxqszCz0QmB0pFKTJlS
         3wgFBOp9On2GxPcPqXsdISs1DjS3mKov9XZjwzs5Q4s659dqrv1CYhmmy1bPn2zXb0je
         GLwzDtqod8ZZoo7YEOgEWQLU6C21pji5b6DYlw4AG4QFpFw5TiU1KaAJHCZvOIon5SXK
         x7gSPbQb7NEo3zD2g94cKMAC5JZbwUjJW3Pcmnmf5OdGRJFCBh1FUnRhmGxAwpuHSrVB
         Blj4GPr+W8+XaIMhDW+FmKj0zic+FUtvQ8POQdZQ5eqRVWzMKU3TYdgKhvPSL5xZpWkW
         4vNA==
X-Gm-Message-State: APjAAAWpEkN1kHBoL/7lE4B5XQNAlrdoDWe1rCHGBoTEs0MOEqwHgVts
        aakBK8WPi3Yp/3svPKmwbAO/hYIimNT3/mpby+bHMg==
X-Google-Smtp-Source: APXvYqwFtlLyfnYQdT5v8iI0NRFF6Nvzcc3DOfId9LiETQFPAPOsvsI1JWyvltS5CNv26Qdw9lypmGH2viOLiZHr834=
X-Received: by 2002:a1c:7311:: with SMTP id d17mr275911wmb.115.1552516270569;
 Wed, 13 Mar 2019 15:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org> <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com>
In-Reply-To: <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 13 Mar 2019 15:30:58 -0700
Message-ID: <CALAqxLUkGME+K=0g5QSja4CvN0w9z0WV60djy+5rRC+Dg-jCGg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
To:     Liam Mark <lmark@codeaurora.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Marissa Wall <marissaw@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 1:11 PM Liam Mark <lmark@codeaurora.org> wrote:
> On Tue, 5 Mar 2019, John Stultz wrote:
> >
> > Eventual TODOS:
> > * Reimplement page-pool for system heap (working on this)
> > * Add stats accounting to system/cma heaps
> > * Make the kselftest actually useful
> > * Add other heaps folks see as useful (would love to get
> >   some help from actual carveout/chunk users)!
>
> We use a modified carveout heap for certain secure use cases.

Cool! It would be great to see if you have any concerns about adding
such a secure-carveout heap to this framework. I suspect it would be
fairly similar to how its integrated into ION, but particularly I'd be
interested in issues around the lack of private flags and other
allocation arguments like alignment.

> Although there would probably be some benefit in discssing how the dma-buf
> heap framework may want to support
> secure heaps in the future it is a large topic which I assume you don't
> want to tackle now.

So I suspect others (Benjamin?) would have a more informed opinion on
the details, but the intent is to allow secure heap implementations.
I'm not sure what areas of concern you have for this allocation
framework in particular?

> We don't have any non-secure carveout heap use cases but the client use
> case I have seen usually revolve around
> wanting large allocations to succeed very quickly.
> For example I have seen camera use cases which do very large allocations
> on camera bootup from the carveout heap, these allocations would come from
> the carveout heap and fallback to the system heap when the carveout heap
> was full.
> Actual non-secure carveout heap can perhaps provide more detail.

Yea, I'm aware that folks still see carveout as preferable to CMA due
to more consistent/predictable allocation latency.  I think we still
have the issue that we don't have bindings to establish/configure
carveout regions w/ dts, and I'm not really wanting to hold up the
allocation API on that issue.


> Since we are making some fundamental changes to how ION worked and since
> Android is likely also be the largest user of the dma-buf heaps framework
> I think it would be good
> to have a path to resolve the issues which are currently preventing
> commercial Android releases from moving to the upstream version of ION.

Yea, I do see solving the cache management efficiency issues as
critical for the dmabuf heaps to be actually usable (my previous
version of this patchset accidentally had my hacks to improve
performance rolled in!).  And there are discussions going on in
various channels to try to figure out how to either change Android to
use dma-bufs more in line with how upstream expects, or what more
generic dma-buf changes we may need to allow Android to use dmabufs
with the expected performance they need.

> I can understand if you don't necessarily want to put all/any of these
> changes into the dma-buf heaps framework as part of this series, but my
> hope is we can get
> the upstream community and the Android framework team to agree on what
> upstreamable changes to dma-buf heaps framework, and/or the Android
> framework, would be required in order for Android to move to the upstream
> dma-buf heaps framework for commercial devices.

Yes. Though I also don't want to get the bigger dma-buf usage
discussion (which really affects all dmabuf exporters) too tied up
with this patch sets attempt to provide a usable allocation interface.
Part of the problem that I think we've seen with ION is that there is
a nest of of related issues, and the entire thing is just too big to
address at once, which I think is part of why ION has sat in staging
for so long. This patchset just tries to provide an dmabuf allocation
interface, and a few example exporter heap types.

> I don't mean to make this specific to Android, but my assumption is that
> many of the ION/dma-buf heaps issues which affect Android would likely
> affect other new large users of the dma-buf heaps framework, so if we
> resolve it for Android we would be helping these future users as well.
> And I do understand that some the issues facing Android may need to be
> resolved by making changes to Android framework.

While true, I also think some of the assumptions in how the dma-bufs
are used (pre-attachment of all devices, etc) are maybe not so
realistic given how Android is using them.  I do want to explore if
Android can change how they use dma-bufs, but I also worry that we
need to think about how we could loosen the expectations for dma-bufs,
as well as trying to figure out how to support things folks have
brought up like partial cache maintenance.

> I think it would be helpful to try and get as much of this agreed upon as
> possible before the dma-buf heaps framework moves out of staging.
>
> As part of my review I will highlight some of the issues which would
> affect Android.
> In my comments I will apply them to the system heap since that is what
> Android currently uses for a lot of its use cases.
> I realize that this new framework provides more flexibility to heaps, so
> perhaps some of these issues can be solved by creating a new type of
> system heap which Android can use, but even if the solution involves
> creating a new system heap I would like to make sure that this "new"
> system heap is upstreamable.

So yea, I do realize I'm dodging the hard problem here, but I think
the cache-management/usage issue is far more generic.

You're right that this implementation give a lot of flexibility to the
exporter heaps in how they implement the dmabuf ops (just like how
other device drivers that are dmabuf exporters have the same
flexibility), but I very much agree we don't want to add a system and
then later a "system-android" heap. So yea, a reasonable amount of
caution is warranted here.

Thanks so much for the review and feedback! I'll try to address things
as I can as I'm traveling this week (so I may be a bit spotty).

thanks
-john
