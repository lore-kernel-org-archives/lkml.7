Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD23C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930AB2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nX2mqnQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfECEhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 00:37:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46948 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfECEhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 00:37:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id 77so4174255otu.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MP+BYohbe5InwRfSzvg57aXOQ3N16hg/j/194MGpAY0=;
        b=nX2mqnQH8G7lAq/7boHjf6fgeLW4OhXc8dycc5+By6G9miBNlXzrVPV09oM01sBY2z
         1PY2T/XYJRHqtEONNgq9PADGf03W5G4sziQ4uRTMnqAEoh6iNM5a9Ezoiyo1ndCy7ojW
         tk5gH9WgN5g9NpRotxrQseR6tWEmch2vzDn0sL0k1iRMx7bM8e8KuZGIwI0PZSgcFr3+
         TlFU9bnfKzaF/HkPoJxOnNiQ3CLrmM6khM79ImW9xBb83Molxw1NMYQ6x9BlXbS1s9zs
         S9Wn0BBJ13BpxlnQuKJTgsk8nHAZ3z9hw5P/B+YZkt20RKzyQ4WKZ9zq8VVw1rVYepe+
         8Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MP+BYohbe5InwRfSzvg57aXOQ3N16hg/j/194MGpAY0=;
        b=o3TDXZQ8ymUJNEypGSDNbaVgGT6erGeNiT4FmTDTEIuyzB6rchEYvfUCq7hgI2Iw3+
         M2D3Aa/3+n6Ynd2tVBf9meeu5KMPl6KrhWA8ovApyLl+adPRvoamkJQU2ex06mPgCmgq
         e2MJgYXlNGZLb00tD+s6wmjPXPVBvt58UNoSpWJi/JYo8HknDQ6AjuUycx7MEr0CeCUK
         duz0VST+h4JGsfPtfO3T0EHoUpeRqC+QTw1KSYaDf6UD1wTqM1qvd85xAKNHEEIqAGdU
         PtfUOGSeFHcHeR3Q59gz5TQdtZ25wMxuyDEh0oHnXYVW1/FM5D+7AaGx8UV57Kx6xd5f
         JBEQ==
X-Gm-Message-State: APjAAAUWhyG3hvzviS1+Xh033ovYrgdkJtdEHIZRxC+BaTPdRu9aZZP4
        i2I4xr1zBrZyKc8ECJWmDI06rb8uWeE1fRuxvA/65g==
X-Google-Smtp-Source: APXvYqzr00vtpNCRa2QqJZ42KJSToZ1wauw/4VV+vzP4c9tKhQXBp7ukXjW5JZyxz7qF7iSRxd8GRh/4dSu03CZLLfk=
X-Received: by 2002:a9d:7f19:: with SMTP id j25mr5018212otq.25.1556858257579;
 Thu, 02 May 2019 21:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-4-brendanhiggins@google.com> <1befe456-d981-d726-44f9-ebe3702ee51d@kernel.org>
In-Reply-To: <1befe456-d981-d726-44f9-ebe3702ee51d@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 2 May 2019 21:37:26 -0700
Message-ID: <CAFd5g46Ok5rtXUyeHdyoujsdYPq4qwaZwdu3CxY50Gq_iq7B6A@mail.gmail.com>
Subject: Re: [PATCH v2 03/17] kunit: test: add string_stream a std::stream
 like string builder
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 6:26 PM shuah <shuah@kernel.org> wrote:
>
> On 5/1/19 5:01 PM, Brendan Higgins wrote:
< snip >
> > diff --git a/kunit/Makefile b/kunit/Makefile
> > index 5efdc4dea2c08..275b565a0e81f 100644
> > --- a/kunit/Makefile
> > +++ b/kunit/Makefile
> > @@ -1 +1,2 @@
> > -obj-$(CONFIG_KUNIT) +=                       test.o
> > +obj-$(CONFIG_KUNIT) +=                       test.o \
> > +                                     string-stream.o
> > diff --git a/kunit/string-stream.c b/kunit/string-stream.c
> > new file mode 100644
> > index 0000000000000..7018194ecf2fa
> > --- /dev/null
> > +++ b/kunit/string-stream.c
> > @@ -0,0 +1,144 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * C++ stream style string builder used in KUnit for building messages.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/list.h>
> > +#include <linux/slab.h>
> > +#include <kunit/string-stream.h>
> > +
> > +int string_stream_vadd(struct string_stream *this,
> > +                    const char *fmt,
> > +                    va_list args)
> > +{
> > +     struct string_stream_fragment *fragment;
>
> Since there is field with the same name, please use a different
> name. Using the same name for the struct which contains a field
> of the same name get very confusing and will hard to maintain
> the code.
>
> > +     int len;
> > +     va_list args_for_counting;
> > +     unsigned long flags;
> > +
> > +     /* Make a copy because `vsnprintf` could change it */
> > +     va_copy(args_for_counting, args);
> > +
> > +     /* Need space for null byte. */
> > +     len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
> > +
> > +     va_end(args_for_counting);
> > +
> > +     fragment = kmalloc(sizeof(*fragment), GFP_KERNEL);
> > +     if (!fragment)
> > +             return -ENOMEM;
> > +
> > +     fragment->fragment = kmalloc(len, GFP_KERNEL);
>
> This is confusing. See above comment.

Good point. Will fix in the next revision.

< snip >

Thanks!
