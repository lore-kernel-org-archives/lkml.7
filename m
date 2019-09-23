Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBEAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5882921670
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvXQgh6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfIWJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:05:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36701 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfIWJFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:05:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so8760829pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8pa0Tk6FlMlkzD8bXA6NA6bMdvmrzwl4PAFIDbVMYM=;
        b=NvXQgh6IW3soN2kC6YtQSTm4nJDtjH7T1g1wwUk4J2MMTXgFeWqE4zDVwCvgvthfAE
         WGgMCY+3F8tX2ulk7a71LHHwNjjj6szslWqQDPwjwKZALkV5YkTouU1UbPdDScjYS1A3
         tU4aEIFZK99BR3XOVeaN/cSOFn3rfi7yObVLV3PWs+NfL5qPlxMyeRQLXGH1oSX1DcR+
         Y00Kq9GxGhG7rrAxC5FyQBB+KSDkFMah1k7qmSzRXBnClfBw0q/Abrxnd2xhD8r5qEtT
         Tri2HbzI2Jc1bPenj4gaZNMu/v3ap/CxdJdQ2lrX7Qpp+yqg86whqYHZk9TgPcLogoid
         i1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8pa0Tk6FlMlkzD8bXA6NA6bMdvmrzwl4PAFIDbVMYM=;
        b=BeeTUh2qakKJ2ihbPW8UWOzlDibdI1jJb9V8IZYCfxiVRGOp5EPM79QZY66D8cT/1X
         GpFGq2L3Yf8NiWf07gmjzaRAaDpUakPSnN7yQq21eoDx659NLZc0AknxXHHbieGq98WT
         nE5tgw4aMt/JoThw+vJfrKHtU0vf0fh4wLXqqgs8kbDJ7gJp5I8HKOcWw90rM9VJYsyZ
         pOxD6ocOV4WtWWSB7jGOnX7jnfuKV+Qo0tEIZrz17JGCexgkC64DJ9BLNCif3yqJWf/y
         q0ZmZ4hOehf4+36FqIrC4z8DALAXLSARLRzKu8k/l3yC+tzUkaSqLbMkQK9N6PwSZgq6
         uvmg==
X-Gm-Message-State: APjAAAXS+6UprjqrG3THo0nS0cNNiivOAfXIhhFZjUf8iS3qpGrqYtek
        6JgReOAK+3cXhcRSB6nJ1enTI27DBL6k/HLmezU5UA==
X-Google-Smtp-Source: APXvYqwcsKtiLcxSzZRbvj/9c2PAwvr8gZTaDk07lPhILKUwjb/s/yL4yzfAO84TT2ZemaVLn8TDzTeRlveY2nu9F6o=
X-Received: by 2002:a17:90a:1746:: with SMTP id 6mr5388129pjm.117.1569229513429;
 Mon, 23 Sep 2019 02:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
 <20190921001855.200947-8-brendanhiggins@google.com> <944ac47d-1411-9ebd-d0d4-a616c88c9c20@infradead.org>
In-Reply-To: <944ac47d-1411-9ebd-d0d4-a616c88c9c20@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 23 Sep 2019 02:05:02 -0700
Message-ID: <CAFd5g44e9bdK8h5+U1MkqPNuf2k9vnu-iPFLTzGajEHPEcRpHQ@mail.gmail.com>
Subject: Re: [PATCH v17 07/19] kunit: test: add initial tests
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
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
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 9:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/20/19 5:18 PM, Brendan Higgins wrote:
> > Add a test for string stream along with a simpler example.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  lib/kunit/Kconfig              | 25 ++++++++++
> >  lib/kunit/Makefile             |  4 ++
> >  lib/kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++
> >  lib/kunit/string-stream-test.c | 52 ++++++++++++++++++++
> >  4 files changed, 169 insertions(+)
> >  create mode 100644 lib/kunit/example-test.c
> >  create mode 100644 lib/kunit/string-stream-test.c
> >
> > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > index 666b9cb67a74..3868c226cf31 100644
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -11,3 +11,28 @@ menuconfig KUNIT
> >         special hardware when using UML. Can also be used on most other
> >         architectures. For more information, please see
> >         Documentation/dev-tools/kunit/.
> > +
> > +if KUNIT
>
> The 'if' above provides the dependency clause, so the 2 'depends on KUNIT'
> below are not needed.  They are redundant.

Thanks for catching that. I fixed it in the new revision I just sent out.

> > +
> > +config KUNIT_TEST
> > +     bool "KUnit test for KUnit"
> > +     depends on KUNIT
> > +     help
> > +       Enables the unit tests for the KUnit test framework. These tests test
> > +       the KUnit test framework itself; the tests are both written using
> > +       KUnit and test KUnit. This option should only be enabled for testing
> > +       purposes by developers interested in testing that KUnit works as
> > +       expected.
> > +
> > +config KUNIT_EXAMPLE_TEST
> > +     bool "Example test for KUnit"
> > +     depends on KUNIT
> > +     help
> > +       Enables an example unit test that illustrates some of the basic
> > +       features of KUnit. This test only exists to help new users understand
> > +       what KUnit is and how it is used. Please refer to the example test
> > +       itself, lib/kunit/example-test.c, for more information. This option
> > +       is intended for curious hackers who would like to understand how to
> > +       use KUnit for kernel development.
> > +
> > +endif # KUNIT

Cheers
