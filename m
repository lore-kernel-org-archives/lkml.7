Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39476C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEE820879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dk/Z/3It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCRMjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:39:21 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36666 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCRMjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:39:20 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so20990137itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byCUQYaJy5lrD7opY2O2OlE1lwVhhrzNcftPfIlycXo=;
        b=dk/Z/3Itwr/DgK3LRuSkUWj4GWwQfQk+17tH348Ui+29dwfIMmJyozVjcI7lgP/Bif
         Vmv2A+g+6wrzG3r6Ow5pCsoInv/YMvWvtykvpeEDUqn/HMmudO1lVysZNfsUJwHe9NbP
         jJ2fOg0gor6qJZxJMiCKTaXGL/veWcURv17uRpDXSWqG0zsqu+onAhzBkZw6hmdxgbQk
         IT799SnMdcM8id7LCZRn4smK1Kxpl3nxddkiTl+fbgne1IaQdsiP5qEccUcAttZ6WV4n
         Fy/JDM6dtmiY8Gydv9sS/Smcbjh2xguvMOpwVmPnNCh9luv6GAGBRon/x4LMnnAQDh8p
         j2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byCUQYaJy5lrD7opY2O2OlE1lwVhhrzNcftPfIlycXo=;
        b=o1hsKJeafYmTRwYM646dbCVycudGKiqPpB9aQ3kEt7box5ZbqgE0mNoqe0LaIVBUmQ
         dUNXg0sDJh/XtTCNMji/0rB2eTPZSckeTsg09SthGLEnzsJ0LDWiMYeAxl+j6lDtOUA7
         TFhH6F4A+zRMETpRpCVcSjW9s2TRUD1akTYqOrVoBuJYgpKK3BoTlVcOuuWXCx9T6gP6
         7ZMbw8xqgvgdsxUFONNopSSsU+71vMwTbvFHUw59nKNCygkCLq+befaeab60wH8cQDFR
         XnBq+rt68BC6bQKN32tqAk4RcruQVOwzE3ZATjJfEjDLIGEBm540GhCPUTRmtG3TWI+B
         c2SQ==
X-Gm-Message-State: APjAAAXqHIpLjH7RY+dHpuacd4KYY1b60DHNDbqMXyaCEfAD3oowAsgR
        4/bH5uH8PEVepo+MCTMNfTbdqNayoQ1ZGzHZDR6wEA==
X-Google-Smtp-Source: APXvYqyQ1GPodSbZbw7MT8J2/TksRsUBMtQVzzCaonfG22gyaLLDrRBU8KTRZ3u/A9iLSECi8aiixZlzbsIDlogq6Ic=
X-Received: by 2002:a02:84ab:: with SMTP id f40mr10258597jai.72.1552912759209;
 Mon, 18 Mar 2019 05:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
 <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
 <201903180527.x2I5RQVp009981@www262.sakura.ne.jp> <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
