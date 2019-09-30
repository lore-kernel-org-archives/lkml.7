Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922CCC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254D321855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OTlCHB7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfI3KJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:09:18 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:54024 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfI3KJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:09:18 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x8UA9DMs010492;
        Mon, 30 Sep 2019 19:09:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x8UA9DMs010492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569838154;
        bh=iaDDjC8hHZpVFgq2CJOu6EYHGdxV8rPxTu4uf6BUBog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OTlCHB7lO+DstBFqU5d2cY94CAPzLxbpP99N7Beo9QK623Oop++YX2Z1nrOXAvY5Q
         nmiys7rcClh9waPuh/CCVLNSpJ3mpCqg9+SqI3LXLInm1Yf70HT/aWjuWYB+mZ89kX
         wUWMDNmWDWe75a+C8w/Gnzd0XzCgiq9FAE49zqlwLMZZZ1rAbG8h5a/iewHdujXpy0
         nJCnJ0aqNgmeR8DSRKXGVaz1wAGVaXco5r9KP/KGapT0kR83RuFhAQaZgg0Ah9qg6n
         zttFTA9HCeFvHvVfcCHQT4E/Q/uGXV5YbWkuAj/1ctDDf7bmpR21q2B9xuBW1DMZNd
         jJZlbufu6BcMg==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id k24so3951576uag.10;
        Mon, 30 Sep 2019 03:09:14 -0700 (PDT)
X-Gm-Message-State: APjAAAVMBYGC0vT7oB69FKgyMYdzM8Mq3LJyv/keAlY2U90GZrDfMqFd
        Pye3at6wMKB5g2jJRnoUAyaoKQqA0OulLqKGicQ=
X-Google-Smtp-Source: APXvYqyZJJCYX3hmXFimzZ2U79EXnnP54ieVt9Stvz2IMg9sMJn5C60iZr+yfiNH8QyoZTpacNn9efknNCXvfY7r6E8=
X-Received: by 2002:ab0:6355:: with SMTP id f21mr522856uap.40.1569838152792;
 Mon, 30 Sep 2019 03:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190723113036.14576-1-yamada.masahiro@socionext.com> <87o91fpp29.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87o91fpp29.wl-ysato@users.sourceforge.jp>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 30 Sep 2019 19:08:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATpUhRiYy_f9FaAVRhMR-h2anoA8Z46soenxGw1saC4Ug@mail.gmail.com>
Message-ID: <CAK7LNATpUhRiYy_f9FaAVRhMR-h2anoA8Z46soenxGw1saC4Ug@mail.gmail.com>
Subject: Re: [PATCH] sh: remove unneeded uapi asm-generic wrappers
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sato-san,

On Sat, Jul 27, 2019 at 10:47 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
> On Tue, 23 Jul 2019 20:30:36 +0900,
> Masahiro Yamada wrote:
> >
> > These are listed in include/uapi/asm-generic/Kbuild, so Kbuild will
> > automatically generate them.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/sh/include/uapi/asm/setup.h | 2 --
> >  arch/sh/include/uapi/asm/types.h | 2 --
> >  2 files changed, 4 deletions(-)
> >  delete mode 100644 arch/sh/include/uapi/asm/setup.h
> >  delete mode 100644 arch/sh/include/uapi/asm/types.h
> >
> > diff --git a/arch/sh/include/uapi/asm/setup.h b/arch/sh/include/uapi/asm/setup.h
> > deleted file mode 100644
> > index 4bd19f80f9b0..000000000000
> > --- a/arch/sh/include/uapi/asm/setup.h
> > +++ /dev/null
> > @@ -1,2 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > -#include <asm-generic/setup.h>
> > diff --git a/arch/sh/include/uapi/asm/types.h b/arch/sh/include/uapi/asm/types.h
> > deleted file mode 100644
> > index 68100e108ea6..000000000000
> > --- a/arch/sh/include/uapi/asm/types.h
> > +++ /dev/null
> > @@ -1,2 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > -#include <asm-generic/types.h>
> > --
> > 2.17.1
> >
>
> Applied sh-next.
> Thanks.
>
> --
> Yosinori Sato


I think you have not sent pull requests for sh or h8300.
Would you send ones in this MW?

-- 
Best Regards
Masahiro Yamada
