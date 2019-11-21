Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F786C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B3D20872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKUHII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:08:08 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:50070 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUHII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:08:08 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 0C9B9200AA9;
        Thu, 21 Nov 2019 07:08:06 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id A7639200A0; Thu, 21 Nov 2019 08:07:32 +0100 (CET)
Date:   Thu, 21 Nov 2019 08:07:32 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        viro@zeniv.linux.org.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] char: pcmcia: a possible concurrency double-free bug in
 rx_alloc_buffers()
Message-ID: <20191121070732.GA126007@light.dominikbrodowski.net>
References: <76309f04-b1e1-11d3-b77f-962bf50c5be2@gmail.com>
 <20190107085724.GC26384@kroah.com>
 <1a20e64b-7e2f-9ea1-657d-b0b997092738@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a20e64b-7e2f-9ea1-657d-b0b997092738@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 05:33:43PM +0800, Jia-Ju Bai wrote:
> 
> 
> On 2019/1/7 16:57, Greg KH wrote:
> > On Mon, Jan 07, 2019 at 04:12:22PM +0800, Jia-Ju Bai wrote:
> > > In drivers/char/pcmcia/synclink_cs.c, the functions mgslpc_open() and hdlcdev_open() can be concurrently executed.
> > > 
> > > hdlcdev_open
> > >    startup
> > >      claim_resources
> > >        rx_alloc_buffers
> > >          line 2641: kfree(info->rx_buf)
> > > 
> > > mgslpc_open
> > >    startup
> > >      claim_resources
> > >        rx_alloc_buffers
> > >          line 2641: kfree(info->rx_buf)
> > > 
> > > Thus, a possible concurrency double-free bug may occur.
> > Wait, are you sure those really are the same structure, and that those
> > two functions can be called at the same time?  That is a tty and a
> > network device, are they both created at the same time or does opening
> > one create the other?
> 
> hdlcdev_open() is assigned to "hdlcdev_ops.ndo_open".
> mgslpc_open() is assigned to "mgslpc_ops.open".
> They are indeed assigned to the fields in different data structures.
> 
> **** For hdlcdev_open() ****
> In hdlcdev_init():
>     dev->netdev_ops = &hdlcdev_ops;
>     rc = register_hdlc_device(dev);
> Thus, hdlcdev_open() can be called after "register_hdlc_device(dev)".
> 
> hdlcdev_init() is called by mgslpc_add_device(), which is called by
> mgslpc_probe().
> mgslpc_probe() is assigned to "mgslpc_driver.probe".
> 
> In synclink_cs_init():
>     rc = pcmcia_register_driver(&mgslpc_driver);
> Thus, mgslpc_probe() can be called after
> "pcmcia_register_driver(&mgslpc_driver)".
> 
> As a result, hdlcdev_open() can be executed in synclink_cs_init().
> 
> **** For mgslpc_open() ****
> In synclink_cs_init():
>     tty_set_operations(serial_driver, &mgslpc_ops);
>     rc = tty_register_driver(serial_driver);
> Thus, mgslpc_open() can be called after
> "tty_register_driver(serial_driver)".
> 
> As a result, mgslpc_open() can be executed in synclink_cs_init().
> 
> **** For hdlcdev_open() and mgslpc_open() ****
> Because mgslpc_open() and hdlcdev_open() can be both executed in
> synclink_cs_init(), I think they can be concurrently executed.
> 
> 
> > 
> > It's not obvious in looking at the code if this really is the same
> > structure or not, how did your tool figure it out?
> 
> My tool uses the data structure field "info->rx_buf" in the code, so it
> cannot very accurately figure it out.
> 
> According to my code review, hdlcdev_open() and mgslpc_open() both call
> "startup(info, tty)", and rx_alloc_buffers() calls kfree(info->rx_buf).
> Thus, an important thing is that whether the variable "info" in
> hdlcdev_open() and mgslpc_open() can be the same?
> I find this code in hdlcdev_open():
>     /* arbitrate between network and tty opens */
>     spin_lock_irqsave(&info->netlock, flags);
> 
> Thus, the variable "info" in hdlcdev_open() and mgslpc_open() can be the
> same, and "info->rx_buf" in the two calls to kfree() can be the same.
> 
> To fix this bug, I think we can reuse the spinlock "info->netlock" to
> protect the function startup() in hdlcdev_open() and mgslpc_open().
> But in rx_alloc_buffers(), there are kmalloc(GFP_KERNEL) and
> kzalloc(GFP_KERNEL).
> If we reuse the spinlock, we also need to change GFP_KERNEL to GFP_ATOMIC.
> What is your opinion?

AFAICS, this is a non-issue: If hdlcdev_open() is called, it sets
info->netcount=1. If info->netcount!=0, mgslpc_open() will abort before
calling startup(). And if mgslpc_open() is called, it sets info->count=1,
causing hdlcdev_open() to fail before calling startup(). So no risk of
concurrency here.

Best,
	Dominik
