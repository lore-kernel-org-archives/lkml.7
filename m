Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F5C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478EE22B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbiayEhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfLLG5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 01:57:38 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36134 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfLLG5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 01:57:37 -0500
Received: by mail-yb1-f193.google.com with SMTP id i72so94088ybg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 22:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ax2ZUv3ImSrASpu/ZSBPTJ2sk/mbghRo8ZpVw2jpKxI=;
        b=KbiayEhiIFcWZKYx7nfN2WA2VlPQM+BYTCvl5HhXzsozSBzvhVwP0560df0XhVcSDv
         2gXROBRO427WyQExSULqmEvjMUrQhWfVjO2ZBsyjj46QMB/ZFtB3ORKq9mzhuJdvhilk
         6QGw2wqD9fibCvKKTdTR4+Ra8LnoZcU9YUFIA3Y80Y3WRxDIgKfN5dOV+hNGb3d8Vg1Y
         yqmf06PR17LyOMfXs08XmqAQgK9Yra8YJn3BmRbvFxhZZ6HGLmeRSZKvtQO83EdmHMEJ
         nERx9nlFoz5vyPrtL6CUROUucOm3S2SyOWveOILM9u6SiWJF/TwugJRxNln21zNcKcfN
         0Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ax2ZUv3ImSrASpu/ZSBPTJ2sk/mbghRo8ZpVw2jpKxI=;
        b=O1CY0DQgnD6OtDXaDEFrqeDU/2YNmrWDsqfS8YkaJUJih3wv/8SMjb/6SJCAc0V7/4
         4Gw7/FiP6loj4DtD7+eJj2HLdO6He+gsqFyfeblo1WAfWtBq8+aJPZGH+bxjqk+KhUzE
         onfBwVJ1YiPOjW04wVRqAAEusn33ehOFzmB8nr4x5oEFNQ5zX5M9cvAz+xwYl/siCSkJ
         5f5MMAvGFZwgfflh5aPf+I1fPQLb59awgMGYKeHmSD7YTiC87mtzRqG8l1poswNW4sal
         8kEKUGlYdMDsfv2qN66RU2OAy5E5DDn99gt0yX2nI8HiYG0Z8NszIEFA1pgaSl6ozWF2
         1tmw==
X-Gm-Message-State: APjAAAXD741UxTi+/0gBz0CZ7kAm4h9xSVy9EsCEZSuDxfi0VS6/euLF
        AzvNU0qcD2uB3AQmNjKLMvW9P7wlGtCtYKDCt2Fm6A==
X-Google-Smtp-Source: APXvYqwtXIU/dyM4LL0wK+yyusaZGouq9tBOLJdmxizFBEz0CJS88YT+Rzs8WN/Twudg6RyU/fw5+gMAwAYQ/IGihyE=
X-Received: by 2002:a25:60c6:: with SMTP id u189mr3154886ybb.173.1576133855768;
 Wed, 11 Dec 2019 22:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20191212160622.021517d3@canb.auug.org.au> <20191212060200.GW2889@paulmck-ThinkPad-P72>
 <CANn89iKJhsMLUBNbkXSr1+t+38POFU8jWrP+tU3JWLjs__HuPw@mail.gmail.com>
