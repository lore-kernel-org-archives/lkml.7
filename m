Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58253C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2052723426
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HbHXDrzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfH1Sne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:43:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38310 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfH1Snd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:43:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id q64so717583qtd.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OjPkEOv+DLtOkFTqeu8lwQuWyFpGs0nrOsZbcx7SOSc=;
        b=HbHXDrzLqc3lpVU55Nd/0BI2SIQ2x72GzuKH/C2UAiJOAp38bcuMdbQptguyCeoa8S
         XtS6TSStn/7XppLzX0ltVtzjXABmeo1iBZlbJIsc4IjxoQVNK0XgHoe5qnT8leWBFLKp
         ygUAeNgUsdCWiSK9m1VX/B1VNJIeObqWI6AHSZGYIK+Qowf5xQW46ccAvDBEfsckznWb
         MmKN+mdFBQ6Nzf54I3ucE1GI2CyvGbcHp7ySqkRKMENGHCY7dCaaAu8QWTMfUcwQtNxa
         Ro8JrnGi/uzzbWR34UB7mEtJw9KlHNFZfY2+dANrWQiodo233hpz5sMhLvpLGJJjf8W7
         2liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjPkEOv+DLtOkFTqeu8lwQuWyFpGs0nrOsZbcx7SOSc=;
        b=jThY1Y0IpxskVAgHEw4Wu3N1ExhczNkgIgSYI64t+oZgW2a4Pno6aM2GnrUZkgvsQV
         QMpzLcLE+n657oljasZaTqgpIpVcx9ybCj0vSn1sZ742zpjfIDByJW67iFLwW/1z6FIT
         Or9VKvxpXm0DpzktBytsyfIcOJx5KSmWn7PNMvzx8rJP38iU62rByUG1ZYHGkqyiUwOa
         1ILdQFnwbmzx9OPmQIk3SNCxND+DI9HgtgoKohkiuyrI8iSZ49X/4eyhIOVAwqJBrfVX
         bh3vDEXXBZsro7yVi7pbzdqrRrQHyN6drmp/3Ymzi7rWd+zMHGyPb/OnklNbLoJZbn3k
         A/Fg==
X-Gm-Message-State: APjAAAU8BwyWumH06R0jbx9ILDP5ODTNK960tHfOjpSa0wo06BDtbSIb
        OYJ7Hj6ewQKf57MPqnKhVKcjCA==
X-Google-Smtp-Source: APXvYqyEQcVWQf49+hXcQCirgyPBJnM1VH//y0tMVxtn+SNqmDh6w+F0CMCxwxOy8DpklWetu0fhmA==
X-Received: by 2002:ac8:750e:: with SMTP id u14mr5800709qtq.282.1567017812387;
        Wed, 28 Aug 2019 11:43:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id k11sm21089qtp.26.2019.08.28.11.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 11:43:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i32uo-0006U8-Rg; Wed, 28 Aug 2019 15:43:30 -0300
Date:   Wed, 28 Aug 2019 15:43:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/5] kernel.h: Add non_block_start/end()
Message-ID: <20190828184330.GD933@ziepe.ca>
References: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
 <20190826201425.17547-4-daniel.vetter@ffwll.ch>
 <20190827225002.GB30700@ziepe.ca>
 <CAKMK7uHKiLwXLHd1xThZVM1dH-oKrtpDZ=FxLBBwtY7XmJKgtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHKiLwXLHd1xThZVM1dH-oKrtpDZ=FxLBBwtY7XmJKgtA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 08:33:13PM +0200, Daniel Vetter wrote:
> On Wed, Aug 28, 2019 at 12:50 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > > index 4fa360a13c1e..82f84cfe372f 100644
> > > +++ b/include/linux/kernel.h
> > > @@ -217,7 +217,9 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
> > >   * might_sleep - annotation for functions that can sleep
> > >   *
> > >   * this macro will print a stack trace if it is executed in an atomic
> > > - * context (spinlock, irq-handler, ...).
> > > + * context (spinlock, irq-handler, ...). Additional sections where blocking is
> > > + * not allowed can be annotated with non_block_start() and non_block_end()
> > > + * pairs.
> > >   *
> > >   * This is a useful debugging help to be able to catch problems early and not
> > >   * be bitten later when the calling function happens to sleep when it is not
> > > @@ -233,6 +235,25 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
> > >  # define cant_sleep() \
> > >       do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
> > >  # define sched_annotate_sleep()      (current->task_state_change = 0)
> > > +/**
> > > + * non_block_start - annotate the start of section where sleeping is prohibited
> > > + *
> > > + * This is on behalf of the oom reaper, specifically when it is calling the mmu
> > > + * notifiers. The problem is that if the notifier were to block on, for example,
> > > + * mutex_lock() and if the process which holds that mutex were to perform a
> > > + * sleeping memory allocation, the oom reaper is now blocked on completion of
> > > + * that memory allocation. Other blocking calls like wait_event() pose similar
> > > + * issues.
> > > + */
> > > +# define non_block_start() \
> > > +     do { current->non_block_count++; } while (0)
> > > +/**
> > > + * non_block_end - annotate the end of section where sleeping is prohibited
> > > + *
> > > + * Closes a section opened by non_block_start().
> > > + */
> > > +# define non_block_end() \
> > > +     do { WARN_ON(current->non_block_count-- == 0); } while (0)
> >
> > check-patch does not like these, and I agree
> >
> > #101: FILE: include/linux/kernel.h:248:
> > +# define non_block_start() \
> > +       do { current->non_block_count++; } while (0)
> >
> > /tmp/tmp1spfxufy/0006-kernel-h-Add-non_block_start-end-.patch:108: WARNING: Single statement macros should not use a do {} while (0) loop
> > #108: FILE: include/linux/kernel.h:255:
> > +# define non_block_end() \
> > +       do { WARN_ON(current->non_block_count-- == 0); } while (0)
> >
> > Please use a static inline?
> 
> We need get_current() plus the task_struct, so this gets real messy
> real fast. Not even sure which header this would fit in, or whether
> I'd need to create a new one. You're insisting on this or respinning
> with the do { } while (0) dropped ok.

My prefernce is always a static inline, but if the headers are so
twisty we need to use #define to solve a missing include, then I
wouldn't insist on it.

If dropping do while is the only change then I can edit it in..
I think we have the acks now

Jason
