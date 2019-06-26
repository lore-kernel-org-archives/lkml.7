Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D34C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F1C21726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6f2tU7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfFZWQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:16:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46264 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfFZWQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:16:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so127936pfy.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GeRJM7RinPoMIQ6Cxu4JfD/FJhf/Q7830l4heE4Z/70=;
        b=S6f2tU7Miw4rgiEW47807L33bYsjxaGq9kSV5FlqDefi2WxZ9lTn6WNXPehPhg/T1u
         QlukqMtHkRexD1aKOxiS1bTcFztoPMq6vRmfl07xvAlF8qkmKEYcRYv6yewHpyrNh/C2
         b54UNQQh2z4Ml5QHakDNUwkkVSa3wpee9qOwZX656U2rr12uOzmYMsnmgvSxd7nO2lJu
         uPRgbm1UzaYtxmtry6zEXpmUHhjd6DhSWjC+3Gn8V/HQxryzbZ7pGyLo06Eq0gUDpp5U
         DjOJXTOOdEhiALmttRxHwycmxPuBaL40MgKhCWjDKs1lUcvOyyLeVeXFZ4cT8o8pd53u
         IzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GeRJM7RinPoMIQ6Cxu4JfD/FJhf/Q7830l4heE4Z/70=;
        b=miOEqwFU1M645Pfib+roKcv4+unJw4Fg8b0pDG+M/bWg4iGkbqNQm7refktULrq0L4
         zm19r6D1BCLSaCiZC8sHX9Au2NJZotBw3jeYBoqs2u7Wt6UtyUMp79dU/H87QTUicYJn
         kKvvDuNWr9yqkb8Wbv3gUdHGrAtt+AyTJhSuKX/yRbxvwqEVKscB37YjfoXnISaosUlx
         nhlgCHFOT4DI3VIxOyve/U6u6pwOZiMBpNvLl4rZRGsJnVE/LwUNzS5/md29k/AgV5t2
         GhdLQYDPePE0Zb7U7JLX/34qNcfi7DZOmwHZwYOtTVWuFLMXWtpmRaE92Gukn/qY/8d1
         Lg2Q==
X-Gm-Message-State: APjAAAVGrzYSaBQzxu1yqoshMmC7Z+IwA2GZ21nyPlpGKuKVLyJXVjR1
        9LeiJcMFO9/TuLrqFWP+dQY+0e/Rf42ZW6XiTN8Tag==
X-Google-Smtp-Source: APXvYqzsQMLB7isztv92bzu5YXVWaHFQchBB4ZbMDdOvCDM8VotktY7nYV0uIl6GRCqZMb6GciobJW+UAft7ArjB2vg=
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr1630712pjb.117.1561587408779;
 Wed, 26 Jun 2019 15:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com> <20190625223312.GP19023@42.do-not-panic.com>
 <CAFd5g46TLAONgXiZkFM98BPd-sariMTwhmYG9hSJ+M9=r-ixeg@mail.gmail.com> <20190626033643.GX19023@42.do-not-panic.com>
In-Reply-To: <20190626033643.GX19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 26 Jun 2019 15:16:36 -0700
Message-ID: <CAFd5g45PTtPumkpp1i41kkixZaR55pbqaF2DsuKNmh5UyAVwOg@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 8:36 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jun 25, 2019 at 05:07:32PM -0700, Brendan Higgins wrote:
> > On Tue, Jun 25, 2019 at 3:33 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Jun 17, 2019 at 01:25:56AM -0700, Brendan Higgins wrote:
> > > > +/**
> > > > + * module_test() - used to register a &struct kunit_module with KUnit.
> > > > + * @module: a statically allocated &struct kunit_module.
> > > > + *
> > > > + * Registers @module with the test framework. See &struct kunit_module for more
> > > > + * information.
> > > > + */
> > > > +#define module_test(module) \
> > > > +             static int module_kunit_init##module(void) \
> > > > +             { \
> > > > +                     return kunit_run_tests(&module); \
> > > > +             } \
> > > > +             late_initcall(module_kunit_init##module)
> > >
> > > Becuase late_initcall() is used, if these modules are built-in, this
> > > would preclude the ability to test things prior to this part of the
> > > kernel under UML or whatever architecture runs the tests. So, this
> > > limits the scope of testing. Small detail but the scope whould be
> > > documented.
> >
> > You aren't the first person to complain about this (and I am not sure
> > it is the first time you have complained about it). Anyway, I have
> > some follow on patches that will improve the late_initcall thing, and
> > people seemed okay with discussing the follow on patches as part of a
> > subsequent patchset after this gets merged.
> >
> > I will nevertheless document the restriction until then.
>
> To be clear, I am not complaining about it. I just find it simply
> critical to document its limitations, so folks don't try to invest
> time and energy on kunit right away for an early init test, if it
> cannot support it.
>
> If support for that requires some work, it may be worth mentioning
> as well.

Makes sense. And in anycase, it is something I do want to do, just not
right now. I will put a TODO here in the next revision.

> > > > +static void kunit_print_tap_version(void)
> > > > +{
> > > > +     if (!kunit_has_printed_tap_version) {
> > > > +             kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
> > >
> > > What is this TAP thing? Why should we care what version it is on?
> > > Why are we printing this?
> >
> > It's part of the TAP specification[1]. Greg and Frank asked me to make
> > the intermediate format conform to TAP. Seems like something else I
> > should probable document...
>
> Yes thanks!
>
> > > > +             kunit_has_printed_tap_version = true;
> > > > +     }
> > > > +}
> > > > +
> > > > +static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> > > > +{
> > > > +     struct kunit_case *test_case;
> > > > +     size_t len = 0;
> > > > +
> > > > +     for (test_case = test_cases; test_case->run_case; test_case++)
> > >
> > > If we make the last test case NULL, we'd just check for test_case here,
> > > and save ourselves an extra few bytes per test module. Any reason why
> > > the last test case cannot be NULL?
> >
> > Is there anyway to make that work with a statically defined array?
>
> No you're right.
>
> > Basically, I want to be able to do something like:
> >
> > static struct kunit_case example_test_cases[] = {
> >         KUNIT_CASE(example_simple_test),
> >         KUNIT_CASE(example_mock_test),
> >         {}
> > };
> >
> > FYI,
> > #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
>
> >
> > In order to do what you are proposing, I think I need an array of
> > pointers to test cases, which is not ideal.
>
> Yeah, you're right. The only other alternative is to have a:
>
> struct kunit_module {
>        const char name[256];
>        int (*init)(struct kunit *test);
>        void (*exit)(struct kunit *test);
>        struct kunit_case *test_cases;
> +       unsigned int num_cases;
> };
>
> And then something like:
>
> #define KUNIT_MODULE(name, init, exit, cases) { \
>         .name = name, \
>         .init = init, \
>         .exit = exit, \
>         .test_cases = cases,
>         num_cases = ARRAY_SIZE(cases), \
> }
>
> Let's evaluate which is better: one extra test case per all test cases, or
> an extra unsigned int for each kunit module.

I am in favor of the current method since init and exit are optional
arguments. I could see myself (actually I am planning on) adding more
optional things to the kunit_module, so having optional arguments will
make my life a lot easier since I won't have to go through big
refactorings around the kernel to support new features that tie in
here.
