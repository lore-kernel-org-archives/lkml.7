Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B821CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B3820578
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4AEvy78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfJ3IC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:02:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45862 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJ3ICZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:02:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so1119868wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 01:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFuJPc5S4w6ovnv3XD7zumM0Z02AhKOD3XZ/KSqoJSQ=;
        b=e4AEvy78bbzzC0tOCC67QosRlTFnzrYq5wBUOHpUIm8pvaMfkc6mo0oAfUQxMoZk/4
         pjetjE3MA+cd5veGzPYwMEUNlch3HXkACK+0SfzOIGF6eoN63WV/PxCzBXvtGnIF5G/m
         JJbyzUDDrmuTVWbGJJ+PawQ9hkPYfNQgO/MiCfZXIimEEVDugUteipGcYClK2uChT66M
         b7oKINR2w4FK2dDIVADC4lErzxIHmHJutAtkPM8Nb9IfiJDwsLApCy3BMOdYEbYi082X
         TTyb3wjQIS9+td27oqcBR/zsMs9YIZXWtryGPjEj6CGMLUDLi5ZNN/DR1saJdGd9y4TH
         PE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFuJPc5S4w6ovnv3XD7zumM0Z02AhKOD3XZ/KSqoJSQ=;
        b=Z5FHkrpmE6u5RZFWzXq7PHmPpN7JJXhI9tNP80CElL5sBD7avHRAZ5J72L00/12Y4e
         W3yO8Q/ZYv+NzCx4Wo3F0QPrNsKGGHY/6onYXsIWZ/6DAuqzdsqBD5YuT6MedRVmF9bi
         KaAKCayvIqC3j0bhtEorWOgSjihBbyYpX/+hIzaLzTPMtCDfE3i7Xe6HwU3xWQag+MPt
         wYEosE8vYo6N0Bvglq/NIt6xqnqZ7wNmureg9IlS+G4DECfqXMzqagDVhWKtKEIZoFH5
         K3qr/4fFge5SN18QoJkA8cUl2B7RxPChN7Vl09srmp8HaeiJqhSl1e3Naz3xVl5qW1wA
         AcYA==
X-Gm-Message-State: APjAAAXVxzTUj3Dl9wgtY0OgiWRc5ObzG01t+4Zz/HH6zEzspCjbxHHS
        PpzrHGQdMUHD/uc7EVr6UuqmIPBPkrbmNNbbu5SGSw==
X-Google-Smtp-Source: APXvYqzvSeH7Fh5EsiF9aZeIV5bm0wBI5AiG6/W8jAsIC+W1bULhWDinOPl6Rm4QcAA5V17ELWvZcfMSeFn/g+pZ4RU=
X-Received: by 2002:adf:eb8d:: with SMTP id t13mr8408157wrn.321.1572422543342;
 Wed, 30 Oct 2019 01:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191024224631.118656-1-davidgow@google.com> <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
In-Reply-To: <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 30 Oct 2019 01:02:11 -0700
Message-ID: <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for the
 'list' doubly linked list
