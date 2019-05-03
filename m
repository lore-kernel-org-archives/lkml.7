Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5B9C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACD52089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864841;
	bh=ikQLO6/eT8HrwZPXkoqVkYn9ngP4X/Js5fRaLyLbP2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rgl1HsoNZzALNywg+r0is5+H9zv27HXcCaZZDP+8jziX0OWi9wXTHFic0ZBsZxrxF
	 BtWgieYfkvjg1KC2HvN19UVkgvyxw6Zxzvd797rXVDVsySuQD70VJt0Ub5GZSIPMOJ
	 JimW3eCwao5kX/sxTDbTPCwqofhqen/2UPHUyZMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfECG1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfECG1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:27:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70DF8206DF;
        Fri,  3 May 2019 06:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556864838;
        bh=ikQLO6/eT8HrwZPXkoqVkYn9ngP4X/Js5fRaLyLbP2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKa9M0rUa2nDqQCp72/jGuaDLrrdJtXOwRQ9CtuZTH+Gk2RkwGryJiyrAshl8oqE8
         nxE1vmI8F+0YCq7hoeIO3O0JtfPoDD4wBEZPvSjjg3FI798TcgYQKTuqCr0R+X1T1X
         WSaCNE37x6cVf7VhYGkdyrek53pNjCU5OWLD67uY=
Date:   Fri, 3 May 2019 08:27:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, cl@linux.com,
        tycho@tycho.ws, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: clean up the kobject add documentation a bit
 more
Message-ID: <20190503062716.GA8960@kroah.com>
References: <20190427081330.GA26788@eros.localdomain>
 <20190427192809.GA8454@kroah.com>
 <20190501215616.GD18827@eros.localdomain>
 <20190502071742.GC16247@kroah.com>
 <20190502072808.GA14064@kroah.com>
 <20190502081918.GA18363@eros.localdomain>
 <20190502102224.GA15012@kroah.com>
 <20190503012529.GB7416@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503012529.GB7416@eros.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 11:25:29AM +1000, Tobin C. Harding wrote:
> On Thu, May 02, 2019 at 12:22:24PM +0200, Greg Kroah-Hartman wrote:
> > Commit 1fd7c3b438a2 ("kobject: Improve doc clarity kobject_init_and_add()")
> > tried to provide more clarity, but the reference to kobject_del() was
> > incorrect.  Fix that up by removing that line, and hopefully be more explicit
> > as to exactly what needs to happen here once you register a kobject with the
> > kobject core.
> > 
> > Cc: Tobin C. Harding <tobin@kernel.org>
> > Fixes: 1fd7c3b438a2 ("kobject: Improve doc clarity kobject_init_and_add()")
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index 3f4b7e95b0c2..f2ccdbac8ed9 100644
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -416,8 +416,12 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
> >   *         to this function be directly freed with a call to kfree(),
> >   *         that can leak memory.
> >   *
> > - *         If this call returns successfully and you later need to unwind
> > - *         kobject_add() for the error path you should call kobject_del().
> > + *         If this function returns success, kobject_put() must also be called
> > + *         in order to properly clean up the memory associated with the object.
> > + *
> > + *         In short, once this function is called, kobject_put() MUST be called
> > + *         when the use of the object is finished in order to properly free
> > + *         everything.
> >   */
> >  int kobject_add(struct kobject *kobj, struct kobject *parent,
> >  		const char *fmt, ...)
> 
> Ack! (Do I get to do those :)

Yes you do, thanks, now added to the patch and queued up.

greg k-h
