Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E81C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBFB207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391681AbfIFQji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:39:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387986AbfIFQjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:39:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77CE03086272;
        Fri,  6 Sep 2019 16:39:37 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-116-139.ams2.redhat.com [10.36.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C95995D9D3;
        Fri,  6 Sep 2019 16:39:36 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id x86GdN6r015074;
        Fri, 6 Sep 2019 18:39:29 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id x86GdI8l015073;
        Fri, 6 Sep 2019 18:39:18 +0200
Date:   Fri, 6 Sep 2019 18:39:18 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
Message-ID: <20190906163918.GJ2120@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-5-linux@rasmusvillemoes.dk>
 <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
 <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk>
 <20190905134535.GP9749@gate.crashing.org>
 <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
 <20190906122349.GZ9749@gate.crashing.org>
 <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
 <20190906163028.GC9749@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906163028.GC9749@gate.crashing.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 06 Sep 2019 16:39:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:30:28AM -0500, Segher Boessenkool wrote:
> On Fri, Sep 06, 2019 at 05:13:54PM +0200, Miguel Ojeda wrote:
> > On Fri, Sep 6, 2019 at 2:23 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > > I can't find anything with "feature" and "macros" in the C++ standard,
> > > it's "predefined macros" there I guess?  In C, it is also "predefined
> > > macros" in general, and there is "conditional feature macros".
> > 
> > They are introduced in C++20,
> 
> (Which isn't the C++ standard yet, okay).

Well, they have been required by SD-6 before being added to C++20, so we
have tons of the predefined macros for C++ already starting with gcc 4.9 or
so, but it is something required by the standard so we have to do that.
Most of them depend also on compiler options, so can't be easily replaced
with a simple __GNUC__ version check.

What I'd like to add is that each predefined macro isn't without cost,
while adding one predefined macro might not be measurable (though, for
some predefined macros (the floating point values) it was very measurable
and we had to resort to lazy evaluation of the macros), adding hundreds of
predefined macros is measurable, affects the speed of empty compiler run,
adds size of -g3 produced debug info, increases size of -E -dD output etc.

	Jakub
