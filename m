Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E67C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870F520700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHRWTgXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfCVBaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:30:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45804 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfCVBaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:30:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id y84so516715oia.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 18:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REmnP7uO1lWqIKMZ3k9PsqE5YKJjhnIdgbtOCCe/+B0=;
        b=kHRWTgXmBsMFitYZzmbFQ2X+z51h80qLrtt5oNoZgqGuj391LISAxUMn3S+jc0jzM9
         wiEiwEiSkVTS9ZTu1ggOs4Dw4jMUliz6Eftlsfebr36w7gQOoOKMyxjCUxuBf/KtJmOJ
         81vDMvpSktz6Mwe9c/YUZU72U3OdAj38zBFDnuqC5tWBVl8jXS9mNSR45LjAkyZhN/fG
         heH7Y4m84KDhum9fCBXtN7AWs6zi/7exROiNUKOhvssCwHXHt3LXFPsy7LaRD5q0igXR
         e5820RpaaEk9WyBpc1q3gGKPYtfXek6JnOKCDLPrGbK4S8Y1Lc4hB5p8RRaot2O7NRwj
         bNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REmnP7uO1lWqIKMZ3k9PsqE5YKJjhnIdgbtOCCe/+B0=;
        b=Nk+flEhydNjbcGeoLIu0rwHkGX9rTOvIoeuKG0qR8Ysyk6jgG7w9Wc9mM6dtqgpqLk
         /Nkcd7UVRDMNVLtipZbVZt8x+0Llxe74wpCkleaqhKZcMcsgs78wrn8k1qhjjS3/ciXd
         TPqZVpfCwdTyl/DKPUojvDEUjxH5AzT9gK9PAvyn2//MYv3SjzJblGm16dZB0FJxZxFn
         b3ZqkAh0VvoA8ryqIiU6vkgtixz7Dhb6lKl9/YNB45Sx5bKLr80tjsIqVrZXb1J6VqxW
         ZkCkJwPEl4ypoBLTgwyiU1lX6Oi2EeXnKDJ3BB0IG3X0HbNJqqIuUPOFAz7OEANpLe2I
         FFOw==
X-Gm-Message-State: APjAAAXiTCSFLp0ptaDQgTzYAAE0zzCLum5uPUp6hTAOtFt/u2iwW9KB
        UQAnqi/jt1/4D+gtRvZJCyMAFfy16oWvv/Qam9Oo2Q==
X-Google-Smtp-Source: APXvYqzcofW/27DLhzwIH+krKlrCs1Kc3KMSQg+DAvQTVWZCRl3MGWmYYg8dKjveQMpfP/9p0ZFbngZHtDM+9TzVKxs=
X-Received: by 2002:aca:4a90:: with SMTP id x138mr160795oia.137.1553218250886;
 Thu, 21 Mar 2019 18:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com> <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
 <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
 <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com> <CAFd5g444f-FBq4x3U7BL-EY+bFxP0rsJhJ14=mjOi89PhMkURg@mail.gmail.com>
 <0e311e88-c4d4-e98d-1720-53a04bd526fc@gmail.com> <CAFd5g44NTZoSAJPMvXP2xvJgn7m5QoV-KJu2AMrr67+eL+CKrQ@mail.gmail.com>
 <d9f7e000-4cac-a35a-3ff9-60130e12ebea@gmail.com> <72cd1c5b-6f68-73ad-c8fd-f3a3268a0529@gmail.com>
 <CAFd5g46UU9wk+F6A5wnKYYtYKmmtv__SaY8eg6v-T9xUjsoxhA@mail.gmail.com> <bb5bcd3d-a09a-cfbe-c7fa-16e5eb75b0e4@gmail.com>
In-Reply-To: <bb5bcd3d-a09a-cfbe-c7fa-16e5eb75b0e4@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 21 Mar 2019 18:30:38 -0700
Message-ID: <CAFd5g448xQLOJwVYU5Zmu4+OPWuboiWZPhBvK6au8Pgm5B9haQ@mail.gmail.com>
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
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
        Rob Herring <robh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 5:22 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/27/19 7:52 PM, Brendan Higgins wrote:
> > On Wed, Feb 20, 2019 at 12:45 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 2/18/19 2:25 PM, Frank Rowand wrote:
> >>> On 2/15/19 2:56 AM, Brendan Higgins wrote:
> >>>> On Thu, Feb 14, 2019 at 6:05 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>>
> >>>>> On 2/14/19 4:56 PM, Brendan Higgins wrote:
> >>>>>> On Thu, Feb 14, 2019 at 3:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>>>>
> >>>>>>> On 12/5/18 3:54 PM, Brendan Higgins wrote:
> >>>>>>>> On Tue, Dec 4, 2018 at 2:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
< snip >
> >>
> >> In the base version, the order of execution of the test code requires
> >> bouncing back and forth between the test functions and the coding of
> >> of_test_find_node_by_name_cases[].
> >
> > You shouldn't need to bounce back and forth because the order in which
> > the tests run shouldn't matter.
>
> If one can't guarantee total independence of all of the tests, with no
> side effects, then yes.  But that is not my world.  To make that
> guarantee, I would need to be able to run just a single test in an
> entire test run.
>
> I actually want to make side effects possible.  Whether from other
> tests or from live kernel code that is accessing the live devicetree.
> Any extra stress makes me happier.
>
> I forget the exact term that has been tossed around, but to me the
> devicetree unittests are more like system validation, release tests,
> acceptance tests, and stress tests.  Not unit tests in the philosophy
> of KUnit.

