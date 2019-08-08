Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF84BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9A1217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfHHL0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:26:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:65121 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbfHHL0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:26:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 04:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="374821270"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2019 04:26:50 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hvgZE-0001yc-RD; Thu, 08 Aug 2019 14:26:48 +0300
Date:   Thu, 8 Aug 2019 14:26:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jslaby@suse.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Subject: Re: [PATCH v2 3/3] serial: lantiq: Add support for Lightning
 Mountain SoC
Message-ID: <20190808112648.GM30120@smile.fi.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
 <0df20f6e4bbf9de09c85a5c92c92e642f62f441f.1565257887.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df20f6e4bbf9de09c85a5c92c92e642f62f441f.1565257887.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:02:08PM +0800, Rahul Tanwar wrote:
> This patch adds IRQ & ISR support in the driver for Lightning Mountain SoC.
> 

I dunno if DT binding should go first, otherwise, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/tty/serial/lantiq.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index b129531dfb9a..fcbea43dc334 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -57,6 +57,7 @@
>  #define ASC_IRNCR_TIR		0x1
>  #define ASC_IRNCR_RIR		0x2
>  #define ASC_IRNCR_EIR		0x4
> +#define ASC_IRNCR_MASK		GENMASK(2, 0)
>  
>  #define ASCOPT_CSIZE		0x3
>  #define TXFIFO_FL		1
> @@ -115,6 +116,7 @@ struct ltq_uart_port {
>  	unsigned int		tx_irq;
>  	unsigned int		rx_irq;
>  	unsigned int		err_irq;
> +	unsigned int		common_irq;
>  	spinlock_t		lock; /* exclusive access for multi core */
>  
>  	const struct ltq_soc_data	*soc;
> @@ -293,6 +295,31 @@ lqasc_rx_int(int irq, void *_port)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t lqasc_irq(int irq, void *p)
> +{
> +	unsigned long flags;
> +	u32 stat;
> +	struct uart_port *port = p;
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +
> +	spin_lock_irqsave(&ltq_port->lock, flags);
> +	stat = readl(port->membase + LTQ_ASC_IRNCR);
> +	spin_unlock_irqrestore(&ltq_port->lock, flags);
> +	if (!(stat & ASC_IRNCR_MASK))
> +		return IRQ_NONE;
> +
> +	if (stat & ASC_IRNCR_TIR)
> +		lqasc_tx_int(irq, p);
> +
> +	if (stat & ASC_IRNCR_RIR)
> +		lqasc_rx_int(irq, p);
> +
> +	if (stat & ASC_IRNCR_EIR)
> +		lqasc_err_int(irq, p);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static unsigned int
>  lqasc_tx_empty(struct uart_port *port)
>  {
> @@ -677,6 +704,7 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
>  	return 0;
>  }
>  OF_EARLYCON_DECLARE(lantiq, "lantiq,asc", lqasc_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(lantiq, "intel,lgm-asc", lqasc_serial_early_console_setup);
>  
>  static struct uart_driver lqasc_reg = {
>  	.owner =	THIS_MODULE,
> @@ -751,6 +779,42 @@ static void free_irq_lantiq(struct uart_port *port)
>  	free_irq(ltq_port->err_irq, port);
>  }
>  
> +static int fetch_irq_intel(struct device *dev, struct ltq_uart_port *ltq_port)
> +{
> +	struct uart_port *port = &ltq_port->port;
> +	int ret;
> +
> +	ret = of_irq_get(dev->of_node, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to fetch IRQ for serial port\n");
> +		return ret;
> +	}
> +	ltq_port->common_irq = ret;
> +	port->irq = ret;
> +
> +	return 0;
> +}
> +
> +static int request_irq_intel(struct uart_port *port)
> +{
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +	int retval;
> +
> +	retval = request_irq(ltq_port->common_irq, lqasc_irq, 0,
> +			     "asc_irq", port);
> +	if (retval)
> +		dev_err(port->dev, "failed to request asc_irq\n");
> +
> +	return retval;
> +}
> +
> +static void free_irq_intel(struct uart_port *port)
> +{
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +
> +	free_irq(ltq_port->common_irq, port);
> +}
> +
>  static int __init
>  lqasc_probe(struct platform_device *pdev)
>  {
> @@ -842,8 +906,15 @@ static const struct ltq_soc_data soc_data_lantiq = {
>  	.free_irq = free_irq_lantiq,
>  };
>  
> +static const struct ltq_soc_data soc_data_intel = {
> +	.fetch_irq = fetch_irq_intel,
> +	.request_irq = request_irq_intel,
> +	.free_irq = free_irq_intel,
> +};
> +
>  static const struct of_device_id ltq_asc_match[] = {
>  	{ .compatible = "lantiq,asc", .data = &soc_data_lantiq },
> +	{ .compatible = "intel,lgm-asc", .data = &soc_data_intel },
>  	{},
>  };
>  
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko


