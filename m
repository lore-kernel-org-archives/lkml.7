Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A82C76198
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB5B2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfGSDjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:39:11 -0400
Received: from ozlabs.org ([203.11.71.1]:35999 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfGSDjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:39:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45qcDr4nkfz9s00;
        Fri, 19 Jul 2019 13:39:08 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
In-Reply-To: <20190718204631.GV20882@gate.crashing.org>
References: <20190713131642.GU14074@gate.crashing.org> <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com> <20190713235430.GZ14074@gate.crashing.org> <87v9w393r5.fsf@concordia.ellerman.id.au> <20190715072959.GB20882@gate.crashing.org> <87pnma89ak.fsf@concordia.ellerman.id.au> <20190717143811.GL20882@gate.crashing.org> <CAK7LNATesRrJFGZQOkTY+PL7FNyub5FJ0N6NF4s6icdXdPNr+Q@mail.gmail.com> <20190717164628.GN20882@gate.crashing.org> <CAK7LNAR7jkq1fAi_=xgsANCkgP2AAej9Yv7RZB3B_cpD7C_71Q@mail.gmail.com> <20190718204631.GV20882@gate.crashing.org>
Date:   Fri, 19 Jul 2019 13:39:08 +1000
Message-ID: <87blxq8zhf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Thu, Jul 18, 2019 at 11:19:58AM +0900, Masahiro Yamada wrote:
>> On Thu, Jul 18, 2019 at 1:46 AM Segher Boessenkool
>> <segher@kernel.crashing.org> wrote:
>> Kbuild always uses thin archives as far as vmlinux is concerned.
>> 
>> But, there are some other call-sites.
>> 
>> masahiro@pug:~/ref/linux$ git grep  '$(AR)' -- :^Documentation :^tools
>> arch/powerpc/boot/Makefile:    BOOTAR := $(AR)
>> arch/unicore32/lib/Makefile:    $(Q)$(AR) p $(GNU_LIBC_A) $(notdir $@) > $@
>> arch/unicore32/lib/Makefile:    $(Q)$(AR) p $(GNU_LIBGCC_A) $(notdir $@) > $@
>> lib/raid6/test/Makefile:         $(AR) cq $@ $^
>> scripts/Kbuild.include:ar-option = $(call try-run, $(AR) rc$(1)
>> "$$TMP",$(1),$(2))
>> scripts/Makefile.build:      cmd_ar_builtin = rm -f $@; $(AR)
>> rcSTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
>> scripts/Makefile.lib:      cmd_ar = rm -f $@; $(AR)
>> rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
>> 
>> Probably, you are interested in arch/powerpc/boot/Makefile.
>
> That one seems fine actually.  The raid6 one I don't know.
>
>
> My original commit message was
>
>     Without this, some versions of GNU ar fail to create
>     an archive index if the object files it is packing
>     together are of a different object format than ar's
>     default format (for example, binutils compiled to
>     default to 64-bit, with 32-bit objects).
>
> but I cannot reproduce the problem anymore.  Shortly after my patch the
> thin archive code happened to binutils, and that overhauled some other
> things, which might have fixed it already?
>
>> > Yes, I know.  This isn't about built-in.[oa], it is about *other*
>> > archives we at least *used to* create.  If we *know* we do not anymore,
>> > then this workaround can of course be removed (and good riddance).
>> 
>> If it is not about built-in.[oa],
>> which archive are you talking about?
>> 
>> Can you pin-point the one?
>
> No, not anymore.  Lost in the mists of time, I guess?  I think we'll
> just have to file it as "it seems to work fine now".

Yeah I think so. If someone finds a case it breaks we can fix it then.

> Thank you (and everyone else) for the time looking at this!

Likewise.

cheers
