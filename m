Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FB5C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447DF20665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbfGOSQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:16:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:53430 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbfGOSQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:16:44 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6FIGLFP018897;
        Mon, 15 Jul 2019 13:16:21 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6FIGJFp018896;
        Mon, 15 Jul 2019 13:16:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 15 Jul 2019 13:16:18 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
Message-ID: <20190715181618.GG20882@gate.crashing.org>
References: <20190713032106.8509-1-yamada.masahiro@socionext.com> <20190713124744.GS14074@gate.crashing.org> <20190713131642.GU14074@gate.crashing.org> <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com> <20190713235430.GZ14074@gate.crashing.org> <87v9w393r5.fsf@concordia.ellerman.id.au> <20190715072959.GB20882@gate.crashing.org> <CAK7LNATGEK9wxz87J3sTNOYPdtAFXaegQU9EctEBGULQL-ZC4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATGEK9wxz87J3sTNOYPdtAFXaegQU9EctEBGULQL-ZC4w@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 09:03:46PM +0900, Masahiro Yamada wrote:
> On Mon, Jul 15, 2019 at 4:30 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > On Mon, Jul 15, 2019 at 05:05:34PM +1000, Michael Ellerman wrote:
> > > Segher Boessenkool <segher@kernel.crashing.org> writes:
> > > > Yes, that is why I used the environment variable, all binutils work
> > > > with that.  There was no --target option in GNU ar before 2.22.
> 
> I use binutils 2.30
> It does not understand --target option.
> 
> $ powerpc-linux-ar --version
> GNU ar (GNU Binutils) 2.30
> Copyright (C) 2018 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License version 3 or (at your option) any later version.
> This program has absolutely no warranty.
> 
> If I give --target=elf$(BITS)-$(GNUTARGET) option, I see this:
> powerpc-linux-ar: -t: No such file or directory

You need to provide a valid command line, like

$ powerpc-linux-ar tv smth.a --target=elf32-powerpc

ar is a bit weird.


Segher