To:     shuah <shuah@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 6:00 AM shuah <shuah@kernel.org> wrote:
> On 10/24/19 4:46 PM, David Gow wrote:
> > Add a KUnit test for the kernel doubly linked list implementation in
> > include/linux/list.h
> >
> > Each test case (list_test_x) is focused on testing the behaviour of the
> > list function/macro 'x'. None of the tests pass invalid lists to these
> > macros, and so should behave identically with DEBUG_LIST enabled and
> > disabled.
> >
> > Note that, at present, it only tests the list_ types (not the
> > singly-linked hlist_), and does not yet test all of the
> > list_for_each_entry* macros (and some related things like
> > list_prepare_entry).
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >
> > This revision addresses Brendan's comments in
> > https://lore.kernel.org/linux-kselftest/20191023220248.GA55483@google.com/
> >
> > Specifically:
> > - Brendan's Reviewed-by/Tested-by being included in the description.
> > - A couple of trailing tabs in Kconfig.debug & list-test.c
> > - Reformatting of previously >80 character lines.
> >
> >
> > Earlier versions of this patchset can be found:
> >
> > v5:
> > https://lore.kernel.org/linux-kselftest/20191022221322.122788-1-davidgow@google.com/
> > v4:
> > https://lore.kernel.org/linux-kselftest/20191018215549.65000-1-davidgow@google.com/
> > v3:
> > https://lore.kernel.org/linux-kselftest/20191016215707.95317-1-davidgow@google.com/
> > v2:
> > https://lore.kernel.org/linux-kselftest/20191010185631.26541-1-davidgow@google.com/
> > v1:
> > https://lore.kernel.org/linux-kselftest/20191007213633.92565-1-davidgow@google.com/
> >
>
> CHECK: Unnecessary parentheses around test_struct.list
> #699: FILE: lib/list-test.c:510:
> +       KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list),
>
> CHECK: Alignment should match open parenthesis
> #700: FILE: lib/list-test.c:511:
> +       KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list),
> +                               struct list_test_struct, list));
>
> CHECK: Please don't use multiple blank lines
> #711: FILE: lib/list-test.c:522:
> +
> +
>
> CHECK: Alignment should match open parenthesis
> #713: FILE: lib/list-test.c:524:
> +       KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry(&list,
> +                               struct list_test_struct, list));
>
> CHECK: Please don't use multiple blank lines
> #724: FILE: lib/list-test.c:535:
> +
> +
>
> CHECK: Alignment should match open parenthesis
> #726: FILE: lib/list-test.c:537:
> +       KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_last_entry(&list,
> +                               struct list_test_struct, list));
>
> CHECK: Alignment should match open parenthesis
> #735: FILE: lib/list-test.c:546:
> +       KUNIT_EXPECT_FALSE(test, list_first_entry_or_null(&list,
> +                               struct list_test_struct, list));
>
> CHECK: Alignment should match open parenthesis
> #741: FILE: lib/list-test.c:552:
> +       KUNIT_EXPECT_PTR_EQ(test, &test_struct1,
> +                       list_first_entry_or_null(&list,
>
> CHECK: Alignment should match open parenthesis
> #742: FILE: lib/list-test.c:553:
> +                       list_first_entry_or_null(&list,
> +                               struct list_test_struct, list));
>
> CHECK: Please don't use multiple blank lines
> #753: FILE: lib/list-test.c:564:
> +
> +
>
> CHECK: Alignment should match open parenthesis
> #755: FILE: lib/list-test.c:566:
> +       KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_next_entry(&test_struct1,
> +                               list));
>
> CHECK: Please don't use multiple blank lines
> #766: FILE: lib/list-test.c:577:
> +
> +
>
> CHECK: Alignment should match open parenthesis
> #768: FILE: lib/list-test.c:579:
> +       KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_prev_entry(&test_struct2,
> +                               list));
>
> ERROR: that open brace { should be on the previous line
> #789: FILE: lib/list-test.c:600:
> +static void list_test_list_for_each_prev(struct kunit *test)
> +{
>
> ERROR: that open brace { should be on the previous line
> #807: FILE: lib/list-test.c:618:
> +static void list_test_list_for_each_safe(struct kunit *test)
> +{
>
> CHECK: Please don't use multiple blank lines
> #813: FILE: lib/list-test.c:624:
> +
> +
>
> ERROR: that open brace { should be on the previous line
> #828: FILE: lib/list-test.c:639:
> +static void list_test_list_for_each_prev_safe(struct kunit *test)
> +{
>
> ERROR: that open brace { should be on the previous line
> #848: FILE: lib/list-test.c:659:
> +static void list_test_list_for_each_entry(struct kunit *test)
> +{
>
> ERROR: that open brace { should be on the previous line
> #869: FILE: lib/list-test.c:680:
> +static void list_test_list_for_each_entry_reverse(struct kunit *test)
> +{
>
>
> I am seeing these error and warns. As per our hallway conversation, the
> "for_each*" in the test naming is tripping up checkpatch.pl
>
> For now you can change the name a bit to not trip checkpatch and maybe
> explore fixing checkpatch to differentiate between function names
> with "for_each" in them vs. the actual for_each usages in the code.

Thanks, Shuah.

Yes, the problem here is that checkpatch.pl believes that anything
with "for_each" in its name must be a loop, so expects that the open
brace is placed on the same line as for a for loop.

Longer term, I think it'd be nicer, naming-wise, to fix or work around
this issue in checkpatch.pl itself, as that'd allow the tests to
continue to follow a naming pattern of "list_test_[x]", where [x] is
the name of the function/macro being tested. Of course, short of
trying to fit a whole C parser in checkpatch.pl, that's going to
involve some compromises as well.

In the meantime, I'm sending out v7 which replaces "for_each" with
"for__each" (adding the extra underscore), so that checkpatch is
happy.

Cheers,
-- David
