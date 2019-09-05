Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C9DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A50206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ak74pS4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389822AbfIEQqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:46:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbfIEQqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:46:46 -0400
Received: from zn.tnic (p200300EC2F0A5F00ED1F85EF3FFCFB3D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5f00:ed1f:85ef:3ffc:fb3d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B2811EC026F;
        Thu,  5 Sep 2019 18:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567702005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cHu6QE74CNs1FkmhZ8Lols7/VAMPd2toM7CcVZKn6Vg=;
        b=ak74pS4L5p6sB45XG4CnsYfZqLntkV7jNgbOMe3CfvjQxe/hnY2OF+kqNLgh+yz1oW6dxX
        KwSanSC7zkIOS6+Alpct64rE+WcUTFhLBNuDID9HeMjR1mzJZng8m7lk2adOZ26pfdLGB/
        N1zvxUKSauOxrJUZDyQ/KuVB9akSyAc=
Date:   Thu, 5 Sep 2019 18:46:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, vaibhavrustagi@google.com,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
Message-ID: <20190905164639.GG19246@zn.tnic>
References: <20190904214505.GA15093@swahl-linux>
 <20190905091514.GA21479@zn.tnic>
 <20190905150738.GD14263@swahl-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905150738.GD14263@swahl-linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:07:38AM -0500, Steve Wahl wrote:
> kexec: Overflow in relocation type 11 value 0x11fffd000

That looks like R_X86_64_32S which is:

"The linker must verify that the generated value for the R_X86_64_32
(R_X86_64_32S) relocation zero-extends (sign-extends) to the original
64-bit value."

Please add that to the commit message.

> ... when loading the crash kernel.
> 
> > What exactly caused those errors, the flags removal from
> > kexec-purgatory.o?
> 
> No, it's the flags for compiling the other objects (purgatory.o,
> sha256.o, and string.o) that cause the problem.  You may have missed
> the added initial values for PURGATORY_CFLAGS_REMOVE and
> PURGATORY_CFLAGS.  This changes -mcmodel=kernel back to
> -mcmodel=large,

That I missed...

> and adds back -ffreestanding and
> -fno-zero-initialized-in-bss, to match the previous flags.

... and that I saw. :)

> -mcmodel=kernel is the major cause of the relocation errors, as the
> code generated contained only 32 bit references to things that can be
> anywhere in 64 bit address space.

Needs to go into the commit message.

> The remaining flag changes are appropriate for compiling a standalone
> module, which applies to 3 of the objects compiled from C files in
> this directory -- they contribute to a standalone piece of code that
> is not (technically) linked with the rest of the kernel.
> 
> (Fine line here: the standalone binary does not get any symbols
> resolved against the rest of the kernel; which is why I say it's not
> *linked* with it.  The binary image of this standalone binary does get
> put into a character array that is pulled into the kernel object code,
> so it does become part of the kernel, but just as an array of bytes
> that kexec copies somewhere and eventually jumps to as a standalone
> program.)

Yes, a shorter version of that should be part of the commit message too.

> kexec-purgatory.o, on the other hand, does get linked with the rest of
> the kernel and should be compiled with the usual flags, not standalone
> flags. That is why changes for it are a bit different, which you
> noticed.

Ok, thanks for explaining.

Now please add that more detailed explanation to your commit message so
that people doing git archeology in the future can gather from it what
the problem was and what the solution became and why.

Also, add the reviewed- and tested-by flags you got from people.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
