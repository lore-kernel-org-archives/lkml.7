Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DB3C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE36422B48
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578041023;
	bh=Hp7q2TTE4pvo/bziqGh+GKRop6IHs7H6cervwPFzkuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1fr2JQllWJn7V4+PiLWmPZntbfK6R/42wOMT0iA7f1aALMl0b6XRHPhA5VrlUbOmD
	 P+KjGkY+fz0c8NpP4jC5MGb0TndfKwX78QkvSaDbhoUEzi8TPhR/UqUhHBJEhYfDKE
	 T4jd1Zz10jeIwQq8y6bSYj97oZwz13bG/yZGqMxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgACInm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:43:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACInm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:43:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A21521D7D;
        Fri,  3 Jan 2020 08:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578041021;
        bh=Hp7q2TTE4pvo/bziqGh+GKRop6IHs7H6cervwPFzkuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtkbFfUrPBMQXP7+xp+mnWGYj/IoYh1ECZ6Km+/UVIBv/1zE3bPF0b7SE6iHKMmMu
         8uQ6F+AMFhsEh/kkK/RgUW4+fwPnR0Nne64F4G7rFAsV/RJJNWt4NE93WQM/M/r4yg
         4zlqGEMUmNKr9e145NVxfSSpjdp06rEKmY7TW/dI=
Date:   Fri, 3 Jan 2020 09:43:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] ttyprintk: fix a potential sleeping in interrupt
 context issue
Message-ID: <20200103084339.GA855576@kroah.com>
References: <20200103034541.5302-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103034541.5302-1-zhenzhong.duan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 11:45:41AM +0800, Zhenzhong Duan wrote:
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
> Fix it by using spinlock in process context instead of mutex and having
> interrupt disabled in critical section.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/ttyprintk.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Why was this resent?  What differs from the first version that required
it to be resent?

Always give us a clue here please :)


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
>  	struct tty_port port;
> -	struct mutex port_write_mutex;
> +	spinlock_t spinlock;
>  };
>  
>  static struct ttyprintk_port tpk_port;
> @@ -99,11 +100,12 @@ static int tpk_open(struct tty_struct *tty, struct file *filp)
>  static void tpk_close(struct tty_struct *tty, struct file *filp)
>  {
>  	struct ttyprintk_port *tpkp = tty->driver_data;
> +	unsigned long flags;
>  
> -	mutex_lock(&tpkp->port_write_mutex);
> +	spin_lock_irqsave(&tpkp->spinlock, flags);
>  	/* flush tpk_printk buffer */
>  	tpk_printk(NULL, 0);

Are you sure you can call this with a spinlock held?

Doesn't your trace above show the opposite?

What is wrong with sleeping during the mutex you currently have?  How is
syzbot reporting this error, is there a reproducer somewhere?

thanks,

greg k-h
