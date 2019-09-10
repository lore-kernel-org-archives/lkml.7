Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD54C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE18D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389731AbfIJMrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:47:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42142 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfIJMry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:47:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id c17so1167987qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 05:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2aOZwIpJYg0wrZBHZwlKVNN/aFyBwqzNH9mtG3DpyY=;
        b=lYHuv7kfrgq2BMyeLOTG7D1r+QqDfDmPeN9HKboQZgUSLj+xeRdsrE5PAj39EsJIkX
         BSjc+nzv34KxcMNK1x7SCveB10NraQSVYYere33PmlPCv3CBVjySdXXbXcSM+R9BG1SM
         V7aSk+/u2Jy4+ma6DlFOCBQmTWVJFIkwZ6eIRpzdvOgbdhvSUd8M48Oe2KhX07O4Rnke
         nhKxayVOoWSC5RFPxHgBRVECSSf9hD3YIh3sjMblL172A4cwwMI3Te+Y9PbOWuJ1FroP
         A4i5DkTn2m9o78v27N0ytWQ21dFQvsVCryWhafLl0Ut2MxKpd/7Kn46UrCZJcfSHxR7B
         MzNQ==
X-Gm-Message-State: APjAAAVsl/6r4pv3tTz9rEgY7eov5xHRcF4ccH6deG5Wi0bjtUxz5XOr
        HQ5AbsasFHr2nSW92+BEBORB751cqtUN9emSLsM=
X-Google-Smtp-Source: APXvYqznXUFZ3cbiRcxFCQDTt85IB1hndwLHj3VmvaGuGlinKGqHNOp5Q1RTECt6q9UqMpDXOroaG2jyB3JaTCf5z2A=
X-Received: by 2002:ac8:32ec:: with SMTP id a41mr28491816qtb.18.1568119672229;
 Tue, 10 Sep 2019 05:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190708151555.8070-1-efremov@linux.com> <10d12447-7b67-466e-5ab3-3d28256f0621@linux.com>
In-Reply-To: <10d12447-7b67-466e-5ab3-3d28256f0621@linux.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Sep 2019 14:47:36 +0200
Message-ID: <CAK8P3a1A1nC53BceMJG6zLzC0cqbcuvnSy9nqYv2OHO8KBjbRw@mail.gmail.com>
Subject: Re: [PATCH] lib/lz4: remove the exporting of LZ4HC_setExternalDict
To:     Denis Efremov <efremov@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Bongkyu Kim <bongkyu.kim@lge.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 2:13 PM Denis Efremov <efremov@linux.com> wrote:
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

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

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

Right, this version is better than mine.

      Arnd
