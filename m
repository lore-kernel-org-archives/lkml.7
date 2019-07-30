Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30954C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077852087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfG3SZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:25:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38410 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbfG3SZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:25:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so47329286qkk.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgkfIZTZT31YAwT292CElgRNymWNb2JeX6gELGSJ0g8=;
        b=tz2jIMAats3GShbrBatOfygDiXbx4xC6GBe7dsfYS0myEKbOYqqFZAEE8syt92sQ2i
         rqjsgQr0kw+vao1ZYeV4hQbUsU7K+r7yrk8lSyp6ByzMzyQdSAqiW+x54g6D2tWjKlHs
         1cyUq/PAMrUslwQ70wDk8MgUtPE2Iv0KbSAWZXw7+NHk81OggK3Kq/k+JlyiGoBbG+B6
         gvKWSIxh1aRf42P9n4BhK4abEL4sLKb/na1nAtiV3WCowpcDlMXENtI7KCgUKW0YMyZw
         kY7SqbeIr5YOveetT/tdy0x1RvuVZ1PGWHlSPgouK9u37VSYrWawQXTxvyV36iJQ6153
         AIjQ==
X-Gm-Message-State: APjAAAWajXGGpJtsqSMRHuMmOPxPNmJCoeV3sfl/BK1GZmA/GM6R4y3H
        4T9GCjB5Yki6cS1LMa4Wapdj9hraObLzyzFNeWCeiiFb
X-Google-Smtp-Source: APXvYqzFirM6D707r7849pKu3mn8W9JDE1PQUJxlpX8j1dY4OgVkWtzE1LzAAxSPeGNSezpGWMOaXX5pMloR0DGpBHM=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr43867129qki.352.1564511114607;
 Tue, 30 Jul 2019 11:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190729202542.205309-1-ndesaulniers@google.com>
 <20190729203246.GA117371@archlinux-threadripper> <20190729215200.GN31406@gate.crashing.org>
 <CAK8P3a1GQSyCj1L8fFG4Pah8dr5Lanw=1yuimX1o+53ARzOX+Q@mail.gmail.com>
 <20190730134856.GO31406@gate.crashing.org> <CAK8P3a2755_6xq453C2AePLW8BeQk_Jg=HfjB_F-zyVMnQDfdg@mail.gmail.com>
 <20190730161637.GP31406@gate.crashing.org> <20190730170728.GQ31406@gate.crashing.org>
In-Reply-To: <20190730170728.GQ31406@gate.crashing.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 20:24:58 +0200
Message-ID: <CAK8P3a2mT7S4VkxqhzsH_3A8HWs6PHQFO8AinLEaHmvAmT8Kug@mail.gmail.com>
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     kbuild test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 7:07 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Tue, Jul 30, 2019 at 11:16:37AM -0500, Segher Boessenkool wrote:
> > in_le32 and friends?  Yeah, huh.  If LLVM copies that to the stack as
> > well, its (not byte reversing) read will be atomic just fine, so things
> > will still work correctly.
> >
> > The things defined with DEF_MMIO_IN_D (instead of DEF_MMIO_IN_X) do not
> > look like they will work correctly if an update form address is chosen,
> > but that won't happen because the constraint is "m" instead of "m<>",
> > making the %Un pretty useless (it will always be the empty string).
>
> Btw, this is true since GCC 4.8; before 4.8, plain "m" *could* have an
> automodify (autoinc, autodec, etc.) side effect.  What is the minimum
> GCC version required, these days?

gcc-4.6, but an architecture can require a higher version.

         Arnd
