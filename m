Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F0AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFA3208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560343637;
	bh=0QvY7pijT10DSAiLLHjqi4qCfFoPRdRX7HMvtEV5wN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Ig5gaOl4k19ZvS6po77yBN2FmtN/dOu08C2AxqIMWR0AIKGrtpVEHSf3lDAdCc3e
	 t6IOzQzsF9cyLT5vT/XVXQfSRoxnFFVhywtfqbR/VmW4OG0coTVN5+RhPMf8qSYwRd
	 tWZvJIKS8G5FkyBddu7g2r9FfIwt5DyZJ7Zg7urg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439154AbfFLMrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439095AbfFLMrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:47:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E31E420896;
        Wed, 12 Jun 2019 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560343635;
        bh=0QvY7pijT10DSAiLLHjqi4qCfFoPRdRX7HMvtEV5wN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjpWAxSkI/pC+ujjMnp6AHoaiEDUP2ckPWYQe7N+Ye0p75V426/yNLif79folKA3C
         HR75eVjdFXYhaAtI8iQSosERcI5DyvZmF+uF5GCezLg0anhDqCrz/MseAa0BemOJa0
         yOBIeyT5c8nJCaHTylDYm6XRndIeLZjsnCRD5v+Q=
Date:   Wed, 12 Jun 2019 14:47:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     dvhart@infradead.org, andy@infradead.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] platform: x86: dell-laptop: no need to check return
 value of debugfs_create functions
Message-ID: <20190612124713.GA27788@kroah.com>
References: <20190612121258.19535-1-gregkh@linuxfoundation.org>
 <20190612121258.19535-3-gregkh@linuxfoundation.org>
 <20190612122105.miyyfkmae24kddwt@pali>
 <20190612123604.GB25718@kroah.com>
 <20190612124411.nbjslftjtc72a25v@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612124411.nbjslftjtc72a25v@pali>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 02:44:11PM +0200, Pali Rohár wrote:
> On Wednesday 12 June 2019 14:36:04 Greg Kroah-Hartman wrote:
> > On Wed, Jun 12, 2019 at 02:21:05PM +0200, Pali Rohár wrote:
> > > On Wednesday 12 June 2019 14:12:53 Greg Kroah-Hartman wrote:
> > > > When calling debugfs functions, there is no need to ever check the
> > > > return value.  The function can work or not, but the code logic should
> > > > never do something different based on this.
> > > > 
> > > > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> > > > Cc: "Pali Rohár" <pali.rohar@gmail.com>
> > > > Cc: Darren Hart <dvhart@infradead.org>
> > > > Cc: Andy Shevchenko <andy@infradead.org>
> > > > Cc: platform-driver-x86@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  drivers/platform/x86/dell-laptop.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> > > > index a561f653cf13..94a2f259031c 100644
> > > > --- a/drivers/platform/x86/dell-laptop.c
> > > > +++ b/drivers/platform/x86/dell-laptop.c
> > > > @@ -2176,9 +2176,8 @@ static int __init dell_init(void)
> > > >  	kbd_led_init(&platform_device->dev);
> > > >  
> > > >  	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
> > > > -	if (dell_laptop_dir != NULL)
> > > > -		debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> > > > -				    &dell_debugfs_fops);
> > > > +	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> > > > +			    &dell_debugfs_fops);
> > > 
> > > Hi!
> > > 
> > > So... debugfs_create_dir() can return NULL, right?
> > 
> > Nope.
> 
> Yea, now I see implementation. It does not return NULL on error, but
> rather ERR_PTR.
> 
> So dell_laptop_dir is always not-NULL. And that check was wrong.
> 
> You can add my
> Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

Thanks!

greg k-h
