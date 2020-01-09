Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE835C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9545E2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578551928;
	bh=kx0FBh7fXm7nuS+UvEjGXaT9xM73CIiasJUFYyjrCx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wfNKD2hQBraf+/szVE20z13kzvWwSD24XtajBUkk0jS6KKyrQv5aB2x3yWxiMsc6Q
	 fiojrF0G18wD7+pTS3H5MNI4alDMItqwZX7IJkAFeqF9VIPwDtI60p3tgdLXmZWQo3
	 GGEE7/WotpWyyuorPVbFldrwyQEOEhc7hRMA8ERs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgAIGir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgAIGir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:38:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFEC2053B;
        Thu,  9 Jan 2020 06:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578551926;
        bh=kx0FBh7fXm7nuS+UvEjGXaT9xM73CIiasJUFYyjrCx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tn1RAqqa/hTvw683sRj7pMWNaKbv1tnnh1nMEB5b02Z+Tr92Iwyp1fnROK7T1JGhJ
         098zWzaXl2aV23l8kpU8hJ0R2uZyN3vYMWSgDpgW8AT2aCBi7KyDRRPxW8K0hWQKI2
         v6oSgbt7bQOAPIQKRxJu5QqC/6TSQL7L7lBQ+4tY=
Date:   Thu, 9 Jan 2020 07:38:41 +0100
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
Message-ID: <20200109063841.GA2579094@kroah.com>
References: <20200108113719.21551-1-pawell@cadence.com>
 <20200108142829.GB2383861@kroah.com>
 <BYAPR07MB4709983A2DF70AA0058C737FDD390@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB4709983A2DF70AA0058C737FDD390@BYAPR07MB4709.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 06:27:02AM +0000, Pawel Laszczak wrote:
> >> +	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> >> +
> >> +	ret = readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
> >> +					!(val & (EP_CMD_CSTALL | EP_CMD_EPRST)),
> >> +					1, 1000);
> >> +
> >> +	if (unlikely(ret))
> >
> >Unless you can measure the difference of using/not using a
> >unlikely/likely mark, NEVER use it.  The compiler and cpu can almost
> >always do better than you can, we have the tests to prove it.
> >
> 
> The both of the above timeout should never occur. If they occurred it would be a 
> critical controller bug. In this case driver can only inform  about this event. 

"Should never occur" is a fun thing to say :)

If it can never occur, then don't even check for it.

If it can, then check for it and handle it properly.

What about this controller in systems with removable busses (like PCI?)
What happens then (hint, I bet this could occur...)

> For timeouts used in driver I've never see an errors. Because debugging these 
> kind of errors is very hard I decided to leave dev_err in such case to inform that
> probably something is wrong in HW project. 
> 
> I will remove unlikely.  
> 
> >> +		dev_err(priv_dev->dev, "Timeout: %s resetting failed.\n",
> >> +			priv_ep->name);
> >> +
> >> +	priv_ep->flags |= EP_HW_RESETED;
> >
> >So an error happens, but you still claim the device is reset?  What can
> >a user do about this error?
> 
> The error should never occur. 

Then no need to warn anyone, just wait and move on.

Or properly handle it.

thanks,

greg k-h
