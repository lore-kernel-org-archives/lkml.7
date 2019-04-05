Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994BDC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654942171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW58vXoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfDECon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:44:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41649 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfDECon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:44:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so2407221pfd.8;
        Thu, 04 Apr 2019 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d24gn8MXLqPfD+VHlRDBI4mUJhGpi39oRyOuo8AC4r0=;
        b=IW58vXoc1jtKO3LcOvipng5XvFizmAx5AmdFk7JAMzClAMP31ylNhg99PvMJZRthmq
         KHzCshEMD/t6EMJFnPC6IkD7SFSAWXqv//gz2t0Vw2c9qkN1J5Lo2wxghUJ18JseadZr
         rUUO/edEda5W0PZz3NHBQv0Fth6+gNWOYcVMa3ElkWSPVxK2o7h0/j9axWcriM/okDAH
         xCeQISIZ+CHChTbmBEQZnpdosliz3Z7iXrvOtcBxgZB7foOiXcyeb2qxbMiNxHVuB/0B
         nHAAgiJEPLYApnYWpo77hJdmvfEnby0B9ustaTGyp2OFfHNvhAZ0umeIR5VlUZ/5lePs
         rBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d24gn8MXLqPfD+VHlRDBI4mUJhGpi39oRyOuo8AC4r0=;
        b=Ib8F+aH8Oe7LluAJS1UYU7u7buZS85bI66mr327vONGkncR2k82zF4DrW6+iNTuAqI
         ik/1Mtxr3annOO9W1FGahpyh1WVbWF9OXz9OHfM9OlMYiqOA1ULAn7Ygc0GAAJ0k4263
         OIl4fRD9FD4DUoxG3e/qITOUgoxfeLyi9Veka/gnGAAb03YQHRx5DpzMzftM7PIrFHau
         eH3qxwPRaJrq/G4tSuaGQQOYDUVDXQdnlCGQUZe3/wzsFNVxwQvI0ZsE+vIL6ahHALub
         Y43sPfrZkGEG7t3LbIQXAojdE4cR/XmO3UfhS2v36QjQdkDs5W2zcc3A+JRv/UMhbYy/
         46MA==
X-Gm-Message-State: APjAAAXEd+nGdKSN0BhQkdHgq/+sIPQuttr1Ena1IHn/Cc6GgXjeHtnf
        OMltgNzCIbOJoi0TsiyPlW0=
X-Google-Smtp-Source: APXvYqyrEpEKj0yVaXGnUiJ/uqt48m+5yV5HQbGa9YBERL5FKVvMwQYotpCL6vR7KrjPKk2uTvggiw==
X-Received: by 2002:aa7:9116:: with SMTP id 22mr9766718pfh.165.1554432282422;
        Thu, 04 Apr 2019 19:44:42 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c130sm33753748pfb.145.2019.04.04.19.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 19:44:41 -0700 (PDT)
Date:   Fri, 5 Apr 2019 10:44:35 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Message-ID: <20190405024350.rbwbiaxjybrmqea6@mail.google.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
 <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
 <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
 <20190403133613.13f3fd75@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403133613.13f3fd75@lwn.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Bjorn

On Wed, Apr 03, 2019 at 01:36:13PM -0600, Jonathan Corbet wrote:
> On Tue, 2 Apr 2019 10:25:23 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > There are ACPI-related documents currently in Documentation/acpi/ that
> > don't clearly fall under either driver-api or admin-guide.  For
> > example, some of them describe various aspects of the ACPI support
> > subsystem operation and some document expectations with respect to the
> > ACPI tables provided by the firmware etc.
> > 
> > Where would you recommend to put them after converting to .rst?
> 
> OK, I've done some pondering on this.  Maybe what we need is a new
> top-level "hardware guide" book meant to hold information on how the
> hardware works and what the kernel's expectations are.  Architecture
> information could maybe go there too.  Would this make sense?
> 
> If so, I could see a division like this:
> 
> Hardware guide
> 	acpi-lid
> 	aml-debugger (or maybe driver api?)
> 	debug (ditto)
> 	DSD-properties-rules
> 	gpio-properties
> 	i2c-muxes
> 
> Admin guide
> 	cppc_sysfs
> 	initrd_table_override
> 
> Driver-API
> 	enumeration
> 	scan_handlers
> 
> other:
> 	dsdt-override: find another home for those five lines
>
Then, should we create dedicated sub-directories for these new charpters and
move documents to coresspoding one? Now we have 'admin-guide' and all admin-guid
docs are under it, otherwise we will have reference across different folders.
For example, the 'admin-guide/index.rst' will have:
    ...
    ../acpi/osi
    ...
Which seems not good.

> ...and so on.  I've probably gotten at least one of those wrong, but that's
> the idea.
> 
> Of course, then it would be nice to better integrate those documents so
> that they fit into a single coherent whole...a guy can dream...:)
>
I am not an adminstrator, so I don't know how adminstrators use this kernel
documentation. But as a kernel developer, I prefer all related documents
integrated into one charpter. Because I probably miss some useful sections
if the documents are distributed into several charpters. And this is usually
how a book is written (One charpter focus on one topic and has sub-sections
such as overview, backgroud knowledge, implemenation details..),
but a book mostly target on hypothetical readers...

> Thanks,
> 
> jon

-- 
Cheers,
Changbin Du
