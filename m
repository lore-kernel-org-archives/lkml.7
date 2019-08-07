Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75CCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A369321E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbfHGNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:31:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:23464 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388479AbfHGNb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:31:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 06:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="168634228"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2019 06:31:25 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hvM2F-0002jO-I9; Wed, 07 Aug 2019 16:31:23 +0300
Date:   Wed, 7 Aug 2019 16:31:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Subject: Re: [PATCH 5/5] serial: lantiq: Add support for Lightning Mountain
 SoC
Message-ID: <20190807133123.GZ30120@smile.fi.intel.com>
References: <cover.1565160764.git.rahul.tanwar@linux.intel.com>
 <a947355d6cf0ab71205e81779e1549f42f3f945a.1565160764.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a947355d6cf0ab71205e81779e1549f42f3f945a.1565160764.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:21:35PM +0800, Rahul Tanwar wrote:
> This patch adds IRQ & ISR support in the driver for Lightning Mountain SoC.

> +#define ASC_IRNCR_MASK		0x7

GENMASK() ?

> +static irqreturn_t lqasc_irq(int irq, void *p)
> +{
> +	unsigned long flags;
> +	u32 stat;
> +	struct uart_port *port = p;
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +
> +	spin_lock_irqsave(&ltq_port->lock, flags);
> +	stat = readl(port->membase + LTQ_ASC_IRNCR);
> +	if (!(stat & ASC_IRNCR_MASK)) {
> +		spin_unlock_irqrestore(&ltq_port->lock, flags);
> +		return IRQ_NONE;
> +	}

> +	spin_unlock_irqrestore(&ltq_port->lock, flags);

Are you sure the below does not need a serialization?

If it's not the case, you may unlock the lock immediately after readl().

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

> +static int fetch_irq_intel(struct platform_device *pdev,
> +			   struct ltq_uart_port *ltq_port)
> +{
> +	struct uart_port *port = &ltq_port->port;
> +	int ret;
> +
> +	ret = of_irq_get(pdev->dev.of_node, 0);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"failed to fetch IRQ for serial port\n");

> +		return -ENODEV;

	return ret;

> +	}
> +	ltq_port->common_irq = ret;
> +	port->irq = ret;
> +

> +	return ret;

Same as per patch 3, i.e.

	return 0;

> +}

> +static int request_irq_intel(struct uart_port *port)
> +{
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +	int retval;
> +
> +	retval = request_irq(ltq_port->common_irq, lqasc_irq, 0,
> +			     "asc_irq", port);

> +	if (retval) {
> +		dev_err(port->dev, "failed to request asc_irq\n");
> +		return retval;
> +	}
> +
> +	return 0;

	if (retval)
		dev_err();

	return retval;

> +}

> +
> +

One blank line is enough.

-- 
With Best Regards,
Andy Shevchenko


