Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C197CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AEB2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORrmTwJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfB1A3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:29:17 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35378 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfB1A3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:29:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id u128so15110502oie.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 16:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aA1okxN3VYgeeIBcSGMu8jaBIK0XtHcLi6+3USeFW+A=;
        b=ORrmTwJvTMgsR8FYdU1wEZ3l8+Wveyndp4sN/o/MaFCQjZnfhvcTkm/4Ovc7izoOJP
         gMwAbb3UxekOkTekdxI5NUaZnNA4Rq1wqVLxGwLfIPOqMdUYYng6XjdtZsJXRiFLvetI
         YjC+76SPdiLz+WW1Q+UhMw2nnqhdKgH6GSialuXtLAIfu1ojl4pMDPNhzSNtzU/qLCtm
         W/GTRsSJKtNLXCRvmjh+EhfDbPLkT8L4x/8DEm4HKlv04LHd1yL8u6+EK++B+8lVzoLo
         IcgcQ0nuIhh9iMxOqTC7dHYyBywcEhWRc650HAsVSOXulyPegqEx5+4DWotdtjpP4/+R
         vAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aA1okxN3VYgeeIBcSGMu8jaBIK0XtHcLi6+3USeFW+A=;
        b=IRQqJGxF0xLKGjGtSvC8reuWWE/Gfmw4H0eMszUs+erTBYJM97/2WrJ3/tL60Rn1Mc
         WIu7X1hLHe/bp+raJB5b5CKVZFxYU58lgo0zxWoPMadRCS8ORuLvtGsUe7Exmgce606S
         SQtyY65x5R+d8R3KMg4skwMD27ik3AfMzLFYFNypLcTj3qnEaFOfM4V1sP5Us/0DSh2x
         TMMU8XgD/nXlyaI/fo75kROXvCbGhKzjDSeowBi125HslWLE2SVA138esM8L41OQNefs
         rkesax7/9GECf+MIUJSHmDZt8JDOKaCKFVKUJcE+p93S1/p64qDuSs4W0EtsdAP/c9/5
         C5Mg==
X-Gm-Message-State: APjAAAWKkow48R2T9RpJe587OJ/BjEQdIIn7RzE27vK6PTWtGIZ849tE
        llwZb7GnTbYUatqXFt4bmbf7wDrS4a6jEHwBJiIAxw==
X-Google-Smtp-Source: AHgI3IYRAqoHrQDFS7w8zHS6g8e+FoihRMVgcEFw+Kd4imISrcRCGvr1GHy19lC0FGWoV9IAuwyqMpBbzs8jF+nu7iE=
X-Received: by 2002:aca:4e50:: with SMTP id c77mr1386753oib.100.1551313755043;
 Wed, 27 Feb 2019 16:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com> <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
 <CAFd5g46NehKo=TT4reQ8r74bDTG9BkR=ELg+Q3n5YooUxFwBmA@mail.gmail.com> <1d72f04e-08ba-e3dd-c8c0-512946126113@gmail.com>
In-Reply-To: <1d72f04e-08ba-e3dd-c8c0-512946126113@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 27 Feb 2019 16:29:04 -0800
Message-ID: <CAFd5g45GjG871ynfMADN+4zmecfARCk2ribY7MsMSc4=QkNqgQ@mail.gmail.com>
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 2:56 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/12/19 5:44 PM, Brendan Higgins wrote:
> > On Wed, Nov 28, 2018 at 12:56 PM Rob Herring <robh@kernel.org> wrote:
> >>
> >> On Wed, Nov 28, 2018 at 1:38 PM Brendan Higgins
> >> <brendanhiggins@google.com> wrote:
<snip>
> >>> ---
> >>>  drivers/of/Kconfig    |    1 +
> >>>  drivers/of/unittest.c | 1405 ++++++++++++++++++++++-------------------
> >>>  2 files changed, 752 insertions(+), 654 deletions(-)
> >>>
> > <snip>
> >>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> >>> index 41b49716ac75f..a5ef44730ffdb 100644
> >>> --- a/drivers/of/unittest.c
> >>> +++ b/drivers/of/unittest.c
<snip>
> >>> +
> >>> +       KUNIT_EXPECT_EQ(test,
> >>> +                       of_property_match_string(np,
> >>> +                                                "phandle-list-names",
> >>> +                                                "first"),
> >>> +                       0);
> >>> +       KUNIT_EXPECT_EQ(test,
> >>> +                       of_property_match_string(np,
> >>> +                                                "phandle-list-names",
> >>> +                                                "second"),
> >>> +                       1);
> >>
> >> Fewer lines on these would be better even if we go over 80 chars.
>
> Agreed.  unittest.c already is a greater than 80 char file in general, and
> is a file that benefits from that.
>

Noted.

