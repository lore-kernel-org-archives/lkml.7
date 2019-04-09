Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A0C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EC5218E2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwiMC75f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDIQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:17:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36975 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDIQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:17:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so9575503pgc.4;
        Tue, 09 Apr 2019 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vKw8Jl9tNEqGMUO467SQXKKYv88p0pyHcXsJhIjuhFk=;
        b=IwiMC75f3+vX+tEKVTBZKhHd5TgUMvi9yKSkkfFOoIb6/LuIXeudrnlyE6gSO1wFlI
         bCMYFKCUU4O/DbwShOO1BkjLIbHiao33xTV68qXq/NAoIVOYolZwA/AHo1pTf/gAjn5S
         W+wYG6ASQyIbyOFZmSIbZWYgsdrUdHWHgTkSGDuvkzrr2VIvk9Gyf0JOBLOpr26lFpA7
         tW9nMuG6x0Srnyj/rNMrHm7hWiFQ0J8LDtdPcc1F1wFAbk2DzrJYiGZnII23fS5g7NCX
         302oKoOP1Y62Q+deyhazzqg566zWI3A6yBMksmm1AG0u2MWxFFCjIsghjlMwz2KlQGLY
         Ukrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vKw8Jl9tNEqGMUO467SQXKKYv88p0pyHcXsJhIjuhFk=;
        b=qUO1f4O+uR2PZ2tyYqoDK6wfOGQHf+aJHywXm5wYLEIliSk/Zf84bGxzqmdWdhs5gT
         kON6kt0bgeugz7dhYbq1p3m1ZcTfMkHiB6aKVjmjygjhdrVqgMX8G/lvWBHFC8upZmge
         KEBFbWbA8y3d/iiJvwG8moFciliyr/tl1T+qq1VixvCmG5uGuw8jcV3tkH+7jZTyOJW1
         Tar+f4nSB/T4TwJIXJuXOL8wWkuzvsAJhzhX19h65axQuoK+YA02lpMhCE9hlyiXLLhK
         KbM/1zK3VunlxCdd64DyzECClok6OZqdZ5yYDexz+IEuaZ3UFjy+oxFrl+H2jiGlOHPM
         +IvA==
X-Gm-Message-State: APjAAAWB7gdsDfa04E4GRlCHz9aDl01PnBqezAjLLyRqmrOuRPjBAt0W
        9Wy40pkW/EAJ2YXyvRa1/4WsHnDr
X-Google-Smtp-Source: APXvYqyWUIMDBbEk74RxQq3YagkSKRFnJ6UnL4jnCH4JYGLxKLtPhvNpESHKN8uAyV/OJFF2eef5nw==
X-Received: by 2002:a63:f444:: with SMTP id p4mr36475025pgk.32.1554826629948;
        Tue, 09 Apr 2019 09:17:09 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id g10sm15773364pgq.54.2019.04.09.09.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:17:09 -0700 (PDT)
Date:   Wed, 10 Apr 2019 00:17:02 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Message-ID: <20190409161700.3itslgpqlhx3up3m@mail.google.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
 <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
 <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
 <20190403133613.13f3fd75@lwn.net>
 <20190405024350.rbwbiaxjybrmqea6@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405024350.rbwbiaxjybrmqea6@mail.google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:44:35AM +0800, Changbin Du wrote:
> + Bjorn
> 
> On Wed, Apr 03, 2019 at 01:36:13PM -0600, Jonathan Corbet wrote:
> > On Tue, 2 Apr 2019 10:25:23 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > 
> > > There are ACPI-related documents currently in Documentation/acpi/ that
> > > don't clearly fall under either driver-api or admin-guide.  For
> > > example, some of them describe various aspects of the ACPI support
> > > subsystem operation and some document expectations with respect to the
> > > ACPI tables provided by the firmware etc.
> > > 
> > > Where would you recommend to put them after converting to .rst?
> > 
> > OK, I've done some pondering on this.  Maybe what we need is a new
> > top-level "hardware guide" book meant to hold information on how the
> > hardware works and what the kernel's expectations are.  Architecture
> > information could maybe go there too.  Would this make sense?
> > 
> > If so, I could see a division like this:
> > 
> > Hardware guide
> > 	acpi-lid
> > 	aml-debugger (or maybe driver api?)
> > 	debug (ditto)
> > 	DSD-properties-rules
> > 	gpio-properties
> > 	i2c-muxes
> > 
> > Admin guide
> > 	cppc_sysfs
> > 	initrd_table_override
> > 
> > Driver-API
> > 	enumeration
> > 	scan_handlers
> > 
> > other:
> > 	dsdt-override: find another home for those five lines
> >
> Then, should we create dedicated sub-directories for these new charpters and
> move documents to coresspoding one? Now we have 'admin-guide' and all admin-guid
> docs are under it, otherwise we will have reference across different folders.
> For example, the 'admin-guide/index.rst' will have:
>     ...
>     ../acpi/osi
>     ...
> Which seems not good.
>
Jonathan, what is your idea about the placement of doc files?

> > ...and so on.  I've probably gotten at least one of those wrong, but that's
> > the idea.
> > 
> > Of course, then it would be nice to better integrate those documents so
> > that they fit into a single coherent whole...a guy can dream...:)
> >
> I am not an adminstrator, so I don't know how adminstrators use this kernel
> documentation. But as a kernel developer, I prefer all related documents
> integrated into one charpter. Because I probably miss some useful sections
> if the documents are distributed into several charpters. And this is usually
> how a book is written (One charpter focus on one topic and has sub-sections
> such as overview, backgroud knowledge, implemenation details..),
> but a book mostly target on hypothetical readers...
>
After some considerarion, I have a new idea. Since the top charpter named as
*API* so non-API things is not suitable for this charpter. But can we just
rename it? For example, we can rename 'Kernel API documentation' to 
'Subsystem-specifc documentation' which is similar to 'Architecture-specific documentation'?

Subsystem-specifc documentation
-------------------------------
.. toctree::
   :maxdepth: 2

   driver-api/index
   core-api/index
   media/index
   networking/index
   input/index
   gpu/index
   ...

Architecture-specific documentation
-----------------------------------
.. toctree::
   :maxdepth: 2

   sh/index
   x86/index
   ...

> > Thanks,
> > 
> > jon
> 
> -- 
> Cheers,
> Changbin Du

-- 
Cheers,
Changbin Du
