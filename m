Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA8BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4002520727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574064826;
	bh=hWugHNSg6FXiyf5zMGSCMUjQJ73H/jew3AKUJQutvGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0lapBpxka9ANZ600wa8GDRNe/biBOKOjfESluv/akduoEODflCXNT5kkmW6plWyWk
	 +xb+C1abcRS0c88uvAAIVsjjw0VgkAYnKEP+pc5AvJTXzZWJiHxfwy4qRYdtoPRGax
	 yMpneeb9WD36XWdhEq7P1H9Rg8LoYiK33lOoWOqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfKRINp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:13:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfKRINo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:13:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EAE42073A;
        Mon, 18 Nov 2019 08:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574064824;
        bh=hWugHNSg6FXiyf5zMGSCMUjQJ73H/jew3AKUJQutvGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w7LPovea5sx/z5aH9l7zhX+zhq2nGXRvh4TWOe/5DnCET5I57moGxzgzZG4cv1tzx
         oZ6noF4fkkWWkxvHwcA1ScIgW0R3Uo4Q203AaLxv/l8QSUBboEdG+nbc1qn9HrAvan
         Agrb9hSGZYui8NTNvZoNhWCOb0Xx7H14tyqmqHiY=
Date:   Mon, 18 Nov 2019 09:13:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, Arthur Heymans <arthur@aheymans.xyz>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>, furquan@chromium.org
Subject: Re: [PATCH 2/3] firmware: google: Unregister driver_info on failure
 and exit in gsmi
Message-ID: <20191118081341.GA133533@kroah.com>
References: <20191115134842.17013-1-patrick.rudolph@9elements.com>
 <20191115134842.17013-3-patrick.rudolph@9elements.com>
 <20191116134001.GE454551@kroah.com>
 <246585089f8b0730bc4e0ddae2e6a877009e1307.camel@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <246585089f8b0730bc4e0ddae2e6a877009e1307.camel@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 08:59:32AM +0100, patrick.rudolph@9elements.com wrote:
> On Sat, 2019-11-16 at 14:40 +0100, Greg Kroah-Hartman wrote:
> > On Fri, Nov 15, 2019 at 02:48:38PM +0100, 
> > patrick.rudolph@9elements.com wrote:
> > > From: Arthur Heymans <arthur@aheymans.xyz>
> > > 
> > > Fix a bug where the kernel module couldn't be loaded after
> > > unloading,
> > > as the platform driver wasn't released on exit.
> > > 
> > > Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
> > > ---
> > >  drivers/firmware/google/gsmi.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/firmware/google/gsmi.c
> > > b/drivers/firmware/google/gsmi.c
> > > index edaa4e5d84ad..974c769b75cf 100644
> > > --- a/drivers/firmware/google/gsmi.c
> > > +++ b/drivers/firmware/google/gsmi.c
> > > @@ -1016,6 +1016,9 @@ static __init int gsmi_init(void)
> > >  	dma_pool_destroy(gsmi_dev.dma_pool);
> > >  	platform_device_unregister(gsmi_dev.pdev);
> > >  	pr_info("gsmi: failed to load: %d\n", ret);
> > > +#ifdef CONFIG_PM
> > > +	platform_driver_unregister(&gsmi_driver_info);
> > > +#endif
> > >  	return ret;
> > >  }
> > >  
> > > @@ -1037,6 +1040,9 @@ static void __exit gsmi_exit(void)
> > >  	gsmi_buf_free(gsmi_dev.name_buf);
> > >  	dma_pool_destroy(gsmi_dev.dma_pool);
> > >  	platform_device_unregister(gsmi_dev.pdev);
> > > +#ifdef CONFIG_PM
> > > +	platform_driver_unregister(&gsmi_driver_info);
> > 
> > Why the #ifdef here?  Why does PM change things?
> > 
> The driver is only registered if CONFIG_PM is selected, thus it only
> needs to be unregistered if CONFIG_PM is selected.
> 
> See 8942b2d5094b0 for reference.

That is a "fun" abuse of the platform driver interface :(

Why not just have this registration of your device for the "normal"
device your driver binds to?  Why create a special platform device
instead?  That means you have double the number of "devices" for your
single real device.

thanks,

greg k-h
