Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9FA213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmlrKR/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfCVBl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:41:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41686 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfCVBl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:41:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id 64so575599otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 18:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90z3Dca3x8TdCg1Z4XryTQ6vmZb+Ca6RF9G47g6ZwCM=;
        b=LmlrKR/HqqSQa2mlc4kMmvdjRzRErBVgs/sEMbner1xLS0Cjker+KWl/HVAGSbSc2+
         khxAwifIohIA2LNadvCv38sLOJfOQTGinRDsh64onY4RKluLcc/oMqS2Sh2fXPHYeg2j
         fMASKARaLXPvkuYc7txAT45BXEXviDNaR6w+ErxBZOipYuk/4qNOd8xmw3oHvTv1/+nw
         FmR22EqbkY/drc2DX5LNJM4bTcPUPtJrSAs7S3nx8LCd26Khao3W0kVFo6vgUcTUyKs3
         hBaYpZsuSaczfwu5TmvzU1pEenoMXvcBWVs1S+LlhRpO62hYYlyv9qb8oLCwUKsyUNxS
         L0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90z3Dca3x8TdCg1Z4XryTQ6vmZb+Ca6RF9G47g6ZwCM=;
        b=J9NYRAk/rpSoWF3OOeTHxmlJuf1lb1VzLmwOv/kMy+1bv64k35E99IL1o2hCfwWq1C
         lGhe52/0xInc2YNh6V4K5sm4xcZj8NUsrN1VSn06MH29BUFL4pBmT1Uw3jYnGt+h14Ei
         raiz9rjcf2svfqovu/iWSdc/eSFTT6ARrHvaXsdBdmkYLj56T7N7pu4nikWJbJvnklXv
         CRxFWSvUkeo4TZZQmODl7kZ9pSl/KNOSDh26F6gDHTMg0IytqBkno5F7wynXnIpRLIrb
         9FV/axscReZXjdx7290B9OrnvXATZnZ34yQisQG1lgh/fWZj0i96/ExBkJovHDM1jNjj
         4CBQ==
X-Gm-Message-State: APjAAAUd6xMESzprkETtzON9YRY1rCsNaBNtanZAaVX9pc/T8wXu9xe+
        /CtQ94QwRYTtyMogXBdkddoOW124zy2dbbc6Q5RUFA==
X-Google-Smtp-Source: APXvYqwDhVXuwrt+B1PkZI96+nFMjHIg5pyl+U8vcgb4f27kJ1h8vTsUDQvYtDdqHjEmyBtHdKb521UwWxE0X8F/QWs=
X-Received: by 2002:a9d:51ca:: with SMTP id d10mr4744537oth.83.1553218917811;
 Thu, 21 Mar 2019 18:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com> <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
 <CAFd5g467OV8wTB7zEshgZw8g8=zoq0dLVfwx3wDH-8UA+9GWFA@mail.gmail.com>
 <0124ed28-466c-e954-ddde-495419630a9f@gmail.com> <CAFd5g47EDmsBWKNiW0jpHW2VG_GWCfe8UO+=ofgM2_ru+_UBQA@mail.gmail.com>
 <118d89b7-d468-6d68-a48d-4d6d9cefd106@gmail.com>
In-Reply-To: <118d89b7-d468-6d68-a48d-4d6d9cefd106@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 21 Mar 2019 18:41:46 -0700
Message-ID: <CAFd5g46AP9yZQ+z+60HGaZuqhJQmfSBw9+r62w4k=cGiMEkqLA@mail.gmail.com>
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
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

