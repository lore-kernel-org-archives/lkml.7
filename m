Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31FA2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0bG+1pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfC1C6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:58:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39173 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC1C6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:58:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id f10so16963838otb.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 19:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpSI6OnXZCLLIwuy8Gv3SdtzWB6luYdaoCxKHcyBJ+4=;
        b=L0bG+1paRaGP/BVlNEM3nuwmkU8vhoyjfFGsdW+6q5DWbQdWZF6Z4IzvasAhhD+S6A
         sJNb47UNmPnkWuuDieiPrJzcZW0WMlzEbC2pvysVKU2kcKTd52ZveBUm2JHrqofkSs/c
         5+b95P6VKsvjJyNslovfZoXCLeNrtfdJK1+FUbTtBpxGlYG03TsPGGtH4A9Q5ij3mObK
         sD/FAt6lEzNG9y2thzucYdKytMdQSBQLHhKr9uVwlCCGeNY7rCxbVMQLdbvhXQtDwgfw
         sbxNO374v7Vdf9ALFusAWU03YyZjO5INYWS3owUzihpZz829gpyefIMIHdXMmOAbph8g
         PFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpSI6OnXZCLLIwuy8Gv3SdtzWB6luYdaoCxKHcyBJ+4=;
        b=mMpM8Cq8l9xtHTth8ll39FOPb9GeiYpSaRzwsxzDLbk4z+gsiqT9DJGmqHH7yBujLR
         4/O3ZnprjqjVC+890ePyUoqHyW3ZIZ6CqRzKD4eb2p2QHdNtWu3LjOlFOjPClKou+bis
         F0ZXfy4S8K9rr2f2b0HZMNp1mj8g2BWkkdskfc2XxfurlUjFizNTGDCzSny38ERN9nVV
         ZhnUHULkNItqi7DFiKQyL6aCCnUamIUE03tFFLbL1LlHb1HTHEf7ehE8k4fcwvOxZYqO
         L1d3y7OnMoA4aOHVK/s989mNLovAMZxj+JFtW1DM4CD46BvZqaGWnr0pY7/KAkTc7cCM
         KAKg==
X-Gm-Message-State: APjAAAWBvmdeU9IJZFdXIq3DDAUnl61gGPnJ4Qk4L+jC7h5VMrd8S51y
        0lD18AdHt9AH89hPp/ue+iOL3UkfmpIXdo5YVq89BQ==
X-Google-Smtp-Source: APXvYqxHYl6cFVHVGgFuoMnNy2NX/G19wXrLUuixWrxQoVrV5Kv/iDPZxm0/4s2FlwL0GkOPDpudya1HyW4qtF/ebUs=
X-Received: by 2002:a05:6830:1216:: with SMTP id r22mr3125227otp.198.1553741890809;
 Wed, 27 Mar 2019 19:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190327145331.215360-1-joel@joelfernandes.org>
 <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
 <CAG48ez1vZ5cngEKVtWTL9rz_K8K25b1sMKYrNs+jn4Va3KYucw@mail.gmail.com> <20190328023432.GA93275@google.com>
In-Reply-To: <20190328023432.GA93275@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Mar 2019 03:57:44 +0100
Message-ID: <CAG48ez2bbSYpNHcC4oucx_AG=5y4K5pZfSOfN3mxGadJGpHuQQ@mail.gmail.com>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
To:     Joel Fernandes <joel@joelfernandes.org>
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

