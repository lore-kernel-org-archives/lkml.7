Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3C5C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FAA20882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfG3Heq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:34:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39390 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbfG3Hep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:34:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id w190so45875972qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 00:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zr+6M31Gi9RIhd6WGjh1Vbf2RuBt7+NJdVFSHL2O2pg=;
        b=TaryWMMIw1asCdXr3irLnmKCisZfKs2JnwOX+AU+LBQY7fPxHjBGquXZ5VUbY8z6uF
         5SWh1YeuPiG9my9J9OvEiHQqSa/nZ2bzqIsoydKeTtEqULZH68Fl9xRs6ri1H4y4G3oV
         IGf+sQcSR24ajyj2+CmpAIs83qhyyOhf1UVGjUuTTARleCmXIIvFTVkAKgUaiFv0ewlS
         0JvNneuONzluJbjYAFeHu0NsrQa2dFE0AKiVqmaOw8742Ve0MDJuY6XlQ/l6/DvjSG7d
         7QTwIKe1SV8eDwsw/nGPP9ErdGSi7KQXRwbYYM4JJICPR6O2DfnplFxt9ghKQl/IOHIe
         FKOw==
X-Gm-Message-State: APjAAAUHmOolOfkWMBMovuNy8qwwXYhIPjmBCv4WRSbsw1WgXmFiiFdE
        nt5E3o8iRWTZYd0EV5oH7pX27JAUzjicy+sjdIM=
X-Google-Smtp-Source: APXvYqybWuHcjdBPufsxlBAq5PrDmFRv9hpZANXgyII0B0Cjj/Yb3Q0KornkEI4utqv4T45sDGzfGDmznwSLfL3qQig=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr74856027qkc.394.1564472084625;
 Tue, 30 Jul 2019 00:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190729202542.205309-1-ndesaulniers@google.com>
 <20190729203246.GA117371@archlinux-threadripper> <20190729215200.GN31406@gate.crashing.org>
In-Reply-To: <20190729215200.GN31406@gate.crashing.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 09:34:28 +0200
Message-ID: <CAK8P3a1GQSyCj1L8fFG4Pah8dr5Lanw=1yuimX1o+53ARzOX+Q@mail.gmail.com>
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

On Mon, Jul 29, 2019 at 11:52 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Mon, Jul 29, 2019 at 01:32:46PM -0700, Nathan Chancellor wrote:
> > For the record:
> >
> > https://godbolt.org/z/z57VU7
> >
> > This seems consistent with what Michael found so I don't think a revert
> > is entirely unreasonable.
>
> Try this:
>
>   https://godbolt.org/z/6_ZfVi
>
> This matters in non-trivial loops, for example.  But all current cases
> where such non-trivial loops are done with cache block instructions are
> actually written in real assembler already, using two registers.
> Because performance matters.  Not that I recommend writing code as
> critical as memset in C with inline asm :-)

Upon a second look, I think the issue is that the "Z" is an input argument
when it should be an output. clang decides that it can make a copy of the
input and pass that into the inline asm. This is not the most efficient
way, but it seems entirely correct according to the constraints.

Changing it to an output "=Z" constraint seems to make it work:

https://godbolt.org/z/FwEqHf

Clang still doesn't use the optimum form, but it passes the correct pointer.

       Arnd
