Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B221C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47522206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLJIpr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:45:47 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46936 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfLJIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:45:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id g18so14766826otj.13;
        Tue, 10 Dec 2019 00:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gu9XcTljjRQf7hRb8/Mhf5hwSbDp/VoOA2gAk6H+H+Q=;
        b=FG5T8bpUugqi1vwtL8ZXNXg/faXNxuT0wAV7AJj+pVCDqtNO6Xh4DyTkUttfQO8SDN
         XuAd2ccf27waOfXV6yiMmugJyELMQMlMiMX+2fLay2gRhxwA7HWu4/rj+4NUM9tYCiRF
         npAifmQht3BjYcudZfbdiCnjA+W69wiG/cVKUURyO44zV54p1d9fb7xqzS+TnFm+inQu
         0b3b/VCESSMf7RlWENtgmTmFBsZFHYMFMQNuCTuSTMdLoQDPLst1Ab4oMpYTl0WS8IDG
         NHhBv/VRO2tVkWg4wNOG606g+LaPO+uxefM7D6OYFyg6ff+qin6cVFoPHwue877lo5x6
         9yhg==
X-Gm-Message-State: APjAAAVdxcO8HgzvIlOBEfOIQNLrkFI7sdg2SZNxgMrZpK2S2byhQGMG
        IwtcWlbMMkHtfZOa+cbRVJNQhP0dNXUuhL/bcGY=
X-Google-Smtp-Source: APXvYqwr5SQmZAWza7zJ7Atdb9MhYfJIuarcaSpvfba+QWrG34fJ6MQk6AeLc7aZqDjffLly9ww2kZAuvH8NC0hX6Es=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr20205715otm.297.1575967546178;
 Tue, 10 Dec 2019 00:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20191204133328.18668-1-linux@roeck-us.net> <CAMuHMdXwJUzuSNS7CBpU5J6ofOZGrWMStJU9VaT2gp3m5U5=Lw@mail.gmail.com>
 <42cb2e14-a2d7-8e53-509f-da201f0624a0@roeck-us.net>
In-Reply-To: <42cb2e14-a2d7-8e53-509f-da201f0624a0@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 09:45:35 +0100
Message-ID: <CAMuHMdW=aFS8qm+=cwTciNBkHmbp5f7S8PVhus7E3MEoJT-qkw@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Tue, Dec 10, 2019 at 9:23 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 12/10/19 12:09 AM, Geert Uytterhoeven wrote:
> > On Wed, Dec 4, 2019 at 2:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >> ioremap_uc is now mandatory.
> >>
> >> lib/devres.c:44:3: error: implicit declaration of function 'ioremap_uc'
> >>
> >> Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
> >> Cc: Tuowen Zhao <ztuowen@gmail.com>
> >> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Cc: Luis Chamberlain <mcgrof@kernel.org>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >>   arch/hexagon/include/asm/io.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> >> index 539e3efcf39c..39e5605c5d42 100644
> >> --- a/arch/hexagon/include/asm/io.h
> >> +++ b/arch/hexagon/include/asm/io.h
> >> @@ -173,7 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
> >>
> >>   void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
> >>   #define ioremap_nocache ioremap
> >> -
> >> +#define ioremap_uc ioremap
> >>
> >>   #define __raw_writel writel
> >
> > Do we really need this? There is only one user of ioremap_uc(), which
> > Christoph is trying hard to get rid of, and the new devres helper that
> > triggers all of this :-(
> > https://lore.kernel.org/dri-devel/20191112105507.GA7122@lst.de/
>
> One may ask why we needed a devres helper in the first place if there
> is indeed just one user.

Because of the new second user, which jumped on the devres train...
a8ff78f7f773142e ("mfd: intel-lpss: Use devm_ioremap_uc for MMIO").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
