Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0451C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3F220657
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHeTmBH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfCYWEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:04:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36816 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbfCYWEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:04:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id o74so9597797ota.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEWPRD5Aa5d9Ny7EzwCXE1Cjcq7X2kWdASCbzdkOZZc=;
        b=hHeTmBH4OSzIv3iWl8xRBWuSB+Ynn5hsNiWVDy35qNfohB0WsCbGEkuF4wUOUXANDe
         6lg8+Gnku9TYjQOFkkYUBRHaIBWnE6wq9RN/KkQB8PHx+ZtsS/ZMTqE0ndvOI1Pia28r
         ZSFG1K7Bub+jv+yfEfgYwYx5lTd5unFHEJQkE7o/kDDQ2gcRVVQ3Mq8IXIbHoFOy3Cap
         B8rPOE4PClLtpR8G3ToGE1rDyaV6syJWvqtMVpr6iqu9zLNfNpdUtrqeU3muHj6ZgBEK
         kF8ZAzB4rcUttOTDmGzgF0r5lRBK8yB4GsN89Xi/1IzFflobLmlPG94lMlEi5R25uzDE
         lpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEWPRD5Aa5d9Ny7EzwCXE1Cjcq7X2kWdASCbzdkOZZc=;
        b=P5Ljo0AU+syciw8+vbT0lWv8bhg3FdDpXsiQO5mq6FoJcmONuz+x50lm1fN8QcqKS2
         75+20YDFVndN+/BMu2eznri55lQGALbE6qPtk+VE1PURPJUNu5WGwVeEEzmeDEEDwAEP
         qO3tatakFfCiQs74qlF/vB3DmJ3PP9noGDje3xoLjglaHQcNSjvTiAZVATrn7u87HMDC
         z54hTpUaxv8KaPu3pv8H8EXupMEqpGXFWw7Q5/wNjjULTxfg7OzmB84zd+y2pl1llR2P
         yRgz9Nz16qC2rJFaXCMh0nzDDabqGMO4LRGpxlaw32WDdKqQZ6FtHsqk+W9Af2+wit7l
         Y0Kw==
X-Gm-Message-State: APjAAAVXvWfTrkf85FRN/7cMRjtGhWHa+6ogAF+RNNFjtz3pPQ34r05e
        /rnWAKKsjRJRoijGddXYCdTodtXF9ONhWA/jt1E6OA==
X-Google-Smtp-Source: APXvYqzPuMy3J6kPGp6abOjazkvg/EVIuyC5MUw5KGkbgfPxvkRJlJjyuecnhhpdpCl+GLJPqp4XyeTBAR3xpv94NZM=
X-Received: by 2002:a9d:6b97:: with SMTP id b23mr288915otq.113.1553551459629;
 Mon, 25 Mar 2019 15:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <f34ee937-83d6-3ff6-12b3-c6cd9acbfc38@gmail.com> <CAL_JsqL0t_p8=Ueq4mHS5i2YEQdc7S7AtPWfkcOsj1g2SixUkA@mail.gmail.com>
 <CAFd5g47cDKSdXGAL8pbDxEU2O8A-9Ajq1wCM+PtPF40T4wYKow@mail.gmail.com> <ec4c1020-4b53-e0f2-4a9d-3fc73af56746@gmail.com>
In-Reply-To: <ec4c1020-4b53-e0f2-4a9d-3fc73af56746@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 25 Mar 2019 15:04:08 -0700
Message-ID: <CAFd5g46u8cQMVbcDv06HGL7mL=j35ziMxnqPXhrwYS5CD1ZeZA@mail.gmail.com>
Subject: Re: [RFC v3 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 5:28 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 12/5/18 3:10 PM, Brendan Higgins wrote:
> > On Tue, Dec 4, 2018 at 5:49 AM Rob Herring <robh@kernel.org> wrote:
> >>
> >> On Tue, Dec 4, 2018 at 5:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>
> >>> Hi Brendan, Rob,
> >>>
> >>> Pulling a comment from way back in the v1 patch thread:
> >>>
> >>> On 10/17/18 3:22 PM, Brendan Higgins wrote:
> >>>> On Wed, Oct 17, 2018 at 10:49 AM <Tim.Bird@sony.com> wrote:
> >>>
> >>> < snip >
> >>>
> >>>> The test and the code under test are linked together in the same
> >>>> binary and are compiled under Kbuild. Right now I am linking
> >>>> everything into a UML kernel, but I would ultimately like to make
> >>>> tests compile into completely independent test binaries. So each test
> >>>> file would get compiled into its own test binary and would link
> >>>> against only the code needed to run the test, but we are a bit of a
> >>>> ways off from that.
> >>>
> >>> I have never used UML, so you should expect naive questions from me,
> >>> exhibiting my lack of understanding.
> >>>
> >>> Does this mean that I have to build a UML architecture kernel to run
> >>> the KUnit tests?
> >>
> >> In this version of the patch series, yes.
> >>
> >>> *** Rob, if the answer is yes, then it seems like for my workflow,
> >>> which is to build for real ARM hardware, my work is doubled (or
> >>> worse), because for every patch/commit that I apply, I not only have
> >>> to build the ARM kernel and boot on the real hardware to test, I also
> >>> have to build the UML kernel and boot in UML.  If that is correct
> >>> then I see this as a major problem for me.
> >>
> >> I've already raised this issue elsewhere in the series. Restricting
> >> the DT tests to UML is a non-starter.
> >
>
> > I have already stated my position elsewhere on the matter, but in
> > summary: Ensuring most tests can run without external dependencies
> > (hardware, VM, etc) has a lot of benefits and should be supported in
> > nearly all cases, but such tests should also work when compiled to run
> > on real hardware/VM; the tooling might not be as good in the latter
> > case, but I understand that there are good reasons to support it
> > nonetheless.
>
> And my needs are the exact opposite.  My tests must run on real hardware,
> in the context of the real operating system subsystems and drivers
> potentially causing issues.

Right, Rob pointed this out, and I fixed this in v4. To be clear, as
of RFC v4 you can run KUnit tests on non-UML architectures, we tested
it on x86 and ARM.

>
> It is useful if the tests can also run without that dependency.

This, of course, is still the main intended use case, but there is
nothing to stop you from using it on real hardware.