Ah, I understand. I thought that they were actually trying to be unit
tests; that pretty much voids this discussion then. Integration tests
and end to end tests are valuable as long as that is actually what you
are trying to do.

>
> I do see the value of pure unit tests, and there are rare times that
> my devicetree use case might be better served by that approach.  But
> if so, it is very easy for me to add a simple pure test when debugging.
> My general use case does not map onto this model.

Why do you think it is rare that you would actually want unit tests?

I mean, if you don't get much code churn, then maybe it's not going to
provide you a ton of value to immediately go and write a bunch of unit
tests right now, but I can't think of a single time where it's hurt.
Unit tests, from my experience, are usually the easiest tests to
maintain, and the most helpful when I am developing.

Maybe I need to understand your use case better.

>
>
> >>
> >> In the frank version the order of execution of the test code is obvious.
> >
> > So I know we were arguing before over whether order *does* matter in
> > some of the other test cases (none in the example that you or I
> > posted), but wouldn't it be better if the order of execution didn't
> > matter? If you don't allow a user to depend on the execution of test
> > cases, then arguably these test case dependencies would never form and
> > the order wouldn't matter.
>
> Reality intrudes.  Order does matter.
>
>
> >>
> >> It is possible that a test function could be left out of
> >> of_test_find_node_by_name_cases[], in error.  This will result in a compile
> >> warning (I think warning instead of error, but I have not verified that)
> >> so it might be caught or it might be overlooked.
> >>
> >> The base version is 265 lines.  The frank version is 208 lines, 57 lines
> >> less.  Less is better.
> >
> > I agree that less is better, but there are different kinds of less to
> > consider. I prefer less logic in a function to fewer lines overall.
> >
> > It seems we are in agreement that test cases should be small and
> > simple, so I won't dwell on that point any longer. I agree that the
>
> As a general guide for simple unit tests, sure.
>
> For my case, no.  Reality intrudes.
>
> KUnit has a nice architectural view of what a unit test should be.

Cool, I am glad you think so! That actually means a lot to me. I was
afraid I wasn't conveying the idea properly and that was the root of
this debate.

>
> The existing devicetree "unittests" are not such unit tests.  They
> simply share the same name.
>
> The devicetree unittests do not fit into a clean:
>   - initialize
>   - do one test
>   - clean up
> model.
>
> Trying to force them into that model will not work.  The initialize
> is not a simple, easy to decompose thing.  And trying to decompose
> it can actually make the code more complex and messier.
>
> Clean up can NOT occur, because part of my test validation is looking
> at the state of the device tree after the tests complete, viewed
> through the /proc/device-tree/ interface.
>

Again, if they are not actually intended to be unit tests, then I
think that is fine.

< snip >

> > Compare the test cases for adding of_test_dynamic_basic,
> > of_test_dynamic_add_existing_property,
> > of_test_dynamic_modify_existing_property, and
> > of_test_dynamic_modify_non_existent_property to the originals. My
> > version is much longer overall, but I think is still much easier to
> > understand. I can say from when I was trying to split this up in the
> > first place, it was not obvious what properties were expected to be
> > populated as a precondition for a given test case (except the first
> > one of course). Whereas, in my version, it is immediately obvious what
> > the preconditions are for a test case. I think you can apply this same
> > logic to the examples you provided, in frank version, I don't
> > immediately know if one test cases does something that is a
> > precondition for another test case.
>
> Yes, that is a real problem in the current code, but easily fixed
> with comments.

I think it is best when you don't need comments, but in this case, I
think I have to agree with you.

>
>
> > My version also makes it easier to run a test case entirely by itself
> > which is really valuable for debugging purposes. A common thing that
> > happens when you have lots of unit tests is something breaks and lots
> > of tests fail. If the test cases are good, there should be just a
> > couple (ideally one) test cases that directly assert the violated
> > property; those are the test cases you actually want to focus on, the
> > rest are noise for the purposes of that breakage. In my version, it is
> > much easier to turn off the test cases that you don't care about and
> > then focus in on the ones that exercise the violated property.
> >
> > Now I know that, hermeticity especially, but other features as well
> > (test suite summary, error on unused test case function, etc) are not
> > actually in KUnit as it is under consideration here. Maybe it would be
> > best to save these last two patches (18/19, and 19/19) until I have
> > these other features checked in and reconsider them then?
>
> Thanks for leaving 18/19 and 19/19 off in v4.

Sure, no problem. It was pretty clear that it was a waste of both of
our times to continue discussing those at this juncture. :-)

Do you still want me to try to convert the DT not-exactly-unittest to
KUnit? I would kind of prefer (I don't feel *super* strongly about the
matter) we don't call it that since I was intending for it to be the
flagship initial example, but I certainly don't mind trying to clean
this patch up to get it up to snuff. It's really just a question of
whether it is worth it to you.

< snip >

Cheers!
