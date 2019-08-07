Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC75C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD42E21E73
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbfHGNaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:30:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:20721 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387982AbfHGNaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:30:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 06:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="185993385"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 07 Aug 2019 06:29:59 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hvM0r-0002hp-7c; Wed, 07 Aug 2019 16:29:57 +0300
Date:   Wed, 7 Aug 2019 16:29:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Subject: Re: [PATCH 3/5] serial: lantiq: Make IRQ & ISR assignment dynamic
Message-ID: <20190807132957.GY30120@smile.fi.intel.com>
References: <cover.1565160764.git.rahul.tanwar@linux.intel.com>
 <6dd57ea99f734bd4e413f6913914c0a93c00f295.1565160764.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd57ea99f734bd4e413f6913914c0a93c00f295.1565160764.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:21:33PM +0800, Rahul Tanwar wrote:
> This driver/IP is reused across multiple SoCs. Older SoCs supported three
> separate IRQs for tx, rx & err interrupts. Newer Lightning Mountain SoC
> supports single IRQ for all of tx/rx/err interrupts. This patch modifies
> the driver design to support dynamic assignment of IRQ resources & ISRs
> based on devicetree node compatible entries.

> +struct ltq_soc_data {
> +	int	(*fetch_irq)(struct platform_device *pdev,
> +				 struct ltq_uart_port *ltq_port);

This can be simple

	int	(*fetch_irq)(struct device *dev, struct ltq_uart_port *ltq_port);

(Note one line and struct device instead of platform_device)

> +	int	(*request_irq)(struct uart_port *port);
> +	void	(*free_irq)(struct uart_port *port);
> +};

> +	retval = ltq_port->soc->request_irq(port);
> +	if(retval)

Space is missed.

>  		return retval;


> +static int fetch_irq_lantiq(struct platform_device *pdev,
> +			    struct ltq_uart_port *ltq_port)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct uart_port *port = &ltq_port->port;
> +	struct resource irqres[3];
> +	int ret;
> +
> +	ret = of_irq_to_resource_table(node, irqres, 3);
> +	if (ret != 3) {
> +		dev_err(&pdev->dev,
> +			"failed to get IRQs for serial port\n");
> +		return -ENODEV;
> +	}
> +	ltq_port->tx_irq = irqres[0].start;
> +	ltq_port->rx_irq = irqres[1].start;
> +	ltq_port->err_irq = irqres[2].start;
> +	port->irq = irqres[0].start;
> +

> +	return ret;

I'm not sure you need to return known value. 0 will be good enough...

> +}

> +	ltq_port->soc = of_device_get_match_data(&pdev->dev);
> +	ret = ltq_port->soc->fetch_irq(pdev, ltq_port);

> +	if (ret < 0)

...and thus simple...

	if (ret)

...may be used.

> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


