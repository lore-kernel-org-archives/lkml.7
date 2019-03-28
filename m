Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D439621773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553755958;
	bh=kd8a4YTiA768T71fL+kuMWtjxlGwrVwkoT4Uyxf3KQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kA6y/JXxy1YDgCVkwmuVbNJih8YDN1ayVrRRCeMwRmYmg/PvSZH7AromiSFFGliAR
	 avPXmVyd4ND7dBztu2Hn0LFEPZtAoEaWIOc8fw8P2nKVLO2mPsGgi2tpKk5uvrYVic
	 NWBaLE6BkRUfwI8SLJgmJUT3G+XvF32/P/ribOdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1Gwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfC1Gwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:52:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158C52075E;
        Thu, 28 Mar 2019 06:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553755956;
        bh=kd8a4YTiA768T71fL+kuMWtjxlGwrVwkoT4Uyxf3KQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8mKNe9y7DJnG1Io/I/JWe6CVVvIQnN+vOBDmsbEhwBMY3gK/ZTo9tNAltJf2Nh6P
         gzqmzFmsDeChDTRy6ACzmwlgtx25dA4tUkyhaqzeg5KDqfLm1DEDCgspBfLIR0387K
         gD1TuOZI8Evwm7MXfAbnt9rRgWYnvCd8ka09WfVk=
Date:   Thu, 28 Mar 2019 07:52:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Patrick Venture <venture@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v7 2/2] drivers/misc: Add Aspeed P2A control driver
Message-ID: <20190328065231.GB20312@kroah.com>
References: <20190312163101.155910-1-venture@google.com>
 <20190327164542.GC11712@kroah.com>
 <CAO=notxFvvOmpjMyXvt5PyuWsB92eraN+=8mWk8_aY2w3sK-eQ@mail.gmail.com>
 <20190327185410.GA14828@kroah.com>
 <CAO=notzwnDtJ9jmEUDsy_tqVKH-+4rO9gd8rpVjKKvQqJsODTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO=notzwnDtJ9jmEUDsy_tqVKH-+4rO9gd8rpVjKKvQqJsODTQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 12:01:50PM -0700, Patrick Venture wrote:
> On Wed, Mar 27, 2019 at 11:54 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Mar 27, 2019 at 11:44:36AM -0700, Patrick Venture wrote:
> > > On Wed, Mar 27, 2019 at 11:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Mar 12, 2019 at 09:31:01AM -0700, Patrick Venture wrote:
> > > > > +     phys_addr_t mem_base;
> > > >
> > > > Is this really a 32bit value?
> > >
> > > It's going to be a 32-bit value if this is in the dts for one of the
> > > correspondingly supported aspeed models.
> > >
> > > >
> > > > Your ioctl thinks it is:
> > > >
> > > > > +struct aspeed_p2a_ctrl_mapping {
> > > > > +     __u32 addr;
> > > >
> > > > Does this driver not work on a 64bit kernel?
> > >
> > > This driver is aimed at only 32-bit hardware (ast2400/2500).  I
> > > modeled the approach after the aspeed-lpc-ctrl driver as it's
> > > providing similar functionality.
> > >
> > > >
> > > > > +     __u32 length;
> > > > > +     __u32 flags;
> > > > > +};
> > > >
> > > > addr really should be __u32 here so you don't have to mess with 32/64
> > > > bit user/kernel issues, right?
> > >
> > > Add is __u32 there.  Are you suggesting it shouldn't be?
> >
> > Ugh, yes, sorry, I meant to say "__u64".
> >
> > If you all insist that this is all that is ever going to be needed, ok,
> > but I reserve the right to complain in 4 years when this needs to be
> > changed :)
> 
> In the event the ast2600 comes out and is 64-bit -- I can't imagine
> that's likely to happen.  I can take solace that this won't be the
> only thing that needs retrofitting.  But it wouldn't kill me to just
> make the change.  I'll just have to tweak it to return failure in the
> event the address provided isn't found in any region...
> 
> Is that all that needs to change for 64-bit addressing support - given
> your read of the driver?

That's all that I noticed at first glance, yes.  I do dislike having
custom user/kernel apis for random chips like this, but I don't know of
a way to have a generic api for them at the moment as I really do not
know what these chips do :(

One would think that the firmware api would work for you, but given the
complexity here, it does not seem that it would match up.

thanks,

greg k-h
