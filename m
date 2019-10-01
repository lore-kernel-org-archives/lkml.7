Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC4AECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310D22086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iqfxY8re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbfJAQQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:16:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39571 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbfJAQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:16:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so8339733pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UhjXWLcrDBB4q1kRn5CmPKgAtAED5RXVbe7dFH6WH6M=;
        b=iqfxY8re2/JcoP9Rrux4Kwx3ipOsfachdXe+PQpwqxOdY9n+iJVAPX1GYRMPn23Cs3
         CLpPqQi6529bZUK+21JLeYjcOSnQDHo9ocHxmpYw7ok/ZS7dsqs9Bei6kfvbRhRHm2P3
         O2e44nV46w+eG/TQ6NQXHypWJ2Ohljg/TXf2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UhjXWLcrDBB4q1kRn5CmPKgAtAED5RXVbe7dFH6WH6M=;
        b=IFznS5SOLsuizVbeXLHCWBxyh6+FYF30GmPfFBTyBOUHAJl6dlbJITeS80rqBz/7D1
         ge9va0Vjr+X28SKN5a8YSpLe+t3L68HFKMAD1iLFTGNFokvg2teNt5lCVzMgPbxTDP4q
         uDJuy5v4Ck0bWvaXdKa0g2tPrfzqDMqabHQ0bxPDyhCy7SO7tWZQawLRpzzNfrNtTlSW
         BrArleK1I04Mqg6PdR2dtqq7h7G2Jp0rSTkS3sNcGeXlIAQx49IcQREtYCBZWnFRA5n4
         IRWm7lnPkP5BrgNfQoMOSbtSm+CBcx/FS46eAZJFIAxKm38qASKHj0qmNCTFyHr2Gvvm
         nh6g==
X-Gm-Message-State: APjAAAW0/K551GUEKnm5QAMIY2/pARcUQRmCmC3Fs5NWJvnphje1HR+t
        JJJjKOxj+qvT84JLN7vbg882v4aMKLU=
X-Google-Smtp-Source: APXvYqzS/kRySDG61Dg6N8vbAGXwkgW5aM6BwLwX9OnIgD6RXQWjnSwru7bU9RUwiA+1/v4+1DT+Xw==
X-Received: by 2002:a63:1c65:: with SMTP id c37mr30721017pgm.31.1569946603223;
        Tue, 01 Oct 2019 09:16:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5sm2740527pgi.19.2019.10.01.09.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 09:16:42 -0700 (PDT)
Date:   Tue, 1 Oct 2019 09:16:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: Programmatically render MAINTAINERS into ReST
Message-ID: <201910010913.2BAAC8A@keescook>
References: <20190924230208.12414-1-keescook@chromium.org>
 <20191001083147.3a1b513f@lwn.net>
 <20191001120930.5d388839@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001120930.5d388839@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 12:09:30PM -0300, Mauro Carvalho Chehab wrote:
> Em Tue, 1 Oct 2019 08:31:47 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > On Tue, 24 Sep 2019 16:02:06 -0700
> > Kees Cook <keescook@chromium.org> wrote:
> > 
> > > Commit log from Patch 2 repeated here for cover letter:
> > > 
> > > In order to have the MAINTAINERS file visible in the rendered ReST
> > > output, this makes some small changes to the existing MAINTAINERS file
> > > to allow for better machine processing, and adds a new Sphinx directive
> > > "maintainers-include" to perform the rendering.  
> > 
> > I finally got around to trying this out.  After the usual warnings, the
> > build comes to a screeching halt with this:
> > 
> >   Sphinx parallel build error:
> >   UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 8: ordinal not in range(128)
> > 
> > For extra fun, the build process simply hangs, requiring a ^C to blow it
> > away.  You've managed to get new behavior out of Sphinx that I've not seen
> > before, congratulations :)
> > 
> > This almost certainly has to do with the fact that I'm (intentionally)
> > running the Python2 Sphinx build here.  Something's not doing unicode that
> > should be.

Given this would be for v5.5, and python2 is EOL in 2 months[1], I don't
think it's unreasonable to deprecate it. Especially considering there
are already explicit "python3" shebangs in existing code in the sphinx/
directory.

[1] https://pythonclock.org/

> > I would suggest that we might just want to repair this before merging this
> > feature.  Either that, or we bite the bullet and deprecate the use of
> > Python 2 entirely - something that's probably not too far into our future
> > regardless.  Anybody have thoughts on that matter?
> 
> I'm almost sure we got this already. If I'm not mistaken, the solution
> is to add the encoding line after shebang. Looking at 
> Documentation/sphinx/maintainers_include.py (patch 2/2), the script
> starts with:
> 
> 	#!/usr/bin/env python
> 	# SPDX-License-Identifier: GPL-2.0
> 	# -*- coding: utf-8; mode: python -*-
> 	# pylint: disable=R0903, C0330, R0914, R0912, E0401
> 
> But, as I pointed before, the SPDX header at the wrong place is causing the 
> crash, as the encoding line should be the second line, not the third one,
> e. g.:
> 
> 	#!/usr/bin/env python
> 	# -*- coding: utf-8; mode: python -*-
> 	# SPDX-License-Identifier: GPL-2.0
> 	# pylint: disable=R0903, C0330, R0914, R0912, E0401
> 
> I also suspect that this would happen even with python3, depending on
> how LC_ALL, LANG, ... are set on the distro you use.

Oh that's a delightful bug. :P I haven't been able to reproduce this
failure (maybe all my LANG junk is accidentally correct)?

Jon, if this fixes it for you, should I respin the patches?

-- 
Kees Cook
