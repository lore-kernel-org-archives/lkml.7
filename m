Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07CCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F3C21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBw2frI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfJHXbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:31:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36404 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJHXbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:31:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so210989wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BfDXfH99UVjVWQ/cjdOOt7YXlVhgSigKHr6l1weSs0Y=;
        b=MBw2frI6q7Ynbali7+G3SF08qydxhhKYbaPyJ7xID566yV6nHhADoCM5NM4Er4XMfL
         h7OmApXhVNRbAhNtcTnd2EBHx4aes8rH/2Z//pAYGn4IjgqABTzz5cOevMDzIPJyEqVW
         ON0d2krjchS4boVHoTy83/zLZ3h86PbQfzeBnIu6N/I+3sNCrqRLxFSAYe3FrZ8nHNor
         TSK73r+yNaS2YVkEZUkz7wcCyKOyRYpKTV0iGUrsbIYFHIB/I0L9uFs7FAZkYYItCjDT
         AggwiCiESDJzGNcNAHe323TeSjqV+hSafZmSPCGnd/Ao2qMPLZ+Jq6XunSNO9FWYuqe/
         Aixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfDXfH99UVjVWQ/cjdOOt7YXlVhgSigKHr6l1weSs0Y=;
        b=NwUr+CXJdkRSGO9uABupimc0oeU7ZCLc7M3l/VgfvYPEKK+OUPS3e1wQzoYd7+zVmN
         k7dF6XxpHWuT3HpShChg+GDQF+ZZeV8sU+4BxJ8mUwIwVzl/BsmevZDEcSJTu4s4jfRg
         U4UKkrz4s4VJBOSutF3Fjo1bROqXjECg4g3RqIDaxfGybaee7y9rk0YY5afHgIa/y/yf
         Nq5rwnrwLBUeEfnydrLB2UklJrVN2U0gxpmIQH7cOQTsJagkVDmLJs4zAlL7NSofzhGK
         zuGa6peg05YQefVozecz2JaEVho0KXx26AtbRw9GL5eIX5O+mbeCVtY49xbI0zlI5nL0
         dvUw==
X-Gm-Message-State: APjAAAXIjFZ0Ni9EpxeX9ld5J9Q1wrf8bmfXb9C6ivSTZfM7IzF6u3Uy
        /XKm83CvCKStvFn5G9h1ZRZHhxEvcMcDgQoUmlgWqQ==
X-Google-Smtp-Source: APXvYqyMihax4fy5li8vt5+MW9vGp6GG1j/KjDVRjWWOSmpo1UI2vulQ1KtW9WsCdss88/reqv1TN/t5eQKV6Fg+L2U=
X-Received: by 2002:a1c:444:: with SMTP id 65mr250947wme.84.1570577458193;
 Tue, 08 Oct 2019 16:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191007213633.92565-1-davidgow@google.com> <201910071752.5E9CAEB@keescook>
In-Reply-To: <201910071752.5E9CAEB@keescook>
From:   David Gow <davidgow@google.com>
Date:   Tue, 8 Oct 2019 16:30:46 -0700
Message-ID: <CABVgOS=D1npnO8KY-_MeNvsFUqbG7O9eMmxQutw-g_PMTPMjuw@mail.gmail.com>
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked list
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        akpm@linux-foundation.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 6:03 PM Kees Cook <keescook@chromium.org> wrote:
(...)
> > +
> > +static void list_init_test(struct kunit *test)
> > +{
> > +     /* Test the different ways of initialising a list. */
> > +     struct list_head list1 = LIST_HEAD_INIT(list1);
> > +     struct list_head list2;
> > +     LIST_HEAD(list3);
> > +
> > +     INIT_LIST_HEAD(&list2);
>
> Can you also add different storage locations and initial contents tests?
> For example:
>
>         struct list_head *list4;
>         struct list_head *list5;
>
>         list4 = kzalloc(sizeof(*list4));
>         INIT_LIST_HEAD(list4);
>
>         list5 = kmalloc(sizeof(*list5));
>         memset(list4, 0xff, sizeof(*list5));
>         INIT_LIST_HEAD(list5);
>
>
>         KUNIT_EXPECT_TRUE(test, list_empty_careful(&list4));
>         KUNIT_EXPECT_TRUE(test, list_empty_careful(&list5));
>
>         kfree(list4);
>         kfree(list5);
>
> Then we know it's not an accident that INIT_LIST_HEAD() works when both
> all-zeros and all-0xFF initial contents are there. :)

Will do.

