Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AFFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2DB20842
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8XNNhFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfB1JDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:03:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36296 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731260AbfB1JDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:03:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id v62so17000762otb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 01:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAwu50oghgU5LOU6exlGkZCJbW2NJCkUzYzp8lQunp4=;
        b=q8XNNhFap9RvRT2ZAkw8iqSuaUNFH1vYu5U71HcmPFAkLT3apRTyMV3/RKQAQvEBA+
         jHtZ8ygUUELFHHW7XgY/vfQLyvdYNLMKaikFdlR5U4hiHBehqnyDe/gk/bkNRefSi5rj
         oL3YQEDCNVBBzOhc5qY/pWBQm85PSWlGHSQaKNTllLnCxoVxYP4s9te71LLLhCAzieAU
         vP9pCqNV9e6L3Sg/xjSbklpILsw3MpobvPtfr27j+bW3GWCttNGUrjjvnYRD5Otq9HNM
         KGl6C8zgjh6Whjj9fRA4LsNzoCQv/7wEp30xHTQogy3wz9WvxTn+dTZNL9jZVYQpnuQi
         sc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAwu50oghgU5LOU6exlGkZCJbW2NJCkUzYzp8lQunp4=;
        b=a2i+fknyAJA4MOB2iFomM4aaIrARDI2t1IawpEC/XJvxcPTBN5Ao2BqQ7QgIPc+JCr
         Wx3n6aM3DJv3ShqAiqMGh7IwcbZHIbmZfugJvVP9upCrLje/J98aK4vbjBMeNUclx7MT
         hmZ2ZXbBeN/7ku658NAfVyo5/9ZfBy//TIuoCxatescnkZPG2V21aAIYADXzF4FaqQvv
         uVDprZQQDDwfyYKMJEEyOj04zURyfOwD9B25Q76X3Qe4+iRlHUF8Ndr2PE74Nhk9y9tn
         SPMNROip/cjfscnMxxet9j9HKficz3mqk1WaCebbP4LDB4/DS1dJcqp4vIW88yQWZg3Y
         2AMw==
X-Gm-Message-State: AHQUAuaDPl1w8Q39sUpX7X2o81ZPBNy2o19trpbuddECWkwkG3ijDN6u
        /+oR5BM/GH7OW1mjzD5godXjts/QjyQZYDqVNJFsAQ==
X-Google-Smtp-Source: APXvYqz/6c5wTB7aS5DN0MvDEPn+uLCX9+pGAyQLpyg3cdMzUPgkP0hyaOHZfw5ETNaP832mL9uYAjtR2aUdION/85A=
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr5198097otp.364.1551344616226;
 Thu, 28 Feb 2019 01:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com> <155121334527.260864.5324117081460979741@swboyd.mtv.corp.google.com>
In-Reply-To: <155121334527.260864.5324117081460979741@swboyd.mtv.corp.google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 Feb 2019 01:03:24 -0800
Message-ID: <CAFd5g46QCisA4PHQXo57-LC6sNdk=OUjBE0O1s4005uBz_Vo6Q@mail.gmail.com>
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
        Amir Goldstein <amir73il@gmail.com>, dan.carpenter@oracle.com,
        wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:35 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-02-14 13:37:20)
> > Add support for aborting/bailing out of test cases. Needed for
> > implementing assertions.
>
> Can you add some more text here with the motivating reasons for
> implementing assertions and bailing out of test cases?

Sure. Yeah, this comes before the commit that adds assertions, so I
should probably put a better explanation here.
>
> For example, I wonder why unit tests can't just return with a failure

Well, you could. You can just do the check as you would without KUnit,
except call KUNIT_FAIL(...) before you return. For example, instead
of:

KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);

you could do:

if (IS_ERR_OR_NULL(ptr)) {
        KUNIT_FAIL(test, "ptr is an errno or null: %ld", ptr);
        return;
}

> when they need to abort and then the test runner would detect that error
> via the return value from the 'run test' function. That would be a more
> direct approach, but also more verbose than a single KUNIT_ASSERT()
> line. It would be more kernel idiomatic too because the control flow

Yeah, I was intentionally going against that idiom. I think that idiom
makes test logic more complicated than it needs to be, especially if
the assertion failure happens in a helper function; then you have to
pass that error all the way back up. It is important that test code
should be as simple as possible to the point of being immediately
obviously correct at first glance because there are no tests for
tests.

The idea with assertions is that you use them to state all the
preconditions for your test. Logically speaking, these are the
premises of the test case, so if a premise isn't true, there is no
point in continuing the test case because there are no conclusions
that can be drawn without the premises. Whereas, the expectation is
the thing you are trying to prove. It is not used universally in
x-unit style test frameworks, but I really like it as a convention.
You could still express the idea of a premise using the above idiom,
but I think KUNIT_ASSERT_* states the intended idea perfectly.

> isn't hidden inside a macro and it isn't intimately connected with
> kthreads and completions.

Yeah, I wasn't a fan of that myself, but it was broadly available. My
previous version (still the architecture specific version for UML, not
in this patchset though) relies on UML_LONGJMP, but is obviously only
works on UML. A number of people wanted support for other
architectures. Rob and Luis specifically wanted me to provide a
version of abort that would work on any architecture, even if it only
had reduced functionality; I thought this fit the bill okay.

>
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> [...]
> > diff --git a/kunit/test-test.c b/kunit/test-test.c
> > new file mode 100644
> > index 0000000000000..a936c041f1c8f
>
> Could this whole file be another patch? It seems to be a test for the
> try catch mechanism.

Sure.

