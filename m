Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB1AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0ED9207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="J4L8Im/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLIKxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:53:18 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38579 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfLIKxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:53:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Wg5l45Wvz9sP6;
        Mon,  9 Dec 2019 21:53:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1575888796;
        bh=Sx8iWlX5fXNNlqxjgYMOs3SvPENuiEFrugWvdXWYq5o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J4L8Im/vg/Tt++EhvqfFa7Bo1cQsG4hCAPfpeP2fg44UAP67R/2X7N0oTcZHNRpWj
         oVJIHl24WiU8flkmL4B/x/bmIjVnPQHFYMPPxtC+4Zahmt162zCOWwzYIqDCIsMWOw
         LQF07hgKMnLUlSeXMIty4R9ZIL6VBU6mPLEMMufnGZSLg6hoQwlDUGzT/yWsmfbLzA
         A7fr4MWpjDvvR2rWKrmrz4HD0hhTDufo4iXGgumnh1XR18Tc017OCuf6wb1nd2sST3
         8os8Hx7trY8PNyubwVGnBZjAAS3smHHf2sjXQ9i/+bBQmP4lZPeMM2PGxURE+MSWlU
         zD64Hn9ejlcFw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and call_do_softirq()
In-Reply-To: <20191207174057.GY3152@gate.crashing.org>
References: <20191121101552.GR16031@gate.crashing.org> <87y2w49rgo.fsf@mpe.ellerman.id.au> <20191125142556.GU9491@gate.crashing.org> <5fdb1c92-8bf4-01ca-f81c-214870c33be3@c-s.fr> <20191127145958.GG9491@gate.crashing.org> <2072e066-1ffb-867e-60ec-04a6bb9075c1@c-s.fr> <20191129184658.GR9491@gate.crashing.org> <ebc67964-e5a9-acd0-0011-61ba23692f7e@c-s.fr> <20191206205953.GQ3152@gate.crashing.org> <2a22feca-d6d6-6cb0-6c76-035234fa8742@c-s.fr> <20191207174057.GY3152@gate.crashing.org>
Date:   Mon, 09 Dec 2019 21:53:11 +1100
Message-ID: <878snlrcrs.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Sat, Dec 07, 2019 at 10:42:28AM +0100, Christophe Leroy wrote:
>> Le 06/12/2019 =C3=A0 21:59, Segher Boessenkool a =C3=A9crit=C2=A0:
>> >If the compiler can see the callee wants the same TOC as the caller has,
>> >it does not arrange to set (and restore) it, no.  If it sees it may be
>> >different, it does arrange for that (and the linker then will check if
>> >it actually needs to do anything, and do that if needed).
>> >
>> >In this case, the compiler cannot know the callee wants the same TOC,
>> >which complicates thing a lot -- but it all works out.
>>=20
>> Do we have a way to make sure which TOC the functions are using ? Is=20
>> there several TOC at all in kernel code ?
>
> Kernel modules have their own TOC, I think?

Yes.

>> >I think things can still go wrong if any of this is inlined into a kern=
el
>> >module?  Is there anything that prevents this / can this not happen for
>> >some fundamental reason I don't see?
>>=20
>> This can't happen can it ?
>> do_softirq_own_stack() is an outline function, defined in powerpc irq.c
>> Its only caller is do_softirq() which is an outline function defined in=
=20
>> kernel/softirq.c
>>=20
>> That prevents inlining, doesn't it ?
>
> Hopefully, sure.  Would be nice if it was clearer that this works...  It
> is too much like working by chance, the way it is :-(

There's no way any of that code can end up in a module. Or at least if
there is, that's a bug.

>> Anyway, until we clarify all this I'll limit my patch to PPC32 which is=
=20
>> where the real benefit is I guess.
>>=20
>> At the end, maybe the solution should be to switch to IRQ stack=20
>> immediately in the exception entry as x86_64 do ?

Yeah that might be cleaner.

cheers