> > +static void list_entry_test(struct kunit *test)
> > +{
> > +     struct list_test_struct test_struct;
>
> I guess this is not a missing initialization here because this is just
> testing the container_of() wrapper macro?
>

Yeah: we shouldn't be doing any memory accesses here, just the pointer
manipulation, so it shouldn't matter.
I can add a comment pointing this out, or just initialise it anyway.

> > +
> > +     KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list), struct list_test_struct, list));
> > +}
> > +
> > +static void list_first_entry_test(struct kunit *test)
> > +{
> > +     struct list_test_struct test_struct1, test_struct2;
> > +     static LIST_HEAD(list);
>
> This is this static?
>

Oops, this doesn't need to be static. I'll fix this (and the others)
for the next version.

> > +static void list_for_each_test(struct kunit *test)
> > +{
> > +     struct list_head entries[3], *cur;
> > +     LIST_HEAD(list);
> > +     int i = 0;
> > +
> > +     list_add_tail(&entries[0], &list);
> > +     list_add_tail(&entries[1], &list);
> > +     list_add_tail(&entries[2], &list);
> > +
> > +     list_for_each(cur, &list) {
> > +             KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> > +             i++;
> > +     }
> > +
> > +     KUNIT_EXPECT_EQ(test, i, 3);
> > +}
> > +
> > +static void list_for_each_prev_test(struct kunit *test)
> > +{
> > +     struct list_head entries[3], *cur;
> > +     LIST_HEAD(list);
> > +     int i = 2;
> > +
> > +     list_add_tail(&entries[0], &list);
> > +     list_add_tail(&entries[1], &list);
> > +     list_add_tail(&entries[2], &list);
> > +
> > +     list_for_each_prev(cur, &list) {
> > +             KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> > +             i--;
> > +     }
> > +
> > +     KUNIT_EXPECT_EQ(test, i, -1);
>
> Both of these tests test that the list contained the correct number of
> entries, not that anything about ordering was established. I would load
> values into these with the list_test_struct and test that the counting
> matches the expected ordering.
>

These tests do check the order of the entries (the order of the list
should match the order of the entries array, and KUNIT_EXPECT_PTR_EQ()
is verifying that the entries[i] is correct).
It would be possible to actually use list_test_struct like with the
list_for_each_entry tests, but since list_for_each just returns the
list_head, it didn't seem useful, so long as the list_head pointers
match.

> > +}
> > +
> > +static void list_for_each_safe_test(struct kunit *test)
> > +{
> > +     struct list_head entries[3], *cur, *n;
> > +     LIST_HEAD(list);
> > +     int i = 0;
> > +
> > +
> > +     list_add_tail(&entries[0], &list);
> > +     list_add_tail(&entries[1], &list);
> > +     list_add_tail(&entries[2], &list);
> > +
> > +     list_for_each_safe(cur, n, &list) {
> > +             KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> > +             list_del(&entries[i]);
> > +             i++;
> > +     }
> > +
> > +     KUNIT_EXPECT_EQ(test, i, 3);
>
> I would expect an is_empty() test here too.
>

Will do.

> > +}
> > +
> > +static void list_for_each_prev_safe_test(struct kunit *test)
> > +{
> > +     struct list_head entries[3], *cur, *n;
> > +     LIST_HEAD(list);
> > +     int i = 2;
> > +
> > +     list_add_tail(&entries[0], &list);
> > +     list_add_tail(&entries[1], &list);
> > +     list_add_tail(&entries[2], &list);
> > +
> > +     list_for_each_prev_safe(cur, n, &list) {
> > +             KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> > +             list_del(&entries[i]);
> > +             i--;
> > +     }
>
> Same thing here.
>

Will do.

> > +static void list_for_each_entry_test(struct kunit *test)
> > +{
> > +     struct list_test_struct entries[5], *cur;
> > +     static LIST_HEAD(list);
> > +     int i = 0;
> > +
> > +     for (i = 0; i < 5; ++i) {
> > +             entries[i].data = i;
> > +             list_add_tail(&entries[i].list, &list);
> > +     }
> > +
> > +     i = 0;
> > +
> > +     list_for_each_entry(cur, &list, list) {
> > +             KUNIT_EXPECT_EQ(test, cur->data, i);
> > +             i++;
> > +     }
> > +}
> > +
> > +static void list_for_each_entry_reverse_test(struct kunit *test)
> > +{
> > +     struct list_test_struct entries[5], *cur;
> > +     static LIST_HEAD(list);
> > +     int i = 0;
> > +
> > +     for (i = 0; i < 5; ++i) {
> > +             entries[i].data = i;
> > +             list_add_tail(&entries[i].list, &list);
> > +     }
> > +
> > +     i = 4;
> > +
> > +     list_for_each_entry_reverse(cur, &list, list) {
> > +             KUNIT_EXPECT_EQ(test, cur->data, i);
> > +             i--;
> > +     }
>
> Oh! Here is the data test. Why keep these separate? You could combine
> the counting tests with these?
>
> One thing to consider adding is a short comment above each test to
> clarify the test intention. While these are relatively simple tests, it
> could clarify things like "only testing counts here" or "similar to
> test_foo(), this adds in ordering verification", etc.
>

The idea here was to have a separate test for each function/macro
being tested. This hopefully should make it easier to narrow down
where test failures are. In this case, the tests using
list_test_struct are here because list_for_each_entry() does the
implicit container_of(), so testing it properly requires the test
struct. As above, the list_for_each() tests do actually check the
order, so it's probably worth adding a check for the count to these
tests, too.

There are definitely a few places where extra comments make sense. In
general, for these tests at least, the purpose of each test is to test
the function/macro it's named after, ideally reasonably thoroughly. My
feeling is that, given that, it's more useful to call out explicitly
if something obvious isn't tested (such as the
list_empty_careful_test(), perhaps, which doesn't verify concurrent
access from multiple threads).

Cheers,
-- David
