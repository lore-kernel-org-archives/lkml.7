Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50A2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1B32184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfHHBIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 21:08:35 -0400
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:59323 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730467AbfHHBIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:08:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D47CE8368EFD;
        Thu,  8 Aug 2019 01:08:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ear68_4a95da1cc8d30
X-Filterd-Recvd-Size: 4032
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 01:08:32 +0000 (UTC)
Message-ID: <f469bc5c8ae2386af57296df0a8a17b7c223a476.camel@perches.com>
Subject: Re: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 07 Aug 2019 18:08:31 -0700
In-Reply-To: <c4157db4-dbda-5ab1-2092-83c4a3b0f19e@roeck-us.net>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-2-rikard.falkeborn@gmail.com>
         <20190807142728.GA16360@roeck-us.net>
         <CAK7LNATGuO0D0a-sTvWw5Pzkn5C7jrLiS=rCwiRsEqaS86KbuQ@mail.gmail.com>
         <099e07d4b4ecca9798404b95dc78c89bc3dd9f7f.camel@perches.com>
         <c4157db4-dbda-5ab1-2092-83c4a3b0f19e@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-07 at 17:58 -0700, Guenter Roeck wrote:
> On 8/7/19 5:07 PM, Joe Perches wrote:
> > On Wed, 2019-08-07 at 23:55 +0900, Masahiro Yamada wrote:
> > > On Wed, Aug 7, 2019 at 11:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > []
> > > > Who is going to fix the fallout ? For example, arm64:defconfig no longer
> > > > compiles with this patch applied.
> > > > 
> > > > It seems to me that the benefit of catching misuses of GENMASK is much
> > > > less than the fallout from no longer compiling kernels, since those
> > > > kernels won't get any test coverage at all anymore.
> > > 
> > > We cannot apply this until we fix all errors.
> > > I do not understand why Andrew picked up this so soon.
> > 
> > I think it makes complete sense to break -next (not mainline)
> > and force people to fix defects.  Especially these types of
> > defects that are trivial to fix.
> > 
> 
> I don't think this (from next-20190807):
> 
> Build results:
> 	total: 158 pass: 137 fail: 21
> Qemu test results:
> 	total: 391 pass: 318 fail: 73
> 
> is very useful. The situation is bad enough for newly introduced problems.
> It is all but impossible to get fixes for all problems discovered (or introduced)
> by adding checks like this one. In some cases, no one will care. In others,
> no one will pick up patches. Sometimes people won't know or realize that
> they are expected to fix something. Making the situation worse, the failures
> introduced by the new checks will hide other accumulating problems.
> 
> arch/sh has failed to build in mainline since 7/27 and in -next since
> next-20190711, due to the added "fallthrough" warning. I don't think
> that is too useful either. Ok, that situation may be a sign that the
> architecture isn't maintained as well as it should, but I don't think
> that this warrants breaking it on purpose in the hope to trigger
> some kind of reaction.
> 
> I don't mind if new checks are introduced, and I agree that it is useful
> and makes sense. But the checks should only be introduced after a reasonable
> attempt was made to fix _all_ associated problems. That doesn't mean that
> the entire work has to be done by the person introducing the check, but I
> do see that person responsible for making sure (or a reasonable definition
> of "make sure") that all problems are fixed before actually introducing
> the check. Yes, I understand, this is a lot of work, but adding checks
> and letting all hell break loose can not be the answer.

No hell is unleashed.

It's -next, an integration build, not mainline.


