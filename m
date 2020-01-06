Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9AAC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59B321734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGJ8Tlbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgAFCo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 21:44:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45643 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgAFCo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 21:44:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id j26so49385359ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 18:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJ6NnJ62Ooy0R7oKnZwCGJ6TP+B7lDV4YY3gww3T+5A=;
        b=cGJ8Tlbn5Zm6sAd9Ge3FLpPmdJEV2m0sb8BmR8sd9/qxw8tTGQv5jXGE8EGBsEPf+T
         FG4QttkkHtHjD6tlyUs3YQ1ONi4L7RXr1tLq0JKPgbMp6ViTlmIAwmDIZzLeEuoCNkHd
         5SekrxSlM1XXaPnvgTy8W41g+h5KT4K0bL+qIDgIUtcbncxgiUa6cRE3osDpjyx3+QBv
         nAU629l9qe/zLps7fSPmxtvXJ5Lc1tVbW901mMwd8XdAWRTBxRIsxLajq45f4V7fRWsR
         3aiOS7wube5jzgAkWmrLZprYM4VGPET4YpA4reUDJRRNYsWqvoEBotR5xZPvITfla08Y
         b+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJ6NnJ62Ooy0R7oKnZwCGJ6TP+B7lDV4YY3gww3T+5A=;
        b=ooxi0FMp9LHihHHygOiitiaS64skMkELk921VUIA8k0MSunA5wS2u+M8LQ2G/aetYm
         5IdIX00guQOasMtg6Q3XktImIpz2WEpa9TY1WRrmFgfIF1IJt1yoGicHiJK9NfVTtbm3
         P4kquoCFv68wQIbwEISFZ9LxdNx1Neg8Qv0/2hMX0Y++A5Hz59EIRkzPyUzyz7hzlYa/
         gMq/vpfFgiH7YN7HHdT/j1FpSBPlVuJxMg0htCD3FaQ0ZAGH77+VK2XIAEAGIdE7qQHG
         qyWFj/S30kqfarKBPBTV7oU/SyRRPb3BJwUWEEl6LrpB47YHHxaSghH9BbcHnLG/UM6z
         NWWg==
X-Gm-Message-State: APjAAAW5pn3Q+FYhQ2XBrSxaS3Tjw4I0y8+1K7yMZtvakisjZfTrrurK
        B/xURznz2XsjLEBoaaOSpX0EHE9zHZpX3Lpc6PI=
X-Google-Smtp-Source: APXvYqz9F0DanMxLlAiQihmjNjGN32KdoklMXuCltP5PAiwO31XHFtP43qWOcpZPJ/PU/bHDmxwD7XgNeiaAVv5yPA8=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr41069438ljg.69.1578278694242;
 Sun, 05 Jan 2020 18:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20200103034541.5302-1-zhenzhong.duan@gmail.com> <20200103084339.GA855576@kroah.com>
In-Reply-To: <20200103084339.GA855576@kroah.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Mon, 6 Jan 2020 10:44:42 +0800
Message-ID: <CAFH1YnN4_BSP8OywYpLfBHnRRThpk27PEmfYe4baaOkO6FQaNA@mail.gmail.com>
Subject: Re: [PATCH RESEND] ttyprintk: fix a potential sleeping in interrupt
 context issue
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 4:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 03, 2020 at 11:45:41AM +0800, Zhenzhong Duan wrote:
> > Google syzbot reports:
> > BUG: sleeping function called from invalid context at
> > kernel/locking/mutex.c:938
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
> > 1 lock held by swapper/1/0:
> > ...
> > Call Trace:
> >   <IRQ>
> >   dump_stack+0x197/0x210
> >   ___might_sleep.cold+0x1fb/0x23e
> >   __might_sleep+0x95/0x190
> >   __mutex_lock+0xc5/0x13c0
> >   mutex_lock_nested+0x16/0x20
> >   tpk_write+0x5d/0x340
> >   resync_tnc+0x1b6/0x320
> >   call_timer_fn+0x1ac/0x780
> >   run_timer_softirq+0x6c3/0x1790
> >   __do_softirq+0x262/0x98c
> >   irq_exit+0x19b/0x1e0
> >   smp_apic_timer_interrupt+0x1a3/0x610
> >   apic_timer_interrupt+0xf/0x20
> >   </IRQ>
> >
> > Fix it by using spinlock in process context instead of mutex and having
> > interrupt disabled in critical section.
> >
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/char/ttyprintk.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
>
> Why was this resent?  What differs from the first version that required
> it to be resent?
>
> Always give us a clue here please :)
Sorry, I should have done that.
patch-bot told me my last version is malformed(tabs converted to
spaces) which may be due to I used gmail web browser to send patch.
Now I have direct access to smtp.gmail.com and use 'git send-email',
so that's not an issue now. No functional changes compared to last
version.

>
>
> >
> > diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> > index 4f24e46ebe7c..56db949a7b70 100644
> > --- a/drivers/char/ttyprintk.c
> > +++ b/drivers/char/ttyprintk.c
> > @@ -15,10 +15,11 @@
> >  #include <linux/serial.h>
> >  #include <linux/tty.h>
> >  #include <linux/module.h>
> > +#include <linux/spinlock.h>
> >
> >  struct ttyprintk_port {
> >       struct tty_port port;
> > -     struct mutex port_write_mutex;
> > +     spinlock_t spinlock;
> >  };
> >
> >  static struct ttyprintk_port tpk_port;
> > @@ -99,11 +100,12 @@ static int tpk_open(struct tty_struct *tty, struct file *filp)
> >  static void tpk_close(struct tty_struct *tty, struct file *filp)
> >  {
> >       struct ttyprintk_port *tpkp = tty->driver_data;
> > +     unsigned long flags;
> >
> > -     mutex_lock(&tpkp->port_write_mutex);
> > +     spin_lock_irqsave(&tpkp->spinlock, flags);
> >       /* flush tpk_printk buffer */
> >       tpk_printk(NULL, 0);
>
> Are you sure you can call this with a spinlock held?
I think so.

>
> Doesn't your trace above show the opposite?
That's why I use spin_lock_irqsave() variants rather than spin_lock()

The issue here is tpk_write()/tpk_close() could be interrupted when
holding a mutex, then in timer handler tpk_write() is called again
trying to acquire same mutex, lead to dead lock.

With spin_lock_irqsave(), interrupt is disabled in process context, so
no such issue.

>
> What is wrong with sleeping during the mutex you currently have?  How is
> syzbot reporting this error, is there a reproducer somewhere?
See https://syzkaller.appspot.com/bug?extid=2eeef62ee31f9460ad65

I didn't reproduce the dead lock locally, not even for the warning
syzbot reported, but syzbot does.

Thanks
Zhenzhong