On Thu, Mar 21, 2019 at 6:10 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/27/19 11:42 PM, Brendan Higgins wrote:
> > On Tue, Feb 19, 2019 at 10:44 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 2/19/19 7:39 PM, Brendan Higgins wrote:
> >>> On Mon, Feb 18, 2019 at 11:52 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>
> >>>> On 2/14/19 1:37 PM, Brendan Higgins wrote:
> >>>>> Add support for aborting/bailing out of test cases. Needed for
> >>>>> implementing assertions.
> >>>>>
> >>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >>>>> ---
> >>>>> Changes Since Last Version
> >>>>>  - This patch is new introducing a new cross-architecture way to abort
> >>>>>    out of a test case (needed for KUNIT_ASSERT_*, see next patch for
> >>>>>    details).
> >>>>>  - On a side note, this is not a complete replacement for the UML abort
> >>>>>    mechanism, but covers the majority of necessary functionality. UML
> >>>>>    architecture specific featurs have been dropped from the initial
> >>>>>    patchset.
> >>>>> ---
> >>>>>  include/kunit/test.h |  24 +++++
> >>>>>  kunit/Makefile       |   3 +-
> >>>>>  kunit/test-test.c    | 127 ++++++++++++++++++++++++++
> >>>>>  kunit/test.c         | 208 +++++++++++++++++++++++++++++++++++++++++--
> >>>>>  4 files changed, 353 insertions(+), 9 deletions(-)
> >>>>>  create mode 100644 kunit/test-test.c
> >>>>
> >>>> < snip >
> >>>>
> >>>>> diff --git a/kunit/test.c b/kunit/test.c
> >>>>> index d18c50d5ed671..6e5244642ab07 100644
> >>>>> --- a/kunit/test.c
> >>>>> +++ b/kunit/test.c
> >>>>> @@ -6,9 +6,9 @@
> >>>>>   * Author: Brendan Higgins <brendanhiggins@google.com>
> >>>>>   */
> >>>>>
> >>>>> -#include <linux/sched.h>
> >>>>>  #include <linux/sched/debug.h>
> >>>>> -#include <os.h>
> >>>>> +#include <linux/completion.h>
> >>>>> +#include <linux/kthread.h>
> >>>>>  #include <kunit/test.h>
> >>>>>
> >>>>>  static bool kunit_get_success(struct kunit *test)
> >>>>> @@ -32,6 +32,27 @@ static void kunit_set_success(struct kunit *test, bool success)
> >>>>>       spin_unlock_irqrestore(&test->lock, flags);
> >>>>>  }
> >>>>>
> >>>>> +static bool kunit_get_death_test(struct kunit *test)
> >>>>> +{
> >>>>> +     unsigned long flags;
> >>>>> +     bool death_test;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&test->lock, flags);
> >>>>> +     death_test = test->death_test;
> >>>>> +     spin_unlock_irqrestore(&test->lock, flags);
> >>>>> +
> >>>>> +     return death_test;
> >>>>> +}
> >>>>> +
> >>>>> +static void kunit_set_death_test(struct kunit *test, bool death_test)
> >>>>> +{
> >>>>> +     unsigned long flags;
> >>>>> +
> >>>>> +     spin_lock_irqsave(&test->lock, flags);
> >>>>> +     test->death_test = death_test;
> >>>>> +     spin_unlock_irqrestore(&test->lock, flags);
> >>>>> +}
> >>>>> +
> >>>>>  static int kunit_vprintk_emit(const struct kunit *test,
> >>>>>                             int level,
> >>>>>                             const char *fmt,
> >>>>> @@ -70,13 +91,29 @@ static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
> >>>>>       stream->commit(stream);
> >>>>>  }
> >>>>>
> >>>>> +static void __noreturn kunit_abort(struct kunit *test)
> >>>>> +{
> >>>>> +     kunit_set_death_test(test, true);
> >>>>> +
> >>>>> +     test->try_catch.throw(&test->try_catch);
> >>>>> +
> >>>>> +     /*
> >>>>> +      * Throw could not abort from test.
> >>>>> +      */
> >>>>> +     kunit_err(test, "Throw could not abort from test!");
> >>>>> +     show_stack(NULL, NULL);
> >>>>> +     BUG();
> >>>>
> >>>> kunit_abort() is what will be call as the result of an assert failure.
> >>>
> >>> Yep. Does that need clarified somewhere.
> >>>>
> >>>> BUG(), which is a panic, which is crashing the system is not acceptable
> >>>> in the Linux kernel.  You will just annoy Linus if you submit this.
> >>>
> >>> Sorry, I thought this was an acceptable use case since, a) this should
> >>> never be compiled in a production kernel, b) we are in a pretty bad,
> >>> unpredictable state if we get here and keep going. I think you might
> >>> have said elsewhere that you think "a" is not valid? In any case, I
> >>> can replace this with a WARN, would that be acceptable?
> >>
> >> A WARN may or may not make sense, depending on the context.  It may
> >> be sufficient to simply report a test failure (as in the old version
> >> of case (2) below.
> >>
> >> Answers to "a)" and "b)":
> >>
> >> a) it might be in a production kernel
> >
> > Sorry for a possibly stupid question, how might it be so? Why would
> > someone intentionally build unit tests into a production kernel?
>
> People do things.  Just expect it.

