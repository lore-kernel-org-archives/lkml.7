Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4930C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ED720838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfGOHFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:05:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52009 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfGOHFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:05:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45nF0t693bz9sPK;
        Mon, 15 Jul 2019 17:05:34 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
In-Reply-To: <20190713235430.GZ14074@gate.crashing.org>
References: <20190713032106.8509-1-yamada.masahiro@socionext.com> <20190713124744.GS14074@gate.crashing.org> <20190713131642.GU14074@gate.crashing.org> <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com> <20190713235430.GZ14074@gate.crashing.org>
Date:   Mon, 15 Jul 2019 17:05:34 +1000
Message-ID: <87v9w393r5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Sun, Jul 14, 2019 at 07:45:15AM +0900, Masahiro Yamada wrote:
>> On Sat, Jul 13, 2019 at 10:17 PM Segher Boessenkool
>> <segher@kernel.crashing.org> wrote:
>> > On Sat, Jul 13, 2019 at 07:47:44AM -0500, Segher Boessenkool wrote:
>> > > On Sat, Jul 13, 2019 at 12:21:06PM +0900, Masahiro Yamada wrote:
>> > > > The KBUILD_ARFLAGS addition in arch/powerpc/Makefile has never worked
>> > > > in a useful way because it is always overridden by the following code
>> > > > in the top Makefile:
>> > > >
>> > > >   # use the deterministic mode of AR if available
>> > > >   KBUILD_ARFLAGS := $(call ar-option,D)
>> > > >
>> > > > The code in the top Makefile was added in 2011, by commit 40df759e2b9e
>> > > > ("kbuild: Fix build with binutils <= 2.19").
>> > > >
>> > > > The KBUILD_ARFLAGS addition for ppc has always been dead code from the
>> > > > beginning.
>> > >
>> > > That was added in 43c9127d94d6 to replace my 8995ac870273 from 2007.
>> > >
>> > > Is it no longer supported to build a 64-bit kernel with a toolchain
>> > > that defaults to 32-bit, or the other way around?  And with non-native
>> > > toolchains (this one didn't run on Linux, even).
>> >
>> > It was an --enable-targets=all toolchain, somewhat common for crosses,
>> > if that matters.
>> 
>> I always use the same toolchain
>> for compile-testing PPC32/64.
>> 
>> I have never been hit by the issue you mention.
>> Somebody would have reported it if it were still a problem.
>
> But did you use --enable-targets=all?

I do. And I don't see any errors with this patch applied.

> The problem was empty archives IIRC.  Not a problem anymore with thin
> archives, maybe?

Maybe? Though I can't get it to break even before we switched to them.

>> Moreover, commit 43c9127d94d6
>> translated the environment variable "GNUTARGET"
>> into the command option "--target="
>> 
>> My powerpc-linux-ar does not know it:
>> 
>> powerpc-linux-ar: -t: No such file or directory
>
> Yes, that is why I used the environment variable, all binutils work
> with that.  There was no --target option in GNU ar before 2.22.

Yeah, we're not very good at testing with really old binutils, so I
guess we broke that.

I'm inclined to merge this, it doesn't seem to break anything, and it
fixes using --target on old binutils that don't have it.

cheers
