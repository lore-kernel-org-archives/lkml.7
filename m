Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE20FC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8868D222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfIZI67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:58:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:59278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729039AbfIZI67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:58:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A619DAC68;
        Thu, 26 Sep 2019 08:58:56 +0000 (UTC)
Date:   Thu, 26 Sep 2019 10:58:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: Regression in dbdda842fe96 ("printk: Add console owner and
 waiter logic to load balance console writes") [Was: Regression in
 fd5f7cde1b85 ("...")]
Message-ID: <20190926085855.debu7t46s7kgb26p@pathway.suse.cz>
References: <20190917141034.gvjg7bgylqbbxyv7@pengutronix.de>
 <20190918013032.GA2895@jagdpanzerIV>
 <20190918071158.rtw45jch2roa2wum@pengutronix.de>
 <20190918075252.GA30808@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190918075252.GA30808@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-09-18 16:52:52, Sergey Senozhatsky wrote:
> On (09/18/19 09:11), Uwe Kleine-König wrote:
> > I rechecked and indeed fd5f7cde1b85's parent has the problem, too, so I
> > did a mistake during my bisection :-|
> > 
> > Redoing the bisection (a bit quicker this time) points to
> > 
> > dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
> > 
> > Sorry for the confusion.
> 
> No worries!
> 
> [..]
> > > So I'd say that lockdep is correct, but there are several hacks which
> > > prevent actual deadlock.
>
> The basic idea is to handle sysrq out of port->lock.

Great idea!

> I didn't test it all (not even sure if it compiles).
> 
> ---
>  drivers/tty/serial/imx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 87c58f9f6390..f0dd807b52df 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -731,9 +731,9 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
>  	struct imx_port *sport = dev_id;
>  	unsigned int rx, flg, ignored = 0;
>  	struct tty_port *port = &sport->port.state->port;
> +	unsigned long flags;
>  
> -	spin_lock(&sport->port.lock);
> -
> +	uart_port_lock_irqsave(&sport->port, flags);

uart_port_lock_irqsave() does not exist. Instead the current users
do:

     spin_lock_irqsave(&port->lock, flags);

>  	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
>  		u32 usr2;
>  
> @@ -749,8 +749,8 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
>  				continue;
>  		}
>  
> -		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> -			continue;
> +		if (uart_prepare_sysrq_char(&sport->port, (unsigned char)rx))
> +			break;
>  
>  		if (unlikely(rx & URXD_ERR)) {
>  			if (rx & URXD_BRK)
> @@ -792,7 +792,7 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
>  	}
>  
>  out:
> -	spin_unlock(&sport->port.lock);
> +	uart_unlock_and_check_sysrq(&sport->port, flags);

This API has been introduced for exactly this reason. See the commit
6e1935819db0c91ce4a5af ("serial: core: Allow processing sysrq at port
unlock time").

I like this approach. It allows to remove hacks with locks.

Well, Sergey's patch is nice example that the API is a bit confusing.
I would either make it symmetric and make a variant without saving
irq flags:

    uart_lock(port);
    uart_unlock_and_handle_sysrq(port);

    uart_lock_irqsave(port, flags);
    uart_unlock_irqrestore_and_handle_sysrq(port);

Or I would keep the locking as is and add some API
just for the sysrq handling:


   int uart_store_sysrq_char(struct uart_port *port, unsigned int ch);
   unsigned int uart_get_sysrq_char(struct uart_port *port);

And use it the following way:

	int handle_irq()
	{
		unsined int sysrq, sysrq_ch;

		spin_lock(&port->lock);
		[...]
			sysrq = uart_store_sysrq_char(port, ch);
			if (!sysrq)
				[...]
		[...]

	out:
		sysrq_ch = uart_get_sysrq_char(port);
		spin_unlock(&port->lock);

		if (sysrq_ch)
			handle_sysrq(sysrq_ch);
	}

I prefer the 2nd option. It is more code. But it is more
self explanatory.

What do you think?

Best Regards,
Petr
