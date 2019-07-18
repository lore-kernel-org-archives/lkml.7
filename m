Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A7C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D0C208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTLdlUK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391391AbfGRVWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:22:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37730 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfGRVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:22:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so14515962plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdDOZlpTn4tsEDqJOH4phmJ0zrEQEHyg4KDmlvGmNVA=;
        b=LTLdlUK3Md6ZrvFG+EulBWmQ3FwJnzXJvo54vza5RGr2dAoMRZx+7pfHorAfNIHatL
         GSryQO0MFwBKms7nrthEc1aJ8oTojJ8OIRHaLlcDGlXFYh1kA7wuJov3gV1Y6X7zhc54
         JkbB5ZhtAXvFJFhlAMEnGgNb9nl16egOJrn/JeH88b9g6VN1wOM5k9HYVJAHFXIPpT/2
         40/r7ITwQR4LYw0DrUscVBRArdymxkLCfvOCIInpjJRFYiur/r3HOnGalrYl7NaCG7Ka
         ftzkaXdFZ6HfwreVvS2HNSsNFyEsp9EZtnVTOQiu/4/0gWiZe6L46RaH8nZzan+BV0w1
         kNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdDOZlpTn4tsEDqJOH4phmJ0zrEQEHyg4KDmlvGmNVA=;
        b=pAQHk3oz/ntSNOzr5Mx83F4n9NLRm9w2ZKCrinXRoAexMy4wGZTnpSFAyxS2PESTvO
         THLTZbBNs3sJfdZZ7FKaTFu8h5SJyh71rZ1NFfpor1OxjL++stJsGFSzD4G3BIbLSmAx
         KGNalLdOkgzVXJQnGBhZPjhdTqpbCEbxcng4dSFef7q72a/079HCHQDARwpPRRBnSkMV
         VD1nmX6Qsnbnh8b7siKOYKXz7lix8UhU10uGbe2xqcf2E/H60QzAd9W1gcaFBBYzbxqA
         l4zuL3eIHKU2Y7qU3aaMih2PTSbzefQC0ZOyjqOtci1U5I8x8f57IMAJiXPnVfNSwaFg
         HX+Q==
X-Gm-Message-State: APjAAAWM5XUTEGlGM86l3ji08hanQ7FlTUyGDcsCrxhIndNA6zCV54by
        U4Txca1zCiCAEO2bniI/ibDLvHMfCGJ+sm0cbNTF8w==
X-Google-Smtp-Source: APXvYqz4/mrNtv3D/O8uy5y5EJlbbJzblE+CppPnjFgR0gR3LQFlKRNWWtKFH+3RZRUW3eIbWFu/KdTLkmmiip5eWD0=
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr51485175pls.179.1563484968978;
 Thu, 18 Jul 2019 14:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <1562959401-19815-1-git-send-email-cai@lca.pw> <20190712.154606.493382088615011132.davem@davemloft.net>
 <EFD25845-097A-46B1-9C1A-02458883E4DA@lca.pw> <20190712.175038.755685144649934618.davem@davemloft.net>
 <D7E57421-A6F4-4453-878A-8F173A856296@lca.pw> <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
 <CAGG=3QWkgm+YhC=TWEWwt585Lbm8ZPG-uFre-kBRv+roPzZFbA@mail.gmail.com>
In-Reply-To: <CAGG=3QWkgm+YhC=TWEWwt585Lbm8ZPG-uFre-kBRv+roPzZFbA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jul 2019 14:22:38 -0700
Message-ID: <CAKwvOd=B=Lj-hTtbe88bo89wLxJrDAsm3fJisSMD=hKkRHf6zw@mail.gmail.com>
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
To:     Bill Wendling <morbo@google.com>
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

On Thu, Jul 18, 2019 at 2:18 PM Bill Wendling <morbo@google.com> wrote:
>
> Top-of-tree clang says that it's const:
>
> $ gcc a.c -O2 && ./a.out
> a is a const.
>
> $ clang a.c -O2 && ./a.out
> a is a const.

Right, so I know you (Bill) did a lot of work to refactor
__builtin_constant_p handling in Clang and LLVM in the
pre-llvm-9-release timeframe.  I suspect Qian might not be using
clang-9 built from source (as clang-8 is the current release) and thus
observing differences.

>
> On Thu, Jul 18, 2019 at 2:10 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> On Thu, Jul 18, 2019 at 2:01 PM Qian Cai <cai@lca.pw> wrote:
>> >
>> >
>> >
>> > > On Jul 12, 2019, at 8:50 PM, David Miller <davem@davemloft.net> wrote:
>> > >
>> > > From: Qian Cai <cai@lca.pw>
>> > > Date: Fri, 12 Jul 2019 20:27:09 -0400
>> > >
>> > >> Actually, GCC would consider it a const with -O2 optimized level because it found that it was never modified and it does not understand it is a module parameter. Considering the following code.
>> > >>
>> > >> # cat const.c
>> > >> #include <stdio.h>
>> > >>
>> > >> static int a = 1;
>> > >>
>> > >> int main(void)
>> > >> {
>> > >>      if (__builtin_constant_p(a))
>> > >>              printf("a is a const.\n");
>> > >>
>> > >>      return 0;
>> > >> }
>> > >>
>> > >> # gcc -O2 const.c -o const
>> > >
>> > > That's not a complete test case, and with a proper test case that
>> > > shows the externalization of the address of &a done by the module
>> > > parameter macros, gcc should not make this optimization or we should
>> > > define the module parameter macros in a way that makes this properly
>> > > clear to the compiler.
>> > >
>> > > It makes no sense to hack around this locally in drivers and other
>> > > modules.
>> >
>> > If you see the warning in the original patch,
>> >
>> > https://lore.kernel.org/netdev/1562959401-19815-1-git-send-email-cai@lca.pw/
>> >
>> > GCC definitely optimize rx_frag_size  to be a constant while I just confirmed clang
>> > -O2 does not. The problem is that I have no clue about how to let GCC not to
>> > optimize a module parameter.
>> >
>> > Though, I have added a few people who might know more of compilers than myself.
>>
>> + Bill and James, who probably knows more than they'd like to about
>> __builtin_constant_p and more than other LLVM folks at this point.
>>
>> --
>> Thanks,
>> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
