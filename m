Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB371C32750
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0569206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZUNVjOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfHLRvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:51:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42218 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLRvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:51:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so8627640wrq.9;
        Mon, 12 Aug 2019 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z+y0C86lIYFqkc13B1ZVf/z3tXXKI/4p8OSUCocFgOs=;
        b=nZUNVjOg2d0QuJzusHNui0cXDqbVVlkxIbCsmKs77PTYxhTBSdMDrOK3GG0CAEEJqX
         lTZ5d2jDsnPHddZ6HoqdxEC4zM+Y/4hSzT7FlYlYJp3AeMrb8FD7f3bMgy2Fph2gunsa
         vQYqbVPr4Um0EdigE7fTrE0DxJsnpkB7sb7VBcvLU5sOrUtLkoWD+b2bojTgqdVOzLST
         1V8v7dbOx8DnA/C2eJ0SGH9WL7FQ4txv+37K3nTJwpTtC9eIVE1h37FfxdsnAMXLluW2
         MaL8QNq3Ck0faY7ygXIvrpOLOvONfc+axTJlPPnOsQuUv7Xix3eg3HhgnpR/CBEJP29U
         H8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z+y0C86lIYFqkc13B1ZVf/z3tXXKI/4p8OSUCocFgOs=;
        b=b2425GXNFMUiViPHUPTMQFmlYMGxjyx9p7aYZwTqiR95RZ/0yAv3iO50zGCbv7RSGi
         kTewJDqH6E+s8/qYK7X8dHsWQ8T6TmcaCAW7B60naPDyxyMZUUiSM+z+CokbpBV0fy78
         8tiFeAh7ZhNTOo+LysmZ0NzkVZFpjzqER0uuppXLtny9i0gq2IoH/YHy3l6M2VzohNht
         LAPzB87QU+uMvHZLdoTeUCtfoyidVsxmcfuwXIpVwbjDGHU2emvela6ofk3y38KSlxz/
         DZLkeMwkzoZMjSlAsjvC60+FfCLq7CBdyvLWA8WoyNqLkqlz8nX85Pc2tCP+dbyAgYbP
         aSew==
X-Gm-Message-State: APjAAAWnW40mELp+cRyt/ouKxPYxnOn6cZAw14ZR1LVPytGIbd9So82h
        5eQHodRYu08xx2hB2iJgFsc=
X-Google-Smtp-Source: APXvYqzKmbRVSr5Qasd/bMq7TfGqhs1XGOA1tpd3PddlR/Vxgy8nlBh0WFBMr01sZD4dJPQ4j54aHg==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr31494739wrw.169.1565631959424;
        Mon, 12 Aug 2019 10:45:59 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id l15sm17734393wrq.64.2019.08.12.10.45.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 10:45:59 -0700 (PDT)
Date:   Mon, 12 Aug 2019 10:45:57 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Werner Koch <wk@gnupg.org>
Subject: Re: [PATCH 4/5] lib/mpi: Fix for building for MIPS64 with Clang
Message-ID: <20190812174557.GA14197@archlinux-threadripper>
References: <20190812033120.43013-1-natechancellor@gmail.com>
 <20190812033120.43013-5-natechancellor@gmail.com>
 <CAKwvOd=BYmsExYeOQmuEJ-Yybgqd_22vQ_WwU0jEXTXAaKpQVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=BYmsExYeOQmuEJ-Yybgqd_22vQ_WwU0jEXTXAaKpQVw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:42:31AM -0700, Nick Desaulniers wrote:
> On Sun, Aug 11, 2019 at 8:31 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > From: Werner Koch <wk@gnupg.org>
> >
> > * mpi/longlong.h [MIPS64][__clang__]: Use the C version like we
> > already do for 32 bit MIPS
> >
> > clang errors:
> >
> > lib/mpi/generic_mpih-mul1.c:37:24: error: invalid use of a cast in a
> > inline asm context requiring an l-value: remove the cast or build with
> > -fheinous-gnu-extensions
> 
> Reminds me of:
> https://github.com/ClangBuiltLinux/linux/commit/7b7c1df2883dd4393592859758c3e76207da8b1d
> 
> >                 umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
> >                 ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > lib/mpi/longlong.h:652:20: note: expanded from macro 'umul_ppmm'
> >         : "=l" ((USItype)(w0)), \
> >                 ~~~~~~~~~~^~~
> > lib/mpi/generic_mpih-mul1.c:37:3: error: invalid output constraint '=h'
> > in asm
> >                 umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
> >                 ^
> > lib/mpi/longlong.h:653:7: note: expanded from macro 'umul_ppmm'
> >              "=h" ((USItype)(w1)) \
> >              ^
> > 2 errors generated.
> >
> > Fixes: 5ce3e312ec5c ("crypto: GnuPG based MPI lib - header files (part 2)")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/605
> > Link: https://github.com/gpg/libgcrypt/commit/e7ae0ae243c8978a67c802169183187d88557be8
> > Signed-off-by: Werner Koch <wk@gnupg.org>
> > [nc: Added build error and tags to commit message
> >      Modified subject line
> >      Removed GnuPG-bug-id
> >      Removed space between defined and (__clang__)]
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  lib/mpi/longlong.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
> > index 8a1507fc94dd..5636e6a09f7a 100644
> > --- a/lib/mpi/longlong.h
> > +++ b/lib/mpi/longlong.h
> > @@ -688,7 +688,8 @@ do {                                                                        \
> >                  : "d" ((UDItype)(u)),                                  \
> >                    "d" ((UDItype)(v)));                                 \
> >  } while (0)
> > -#elif (__GNUC__ >= 5) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 4)
> > +#elif defined(__clang__) || (__GNUC__ >= 5) || (__GNUC__ == 4 && \
> > +                                               __GNUC_MINOR__ >= 4)
> 
> So the minimum supported version of GCC to build the kernel is
> currently 4.6, so we can clean up a lot more here.  I'd remove the
> check, and delete the #elif and #else implementations.
> 

Sure, I will dig into this further and send a v2.

Thanks for the review,
Nathan

> >  #define umul_ppmm(w1, w0, u, v) \
> >  do {                                                                   \
> >         typedef unsigned int __ll_UTItype __attribute__((mode(TI)));    \
> > --
> > 2.23.0.rc2
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
