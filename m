Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA91C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0431D2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pgbuLrOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfC1UA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:00:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39546 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfC1UA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:00:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so5448196plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l4OXWYTQIq864f83sjGFJZxSf2xNN5tMm6PvqAXI1LE=;
        b=pgbuLrOISsBiuUZbksBxinTCDw00UPqJTBAgWo53KMCXcveZr/Yu10xKIvUPFHTUcz
         NVct/jSspa/sPtOfTtbWAfazqUJJu2a78CBBPN7smbqNbsm+bEKUiWF16slDt89kGPJP
         fXOY7ZI6GR10fTzojsMFRIk4oH20S0TNNq3fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l4OXWYTQIq864f83sjGFJZxSf2xNN5tMm6PvqAXI1LE=;
        b=En+kX9u5OSsnktUB+hWPo3dFr4rNLJgeBZGt6PjMpNqR8fUgdHEaromufgjvnSpMUC
         FYvdqSnm0Oojr0jm99GqddccnUwWAnCGJzGnxPimDnMx0e7BPAOeJlztVZM8VaIfJAkr
         zBO9RWSNkqcaFFEBpYsx2TnS6/WruIb2DD4JSIu2IKn6IWTqFtoJX+Y4i27rrSO/TtPP
         fCZhJ0/i7xY0TNsy/Z29SJCoLrJDWpuf3JXE4W5VTQdd8IF8HwiJ87RMOW+KdAFCx6e7
         xOEzrHjF0wWjH5HpeGZEWm9zp1xg7wVHwRx5tBM4LGb8hE+mCyfexcn5mPf/5i2nUO2d
         NBXw==
X-Gm-Message-State: APjAAAWKMO472/DBZw7psy1ziUy3fgzDtWR/ErWXB27w+pIFFGEFilE3
        RplOHFOA2fXJxiCrd9pfwuhGsA==
X-Google-Smtp-Source: APXvYqwAFsvhAb76H5HASPWM5AYjb7R9zZwrxXboizpfJGrJDszGQp9aQKPm/TVlvZmOe1P0U/wB/w==
X-Received: by 2002:a17:902:168:: with SMTP id 95mr45581553plb.212.1553803255611;
        Thu, 28 Mar 2019 13:00:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n1sm28254pgv.19.2019.03.28.13.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 13:00:53 -0700 (PDT)
Date:   Thu, 28 Mar 2019 16:00:52 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jann Horn <jannh@google.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
Message-ID: <20190328200052.GA105221@google.com>
References: <20190327145331.215360-1-joel@joelfernandes.org>
 <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
 <CAG48ez1vZ5cngEKVtWTL9rz_K8K25b1sMKYrNs+jn4Va3KYucw@mail.gmail.com>
 <20190328023432.GA93275@google.com>
 <CAG48ez2bbSYpNHcC4oucx_AG=5y4K5pZfSOfN3mxGadJGpHuQQ@mail.gmail.com>
 <20190328143738.GA261521@google.com>
 <CAG48ez1-3dLvzQoxxoUzTUq8dc1wwvwPBBxX_X9FWMscWTS-FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1-3dLvzQoxxoUzTUq8dc1wwvwPBBxX_X9FWMscWTS-FQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:17:50PM +0100, Jann Horn wrote:
> Since we're just talking about RCU stuff now, adding Paul McKenney to
> the thread.
> 
> On Thu, Mar 28, 2019 at 3:37 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Thu, Mar 28, 2019 at 03:57:44AM +0100, Jann Horn wrote:
> > > On Thu, Mar 28, 2019 at 3:34 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > On Thu, Mar 28, 2019 at 01:59:45AM +0100, Jann Horn wrote:
> > > > > On Thu, Mar 28, 2019 at 1:06 AM Kees Cook <keescook@chromium.org> wrote:
> > > > > > On Wed, Mar 27, 2019 at 7:53 AM Joel Fernandes (Google)
> > > > > > <joel@joelfernandes.org> wrote:
> > > > > > >
> > > > > > > struct pid's count is an atomic_t field used as a refcount. Use
> > > > > > > refcount_t for it which is basically atomic_t but does additional
> > > > > > > checking to prevent use-after-free bugs. No change in behavior if
> > > > > > > CONFIG_REFCOUNT_FULL=n.
> > > > > > >
> > > > > > > Cc: keescook@chromium.org
> > > > > > > Cc: kernel-team@android.com
> > > > > > > Cc: kernel-hardening@lists.openwall.com
> > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > [...]
> > > > > > > diff --git a/kernel/pid.c b/kernel/pid.c
> > > > > > > index 20881598bdfa..2095c7da644d 100644
> > > > > > > --- a/kernel/pid.c
> > > > > > > +++ b/kernel/pid.c
> > > > > > > @@ -37,7 +37,7 @@
> > > > > > >  #include <linux/init_task.h>
> > > > > > >  #include <linux/syscalls.h>
> > > > > > >  #include <linux/proc_ns.h>
> > > > > > > -#include <linux/proc_fs.h>
> > > > > > > +#include <linux/refcount.h>
> > > > > > >  #include <linux/sched/task.h>
> > > > > > >  #include <linux/idr.h>
> > > > > > >
> > > > > > > @@ -106,8 +106,8 @@ void put_pid(struct pid *pid)
> > > > > > >                 return;
> > > > > > >
> > > > > > >         ns = pid->numbers[pid->level].ns;
> > > > > > > -       if ((atomic_read(&pid->count) == 1) ||
> > > > > > > -            atomic_dec_and_test(&pid->count)) {
> > > > > > > +       if ((refcount_read(&pid->count) == 1) ||
> > > > > > > +            refcount_dec_and_test(&pid->count)) {
> > > > > >
> > > > > > Why is this (and the original code) safe in the face of a race against
> > > > > > get_pid()? i.e. shouldn't this only use refcount_dec_and_test()? I
> > > > > > don't see this code pattern anywhere else in the kernel.
> > > > >
> > > > > Semantically, it doesn't make a difference whether you do this or
> > > > > leave out the "refcount_read(&pid->count) == 1". If you read a 1 from
> > > > > refcount_read(), then you have the only reference to "struct pid", and
> > > > > therefore you want to free it. If you don't get a 1, you have to
> > > > > atomically drop a reference, which, if someone else is concurrently
> > > > > also dropping a reference, may leave you with the last reference (in
> > > > > the case where refcount_dec_and_test() returns true), in which case
> > > > > you still have to take care of freeing it.
> > > >
> > > > Also, based on Kees comment, I think it appears to me that get_pid and
> > > > put_pid can race in this way in the original code right?
> > > >
> > > > get_pid                 put_pid
> > > >
> > > >                         atomic_dec_and_test returns 1
> > >
> > > This can't happen. get_pid() can only be called on an existing
> > > reference. If you are calling get_pid() on an existing reference, and
> > > someone else is dropping another reference with put_pid(), then when
> > > both functions start running, the refcount must be at least 2.
> >
> > Sigh, you are right. Ok. I was quite tired last night when I wrote this.
> > Obviously, I should have waited a bit and thought it through.
> >
> > Kees can you describe more the race you had in mind?
> >
> > > > atomic_inc
> > > >                         kfree
> > > >
> > > > deref pid /* boom */
> > > > -------------------------------------------------
> > > >
> > > > I think get_pid needs to call atomic_inc_not_zero() and put_pid should
> > > > not test for pid->count == 1 as condition for freeing, but rather just do
> > > > atomic_dec_and_test. So something like the following diff. (And I see a
> > > > similar pattern used in drivers/net/mac.c)
> > >
> > > get_pid() can only be called when you already have a refcounted
> > > reference; in other words, when the reference count is at least one.
> > > The lifetime management of struct pid differs from the lifetime
> > > management of most other objects in the kernel; the usual patterns
> > > don't quite apply here.
> > >
> > > Look at put_pid(): When the refcount has reached zero, there is no RCU
> > > grace period (unlike most other objects with RCU-managed lifetimes).
> > > Instead, free_pid() has an RCU grace period *before* it invokes
> > > delayed_put_pid() to drop a reference; and free_pid() is also the
> > > function that removes a PID from the namespace's IDR, and it is used
> > > by __change_pid() when a task loses its reference on a PID.
> > >
> > > In other words: Most refcounted objects with RCU guarantee that the
> > > object waits for a grace period after its refcount has reached zero;
> > > and during the grace period, the refcount is zero and you're not
> > > allowed to increment it again.
> >
> > Can you give an example of this "most refcounted objects with RCU" usecase?
> > I could not find any good examples of such. I want to document this pattern
> > and possibly submit to Documentation/RCU.
> 
> E.g. struct posix_acl is a relatively straightforward example:
> posix_acl_release() is a wrapper around refcount_dec_and_test(); if
> the refcount has dropped to zero, the object is released after an RCU
> grace period using kfree_rcu().
> get_cached_acl() takes an RCU read lock, does rcu_dereference() [with
> a missing __rcu annotation, grmbl], and attempts to take a reference
> with refcount_inc_not_zero().

Ok I get it now. It is quite a subtle difference in usage, I have noted both
these usecases in my private notes for my own sanity ;-). I wonder if Paul
thinks this is too silly to document into Documentation/RCU/, or if I should
write-up something.

One thing I wonder is if one usage pattern is faster than the other.
Certainly in the {get,put}_pid case, it seems nice to be able to do a
get_pid even though free_pid's grace period has still not completed. Where as
in the posix_acl case, once the grace period starts then it is no longer
possible to get a reference as you pointed and its basically game-over for
that object.

thank you!

 - Joel

