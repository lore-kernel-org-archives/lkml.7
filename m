Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FB5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235C1206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfLJIJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:09:51 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35719 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfLJIJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:09:50 -0500
Received: by mail-ot1-f68.google.com with SMTP id o9so14758937ote.2;
        Tue, 10 Dec 2019 00:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGZeZcjQTLU2zQCTpbiTGx9ss8zli/3jjKod1Govw4s=;
        b=f6kWt518mrCTY+3vTFFGgxT7OkiRnpb4RBKYc6mkgoQtcrpN9hPD/oXLWa2SJERlJG
         weEAIGn+Wdsd4iBqOS8P6hhrx6qWmY+eX3ztmhWRDtvRfFDK5vv2aoinPwhiWyoXQAmF
         mF1yisYdqapB6pq/1asGiagOqa65x0xaps/M0L5iGAs1Gcxpr0Krcrhn747/ZuG2Ga9Y
         MIK2UYfDza4HNmpVrj+z2PySVZ7glvjLTqYESRsAAmHMNA79Pe73xuFyY3iPwFTU4wfG
         15Od88DJrAmmrvIwYiQ7n/yo+68/Vv5Dwlr2s7pdbKRd/431hL7+XI+d8R5KD/mTC501
         GR0A==
X-Gm-Message-State: APjAAAUNdG/z+BKdrbOjjDA9FcRQOHJsS5v9BAU/eC3T/PDbJiorFBFE
        35wx2MEK93l0oIsigsE+/fxD1MPiRkwgXRzeKyA=
X-Google-Smtp-Source: APXvYqzab4wGE6gtc+gI6DLVQsgBMXCSKx3441zfxkYGZfA8f+kNUT7FaIWvNrdR/enSyC+Lk6+T4Y69JX4XqTFiz8s=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr17111711ots.250.1575965389648;
 Tue, 10 Dec 2019 00:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20191204133328.18668-1-linux@roeck-us.net>
In-Reply-To: <20191204133328.18668-1-linux@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 09:09:38 +0100
Message-ID: <CAMuHMdXwJUzuSNS7CBpU5J6ofOZGrWMStJU9VaT2gp3m5U5=Lw@mail.gmail.com>
Subject: Re: [PATCH] hexagon: io: Define ioremap_uc to fix build error
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Brian Cain <bcain@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tuowen Zhao <ztuowen@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 2:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
> ioremap_uc is now mandatory.
>
> lib/devres.c:44:3: error: implicit declaration of function 'ioremap_uc'
>
> Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
> Cc: Tuowen Zhao <ztuowen@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/hexagon/include/asm/io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> index 539e3efcf39c..39e5605c5d42 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -173,7 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
>
>  void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
>  #define ioremap_nocache ioremap
> -
> +#define ioremap_uc ioremap
>
>  #define __raw_writel writel

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
