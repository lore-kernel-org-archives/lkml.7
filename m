Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2135BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F021D205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfG3Oar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:30:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34805 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfG3Oar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:30:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so63299313qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6k3LBxNyc8SfDfnGl8aFZmpFQ+XfoOprX/ZJ6nWfjo=;
        b=ptmBVRQshpo4DY/kHQxEUN75TwF1yY41m3ArrTc2S80C6EoKqxCUvVwISUAogY+Yy+
         0lZ07dxvT1tKdPIaeoOjp8OrpF2V+AbI1qz0C3onFEp9bKrMpXYpmVf6NB1FegJQalEV
         zteoaGYJ7fG1gUqRP+4qLL1nNnqFqNHV6z6xS18BXVQ9XZOhvRp/ZCd9hNG5T4XlKDRo
         xBVr2Z+MOtfYupTsZRYi8QZQP+Iy5CgyDwiqIT/oVxityBGtJxFFE5iykVWKsoEGcleF
         GvW3QcsRFZb9F/rkXHf0MrFaQ1Bq2vjuRH+h4eksPM9fo26M/T8ftnDSFkr8ktm449+1
         +d1g==
X-Gm-Message-State: APjAAAWmLX+pO/EBQL8rFdF2TFFufq3SaYsv5PxIKv37XyVoCRlo95E7
        GfGCVv/2Cc/dQb8j6QP/qpsosT7XE7rtMI+eDMc=
X-Google-Smtp-Source: APXvYqzUviZRVY2WfETwauJWgNpE5wRBn/5f9gVf7X+Z0FC6TvIsPiZ0akUTChtLPGAi8VVnDWCMuxwfI9B5fg4E1E8=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr79757414qtd.18.1564497045891;
 Tue, 30 Jul 2019 07:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190729202542.205309-1-ndesaulniers@google.com>
 <20190729203246.GA117371@archlinux-threadripper> <20190729215200.GN31406@gate.crashing.org>
 <CAK8P3a1GQSyCj1L8fFG4Pah8dr5Lanw=1yuimX1o+53ARzOX+Q@mail.gmail.com> <20190730134856.GO31406@gate.crashing.org>
In-Reply-To: <20190730134856.GO31406@gate.crashing.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 16:30:29 +0200
Message-ID: <CAK8P3a2755_6xq453C2AePLW8BeQk_Jg=HfjB_F-zyVMnQDfdg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@c-s.fr>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 3:49 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Tue, Jul 30, 2019 at 09:34:28AM +0200, Arnd Bergmann wrote:
> > Upon a second look, I think the issue is that the "Z" is an input argument
> > when it should be an output. clang decides that it can make a copy of the
> > input and pass that into the inline asm. This is not the most efficient
> > way, but it seems entirely correct according to the constraints.
>
> Most dcb* (and all icb*) do not change the memory pointed to.  The
> memory is an input here, logically as well, and that is obvious.

Ah, right. I had only thought of dcbz here, but you are right that using
an output makes little sense for the others.

readl() is another example where powerpc currently uses "Z" for an
input, which illustrates this even better.

> > Changing it to an output "=Z" constraint seems to make it work:
> >
> > https://godbolt.org/z/FwEqHf
> >
> > Clang still doesn't use the optimum form, but it passes the correct pointer.
>
> As I said many times already, LLVM does not seem to treat all asm
> operands as lvalues.  That is a bug.  And it is critical for memory
> operands for example, as should be obvious if you look at at for a few
> seconds (you pass *that* memory, not a copy of it).  The thing you pass
> has an identity.  It's an lvalue.  This is true for *all* inline asm
> operands, not just output operands and memory operands, but it is most
> obvious there.

From experimentation, I would guess that llvm handles "m" correctly, but
not "Z". See https://godbolt.org/z/uqfDx_ for another example.

> Or, LLVM might have a bug elsewhere.
>
> Either way, the asm is fine, and it has worked fine in GCC since
> forever.  Changing this constraint to be an output constraint would
> just be obfuscation (we could change *all* operands to *everything* to
> be inout ("+") constraints, and it won't affect correctness, just the
> reader's sanity).

I would still argue that for dcbz specifically, an output makes more
sense than an input, but as you say that does not solve the others.

        Arnd
