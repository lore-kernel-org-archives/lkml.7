Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ABEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D5A20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJ1kv386"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfC1PSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:18:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35711 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfC1PSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:18:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id m10so11056767otp.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRuZM9Zb9jpMpm2OAU4z55LvnMQhzwW5ETdoBhBcgFk=;
        b=PJ1kv386CMXVG6VYkQyEn2+k56bZac8+HUiFXV0vd1/Czlsnzf5FsHTHX2BTghctbl
         Xq1GoTESVz2pdEp+z73y/WLtQM0pZcUmrXoBAYQmYWnOmByXaeU4LXFz3n1ey99n10oX
         XU59k9LreBBioGDtf4zLrFDeG5WtgrY5nLYONX03OWt8bRLwnuxeqwywNU/Aahg4pvJF
         xI6Zg3XOsZqeKiAg3G2jAfyNnsn0hywDxNLF4gpPjJVZGZgnYKQ/JjK11xaxSEGr3tid
         uU1G+45APNXGsIm1zJpb+gajkGqUt7NweihfdbrZm9BgjPE4oJxodVCxo7rI8yKJRQ0/
         qQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRuZM9Zb9jpMpm2OAU4z55LvnMQhzwW5ETdoBhBcgFk=;
        b=py6oAE8dgOAOS1nRT7C16s2tqG/6afgC3mC6nd07NHDnaHqwUlK0AfZUYxq8ep8uB5
         XgbfAwqeIgDcf9sK8sFQh227SfO2bJ/A9cFaOHZTVSFs490OPeBzAWN3DRLtLGmdRfpv
         VSVNjJy3WzXbsx6IJiYdPOyPDeaHVnOMyzq79wIhLZcop6oQKeyz6O5ZP2JC1wImEoWR
         vhU9H3ATKfdBeUR9j56MZkLJ802k0eGKoml5L2jerSDZxWwwSnoE7DBCM7VwzcItoKNc
         hqCu5j2hcYBoPjpBQB1K4FcpkzR6KcqhkbHfKoYdnPJ18WS4i3CHURBAWZjN6A/NuvdS
         1gGw==
X-Gm-Message-State: APjAAAXdGMPROtRC8m313SFrUuJaMVrDaQ+XrUEiyu0d1uhtVg+hFnGG
        TZzIZT7LFiUVODLYc0sctHAHsruL6W1p/FfH/1BrmA==
X-Google-Smtp-Source: APXvYqzVk2qNG4K9oAkQ451iIBbTECHxGPy/E2eCbaV5R/JOPoGQ44pzpCWX8JoJ9j3vJxuqpNFgR8M85QMlGkgMDys=
X-Received: by 2002:a9d:309:: with SMTP id 9mr30011404otv.230.1553786296153;
 Thu, 28 Mar 2019 08:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190327145331.215360-1-joel@joelfernandes.org>
 <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
 <CAG48ez1vZ5cngEKVtWTL9rz_K8K25b1sMKYrNs+jn4Va3KYucw@mail.gmail.com>
 <20190328023432.GA93275@google.com> <CAG48ez2bbSYpNHcC4oucx_AG=5y4K5pZfSOfN3mxGadJGpHuQQ@mail.gmail.com>
 <20190328143738.GA261521@google.com>
In-Reply-To: <20190328143738.GA261521@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Mar 2019 16:17:50 +0100
Message-ID: <CAG48ez1-3dLvzQoxxoUzTUq8dc1wwvwPBBxX_X9FWMscWTS-FQ@mail.gmail.com>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're just talking about RCU stuff now, adding Paul McKenney to
the thread.

