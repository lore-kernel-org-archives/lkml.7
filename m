Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C302C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394B520663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfLJIJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:09:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46632 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfLJIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:09:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id a124so8951104oii.13;
        Tue, 10 Dec 2019 00:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npgnC/M6weBM9U5t1QrqcgCAOt54Yrn9ohY0tdJFDi8=;
        b=imJ8gBKuldqCO7Nt0OP4JEBiipOJhRi0phkd8kGYDAA2hWgoT88e0yhQnZhSeq0J8E
         UdpfuW7emxP1usvpipAgT/BwtSa4r7iLJlL5eujmC1jpjpYmo/WRDSjzxOylYQaGi2jq
         OOsx6I8zW9oe52m828YLltCV/kfKBbBMU2NQIYbB4d6AoihwVkah8prCc3X2NfWY5XMn
         jw8JC/KR2Jj6be9JPoxSjsVQW9N+PtYz+eoaBS/vL8FtQULDzPu3VFGNfqKV51zZRQHh
         0vr59zJ/ZUGBoKN3jtXkK15ZQMEwPbKQd80da8OEj87cmLtw6DnyW1PEKZMbn4hBaJ35
         YuuQ==
X-Gm-Message-State: APjAAAVhf6CtBX7vJD3MWf+HhCo86ngoVEFMqzhZLtFA/J4VFzo+qDjI
        mO9qjLD4SH78D0HPq8Sbx2Ic8VIWp71Tg+CM/QQ=
X-Google-Smtp-Source: APXvYqxthoIVKKXeDcIl+kjD/s7TOweZAhxqeclY/aSRjGjlnUdM+wcDbbO+6eJiAsPK2NeG1dQiyb6ihCqUsltEqqA=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr3035210oia.102.1575965356727;
 Tue, 10 Dec 2019 00:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20191209222956.239798-1-ndesaulniers@google.com> <20191209222956.239798-2-ndesaulniers@google.com>
In-Reply-To: <20191209222956.239798-2-ndesaulniers@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 09:09:05 +0100
Message-ID: <CAMuHMdUO=cZMsFx4t_uULNRuwnGLjbRYOJAo7j5gC-iSV3wy5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] hexagon: define ioremap_uc
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bcain@codeaurora.org, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ztuowen@gmail.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, alexios.zavras@intel.com,
        Allison Randal <allison@lohutok.net>,
        Will Deacon <will@kernel.org>, rfontana@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 11:30 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Similar to
> commit 38e45d81d14e ("sparc64: implement ioremap_uc")
> define ioremap_uc for hexagon to avoid errors from
> -Wimplicit-function-definition.
>
> Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
> Link: https://github.com/ClangBuiltLinux/linux/issues/797
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/hexagon/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> index 539e3efcf39c..b0dbc3473172 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -173,6 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
>
>  void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
>  #define ioremap_nocache ioremap
> +#define ioremap_uc(X, Y) ioremap((X), (Y))

Do we really need this? There is only one user of ioremap_uc(), which
Christoph is trying hard to get rid of, and the new devres helper that
triggers all of this :-(
https://lore.kernel.org/dri-devel/20191112105507.GA7122@lst.de/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