On Thu, Mar 28, 2019 at 3:34 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Thu, Mar 28, 2019 at 01:59:45AM +0100, Jann Horn wrote:
> > On Thu, Mar 28, 2019 at 1:06 AM Kees Cook <keescook@chromium.org> wrote:
> > > On Wed, Mar 27, 2019 at 7:53 AM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > struct pid's count is an atomic_t field used as a refcount. Use
> > > > refcount_t for it which is basically atomic_t but does additional
> > > > checking to prevent use-after-free bugs. No change in behavior if
> > > > CONFIG_REFCOUNT_FULL=n.
> > > >
> > > > Cc: keescook@chromium.org
> > > > Cc: kernel-team@android.com
> > > > Cc: kernel-hardening@lists.openwall.com
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > [...]
> > > > diff --git a/kernel/pid.c b/kernel/pid.c
> > > > index 20881598bdfa..2095c7da644d 100644
> > > > --- a/kernel/pid.c
> > > > +++ b/kernel/pid.c
> > > > @@ -37,7 +37,7 @@
> > > >  #include <linux/init_task.h>
> > > >  #include <linux/syscalls.h>
> > > >  #include <linux/proc_ns.h>
> > > > -#include <linux/proc_fs.h>
> > > > +#include <linux/refcount.h>
> > > >  #include <linux/sched/task.h>
> > > >  #include <linux/idr.h>
> > > >
> > > > @@ -106,8 +106,8 @@ void put_pid(struct pid *pid)
> > > >                 return;
> > > >
> > > >         ns = pid->numbers[pid->level].ns;
> > > > -       if ((atomic_read(&pid->count) == 1) ||
> > > > -            atomic_dec_and_test(&pid->count)) {
> > > > +       if ((refcount_read(&pid->count) == 1) ||
> > > > +            refcount_dec_and_test(&pid->count)) {
> > >
> > > Why is this (and the original code) safe in the face of a race against
> > > get_pid()? i.e. shouldn't this only use refcount_dec_and_test()? I
> > > don't see this code pattern anywhere else in the kernel.
> >
> > Semantically, it doesn't make a difference whether you do this or
> > leave out the "refcount_read(&pid->count) == 1". If you read a 1 from
> > refcount_read(), then you have the only reference to "struct pid", and
> > therefore you want to free it. If you don't get a 1, you have to
> > atomically drop a reference, which, if someone else is concurrently
> > also dropping a reference, may leave you with the last reference (in
> > the case where refcount_dec_and_test() returns true), in which case
> > you still have to take care of freeing it.
>
> Also, based on Kees comment, I think it appears to me that get_pid and
> put_pid can race in this way in the original code right?
>
> get_pid                 put_pid
>
>                         atomic_dec_and_test returns 1

This can't happen. get_pid() can only be called on an existing
reference. If you are calling get_pid() on an existing reference, and
someone else is dropping another reference with put_pid(), then when
both functions start running, the refcount must be at least 2.

> atomic_inc
>                         kfree
>
> deref pid /* boom */
> -------------------------------------------------
>
> I think get_pid needs to call atomic_inc_not_zero() and put_pid should
> not test for pid->count == 1 as condition for freeing, but rather just do
> atomic_dec_and_test. So something like the following diff. (And I see a
> similar pattern used in drivers/net/mac.c)

get_pid() can only be called when you already have a refcounted
reference; in other words, when the reference count is at least one.
The lifetime management of struct pid differs from the lifetime
management of most other objects in the kernel; the usual patterns
don't quite apply here.

Look at put_pid(): When the refcount has reached zero, there is no RCU
grace period (unlike most other objects with RCU-managed lifetimes).
Instead, free_pid() has an RCU grace period *before* it invokes
delayed_put_pid() to drop a reference; and free_pid() is also the
function that removes a PID from the namespace's IDR, and it is used
by __change_pid() when a task loses its reference on a PID.

In other words: Most refcounted objects with RCU guarantee that the
object waits for a grace period after its refcount has reached zero;
and during the grace period, the refcount is zero and you're not
allowed to increment it again. But for struct pid, the guarantee is
instead that there is an RCU grace period after it has been removed
from the IDRs and the task, and during the grace period, refcounting
is guaranteed to still work normally.

> Is the above scenario valid? I didn't see any locking around get_pid or
> pud_pid to avoid such a race.
>
> ---8<-----------------------
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 8cb86d377ff5..3d79834e3180 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -69,8 +69,8 @@ extern struct pid init_struct_pid;
>
>  static inline struct pid *get_pid(struct pid *pid)
>  {
> -       if (pid)
> -               refcount_inc(&pid->count);
> +       if (!pid || !refcount_inc_not_zero(&pid->count))
> +               return NULL;
>         return pid;
>  }

Nope, this is wrong. Once the refcount is zero, the object goes away,
refcount_inc_not_zero() makes no sense here.

>
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 2095c7da644d..89c4849fab5d 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -106,8 +106,7 @@ void put_pid(struct pid *pid)
>                 return;
>
>         ns = pid->numbers[pid->level].ns;
> -       if ((refcount_read(&pid->count) == 1) ||
> -            refcount_dec_and_test(&pid->count)) {
> +       if (refcount_dec_and_test(&pid->count)) {
>                 kmem_cache_free(ns->pid_cachep, pid);
>                 put_pid_ns(ns);
>         }
>
>
