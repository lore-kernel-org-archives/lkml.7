Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929CCC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B4F21929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbYI1+bG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390413AbfKERl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:41:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41387 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388969AbfKERl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:41:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id e9so14422186oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IW0B7vGBOZzh3Br4WBMe5H6F6ySlTPaNURY6MVu9ypc=;
        b=ZbYI1+bGZXJmenbWyTwg59wx2IQa4RsXYMy5cDpjY94ZKRzvY7jXz1ZuZz7MjxE0Z1
         0DkLswJnlqUZAxeZlQetG/AGeQ8sSr0bH3bsRJpWQizhENKoMme9H4ptr2WeIPHjsbwT
         bhs695GuhX7/roSlyPP9tqWBYFTQpzlG8AbUf9dbDw+Q0JkDCrXka6BfBc2NHToivKcd
         M4bs0RdXRhCXJtq3rs5X8Aa46HQco0y0ejruMU2uwY4Hpk4/sk5fSsaJmiOy/iEIB8LN
         Ei1PHtt5WYyOUo6ml8iX8eKhtZKSni+wqyGt/Xz8ZvCq8Kh3EhWTVC9fSt9H/u3uTVTT
         XeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IW0B7vGBOZzh3Br4WBMe5H6F6ySlTPaNURY6MVu9ypc=;
        b=RZ26tx80rqjOLrvhnuXL5vaykG7hwdlaJN1EE4wuRPxIbeoe8KFC/jA3hjMxK6ns4w
         3TbWQLLsxFw2ob/2kteCif/07wSEPixtORNi3qddmAvVezR8BgoU6P8BBaXF5nYpBsZV
         IkCuILfEhLP/6bWp8eS1LSPd7+pWqjRizuCeaVxxy6EMIrZ4agyUmh7o6VVOh/SRLygK
         UcRveNO46hs42zoQG5NKxJ9f8Z56qX5tGzEFU3ZTZ1i8kMpiBW9mGYxXTfBupymBm8zy
         uBMBDToKZdf+ABPK/njavRLiw+EpIiJIqozwNWUrF9DvIqL6q0TibB7jK1moqi1uoHSH
         MqUg==
X-Gm-Message-State: APjAAAX4l9crVlyt+y0s1/diCnq3pPuJ6pQC1JSOT9zpicDjrcKf9/nR
        dh8E9S+hNGLwcEsYJBW0nkBXbKMP0dqDpBcbY0TQiw==
X-Google-Smtp-Source: APXvYqyeDs/QoA5RfByjqPGNd6UTX27g8Bcyttet+PRuoxInbJsv6PD62Ia904Qn9TsvFKumOj9jCCzig32M+6/5khE=
X-Received: by 2002:aca:c64c:: with SMTP id w73mr118205oif.161.1572975716440;
 Tue, 05 Nov 2019 09:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191104095823.GD10326@phenom.ffwll.local> <CALAqxLW_CoAn-KXki0dGKK+vo-R4CTnjt1Azrw=mRdL8BUFGWw@mail.gmail.com>
 <20191105094259.GX10326@phenom.ffwll.local>
In-Reply-To: <20191105094259.GX10326@phenom.ffwll.local>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 5 Nov 2019 09:41:44 -0800
Message-ID: <CALAqxLWvNOL=Exybb25GgYQujyJcPNTsFuaBnjLQPKTkVAi6Xw@mail.gmail.com>
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

On Tue, Nov 5, 2019 at 1:43 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Nov 04, 2019 at 10:57:44AM -0800, John Stultz wrote:
> > On Mon, Nov 4, 2019 at 1:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Fri, Oct 25, 2019 at 11:48:32PM +0000, John Stultz wrote:
> > So even if the heaps are configured via DT (which at the moment there
> > is no such binding, so that's not really a valid method yet), there's
> > still the question of if the heap is necessary/makes sense on the
> > device. And the DT would only control the availability of the heap
> > interface, not if the heap driver is loaded or not.
>
> Hm I thought the cma regions are configured in DT? How does that work if
> it's not using DT?

So yea, CMA regions are either configured by DT or setup at build time
(I think there's a cmdline option to set it up as well).

But the CMA regions and the dmabuf cma heap driver are separate
things. The latter uses the former.

> > On the HiKey/HiKey960 boards, we have to allocate contiguous buffers
> > for the display framebuffer. So gralloc uses ION to allocate from the
> > CMA heap. However on the db845c, it has no such restrictions, so the
> > CMA heap isn't necessary.
>
> Why do you have a CMA region for the 2nd board if you don't need it?
> _That_ sounds like some serious memory waster, not a few lines of code
> loaded for nothing :-)

??? That's not what I said above.  If the db845c doesn't need CMA it
won't have a CMA region.

The issue at hand is that we may want to avoid loading the dmabuf CMA
heap driver on a board that doesn't use CMA.


> > With Android's GKI effort, there needs to be one kernel that works on
> > all the devices, and they are using modules to try to minimize the
> > amount of memory spent on functionality that isn't universally needed.
> > So on devices that don't need the CMA heap, they'd probably prefer not
> > to load the CMA dmabuf heap driver, so it would be best if it could be
> > built as a module.  If we want to build the CMA heap as a module, the
> > symbols it uses need to be exported.
>
> Yeah, I guess I'm disagreeing on whether dma-buf heaps are core or not.

That's fine to dispute. I'm not really in a place to assert one way or
not, but the Android folks have made their ION system and CMA heaps
loadable via a module, so it would seem like having the dmabuf system
and CMA heaps be modular would be useful to properly replace that
usage.

For instance, the system heap as a module probably doesn't make much
sense, as most boards that want to use the dmabuf heaps interface are
likely to use that as well.  CMA is more optional as not all boards
will use that one, so it might make sense to avoid loading it.

Sandeep: Can you chime in here as to how critical having the system
and cma heaps be modules are?


> > > Exporting symbols for no real in-tree users feels fishy.
> >
> > I'm submitting an in-tree user here. So I'm not sure what you mean?  I
> > suspect you're thinking there is some hidden/nefarious plan here, but
> > really there isn't.
>
> I was working under the assumption that you're only exporting the symbols
> for other heaps, and keep the current ones in-tree.

No. I'm trying to allow the (hopefully-soon-to-be-in-tree) system and
cma heap drivers to be loaded from a module.
If other heaps need exports, they can submit their heaps upstream and
argue for the exported symbols themselves.

> Are there even any
> out-of-tree dma-buf heaps still? out-of-tree and legit different use-case
> I mean ofc, not just out-of-tree because inertia :-)

So as Andrew mentioned, he has some dmabuf heaps he's working on at
TI.  From what I've heard the qualcomm folks like the dmabuf heaps
approach, but I'm not sure if they've taken a pass at converting their
vendor ION heaps to it yet.

The main reason I'm only submitting system and CMA is because those
are the only two I personally have a user for (HiKey/HiKey960 boards).
It's my hope that once we deprecate ION in Android, vendors will
migrate and we'll be able to push them to upstream their heaps as
well.

thanks
-john
