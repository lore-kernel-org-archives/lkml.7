Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DCC20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdgdMpV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfCDWkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:40:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39505 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCDWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:39:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id e15so5702329otk.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 14:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xndiW0RBCWN7lD68hnmq1fpw4rAH6KO85X9a70+dzrY=;
        b=WdgdMpV4hinPiwdoxjMjUK9WYyBKLILRTpqp0SyjouJCVyXQfd9kGxcE93hWZ9ILm8
         xwnzHmJVjargqIrhsYLRiSXy2Lau6+1byZp56RfFsj5DYo7YOEfeIAqnvnf8X6yMGGW1
         kX/fw+lyPZgvKBqFW+stepYIuFnkn4U5uiNKuNxhLbamS67F/dSWh3/frY1eKpbysAlu
         r97coq8ldyUwCGC0vV/SQpHKQcSCDrpJzj+SZ1GRTeh90euH/DyQpIIRHpaFCtbS89Ve
         d2G1QJ1hmsOgs8KRvU6ftOTd4d8WX4VANIgJZnk0sXcK/yGXCpWU3wTuHKOT4YdzEkYF
         n1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xndiW0RBCWN7lD68hnmq1fpw4rAH6KO85X9a70+dzrY=;
        b=nQz4E24UM2e27lzNEwTrtzuLBsmfdf/wQaJ8sM79tzkyvS/Y5IeEep6LWc6WWWxvIp
         JhrM5a6WcstkOnCE+eqEoAz4aVtB0cK0ZwakcTkljh48jroWTV3RXrxafQeD6GJE0+Y8
         6QysS5yogglvkN7o2jXRqsdO+QPW8RtSampW+iDgBVBAOZ2UAH9X9IPz2yAoJglFNGqi
         qjuYxjPTJBQ/PLnnzMZ+YbEBJIC0rz/aWWeTzn5Ss5uY/Rapg5mh3VX+qfpTk868pres
         KGxObWsftupFJnvMB7JJqsdGLzOTcHDdQYDxfNVpv3uoMxIm4areuO2qChQ8204wi8zr
         jZag==
X-Gm-Message-State: APjAAAXie9Js3v/fibS5j9aIT0x1OzuzmiC2ohi+Csq75tT0JcQ6wMNA
        VW71dMfXrdAyaqMPpsYbqPgXonM7qkM2CHmAARthmw==
X-Google-Smtp-Source: APXvYqyNQ/310Oh+0hK91BCvGbdFuxysXXI3Mguxf9m4HDm5Zz5BYGvhQQVlTE1YzhO5kFOy2kBiHHPwb47R3MrfpAE=
X-Received: by 2002:a9d:7597:: with SMTP id s23mr13709102otk.25.1551739198555;
 Mon, 04 Mar 2019 14:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com> <155121334527.260864.5324117081460979741@swboyd.mtv.corp.google.com>
 <CAFd5g46QCisA4PHQXo57-LC6sNdk=OUjBE0O1s4005uBz_Vo6Q@mail.gmail.com> <155137694423.260864.2846034318906225490@swboyd.mtv.corp.google.com>
In-Reply-To: <155137694423.260864.2846034318906225490@swboyd.mtv.corp.google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Mar 2019 14:39:47 -0800
Message-ID: <CAFd5g46v5tYRcXaAj9j6XBaO14q1R+2-7LOSgdgJSkwWqDim4g@mail.gmail.com>
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, shuah@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:02 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-02-28 01:03:24)
> > On Tue, Feb 26, 2019 at 12:35 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > when they need to abort and then the test runner would detect that error
> > > via the return value from the 'run test' function. That would be a more
> > > direct approach, but also more verbose than a single KUNIT_ASSERT()
> > > line. It would be more kernel idiomatic too because the control flow
> >
> > Yeah, I was intentionally going against that idiom. I think that idiom
> > makes test logic more complicated than it needs to be, especially if
> > the assertion failure happens in a helper function; then you have to
> > pass that error all the way back up. It is important that test code
> > should be as simple as possible to the point of being immediately
> > obviously correct at first glance because there are no tests for
> > tests.
> >
> > The idea with assertions is that you use them to state all the
> > preconditions for your test. Logically speaking, these are the
> > premises of the test case, so if a premise isn't true, there is no
> > point in continuing the test case because there are no conclusions
> > that can be drawn without the premises. Whereas, the expectation is
> > the thing you are trying to prove. It is not used universally in
> > x-unit style test frameworks, but I really like it as a convention.
> > You could still express the idea of a premise using the above idiom,
> > but I think KUNIT_ASSERT_* states the intended idea perfectly.
>
> Fair enough. It would be great if these sorts of things were described
> in the commit text.