In-Reply-To: <CANn89iKJhsMLUBNbkXSr1+t+38POFU8jWrP+tU3JWLjs__HuPw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 11 Dec 2019 22:57:24 -0800
Message-ID: <CANn89i+xomdo4HFqewrfNf_Z4Q5ayXuW6A4SjSkE46JXP9KuFw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the rcu tree
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:38 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Dec 11, 2019 at 10:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Dec 12, 2019 at 04:06:22PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > After merging the rcu (I think) tree, today's linux-next build (x86_64
> > > allnoconfig) produced this warning:
> > >
> > > kernel/time/timer.c: In function 'schedule_timeout':
> > > kernel/time/timer.c:969:20: warning: 'timer.expires' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >   969 |   long diff = timer->expires - expires;
> > >       |               ~~~~~^~~~~~~~~
> > >
> > > Introduced by (bisected to) commit
> > >
> > >   c4127fce1d02 ("timer: Use hlist_unhashed_lockless() in timer_pending()")
> > >
> > > x86_64-linux-gnu-gcc (Debian 9.2.1-21) 9.2.1 20191130
> >
> > Well, if the timer is pending, then ->expires has to have been
> > initialized, but off where the compiler cannot see it, such as during a
> > previous call to __mod_timer().  And the change may have made it harder
> > for the compiler to see all of these relationships, but...
> >
> > I don't see this warning with gcc version 7.4.0.  Just out of curiosity,
> > what are you running, Stephen?
> >
> > Eric, any thoughts for properly educating the compiler on this one?
>
> Ah... the READ_ONCE() apparently turns off the compiler ability to
> infer that this branch should not be taken.
>
> Since __mod_timer() is inlined we could perhaps add a new option
>
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 4820823515e9..8bbce552568b 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -944,6 +944,7 @@ static struct timer_base *lock_timer_base(struct
> timer_list *timer,
>
>  #define MOD_TIMER_PENDING_ONLY         0x01
>  #define MOD_TIMER_REDUCE               0x02
> +#define MOD_TIMER_NOTPENDING           0x04
>
>  static inline int
>  __mod_timer(struct timer_list *timer, unsigned long expires, unsigned
> int options)
> @@ -960,7 +961,7 @@ __mod_timer(struct timer_list *timer, unsigned
> long expires, unsigned int option
>          * the timer is re-modified to have the same timeout or ends up in the
>          * same array bucket then just return:
>          */
> -       if (timer_pending(timer)) {
> +       if (!(options & MOD_TIMER_NOTPENDING) && timer_pending(timer)) {
>                 /*
>                  * The downside of this optimization is that it can result in
>                  * larger granularity than you would get from adding a new
> @@ -1891,7 +1892,7 @@ signed long __sched schedule_timeout(signed long timeout)
>
>         timer.task = current;
>         timer_setup_on_stack(&timer.timer, process_timeout, 0);
> -       __mod_timer(&timer.timer, expire, 0);
> +       __mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
>         schedule();
>         del_singleshot_timer_sync(&timer.timer);


Also add_timer() can benefit from the same hint, since it seems inlined as well.

(untested patch)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823515e9..568564ae3597 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -944,6 +944,7 @@ static struct timer_base *lock_timer_base(struct
timer_list *timer,

 #define MOD_TIMER_PENDING_ONLY         0x01
 #define MOD_TIMER_REDUCE               0x02
+#define MOD_TIMER_NOTPENDING           0x04

 static inline int
 __mod_timer(struct timer_list *timer, unsigned long expires, unsigned
int options)
@@ -960,7 +961,7 @@ __mod_timer(struct timer_list *timer, unsigned
long expires, unsigned int option
         * the timer is re-modified to have the same timeout or ends up in the
         * same array bucket then just return:
         */
-       if (timer_pending(timer)) {
+       if (!(options & MOD_TIMER_NOTPENDING) && timer_pending(timer)) {
                /*
                 * The downside of this optimization is that it can result in
                 * larger granularity than you would get from adding a new
@@ -1133,7 +1134,7 @@ EXPORT_SYMBOL(timer_reduce);
 void add_timer(struct timer_list *timer)
 {
        BUG_ON(timer_pending(timer));
-       mod_timer(timer, timer->expires);
+       __mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
 }
 EXPORT_SYMBOL(add_timer);

@@ -1891,7 +1892,7 @@ signed long __sched schedule_timeout(signed long timeout)

        timer.task = current;
        timer_setup_on_stack(&timer.timer, process_timeout, 0);
-       __mod_timer(&timer.timer, expire, 0);
+       __mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
        schedule();
        del_singleshot_timer_sync(&timer.timer);
