Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D50C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ECF2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/8BoGQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391057AbfGRVVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:21:42 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33503 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfGRVVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:21:42 -0400
Received: by mail-vs1-f66.google.com with SMTP id m8so20216175vsj.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLWgE4G1xumD+5ZusInPzcVsAid5/1NnJBPXIPh5kwU=;
        b=c/8BoGQt9/QOqtqbYVLLVLcLBKKCNOL7ZGgciVXxCS21F1WB5gBw1Lhtv1yMwGbQ/8
         FL7h6h0baE/EM6HpjnHtdgaCQxgO1LCBFh5EMOP8abh9QCVx9P0iVVBR1osJKkuIj37I
         7In1Y7cMeJe/ozyMDC/3pmdbyV+j2J3tmfucx9P0zn3zlgwZMEGPszlG/ypDkHx9w0ey
         VmnNdkY5C43kS4BMQYBEBtVWCnmD58X/+gFuHIi7F0VXGS7IeLhQ6lpyF6vygZUViVa0
         OEbs/lPqkuIOfBqlLezNboG1lpxEwSrVjAGOZTHk62zaj5AxQJAcmrSg06aF3ENi3eNO
         sM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLWgE4G1xumD+5ZusInPzcVsAid5/1NnJBPXIPh5kwU=;
        b=UcyfIzwe5LBWI2001g+RkY43DhcagznvN0OcHBGFyvOx8WeftAh3oqIlodMTPkgJw2
         YPeWFoKVqExaOXHLO67sLhW7HXfn4ERfVwOEYf4Cy3+dibUoCWBuGnAJWD/LER5X9PLw
         m0ns1D2m96+e/WLhQ9y6DB7SfUA+fYKwbHYkO90zYrVEVodXtztAmIiPKAwVtMwbPdk5
         41Xw6xwfDjLlRHg8cWKsyFU3k0m6kLKw8iGBK5oRILImcx6Dkh0iz5gf8wM7mmttEsX8
         dwuCPlY//k4nGqWWSVJeTNvfwDarWZCU7StpZQ6inHNeVZsGq5F0PktaO5RfPlmHakn/
         jqzQ==
X-Gm-Message-State: APjAAAWZLbJZhzMXOW3eSpGcMgQEBuMePz9pEwT/jjc1+uZ0SpnrgpEx
        jRP3l5oDTLGPnimcl4WP39XGQama5PdRRoRvgWfu
X-Google-Smtp-Source: APXvYqzw6e79MIrSSr/wveDt3o5nS/x3WVT9g6SIC9rmt/BfJdmhC96Gcdb7mp3vJdj09OD/y6QUPsswLWFlksDLylI=
X-Received: by 2002:a67:d39e:: with SMTP id b30mr30387881vsj.212.1563484900833;
 Thu, 18 Jul 2019 14:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <1562959401-19815-1-git-send-email-cai@lca.pw> <20190712.154606.493382088615011132.davem@davemloft.net>
 <EFD25845-097A-46B1-9C1A-02458883E4DA@lca.pw> <20190712.175038.755685144649934618.davem@davemloft.net>
 <D7E57421-A6F4-4453-878A-8F173A856296@lca.pw> <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
In-Reply-To: <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 18 Jul 2019 14:21:29 -0700
Message-ID: <CAGG=3QUvdwJs1wW1w+5Mord-qFLa=_WkjTsiZuwGfcjkoEJGNQ@mail.gmail.com>
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Qian Cai <cai@lca.pw>, James Y Knight <jyknight@google.com>,
        David Miller <davem@davemloft.net>, sathya.perla@broadcom.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, netdev@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[My previous response was marked as spam...]

Top-of-tree clang says that it's const:

$ gcc a.c -O2 && ./a.out
a is a const.

$ clang a.c -O2 && ./a.out
a is a const.


On Thu, Jul 18, 2019 at 2:10 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jul 18, 2019 at 2:01 PM Qian Cai <cai@lca.pw> wrote:
> >
> >
> >
> > > On Jul 12, 2019, at 8:50 PM, David Miller <davem@davemloft.net> wrote:
> > >
> > > From: Qian Cai <cai@lca.pw>
> > > Date: Fri, 12 Jul 2019 20:27:09 -0400
> > >
> > >> Actually, GCC would consider it a const with -O2 optimized level because it found that it was never modified and it does not understand it is a module parameter. Considering the following code.
> > >>
> > >> # cat const.c
> > >> #include <stdio.h>
> > >>
> > >> static int a = 1;
> > >>
> > >> int main(void)
> > >> {
> > >>      if (__builtin_constant_p(a))
> > >>              printf("a is a const.\n");
> > >>
> > >>      return 0;
> > >> }
> > >>
> > >> # gcc -O2 const.c -o const
> > >
> > > That's not a complete test case, and with a proper test case that
> > > shows the externalization of the address of &a done by the module
> > > parameter macros, gcc should not make this optimization or we should
> > > define the module parameter macros in a way that makes this properly
> > > clear to the compiler.
> > >
> > > It makes no sense to hack around this locally in drivers and other
> > > modules.
> >
> > If you see the warning in the original patch,
> >
> > https://lore.kernel.org/netdev/1562959401-19815-1-git-send-email-cai@lca.pw/
> >
> > GCC definitely optimize rx_frag_size  to be a constant while I just confirmed clang
> > -O2 does not. The problem is that I have no clue about how to let GCC not to
> > optimize a module parameter.
> >
> > Though, I have added a few people who might know more of compilers than myself.
>
> + Bill and James, who probably knows more than they'd like to about
> __builtin_constant_p and more than other LLVM folks at this point.
>
> --
> Thanks,
> ~Nick Desaulniers
