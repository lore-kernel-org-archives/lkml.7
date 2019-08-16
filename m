Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56789C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AC72133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JfOVHWNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfHPQhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:37:05 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36428 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfHPQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:37:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id k18so10206457otr.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TjiC7tL5tVLJpZgBmmeBYDZnQ+YoBFviaBZJfxvqRo=;
        b=JfOVHWNQNFhlm05DIsQUQILP6M8uBwVqZSzqy1eYSpIOTEaQbCtHbvykAwr22Tl6G1
         RNXH1jUaj+1SuMHTPPN2vG+sS56vR/rcdrJk34I37Kr5H+ovEq9dCHTkoSWPVy5ywMLh
         lz1n0dh2WMbvNoSKqCFONNRk5N6dN3lYNnwsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TjiC7tL5tVLJpZgBmmeBYDZnQ+YoBFviaBZJfxvqRo=;
        b=fMczE/jC8XhA3SO+TItg8kq9eFBsVCoRuaq3Ket07zSiF4Mf7sBosmKCfxgNcsey08
         p2GizKlCC8Irkc//IVv6s5HQWcl0Lkv5L1Q6Cpe3dt04pdHcgNgxQP4C/plpXGwNTzX2
         jcyNwDlfn78PI4R2PvECMkqY4ro/3S0jL4OjPH591tgoKCJ/aYc8isVT+kMKSiuv4+Yh
         ttxpT0028Efk6So92IDTuOF20Ph1e6VwMK/t1SG4f0na4NDE/861+SycZja9Db959tnX
         dPkVX+tUxkpu62YY2tpChAzGjWohdugPO/YbYEfGt8AgE/rX05OdZnUllpA8gUQuYL1H
         PuyA==
X-Gm-Message-State: APjAAAUYTfQjZ2unWjkiPzCR2doq8putCczlF03xFol9mTfIxDdDW9xF
        6NvmMzDBy07HqRDW6X59YsufE4lHT0kMFBXieGm4nA==
X-Google-Smtp-Source: APXvYqxJCBauYrVR7fqS+LuWRAKsoJ5dG70QezYi/k/QXJiyisCvN0d9PyJccgTFO91to0aqDKVlvYvo6VHCa8rK6mw=
X-Received: by 2002:a9d:1ca3:: with SMTP id l35mr7813768ota.106.1565973423804;
 Fri, 16 Aug 2019 09:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190815190525.GS9477@dhcp22.suse.cz> <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz> <CAKMK7uH42EgdxL18yce-7yay=x=Gb21nBs3nY7RA92Nsd-HCNA@mail.gmail.com>
 <20190815202721.GV21596@ziepe.ca> <CAKMK7uER0u1TqeJBXarKakphnyZTHOmedOfXXqLGVDE2mE-mAQ@mail.gmail.com>
 <20190816010036.GA9915@ziepe.ca> <CAKMK7uH0oa10LoCiEbj1NqAfWitbdOa-jQm9hM=iNL-=8gH9nw@mail.gmail.com>
 <20190816121243.GB5398@ziepe.ca> <CAKMK7uHk03OD+N-anPf-ADPzvQJ_NbQXFh5WsVUo-Ewv9vcOAw@mail.gmail.com>
 <20190816143819.GE5398@ziepe.ca>
In-Reply-To: <20190816143819.GE5398@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 16 Aug 2019 18:36:52 +0200
Message-ID: <CAKMK7uGzOO4nZPbZzmaDjjBGZiV2HjgdbT45q9Rd5wTO14VH2w@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 2/5] kernel.h: Add non_block_start/end()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Hocko <mhocko@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Rientjes <rientjes@google.com>,
        Wei Wang <wvw@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 4:38 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Aug 16, 2019 at 04:11:34PM +0200, Daniel Vetter wrote:
> > Also, aside from this patch (which is prep for the next) and some
> > simple reordering conflicts they're all independent. So if there's no
> > way to paint this bikeshed here (technicolor perhaps?) then I'd like
> > to get at least the others considered.
>
> Sure, I think for conflict avoidance reasons I'm probably taking
> mmu_notifier stuff via hmm.git, so:
>
> - Andrew had a minor remark on #1, I am ambivalent and would take it
>   as-is. Your decision if you want to respin.

I like mine better, see also the reply from Ralph Campbell.

> - #2/#3 is this issue, I would stand by the preempt_disable/etc path
>   Our situation matches yours, debug tests run lockdep/etc.

Since Michal requested the current flavour I think we need spin a bit
more on these here. I guess I'll just rebase them to the end so
they're not holding up the others.

> - #4 I like a lot, except the map should enclose range_end too,
>   this can be done after the mm_has_notifiers inside the
>   __mmu_notifier function

To make sure I get this right: The same lockdep context, but also
wrapped around invalidate_range_end? From my understanding of pte
zapping that makes sense, but I'm definitely not well-versed enough
for that.

>   Can you respin?

Will do.

>   I will propose preloading the map in another patch
> - #5 is already applied in -rc

Yup, I'll drop that one.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
