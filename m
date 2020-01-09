Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E442C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0279C20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578562699;
	bh=B8Vy7Qc/JmhHxytf6QW/GNyZc4W736SnXEDytIHhZaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rTfDMe1TUPhy+rxDaaWaZN9caGO1jYnsTs6KFIYw+4HwvCvqU56ZqghK9wb2Ks7+c
	 WvbLWwoahe0+8ssr5Kn4Mlks9BB6S4RnBiiqr6jvrY/uAcewTwYqUKK4vpa7RWPnGl
	 KTwZGeC3H9441ddGZPJ0u/Q1dUgjYbH/O8mVuh5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgAIJiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:38:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbgAIJiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:38:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1217220678;
        Thu,  9 Jan 2020 09:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578562694;
        bh=B8Vy7Qc/JmhHxytf6QW/GNyZc4W736SnXEDytIHhZaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIRDGUFEScKQC8f2kDjY16KIhbuSJj5ICaJWJfXBbOKqwqWx16O/JeVmayvc9EMbF
         vLo/yMCUXL8WXkaqBvM+8TJ87FL4EqbGdtZStq6nrzKxx6gkecYr1DmJm/jnpwZrhS
         /OUvAVwax6WXEhP1+L/6vKhizuywUAtt6zqzwAR4=
Date:   Thu, 9 Jan 2020 10:38:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Peter Chan <peter.chan@nxp.com>
Subject: Re: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Message-ID: <20200109093812.GC44349@kroah.com>
References: <20200108113719.21551-1-pawell@cadence.com>
 <20200108142829.GB2383861@kroah.com>
 <BYAPR07MB4709983A2DF70AA0058C737FDD390@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20200109063841.GA2579094@kroah.com>
 <BYAPR07MB4709AA109700B4BCAD1C1ED8DD390@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB4709AA109700B4BCAD1C1ED8DD390@BYAPR07MB4709.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 08:34:12AM +0000, Pawel Laszczak wrote:
> >
> >On Thu, Jan 09, 2020 at 06:27:02AM +0000, Pawel Laszczak wrote:
> >> >> +	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> >> >> +
> >> >> +	ret = readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
> >> >> +					!(val & (EP_CMD_CSTALL | EP_CMD_EPRST)),
> >> >> +					1, 1000);
> >> >> +
> >> >> +	if (unlikely(ret))
> >> >
> >> >Unless you can measure the difference of using/not using a
> >> >unlikely/likely mark, NEVER use it.  The compiler and cpu can almost
> >> >always do better than you can, we have the tests to prove it.
> >> >
> >>
> >> The both of the above timeout should never occur. If they occurred it would be a
> >> critical controller bug. In this case driver can only inform  about this event.
> >
> >"Should never occur" is a fun thing to say :)
> >
> >If it can never occur, then don't even check for it.
> 
> Yes, on existing platforms it can never occur. 
> 
> >
> >If it can, then check for it and handle it properly.
> >
> >What about this controller in systems with removable busses (like PCI?)
> >What happens then (hint, I bet this could occur...)
> 
> It's good question.  Nobody from our customer currently use such system. 
> The only platform with PCI is used by me for testing purpose.  

So if you do have a PCI device, then you need to handle PCI reads
failing and returning all 1s.  Hopefully you can gracefully handle this :)

Adding timeout handling here, where it is totally obvious to do so,
would be a good thing.

thanks,

greg k-h
