Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00280C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79C421E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbfHGNTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:19:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:2534 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387970AbfHGNTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:19:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 06:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="165318374"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2019 06:19:07 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hvLqL-0002ZV-Fa; Wed, 07 Aug 2019 16:19:05 +0300
Date:   Wed, 7 Aug 2019 16:19:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Subject: Re: [PATCH 1/5] serial: lantiq: Add SMP support
Message-ID: <20190807131905.GW30120@smile.fi.intel.com>
References: <cover.1565160764.git.rahul.tanwar@linux.intel.com>
 <7912786cccad60c72b20ea724af1def505ab22aa.1565160764.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7912786cccad60c72b20ea724af1def505ab22aa.1565160764.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:21:31PM +0800, Rahul Tanwar wrote:
> The existing driver can only support single core SoC. But new multicore
> platforms which reuse the same driver/IP need SMP support. This patch adds
> multicore support in the driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/tty/serial/lantiq.c | 47 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 9de9f0f239a1..42e27b48e9cc 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -99,7 +99,6 @@
>  static void lqasc_tx_chars(struct uart_port *port);
>  static struct ltq_uart_port *lqasc_port[MAXPORTS];
>  static struct uart_driver lqasc_reg;
> -static DEFINE_SPINLOCK(ltq_asc_lock);
>  
>  struct ltq_uart_port {
>  	struct uart_port	port;
> @@ -110,6 +109,7 @@ struct ltq_uart_port {
>  	unsigned int		tx_irq;
>  	unsigned int		rx_irq;
>  	unsigned int		err_irq;
> +	spinlock_t		lock; /* exclusive access for multi core */
>  };
>  
>  static inline void asc_update_bits(u32 clear, u32 set, void __iomem *reg)
> @@ -135,9 +135,11 @@ static void
>  lqasc_start_tx(struct uart_port *port)
>  {
>  	unsigned long flags;
> -	spin_lock_irqsave(&ltq_asc_lock, flags);
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +
> +	spin_lock_irqsave(&ltq_port->lock, flags);
>  	lqasc_tx_chars(port);
> -	spin_unlock_irqrestore(&ltq_asc_lock, flags);
> +	spin_unlock_irqrestore(&ltq_port->lock, flags);
>  	return;
>  }
>  
> @@ -245,9 +247,11 @@ lqasc_tx_int(int irq, void *_port)
>  {
>  	unsigned long flags;
>  	struct uart_port *port = (struct uart_port *)_port;
> -	spin_lock_irqsave(&ltq_asc_lock, flags);
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +
> +	spin_lock_irqsave(&ltq_port->lock, flags);
>  	__raw_writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
> -	spin_unlock_irqrestore(&ltq_asc_lock, flags);
> +	spin_unlock_irqrestore(&ltq_port->lock, flags);
>  	lqasc_start_tx(port);
>  	return IRQ_HANDLED;
>  }
> @@ -257,11 +261,13 @@ lqasc_err_int(int irq, void *_port)
>  {
>  	unsigned long flags;
>  	struct uart_port *port = (struct uart_port *)_port;
> -	spin_lock_irqsave(&ltq_asc_lock, flags);
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +
> +	spin_lock_irqsave(&ltq_port->lock, flags);
>  	/* clear any pending interrupts */
>  	asc_update_bits(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
>  		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
> -	spin_unlock_irqrestore(&ltq_asc_lock, flags);
> +	spin_unlock_irqrestore(&ltq_port->lock, flags);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -270,10 +276,12 @@ lqasc_rx_int(int irq, void *_port)
>  {
>  	unsigned long flags;
>  	struct uart_port *port = (struct uart_port *)_port;
> -	spin_lock_irqsave(&ltq_asc_lock, flags);
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +
> +	spin_lock_irqsave(&ltq_port->lock, flags);
>  	__raw_writel(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
>  	lqasc_rx_chars(port);
> -	spin_unlock_irqrestore(&ltq_asc_lock, flags);
> +	spin_unlock_irqrestore(&ltq_port->lock, flags);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -307,11 +315,13 @@ lqasc_startup(struct uart_port *port)
>  {
>  	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
>  	int retval;
> +	unsigned long flags;
>  
>  	if (!IS_ERR(ltq_port->clk))
>  		clk_prepare_enable(ltq_port->clk);
>  	port->uartclk = clk_get_rate(ltq_port->freqclk);
>  
> +	spin_lock_irqsave(&ltq_port->lock, flags);
>  	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
>  		port->membase + LTQ_ASC_CLC);
>  
> @@ -331,6 +341,8 @@ lqasc_startup(struct uart_port *port)
>  	asc_update_bits(0, ASCCON_M_8ASYNC | ASCCON_FEN | ASCCON_TOEN |
>  		ASCCON_ROEN, port->membase + LTQ_ASC_CON);
>  
> +	spin_unlock_irqrestore(&ltq_port->lock, flags);
> +
>  	retval = request_irq(ltq_port->tx_irq, lqasc_tx_int,
>  		0, "asc_tx", port);
>  	if (retval) {
> @@ -367,15 +379,19 @@ static void
>  lqasc_shutdown(struct uart_port *port)
>  {
>  	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +	unsigned long flags;
> +
>  	free_irq(ltq_port->tx_irq, port);
>  	free_irq(ltq_port->rx_irq, port);
>  	free_irq(ltq_port->err_irq, port);
>  
> +	spin_lock_irqsave(&ltq_port->lock, flags);
>  	__raw_writel(0, port->membase + LTQ_ASC_CON);
>  	asc_update_bits(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
>  		port->membase + LTQ_ASC_RXFCON);
>  	asc_update_bits(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
>  		port->membase + LTQ_ASC_TXFCON);
> +	spin_unlock_irqrestore(&ltq_port->lock, flags);
>  	if (!IS_ERR(ltq_port->clk))
>  		clk_disable_unprepare(ltq_port->clk);
>  }
> @@ -390,6 +406,7 @@ lqasc_set_termios(struct uart_port *port,
>  	unsigned int baud;
>  	unsigned int con = 0;
>  	unsigned long flags;
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
>  
>  	cflag = new->c_cflag;
>  	iflag = new->c_iflag;
> @@ -443,7 +460,7 @@ lqasc_set_termios(struct uart_port *port,
>  	/* set error signals  - framing, parity  and overrun, enable receiver */
>  	con |= ASCCON_FEN | ASCCON_TOEN | ASCCON_ROEN;
>  
> -	spin_lock_irqsave(&ltq_asc_lock, flags);
> +	spin_lock_irqsave(&ltq_port->lock, flags);
>  
>  	/* set up CON */
>  	asc_update_bits(0, con, port->membase + LTQ_ASC_CON);
> @@ -471,7 +488,7 @@ lqasc_set_termios(struct uart_port *port,
>  	/* enable rx */
>  	__raw_writel(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
>  
> -	spin_unlock_irqrestore(&ltq_asc_lock, flags);
> +	spin_unlock_irqrestore(&ltq_port->lock, flags);
>  
>  	/* Don't rewrite B0 */
>  	if (tty_termios_baud_rate(new))
> @@ -589,17 +606,14 @@ lqasc_console_putchar(struct uart_port *port, int ch)
>  static void lqasc_serial_port_write(struct uart_port *port, const char *s,
>  				    u_int count)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&ltq_asc_lock, flags);
>  	uart_console_write(port, s, count, lqasc_console_putchar);
> -	spin_unlock_irqrestore(&ltq_asc_lock, flags);
>  }
>  
>  static void
>  lqasc_console_write(struct console *co, const char *s, u_int count)
>  {
>  	struct ltq_uart_port *ltq_port;
> +	unsigned long flags;
>  
>  	if (co->index >= MAXPORTS)
>  		return;
> @@ -608,7 +622,9 @@ lqasc_console_write(struct console *co, const char *s, u_int count)
>  	if (!ltq_port)
>  		return;
>  
> +	spin_lock_irqsave(&ltq_port->lock, flags);
>  	lqasc_serial_port_write(&ltq_port->port, s, count);
> +	spin_unlock_irqrestore(&ltq_port->lock, flags);
>  }
>  
>  static int __init
> @@ -766,6 +782,7 @@ lqasc_probe(struct platform_device *pdev)
>  	ltq_port->rx_irq = irqres[1].start;
>  	ltq_port->err_irq = irqres[2].start;
>  
> +	spin_lock_init(&ltq_port->lock);
>  	lqasc_port[line] = ltq_port;
>  	platform_set_drvdata(pdev, ltq_port);
>  
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko


