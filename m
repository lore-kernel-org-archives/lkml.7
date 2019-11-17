Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D6C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5293C20727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slVeQhdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfKQL1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 06:27:54 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43146 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfKQL1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 06:27:53 -0500
Received: by mail-wr1-f49.google.com with SMTP id n1so16093833wra.10;
        Sun, 17 Nov 2019 03:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRb4rHk+wMDKet5bHxbNKk76HRcEuXGmjVUHzgEq0xw=;
        b=slVeQhdyt+sqLBrGn6439IEhrCPW6xHrtN3CTNUYWaCIcBLhfotFK1CU97BPZ9MljW
         oepHugZNkm0/EG42xxpa46EZjR6hMr1eY1Do/+n1eOpQHfUJ11NRqFbcaWDHkO9IMP6Z
         i/pRxCfMDmACYsQhBiYTfNmKBskXrh/W3Xb6zjKrE8xKj6w2+16dzuy3serZyBk5gz3H
         pB6wrqlZdeuHxsN7m7FFKp65M7f8vyv2BE3ZZfmd7jiPAvV0Lb3KD3LCskVb3bx3mrp7
         3lUTjflfaK3rgA6Ya/M7QZYVQl2tmCn0CFrTseVJNAMdWzB7IJ0BhLgTq2YE8mcCFql8
         S7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRb4rHk+wMDKet5bHxbNKk76HRcEuXGmjVUHzgEq0xw=;
        b=uSVQFTRmcK5jEVUytZtTdyi/crOJ9KeRXdIRZ5ZgFxRA5UNxvDNoqTEQFi5FYe32RP
         K04r2Z/aXryct8iZNJYC3cXhPEAxvNJD7y64q5P2EWrwwd3nsGWMuHav7bqCkrtAG3YZ
         gUcCucVuRJ0fjb3+FKc0A2t1s0lG7rrxVpu3bRt2c/m2jaN/1DbI9Z1TmAGjCtRKpajt
         v66aCtF2t6FlpgF9aWEtnGIWerjJMLcSt7ZNy3H8h6RKPZ531Uy8RW+V9pzt1hRRC/Zs
         9/yeNu7B1MXUnWM4qnuI17Uzhd4JYti+Jpb8lumIfWbgoktC7wn52Z/4K0EgXS1vBJSh
         FeXg==
X-Gm-Message-State: APjAAAWhXd1Ba6Nnj8f1zE2JsxsNfhUWkenzse5GslOcHPsb61E75D5s
        dPP9SMgB+zJ6tP3RsgMHsehGJX7DdC8MpnaAcs4=
X-Google-Smtp-Source: APXvYqw0TX9o7dA9RxXrRGrFHXGIGskn4cHlshHNQj3aEvQV9CpeXk5m2CJ7PMoYoaPtlL+Ld/CjcxA2R3+scpNQnSk=
X-Received: by 2002:adf:8b01:: with SMTP id n1mr26544555wra.227.1573990071310;
 Sun, 17 Nov 2019 03:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com>
 <20191025111338.27324-6-chunyan.zhang@unisoc.com> <20191113221952.AD925206E3@mail.kernel.org>
In-Reply-To: <20191113221952.AD925206E3@mail.kernel.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Sun, 17 Nov 2019 19:27:15 +0800
Message-ID: <CAAfSe-twxx4PyERHXuYcoehPoNYiVaOS4hZEK0KndoM2sL_5gQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] clk: sprd: add clocks support for SC9863A
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, 14 Nov 2019 at 06:19, Stephen Boyd <sboyd@kernel.org> wrote:
>

[cut]

