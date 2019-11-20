Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFB4C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CF020715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6TE3oEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfKTPzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:55:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32772 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731558AbfKTPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:55:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so1522825wmi.0;
        Wed, 20 Nov 2019 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ITdp6Cvx22Mvj0C3ifwRHj6Rcd3lphMvacHtAaG57qc=;
        b=B6TE3oEvst7ihyrpJR0zF+gUuWQd/9/UqSy4gEs7FbF5aO6ZvaxQWBW/aB+FOJYjYy
         3FjEoS6viLBiQUQCSlwWPAU6p5of7c7qwl2JPllC1LoNpKwig6rZqxYEZ+xtUAJiT3v1
         RPWXVjogio8MwyNSHQ70jVQSQ3pVDssspKfhgh3M6BMciw+5TJncOn8g++ZKiKYLEFpE
         +z5XVqUf3ictUVsq0GFVTGSNx2pyWla00GmDtrUS2isrC5BOCa1JNg5dghWoqZW6+EAb
         XKLbAajDE+qwZLOVRh9bEcd/PKAakG6Y8vTIvU7pXkJpnk3J0THERSdNIiIY531aajT5
         ILpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ITdp6Cvx22Mvj0C3ifwRHj6Rcd3lphMvacHtAaG57qc=;
        b=VkKLMOB9aJSdNAQF2hoqRVDzD4A7QpGynD5IQvhkUhdqDfQzSPaVX+ATVwy5TRXv7a
         P3Hct5Z2s1HChezrkM9DbHnpoqjBQdMRVHVmpSxcQqmHyyvcRsKtF85d6vtfvDTNF2tF
         BFJKGNguMZHQyBJUAywe++hI0XnKU1pJb1kIo9aYuiC3oiEfbjgnzlXgMOhvcBQz9TjV
         qPPSS0qIeNpWJFdfClMsVwh9igBNeMD4jfSHgzN2WMSaymeKSzWArlqs/bWxDzBdgw+u
         Pmmxts1ad3pDpy9AGUCuiux37T8F7a+LAhYtKuwLuT2GvSXsUZt97iiCZaaeoSyZN03u
         MZdw==
X-Gm-Message-State: APjAAAXA6yi097ZRtR8Q4+YAhrVl4XSgJTde1/nJSDB4sz43o280CpGL
        GU/X+YJFjy9XWigtisbOAdGdj5l2
X-Google-Smtp-Source: APXvYqyJ4RGAQfVkR4w0Ktg4IvHUl10bPYL+Dt6QgLwZZ5paWu4345Z0OGZoKMHE9ENdbhpjapQoFg==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr4151915wma.140.1574265311158;
        Wed, 20 Nov 2019 07:55:11 -0800 (PST)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id s17sm6755105wmh.41.2019.11.20.07.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:55:10 -0800 (PST)
Date:   Wed, 20 Nov 2019 15:55:08 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: add retry to tty_init_dev() to workaround a
 race condition
Message-ID: <20191120155508.kt4prkqmdd4qwioh@debian>
References: <20191120151709.14148-1-sudipm.mukherjee@gmail.com>
 <20191120151709.14148-2-sudipm.mukherjee@gmail.com>
 <20191120154450.GB3004157@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120154450.GB3004157@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 04:44:50PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 20, 2019 at 03:17:09PM +0000, Sudip Mukherjee wrote:
> > There seems to be a race condition in tty drivers and I could see on
> > many boot cycles a NULL pointer dereference as tty_init_dev() tries to
> > do 'tty->port->itty = tty' even though tty->port is NULL.
<snip>
> > +++ b/drivers/tty/pty.c
> > @@ -842,7 +842,7 @@ static int ptmx_open(struct inode *inode, struct file *filp)
> >  
> >  
> >  	mutex_lock(&tty_mutex);
> > -	tty = tty_init_dev(ptm_driver, index);
> > +	tty = tty_init_dev(ptm_driver, index, 0);
> 
> Horrible naming scheme for this new "flag".
> 
> Look at that call here, can you instantly tell what this call is doing
> with "0"?  I sure can not :(

well, I also made the mistake of 1->0 in my initial patch. :(

> 
> If you really want to do this, you make a different function,
> tty_init_dev_retry() and then have that pass in a retry flag in the tty
> core, so that any users always know what they are doing here.

will do.

> 
> But, this really feels like a race in the code somewhere:
> 
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -1295,6 +1295,7 @@ static int tty_reopen(struct tty_struct *tty)
> >   *	tty_init_dev		-	initialise a tty device
> >   *	@driver: tty driver we are opening a device on
> >   *	@idx: device index
> > + *	@retry: retry count if driver has not set tty->port yet
> 
> Why would tty->port not be set up already?  The caller has control over
> this, what is not happening correctly to cause this?

Will add more debugs to check what is happening now and then send you v2.


--
Regards
Sudip
