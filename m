Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45ACC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FEC20820
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfH3Qta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfH3Qta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:49:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3346B2A09CC;
        Fri, 30 Aug 2019 16:49:30 +0000 (UTC)
Received: from treble (ovpn-123-26.rdu2.redhat.com [10.10.123.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DD6360605;
        Fri, 30 Aug 2019 16:49:29 +0000 (UTC)
Date:   Fri, 30 Aug 2019 11:49:27 -0500
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
Message-ID: <20190830164927.a2czlphx4ho3rhhf@treble>
References: <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble>
 <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble>
 <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
 <CAK8P3a1K5HgfACmJXr4dTTwDJFz5BeSCCa3RQWYbXGE-2q4TJQ@mail.gmail.com>
 <CAHk-=whuUdqrh2=LLNfRiW6oadx0zzGVkvqyx_O1cGLa2U6Jjg@mail.gmail.com>
 <20190830150208.jyk7tfzznqimc6ow@treble>
 <CAHk-=wgqAcRU99Dp20+ZAux7Mdgbnw5deOguwOjdCJY0eNnSkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgqAcRU99Dp20+ZAux7Mdgbnw5deOguwOjdCJY0eNnSkA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 30 Aug 2019 16:49:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 08:48:49AM -0700, Linus Torvalds wrote:
> On Fri, Aug 30, 2019 at 8:02 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > For KASAN, the Clang threshold for inserting memset() is *2* consecutive
> > writes instead of 17.  Isn't that likely to cause tearing-related
> > surprises?
> 
> Tearing isn't likely to be a problem.
> 
> It's not like memcpy() does byte-by-byte copies. If you pass it a
> word-aligned pointer, it will do word-aligned accesses simply for
> performance reasons.
> 
> Even on x86, where we use "rep movsb", we (a) tend to disable it for
> small copies and (b) it turns out that microcode that does the
> optimized movsb (which is the only case we use it) probably ends up
> doing atomic things anyway. Note the "probably". I don't have
> microcode source code, but there are other indications like "we know
> it doesn't take interrupts on a byte-per-byte level, only on the
> cacheline level".

The microcode argument is not all that comforting :-)

Also what about unaligned accesses, e.g. if a struct member isn't on a
word boundary?  Arnd's godbolt link showed those can get combined too.

I don't see x86 memcpy() doing any destination alignment checks.

Have we audited other arches' memset/memcpy implementations?

> So it's probably not an issue from a tearing standpoint - but it
> worries me because of "this has to be a leaf function" kind of issues
> where we may be using individual stores on purpose. We do have things
> like that.

It sounds like everybody's in agreement that replacing accesses with
memset/memcpy is bad in a kernel context.  Should we push for a new
fine-grained compiler option to disable it?

-- 
Josh
