Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE79C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA8E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfG3SYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:24:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33285 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3SYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:24:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so47332803qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELs8WXXvt2Nkvxci62TT76ZUPbF4S3pMgT3/gsD16Yg=;
        b=bDEzt8bmtnk66qMuKWwlviDej60p3bMheuXWAzxg4rt8nq3rq281U2XnF3vi4Yzfsn
         jdizUMUFpUjEWVef6LoIpFfW2xYYTrm8VaoNFHKM7v//1LSh9ARpZb4DFFeIbtkB4dok
         LqHpl+oPPaU4mAwNEQb1A2j6oZrUgpTTqCA3WwkH6UveIe3tRQiFchxrPhshJgRQZcli
         J7RGDLRzzdCeRCFWquDRIKwhAVkNPhiKRlYhbyKycii/ISTQcK0w+kLLBzWSEP0hO1cT
         eE2J+9dmP6NIAp7L8dh9kVHVbYaPdZqXtxYkQBPG3erxjAydnExIBj/3QRUBKRIHb0Nh
         /r4g==
X-Gm-Message-State: APjAAAUpGHN4qZ9iEHldnGkfWv9mlN3oDr/RDFapqvptWRuCCB1dKJG8
        d4H+6qDslh9DlgQHqEOOwVw/Fg6pmGqH4Wu8FqQ=
X-Google-Smtp-Source: APXvYqw0YE69zRoJRlHpqf+lgOqtR/yc+lKsnQOITZmISxo4fV9UOHAPi3cwNRHYae2yNSx6QOkQGDl/06JVPF1xutQ=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr32660393qkm.3.1564511071739;
 Tue, 30 Jul 2019 11:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190729202542.205309-1-ndesaulniers@google.com>
 <20190729203246.GA117371@archlinux-threadripper> <20190729215200.GN31406@gate.crashing.org>
 <CAK8P3a1GQSyCj1L8fFG4Pah8dr5Lanw=1yuimX1o+53ARzOX+Q@mail.gmail.com>
 <20190730134856.GO31406@gate.crashing.org> <CAK8P3a2755_6xq453C2AePLW8BeQk_Jg=HfjB_F-zyVMnQDfdg@mail.gmail.com>
 <20190730161637.GP31406@gate.crashing.org>
In-Reply-To: <20190730161637.GP31406@gate.crashing.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 20:24:14 +0200
Message-ID: <CAK8P3a0_ovcX9tOo1UQ3_1UmM=+A2X=yErw27i2pHOj4XD40-A@mail.gmail.com>
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

On Tue, Jul 30, 2019 at 6:16 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Tue, Jul 30, 2019 at 04:30:29PM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 30, 2019 at 3:49 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > >
> > > On Tue, Jul 30, 2019 at 09:34:28AM +0200, Arnd Bergmann wrote:
> > > > Upon a second look, I think the issue is that the "Z" is an input argument
> > > > when it should be an output. clang decides that it can make a copy of the
> > > > input and pass that into the inline asm. This is not the most efficient
> > > > way, but it seems entirely correct according to the constraints.
> > >
> > > Most dcb* (and all icb*) do not change the memory pointed to.  The
> > > memory is an input here, logically as well, and that is obvious.
> >
> > Ah, right. I had only thought of dcbz here, but you are right that using
> > an output makes little sense for the others.
> >
> > readl() is another example where powerpc currently uses "Z" for an
> > input, which illustrates this even better.
>
> in_le32 and friends?  Yeah, huh.  If LLVM copies that to the stack as
> well, its (not byte reversing) read will be atomic just fine, so things
> will still work correctly.

byteorder is fine, the problem I was thinking of is when moving the load/store
instructions around the barriers that synchronize with DMA, or turning
them into different-size accesses. Changing two consecutive 16-bit mmio reads
into an unaligned 32-bit read will rarely have the intended effect ;-)

       Arnd
