Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B4CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9208F20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdb11PGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439082AbfFLMoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:44:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51100 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfFLMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:44:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so6440268wmf.0;
        Wed, 12 Jun 2019 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SodGvDNuEqVdF6QsPWL21qwN7WUNZ/wWJeCs4cM+3TA=;
        b=Tdb11PGej+gGN4BTnOqMLPD3CMwFvf27tv/eF0e2JD4T3vbJwSANESetelgMLHp9mL
         y5V2om7gUVQ6Wxr7mA1WYNLXb0z5t2YEbMNXRZZZg+Uqwss4FKBPseD0pWbBpNjcZuXy
         HubxlxmtpTn/Q3fs+1gnfZ9hNeyaRvlKO/uk75Z9LMYCGU85/couXbHdfA57BgN8aKvU
         uC+iAdyFWgHhQ/WXXVNG21VMUsCkxn/V+Pe3ECgb+vj2qSXLPjWpdyauezOHMGf89AgB
         LtOO06eNVNsjAtFvUrD+cPJ+svYS1yviSJBo/9+1bmwlCQRUkO63RhNnv/4xiZzbfY5g
         sXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SodGvDNuEqVdF6QsPWL21qwN7WUNZ/wWJeCs4cM+3TA=;
        b=raIu4k9Z1cTMIISlyxH3skS5YqTlf5iUOjdrMFRAPUU3S8u6NnI8NVi1xrSerhgGh4
         19yROBfNnzPD4fz/wc3qJxaIMAQek0NpQ9X5JS7eECtrxvXN720lP5B+Wv1aLfMag3Z6
         Bob6vwUXG69RfXig+A1PMrmdUOCX5JJmpJCG8G5z0+fm8G7SmREuFN8UWHUDmf0clp21
         bCH1G+fXoyLzHfcqJ4irL5ACLNz6K2cqOE+87ZnAxyiXM1gXyvdpLP5qq792Nk8FRs8f
         xcmp2Sp0TaLAQDidBUSAKhSU2VFbJU4mUCCMnSWj4to+jP+7ospXjWDxoQ50N3n+u9N5
         Ef7Q==
X-Gm-Message-State: APjAAAUtTNYVXScgj2FQvrXSktPJYGqulUUZEKEy0qDfIV7cJ5oWwc4m
        NGBL6U8bRmotq1/NYXxK4Mo=
X-Google-Smtp-Source: APXvYqw6aWXhnlBwsHOrkqfNZ1qvYvt3T1wVTVge1fwYuXw9hUKUbVOhnQdQ2XIVmSfQZa1VcTdJ2w==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr21106935wmg.69.1560343452839;
        Wed, 12 Jun 2019 05:44:12 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l17sm16467263wrq.37.2019.06.12.05.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 05:44:11 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:44:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dvhart@infradead.org, andy@infradead.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] platform: x86: dell-laptop: no need to check return
 value of debugfs_create functions
Message-ID: <20190612124411.nbjslftjtc72a25v@pali>
References: <20190612121258.19535-1-gregkh@linuxfoundation.org>
 <20190612121258.19535-3-gregkh@linuxfoundation.org>
 <20190612122105.miyyfkmae24kddwt@pali>
 <20190612123604.GB25718@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612123604.GB25718@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 June 2019 14:36:04 Greg Kroah-Hartman wrote:
> On Wed, Jun 12, 2019 at 02:21:05PM +0200, Pali Rohár wrote:
> > On Wednesday 12 June 2019 14:12:53 Greg Kroah-Hartman wrote:
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > > 
> > > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> > > Cc: "Pali Rohár" <pali.rohar@gmail.com>
> > > Cc: Darren Hart <dvhart@infradead.org>
> > > Cc: Andy Shevchenko <andy@infradead.org>
> > > Cc: platform-driver-x86@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/platform/x86/dell-laptop.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> > > index a561f653cf13..94a2f259031c 100644
> > > --- a/drivers/platform/x86/dell-laptop.c
> > > +++ b/drivers/platform/x86/dell-laptop.c
> > > @@ -2176,9 +2176,8 @@ static int __init dell_init(void)
> > >  	kbd_led_init(&platform_device->dev);
> > >  
> > >  	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
> > > -	if (dell_laptop_dir != NULL)
> > > -		debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> > > -				    &dell_debugfs_fops);
> > > +	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> > > +			    &dell_debugfs_fops);
> > 
> > Hi!
> > 
> > So... debugfs_create_dir() can return NULL, right?
> 
> Nope.

Yea, now I see implementation. It does not return NULL on error, but
rather ERR_PTR.

So dell_laptop_dir is always not-NULL. And that check was wrong.

You can add my
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

> > And it is then OK to call
> > debugfs_create_file("rfkill", 0444, dell_laptop_dir, ...) with
> > dell_laptop_dir = NULL?
> 
> Yes.
> 
> > Where would be that "rfkill" file created?
> 
> The root of debugfs.
> 
> But, if debugfs_create_dir() return an error, and you pass that value
> into debugfs_create_file() it will happily just return an error back
> again, and move on.
> 
> So it is always safe to pass the return value of one debugfs call into
> another, no need to check anything.  If the system is so messed up that
> debugfs_create_dir() fails (i.e. you are out of memory), failing to
> create a debugfs file is the least of your worries :)
> 
> And even then, no need to change your code logic, the functionality of
> your code should never depend on if debugfs is working properly at the
> moment or not.
> 
> thanks,
> 
> greg k-h

-- 
Pali Rohár
pali.rohar@gmail.com
