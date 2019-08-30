Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37CAC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B282341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfH3PCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbfH3PCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:02:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6006C065123;
        Fri, 30 Aug 2019 15:02:11 +0000 (UTC)
Received: from treble (ovpn-125-111.rdu2.redhat.com [10.10.125.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7E015D721;
        Fri, 30 Aug 2019 15:02:10 +0000 (UTC)
Date:   Fri, 30 Aug 2019 10:02:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
Message-ID: <20190830150208.jyk7tfzznqimc6ow@treble>
References: <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble>
 <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble>
 <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
 <CAK8P3a1K5HgfACmJXr4dTTwDJFz5BeSCCa3RQWYbXGE-2q4TJQ@mail.gmail.com>
 <CAHk-=whuUdqrh2=LLNfRiW6oadx0zzGVkvqyx_O1cGLa2U6Jjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whuUdqrh2=LLNfRiW6oadx0zzGVkvqyx_O1cGLa2U6Jjg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 30 Aug 2019 15:02:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 03:26:30PM -0700, Linus Torvalds wrote:
> On Thu, Aug 29, 2019 at 1:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Maybe we can just pass -fno-builtin-memcpy -fno-builtin-memset
> > for clang when CONFIG_KASAN is set and hope for the best?
> 
> I really hate how that disables conversions both ways, which is kind
> of pointless and wrong.  It's really just "we don't want surprising
> memcpy calls for single writes".
> 
> Disabling all the *good* "optimize memset/memcpy" cases is really sad.
> 
> We actually have a lot of small structures in the kernel on purpose
> (often for type safety), and I bet we use memcpy on them on purpose at
> times. I'd hate to see that become a function call rather than "copy
> two words by hand".
> 
> Even for KASAN.
> 
> And I guess that when the compiler sees 20+ "set to zero" it's quite
> reasonable to say "just turn it into a memset".

For KASAN, the Clang threshold for inserting memset() is *2* consecutive
writes instead of 17.  Isn't that likely to cause tearing-related
surprises?

I suppose people don't run KASAN in production, but we don't want
tearing-related bugs showing up there because somebody's going to end up
having to debug them regardless.

-- 
Josh
