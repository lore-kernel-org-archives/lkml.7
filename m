Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F34C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E65120872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GBqkAOcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfIJMRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:17:11 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:53203 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731146AbfIJMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:17:11 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x8ACGxH2004523
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 21:17:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x8ACGxH2004523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568117820;
        bh=iT2EreQCQsjv1Yh12XOUi9gW7uCgo2uG/uTgJoEFfD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GBqkAOcJ6HIYqenv16F8cDQwySHEyWCoWIwH4/jVyBb8sC5woUQ1BQuX1lS3TgvI3
         KgUxcv6pPocxNIOUnwXndKZ7AR4Y36iFB/ngUbOqUiYV5KVobHK2Ev6hZeQB+Sji0O
         zsII9UQfclt9e5GtpNM0smxTQc7TT+80b5upeUhHNiLcjr90tFj2Noy/ESeeQaY9pC
         Lutm5tOBsSIdjEeuP72YP4sQuo+oyM84CEsnJAMYUi/qlaGzWJu4APYMwUsxCj3ina
         Wp+fhKG2mBYfbCxs2pCXksUYvoZLUUhbDE+Rzo71Cy3pJX/1q6bE6aScAxMpTBO9iL
         5QXY+P9qnYshA==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id t136so3480491vkt.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 05:17:00 -0700 (PDT)
X-Gm-Message-State: APjAAAVfU3WrhMhvI6LC0vJB0U+2HvemDY8TM4sjNUbpdZI+OkdkbzCL
        5S8PSn6tbYd9P2v6KXfqygqd3uakgvPDYWTlocI=
X-Google-Smtp-Source: APXvYqzyZxpGt34EHqWcBbslD4XPNv3zm9CpxfRmuWCNG0T5g2OpZkt0F40xcCsU/m2XnN3MYSs+uWvw7V/EpxpfwJ8=
X-Received: by 2002:a1f:9091:: with SMTP id s139mr13597058vkd.64.1568117818896;
 Tue, 10 Sep 2019 05:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190708151555.8070-1-efremov@linux.com> <10d12447-7b67-466e-5ab3-3d28256f0621@linux.com>
In-Reply-To: <10d12447-7b67-466e-5ab3-3d28256f0621@linux.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 10 Sep 2019 21:16:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkQBM1cbcCtYDPtcVrXmvd4j8C5c5Va4qwnJ_KXrAZ0g@mail.gmail.com>
Message-ID: <CAK7LNAQkQBM1cbcCtYDPtcVrXmvd4j8C5c5Va4qwnJ_KXrAZ0g@mail.gmail.com>
Subject: Re: [PATCH] lib/lz4: remove the exporting of LZ4HC_setExternalDict
To:     Denis Efremov <efremov@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Bongkyu Kim <bongkyu.kim@lge.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 9:13 PM Denis Efremov <efremov@linux.com> wrote:
>
> +Cc: Andrew Morton <akpm@linux-foundation.org>,
>      Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Hi,
>
> On 7/8/19 6:15 PM, Denis Efremov wrote:
> > The function LZ4HC_setExternalDict is declared static and marked
> > EXPORT_SYMBOL, which is at best an odd combination. Because the function
> > is not used outside of the lib/lz4/lz4hc_compress.c file it is defined in,
> > this commit removes the EXPORT_SYMBOL() marking.
> >
> > Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> > ---
> >  lib/lz4/lz4hc_compress.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
> > index 176f03b83e56..1b61d874e337 100644
> > --- a/lib/lz4/lz4hc_compress.c
> > +++ b/lib/lz4/lz4hc_compress.c
> > @@ -663,7 +663,6 @@ static void LZ4HC_setExternalDict(
> >       /* match referencing will resume from there */
> >       ctxPtr->nextToUpdate = ctxPtr->dictLimit;
> >  }
> > -EXPORT_SYMBOL(LZ4HC_setExternalDict);
> >
> >  static int LZ4_compressHC_continue_generic(
> >       LZ4_streamHC_t *LZ4_streamHCPtr,
> >
>
> Andrew, could you please look at this patch and accept it if everybody agrees?
> static LZ4HC_setExternalDict will trigger a warning after this check
> will be in tree https://lkml.org/lkml/2019/7/14/118
>
> There is also a different fix by Arnd Bergmann with making this function non-static:
> https://lkml.org/lkml/2019/9/6/669
>
> But since there is no uses of this EXPORT_SYMBOL in kernel and LZ4HC_setExternalDict
> is indeed static in the original library https://github.com/lz4/lz4/blob/dev/lib/lz4hc.c#L1054
> we came to the conclusion that it will be better to simply unexport the symbol.
>
> Thanks,
> Denis



-- 
Best Regards
Masahiro Yamada
