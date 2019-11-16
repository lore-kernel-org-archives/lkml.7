Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB7FC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 13:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46941206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573911317;
	bh=0N0ewmAfa2QYn131WsF6ctHgrLk9FbCRjBSZRNlTNmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gaIjB/CjuLdbCmn5l76D07Ovc2V/qkZjDg9HuMbIwCz/9mEdMFPVKpUQ6gXP/nssL
	 u6ISaVjVP8ETe3EqYFiCD5EyTHEDK3gZrQcwQ8795wPh0GhJXPXHC5fYV9gwF9QoXf
	 8Q5g1ii12jarEr/Xqv4uzXxK0YMNCqZVgDPFwu30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKPNfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 08:35:12 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:39293 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727550AbfKPNfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 08:35:11 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iVyEH-0002yS-Dr; Sat, 16 Nov 2019 14:35:09 +0100
Date:   Sat, 16 Nov 2019 13:35:08 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] irqchip/gic: Check interrupt type validity
Message-ID: <20191116133508.25234f26@why>
In-Reply-To: <20191023195620.23415-1-f.fainelli@gmail.com>
References: <20191023195620.23415-1-f.fainelli@gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: f.fainelli@gmail.com, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 12:56:19 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> In case the interrupt property specifies a type parameter that is not
> GIC_SPI (0) or GIC_PPIC (1), do not attempt to translate the interrupt
> and return -EINVAL instead.
> 
> Fixes: f833f57ff254 ("irqchip: Convert all alloc/xlate users from of_node to fwnode")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Marc,
> 
> Regardless of whether my attempt to use SGI moves any further, this
> seems appropriate to do since we should not be trying to translate
> incorrectly specified interrupts. Thanks!
> 
>  drivers/irqchip/irq-gic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 30ab623343d3..fc47e655618d 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1005,6 +1005,9 @@ static int gic_irq_domain_translate(struct irq_domain *d,
>  		if (fwspec->param_count < 3)
>  			return -EINVAL;
>  
> +		if (fwspec->param[0] > 1)
> +			return -EINVAL;
> +
>  		/* Get the interrupt number and add 16 to skip over SGIs */
>  		*hwirq = fwspec->param[1] + 16;
>  

I'm in two minds about this.

The usual stance is that the kernel is not a validation suite for DT
files, but on the other hand we already do some of that two lines above
(a consequence of kernel and DT binding lockstep development...). Do we
really want to add more of this? Or should we put more effort in static
validation of DT files and actually remove these checks?

	M.
-- 
Jazz is not dead. It just smells funny...
