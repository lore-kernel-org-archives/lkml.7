Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F8EC5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C1F21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TqEhtOSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfKETsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:48:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42327 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfKETsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:48:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id b16so18704276otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 11:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sqb7GQLcQVbw2N0rPy5gzCBrbUzJToKITpBvRXsoKJk=;
        b=TqEhtOSMPG3KFe2OzLNhU+XMMbv3vQ/UqX1lLqTkWkQHbMfW2xSa8I+ZgpqLZJzmyu
         ncJDa/AGRBUW4mEfDae3GLEC+fv4Z8ax12Y/U/zSO4qDKwd3x8lHX787XzXBGAhOlo60
         EFccP+d8WXqgsnNWQiUXxAUsJ0zmHLBnnuL5roOl4R20eQp6/md4ZSVBWvwAmEWc2NJN
         b7Gw6Cc7NCurX68LC1mDzuTbDIfX50hy9aThsGbd0YypIocJGwv0KMbijNcisjHvwm7b
         GKqgWjpqG6WgtTSZGcB2zqF61YRU572ZtWOEqaItvhdW3gFvfwsMqyC0jG5FZmb2uw57
         xyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sqb7GQLcQVbw2N0rPy5gzCBrbUzJToKITpBvRXsoKJk=;
        b=ZNqEw0PPdm/ZWLoh2VQkjPakM20QjcEwV68et7Tt8P9PY8Z0UGgjogKyFGCwj6tmrc
         rrMP7AeqBVOp21XSeYP1HqWH/pGDQC0unt/lp5HWWdU7naQBE0c+NnhfXN0WHSocAnyg
         4R44EsAsLR42334gI7YnKzqKHomRZLubI6EilGVb6bm9t4JsR+sjRoLUPfRw3UrvfZ6F
         gwKngoju1ArLedd4NhH2QYu+bOK/6yeEUZGe/w+60bMUXaDovVmG6dq2c84bQy4BCEv2
         JVXOiNeSIbhp5Z7V58yRP/uzWxBsrZ1YwVNaVg6WATurDUoiv9QMmTuLEiSxldPnq2YT
         VGpg==
X-Gm-Message-State: APjAAAUB0lTNOLT2kDndVXK+7HMpxHTHksQCbxqJ53PrHVk/NabpkS5J
        FRtcssUkG7eX4Vwbd+no9wxoR0aqmniVQFX27zfunQ==
X-Google-Smtp-Source: APXvYqx/5UhLYjy08pWDrSssq4y3azdX7VIiqTt2QeupWH16xoX87fJYkAl89Qva0MNLhr3vdAmwGjb9v53y9mZuS9w=
X-Received: by 2002:a9d:75c7:: with SMTP id c7mr4595580otl.12.1572983285883;
 Tue, 05 Nov 2019 11:48:05 -0800 (PST)
MIME-Version: 1.0
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191104095823.GD10326@phenom.ffwll.local> <CALAqxLW_CoAn-KXki0dGKK+vo-R4CTnjt1Azrw=mRdL8BUFGWw@mail.gmail.com>
 <20191105094259.GX10326@phenom.ffwll.local> <CALAqxLWvNOL=Exybb25GgYQujyJcPNTsFuaBnjLQPKTkVAi6Xw@mail.gmail.com>
 <CAKMK7uFSBNqVWy0N-GH7CzH-R7c9CVb97LgCffdMzGCgvVan4Q@mail.gmail.com>
In-Reply-To: <CAKMK7uFSBNqVWy0N-GH7CzH-R7c9CVb97LgCffdMzGCgvVan4Q@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 5 Nov 2019 11:47:53 -0800
Message-ID: <CALAqxLV+MfESanq+PenRUNR_w6KZT1KQ7suPjmiT-bdAFx83EA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/2] Allow DMA BUF heaps to be loaded as modules
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 11:19 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Nov 5, 2019 at 6:41 PM John Stultz <john.stultz@linaro.org> wrote:
> > On Tue, Nov 5, 2019 at 1:43 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Mon, Nov 04, 2019 at 10:57:44AM -0800, John Stultz wrote:
> > > > On Mon, Nov 4, 2019 at 1:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > On Fri, Oct 25, 2019 at 11:48:32PM +0000, John Stultz wrote:
> > > > So even if the heaps are configured via DT (which at the moment there
> > > > is no such binding, so that's not really a valid method yet), there's
> > > > still the question of if the heap is necessary/makes sense on the
> > > > device. And the DT would only control the availability of the heap
> > > > interface, not if the heap driver is loaded or not.
> > >
> > > Hm I thought the cma regions are configured in DT? How does that work if
> > > it's not using DT?
> >
> > So yea, CMA regions are either configured by DT or setup at build time
> > (I think there's a cmdline option to set it up as well).
> >
> > But the CMA regions and the dmabuf cma heap driver are separate
> > things. The latter uses the former.
>
> Huh, I assumed the plan is that whenever there's a cma region, we want
> to instantiate a dma-buf heap for it? Why/when would we not want to do
> that?

Not quite. Andrew noted that we may not want to expose all CMA regions
via dmabuf heaps, so right now we only expose the default region. I
have follow on patches that I sent out earlier (which requires a
to-be-finalized DT binding) which allows us to specify which other CMA
regions to expose.

> > > > On the HiKey/HiKey960 boards, we have to allocate contiguous buffers
> > > > for the display framebuffer. So gralloc uses ION to allocate from the
> > > > CMA heap. However on the db845c, it has no such restrictions, so the
> > > > CMA heap isn't necessary.
> > >
> > > Why do you have a CMA region for the 2nd board if you don't need it?
> > > _That_ sounds like some serious memory waster, not a few lines of code
> > > loaded for nothing :-)
> >
> > ??? That's not what I said above.  If the db845c doesn't need CMA it
> > won't have a CMA region.
> >
> > The issue at hand is that we may want to avoid loading the dmabuf CMA
> > heap driver on a board that doesn't use CMA.
>
> So the CMA core code is also a module, or how does that work? Not

No.  CMA core isn't available as a module.

> loading the cma dma-buf heap, but keeping all the other cma code
> around feels slightly silly. Do we have numbers that justify this
> silliness?

I agree that is maybe not the most critical item on the list, but its
one of many that do add up over time.

Again, I'll defer to Sandeep or other folks on the Google side to help
with the importance here. Mostly I'm trying to ensure there is
functional parity to ION so we don't give folks any reason they could
object to deprecating it.

> > The main reason I'm only submitting system and CMA is because those
> > are the only two I personally have a user for (HiKey/HiKey960 boards).
> > It's my hope that once we deprecate ION in Android, vendors will
> > migrate and we'll be able to push them to upstream their heaps as
> > well.
>
> I think for upstream I'd want to see those other heaps first. If
> they're mostly driver allocators exposed as heaps, then I think we
> need something different than heap modules, maybe allow dma-buf to
> allocate from drivers instead. But afaiui all such driver allocators
> we have in upstream are cma regions only right now.

I'm sorry, I'm not sure I understand what you mean here (I'm not sure
what action I should be taking). Could you clarify this point?

thanks
-john
