Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22103C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E343922CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MTI+Kanp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfH1S4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:56:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43334 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfH1S4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:56:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so848941otp.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nS9sghIUIPx7g755mVLBuxz1Z71NtFQBCRRvUjCx70o=;
        b=MTI+KanpTuhTrzzLxlbtZ1+swgBPtUkHfSSiiksg4bSXV8X0K5yvq031Ly+YoDSY5V
         ZymtBakgNC8hjLexb5QVq0atw4I+AobGrh1I4snAozgBTC+pTzLQaFbJPhDtNNw9RE4u
         2mRKcWVUunztUfQpODM6eEjC8xJ49wiw3XGFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nS9sghIUIPx7g755mVLBuxz1Z71NtFQBCRRvUjCx70o=;
        b=EVv09dFAPP2ZHRmazqcZaO/qrZe/6d4eKhrBeYMP7DC9vQ90CQIyiJa1zoV4HKYUnp
         4XyFK6JNTUIpdo6h6/Gi9PRI/BdysKKDYRb3hIRTFIqr4A+Zsv33udaFNEzwg5xnVPcA
         1TI6Xj4+bbJhLGnlPfbo5BfQ4Lb/ywMKIV2GCaRvCcYwjwSlAL96YdhjFsXbTXDlDTgF
         VRg8s1GEokOQ9fSCYYVRkaeARB+wc9/OR/Xvg35FUSdJCE97N0MKMiASL/r/5jOB66Lc
         y145theWCZ9IRVVZoR9KfXngHrYMx00vRaZBIsOBQIzV7DoNr/6wr8MIJ3MFhj587y+b
         uZAQ==
X-Gm-Message-State: APjAAAUGfP9oT6CcXG3CEy1IvS9XiQ9Jx5TJ9dw9J/LlvO+YWgYyGNWK
        U8szx6tGn4qvbqKSsiZYaJqz4ag+z3/G89K2kf1tGw==
X-Google-Smtp-Source: APXvYqyggOyk01nC8FZIwN+CbjL/bjhI1aZtVdsQYi3h4hYy3se1Usiy90hGVxmIIjB8FzpqdJKGP5apV2lekxdVIBg=
X-Received: by 2002:a9d:6955:: with SMTP id p21mr283847oto.204.1567018610863;
 Wed, 28 Aug 2019 11:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
 <20190826201425.17547-4-daniel.vetter@ffwll.ch> <20190827225002.GB30700@ziepe.ca>
 <CAKMK7uHKiLwXLHd1xThZVM1dH-oKrtpDZ=FxLBBwtY7XmJKgtA@mail.gmail.com> <20190828184330.GD933@ziepe.ca>
In-Reply-To: <20190828184330.GD933@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 28 Aug 2019 20:56:39 +0200
Message-ID: <CAKMK7uFJESH1XHTCqYoDb4iMfThxnib3Uz=RUcd7h=SS-TJWbg@mail.gmail.com>
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

On Wed, Aug 28, 2019 at 8:43 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Aug 28, 2019 at 08:33:13PM +0200, Daniel Vetter wrote:
> > On Wed, Aug 28, 2019 at 12:50 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > > > index 4fa360a13c1e..82f84cfe372f 100644
> > > > +++ b/include/linux/kernel.h
> > > > @@ -217,7 +217,9 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
> > > >   * might_sleep - annotation for functions that can sleep
> > > >   *
> > > >   * this macro will print a stack trace if it is executed in an atomic
> > > > - * context (spinlock, irq-handler, ...).
> > > > + * context (spinlock, irq-handler, ...). Additional sections where blocking is
> > > > + * not allowed can be annotated with non_block_start() and non_block_end()
> > > > + * pairs.
> > > >   *
> > > >   * This is a useful debugging help to be able to catch problems early and not
> > > >   * be bitten later when the calling function happens to sleep when it is not
> > > > @@ -233,6 +235,25 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
> > > >  # define cant_sleep() \
> > > >       do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
> > > >  # define sched_annotate_sleep()      (current->task_state_change = 0)
> > > > +/**
> > > > + * non_block_start - annotate the start of section where sleeping is prohibited
> > > > + *
> > > > + * This is on behalf of the oom reaper, specifically when it is calling the mmu
> > > > + * notifiers. The problem is that if the notifier were to block on, for example,
> > > > + * mutex_lock() and if the process which holds that mutex were to perform a
> > > > + * sleeping memory allocation, the oom reaper is now blocked on completion of
> > > > + * that memory allocation. Other blocking calls like wait_event() pose similar
> > > > + * issues.
> > > > + */
> > > > +# define non_block_start() \
> > > > +     do { current->non_block_count++; } while (0)
> > > > +/**
> > > > + * non_block_end - annotate the end of section where sleeping is prohibited
> > > > + *
> > > > + * Closes a section opened by non_block_start().
> > > > + */
> > > > +# define non_block_end() \
> > > > +     do { WARN_ON(current->non_block_count-- == 0); } while (0)
> > >
> > > check-patch does not like these, and I agree
> > >
> > > #101: FILE: include/linux/kernel.h:248:
> > > +# define non_block_start() \
> > > +       do { current->non_block_count++; } while (0)
> > >
> > > /tmp/tmp1spfxufy/0006-kernel-h-Add-non_block_start-end-.patch:108: WARNING: Single statement macros should not use a do {} while (0) loop
> > > #108: FILE: include/linux/kernel.h:255:
> > > +# define non_block_end() \
> > > +       do { WARN_ON(current->non_block_count-- == 0); } while (0)
> > >
> > > Please use a static inline?
> >
> > We need get_current() plus the task_struct, so this gets real messy
> > real fast. Not even sure which header this would fit in, or whether
> > I'd need to create a new one. You're insisting on this or respinning
> > with the do { } while (0) dropped ok.
>
> My prefernce is always a static inline, but if the headers are so
> twisty we need to use #define to solve a missing include, then I
> wouldn't insist on it.

Cleanest would be a new header I guess, together with might_sleep().
But moving that is a bit much I think, there's almost 500 callers of
that one from a quick git grep

> If dropping do while is the only change then I can edit it in..
> I think we have the acks now

Yeah sounds simplest, thanks.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
