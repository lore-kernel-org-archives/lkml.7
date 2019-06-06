Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAE3C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DD620868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559803065;
	bh=PZclXto95zQCnAw7+RqvTMceiBAgvFgp7tWzFU0lQ7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oyOuuXaAgaKGDkhIsCcRoDWIrt1oG2/VfAT6bTApzZ7adeXrviAwPQpLqH5751m2I
	 dfUF4GvcIQsXz/toH82DmlcQULovDhFnW5tnGTTLXZp6UJopaVZLZVzara5Sv1Luv8
	 tEU5b8Owt5kWkQ1sRKEP96etV8I0K2+DcrTyCtbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFFGho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFGho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:37:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6493820673;
        Thu,  6 Jun 2019 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559803063;
        bh=PZclXto95zQCnAw7+RqvTMceiBAgvFgp7tWzFU0lQ7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PaF9zKniU6nz+hpZYk8sIfBvycyGZXZUtrcuDhaITxaiz5LG2nCh0JS0S5FvvNyC9
         S8cOJlblvb92R4pTjv0XRtItw/uMxdk6ya3j3pVfpahog89GnUzrxaOHFIH5v1uyK1
         OOfd2N6+JPXmoN/BRUTgBLi3v/26cJgJpjKvOT0I=
Date:   Thu, 6 Jun 2019 08:37:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Talel Shenhar <talel@amazon.com>, nicolas.ferre@microchip.com,
        jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, jonnyc@amazon.com, hhhawa@amazon.com,
        ronenk@amazon.com, hanochu@amazon.com, barakw@amazon.com
Subject: Re: [PATCH 2/3] irqchip: al-fic: Introduce Amazon's Annapurna Labs
 Fabric Interrupt Controller Driver
Message-ID: <20190606063741.GA23305@kroah.com>
References: <1559717653-11258-1-git-send-email-talel@amazon.com>
 <1559717653-11258-3-git-send-email-talel@amazon.com>
 <20190605075927.GA9693@kroah.com>
 <a81a46ef13273aa8c6ea87c8d3550e33650e27b6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a81a46ef13273aa8c6ea87c8d3550e33650e27b6.camel@kernel.crashing.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 07:55:43AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2019-06-05 at 09:59 +0200, Greg KH wrote:
> > 
> > > +struct irq_domain *al_fic_wire_get_domain(struct al_fic *fic);
> > > +
> > > +struct al_fic *al_fic_wire_init(struct device_node *node,
> > > +				void __iomem *base,
> > > +				const char *name,
> > > +				unsigned int parent_irq);
> > > +int al_fic_cleanup(struct al_fic *fic);
> > 
> > Who is using these new functions?  We don't add new apis that no one
> > uses :(
> 
> They will be used by subsequent driver submissions but those aren't
> quite ready yet, so we can hold onto patch 3 for now until they are.

Patch 2 also should have these removed :)

You know we don't add new apis until we have a real, in-kernel user for
them...

thanks,

greg k-h
