Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACD9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6C821850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FeIlB/Mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfB1Hms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:42:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38962 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbfB1Hmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:42:47 -0500
Received: by mail-ot1-f68.google.com with SMTP id e15so7256547otk.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 23:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4OeSZtDovplvAQyNL3HshW6Hp84vdZiJpd1r1wdKWc=;
        b=FeIlB/Mn8jaREKiu5kiqBg/dbvuj8HgMH+lSWw8Vkrnqi9BSVBkGxRUDpd4R3x2Hxn
         nEs26yUTb0INthoZ7OPJF7xyjLhQoc8nskZq6+hTUaDj45sKHW19Hb5BihtjAH64hAry
         8LUpAfYCYBvX6qB63rJHUthNjZBoQatbgrwadEgSKppCjGgd2JK2CEv7LMe9CRnXV7jK
         I5gGotilARxUB3vHsuHpYf1OACL+yFwrr10EkJOnJwBHQCkHVR6GjmuuUopgAo07sCdM
         HRvpw5mCjFM+IA0ynfBKbDddS0pl2W/5I3HD4d4Mzka92er9pEy61i0/4tZEC3onf5Pn
         7dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4OeSZtDovplvAQyNL3HshW6Hp84vdZiJpd1r1wdKWc=;
        b=rfgiRs3xBPWUgq6fjYid1AbkYx+GwUFT1ne65eVNmAMRI6qjr5mQLwkYOAoIWUhpLL
         45ZQ6OBTkqCibVGZaYrpYn1scW8VMFBKnHY71cF2lyLxujG/h4CQ3rcsUthUoihdIRxY
         fXGFMBYnBKM/ZxyMcpdvm/tzQ846QbFDetWvh22kFxaWYigxeg/Vfhq1UZczwRVi56WU
         sT65fyuGlxhj0TQcdjSxasRNT6V8704fdNLZhENAt5wKGfFUHdj8pgs3HTVZrhkGjZGR
         /dPfpYLL3XBB2V+roKZ2kGlSRRGocBPpCMqgpOp72qkL/SUaouk1jkZSlR30HDKH/K2t
         Y9qA==
X-Gm-Message-State: AHQUAubj3Hmqrfi8S3fI0Z7HhXoebeAGrZABxVo436xn8Udfx7PSkfIG
        rUUg47Hd0WzACD1LBUhkv7ga5n8rhnp19DZvp905Rg==
X-Google-Smtp-Source: APXvYqzBd1+8XOEIYiFPzgkv+hGNGR2IlGHLkk7BG93Dufxr/DGkUqfNyw5vjvshQVs2LTFwzHDnE5Q6MtFyNM2T/cI=
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr3323688otj.230.1551339765252;
 Wed, 27 Feb 2019 23:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com> <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
 <CAFd5g467OV8wTB7zEshgZw8g8=zoq0dLVfwx3wDH-8UA+9GWFA@mail.gmail.com> <0124ed28-466c-e954-ddde-495419630a9f@gmail.com>
In-Reply-To: <0124ed28-466c-e954-ddde-495419630a9f@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 27 Feb 2019 23:42:33 -0800
Message-ID: <CAFd5g47EDmsBWKNiW0jpHW2VG_GWCfe8UO+=ofgM2_ru+_UBQA@mail.gmail.com>
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
        Amir Goldstein <amir73il@gmail.com>, dan.carpenter@oracle.com,
        wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 10:44 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/19/19 7:39 PM, Brendan Higgins wrote:
> > On Mon, Feb 18, 2019 at 11:52 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 2/14/19 1:37 PM, Brendan Higgins wrote:
> >>> Add support for aborting/bailing out of test cases. Needed for
> >>> implementing assertions.
> >>>
> >>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >>> ---
> >>> Changes Since Last Version
> >>>  - This patch is new introducing a new cross-architecture way to abort
> >>>    out of a test case (needed for KUNIT_ASSERT_*, see next patch for
> >>>    details).
> >>>  - On a side note, this is not a complete replacement for the UML abort
> >>>    mechanism, but covers the majority of necessary functionality. UML
> >>>    architecture specific featurs have been dropped from the initial
> >>>    patchset.
> >>> ---
> >>>  include/kunit/test.h |  24 +++++
> >>>  kunit/Makefile       |   3 +-
> >>>  kunit/test-test.c    | 127 ++++++++++++++++++++++++++
> >>>  kunit/test.c         | 208 +++++++++++++++++++++++++++++++++++++++++--
> >>>  4 files changed, 353 insertions(+), 9 deletions(-)
> >>>  create mode 100644 kunit/test-test.c
> >>
> >> < snip >
> >>
> >>> diff --git a/kunit/test.c b/kunit/test.c
> >>> index d18c50d5ed671..6e5244642ab07 100644
> >>> --- a/kunit/test.c
> >>> +++ b/kunit/test.c
> >>> @@ -6,9 +6,9 @@
> >>>   * Author: Brendan Higgins <brendanhiggins@google.com>
> >>>   */
> >>>
> >>> -#include <linux/sched.h>
> >>>  #include <linux/sched/debug.h>
> >>> -#include <os.h>
> >>> +#include <linux/completion.h>
> >>> +#include <linux/kthread.h>
> >>>  #include <kunit/test.h>
> >>>
> >>>  static bool kunit_get_success(struct kunit *test)
> >>> @@ -32,6 +32,27 @@ static void kunit_set_success(struct kunit *test, bool success)
> >>>       spin_unlock_irqrestore(&test->lock, flags);
> >>>  }
> >>>
> >>> +static bool kunit_get_death_test(struct kunit *test)
> >>> +{
> >>> +     unsigned long flags;
> >>> +     bool death_test;
> >>> +
> >>> +     spin_lock_irqsave(&test->lock, flags);
> >>> +     death_test = test->death_test;
> >>> +     spin_unlock_irqrestore(&test->lock, flags);
> >>> +
> >>> +     return death_test;
> >>> +}
> >>> +
> >>> +static void kunit_set_death_test(struct kunit *test, bool death_test)
> >>> +{
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&test->lock, flags);
> >>> +     test->death_test = death_test;
> >>> +     spin_unlock_irqrestore(&test->lock, flags);
> >>> +}
> >>> +
> >>>  static int kunit_vprintk_emit(const struct kunit *test,
> >>>                             int level,
> >>>                             const char *fmt,
> >>> @@ -70,13 +91,29 @@ static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
> >>>       stream->commit(stream);
> >>>  }
> >>>
> >>> +static void __noreturn kunit_abort(struct kunit *test)
> >>> +{
> >>> +     kunit_set_death_test(test, true);
> >>> +
> >>> +     test->try_catch.throw(&test->try_catch);
> >>> +
> >>> +     /*
> >>> +      * Throw could not abort from test.
> >>> +      */
> >>> +     kunit_err(test, "Throw could not abort from test!");
> >>> +     show_stack(NULL, NULL);
> >>> +     BUG();
> >>
> >> kunit_abort() is what will be call as the result of an assert failure.
> >
> > Yep. Does that need clarified somewhere.
> >>
> >> BUG(), which is a panic, which is crashing the system is not acceptable
> >> in the Linux kernel.  You will just annoy Linus if you submit this.
> >
> > Sorry, I thought this was an acceptable use case since, a) this should
> > never be compiled in a production kernel, b) we are in a pretty bad,
> > unpredictable state if we get here and keep going. I think you might
> > have said elsewhere that you think "a" is not valid? In any case, I
> > can replace this with a WARN, would that be acceptable?
>
> A WARN may or may not make sense, depending on the context.  It may
> be sufficient to simply report a test failure (as in the old version
> of case (2) below.
>
> Answers to "a)" and "b)":
>
> a) it might be in a production kernel

Sorry for a possibly stupid question, how might it be so? Why would
someone intentionally build unit tests into a production kernel?

>
> a') it is not acceptable in my development kernel either

Fair enough.

>
> b) No.  You don't crash a developer's kernel either unless it is
> required to avoid data corruption.

Alright, I thought that was one of those cases, but I am not going to
push the point. Also, in case it wasn't clear, the path where BUG()
gets called only happens if there is a bug in KUnit itself, not just
because a test case fails catastrophically.

>
> b') And you can not do replacements like:
>
> (1) in of_unittest_check_tree_linkage()
>
> -----  old  -----
>
>         if (!of_root)
>                 return;
>
> -----  new  -----
>
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, of_root);
>
> (2) in of_unittest_property_string()
>
> -----  old  -----
>
>         /* of_property_read_string_index() tests */
>         rc = of_property_read_string_index(np, "string-property", 0, strings);
>         unittest(rc == 0 && !strcmp(strings[0], "foobar"), "of_property_read_string_index() failure; rc=%i\n", rc);
>
> -----  new  -----
>
>         /* of_property_read_string_index() tests */
>         rc = of_property_read_string_index(np, "string-property", 0, strings);
>         KUNIT_ASSERT_EQ(test, rc, 0);
>         KUNIT_EXPECT_STREQ(test, strings[0], "foobar");
>
>
> If a test fails, that is no reason to abort testing.  The remainder of the unit
> tests can still run.  There may be cascading failures, but that is ok.

Sure, that's what I am trying to do. I don't see how (1) changes
anything, a failed KUNIT_ASSERT_* only bails on the current test case,
it does not quit the entire test suite let alone crash the kernel.

In case it wasn't clear above,
> >>> +     test->try_catch.throw(&test->try_catch);
should never, ever return. The only time it would, would be if KUnit
was very broken. This should never actually happen, even if the
assertion that called it was violated. KUNIT_ASSERT_* just says, "this
is a prerequisite property for this test case"; if it is violated, the
test case should fail and bail because the preconditions for the test
case cannot be satisfied. Nevertheless, other tests cases will still
run.