>
> > +static const u64 itable_dpll[5] = {4, 1211000000, 1320000000, 1570000000,
> > +                                  1866000000};
> > +static SPRD_PLL_WITH_ITABLE_1K(dpll0_clk, "dpll0", "dpll0-gate", 0x0,
> > +                                  3, itable_dpll, f_dpll, 240);
> > +static SPRD_PLL_WITH_ITABLE_1K(dpll1_clk, "dpll1", "dpll1-gate", 0x18,
> > +                                  3, itable_dpll, f_dpll, 240);
> > +
> > +static CLK_FIXED_FACTOR(dpll0_933m, "dpll0-933m", "dpll0", 2, 1, 0);
> > +static CLK_FIXED_FACTOR(dpll0_622m3, "dpll0-622m3", "dpll0", 3, 1, 0);
> > +static CLK_FIXED_FACTOR(dpll1_400m, "dpll1-400m", "dpll1", 4, 1, 0);
> > +static CLK_FIXED_FACTOR(dpll1_266m7, "dpll1-266m7", "dpll1", 6, 1, 0);
> > +static CLK_FIXED_FACTOR(dpll1_123m1, "dpll1-123m1", "dpll1", 13, 1, 0);
> > +static CLK_FIXED_FACTOR(dpll1_50m, "dpll1-50m", "dpll1", 32, 1, 0);
> > +
> > +static struct sprd_clk_common *sc9863a_dpll_clks[] = {
> [...]
> > +static SPRD_COMP_CLK(core0_clk, "core0-clk", core_parents, 0xa20,
> > +                    0, 3, 8, 3, 0);
> > +static SPRD_COMP_CLK(core1_clk, "core1-clk", core_parents, 0xa24,
> > +                    0, 3, 8, 3, 0);
> > +static SPRD_COMP_CLK(core2_clk, "core2-clk", core_parents, 0xa28,
> > +                    0, 3, 8, 3, 0);
> > +static SPRD_COMP_CLK(core3_clk, "core3-clk", core_parents, 0xa2c,
> > +                    0, 3, 8, 3, 0);
> > +static SPRD_COMP_CLK(core4_clk, "core4-clk", core_parents, 0xa30,
> > +                    0, 3, 8, 3, 0);
> > +static SPRD_COMP_CLK(core5_clk, "core5-clk", core_parents, 0xa34,
> > +                    0, 3, 8, 3, 0);
> > +static SPRD_COMP_CLK(core6_clk, "core6-clk", core_parents, 0xa38,
> > +                    0, 3, 8, 3, 0);
> > +static SPRD_COMP_CLK(core7_clk, "core7-clk", core_parents, 0xa3c,
> > +                    0, 3, 8, 3, 0);
> > +static SPRD_COMP_CLK(scu_clk, "scu-clk", core_parents, 0xa40,
> > +                    0, 3, 8, 3, 0);
> > +static SPRD_DIV_CLK(ace_clk, "ace-clk", "scu-clk", 0xa44,
> > +                   8, 3, 0);
> > +static SPRD_DIV_CLK(axi_periph_clk, "axi-periph-clk", "scu-clk", 0xa48,
> > +                   8, 3, 0);
> > +static SPRD_DIV_CLK(axi_acp_clk, "axi-acp-clk", "scu-clk", 0xa4c,
> > +                   8, 3, 0);
> > +
> > +static const char * const atb_parents[] = { "ext-26m", "twpll-384m",
> > +                                           "twpll-512m", "mpll2" };
> > +static SPRD_COMP_CLK(atb_clk, "atb-clk", atb_parents, 0xa50,
> > +                    0, 2, 8, 3, 0);
> > +static SPRD_DIV_CLK(debug_apb_clk, "debug-apb-clk", "atb-clk", 0xa54,
> > +                   8, 3, 0);
> > +
> > +static const char * const gic_parents[] = { "ext-26m", "twpll-153m6",
> > +                                           "twpll-384m", "twpll-512m" };
>
> Can you use the new way of specifying clk parents instead of using these
> big string lists? That will hopefully cut down on the size of this code
> by reducing all these string lists.

Not sure if I understand correctly - do you mean that switch to use a
reference to clk_parent_data.hw in the driver instead?
like:
https://elixir.bootlin.com/linux/v5.4-rc7/source/drivers/clk/qcom/gcc-sm8150.c#L136

Since if I have to define many clk_parent_data.fw_name strings
instead, it seems not able to reduce the code size, right?

Thanks,
Chunyan
