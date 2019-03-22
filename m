Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D31C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEABB218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o46QXeHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfCVBKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:10:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37622 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfCVBKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:10:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so320640pfr.4;
        Thu, 21 Mar 2019 18:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QgBnLuwIoaOqn1M2NY5NRuDQzGpKg4quCarl6P8ka20=;
        b=o46QXeHbDWNFb0zRD1LbeA8hd2BO3AJRl1uX3Gx6eJHOuSVeNBMPmhmYRlxhWNZHeF
         OrWurnpBRHTk7E6mK+eTzDVgQWAG1IQLEybMBwjdn+3AeizcZkdMBjM57LSkjiJ4Pfa4
         kHjThjRC2JfkiD184ofJXOj8fTN7Ua+OD8lrAdM5A8eLK2GojfnB8GFBGHQJDCyM/RPu
         7iTDPyQphVZCgTIunKnRuqZaAHop0Nd8MlVKVKLsfDEkQJft/OWyFkg1h6DeAcnZue3H
         YkVEjLz+oaFIqLOXOhJ8vFojuCfuavj3FrdPZNYYqrv8iwiVQgXzaQVKPui/2OLqbVsd
         LyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QgBnLuwIoaOqn1M2NY5NRuDQzGpKg4quCarl6P8ka20=;
        b=MAQ7+6hhjearO+MPBIr9xu0n7AZQjV3ek0LD6EUMcS77S9J1jf9V8prVv6KpEEuXqF
         6zxH3XV4dVe4mvycwE3L3QDO5cQvInBq46EmEcG1wA+iNQCaQiRJnXWgyMCZDI+7I6Fw
         90qK10UKzogSZDPs/GhxhP5e9MFVoMrpoRC3RHR9iPusT/RsZcg+yQKGv+bAKX1/uRg6
         AmsZrNs585ZsI3DDitqxhD/QpPVJ66AtCB8JWIw6pGFCFrHgHP4As82r2uaKT6XbQYab
         aQFgZ5udhlAG6+PAYxAVyGc/a/LgmfosFKdl3S5ZOrSGwbwdkzmTsbM6623N6Biv5XRt
         murA==
X-Gm-Message-State: APjAAAVrw1rVd0/H+h3nLWSy97jpKQHLlrUnY+2uzKk5FyjGTCtjWKfl
        qeucaApjQpGtvFtDqynosLM=
X-Google-Smtp-Source: APXvYqz+t7YnjfWrjarZWBhs0tGaH2Fq1O/OnJ3JF85QA7MrGnP3NzRHb8yTSYPgkEYj2d6VVBVVyA==
X-Received: by 2002:a65:6299:: with SMTP id f25mr6334824pgv.376.1553216998936;
        Thu, 21 Mar 2019 18:09:58 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id p34sm10873576pgb.18.2019.03.21.18.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:09:58 -0700 (PDT)
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
To:     Brendan Higgins <brendanhiggins@google.com>
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
        wfg@linux.intel.com, Frank Rowand <frowand.list@gmail.com>
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com>
 <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
 <CAFd5g467OV8wTB7zEshgZw8g8=zoq0dLVfwx3wDH-8UA+9GWFA@mail.gmail.com>
 <0124ed28-466c-e954-ddde-495419630a9f@gmail.com>
 <CAFd5g47EDmsBWKNiW0jpHW2VG_GWCfe8UO+=ofgM2_ru+_UBQA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <118d89b7-d468-6d68-a48d-4d6d9cefd106@gmail.com>