On Thu, Mar 28, 2019 at 3:37 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Thu, Mar 28, 2019 at 03:57:44AM +0100, Jann Horn wrote:
> > On Thu, Mar 28, 2019 at 3:34 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > On Thu, Mar 28, 2019 at 01:59:45AM +0100, Jann Horn wrote:
> > > > On Thu, Mar 28, 2019 at 1:06 AM Kees Cook <keescook@chromium.org> wrote:
> > > > > On Wed, Mar 27, 2019 at 7:53 AM Joel Fernandes (Google)
> > > > > <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > struct pid's count is an atomic_t field used as a refcount. Use
> > > > > > refcount_t for it which is basically atomic_t but does additional
> > > > > > checking to prevent use-after-free bugs. No change in behavior if
> > > > > > CONFIG_REFCOUNT_FULL=n.
> > > > > >
> > > > > > Cc: keescook@chromium.org
> > > > > > Cc: kernel-team@android.com
> > > > > > Cc: kernel-hardening@lists.openwall.com
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > [...]
> > > > > > diff --git a/kernel/pid.c b/kernel/pid.c
> > > > > > index 20881598bdfa..2095c7da644d 100644
> > > > > > --- a/kernel/pid.c
> > > > > > +++ b/kernel/pid.c
> > > > > > @@ -37,7 +37,7 @@
> > > > > >  #include <linux/init_task.h>
> > > > > >  #include <linux/syscalls.h>
> > > > > >  #include <linux/proc_ns.h>
> > > > > > -#include <linux/proc_fs.h>
> > > > > > +#include <linux/refcount.h>
> > > > > >  #include <linux/sched/task.h>
> > > > > >  #include <linux/idr.h>
> > > > > >
> > > > > > @@ -106,8 +106,8 @@ void put_pid(struct pid *pid)
> > > > > >                 return;
> > > > > >
> > > > > >         ns = pid->numbers[pid->level].ns;
> > > > > > -       if ((atomic_read(&pid->count) == 1) ||
> > > > > > -            atomic_dec_and_test(&pid->count)) {
> > > > > > +       if ((refcount_read(&pid->count) == 1) ||
> > > > > > +            refcount_dec_and_test(&pid->count)) {
> > > > >
> > > > > Why is this (and the original code) safe in the face of a race against
> > > > > get_pid()? i.e. shouldn't this only use refcount_dec_and_test()? I
> > > > > don't see this code pattern anywhere else in the kernel.
> > > >
> > > > Semantically, it doesn't make a difference whether you do this or
> > > > leave out the "refcount_read(&pid->count) == 1". If you read a 1 from
> > > > refcount_read(), then you have the only reference to "struct pid", and
> > > > therefore you want to free it. If you don't get a 1, you have to
> > > > atomically drop a reference, which, if someone else is concurrently
> > > > also dropping a reference, may leave you with the last reference (in
> > > > the case where refcount_dec_and_test() returns true), in which case
> > > > you still have to take care of freeing it.
> > >
> > > Also, based on Kees comment, I think it appears to me that get_pid and
> > > put_pid can race in this way in the original code right?
> > >
> > > get_pid                 put_pid
> > >
> > >                         atomic_dec_and_test returns 1
> >
> > This can't happen. get_pid() can only be called on an existing
> > reference. If you are calling get_pid() on an existing reference, and
> > someone else is dropping another reference with put_pid(), then when
> > both functions start running, the refcount must be at least 2.
>
> Sigh, you are right. Ok. I was quite tired last night when I wrote this.
> Obviously, I should have waited a bit and thought it through.
>
> Kees can you describe more the race you had in mind?
>
> > > atomic_inc
> > >                         kfree
> > >
> > > deref pid /* boom */
> > > -------------------------------------------------
> > >
> > > I think get_pid needs to call atomic_inc_not_zero() and put_pid should
> > > not test for pid->count == 1 as condition for freeing, but rather just do
> > > atomic_dec_and_test. So something like the following diff. (And I see a
> > > similar pattern used in drivers/net/mac.c)
> >
> > get_pid() can only be called when you already have a refcounted
> > reference; in other words, when the reference count is at least one.
> > The lifetime management of struct pid differs from the lifetime
> > management of most other objects in the kernel; the usual patterns
> > don't quite apply here.
> >
> > Look at put_pid(): When the refcount has reached zero, there is no RCU
> > grace period (unlike most other objects with RCU-managed lifetimes).
> > Instead, free_pid() has an RCU grace period *before* it invokes
> > delayed_put_pid() to drop a reference; and free_pid() is also the
> > function that removes a PID from the namespace's IDR, and it is used
> > by __change_pid() when a task loses its reference on a PID.
> >
> > In other words: Most refcounted objects with RCU guarantee that the
> > object waits for a grace period after its refcount has reached zero;
> > and during the grace period, the refcount is zero and you're not
> > allowed to increment it again.
>
> Can you give an example of this "most refcounted objects with RCU" usecase?
> I could not find any good examples of such. I want to document this pattern
> and possibly submit to Documentation/RCU.

E.g. struct posix_acl is a relatively straightforward example:
posix_acl_release() is a wrapper around refcount_dec_and_test(); if
the refcount has dropped to zero, the object is released after an RCU
grace period using kfree_rcu().
get_cached_acl() takes an RCU read lock, does rcu_dereference() [with
a missing __rcu annotation, grmbl], and attempts to take a reference
with refcount_inc_not_zero().

> > But for struct pid, the guarantee is
> > instead that there is an RCU grace period after it has been removed
> > from the IDRs and the task, and during the grace period, refcounting
> > is guaranteed to still work normally.
>
> Ok, thanks. Here I think in scrappy but simple pseudo code form, the struct
> pid flow is something like (replaced "pid" with data");
>
> get_data:
>         atomic_inc(data->refcount);
>
> some_user_of_data:
>         rcu_read_lock();
>         From X, obtain a ptr to data using rcu_dereference.
>         get_data(data);
>         rcu_read_unlock();
>
> free_data:
>         remove all references to data in all places in X
>         call_rcu(put_data)
>
> put_data:
>         if (atomic_dec_and_test(data->refcount)) {
>                 free(data);
>         }
>
> create_data:
>         data = alloc(..)
>         atomic_set(data->refcount, 1);
>         set pointers to data in X.
>
> > > pud_pid to avoid such a race.
> > >
> > > ---8<-----------------------
> > >
> > > diff --git a/include/linux/pid.h b/include/linux/pid.h
> > > index 8cb86d377ff5..3d79834e3180 100644
> > > --- a/include/linux/pid.h
> > > +++ b/include/linux/pid.h
> > > @@ -69,8 +69,8 @@ extern struct pid init_struct_pid;
> > >
> > >  static inline struct pid *get_pid(struct pid *pid)
> > >  {
> > > -       if (pid)
> > > -               refcount_inc(&pid->count);
> > > +       if (!pid || !refcount_inc_not_zero(&pid->count))
> > > +               return NULL;
> > >         return pid;
> > >  }
> >
> > Nope, this is wrong. Once the refcount is zero, the object goes away,
> > refcount_inc_not_zero() makes no sense here.
>
> Yeah ok, I think what you meant here is that references to the object from
> all places go away before the grace period starts, so a get_pid on an object
> with refcount of zero is impossible since there's no way to *get* to that
> object after the grace-period ends.
>
> So, yes you are right that refcount_inc is all that's needed.
>
> Also note to the on looker, the original patch I sent is not wrong, that
> still applies and is correct. We are just discussing here any possible issues
> with the *existing* code.
>
> thanks!
>
>  - Joel
>
