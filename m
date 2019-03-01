Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E50C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B114F20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfCAJvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:51:41 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41050 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfCAJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:51:41 -0500
Received: by mail-ua1-f66.google.com with SMTP id j7so7095073uak.8;
        Fri, 01 Mar 2019 01:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wRZYJMbL7YK8sFkJdZpCHVpLmSHoA0VUyOgYXV8p3E=;
        b=SN3tDlSldR4eZIQ5olWibakWmqF3VIn+IO/vmjsDUUdILr0RMgaTp+rpehsJsgTSoI
         rL4oo83qlKoIzNGdQ+1AnbJKlwov5ELQIukCcUjyAh04UrROxw+m4D8WQvuFJd6jhiTU
         z6qRh2hsDERyg//q9jpNVRtrO9JS/J/fPhCMsbTO9MTC2gaWST0U6W0TsIhm8s8be1YV
         PsYFUcoBOrTmQiw7kOzrj2UmbD9rGyqm9PXv7waZllkwldyNIsApKVlOKewpfr9S+4g7
         L5lgmj9mvVp+1Gld0yjE/hEs3rBcK2poro6cDoNt3REmYCExoWwoZboe1toMFkjd1t2+
         crFA==
X-Gm-Message-State: APjAAAWjCUHRHBI0O7kwcnSuUW/XjIobnkkEEfom8TJWop4wgIXQPA/o
        /ofS8RixlHJivCatdpJowToG2Kpy3CcB6YvLrfQ=
X-Google-Smtp-Source: APXvYqwQqmv0qSf/5I7Q7XSoWMbil550gLemcgNm3OkWBAPRfchw5wWM4WxaHoIxWPSOeqFbfrsBQFGlYJTQ+WlPsfk=
X-Received: by 2002:a67:78ce:: with SMTP id t197mr2151989vsc.152.1551433899715;
 Fri, 01 Mar 2019 01:51:39 -0800 (PST)
MIME-Version: 1.0
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn> <1551430616-42014-8-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1551430616-42014-8-git-send-email-wen.yang99@zte.com.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Mar 2019 10:51:27 +0100
Message-ID: <CAMuHMdWrY0UNhCA7a8oHVfdVNXaB=15qFuWqvuU9OZpf7-ecmg@mail.gmail.com>
Subject: Re: [PATCH 08/15] ARM: shmobile: fix a leaked reference by
 addingmissing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linus Walleij <linus.walleij@linaro.org>,
        avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        openbmc@lists.ozlabs.org, Wei Xu <xuwei5@hisilicon.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        wang.yi59@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 9:57 AM Wen Yang <wen.yang99@zte.com.cn> wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-shmobile/pm-rcar-gen2.c:77:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
> ./arch/arm/mach-shmobile/pm-rcar-gen2.c:85:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
> ./arch/arm/mach-shmobile/pm-rcar-gen2.c:90:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
