Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F6DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E106920675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdtsdR24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCGVPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:15:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39029 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCGVPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:15:05 -0500
Received: by mail-io1-f67.google.com with SMTP id x3so14897474ior.6;
        Thu, 07 Mar 2019 13:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kwQTfJDf2GGq+4EPc/xPnv60WmjD15BGPGOMXGyJQo=;
        b=FdtsdR24Sk28iB9JIojUoGU2XQWH1ZSrJg7xlAwvOdI0fL8oePoAM9Y0fIfFXKKlYb
         RkgKU8a56dm6ii2OoTqBirOKFGGuVz6+gm5AmR6HubhyUs64AkEx79Jw8L+bTWm8hGRC
         41Am4csx1DEnDPOqOExJ8CzdVHVLWzCbdcXx3miUNrcMyEYYw8gOhVf4PpwNWT0rC+tc
         c7Crsj8THobz0SUXoQOOobDnkQrbSe5PeBgxn9ki6B9IdjMZ6TfvNo5fDPIa/yIaWDpz
         k1IgWREt7px4JptQeQGTcwZspt6IJU4z0lQ2mtrvIqBEJvVkqA54LbN86X3K7g8+5erT
         SI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kwQTfJDf2GGq+4EPc/xPnv60WmjD15BGPGOMXGyJQo=;
        b=ZRpBRMCRm86unNc6xO2pWOCj0BIM4V2BWMH66rq2Y81SawKlJf0ua1LPMUQyfbQ1Qm
         f/Pzc/4lcalhzisVXERO2sI+tY6AkDgmdrxFu1yPkVyIAF6ohm9Dss4HW+HZPqNiP8nm
         yffnuU9khKtydvfWo8U6H7xJbfG//W+HkDfXTG9rXawhorSGCIDbb/WeiGASCmPEmm/5
         VDBlEHgjApKdU2T8CJ2AZUdzmDwtcq2n0Czs+yc49AAkBQ3Qz8JQUYuwsxMM0qAb5l9S
         tmHBYVoDxd1QzwfyMiNpktofPzQ7M0z6OPY/faDB//FqqSUGBMIHfNdZ1OQLboie5FCl
         REXA==
X-Gm-Message-State: APjAAAWmY1lzJQBB6Nu+vXzYLf/DtgOZFUaWsm44isUQKq81HNxGdOHj
        1jsn/NQT47s9lfrIiiFUyCX41WIHr44Y7zFWPEw=
X-Google-Smtp-Source: APXvYqz02VverKWnZ4mSUuKRqA24qCdg7ndh+nOVzx3JlPIXPRUnrXkmqzh/ZBO3E46Ggx3HeEo1VHde+44BqMELJG0=
X-Received: by 2002:a6b:e219:: with SMTP id z25mr7425326ioc.116.1551993303724;
 Thu, 07 Mar 2019 13:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com> <CAKgT0Ud35pmmfAabYJijWo8qpucUWS8-OzBW=gsotfxZFuS9PQ@mail.gmail.com>
 <1d5e27dc-aade-1be7-2076-b7710fa513b6@redhat.com> <CAKgT0UdNPADF+8NMxnWuiB_+_M6_0jTt5NfoOvFN9qbPjGWNtw@mail.gmail.com>
 <2269c59c-968c-bbff-34c4-1041a2b1898a@redhat.com> <CAKgT0UdHkDB1vFMp7T9_pdoiuDW4qvgxhqsNztPQXrRCAmYNng@mail.gmail.com>
 <20190307134744-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190307134744-mutt-send-email-mst@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 7 Mar 2019 13:14:52 -0800
Message-ID: <CAKgT0Ue=Y-6-mzqzZ+tJYvfOd4ZeK59okeZKjfJ7LHwhbdpY_w@mail.gmail.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        David Hildenbrand <david@redhat.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 10:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Mar 07, 2019 at 10:45:58AM -0800, Alexander Duyck wrote:
> > To that end what I think w may want to do is instead just walk the LRU
> > list for a given zone/order in reverse order so that we can try to
> > identify the pages that are most likely to be cold and unused and
> > those are the first ones we want to be hinting on rather than the ones
> > that were just freed. If we can look at doing something like adding a
> > jiffies value to the page indicating when it was last freed we could
> > even have a good point for determining when we should stop processing
> > pages in a given zone/order list.
> >
> > In reality the approach wouldn't be too different from what you are
> > doing now, the only real difference would be that we would just want
> > to walk the LRU list for the given zone/order rather then pulling
> > hints on what to free from the calls to free_one_page. In addition we
> > would need to add a couple bits to indicate if the page has been
> > hinted on, is in the middle of getting hinted on, and something such
> > as the jiffies value I mentioned which we could use to determine how
> > old the page is.
>
> Do we really need bits in the page?
> Would it be bad to just have a separate hint list?

The issue is lists are expensive to search. If we have a single bit in
the page we can check it as soon as we have the page.

> If you run out of free memory you can check the hint
> list, if you find stuff there you can spin
> or kick the hypervisor to hurry up.

This implies you are keeping a separate list of pages for what has
been hinted on. If we are pulling pages out of the LRU list for that
it will require the zone lock to move the pages back and forth and for
higher core counts that isn't going to scale very well, and if you are
trying to pull out a page that is currently being hinted on you will
run into the same issue of having to wait for the hint to be completed
before proceeding.

> Core mm/ changes, so nothing's easy, I know.

We might be able to reuse some existing page flags. For example, there
is the PG_young and PG_idle flags that would actually be a pretty good
fit in terms of what we are looking for in behavior. We could set
PG_young when the page is initially freed, then clear it when we start
to perform the hint, and set PG_idle once the hint has been completed.

The check for if we could use a page would be pretty fast as a result
as well since if PG_young or PG_idle are set it means the page is free
to use so the check in arch_alloc_page would be pretty cheap since we
could probably test for both bits in one read.
