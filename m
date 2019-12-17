Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD0EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FC62082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576584320;
	bh=b7idOAhKkeMMLcy66bx1nIPNb7SOC12CKcpdNoBbzrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K7PEFGLM8w1UlFKeE8CuNWeNcMG73jZFhIjADtQVuKHWxrypcKGZb/MZaCH5JyiEB
	 Mk9yJvFEEtqdJfv5AubGQPmGaayKYbKy6JqnPJMFwb62Xn2NJCTgTMaPZfPWzc5ZM0
	 h/o7N1js1OC41VhlZ7gwgh8OlO3hFY4gusZShuaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLQMFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfLQMFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:05:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 941B7207FF;
        Tue, 17 Dec 2019 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576584318;
        bh=b7idOAhKkeMMLcy66bx1nIPNb7SOC12CKcpdNoBbzrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ha9fregj8WHmJhnFO1fnhqZ7phuKEyTTasFGOHha+PtGCSFPbynTGWmCOcEAmtdmM
         r8Xav1LFqxbiT5VwJQS6pLNp6LA+kSdnXKkOWDpsOYg9XiU/jQyTavISQYFS4iefWs
         rnhT0UiSC4znajoS8KNZeR6EgTXbjXiUv+/A4qzU=
Date:   Tue, 17 Dec 2019 13:05:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] tty: use tty_init_dev_retry() to workaround a
 race condition
Message-ID: <20191217120515.GA3156341@kroah.com>
References: <20191121152239.28405-1-sudipm.mukherjee@gmail.com>
 <20191121152239.28405-2-sudipm.mukherjee@gmail.com>
 <20191121164138.GD651886@kroah.com>
 <20191121210155.limd7v6cpd5yz2e7@debian>
 <eef58b47-f208-2ac5-6e02-a87f9568c70f@suse.com>
 <20191210114147.ivple4ccr4bj6c4h@debian>
 <20191212111519.GA1534818@kroah.com>
 <CADVatmMK=dCaAzdHbmQ6Qj5gqcvSiL3BRZDL6jnEM2G_C3pUpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmMK=dCaAzdHbmQ6Qj5gqcvSiL3BRZDL6jnEM2G_C3pUpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:47:25AM +0000, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Thu, Dec 12, 2019 at 11:15 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Dec 10, 2019 at 11:41:47AM +0000, Sudip Mukherjee wrote:
> > > Hi Jiri,
> > >
> > > On Fri, Nov 22, 2019 at 10:05:09AM +0100, Jiri Slaby wrote:
> > > > On 21. 11. 19, 22:01, Sudip Mukherjee wrote:
> > > > > Hi Greg,
> > > > >
> > > > > On Thu, Nov 21, 2019 at 05:41:38PM +0100, Greg Kroah-Hartman wrote:
> > > > >> On Thu, Nov 21, 2019 at 03:22:39PM +0000, Sudip Mukherjee wrote:
> > > > >>> There seems to be a race condition in tty drivers and I could see on
> > > > >>> many boot cycles a NULL pointer dereference as tty_init_dev() tries to
> > > > >>> do 'tty->port->itty = tty' even though tty->port is NULL.
> > > <snip>
> > > > >>>
> > > > >>> uart_add_one_port() registers the console, as soon as it registers, the
> > > > >>> userspace tries to use it and that leads to tty_open() but
> > > > >>> uart_add_one_port() has not yet done tty_port_link_device() and so
> > > > >>> tty->port is not yet configured when control reaches tty_init_dev().
> > > > >>
> > > > >> Shouldn't we do tty_port_link_device() before uart_add_one_port() to
> > > > >> remove that race?  Once you register the console, yes, tty_open() can
> > > > >> happen, so the driver had better be ready to go at that point in time.
> > > > >>
> > > > >
> > > > > But tty_port_link_device() is done by uart_add_one_port() itself.
> > > > > After registering the console uart_add_one_port() will call
> > > > > tty_port_register_device_attr_serdev() and tty_port_link_device() is
> > > > > called from this. Thats still tty core.
> > > >
> > > > Interferences of console vs tty code are ugly. Does it help to simply
> > > > put tty_port_link_device to uart_add_one_port before uart_configure_port?
> > >
> > > sorry for the late response, got busy with an out-of-tree driver.
> > >
> > > It fixes the problem if I put tty_port_link_device() before
> > > uart_configure_port(). Please check the attached patch and that
> > > completely fixes the problem. Do you want me to send a proper patch for
> > > it or do you want me to check more into it?
> >
> > This looks a lot more sane to me, can you resend it in proper format so
> > that I can apply it?
> 
> https://lore.kernel.org/lkml/20191212131602.29504-1-sudipm.mukherjee@gmail.com/

It's in my "to review" queue, don't worry, not lost :)
