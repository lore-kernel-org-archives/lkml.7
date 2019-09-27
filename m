Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841E4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D3520673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfI0Mnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:43:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42552 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0Mnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:43:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so2083260otd.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+augSSgNJssXtFfz6W9A1hC0ETAojLriMrB6ZOTBGE=;
        b=Oe7XAC9IfvuMxcMJ+xk4hDokZTeK8PUSXyziwHCppZ/FVvj9WLYA2lmhYX1B/oVUYD
         fjSNBOr0HtD1eD79Ik2pv6LpKTYbenm5xXk0P7wFYrVXzJArXhUgPv4Ae9mNZZouBDOH
         AvmCtjGf1f0NAMWvMJBmGkfCaDx/ZhUErr5j+7iNdhWynTpPaK6FdNoPg3fbFqHF8UvK
         I5C9ghta/cZrJ0ioPytzab+EfouUeh6ehJmVQ9/PeYwIT0j4qqmzt6+p5H3dqM8Z6ATa
         ujVXqLd0i5tPR1GNMxOviDNwcdM78mPcYYgoHvi4stRFF59SPNmIwTxzhkJJKUoWB4vC
         PZpg==
X-Gm-Message-State: APjAAAWsluDPvhYuWb/gxgI/EsHKEJkkYwoLt9C8+BcSUHFZ/eMD8tGq
        bZoZ9dlp8Op6WpdH6rlJ53A3YnR8owLkVnwIKS4=
X-Google-Smtp-Source: APXvYqwntxFE5bIQKEPorldQj0pV5GWsHfjYvuvwZaB4N4e0cmCL2tZG85h8xmQbVxTYaewHc3McFsbg0RaK6Z4ltn8=
X-Received: by 2002:a9d:730d:: with SMTP id e13mr2095221otk.145.1569588210251;
 Fri, 27 Sep 2019 05:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190927121544.7650-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190927121544.7650-1-huangfq.daxian@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Sep 2019 14:43:19 +0200
Message-ID: <CAMuHMdVpHUe5UC2RpZp40=0UeT0jVqH-PCS3pmoZTVkdEnocsg@mail.gmail.com>
Subject: Re: [PATCH] m68k: q40: Fix info-leak in rtc_ioctl
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fuqian,

On Fri, Sep 27, 2019 at 2:15 PM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
> When the option is RTC_PLL_GET, pll will be copied to userland
> via copy_to_user. pll is initialized using mach_get_rtc_pll indirect
> call and mach_get_rtc_pll is only assigned with function
> q40_get_rtc_pll in arch/m68k/q40/config.c.
> In function q40_get_rtc_pll, the field pll_ctrl is not initialized.
> This will leak uninitialized stack content to userland.
> Fix this by zeroing the uninitialized field.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Thanks for your patch!

> --- a/arch/m68k/q40/config.c
> +++ b/arch/m68k/q40/config.c
> @@ -264,6 +264,7 @@ static int q40_get_rtc_pll(struct rtc_pll_info *pll)
>  {
>         int tmp = Q40_RTC_CTRL;
>
> +       pll->pll_ctrl = 0;
>         pll->pll_value = tmp & Q40_RTC_PLL_MASK;
>         if (tmp & Q40_RTC_PLL_SIGN)
>                 pll->pll_value = -pll->pll_value;

Nice catch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue for v5.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
