Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC02C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1909F20657
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfHEHO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:14:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39003 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfHEHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:14:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so30070095wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 00:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeNejt0zLzN492QJi1mkWun4jhRVeId9uvP6YFvkE6Y=;
        b=A03eHU+EOAsZUSk+QjHXnMNBdv5LrvWG1nr8aj4UZxZBSMnubDNsrWtQNLrZVMk9sr
         X1BVegxcs9VHyGe8BeJ+2M3tqUfeOiN9H1Xn8ftlwlFUF3sEokHv0+TtduLa4WhjbYb1
         zdx+FyBF0v+yFyDyCkm674oVIyLhXfTLNKAcsu1O9SIdwkJQ7EpyJQlQBDOAehrW0bF+
         OaRvb55yOtJ8hnf8kkAt9cm12TdS1nAtLTRcejRgufAcB8RNNNN2OufNt8sYC68cSShg
         lt1f4PFlanFODX0vC91qSor641jaXLk6GiGC3QOP34RHN1KFeiS2jakGCtVUFSGgkeNp
         9UQQ==
X-Gm-Message-State: APjAAAW+GhHR2N8WtFq6gNbeExsp4m0Snf5wGgz+S2xULulFjVxG1ZHY
        9NWPKROZ7q0AdwXBhc50V8QXAYOprBoVOinNBvQ=
X-Google-Smtp-Source: APXvYqyJHbNNeU9LWJXXQV6T4TnyUcPVnQN15PKjItyX2mnuqMbukNeaNn3MFVC/NEqzIIcH18naTf92+jSdshgM/NI=
X-Received: by 2002:a5d:630c:: with SMTP id i12mr20079707wru.312.1564989296014;
 Mon, 05 Aug 2019 00:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <9ec2190f5be1c4e676a803901200364578662b6d.1564704625.git.fthain@telegraphics.com.au>
 <fd5ccd89-987a-3d4b-5c49-9068abadf81d@linux-m68k.org>
In-Reply-To: <fd5ccd89-987a-3d4b-5c49-9068abadf81d@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Aug 2019 09:14:42 +0200
Message-ID: <CAMuHMdW=cPipS6pmxAtU6r1MaVaPWfhGQ-AAe0E-TJGbXftHfA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Prevent some compiler warnings in coldfire builds
To:     Greg Ungerer <gregungerer00@gmail.com>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, Aug 3, 2019 at 1:36 AM Greg Ungerer <gregungerer00@gmail.com> wrote:
> On 2/8/19 10:10 am, Finn Thain wrote:
> > Since commit d3b41b6bb49e ("m68k: Dispatch nvram_ops calls to Atari or
> > Mac functions"), Coldfire builds generate compiler warnings due to the
> > unconditional inclusion of asm/atarihw.h and asm/macintosh.h.
> >
> > The inclusion of asm/atarihw.h causes warnings like this:
> >
> > In file included from ./arch/m68k/include/asm/atarihw.h:25:0,
> >                   from arch/m68k/kernel/setup_mm.c:41,
> >                   from arch/m68k/kernel/setup.c:3:
> > ./arch/m68k/include/asm/raw_io.h:39:0: warning: "__raw_readb" redefined
> >   #define __raw_readb in_8
> >
> > In file included from ./arch/m68k/include/asm/io.h:6:0,
> >                   from arch/m68k/kernel/setup_mm.c:36,
> >                   from arch/m68k/kernel/setup.c:3:
> > ./arch/m68k/include/asm/io_no.h:16:0: note: this is the location of the previous definition
> >   #define __raw_readb(addr) \
> > ...
> >
> > This issue is resolved by dropping the asm/raw_io.h include. It turns out
> > that asm/io_mm.h already includes that header file.
> >
> > Moving the relevant macro definitions helps to clarify this dependency
> > and make it safe to include asm/atarihw.h.
> >
> > The other warnings look like this:
> >
> > In file included from arch/m68k/kernel/setup_mm.c:48:0,
> >                   from arch/m68k/kernel/setup.c:3:
> > ./arch/m68k/include/asm/macintosh.h:19:35: warning: 'struct irq_data' declared inside parameter list will not be visible outside of this definition or declaration
> >   extern void mac_irq_enable(struct irq_data *data);
> >                                     ^~~~~~~~
> > ...
> >
> > This issue is resolved by adding the missing linux/irq.h include.
> >
> > Cc: Michael Schmitz <schmitzmic@gmail.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

>
> Looks good to me:
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>
> Geert: I can take this via the m68knommu tree if you like?
> Or if you want to pick it up then no problem.

If you have fixes for m68knommu for v5.3, feel free to queue it.
Else I can queue it for v5.4.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
