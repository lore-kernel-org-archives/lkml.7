Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BBFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9918206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3ExTykj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfCYWcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:32:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39583 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfCYWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:32:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id n187so5552166oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGWDtMK/dsTPDyC5sqpAIR0H6yQciJJiOWrefhHIEOU=;
        b=O3ExTykjQtCF9m/m8ZnZTZNyjSw/6FynnzGdt9KSg2tyAB1bp7g7i94Hjg7dzHmBnO
         89dEjfQXr/3ayvSDgZ38Q25L+tq3w6lY7HkMpHoGiwXYvHHOFccgrgSIWUVQ/zEk3juU
         +hRaI2RsGqCWoPqWzIMQKHygzhBZfKmXNM4UCDXU2cDpob4LXVswYs++ZcSl/QrRru4M
         1y7Dn4uZ5ptPLPgpvw+U6Gw2lhyWtUkMe9c/YXkiyJginA0hNGaz27Na4yKtPC7Yxy0l
         9Nia7RU03h+L28U4xJkOSw4JIBLZh1/Z9VAmH3TpnTTCCLih6w4bnwbY5o1mYuvMyoek
         qrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGWDtMK/dsTPDyC5sqpAIR0H6yQciJJiOWrefhHIEOU=;
        b=aoe3vvr1TOeWvKxN6MW+hZuQlbquAGRZePXPA7HT0sLvnTdaKkwDDzhZRpwWJDwgBL
         gHa3IZtmPcby7Y33CGTMu+V5ZxjE8Ff68aCie158wg6SCvaZRufJmXhWq2smGhQZh0VE
         v2vAqM12LSxcTR7mPumf2OW7dfbo7ldRq2NJVCeArPi0OGJuh1hvrMoL/7DOH+rAiKLy
         foe7kTYX/eiu1GQxJx0/A1ai6UGGL9IWZZl+B7ZpqUPgaph3B5CCU8GupPrOK1CgWssm
         Knnip9dPpOOwqVpiqwILU6jNDVxgt4X4OUBSP3qSw+WRntwuZ86EIxBoD9HhniIwFAHW
         RWAw==
X-Gm-Message-State: APjAAAUiAwzFKHJojHZuHKvW6/9+nRA/K1WUGK+KBxA1xo4E6cdhNMSQ
        UKLJPDkaeRSOMeteLDUcOA5LCvR9+Y3fD1h4UJkqsQ==
X-Google-Smtp-Source: APXvYqwtnSaCVLFKPNtkz+oD0ZL8JVRFbrZvVPYa4qE+KIj/DmpPDM/1H99NZB58DkyjPA7bQ6BSJppoSWdpz46bmSc=
X-Received: by 2002:aca:f594:: with SMTP id t142mr14148424oih.100.1553553138946;
 Mon, 25 Mar 2019 15:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com> <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
 <CAFd5g467OV8wTB7zEshgZw8g8=zoq0dLVfwx3wDH-8UA+9GWFA@mail.gmail.com>
 <0124ed28-466c-e954-ddde-495419630a9f@gmail.com> <CAFd5g47EDmsBWKNiW0jpHW2VG_GWCfe8UO+=ofgM2_ru+_UBQA@mail.gmail.com>
 <118d89b7-d468-6d68-a48d-4d6d9cefd106@gmail.com> <CAFd5g46AP9yZQ+z+60HGaZuqhJQmfSBw9+r62w4k=cGiMEkqLA@mail.gmail.com>
 <e29d487f5ca0a5caf4723bc5d96b8a523a53a318.camel@oracle.com>
In-Reply-To: <e29d487f5ca0a5caf4723bc5d96b8a523a53a318.camel@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 25 Mar 2019 15:32:07 -0700
Message-ID: <CAFd5g44eqjN-nVCJuoeYFCxwVa5AorWiAnXe-tFCAc11zDgJFA@mail.gmail.com>
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
To:     Knut Omang <knut.omang@oracle.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
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

On Fri, Mar 22, 2019 at 12:11 AM Knut Omang <knut.omang@oracle.com> wrote:
>
> On Thu, 2019-03-21 at 18:41 -0700, Brendan Higgins wrote:
> > On Thu, Mar 21, 2019 at 6:10 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > > On 2/27/19 11:42 PM, Brendan Higgins wrote:
> > > > On Tue, Feb 19, 2019 at 10:44 PM Frank Rowand <frowand.list@gmail.com>
> > > > wrote:
> > > > > On 2/19/19 7:39 PM, Brendan Higgins wrote:
> > > > > > On Mon, Feb 18, 2019 at 11:52 AM Frank Rowand <frowand.list@gmail.com>
> > > > > > wrote:
> > > > > > > On 2/14/19 1:37 PM, Brendan Higgins wrote:
< snip >
> > > > > > > kunit_abort() is what will be call as the result of an assert
> > > > > > > failure.
> > > > > >
> > > > > > Yep. Does that need clarified somewhere.
> > > > > > > BUG(), which is a panic, which is crashing the system is not
> > > > > > > acceptable
> > > > > > > in the Linux kernel.  You will just annoy Linus if you submit this.
> > > > > >
> > > > > > Sorry, I thought this was an acceptable use case since, a) this should
> > > > > > never be compiled in a production kernel, b) we are in a pretty bad,
> > > > > > unpredictable state if we get here and keep going. I think you might
> > > > > > have said elsewhere that you think "a" is not valid? In any case, I
> > > > > > can replace this with a WARN, would that be acceptable?
> > > > >
> > > > > A WARN may or may not make sense, depending on the context.  It may
> > > > > be sufficient to simply report a test failure (as in the old version
> > > > > of case (2) below.
> > > > >
> > > > > Answers to "a)" and "b)":
> > > > >
> > > > > a) it might be in a production kernel
> > > >
> > > > Sorry for a possibly stupid question, how might it be so? Why would
> > > > someone intentionally build unit tests into a production kernel?
> > >
> > > People do things.  Just expect it.
> >
> > Huh, alright. I will take your word for it then.
>
> I have a better explanation: Production kernels have bugs, unfortunately.
> And sometimes those need to be investigated on systems than cannot be
> brought down or affected more than absolutely necessary, maybe via a third party
> doing the execution. A light weight, precise test (well tested ahead :) ) might
> be a way of proving or disproving assumptions that can lead to the development
> and application of a fix.

Sorry, you are not suggesting testing in production are you? To be
clear, I am not concerned about someone using testing, KUnit, or
whatever in a *production-like* environment: that's not what we are
talking about here. My assumption is that no one will deploy tests
into actual production.

>
> IMHO you're confusing "building into" with temporary applying, then removing
> again - like the difference between running a local user space program vs
> installing it under /usr and have it in everyone's PATH.

I don't really see the point of distinguishing between "building into"
and "temporary applying" in this case; that's part of my point. Maybe
it makes sense in whitebox end-to-end testing, but in the case of unit
testing, I don't think so.

>
> > > > > a') it is not acceptable in my development kernel either
>
> I think one of the fundamental properties of a good test framework is that it
> should not require changes to the code under test by itself.
>

Sure, but that has nothing to do with the environment the code/tests
are running in.

< snip >

Cheers