In-Reply-To: <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Mar 2019 13:39:08 +0100
Message-ID: <CACT4Y+bHJDc17VZhRK4W5_zoEbbe0OO677hi6U-c-oWs+iZNLg@mail.gmail.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 1:32 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Mar 18, 2019 at 1:07 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, Mar 18, 2019 at 6:27 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > Dmitry Vyukov wrote:
> > > > > Then, we need to find what test is changing console_loglevel.
> > > > > Maybe add debug BUG_ON() in linux-next.git using CONFIG_DEBUG_AID_FOR_SYZBOT ?
> > > >
> > > > Is there a single place to catch this? I could run syzkaller locally
> > > > first with the check.
> > > >
> > >
> > > There is no such place. But not so many places change permanently.
> > > For x86, you can test with below patch applied.
> > >
> > > ---
> > >  drivers/tty/sysrq.c    |  1 +
> > >  kernel/printk/printk.c |  3 +++
> > >  kernel/sysctl.c        | 23 ++++++++++++++++++++++-
> > >  3 files changed, 26 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > > index fa0ce7d..ad73520 100644
> > > --- a/drivers/tty/sysrq.c
> > > +++ b/drivers/tty/sysrq.c
> > > @@ -91,6 +91,7 @@ static void sysrq_handle_loglevel(int key)
> > >         i = key - '0';
> > >         console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
> > >         pr_info("Loglevel set to %d\n", i);
> > > +       WARN_ONCE(i < CONSOLE_LOGLEVEL_DEFAULT, "Reducing console_loglevel to %d", i);
> > >         console_loglevel = i;
> > >  }
> > >  static struct sysrq_key_op sysrq_loglevel_op = {
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index 02ca827..70d1f8c 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -1533,11 +1533,13 @@ int do_syslog(int type, char __user *buf, int len, int source)
> > >         case SYSLOG_ACTION_CONSOLE_OFF:
> > >                 if (saved_console_loglevel == LOGLEVEL_DEFAULT)
> > >                         saved_console_loglevel = console_loglevel;
> > > +               WARN_ONCE(minimum_console_loglevel < CONSOLE_LOGLEVEL_DEFAULT, "Reducing console_loglevel to %d", minimum_console_loglevel);
> > >                 console_loglevel = minimum_console_loglevel;
> > >                 break;
> > >         /* Enable logging to console */
> > >         case SYSLOG_ACTION_CONSOLE_ON:
> > >                 if (saved_console_loglevel != LOGLEVEL_DEFAULT) {
> > > +                       WARN_ONCE(saved_console_loglevel < CONSOLE_LOGLEVEL_DEFAULT, "Reducing console_loglevel to %d", saved_console_loglevel);
> > >                         console_loglevel = saved_console_loglevel;
> > >                         saved_console_loglevel = LOGLEVEL_DEFAULT;
> > >                 }
> > > @@ -1548,6 +1550,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
> > >                         return -EINVAL;
> > >                 if (len < minimum_console_loglevel)
> > >                         len = minimum_console_loglevel;
> > > +               WARN_ONCE(len < CONSOLE_LOGLEVEL_DEFAULT, "Reducing console_loglevel to %d", len);
> > >                 console_loglevel = len;
> > >                 /* Implicitly re-enable logging to console */
> > >                 saved_console_loglevel = LOGLEVEL_DEFAULT;
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index b3df3ab..2170421 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -273,6 +273,27 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
> > >  int sysctl_legacy_va_layout;
> > >  #endif
> > >
> > > +static int proc_dointvec_loglevel(struct ctl_table *table, int write,
> > > +                                 void __user *buffer, size_t *lenp, loff_t *ppos)
> > > +{
> > > +       if (write && buffer && *lenp) {
> > > +               size_t len = *lenp;
> > > +               char *kbuf, *p;
> > > +
> > > +               if (len > PAGE_SIZE - 1)
> > > +                       len = PAGE_SIZE - 1;
> > > +               p = kbuf = memdup_user_nul(buffer, len);
> > > +               if (IS_ERR(kbuf))
> > > +                       return PTR_ERR(kbuf);
> > > +               while (*p && (*p < '0' || *p > '9'))
> > > +                       p++;
> > > +               len = *p ? strtoul(p, &p, 10) : CONSOLE_LOGLEVEL_DEFAULT;
> > > +               WARN_ONCE(len < CONSOLE_LOGLEVEL_DEFAULT, "Reducing console_loglevel to %d", (int) len);
> > > +               kfree(kbuf);
> > > +       }
> > > +       return proc_dointvec(table, write, buffer, lenp, ppos);
> > > +}
> > > +
> > >  /* The default sysctl tables: */
> > >
> > >  static struct ctl_table sysctl_base_table[] = {
> > > @@ -839,7 +860,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
> > >                 .data           = &console_loglevel,
> > >                 .maxlen         = 4*sizeof(int),
> > >                 .mode           = 0644,
> > > -               .proc_handler   = proc_dointvec,
> > > +               .proc_handler   = proc_dointvec_loglevel,
> > >         },
> > >         {
> > >                 .procname       = "printk_ratelimit",
> > > --
> > > 1.8.3.1
> >
> >
> > Thanks.
> > Running this for 10 mins I only got a bunch of these, so at least none
> > of these WARNs does not trigger immediately. But I will continue
> > running it.
> >
> > WARNING in schedule_bh
> > kernel BUG at ./include/linux/mm.h:LINE!
> > WARNING in vkms_vblank_simulate
> > general protection fault in xfrmi_decode_session
> > INFO: task hung in corrupted
> > kernel BUG at drivers/android/binder_alloc.c:LINE!
> > BUG: unable to handle kernel NULL pointer dereference in
> > drm_atomic_helper_commit_modeset_disables
> > INFO: task hung in __rq_qos_throttle
> > WARNING in sk_stream_kill_queues
>
>
> Wait, but isn't SYSLOG_ACTION_CONSOLE_LEVEL what we are looking for?
> syzkaller knows about the syslog syscall:
> https://github.com/google/syzkaller/blob/13026d10f09f0e801c342e6c009ff580d49b894b/sys/linux/sys.txt#L322
> and even though it does not know SYSLOG_ACTION_CONSOLE_LEVEL const, it
> can guess that number.

I've restricted fuzzer from invoking SYSLOG_ACTION_CONSOLE_LEVEL.
Let's see if it helps.
