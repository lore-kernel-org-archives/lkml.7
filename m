Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1AFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC99205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712860;
	bh=49j3u6W+B+wmtfk3MiDgPAHpTSsRmaAxd7k+TkSo0dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lMUhtLaDX7GjpfSK4Cbsxma174ncIjv3mEUPEgKmcUy+sdx9Oue9kM8WFr7R9QqaX
	 AQnXzuFEDsq5rW0EIy37AwbGBEDTsajDI+wGpXL8Rna1qoir3dmf1R2g6MDroyjhuI
	 WgC9kzPYpWwAEJJfgSjRVwMAbxMcQijaf1GQtIiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390386AbfC0SyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbfC0SyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:54:15 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C906C205C9;
        Wed, 27 Mar 2019 18:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553712854;
        bh=49j3u6W+B+wmtfk3MiDgPAHpTSsRmaAxd7k+TkSo0dE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5UleUFWmRJDTiksUP0ReTaUoTlG6a39uTLix+u2fuMmKl6C1/wETGHAEHSZb1CIY
         fPvRNMD8n7nt3qNdehDNRtcSUMoSnEeMkpsJr++PGYWICyhvEyU4fPAJwpgT84PxZy
         jr+GudYdtg/b71oW3SMJsOlS3IcF6PkLhd7CRvfw=
Date:   Wed, 27 Mar 2019 19:54:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Patrick Venture <venture@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v7 2/2] drivers/misc: Add Aspeed P2A control driver
Message-ID: <20190327185410.GA14828@kroah.com>
References: <20190312163101.155910-1-venture@google.com>
 <20190327164542.GC11712@kroah.com>
 <CAO=notxFvvOmpjMyXvt5PyuWsB92eraN+=8mWk8_aY2w3sK-eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO=notxFvvOmpjMyXvt5PyuWsB92eraN+=8mWk8_aY2w3sK-eQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:44:36AM -0700, Patrick Venture wrote:
> On Wed, Mar 27, 2019 at 11:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 12, 2019 at 09:31:01AM -0700, Patrick Venture wrote:
> > > +     phys_addr_t mem_base;
> >
> > Is this really a 32bit value?
> 
> It's going to be a 32-bit value if this is in the dts for one of the
> correspondingly supported aspeed models.
> 
> >
> > Your ioctl thinks it is:
> >
> > > +struct aspeed_p2a_ctrl_mapping {
> > > +     __u32 addr;
> >
> > Does this driver not work on a 64bit kernel?
> 
> This driver is aimed at only 32-bit hardware (ast2400/2500).  I
> modeled the approach after the aspeed-lpc-ctrl driver as it's
> providing similar functionality.
> 
> >
> > > +     __u32 length;
> > > +     __u32 flags;
> > > +};
> >
> > addr really should be __u32 here so you don't have to mess with 32/64
> > bit user/kernel issues, right?
> 
> Add is __u32 there.  Are you suggesting it shouldn't be?

Ugh, yes, sorry, I meant to say "__u64".

If you all insist that this is all that is ever going to be needed, ok,
but I reserve the right to complain in 4 years when this needs to be
changed :)

thanks,

greg k-h
