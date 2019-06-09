Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E76C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956AD2083D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560078435;
	bh=BoVXawOIy+yoXWu7Sh5tusd2+DJEUCMI4+wVXPSiYoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R8w9XX8khIoBW4+HaGyhsq2MUIZ0j24QUPp42MPCD71/QzRayXZEm4g2z3OsSglGA
	 g/RipEW4dNgQ8IfzlGXz3xrtOgz/ntP6Qe3pk/mqRLTTGWpNjz7brD8jkqA19T51iu
	 bVfe4/z63O/PBuH8Amy5fJwLgclahA3owAq4xzoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfFILHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfFILHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:07:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FD92083D;
        Sun,  9 Jun 2019 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560078433;
        bh=BoVXawOIy+yoXWu7Sh5tusd2+DJEUCMI4+wVXPSiYoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zmr0Iy4glMkx23TrS5wmlVRG9KaBxeJ2RSz3E+odSlQ2p1xlxRSBszUfvTM8Yp/ak
         QELHA1+QuS3NnMyptffrQ2fNyJGdbB2RSdJMiRZUrp3RWfyuXmASwXHgWL7CUVXz79
         jcI+q/tAdNlReep8A/Lste96R2UEOWD9EUVg7a38=
Date:   Sun, 9 Jun 2019 13:07:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geordan Neukum <gneukum1@gmail.com>
Cc:     Hao Xu <haoxu.linuxkernel@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: kpc2000: kpc2000_i2c: void* -> void *
Message-ID: <20190609110711.GA5666@kroah.com>
References: <1559978867-3693-1-git-send-email-haoxu.linuxkernel@gmail.com>
 <20190608134505.GA963@arch-01.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608134505.GA963@arch-01.home>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 01:45:05PM +0000, Geordan Neukum wrote:
> On Sat, Jun 08, 2019 at 03:27:46PM +0800, Hao Xu wrote:
> > modify void* to void * for #define inb_p(a) readq((void*)a)
> > and #define outb_p(d,a) writeq(d,(void*)a)
> > 
> > Signed-off-by: Hao Xu <haoxu.linuxkernel@gmail.com>
> > ---
> >  drivers/staging/kpc2000/kpc2000_i2c.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
> > index a434dd0..de3a0c8 100644
> > --- a/drivers/staging/kpc2000/kpc2000_i2c.c
> > +++ b/drivers/staging/kpc2000/kpc2000_i2c.c
> > @@ -124,9 +124,9 @@ struct i2c_device {
> >  
> >  // FIXME!
> >  #undef inb_p
> > -#define inb_p(a) readq((void*)a)
> > +#define inb_p(a) readq((void *)a)
> >  #undef outb_p
> > -#define outb_p(d,a) writeq(d,(void*)a)
> > +#define outb_p(d,a) writeq(d,(void *)a)
> 
> Alternatively to fixing up the style here, did you consider just
> removing these two macros altogether and calling [read|write]q
> directly throughout the kpc_i2c driver (per the '//FIXME' comment)?
> 
> Unless, I'm misunderstanding something, these macros are shadowing the
> functions [in|out]b_p, which already exist in io.h. [in|out]b_p are for
> 8-bit i/o transactions and [read|write]q are for 64-bit transactions, so
> shadowing the original [in|out]b_p with something that actually does
> 64-bit transactions is probably potentially misleading here.

Yes, these should be fixed up "properly".  But I'll take the coding
style cleanups for now.

thanks,

greg k-h
