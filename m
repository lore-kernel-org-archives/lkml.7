Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379ACC48BE0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063D12085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Tz3wIEMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfFSVUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:20:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41698 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSVUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:20:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id g7so466391oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bI9P9AKaggByB2J+3Bzt1bHMyBdbzhZul43br86InHM=;
        b=Tz3wIEMJQ6KUu24p8kJGpTzmA6Co/vmiIUI3dfmnw92cqIil2cOfv4n0isjZeDFBj/
         N2DwUQt3F8qi0Lq/xtl6BMeVRiOStswnCRJNxGBm9I3jcsl0Vin08++XC8/kTEXa8Rb4
         gdhuT8fnTwj/ll0yWjskwxZDpP7xdYe59hvjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bI9P9AKaggByB2J+3Bzt1bHMyBdbzhZul43br86InHM=;
        b=CvFmuWSMkMaxl/tEHQzmhjKDw9rf7uVKFyovpNkuHpmWxsaD+Fv14zLQ89tOOuQXsa
         hsSChssdFyyHalvZG1S94us0QluQENSRV/PGSFIjetqzv5z7JhF4+XVQtvU+THmfCi3z
         ETdwADx53LnS+f3yN56WKFwUBK9hPCiFrv+sb1qtGi+9cW5R4Ft/yZRcMpsX+TYjEJ6g
         GVIWXVlJVjn/Wvm+IbdGKiLwghVKCPl5zX1oJV4W0Jtsd3UYBJaS3p2MugzSzIIQ9a9l
         tdw6R0UEcRC/yUxDyvkwwW1MP+dsT0aJsbfRZ024/j6YGxF790+ViyOl0gl6lmhSOJH6
         B1Bw==
X-Gm-Message-State: APjAAAUOIq1KLX7QhvXLzy6WA6KeoT9B9zn2wZtqpUtYOwiVU/rYTo24
        0wv/0P5tYKC0tlWb1f+fZv88Rtg/HEu2yD0o2e36Cg==
X-Google-Smtp-Source: APXvYqx/TLTpB9wGr9JZtdZ6RHY2xIrpHVS+clHcKNaPFf5G0BlbrC2hAFkgq7x4pUPG8gx88sa6UIhdMVbNbLa5tDI=
X-Received: by 2002:a05:6808:118:: with SMTP id b24mr3757147oie.128.1560979237149;
 Wed, 19 Jun 2019 14:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
 <20190521154411.GD3836@redhat.com> <20190618152215.GG12905@phenom.ffwll.local>
 <20190619165055.GI9360@ziepe.ca> <CAKMK7uGpupxF8MdyX3_HmOfc+OkGxVM_b9WbF+S-2fHe0F5SQA@mail.gmail.com>
 <20190619201340.GL9360@ziepe.ca> <CAKMK7uGtXT1qLdUqnmTd9uUkdMrcreg4UmAxscx0Fp4Pv6uj_A@mail.gmail.com>
 <20190619204243.GM9360@ziepe.ca>
In-Reply-To: <20190619204243.GM9360@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 19 Jun 2019 23:20:23 +0200
Message-ID: <CAKMK7uEJu4+gDLGDabxeDpArgXEGQ0B+9Z_SUM2zTB4QsnTB+g@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Check if mmu notifier callbacks are allowed to fail
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:42 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 19, 2019 at 10:18:43PM +0200, Daniel Vetter wrote:
> > On Wed, Jun 19, 2019 at 10:13 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Wed, Jun 19, 2019 at 09:57:15PM +0200, Daniel Vetter wrote:
> > > > On Wed, Jun 19, 2019 at 6:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > On Tue, Jun 18, 2019 at 05:22:15PM +0200, Daniel Vetter wrote:
> > > > > > On Tue, May 21, 2019 at 11:44:11AM -0400, Jerome Glisse wrote:
> > > > > > > On Mon, May 20, 2019 at 11:39:42PM +0200, Daniel Vetter wrote:
> > > > > > > > Just a bit of paranoia, since if we start pushing this deep into
> > > > > > > > callchains it's hard to spot all places where an mmu notifier
> > > > > > > > implementation might fail when it's not allowed to.
> > > > > > > >
> > > > > > > > Inspired by some confusion we had discussing i915 mmu notifiers and
> > > > > > > > whether we could use the newly-introduced return value to handle some
> > > > > > > > corner cases. Until we realized that these are only for when a task
> > > > > > > > has been killed by the oom reaper.
> > > > > > > >
> > > > > > > > An alternative approach would be to split the callback into two
> > > > > > > > versions, one with the int return value, and the other with void
> > > > > > > > return value like in older kernels. But that's a lot more churn for
> > > > > > > > fairly little gain I think.
> > > > > > > >
> > > > > > > > Summary from the m-l discussion on why we want something at warning
> > > > > > > > level: This allows automated tooling in CI to catch bugs without
> > > > > > > > humans having to look at everything. If we just upgrade the existing
> > > > > > > > pr_info to a pr_warn, then we'll have false positives. And as-is, no
> > > > > > > > one will ever spot the problem since it's lost in the massive amounts
> > > > > > > > of overall dmesg noise.
> > > > > > > >
> > > > > > > > v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
> > > > > > > > the problematic case (Michal Hocko).
> > > > >
> > > > > I disagree with this v2 note, the WARN_ON/WARN will trigger checkers
> > > > > like syzkaller to report a bug, while a random pr_warn probably will
> > > > > not.
> > > > >
> > > > > I do agree the backtrace is not useful here, but we don't have a
> > > > > warn-no-backtrace version..
> > > > >
> > > > > IMHO, kernel/driver bugs should always be reported by WARN &
> > > > > friends. We never expect to see the print, so why do we care how big
> > > > > it is?
> > > > >
> > > > > Also note that WARN integrates an unlikely() into it so the codegen is
> > > > > automatically a bit more optimal that the if & pr_warn combination.
> > > >
> > > > Where do you make a difference between a WARN without backtrace and a
> > > > pr_warn? They're both dumped at the same log-level ...
> > >
> > > WARN panics the kernel when you set
> > >
> > > /proc/sys/kernel/panic_on_warn
> > >
> > > So auto testing tools can set that and get a clean detection that the
> > > kernel has failed the test in some way.
> > >
> > > Otherwise you are left with frail/ugly grepping of dmesg.
> >
> > Hm right.
> >
> > Anyway, I'm happy to repaint the bikeshed in any color that's desired,
> > if that helps with landing it. WARN_WITHOUT_BACKTRACE might take a bit
> > longer (need to find a bit of time, plus it'll definitely attract more
> > comments).
>
> I was actually just writing something very similar when looking at the
> hmm things..
>
> Also, is the test backwards?

Yes, in the last rebase I screwed things up :-/
-Daniel

> mmu_notifier_range_blockable() == true means the callback must return
> zero
>
> mmu_notififer_range_blockable() == false means the callback can return
> 0 or -EAGAIN.
>
> Suggest this:
>
>                                 pr_info("%pS callback failed with %d in %sblockable context.\n",
>                                         mn->ops->invalidate_range_start, _ret,
>                                         !mmu_notifier_range_blockable(range) ? "non-" : "");
> +                               WARN_ON(mmu_notifier_range_blockable(range) ||
> +                                       _ret != -EAGAIN);
>                                 ret = _ret;
>                         }
>                 }
>
> To express the API invariant.
>
> Jason



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
