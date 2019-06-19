Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F7C48BDF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD232147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YlyPqPBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfFSUS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:18:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37875 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 16:18:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id s20so367758otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMu1Eynp9KYFQ9eA5SmgvunmkEBDxoIzU+1szZNiCbA=;
        b=YlyPqPBiPTfkDOdJ5VJIj4DFNeLCKL8DI+SUapLpqcyHkZ3w7UdvlSsXa0Oewx+gIO
         ls8A9xGbEJDVy7wX+7Wrp2Y2dOkXE2UKcAt2aGPDe8APV+r21JZ69QC/JyzdhFWazDwg
         T44DzMD+35dNL6M4TaFtbY9aua85SEnMj9gpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMu1Eynp9KYFQ9eA5SmgvunmkEBDxoIzU+1szZNiCbA=;
        b=heV4qaKCqKEoauHIyerzLJrE8RoC6j+oHacTa3TDqrZwETm04CwtfqJM0WGBJdcGNs
         Ak31NtuamC0iZjGlwk6PVn2kjGr9G7anlrME+bKMtrb1eh/3MBuWN8BR6rLfYqxXfuMe
         ek8D6hBTHWAx4xkrhSELFuFSmY8MBay5ue8//6rQOaM9yT6+h3bWuGZNClNljzzS8uWG
         do3yXjOIdiufy6XQEn2n9viW7zHIYJ5OggyRgQlrGREsWZVTRPwNv3jyhbRPqgOXLlT7
         AFcTM4Gg8aJRcPU179rmvyknxL9SrN6AwhTsW5kAhGNNagwsONskvJiKn/pOoUC4RsRo
         VsRw==
X-Gm-Message-State: APjAAAXDI5GaXf7O6cXbKP4Nzy/WTZ7CFi+up29TFTK/Hl8Fgcu9QsMI
        prtMSu3e9obhleE6B6nVzXk3ixJOtTROXRGYw8sTuA==
X-Google-Smtp-Source: APXvYqw6bgG2GsUkNVmJ8zuOKu1tc9Z6lf4W2oeXwaheE4AOJs5xOP8C+LQrEQLCr9yBSA9ecTAu4RInlgBAYdXylok=
X-Received: by 2002:a05:6830:ce:: with SMTP id x14mr5140545oto.188.1560975536589;
 Wed, 19 Jun 2019 13:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
 <20190521154411.GD3836@redhat.com> <20190618152215.GG12905@phenom.ffwll.local>
 <20190619165055.GI9360@ziepe.ca> <CAKMK7uGpupxF8MdyX3_HmOfc+OkGxVM_b9WbF+S-2fHe0F5SQA@mail.gmail.com>
 <20190619201340.GL9360@ziepe.ca>
In-Reply-To: <20190619201340.GL9360@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 19 Jun 2019 22:18:43 +0200
Message-ID: <CAKMK7uGtXT1qLdUqnmTd9uUkdMrcreg4UmAxscx0Fp4Pv6uj_A@mail.gmail.com>
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

On Wed, Jun 19, 2019 at 10:13 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Jun 19, 2019 at 09:57:15PM +0200, Daniel Vetter wrote:
> > On Wed, Jun 19, 2019 at 6:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Tue, Jun 18, 2019 at 05:22:15PM +0200, Daniel Vetter wrote:
> > > > On Tue, May 21, 2019 at 11:44:11AM -0400, Jerome Glisse wrote:
> > > > > On Mon, May 20, 2019 at 11:39:42PM +0200, Daniel Vetter wrote:
> > > > > > Just a bit of paranoia, since if we start pushing this deep into
> > > > > > callchains it's hard to spot all places where an mmu notifier
> > > > > > implementation might fail when it's not allowed to.
> > > > > >
> > > > > > Inspired by some confusion we had discussing i915 mmu notifiers and
> > > > > > whether we could use the newly-introduced return value to handle some
> > > > > > corner cases. Until we realized that these are only for when a task
> > > > > > has been killed by the oom reaper.
> > > > > >
> > > > > > An alternative approach would be to split the callback into two
> > > > > > versions, one with the int return value, and the other with void
> > > > > > return value like in older kernels. But that's a lot more churn for
> > > > > > fairly little gain I think.
> > > > > >
> > > > > > Summary from the m-l discussion on why we want something at warning
> > > > > > level: This allows automated tooling in CI to catch bugs without
> > > > > > humans having to look at everything. If we just upgrade the existing
> > > > > > pr_info to a pr_warn, then we'll have false positives. And as-is, no
> > > > > > one will ever spot the problem since it's lost in the massive amounts
> > > > > > of overall dmesg noise.
> > > > > >
> > > > > > v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
> > > > > > the problematic case (Michal Hocko).
> > >
> > > I disagree with this v2 note, the WARN_ON/WARN will trigger checkers
> > > like syzkaller to report a bug, while a random pr_warn probably will
> > > not.
> > >
> > > I do agree the backtrace is not useful here, but we don't have a
> > > warn-no-backtrace version..
> > >
> > > IMHO, kernel/driver bugs should always be reported by WARN &
> > > friends. We never expect to see the print, so why do we care how big
> > > it is?
> > >
> > > Also note that WARN integrates an unlikely() into it so the codegen is
> > > automatically a bit more optimal that the if & pr_warn combination.
> >
> > Where do you make a difference between a WARN without backtrace and a
> > pr_warn? They're both dumped at the same log-level ...
>
> WARN panics the kernel when you set
>
> /proc/sys/kernel/panic_on_warn
>
> So auto testing tools can set that and get a clean detection that the
> kernel has failed the test in some way.
>
> Otherwise you are left with frail/ugly grepping of dmesg.

Hm right.

Anyway, I'm happy to repaint the bikeshed in any color that's desired,
if that helps with landing it. WARN_WITHOUT_BACKTRACE might take a bit
longer (need to find a bit of time, plus it'll definitely attract more
comments).

Michal?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
