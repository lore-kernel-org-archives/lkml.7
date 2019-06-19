Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB8CC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2192173E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c98keUgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfFST53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:57:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34379 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFST53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:57:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id a128so318929oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7z2tqXWz21B1V8yRVcYZ+guCUeprENU4KV1hN3na0Fs=;
        b=c98keUgte0uTFh2NqchAuIxnX8Q49/GZCgQczWFfVOcAzumkG95NuHQPDWP2WUsqo/
         oCLbH0XtppVL+lGrn05uM9oLm3WIhfibqD8PTm4hTs0/e0Z+Pqsa2VuNsS3X9lc9qmmu
         Z3zqjTkCzBNUM3CWJvMoRhJP+YYYDv1DhjaEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7z2tqXWz21B1V8yRVcYZ+guCUeprENU4KV1hN3na0Fs=;
        b=CTogo3fsEDoDNsc8K20UqFyV6J/E4rQmT8PkdDuebalZmmHN+WiZS+PSB9W9Vcr94N
         ljDK9XBObLY4bDokoTs79lryWLGGae38orCdvAJJXUYi5czlkc27orgbgw+3qj53Yc49
         QZzC30eUm5MQBH80gma/DkRpfinXrOTM7T3Se6QpEnIhUeBbDD3/33eotJQ482dUgpra
         dm267r67jDer3VTfrdpyb+yAUr/YWa2JouFu/62w0tu6MnyBpOFkqguRX9tX5cmMmGmt
         VHuZP9IrLWX5/H/dJq4ioeColS0faO+vpOMdQfKntsK0CPCd3U+jBT3jEnKtNApffVyb
         SFGg==
X-Gm-Message-State: APjAAAV98LhJqoezYoAp38eB1hap7sFuQwkv+wNilw3EHK9mhMQQb3F9
        E+50mCBzSkn/Xu0PNYCmT2Z9Ce/FkygnDyItw/P6tXGf
X-Google-Smtp-Source: APXvYqw5ofouG26OMfQzFxsOzV+EiqO0k+h0EfPvx43Md1F3SX/w73DYzzvppOkjHYp+QM5aupN2Qz3/NdhkpYGtQiw=
X-Received: by 2002:aca:b2d5:: with SMTP id b204mr3542425oif.101.1560974248386;
 Wed, 19 Jun 2019 12:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
 <20190521154411.GD3836@redhat.com> <20190618152215.GG12905@phenom.ffwll.local>
 <20190619165055.GI9360@ziepe.ca>
In-Reply-To: <20190619165055.GI9360@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 19 Jun 2019 21:57:15 +0200
Message-ID: <CAKMK7uGpupxF8MdyX3_HmOfc+OkGxVM_b9WbF+S-2fHe0F5SQA@mail.gmail.com>
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

On Wed, Jun 19, 2019 at 6:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Jun 18, 2019 at 05:22:15PM +0200, Daniel Vetter wrote:
> > On Tue, May 21, 2019 at 11:44:11AM -0400, Jerome Glisse wrote:
> > > On Mon, May 20, 2019 at 11:39:42PM +0200, Daniel Vetter wrote:
> > > > Just a bit of paranoia, since if we start pushing this deep into
> > > > callchains it's hard to spot all places where an mmu notifier
> > > > implementation might fail when it's not allowed to.
> > > >
> > > > Inspired by some confusion we had discussing i915 mmu notifiers and
> > > > whether we could use the newly-introduced return value to handle some
> > > > corner cases. Until we realized that these are only for when a task
> > > > has been killed by the oom reaper.
> > > >
> > > > An alternative approach would be to split the callback into two
> > > > versions, one with the int return value, and the other with void
> > > > return value like in older kernels. But that's a lot more churn for
> > > > fairly little gain I think.
> > > >
> > > > Summary from the m-l discussion on why we want something at warning
> > > > level: This allows automated tooling in CI to catch bugs without
> > > > humans having to look at everything. If we just upgrade the existing
> > > > pr_info to a pr_warn, then we'll have false positives. And as-is, no
> > > > one will ever spot the problem since it's lost in the massive amounts
> > > > of overall dmesg noise.
> > > >
> > > > v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
> > > > the problematic case (Michal Hocko).
>
> I disagree with this v2 note, the WARN_ON/WARN will trigger checkers
> like syzkaller to report a bug, while a random pr_warn probably will
> not.
>
> I do agree the backtrace is not useful here, but we don't have a
> warn-no-backtrace version..
>
> IMHO, kernel/driver bugs should always be reported by WARN &
> friends. We never expect to see the print, so why do we care how big
> it is?
>
> Also note that WARN integrates an unlikely() into it so the codegen is
> automatically a bit more optimal that the if & pr_warn combination.

Where do you make a difference between a WARN without backtrace and a
pr_warn? They're both dumped at the same log-level ...

I can easily throw an unlikely around this here if that's the only
thing that's blocking the merge.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