>
> > On the of_property_match_string(...), I have no opinion. I will do
> > whatever you like best.
> >
> > Nevertheless, as far as the KUNIT_EXPECT_*(...), I do have an opinion: I am
> > trying to establish a good, readable convention. Given an expect statement
> > structured as
> > ```
> > KUNIT_EXPECT_*(
> >     test,
> >     expect_arg_0, ..., expect_arg_n,
> >     fmt_str, fmt_arg_0, ..., fmt_arg_n)
> > ```
> > where `test` is the `struct kunit` context argument, `expect_arg_{0, ..., n}`
> > are the arguments the expectations is being made about (so in the above example,
> > `of_property_match_string(...)` and `1`), and `fmt_*` is the optional format
> > string that comes at the end of some expectations.
> >
> > The pattern I had been trying to promote is the following:
> >
> > 1) If everything fits on 1 line, do that.
> > 2) If you must make a line split, prefer to keep `test` on its own line,
> > `expect_arg_{0, ..., n}` should be kept together, if possible, and the format
> > string should follow the conventions already most commonly used with format
> > strings.
> > 3) If you must split up `expect_arg_{0, ..., n}` each argument should get its
> > own line and should not share a line with either `test` or any `fmt_*`.
> >
> > The reason I care about this so much is because expectations should be
> > extremely easy to read; they are the most important part of a unit
> > test because they tell you what the test is verifying. I am not
> > married to the formatting I proposed above, but I want something that
> > will be extremely easy to identify the arguments that the expectation
> > is on. Maybe that means that I need to add some syntactic fluff to
> > make it clearer, I don't know, but this is definitely something we
> > need to get right, especially in the earliest examples.
>
> I will probably raise the ire of the kernel formatting rule makers by offering
> what I think is a _much_ more readable format __for this specific case__.
> In other words for drivers/of/unittest.c.
>
> If you can not make your mail window _very_ wide, or if this email has been
> line wrapped, this example will not be clear.
>
> Two possible formats:
>
>
> ### -----  version 1, as created by the patch series
>
> static void of_unittest_property_string(struct kunit *test)
> {
>         const char *strings[4];
>         struct device_node *np;
>         int rc;
>
>         np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
>
>         KUNIT_EXPECT_EQ(
>                 test,
>                 of_property_match_string(np, "phandle-list-names", "first"),
>                 0);
>         KUNIT_EXPECT_EQ(
>                 test,
>                 of_property_match_string(np, "phandle-list-names", "second"),
>                 1);
>         KUNIT_EXPECT_EQ(
>                 test,
>                 of_property_match_string(np, "phandle-list-names", "third"),
>                 2);
>         KUNIT_EXPECT_EQ_MSG(
>                 test,
>                 of_property_match_string(np, "phandle-list-names", "fourth"),
>                 -ENODATA,
>                 "unmatched string");
>         KUNIT_EXPECT_EQ_MSG(
>                 test,
>                 of_property_match_string(np, "missing-property", "blah"),
>                 -EINVAL,
>                 "missing property");
>         KUNIT_EXPECT_EQ_MSG(
>                 test,
>                 of_property_match_string(np, "empty-property", "blah"),
>                 -ENODATA,
>                 "empty property");
>         KUNIT_EXPECT_EQ_MSG(
>                 test,
>                 of_property_match_string(np, "unterminated-string", "blah"),
>                 -EILSEQ,
>                 "unterminated string");
>
>         /* of_property_count_strings() tests */
>         KUNIT_EXPECT_EQ(test,
>                         of_property_count_strings(np, "string-property"), 1);
>         KUNIT_EXPECT_EQ(test,
>                         of_property_count_strings(np, "phandle-list-names"), 3);
>         KUNIT_EXPECT_EQ_MSG(
>                 test,
>                 of_property_count_strings(np, "unterminated-string"), -EILSEQ,
>                 "unterminated string");
>         KUNIT_EXPECT_EQ_MSG(
>                 test,
>                 of_property_count_strings(np, "unterminated-string-list"),
>                 -EILSEQ,
>                 "unterminated string array");
>
>
>
>
> ### -----  version 2, modified to use really long lines
>
> static void of_unittest_property_string(struct kunit *test)
> {
>         const char *strings[4];
>         struct device_node *np;
>         int rc;
>
>         np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
>
>         KUNIT_EXPECT_EQ(    test, of_property_match_string(np, "phandle-list-names", "first"),  0);
>         KUNIT_EXPECT_EQ(    test, of_property_match_string(np, "phandle-list-names", "second"), 1);
>         KUNIT_EXPECT_EQ(    test, of_property_match_string(np, "phandle-list-names", "third"),  2);
>         KUNIT_EXPECT_EQ_MSG(test, of_property_match_string(np, "phandle-list-names", "fourth"), -ENODATA, "unmatched string");
>         KUNIT_EXPECT_EQ_MSG(test, of_property_match_string(np, "missing-property", "blah"),     -EINVAL, "missing property");
>         KUNIT_EXPECT_EQ_MSG(test, of_property_match_string(np, "empty-property", "blah"),       -ENODATA, "empty property");
>         KUNIT_EXPECT_EQ_MSG(test, of_property_match_string(np, "unterminated-string", "blah"),  -EILSEQ, "unterminated string");
>
>         /* of_property_count_strings() tests */
>         KUNIT_EXPECT_EQ(    test, of_property_count_strings(np, "string-property"),             1);
>         KUNIT_EXPECT_EQ(    test, of_property_count_strings(np, "phandle-list-names"),          3);
>         KUNIT_EXPECT_EQ_MSG(test, of_property_count_strings(np, "unterminated-string"),         -EILSEQ, "unterminated string");
>         KUNIT_EXPECT_EQ_MSG(test, of_property_count_strings(np, "unterminated-string-list"),    -EILSEQ, "unterminated string array");
>
>
>         ------------------------  ------------------------------------------------------------- --------------------------------------
>              ^                         ^                                                             ^
>              |                         |                                                             |
>              |                         |                                                             |
>             mostly boilerplate        what is being tested                                          expected result, error message
>             (can vary in relop
>              and _MSG or not)
>
> In my opinion, the second version is much more readable.  It is easy to see the
> differences in the boilerplate.  It is easy to see what is being tested, and how
> the arguments of the tested function vary for each test.  It is easy to see the
> expected result and error message.  The entire block fits into a single short
> window (though much wider).

I have no opinion on the over 80 char thing, so as long as everyone
else is okay with it, I have no complaints.

Cheers
