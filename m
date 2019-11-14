Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C25C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7592206E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573703272;
	bh=xUwCDNjkHhFhbCYz6R0V7HBpEO36wYc8OSVLjNz91h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WeGH2GFyhtfGvGpT/7Qyo/yqbJbjIjMPgDhqp8QuohZhCuRpoZXnhAWWKQ2xnp9R1
	 fmFVYSFDsJu4jeqNGGLQ7womtPTZDdP7xfJdeU89ICIn6AL80mSD7tBlo4xhQUSKB3
	 IjAhe+SySwKMhgo2sEUKxbnSKP/bLt2rs73ehrQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKNDrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 22:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfKNDru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 22:47:50 -0500
Received: from localhost (unknown [124.219.31.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4720206E1;
        Thu, 14 Nov 2019 03:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573703270;
        bh=xUwCDNjkHhFhbCYz6R0V7HBpEO36wYc8OSVLjNz91h0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXX99mkhvZAktUDdROtjjSRsXaVK3DorFc85wrSnj76qR19D4b1BfuUI5hTS5istl
         kGr9Ck5GJPdvUg9Hb2b0DMcnrdGLJ55HldVoKEogyEaYucH9Msgvnf1mevj8zeJQyf
         4A+mfpLJBIbU67oADMwhIP26K8txA8F170cL7W/I=
Date:   Thu, 14 Nov 2019 11:47:47 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: samsung: rename to fix build warning
Message-ID: <20191114034747.GA188438@kroah.com>
References: <20191018194707.27188-1-sudipm.mukherjee@gmail.com>
 <20191104164351.GA2269025@kroah.com>
 <CADVatmMzZ9AByeUBtqdrfE_apK58oMYLxSuBrDdLh2XTQzKE9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmMzZ9AByeUBtqdrfE_apK58oMYLxSuBrDdLh2XTQzKE9A@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 03:18:38PM +0000, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Mon, Nov 4, 2019 at 4:43 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Oct 18, 2019 at 08:47:07PM +0100, Sudip Mukherjee wrote:
> > > The build of arm allmodconfig gives a warning:
> > >
> > > warning: same module names found:
> > >   drivers/tty/serial/samsung.ko
> > >   drivers/mtd/nand/onenand/samsung.ko
> > >
> > > Rename drivers/tty/serial/samsung.c to drivers/tty/serial/samsung_tty.c
> > > to fix the warning.
> > >
> <snip>
> >
> >
> > What are you going to break if you rename this module?
> 
> hopefully nothing.
> 
> >
> > What configs enable both of these other than allmodconfig?  Why rename
> > the tty driver and not the mtd driver?  Why not both?
> 
> But, there is no other config defined which has both enabled. Though I can
> make one, but since it is not defined and no one else has reported this, I think
> its better if you discard this. ( I think you already have :) )  or if
> you want I can
> send a v2 renaming both.

Let's rename both and cause equal pain :)

thanks,

greg k-h
