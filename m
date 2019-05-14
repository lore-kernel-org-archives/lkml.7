Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8CEC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9272084A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557852916;
	bh=8n63wOgL9cad2rIE8kZV4epVBMV8HjjuhWRqstNew/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FxWd4sqtORcKsGy7h9h7oQ8l81kacbm3JHFW91S4AG6cJt5jqE1eWGZdpyfj/Sf7u
	 AWWDtja1TBmar5MlxXKzvUh1NHp/u4PbasFMDEGq6Oth1C6C+tXOycmFxgvFUAY/bs
	 kgvBDx5ezn+W5P70nd3GTjQXwBhDrR4J3UdzpCkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfENQzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfENQzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:55:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF79F2084A;
        Tue, 14 May 2019 16:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557852914;
        bh=8n63wOgL9cad2rIE8kZV4epVBMV8HjjuhWRqstNew/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ndf/+YurjqS3iWSoa4TtmCCyHbKxML1csn3QVzAQ8NzyZkeVHkcdvZRSLD9N2kIge
         Gbq9WmCXuYBrzVgVxhC1AKXGAnsDeeJiExqP0/tq+U/sTb01im27Tzt7T3XfKjsr88
         HvbDIx262CIjlbdTYmsxeYQm6JzgoDKTTyyJx9y0=
Date:   Tue, 14 May 2019 18:55:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] usb: xhci: Possible resource leaks when xhci_run() fails
Message-ID: <20190514165511.GA28266@kroah.com>
References: <fd7610ec-5f14-7952-cd9a-e56adb4e1353@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7610ec-5f14-7952-cd9a-e56adb4e1353@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 10:58:05PM +0800, Jia-Ju Bai wrote:
> xhci_pci_setup() is assigned to hc_driver.reset;
> xhci_run() is assigned to hc_driver.start();
> xhci_stop() is assigned to hc_driver.stop().
> 
> xhci_pci_setup() calls xhci_gen_setup, which calls xhci_init(). And
> xhci_init() calls xhci_mem_init() to allocate resources.
> 
> xhci_stop() calls xhci_mem_cleanup(), to release the resources allocated in
> xhci_mem_init() (also namely xhci_pci_setup()).
> 
> xhci_run() can fail, because xhci_try_enable_msi() or xhci_alloc_command()
> in this function can fail.
> 
> In drivers/usb/core/hcd.c:
>     retval = hcd->driver->reset(hcd);
>     if (retval < 0) {
>         ......
>         goto err_hcd_driver_setup;
>     }
>     ......
>     retval = hcd->driver->start(hcd);
>     if (retval < 0) {
>         ......
>         goto err_hcd_driver_start;
>     }
>     .......
>     hcd->driver->stop(hcd);
>     hcd->state = HC_STATE_HALT;
>     clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
>     del_timer_sync(&hcd->rh_timer);
> err_hcd_driver_start:
>     if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
>         free_irq(irqnum, hcd);
> err_request_irq:
> err_hcd_driver_setup:
> err_set_rh_speed:
>     usb_put_invalidate_rhdev(hcd);
> err_allocate_root_hub:
>     usb_deregister_bus(&hcd->self);
> err_register_bus:
>     hcd_buffer_destroy(hcd);
> err_create_buf:
>     usb_phy_roothub_power_off(hcd->phy_roothub);
> err_usb_phy_roothub_power_on:
>     usb_phy_roothub_exit(hcd->phy_roothub);
> 
> Thus, when hcd->driver->reset() succeeds and hcd->driver->start() fails,
> hcd->driver->stop() is not called.
> 
> Namely, when xhci_pci_setup() successfully allocates resources, and
> xhci_run() fails, xhci_stop() is not called to release the resources.
> For this reason, resource leaks occur in this case.
> 
> I check the code of the ehci driver, uhci driver and ohci driver, and find
> that they do not have such problem, because:
> In the ehci driver, ehci_run() (namely hcd->driver->start()) never fails.
> In the uhci driver, all the resources are allocated in uhci_start (namely
> hcd->driver->start()), and no resources are allocated in uhci_pci_init()
> (namely hcd->driver->reset()).
> In the ohci driver, ohci_setup() (namely hcd->driver->reset()) also
> allocates resources. But when ohci_start() (namely hcd->driver->start()) is
> going to fail, ohci_stop() is directly called to release the resources
> allocated by ohci_setup().
> 
> Thus, there are two possible ways of fixing bugs:
> 1) Call xhci_stop() when xhci_run() is going to fail (like the ohci driver)
> 2) Move all resource-allocation operations into xhci_run() (like the uhci
> driver).
> 
> I am not sure whether these ways are correct, so I only report bugs.

Can you create a patch to show how you would fix this potential issue?
Given that making this type of thing fail is pretty rare, it's not a
real high priority to get to, so it might be a while for anyone here to
look at it.

thanks,

greg k-h