Date:   Thu, 21 Mar 2019 18:09:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47EDmsBWKNiW0jpHW2VG_GWCfe8UO+=ofgM2_ru+_UBQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 11:42 PM, Brendan Higgins wrote:
> On Tue, Feb 19, 2019 at 10:44 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 2/19/19 7:39 PM, Brendan Higgins wrote:
>>> On Mon, Feb 18, 2019 at 11:52 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> On 2/14/19 1:37 PM, Brendan Higgins wrote:
>>>>> Add support for aborting/bailing out of test cases. Needed for
>>>>> implementing assertions.
>>>>>
>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>>> ---
>>>>> Changes Since Last Version
>>>>>  - This patch is new introducing a new cross-architecture way to abort
>>>>>    out of a test case (needed for KUNIT_ASSERT_*, see next patch for
>>>>>    details).
>>>>>  - On a side note, this is not a complete replacement for the UML abort
>>>>>    mechanism, but covers the majority of necessary functionality. UML
>>>>>    architecture specific featurs have been dropped from the initial
>>>>>    patchset.
>>>>> ---
>>>>>  include/kunit/test.h |  24 +++++
>>>>>  kunit/Makefile       |   3 +-
>>>>>  kunit/test-test.c    | 127 ++++++++++++++++++++++++++
>>>>>  kunit/test.c         | 208 +++++++++++++++++++++++++++++++++++++++++--
>>>>>  4 files changed, 353 insertions(+), 9 deletions(-)
>>>>>  create mode 100644 kunit/test-test.c
>>>>
>>>> < snip >
>>>>
>>>>> diff --git a/kunit/test.c b/kunit/test.c
>>>>> index d18c50d5ed671..6e5244642ab07 100644
>>>>> --- a/kunit/test.c
>>>>> +++ b/kunit/test.c
>>>>> @@ -6,9 +6,9 @@
>>>>>   * Author: Brendan Higgins <brendanhiggins@google.com>
>>>>>   */
>>>>>
>>>>> -#include <linux/sched.h>
>>>>>  #include <linux/sched/debug.h>
>>>>> -#include <os.h>
>>>>> +#include <linux/completion.h>
>>>>> +#include <linux/kthread.h>
>>>>>  #include <kunit/test.h>
>>>>>
>>>>>  static bool kunit_get_success(struct kunit *test)
>>>>> @@ -32,6 +32,27 @@ static void kunit_set_success(struct kunit *test, bool success)
>>>>>       spin_unlock_irqrestore(&test->lock, flags);
>>>>>  }
>>>>>
>>>>> +static bool kunit_get_death_test(struct kunit *test)
>>>>> +{
>>>>> +     unsigned long flags;
>>>>> +     bool death_test;
>>>>> +
>>>>> +     spin_lock_irqsave(&test->lock, flags);
>>>>> +     death_test = test->death_test;
>>>>> +     spin_unlock_irqrestore(&test->lock, flags);
>>>>> +
>>>>> +     return death_test;
>>>>> +}
>>>>> +
>>>>> +static void kunit_set_death_test(struct kunit *test, bool death_test)
>>>>> +{
>>>>> +     unsigned long flags;
>>>>> +
>>>>> +     spin_lock_irqsave(&test->lock, flags);
>>>>> +     test->death_test = death_test;
>>>>> +     spin_unlock_irqrestore(&test->lock, flags);
>>>>> +}
>>>>> +
>>>>>  static int kunit_vprintk_emit(const struct kunit *test,
>>>>>                             int level,
>>>>>                             const char *fmt,
>>>>> @@ -70,13 +91,29 @@ static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
>>>>>       stream->commit(stream);
>>>>>  }
>>>>>
>>>>> +static void __noreturn kunit_abort(struct kunit *test)
>>>>> +{
>>>>> +     kunit_set_death_test(test, true);
>>>>> +
>>>>> +     test->try_catch.throw(&test->try_catch);
>>>>> +
>>>>> +     /*
>>>>> +      * Throw could not abort from test.
>>>>> +      */
>>>>> +     kunit_err(test, "Throw could not abort from test!");
>>>>> +     show_stack(NULL, NULL);
>>>>> +     BUG();
>>>>
>>>> kunit_abort() is what will be call as the result of an assert failure.
>>>
>>> Yep. Does that need clarified somewhere.
>>>>
>>>> BUG(), which is a panic, which is crashing the system is not acceptable
>>>> in the Linux kernel.  You will just annoy Linus if you submit this.
>>>
>>> Sorry, I thought this was an acceptable use case since, a) this should
>>> never be compiled in a production kernel, b) we are in a pretty bad,
>>> unpredictable state if we get here and keep going. I think you might
>>> have said elsewhere that you think "a" is not valid? In any case, I
>>> can replace this with a WARN, would that be acceptable?
>>
>> A WARN may or may not make sense, depending on the context.  It may
>> be sufficient to simply report a test failure (as in the old version
>> of case (2) below.
>>
>> Answers to "a)" and "b)":
>>
>> a) it might be in a production kernel
> 
> Sorry for a possibly stupid question, how might it be so? Why would
> someone intentionally build unit tests into a production kernel?