>
> > diff --git a/kunit/test.c b/kunit/test.c
> > index d18c50d5ed671..6e5244642ab07 100644
> > --- a/kunit/test.c
> > +++ b/kunit/test.c
> [...]
> > +
> > +static void kunit_generic_throw(struct kunit_try_catch *try_catch)
> > +{
> > +       try_catch->context.try_result = -EFAULT;
> > +       complete_and_exit(try_catch->context.try_completion, -EFAULT);
> > +}
> > +
> > +static int kunit_generic_run_threadfn_adapter(void *data)
> > +{
> > +       struct kunit_try_catch *try_catch = data;
> >
> > +       try_catch->try(&try_catch->context);
> > +
> > +       complete_and_exit(try_catch->context.try_completion, 0);
>
> The exit code doesn't matter, right? If so, it might be clearer to just
> return 0 from this function because kthreads exit themselves as far as I
> recall.

You mean complete and then return?

>
> > +}
> > +
> > +static void kunit_generic_run_try_catch(struct kunit_try_catch *try_catch)
> > +{
> > +       struct task_struct *task_struct;
> > +       struct kunit *test = try_catch->context.test;
> > +       int exit_code, wake_result;
> > +       DECLARE_COMPLETION(test_case_completion);
>
> DECLARE_COMPLETION_ONSTACK()?

Whoops, yeah, that one.

>
> > +
> > +       try_catch->context.try_completion = &test_case_completion;
> > +       try_catch->context.try_result = 0;
> > +       task_struct = kthread_create(kunit_generic_run_threadfn_adapter,
> > +                                            try_catch,
> > +                                            "kunit_try_catch_thread");
> > +       if (IS_ERR_OR_NULL(task_struct)) {
>
> It looks like NULL is never returned from kthread_create(), so don't
> check for it here.

Bad habit, sorry.

>
> > +               try_catch->catch(&try_catch->context);
> > +               return;
> > +       }
> > +
> > +       wake_result = wake_up_process(task_struct);
> > +       if (wake_result != 0 && wake_result != 1) {
>
> These are the only two possible return values of wake_up_process(), so
> why not just use kthread_run() and check for an error on the process
> creation?

Good point, I am not sure why I did that.

>
> > +               kunit_err(test, "task was not woken properly: %d", wake_result);
> > +               try_catch->catch(&try_catch->context);
> > +       }
> > +
> > +       /*
> > +        * TODO(brendanhiggins@google.com): We should probably have some type of
> > +        * timeout here. The only question is what that timeout value should be.
> > +        *
> > +        * The intention has always been, at some point, to be able to label
> > +        * tests with some type of size bucket (unit/small, integration/medium,
> > +        * large/system/end-to-end, etc), where each size bucket would get a
> > +        * default timeout value kind of like what Bazel does:
> > +        * https://docs.bazel.build/versions/master/be/common-definitions.html#test.size
> > +        * There is still some debate to be had on exactly how we do this. (For
> > +        * one, we probably want to have some sort of test runner level
> > +        * timeout.)
> > +        *
> > +        * For more background on this topic, see:
> > +        * https://mike-bland.com/2011/11/01/small-medium-large.html
> > +        */
> > +       wait_for_completion(&test_case_completion);
>
> It doesn't seem like a bad idea to make this have some arbitrarily large
> timeout value to start with. Just to make sure the whole thing doesn't
> get wedged. It's a timeout, so in theory it should never trigger if it's
> large enough.

Seems reasonable.

>
> > +
> > +       exit_code = try_catch->context.try_result;
> > +       if (exit_code == -EFAULT)
> > +               try_catch->catch(&try_catch->context);
> > +       else if (exit_code == -EINTR)
> > +               kunit_err(test, "wake_up_process() was never called.");
>
> Does kunit_err() add newlines? It would be good to stick to the rest of
> kernel style (printk, tracing, etc.) and rely on the callers to have the
> newlines they want. Also, remove the full-stop because it isn't really
> necessary to have those in error logs.

Will do.

>
> > +       else if (exit_code)
> > +               kunit_err(test, "Unknown error: %d", exit_code);
> > +}
> > +
> > +void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch)
> > +{
> > +       try_catch->run = kunit_generic_run_try_catch;
>
> Is the idea that 'run' would be anything besides
> 'kunit_generic_run_try_catch'? If it isn't going to be different, then

Yeah, it can be overridden with an architecture specific version.

> maybe it's simpler to just have a function like
> kunit_generic_run_try_catch() that is called by the unit tests instead
> of having to write 'try_catch->run(try_catch)' and indirect for the
> basic case. Maybe I've missed the point entirely though and this is all
> scaffolding for more complicated exception handling later on.

Yeah, the idea is that different architectures can override exception
handling with their own implementation. This is just the generic one.
For example, UML has one that doesn't depend on kthreads or
completions; the UML version also allows recovery from some segfault
conditions.

>
> > +       try_catch->throw = kunit_generic_throw;
> > +}
> > +
> > +void __weak kunit_try_catch_init(struct kunit_try_catch *try_catch)
> > +{
> > +       kunit_generic_try_catch_init(try_catch);
> > +}
> > +
> > +static void kunit_try_run_case(struct kunit_try_catch_context *context)
> > +{
> > +       struct kunit_try_catch_context *ctx = context;
> > +       struct kunit *test = ctx->test;
> > +       struct kunit_module *module = ctx->module;
> > +       struct kunit_case *test_case = ctx->test_case;
> > +
> > +       /*
> > +        * kunit_run_case_internal may encounter a fatal error; if it does, we
> > +        * will jump to ENTER_HANDLER above instead of continuing normal control
>
> Where is 'ENTER_HANDLER' above?

Whoops, sorry, that is left over from v3. Will remove.

>
> > +        * flow.
> > +        */
> >         kunit_run_case_internal(test, module, test_case);
> > +       /* This line may never be reached. */
> >         kunit_run_case_cleanup(test, module, test_case);
> > +}

Thanks!
