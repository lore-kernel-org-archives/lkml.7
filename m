Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80FEC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B70206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKNKvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:51:35 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:50173 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:51:34 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MuUSa-1hfAKl2DJ4-00rYbH for <linux-kernel@vger.kernel.org>; Thu, 14 Nov
 2019 11:51:33 +0100
Received: by mail-qk1-f172.google.com with SMTP id d13so4560162qko.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 02:51:33 -0800 (PST)
X-Gm-Message-State: APjAAAX5DlyXsuZ0/YGqludkBZPyCc49t5m2ByHI46sED/X5fyM+oLEM
        qcbTsDz/ZKoEjWjCW9ZHtB3gfy29ljoA0dCSH2c=
X-Google-Smtp-Source: APXvYqxTOH65YOkZmOCh2vwVMW2UO3jkTNotVAvDt36xWQudyigp9ZcfhlZQP9St6NqpTYwvLoFj/R2aLARKcQH4VfU=
X-Received: by 2002:a37:58d:: with SMTP id 135mr6789975qkf.394.1573728692398;
 Thu, 14 Nov 2019 02:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-12-arnd@arndb.de>
 <alpine.DEB.2.21.1911132306070.2507@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911132306070.2507@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Nov 2019 11:51:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a27OV864GfvLK_wjO7dK__r59dZ_dNQACp4G00gJrAwMw@mail.gmail.com>
Message-ID: <CAK8P3a27OV864GfvLK_wjO7dK__r59dZ_dNQACp4G00gJrAwMw@mail.gmail.com>
Subject: Re: [PATCH 21/23] y2038: itimer: change implementation to timespec64
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vukBeNVzwtZZm30evk28O3auuC6LKSPndSBEoaUcs3G9FxvdNCC
 GYhsn/wjDfM2BrY5JZLCX/5VPFmQUDjBLC7Q82vkR2xxWiUGejiodGeL+wXGokOkJzECgry
 Luhm+qhAVryAHw47ysgiOv/BqyJuHbstdHcFZul1HMtG0IrVd9wS9iw1r1nptTNCf8Ukhmu
 p8QFYTEZNIUnMfbMcVmeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mHYJ+46cgrE=:fNN3Yo222EC3yYzjhBgiZy
 AkVYaJwR8la1XIOMzZqsYIs6/VV/4vuvAaUSVMQrUqdG2nG6chJrGHXpdVxJOADR0JCm1Ie87
 2uCqHLb6YchAcQz9YhS43qsT9/1FFnUOFeGY83JP/ogK+uBTk4SmNoj6+ZmiXxcAwqUZvz7G3
 6YOBkZP6lqbx5lEjbhn6HFbAXj6syzAIlHXranY5JzLDgO+va+LGxFj07+RmgQoeS9irvZpJJ
 AkqrD/ov3Jbw8KspA0sz7y6YpRrHp7vlt9MY1xTGc7TGpb6LxI1pTGFal7GyXo8SVntvGt3rL
 ZmuVY+s/xa+r16B42gMsKxaW3nvHk4ho1xfsTy/AQSqcfoQjaKGA4YTTrbv/GbPVP15G7j9/u
 8jq1UfBBAQ0q3au4CrRqatmlwZLw1+gPDGpTRJHAKYsRURT/pd/xkgAvM53zOmXOQgRugdHu5
 5T6uc6SP0Sh4Muhkd+Iw/WOrZwHXdaF9YYVbLqtxrlWkiUeEM9kdqsY+M1v0m83M2vB7POWIA
 ri5n0TArzZnbXD0y3vK7VhxZwwKJBPIIPU3w2YT5rxbNfe56cFVkplmARjNWriWn0E9KIcXvt
 Pp3UCb7keeMmClhgonN7wFCNjXeb9C9VjxPeWSEUiiIL86TNmIZB5ksex/PuYSncZfxS/zh1o
 4QwREGUH8w90wRUKJzTjngqAFdTvZ7XR578A26XpB2G6AKNB3JLpdL3m/HoxO76PjvSdoyCVg
 M9R5jknzW19YVAV/diPgsaZzd/xwvbQ6swS7c8ud3whQVGUomAX2AJqLwDbQysn7xIUnbVKa0
 DLiNxXbcQ+ogskpR2Mr63GXuS5uzys0peZxakzg725l6j3Ff6vJAUDHf334egMkYj+GCZGVfH
 S+cz0XxNnEu8C1aUW/nA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:28 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 8 Nov 2019, Arnd Bergmann wrote:
> > @@ -321,12 +321,12 @@ TRACE_EVENT(itimer_state,
> >               __entry->which          = which;
> >               __entry->expires        = expires;
> >               __entry->value_sec      = value->it_value.tv_sec;
> > -             __entry->value_usec     = value->it_value.tv_usec;
> > +             __entry->value_usec     = value->it_value.tv_nsec / NSEC_PER_USEC;
> >               __entry->interval_sec   = value->it_interval.tv_sec;
> > -             __entry->interval_usec  = value->it_interval.tv_usec;
> > +             __entry->interval_usec  = value->it_interval.tv_nsec / NSEC_PER_USEC;
>
> Hmm, having a division in a tracepoint is clearly suboptimal.

Ok, moving it to the TP_printk() as Steven suggested.

> > -     TP_printk("which=%d expires=%llu it_value=%ld.%ld it_interval=%ld.%ld",
> > +     TP_printk("which=%d expires=%llu it_value=%ld.%06ld it_interval=%ld.%06ld",
>
> We print only 6 digits after the . so that would be even correct w/o a
> division. But it probably does not matter much.

This is just a cosmetic fix, it can be a separate patch if you care. The idea
is to print the numbers as normal decimal representation, e.g. 0.001000
for a millisecond instead of the nonstandard 0.1000.

> > @@ -197,19 +207,13 @@ static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
> >  #define timeval_valid(t) \
> >       (((t)->tv_sec >= 0) && (((unsigned long) (t)->tv_usec) < USEC_PER_SEC))
>
> Hrm, why do we have yet another incarnation of timeval_valid()?

No idea, you have to ask the author of commit 7d99b7d634d8 ("[PATCH]
Validate and
sanitze itimer timeval from userspace") ;-)

> Can we please have only one (the inline version)?

I'm removing the inline version in a later patch along with most of the rest of
include/linux/time32.h.

Having the macro version is convenient for this patch, since I'm using it
on two different structures (itimerval/__kernel_old_timeval and
old_itimerval32/old_timeval32), neither of which is the type used in the
inline function.

I could use two local inline functions instead of the macro, or just open
code both call sites if you prefer that.

      Arnd
