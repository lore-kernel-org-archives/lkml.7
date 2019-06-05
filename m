Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72448C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4884B20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559721573;
	bh=mXtbQjrp4hZzZF7WMcuhIcjehlpaMQLU3Ia5lw/W6lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uUPKLAGthPbmZFW2mOvI8VBBT8lyKUKb26xQk+s3Jb0TDQ/IwJasahLz5M74X6Yck
	 +O0IupH1HqdztziGo4oocn+6Vre48NGnFF+2CIrLpB1sSogK7K9UjH+gmznkQReHg1
	 mGXHICe4TzBVYMg1qr5gE951MrnFXgxZ8s2yqhq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFEH7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfFEH7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:59:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DDAA2083E;
        Wed,  5 Jun 2019 07:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559721571;
        bh=mXtbQjrp4hZzZF7WMcuhIcjehlpaMQLU3Ia5lw/W6lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skwx1CegibHFjp2wMfd3n8BRr00aSLRVHAfq+VP9Pi9ut+7tE/QQVVAs3hFPxzmYA
         ETOM3HWt2aHaawLxkBtQGS47NtMKCRDr9CTaF4v5soH1X51qCyX5GuRn1Yfhxo4eOj
         6UUwUZ2K4NQA1KK2ZoiBWwv6Lu9V+uRrFlNGHjfg=
Date:   Wed, 5 Jun 2019 09:59:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     nicolas.ferre@microchip.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, jonnyc@amazon.com,
        hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH 2/3] irqchip: al-fic: Introduce Amazon's Annapurna Labs
 Fabric Interrupt Controller Driver
Message-ID: <20190605075927.GA9693@kroah.com>
References: <1559717653-11258-1-git-send-email-talel@amazon.com>
 <1559717653-11258-3-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559717653-11258-3-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 09:54:12AM +0300, Talel Shenhar wrote:
> --- /dev/null
> +++ b/include/linux/irqchip/al-fic.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + */
> +
> +#ifndef _AL_FIC_H_
> +#define _AL_FIC_H_
> +
> +#include <linux/irqdomain.h>
> +
> +struct al_fic;
> +
> +struct irq_domain *al_fic_wire_get_domain(struct al_fic *fic);
> +
> +struct al_fic *al_fic_wire_init(struct device_node *node,
> +				void __iomem *base,
> +				const char *name,
> +				unsigned int parent_irq);
> +int al_fic_cleanup(struct al_fic *fic);

Who is using these new functions?  We don't add new apis that no one
uses :(

thanks,

greg k-h