Huh, alright. I will take your word for it then.

>
> >>
> >> a') it is not acceptable in my development kernel either
> >
> > Fair enough.
> >
> >>
> >> b) No.  You don't crash a developer's kernel either unless it is
> >> required to avoid data corruption.
> >
> > Alright, I thought that was one of those cases, but I am not going to
> > push the point. Also, in case it wasn't clear, the path where BUG()
> > gets called only happens if there is a bug in KUnit itself, not just
> > because a test case fails catastrophically.
>
> Still not out of the woods.  Still facing Lions and Tigers and Bears,
> Oh my!

Nope, I guess not :-)

>
> So kunit_abort() is normally called as the result of an assert
> failure (as written many lines further above).
>
> kunit_abort()
>    test->try_catch.throw(&test->try_catch)
>    // this is really kunit_generic_throw(), yes?
>       complete_and_exit()
>          if (comp)
>             // comp is test_case_completion?
>             complete(comp)
>          do_exit()
>             // void __noreturn do_exit(long code)
>             // depending on the task, either panic
>             // or the task dies

You are right up until after it calls do_exit().

KUnit actually spawns a thread for the test case to run in so that
when exit is called, only the test case thread dies. The thread that
started KUnit is never affected.

>
> I did not read through enough of the code to understand what is going
> on here.  Is each kunit_module executed in a newly created thread?
> And if kunit_abort() is called then that thread dies?  Or something
> else?

Mostly right, each kunit_case (not kunit_module) gets executed in its
own newly created thread. If kunit_abort() is called in that thread,
the kunit_case thread dies. The parent thread keeps going, and other
test cases are executed.

>
>
> >>
> >> b') And you can not do replacements like:
> >>
> >> (1) in of_unittest_check_tree_linkage()
> >>
> >> -----  old  -----
> >>
> >>         if (!of_root)
> >>                 return;
> >>
> >> -----  new  -----
> >>
> >>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, of_root);
> >>
> >> (2) in of_unittest_property_string()
> >>
> >> -----  old  -----
> >>
> >>         /* of_property_read_string_index() tests */
> >>         rc = of_property_read_string_index(np, "string-property", 0, strings);
> >>         unittest(rc == 0 && !strcmp(strings[0], "foobar"), "of_property_read_string_index() failure; rc=%i\n", rc);
> >>
> >> -----  new  -----
> >>
> >>         /* of_property_read_string_index() tests */
> >>         rc = of_property_read_string_index(np, "string-property", 0, strings);
> >>         KUNIT_ASSERT_EQ(test, rc, 0);
> >>         KUNIT_EXPECT_STREQ(test, strings[0], "foobar");
> >>
> >>
> >> If a test fails, that is no reason to abort testing.  The remainder of the unit
> >> tests can still run.  There may be cascading failures, but that is ok.
> >
> > Sure, that's what I am trying to do. I don't see how (1) changes
> > anything, a failed KUNIT_ASSERT_* only bails on the current test case,
> > it does not quit the entire test suite let alone crash the kernel.
>
> This may be another case of whether a kunit_module is approximately a
> single KUNIT_EXPECT_*() or a larger number of them.
>
> I still want, for example, of_unittest_property_string() to include a large
> number of KUNIT_EXPECT_*() instances.  In that case I still want the rest of
> the tests in the kunit_module to be executed even after a KUNIT_ASSERT_*()
> fails.  The existing test code has that property.

Sure, in the context of the reply you just sent me on the DT unittest
thread, that makes sense. I can pull out all but the ones that would
have terminated the collection of test cases (where you return early),
if that makes it better.
