Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B88CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC17217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2RmuRZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfKAK0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:26:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35270 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbfKAK0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:26:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id l10so9200364wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIsyO0dYa/j5O9STeNXT9gsa/Vv1qidzl7M/7WtKnlY=;
        b=p2RmuRZyGE752aqHlKKWtMTXzUv40V+9x50Xh6mCgJ3CUx9LAOFpMC+dvKgAikhBm9
         2kt3yA292OpNk/XCm/jJHaodqTuc0y0xCVEWBcc93RKcETt8s+uVnHwORFqNcTJicSNa
         GJaniqgHjINAuJ3G0xCtRga17zJ51eIGZ+GWK6fdzQ/TZQvvzUgAaAaN5vUoBIYpS7WQ
         HtRQtLSGIMLTQWhns1Wezne1F4unAMZ+UxPgDXbU6ZntTE2kmgHZRHc/Bnt0ncbBb5uM
         8pyCcXne6aKVU3B1L1C8O4RyY4ZzG1V5wQOWt9K2XQcJWphEpghPluPXmWvdZiJ7hm7J
         oL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIsyO0dYa/j5O9STeNXT9gsa/Vv1qidzl7M/7WtKnlY=;
        b=R5uViK/BIxWY1NkAYRe4lJETrLighLPEq/oZpxeKsRaBt+vMNfXhWBi/j+A7MYneZD
         kZSp6UDmiJEfbpMdNo5Czaji2f6ArrE1ItvPtM7nQkbmw9X3FjCeyVtKjdKbXS2qvW33
         F4jxLiK5a3ASWl7LSxcYRoOEkQl+B3yDH1wpgAxs0ifjangqlv2nkz1NrdpBNRK1MyIC
         Uf/K95P5hPFizNcBSCBYssUfnmMTpl47ltdK4RIGiHuhfj72E/BVmpHU5McThAkBaKFm
         Fcz56B78ELUJkcFUORsmIaFfoA0/I8Kb4zob4Qz2UmQ4ECvsJqiH66uSaIZCetK1mGpm
         s1Zg==
X-Gm-Message-State: APjAAAWU5EASMGZPimCV4YdceaD41o2T5nM5EMNaFgkp9Ut2lBFK/4pd
        BOcVDX9VkoNoEKWLc05SFqgntRkSJOl/YdKxoideQg==
X-Google-Smtp-Source: APXvYqwINW8N2IbEc4obogACI/d5yO7n6MpnKx9pbBB7JuFm9SKc0Awl31e6U+DHhEQgcUm0nussnBPhPtj24lUNz94=
X-Received: by 2002:a5d:404d:: with SMTP id w13mr10458377wrp.185.1572603964621;
 Fri, 01 Nov 2019 03:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191024224631.118656-1-davidgow@google.com> <201910311147.FA6A822@keescook>
In-Reply-To: <201910311147.FA6A822@keescook>
From:   David Gow <davidgow@google.com>
Date:   Fri, 1 Nov 2019 03:25:52 -0700
Message-ID: <CABVgOSmFm312wkP7_jhgkPhmPHeC+2000twNj7hKPbKf0VEg7w@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for the
 'list' doubly linked list
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 11:51 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 24, 2019 at 03:46:31PM -0700, David Gow wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7ef985e01457..f3d0c6e42b97 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9504,6 +9504,13 @@ F:     Documentation/misc-devices/lis3lv02d.rst
> >  F:   drivers/misc/lis3lv02d/
> >  F:   drivers/platform/x86/hp_accel.c
> >
> > +LIST KUNIT TEST
> > +M:   David Gow <davidgow@google.com>
> > +L:   linux-kselftest@vger.kernel.org
> > +L:   kunit-dev@googlegroups.com
> > +S:   Maintained
> > +F:   lib/list-test.c
>
> Should KUnit be the first name here? Then all KUnit tests appear in the
> same location in the MAINTAINERS file, or should it be like it is here,
> so that KUnit tests are close to the same-named area?

Thus far, we haven't standardised on anything re: MAINTAINERS entries
for tests. For the sysctl test, for instance, the file has been added
to the general "PROC SYSCTL" section.
There's no existing MAINTAINERS entry for list.h at all, though, so
that's couldn't be done here.

My suspicion is that it doesn't matter all that much (isn't everyone
just grepping MAINTAINERS anyway?), but that long-term, tests are more
likely to be being maintained in parallel with the code under test,
rather than in one group block of tests. I don't mind changing it if
anyone has stronger opinions, though...

> > +
> >  LIVE PATCHING
> >  M:   Josh Poimboeuf <jpoimboe@redhat.com>
> >  M:   Jiri Kosina <jikos@kernel.org>
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index a3017a5dadcd..6c1be6181e38 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1961,6 +1961,24 @@ config SYSCTL_KUNIT_TEST
> >
> >         If unsure, say N.
> >
> > +config LIST_KUNIT_TEST
>
> Similarly for the Kconfig name. (Also aren't KUNIT and TEST redundant?)
>
> config KUNIT_LIST
>
> ?
>
> config LIST_KUNIT
>

This matches what's being done with the existing sysctl test, which
uses SYSCTL_KUNIT_TEST as its config name.
So, we've kind-of standardised on x_KUNIT_TEST thus far, even if it is
a bit redundant.

> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -292,3 +292,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
> >  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
> >  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
> >  obj-$(CONFIG_OBJAGG) += objagg.o
> > +
> > +# KUnit tests
> > +obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>
> And again, list-kunit.o? Other things have -test (or more commonly
> _test) suffixes. (So maybe list_kunit.o?)
>
> But as I said last time, I'll live with whatever, I'd just like a
> documented best-practice with a reasonable rationale. :)
>

Similarly, we've been going with a -test suffix thus far.

I definitely agree that these conventions should be documented, though.

Cheers,
-- David
