Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E32C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB922339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfH2A2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 20:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfH2A2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 20:28:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B202C10F23E2;
        Thu, 29 Aug 2019 00:28:23 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C139B5C1D6;
        Thu, 29 Aug 2019 00:28:22 +0000 (UTC)
Date:   Wed, 28 Aug 2019 19:28:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Eli Friedman <efriedma@quicinc.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
Message-ID: <20190829002820.7n3kro3yfpq4mglq@treble>
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble>
 <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble>
 <CAKwvOdkyvZf-oM6aXuCD6Aa4zDqZU-fKu5uUF6E05V6rWnxpKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkyvZf-oM6aXuCD6Aa4zDqZU-fKu5uUF6E05V6rWnxpKA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 29 Aug 2019 00:28:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:13:21PM -0700, Nick Desaulniers wrote:
> On Tue, Aug 27, 2019 at 12:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Tue, Aug 27, 2019 at 09:00:52PM +0200, Arnd Bergmann wrote:
> > > On Tue, Aug 27, 2019 at 5:00 PM Ilie Halip <ilie.halip@gmail.com> wrote:
> > > >
> > > > > > $ clang-9 -c  crc32.i  -O2   ; objtool check  crc32.o
> > > > > > crc32.o: warning: objtool: fn1 uses BP as a scratch register
> > > >
> > > > Yes, I see it too. https://godbolt.org/z/N56HW1
> > > >
> > > > > Do you still see this warning with -fno-omit-frame-pointer (assuming
> > > > > clang has that option)?
> > > >
> > > > Using this makes the warning go away. Running objtool with --no-fp
> > > > also gets rid of it.
> > >
> > > I still see the warning after adding back the -fno-omit-frame-pointer
> > > in my reduced test case:
> > >
> > > $ clang-9 -c  crc32.i -Werror -Wno-address-of-packed-member -Wall
> > > -Wno-pointer-sign -Wno-unused-value -Wno-constant-logical-operand -O2
> > > -Wno-unused -fno-omit-frame-pointer
> > > $ objtool check  crc32.o
> > > crc32.o: warning: objtool: fn1 uses BP as a scratch register
> >
> > This warning most likely means that clang is clobbering RBP in leaf
> > functions.  With -fno-omit-frame-pointer, leaf functions don't need to
> > set up the frame pointer, but they at least need to leave RBP untouched,
> > so that an interrupts/exceptions can unwind through the function.
> 
> It sounds like clang has `-mno-omit-leaf-frame-pointer` (via
> https://bugs.llvm.org/show_bug.cgi?id=43128#c6).  Arnd, can you give
> that a shot?

I think Arnd already confirmed that -mno-omit-leaf-frame-pointer fixed
it in an earlier email.

-- 
Josh
