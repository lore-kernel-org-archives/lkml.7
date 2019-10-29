Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4ACCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C625E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbfJ2OpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:45:12 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:57863
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbfJ2OpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:45:12 -0400
X-IronPort-AV: E=Sophos;i="5.68,244,1569276000"; 
   d="scan'208";a="325017627"
Received: from ppp-seco11pareq2-46-193-149-47.wb.wifirst.net (HELO hadrien) ([46.193.149.47])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 15:45:08 +0100
Date:   Tue, 29 Oct 2019 15:45:07 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Matthias Maennich <maennich@google.com>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Warning message from 'make nsdeps' when namespace is lower
 cases
In-Reply-To: <20191029143722.GB33177@google.com>
Message-ID: <alpine.DEB.2.21.1910291544180.2144@hadrien>
References: <CAK7LNAQ8Wi1zED0rYJhk9tYi5-jgCoyeHNtofvgKet4ZTzKFcA@mail.gmail.com> <alpine.DEB.2.21.1910291437450.2179@hadrien> <20191029143722.GB33177@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Oct 2019, Matthias Maennich wrote:

> Hi!
>
> On Tue, Oct 29, 2019 at 02:38:36PM +0100, Julia Lawall wrote:
> >
> >
> > On Tue, 29 Oct 2019, Masahiro Yamada wrote:
> >
> > > Hi.
> > >
> > > When I was playing with 'make nsdeps',
> > > I saw a new warning.
> > >
> > > If I rename USB_STORAGE to usb_storage,
> > > I see 'warning: line 15: should usb_storage be a metavariable?'
> > > Why? I think it comes from spatch.
> >
> > Yes, it would come from spatch.
> >
> > > It should be technically OK to use either upper or lower cases
> > > for the namespace name.
> >
> > What is normally wanted?  Uppercase or lowercase?
>
> There is no (documented) preference or convention yet. The existing
> namespaces (USB_STORAGE and MCB) use upper case. While technically both
> should work, I have a personal preference for consistently using upper
> case. Is there a way to suppress this warning as I agree that it might
> be confusing?

The warning is not intentional in this case.  I will have to fix
Coccinelle, but I can't do it until next week.

julia

>
> Cheers,
> Matthias
>
> >
> > julia
> >
> > >
> > > Just apply the following, and try 'make nsdeps'.
> > >
> > >
> > > diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
> > > index 46635fa4a340..6f817d65c26b 100644
> > > --- a/drivers/usb/storage/Makefile
> > > +++ b/drivers/usb/storage/Makefile
> > > @@ -8,7 +8,7 @@
> > >
> > >  ccflags-y := -I $(srctree)/drivers/scsi
> > >
> > > -ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
> > > +ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=usb_storage
> > >
> > >  obj-$(CONFIG_USB_UAS)          += uas.o
> > >  obj-$(CONFIG_USB_STORAGE)      += usb-storage.o
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
> > >
>