Good point. Will fix.

>
> Is the assumption that things like held locks and refcounted elements
> won't exist when one of these assertions is made? It sounds like some of
> the cleanup logic could be fairly complicated if a helper function
> changes some state and then an assert fails and we have to unwind all
> the state from a corrupt location. A similar problem exists for a test
> timeout too. How do we get back to a sane state if the test locks up for
> a long time? Just don't try?

It depends on the situation, if it is part of a KUnit test itself
(probably not code under test), then you can use the kunit_resource
API: https://lkml.org/lkml/2019/2/14/1125; it is inspired by the
devm_* family of functions, such that when a KUnit test case ends, for
any reason, all the kunit_resources are automatically cleaned up.
Similarly, kunit_module.exit is called at the end of every test case,
regardless of how it terminates.

>
> >
> > > isn't hidden inside a macro and it isn't intimately connected with
> > > kthreads and completions.
> >
> > Yeah, I wasn't a fan of that myself, but it was broadly available. My
> > previous version (still the architecture specific version for UML, not
> > in this patchset though) relies on UML_LONGJMP, but is obviously only
> > works on UML. A number of people wanted support for other
> > architectures. Rob and Luis specifically wanted me to provide a
> > version of abort that would work on any architecture, even if it only
> > had reduced functionality; I thought this fit the bill okay.
>
> Ok.
>
> >
> > >
> > > >
> > > > diff --git a/kunit/test.c b/kunit/test.c
> > > > index d18c50d5ed671..6e5244642ab07 100644
> > > > --- a/kunit/test.c
> > > > +++ b/kunit/test.c
> > > [...]
> > > > +
> > > > +static void kunit_generic_throw(struct kunit_try_catch *try_catch)
> > > > +{
> > > > +       try_catch->context.try_result = -EFAULT;
> > > > +       complete_and_exit(try_catch->context.try_completion, -EFAULT);
> > > > +}
> > > > +
> > > > +static int kunit_generic_run_threadfn_adapter(void *data)
> > > > +{
> > > > +       struct kunit_try_catch *try_catch = data;
> > > >
> > > > +       try_catch->try(&try_catch->context);
> > > > +
> > > > +       complete_and_exit(try_catch->context.try_completion, 0);
> > >
> > > The exit code doesn't matter, right? If so, it might be clearer to just
> > > return 0 from this function because kthreads exit themselves as far as I
> > > recall.
> >
> > You mean complete and then return?
>
> Yes. I was confused for a minute because I thought the exit code was
> checked, but it isn't. Instead, the try_catch->context.try_result is
> where the test result goes, so calling exit explicitly doesn't seem to
> be important here, but it is important in the throw case.

Yep.

>
> >
> > >
> > > > +       else if (exit_code)
> > > > +               kunit_err(test, "Unknown error: %d", exit_code);
> > > > +}
> > > > +
> > > > +void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch)
> > > > +{
> > > > +       try_catch->run = kunit_generic_run_try_catch;
> > >
> > > Is the idea that 'run' would be anything besides
> > > 'kunit_generic_run_try_catch'? If it isn't going to be different, then
> >
> > Yeah, it can be overridden with an architecture specific version.
> >
> > > maybe it's simpler to just have a function like
> > > kunit_generic_run_try_catch() that is called by the unit tests instead
> > > of having to write 'try_catch->run(try_catch)' and indirect for the
> > > basic case. Maybe I've missed the point entirely though and this is all
> > > scaffolding for more complicated exception handling later on.
> >
> > Yeah, the idea is that different architectures can override exception
> > handling with their own implementation. This is just the generic one.
> > For example, UML has one that doesn't depend on kthreads or
> > completions; the UML version also allows recovery from some segfault
> > conditions.
>
> Ok, got it. It may still be nice to have a wrapper or macro for that
> try_catch->run(try_catch) statement so we don't have to know that a
> try_catch struct has a run member.
>
>         static inline void kunit_run_try_catch(struct kunit_try_catch *try_catch)
>         {
>                 try_catch->run(try_catch);
>         }

Makes sense. Will fix in the next revision.
