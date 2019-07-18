Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AC8C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBFD21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfGRXUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 19:20:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfGRXUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:20:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 347903082E10;
        Thu, 18 Jul 2019 23:20:18 +0000 (UTC)
Received: from treble (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59DD31001B35;
        Thu, 18 Jul 2019 23:20:17 +0000 (UTC)
Date:   Thu, 18 Jul 2019 18:20:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
Message-ID: <20190718232015.bazk37cqbweh52pc@treble>
References: <CAK8P3a1_8kjzamn6_joBbZTO8NeGn0E3O+MZ+bcOQ0HkkRHXRQ@mail.gmail.com>
 <20190712135755.7qa4wxw3bfmwn5rp@treble>
 <CAK8P3a13QFN59o9xOMce6K64jGnz+Cf=o3R_ORMo7j-65F5i8A@mail.gmail.com>
 <20190712142928.gmt6gibikdjmkppm@treble>
 <CAKwvOdnOpgo9rEctZZR9Y9rEc60FCthbPtp62UsdMtkGDF5nUg@mail.gmail.com>
 <CAK8P3a0AGpvAOzSfER7iiaz=aLVMbxiVorTsh__yT4xxBOHSyw@mail.gmail.com>
 <CAKwvOd=o16rtGOVm9DWhhqxed0OEW5NKt4Vt3y_6KCcbdU-dhQ@mail.gmail.com>
 <CAK8P3a2Vq+ojOZSefwziMhzU2SG+Bq6HDz2Ssjz7_BpVnMUu=A@mail.gmail.com>
 <20190716230336.y7nk24ybbwguio2s@treble>
 <CAKwvOdm_MiACJWnRww3tSD7033J6MX2Erzs1xwmd1=taNmyg9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdm_MiACJWnRww3tSD7033J6MX2Erzs1xwmd1=taNmyg9A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 18 Jul 2019 23:20:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 03:36:47PM -0700, Nick Desaulniers wrote:
> On Tue, Jul 16, 2019 at 4:03 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, Jul 17, 2019 at 12:05:14AM +0200, Arnd Bergmann wrote:
> > > On Tue, Jul 16, 2019 at 10:24 PM 'Nick Desaulniers' via Clang Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > On Fri, Jul 12, 2019 at 1:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > >
> > > > > On Fri, Jul 12, 2019 at 6:59 PM 'Nick Desaulniers' via Clang Built
> > > > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > > > > > The issue still needs to get fixed in clang regardless.  There are other
> > > > > > > noreturn functions in the kernel and this problem could easily pop back
> > > > > > > up.
> > > > > >
> > > > > > Sure, thanks for the report.  Arnd, can you help us get a more minimal
> > > > > > test case to understand the issue better?
> > > > >
> > > > > I reduced it to this testcase:
> > > > >
> > > > > int a, b;
> > > > > void __reiserfs_panic(int, ...) __attribute__((noreturn));
> > > > > void balance_internal() {
> > > > >   if (a)
> > > > >     __reiserfs_panic(0, "", __func__, "", 2, __func__, a);
> > > > >   if (b)
> > > > >     __reiserfs_panic(0, "", __func__, "", 5, __func__, a, 0);
> > > > > }
> > > > >
> > > > > https://godbolt.org/z/Byfvmx
> > > >
> > > > Is this the same issue as Josh pointed out?  IIUC, Josh pointed to a
> > > > jump destination that was past a `push %rbp`, and I don't see it in
> > > > your link.  (Or, did I miss it?)
> > >
> > > I think it can be any push. The point is that the stack is different
> > > between the two branches leading up to the noreturn call.
> >
> > Right.
> 
> So if I remove the `-mstack-alignment=8` command line flag, it looks
> like the stack depth will still differ on calls to __reiserfs_panic,
> but now the call is not shared (two separate code paths):
> https://godbolt.org/z/tvkXwK. Is that ok or also bad?

That looks ok.  I'm not sure whether removing the stack alignment would
fix it though, you might have just gotten lucky.

> I'm getting the feeling that `-mstack-alignment=8` might have some
> issues once we start pushing parameters on the stack.  How many can we
> use registers for in x86 before resorting to the stack, and does the
> function being variadic affect this? (if not, maybe a test case
> without variadic and many-parameters would not conflate the issue?)

Yeah, I think calling a variadic function (or a function with more than
6 args) does have something to do with it, because then some arguments
have to be passed on the stack.

-- 
Josh
