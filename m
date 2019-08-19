Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5772DC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288822070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="E4BNM2p/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfHSEhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:37:07 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:48130 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSEhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:37:05 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x7J4apVX023610;
        Mon, 19 Aug 2019 13:36:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x7J4apVX023610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566189412;
        bh=92O1pFReptltud0H5j530dBG+Ho3Yo+hz2c5cCYEwYY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E4BNM2p/a0lvhptox5aS626n/uqm4oFpqQlwNJXZZpMIBKTMbbeZuFvyk3ZuKd9Ix
         ZTiHxv1XE8aH3jZzmsFfHkpdPoqflbFt/NEM/xvUMNdr3Jwic+NmWQ/jxc+gLJW9qx
         GoE/Vfpf6DU7oEM+P+n/wMJPIpaGggpxIUNRcpTYlXAHwcR+MrSTCCfso84jb9L4n3
         Kz3lLJOg5raysC3ryNgVw15rLdT8x0NMFynN+bOqCHopw036s2hcL/eue/zRPl3Yy0
         S4xLvSBvoCvKPa1Zui0BXnFuzx5T9a016PJqIu/72Iz4AAXqGHcuiSPQ6q+Y9qLyzE
         9i7p0n+79LQPQ==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id j21so195206uap.2;
        Sun, 18 Aug 2019 21:36:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVpMttBn1Cb4vLd0WA+LJsG/TH1QIYGClTILU+uwNz4Jf95ge01
        22lItCh6ZbqQOOoEeiA9OcOiw3JDr6iPJecjhI8=
X-Google-Smtp-Source: APXvYqzxv6FoJWVgfO/JQFAnDKIT3YPH9cijYI+soh1aReHi9LTjxSce9ZlMxE89kupNwhGFNJaGx/GIP++DDRDsmeo=
X-Received: by 2002:ab0:6608:: with SMTP id r8mr12223136uam.25.1566189411225;
 Sun, 18 Aug 2019 21:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190617162123.24920-1-yamada.masahiro@socionext.com> <CAK7LNATtqhxPcDneW0QOkw-5NyPNP06Qv0bYTe7A_gCiHMiU7A@mail.gmail.com>
In-Reply-To: <CAK7LNATtqhxPcDneW0QOkw-5NyPNP06Qv0bYTe7A_gCiHMiU7A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 19 Aug 2019 13:36:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMwqy0ZUZ=kTJ7MJ6OJNa=+vbj5444xzmubJ8+6vO=sg@mail.gmail.com>
Message-ID: <CAK7LNASMwqy0ZUZ=kTJ7MJ6OJNa=+vbj5444xzmubJ8+6vO=sg@mail.gmail.com>
Subject: Re: [PATCH] libfdt: reduce the number of headers included from libfdt_env.h
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 11:30 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Tue, Jun 18, 2019 at 1:21 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Currently, libfdt_env.h includes <linux/kernel.h> just for INT_MAX.
> >
> > <linux/kernel.h> pulls in a lots of broat.
> >
> > Thanks to commit 54d50897d544 ("linux/kernel.h: split *_MAX and *_MIN
> > macros into <linux/limits.h>"), <linux/kernel.h> can be replaced with
> > <linux/limits.h>.
> >
> > This saves including dozens of headers.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
>
> ping?

ping x2.




>
>
> >  include/linux/libfdt_env.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
> > index edb0f0c30904..2231eb855e8f 100644
> > --- a/include/linux/libfdt_env.h
> > +++ b/include/linux/libfdt_env.h
> > @@ -2,7 +2,7 @@
> >  #ifndef LIBFDT_ENV_H
> >  #define LIBFDT_ENV_H
> >
> > -#include <linux/kernel.h>      /* For INT_MAX */
> > +#include <linux/limits.h>      /* For INT_MAX */
> >  #include <linux/string.h>
> >
> >  #include <asm/byteorder.h>
> > --
> > 2.17.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