People do things.  Just expect it.


>>
>> a') it is not acceptable in my development kernel either
> 
> Fair enough.
> 
>>
>> b) No.  You don't crash a developer's kernel either unless it is
>> required to avoid data corruption.
> 
> Alright, I thought that was one of those cases, but I am not going to
> push the point. Also, in case it wasn't clear, the path where BUG()
> gets called only happens if there is a bug in KUnit itself, not just
> because a test case fails catastrophically.

Still not out of the woods.  Still facing Lions and Tigers and Bears,
Oh my!

So kunit_abort() is normally called as the result of an assert
failure (as written many lines further above).

kunit_abort()
   test->try_catch.throw(&test->try_catch)
   // this is really kunit_generic_throw(), yes?
      complete_and_exit()
         if (comp)
            // comp is test_case_completion?
            complete(comp)
         do_exit()
            // void __noreturn do_exit(long code)
            // depending on the task, either panic
            // or the task dies

I did not read through enough of the code to understand what is going
on here.  Is each kunit_module executed in a newly created thread?
And if kunit_abort() is called then that thread dies?  Or something
else?


>>
>> b') And you can not do replacements like:
>>
>> (1) in of_unittest_check_tree_linkage()
>>
>> -----  old  -----
>>
>>         if (!of_root)
>>                 return;
>>
>> -----  new  -----
>>
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, of_root);
>>
>> (2) in of_unittest_property_string()
>>
>> -----  old  -----
>>
>>         /* of_property_read_string_index() tests */
>>         rc = of_property_read_string_index(np, "string-property", 0, strings);
>>         unittest(rc == 0 && !strcmp(strings[0], "foobar"), "of_property_read_string_index() failure; rc=%i\n", rc);
>>
>> -----  new  -----
>>
>>         /* of_property_read_string_index() tests */
>>         rc = of_property_read_string_index(np, "string-property", 0, strings);
>>         KUNIT_ASSERT_EQ(test, rc, 0);
>>         KUNIT_EXPECT_STREQ(test, strings[0], "foobar");
>>
>>
>> If a test fails, that is no reason to abort testing.  The remainder of the unit
>> tests can still run.  There may be cascading failures, but that is ok.
> 
> Sure, that's what I am trying to do. I don't see how (1) changes
> anything, a failed KUNIT_ASSERT_* only bails on the current test case,
> it does not quit the entire test suite let alone crash the kernel.

This may be another case of whether a kunit_module is approximately a
single KUNIT_EXPECT_*() or a larger number of them.

I still want, for example, of_unittest_property_string() to include a large
number of KUNIT_EXPECT_*() instances.  In that case I still want the rest of
the tests in the kunit_module to be executed even after a KUNIT_ASSERT_*()
fails.  The existing test code has that property.


> 
> In case it wasn't clear above,
>>>>> +     test->try_catch.throw(&test->try_catch);
> should never, ever return. The only time it would, would be if KUnit
> was very broken. This should never actually happen, even if the
> assertion that called it was violated. KUNIT_ASSERT_* just says, "this
> is a prerequisite property for this test case"; if it is violated, the
> test case should fail and bail because the preconditions for the test
> case cannot be satisfied. Nevertheless, other tests cases will still
> run.
> 

