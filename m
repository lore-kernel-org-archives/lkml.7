Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50345C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A5920881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557929727;
	bh=9oT0KsgoIHKp1gaIA3yGnSWjzLgttcSJqWsnHuMFklU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UGU6o/2rBJ1ZI37P+c0GCFrATL83h3VXH8LaDX6RU9tbvaYrsifkpRZUy4Xscy+7n
	 jPR4+iDU49WN+cE/JhcdCPxx59E/fDcnvmIjJBfWsT4zbipdIucXGiaRPdF46jdGOd
	 osfTWdCV3Pek6PuRMDylujpbuf/7QgSrSzdnilMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfEOOP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfEOOPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:15:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6447F2084E;
        Wed, 15 May 2019 14:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557929724;
        bh=9oT0KsgoIHKp1gaIA3yGnSWjzLgttcSJqWsnHuMFklU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cymAmOBxyc1GTsEjFYm1jEEF6fF6ucwbLlFcVy2JUemumbYGXIUAaHBENIdwaXGtQ
         Mo7G53E/Odw8uc2jvKrtkir0KuwxNzwtx1jzqSUEWS3JtVJt5MFoAzkVWiMzBfYKvr
         LEJV4MU7MjXrMViY2dKAYcBUlOU+oAz5guTRnMw4=
Date:   Wed, 15 May 2019 16:15:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bsr: do not use assignment in if condition
Message-ID: <20190515141521.GA8999@kroah.com>
References: <20190515131524.26679-1-parna.naveenkumar@gmail.com>
 <20190515133230.GB5316@kroah.com>
 <CAKXhv7csf3Qys4KsN+OJuPwb4daakC3U93boUwxd3t-9D9uNQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXhv7csf3Qys4KsN+OJuPwb4daakC3U93boUwxd3t-9D9uNQw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 07:16:37PM +0530, Naveen Kumar Parna wrote:
> On Wed, 15 May 2019 at 19:02, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, May 15, 2019 at 06:45:24PM +0530, parna.naveenkumar@gmail.com
> > wrote:
> > > From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> > >
> > > checkpatch.pl does not like assignment in if condition
> > >
> > > Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> > > ---
> > >  drivers/char/bsr.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
> > > index a6cef548e01e..2b00748b83d2 100644
> > > --- a/drivers/char/bsr.c
> > > +++ b/drivers/char/bsr.c
> > > @@ -322,7 +322,8 @@ static int __init bsr_init(void)
> > >               goto out_err_2;
> > >       }
> > >
> > > -     if ((ret = bsr_create_devs(np)) < 0) {
> > > +     ret = bsr_create_devs(np);
> > > +     if (ret  < 0) {
> >
> > Checkpatch also probably does not like that if statement :(
> >
> I ran checkpatch script and it did not show any warning or error.
> 
> $ ./scripts/checkpatch.pl
> 0001-bsr-do-not-use-assignment-in-if-condition.patch
> total: 0 errors, 0 warnings, 9 lines checked
> 0001-bsr-do-not-use-assignment-in-if-condition.patch has no obvious style
> problems and is ready for submission.

Ok, then checkpatch missed it, but your eyes should have caught it.

When you are doing code style fixes outside of the drivers/staging/
area, you need to be very careful to be sure to get it right, as many
maintainers do not like the churn.

Please fix this up and resend.

thanks,

greg k-h
