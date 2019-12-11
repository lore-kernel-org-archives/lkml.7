Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09C3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21482173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576071609;
	bh=JmU9lT2aWf0Wn3bEyB4ZKSGlHGmR+w0e61SJPR6LqLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j5+7fgRjHDbtlcUe+E95TIDuZjrgOzHKijV7lhPRLilQPr0tkIISaipj0CZpuY3RT
	 lGl7vdTRDjJR+8xS8SU7DI3R7im0e7mUgbX+6T2U7ElXejJtNXLsoWEsR+CJnIcU8B
	 /ceEgdnWS+qqW7RpZPiYMuy27Nrq7C+je5dga52k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfLKNkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbfLKNkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:40:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F5820836;
        Wed, 11 Dec 2019 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576071607;
        bh=JmU9lT2aWf0Wn3bEyB4ZKSGlHGmR+w0e61SJPR6LqLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPBijh1Yscn9yAB6bCVK5OpbsOxkor/iISyx/UUr4OQQ+2D4+dW1tgQqzycTtctE0
         +Amfnyp60DO0hsjDlpwUWAT9LrukrP0YKMc8F2cVIi1Vlk2CXkdaoEFuDcfMpDB8Pz
         qErlo/0SSpbxt0knX3Q/NsQVcOxGoVciCkO/vpMw=
Date:   Wed, 11 Dec 2019 14:40:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        syzbot+2eeef62ee31f9460ad65@syzkaller.appspotmail.com,
        arnd@arndb.de, bp@alien8.de, john.wanghui@huawei.com,
        keescook@chromium.org, kernelfans@gmail.com, len.brown@intel.com,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org, zhangshaokun@hisilicon.com
Subject: Re: [PATCH] ttyprintk: fix a potential sleeping in interrupt context
 issue
Message-ID: <20191211134005.GA523125@kroah.com>
References: <CAFH1YnMX5oYUT7-_swssWgxQvzKTZUzvOmREBOh5vhfvqX1vNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFH1YnMX5oYUT7-_swssWgxQvzKTZUzvOmREBOh5vhfvqX1vNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:11:46PM +0800, Zhenzhong Duan wrote:
> Google syzbot reports:
> BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:938
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
> 1 lock held by swapper/1/0:
> ...
> Call Trace:
>   <IRQ>
>   dump_stack+0x197/0x210
>   ___might_sleep.cold+0x1fb/0x23e
>   __might_sleep+0x95/0x190
>   __mutex_lock+0xc5/0x13c0
>   mutex_lock_nested+0x16/0x20
>   tpk_write+0x5d/0x340
>   resync_tnc+0x1b6/0x320
>   call_timer_fn+0x1ac/0x780
>   run_timer_softirq+0x6c3/0x1790
>   __do_softirq+0x262/0x98c
>   irq_exit+0x19b/0x1e0
>   smp_apic_timer_interrupt+0x1a3/0x610
>   apic_timer_interrupt+0xf/0x20
>   </IRQ>
> 
> This patch fix it by using spinlock in process context instead of
> mutex and having interrupt disabled in critical section.
> 
> Reported-by: syzbot+2eeef62ee31f9460ad65@syzkaller.appspotmail.com
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  drivers/char/ttyprintk.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index 4f24e46ebe7c..56db949a7b70 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -15,10 +15,11 @@
>  #include <linux/serial.h>
>  #include <linux/tty.h>
>  #include <linux/module.h>
> +#include <linux/spinlock.h>
> 
>  struct ttyprintk_port {
>   struct tty_port port;
> - struct mutex port_write_mutex;
> + spinlock_t spinlock;
>  };
> 
>  static struct ttyprintk_port tpk_port;
> @@ -99,11 +100,12 @@ static int tpk_open(struct tty_struct *tty,
> struct file *filp)
>  static void tpk_close(struct tty_struct *tty, struct file *filp)
>  {
>   struct ttyprintk_port *tpkp = tty->driver_data;
> + unsigned long flags;
> 
> - mutex_lock(&tpkp->port_write_mutex);
> + spin_lock_irqsave(&tpkp->spinlock, flags);
>   /* flush tpk_printk buffer */
>   tpk_printk(NULL, 0);
> - mutex_unlock(&tpkp->port_write_mutex);
> + spin_unlock_irqrestore(&tpkp->spinlock, flags);
> 
>   tty_port_close(&tpkp->port, tty, filp);
>  }


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
