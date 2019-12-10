Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3430C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0180206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLJIIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:08:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44514 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfLJIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:08:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id x3so14700533oto.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQwa9N8LTZYgjM9k+EUZaR7NvHYPKaNCkbh+vO0JmUY=;
        b=uEcu6lXpXKn0pEvHz4yY+5BikYXEhb7OQztM7Fp/0hYP1ertkZm3n6AFb2kJ/omFgV
         hvXG4mVkkWTxlDH2Jku98cXB6hU7Wizh0tKoNRaHf3gf7Hsc/e48XgrP9e7kndEViJaO
         8f9GcL0zwxobwXwT2dcuAVDHn9yT/CEmDQpwc8cmBPAyzr2lib1DSYwCIYw6hGt2yPSI
         AXSoPPAQ+7oMGl8BImMO2/6mcKPtapZ2Oojj39eDywquHS6jlZp2IIR9pDGxCL5/FL4o
         dm9nini6YVfrilguRQEX9x9jePcmcWXOaU0mqtGsTZyFD/KCQYSJym+LQ43rBLt6W9qp
         v6vg==
X-Gm-Message-State: APjAAAWgPWFJEQGN6Z/+m89e/pdf7ZfIqjf7LDLDZFacIluEhM6JTp9T
        3JyYbTvRfBbAJl2Z6Wygjcwpgj2WTTw696ed9U3u79/K
X-Google-Smtp-Source: APXvYqx81ffZFccEasStMDHRrT0HswHf5LTZ+WSeYy0xvTNJvyxs6ulcodPwTgdqRd+IzZBRon8IS7LomGjdpKgrqXU=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr20120039otm.297.1575965334424;
 Tue, 10 Dec 2019 00:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20191016210629.1005086-1-ztuowen@gmail.com> <20191016210629.1005086-2-ztuowen@gmail.com>
In-Reply-To: <20191016210629.1005086-2-ztuowen@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 09:08:42 +0100
Message-ID: <CAMuHMdUsKQPvOwxARcWMqmFB7BdatZe=3bR+BG=DCaq_yMfySw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] sparc64: implement ioremap_uc
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        acelan.kao@canonical.com, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        kbuild test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 7:47 PM Tuowen Zhao <ztuowen@gmail.com> wrote:
> On sparc64, the whole physical IO address space is accessible using
> physically addressed loads and stores. *_uc does nothing like the
> others.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> ---
>  arch/sparc/include/asm/io_64.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
> index 688911051b44..f4afa301954a 100644
> --- a/arch/sparc/include/asm/io_64.h
> +++ b/arch/sparc/include/asm/io_64.h
> @@ -407,6 +407,7 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>  }
>
>  #define ioremap_nocache(X,Y)           ioremap((X),(Y))
> +#define ioremap_uc(X,Y)                        ioremap((X),(Y))
>  #define ioremap_wc(X,Y)                        ioremap((X),(Y))
>  #define ioremap_wt(X,Y)                        ioremap((X),(Y))

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
