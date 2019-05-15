Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165D1C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33732084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfEOOge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:36:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:49246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbfEOOgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:36:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A56DAFBC;
        Wed, 15 May 2019 14:36:32 +0000 (UTC)
Date:   Wed, 15 May 2019 16:36:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 3/4] printk: factor out register_console() code
Message-ID: <20190515143631.vuhbda6btucrkskx@pathway.suse.cz>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
 <20190426053302.4332-4-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426053302.4332-4-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-04-26 14:33:01, Sergey Senozhatsky wrote:
> We need to take console_sem lock when we iterate console drivers
> list. Otherwise, another CPU can concurrently modify console drivers
> list or console drivers. Current register_console() has several
> race conditions - for_each_console() must be done under console_sem.
> 
> Factor out console registration code and hold console_sem throughout
> entire registration process. Note that we need to unlock console_sem
> and lock it again after we added new console to the list and before
> we unregister boot consoles. This might look a bit weird, but this
> is how we print pending logbuf messages to all registered and
> available consoles.

My main concern was whether we could call newcon->setup() under
console_lock. I checked many console drivers and all looked safe.
There should not be much reasons to do it.


> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  kernel/printk/printk.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 3ac71701afa3..3b36e26d4a51 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2771,7 +2771,6 @@ void register_console(struct console *newcon)
>  	 *	Put this console in the list - keep the
>  	 *	preferred driver at the head of the list.
>  	 */
> -	console_lock();
>  	if ((newcon->flags & CON_CONSDEV) || console_drivers == NULL) {
>  		newcon->next = console_drivers;
>  		console_drivers = newcon;
> @@ -2818,6 +2817,7 @@ void register_console(struct console *newcon)
>  
>  	console_unlock();
>  	console_sysfs_notify();
> +	console_lock();

I have got an idea how to get rid of this weirdness:

1. The check for bcon seems to be just an optimization. There is not need
   to remove boot consoles when there are none.

2. The condition (newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV)
   is valid only when the preferred console was really added.

Therefore we could move the code to a separate function, e.g.

void unregister_boot_consoles(void)
{
	struct console *bcon;

	console_lock();
	for_each_console(bcon)
		if (bcon->flags & CON_BOOT)
			__unregister_console(bcon);
	}
	console_unlock();
	console_sysfs_notify();
}

Then we could do something like:

void register_console(struct console *newcon)
{
	bool newcon_is_preferred = false;

	console_lock();
	__register_console(newcon);
	if ((newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV)
		newcon_is_preferred = true;
	console_unlock();
	console_sysfs_notify();

	/*
	 * By unregistering the bootconsoles after we enable the real console
	 * we get the "console xxx enabled" message on all the consoles -
	 * boot consoles, real consoles, etc - this is to ensure that end
	 * users know there might be something in the kernel's log buffer that
	 * went to the bootconsole (that they do not see on the real console)
	 */
	if (newcon_is_preferred && !keep_bootcon)
		unregister_boot_consoles();
}

How does that sound?

Otherwise, the patch looks fine to me.

Best Regards,
Petr
