Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E5C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6DC21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfEHJLI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:11:08 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41551 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfEHJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:11:08 -0400
Received: by mail-vs1-f66.google.com with SMTP id g187so12198664vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 02:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9zvqXQzn3SLsVtTH+qrWy/dpjXSSADrZyCG/zclGFrk=;
        b=OjXpJ7qUsFyNmGZmvDeOv2DQb8w1ZVfQQluSWpkuf2Ij1OGY6TxleVbhBnDqj54Cso
         ge8zGZ2EdRdVLmEmNabw8LD5m4iprp/Y1+qfHLwlGReLXUoBiML5ZDEwWDjWTkFqiuag
         Nc1YQEe2sKjnesEiYWM6gvxlEaEFVr2HlPpUXQZB+zrPM0XFFXlbDpXBsz3ntW95yfKB
         F9kM0D6v9uKFzq+ddixoNxT+2bQVgC34P83QJC6O5jc8iSxbHGyoMFlOPENNPTuYv+oC
         bsrLAaWWn0DAhW4/i1LhPQvWiD4loT2rhnb9M4RIjf3t43KQxvjrI892NZMlD8wS5pci
         9xJQ==
X-Gm-Message-State: APjAAAU/jxe+oXqIyTdyCYgAs0K67rrc1Y+rlchYy042HkK+uc1KKBZS
        y9Dg2YjRZUQiBetIjF0RfnDy9JPN10HNaALSci31ZfR2
X-Google-Smtp-Source: APXvYqxYeb5Azwgv1CuO52oUvy4D+Pb3NnsFkuzTzZ7jpSvPO6zuoR64XiNPduTANQ/xIpRLFKwi7OZpSBDcUBGZZQY=
X-Received: by 2002:a67:e2ca:: with SMTP id i10mr11629908vsm.96.1557306667170;
 Wed, 08 May 2019 02:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190507135233.31836-1-anders.roxell@linaro.org>
In-Reply-To: <20190507135233.31836-1-anders.roxell@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 May 2019 11:10:55 +0200
Message-ID: <CAMuHMdUEaNto48rxq_8=zx3+9cuMp4UxY=dL0TjbqYo=9dxB9A@mail.gmail.com>
Subject: Re: [PATCH] intel_th: msu: fix unused variables
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 3:53 PM Anders Roxell <anders.roxell@linaro.org> wrote:
> When building and CONFIG_X86 isn't set the compiler rightly complains
> about an unused varable 'i', see the warning below:
>
> ../drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_alloc’:
> ../drivers/hwtracing/intel_th/msu.c:783:21: warning: unused variable ‘i’ [-Wunused-variable]
>   int ret = -ENOMEM, i;
>                      ^
> ../drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_free’:
> ../drivers/hwtracing/intel_th/msu.c:863:6: warning: unused variable ‘i’ [-Wunused-variable]
>   int i;
>       ^
>
> Rework so that an else part is added where empty functions are created
> for set_memory_uc() and set_memory_wb(), in that way we could remove
> '#ifdef CONFIG_X86' in function msc_buffer_win_alloc() and
> msc_buffer_win_free().
>
> Fixes: ba39bd830605 ("intel_th: msu: Switch over to scatterlist")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for your patch!

> --- a/drivers/hwtracing/intel_th/msu.c
> +++ b/drivers/hwtracing/intel_th/msu.c
> @@ -21,6 +21,11 @@
>
>  #ifdef CONFIG_X86
>  #include <asm/set_memory.h>
> +#else
> +static void set_memory_uc(unsigned long addr, int numpages)

static inline?

> +{}
> +static void set_memory_wb(unsigned long addr, int numpages)

static inline?

> +{}
>  #endif

Regardless:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
