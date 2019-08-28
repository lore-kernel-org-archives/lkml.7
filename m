Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00B7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EB420856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VeBtF93w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfH1Sd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:33:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39583 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfH1Sd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:33:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id 16so493963oiq.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRw4JAwMK/TegnyayQas2h0SadP2fic7Zv1TUKBel5o=;
        b=VeBtF93wmFWp16gPmYOQv/sDqBZbOhNKDsEFS/r+1ujwicLkHIplTAeOkU/YhRf81U
         iE//NvDEi7pyMMEhylzy9D5t+BM6uaUww6q7vfD2pt45cZ772YL9Q5ChveoiwVauphCz
         tHCP8nw7jJgZIkjkReMrHLn/1r1pfE6A0fRcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRw4JAwMK/TegnyayQas2h0SadP2fic7Zv1TUKBel5o=;
        b=sejR5uJ+hcWpchdR2rbLGst8w9YWr3lIL/7gODRu27Nfz3MovnAkNSh71PZgttrucr
         yjVu4KKfjka4PExMhflB/ckoR7taqFn2t+9BvOpt+tNM4vdqH+6CgGE5pMqEPOtJpOgl
         usF7NBJ8dgipnirb6TnNZHrcv+BUbsYNqtDNqTVhjVULr4sPS5Pv5Dl/4L9P3YTZbCdv
         cJxkph/k+ISK2KxHW/kgP26E7tl1o3kB5sK17lG7F7hWhd4rzxvzzfKEWdvxSGNofpqu
         uFQpDK/of3diGoR5ICvuf1THhDIfevegUc+i1YqMnR451EDnC5Ep2PC3T/cq5vrTlVfP
         Yh8w==
X-Gm-Message-State: APjAAAWE+J8+ctjoolhD9Izi5lcbqXGgv0UwRFpMvXRCxhbQRRpDOv9X
        WCZ8LWWaYmVcdlUrc7RiBPWL6WNw/0MFfIejMQrnZA==
X-Google-Smtp-Source: APXvYqxshs+IbUxVF7bX+CC6odwm6yUPhQaN60op/uAq3yyqpLy+0PZBoNClG3BYkaFZ3dYugoyTBC4HI+Obkt1XEV4=
X-Received: by 2002:aca:6742:: with SMTP id b2mr3778581oiy.14.1567017205105;
 Wed, 28 Aug 2019 11:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
 <20190826201425.17547-4-daniel.vetter@ffwll.ch> <20190827225002.GB30700@ziepe.ca>
In-Reply-To: <20190827225002.GB30700@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 28 Aug 2019 20:33:13 +0200
Message-ID: <CAKMK7uHKiLwXLHd1xThZVM1dH-oKrtpDZ=FxLBBwtY7XmJKgtA@mail.gmail.com>
Subject: Re: [PATCH 3/5] kernel.h: Add non_block_start/end()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 12:50 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 4fa360a13c1e..82f84cfe372f 100644
> > +++ b/include/linux/kernel.h
> > @@ -217,7 +217,9 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
> >   * might_sleep - annotation for functions that can sleep
> >   *
> >   * this macro will print a stack trace if it is executed in an atomic
> > - * context (spinlock, irq-handler, ...).
> > + * context (spinlock, irq-handler, ...). Additional sections where blocking is
> > + * not allowed can be annotated with non_block_start() and non_block_end()
> > + * pairs.
> >   *
> >   * This is a useful debugging help to be able to catch problems early and not
> >   * be bitten later when the calling function happens to sleep when it is not
> > @@ -233,6 +235,25 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
> >  # define cant_sleep() \
> >       do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
> >  # define sched_annotate_sleep()      (current->task_state_change = 0)
> > +/**
> > + * non_block_start - annotate the start of section where sleeping is prohibited
> > + *
> > + * This is on behalf of the oom reaper, specifically when it is calling the mmu
> > + * notifiers. The problem is that if the notifier were to block on, for example,
> > + * mutex_lock() and if the process which holds that mutex were to perform a
> > + * sleeping memory allocation, the oom reaper is now blocked on completion of
> > + * that memory allocation. Other blocking calls like wait_event() pose similar
> > + * issues.
> > + */
> > +# define non_block_start() \
> > +     do { current->non_block_count++; } while (0)
> > +/**
> > + * non_block_end - annotate the end of section where sleeping is prohibited
> > + *
> > + * Closes a section opened by non_block_start().
> > + */
> > +# define non_block_end() \
> > +     do { WARN_ON(current->non_block_count-- == 0); } while (0)
>
> check-patch does not like these, and I agree
>
> #101: FILE: include/linux/kernel.h:248:
> +# define non_block_start() \
> +       do { current->non_block_count++; } while (0)
>
> /tmp/tmp1spfxufy/0006-kernel-h-Add-non_block_start-end-.patch:108: WARNING: Single statement macros should not use a do {} while (0) loop
> #108: FILE: include/linux/kernel.h:255:
> +# define non_block_end() \
> +       do { WARN_ON(current->non_block_count-- == 0); } while (0)
>
> Please use a static inline?

We need get_current() plus the task_struct, so this gets real messy
real fast. Not even sure which header this would fit in, or whether
I'd need to create a new one. You're insisting on this or respinning
with the do { } while (0) dropped ok.

Thanks, Daniel

> Also, can we get one more ack on this patch?
>
> Jason



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
