Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4E220857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YadzOFns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbfCAQwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:52:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43974 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbfCAQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:52:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so21513697ota.10;
        Fri, 01 Mar 2019 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfGCMUN5rPhxXOHU6GO9HQgy62a74lDnvzWD2rPXkz4=;
        b=YadzOFnsRt7HqStDcUVL5g8FLyCYcHKVpJdvB0bs1QQyo32ZJ1O9mujXJuPzSREToa
         sJ/RCeeCUgznWWwjgLw1OMIH4WaVArcbAs6BqSwIWpQ2qA5KsuKpaaEz6RBU6iHqX8rJ
         7dCzY3wWKFJOFJRfkSq0z0zw23LcbiZSspzyQTvkdX+UqaBWfmAGCIda/ny15hjDO9hn
         A1gun7G8mD8U5Fo8F18Auo5eThd+j1CoBtc9hahktTw8/iP+gHvxRgKU3hZ+6FrDNNBv
         N6yiFGE4d2vDJHNrcECwzbjbrQwhCA3iM2M2p52iFfRuObce+glfPhATOcKud57G7bdy
         SwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfGCMUN5rPhxXOHU6GO9HQgy62a74lDnvzWD2rPXkz4=;
        b=GE01i3RXJYw+0WIQev6Of8UJxiy1RtArqUslrYbV83Bqb+svPc7YVBlq2pLp8r9Wos
         WwtV4s/pZ4dzzy6NVUqsaYbFodlsICH/GRkXLh5k51/28I9c3x3ETuN9V9j7ScQxAnJD
         HuvXMrCq/ehGvQeJTwRe+1fvsLL9NZeJxMKyHAwF9fiSGDT8rh8xqeUqkfU/d2v3hfeS
         He1EliRDGcvvINAPwWhG+FEaZV2vlYpDw9VXzB+QlEPOxYOCUJmtSZX0Joz6jBL0qe/1
         zWsciplIEHpvXIBw7lwSrlrIpQV++xiI0we4QCbVPhblGct/PfFs/db8rTyEQcINqJzg
         mH8Q==
X-Gm-Message-State: APjAAAXQnkaaHNp2T3Ki4zyjhDqpwg/JbJxaTsT7YJQRNPEf3WvhFNJD
        luc7kwDXzBVOc7Kn8ZGMN9feo7nK3qIJwzaw6aM=
X-Google-Smtp-Source: APXvYqyGLydGGb+d8KABdstqENqvMOYfuAmB+lV9H24A55nw4V6X6UtyiPVGvL6BE7VbtjwSlCGD66Sqj8XyTHrXH/0=
X-Received: by 2002:a9d:798c:: with SMTP id h12mr3782628otm.86.1551459165541;
 Fri, 01 Mar 2019 08:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20190301102140.7181-1-narmstrong@baylibre.com>
 <20190301102140.7181-3-narmstrong@baylibre.com> <CAFBinCC1b5Q8Y=5qXKJ+B1XBhpo8PGFYHwTEeVTgbXwz7ge3-A@mail.gmail.com>
 <a3654bdb-4289-7755-5601-e8177b00790f@baylibre.com>
In-Reply-To: <a3654bdb-4289-7755-5601-e8177b00790f@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 1 Mar 2019 17:52:34 +0100
Message-ID: <CAFBinCA6VJqK31NgyVkf2rLva0R2RbYQasdZGe+0BjjdOmnmFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: meson: g12a: add cpu clocks
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Mar 1, 2019 at 5:42 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> >> +static struct clk_regmap g12a_cpu_clk_dyn0_sel = {
> >> +       .data = &(struct clk_regmap_mux_data){
> >> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> >> +               .mask = 0x3,
> >> +               .shift = 0,
> >> +       },
> >> +       .hw.init = &(struct clk_init_data){
> >> +               .name = "cpu_clk_dyn0_sel",
> > the buildroot code has a variable with the name "p_premux"
> > I'm not sure what the datasheet states, but maybe this should be
> > cpu_clk_dyn0_pre_sel
> > same applies to the corresponding dyn1 clock below
>
> these bit are named "premux1", and cpu_clk_dyn0 names "postmux1",
> which has no sense because there is no mux in between.
>
> clk_dyn0_sel is the actual source selector of the dyn0 tree,
> clkdyn0 is the top of the dyn0 tree, this is why i did not add "sel"
> in it.
OK, thank you for the explanation.
can you please add a comment with the name from the datasheet in that
case? that'll make it easier (at least for me) to compare the
datasheet (and also buildroot kernel, since similar names are used
there) with the mainline drivers

[...]
> >
> >> +               .flags = CLK_IGNORE_UNUSED,
> >> +       },
> >> +};
> >> +
> >> +static struct clk_regmap g12a_cpu_clk_axi_div = {
> >> +       .data = &(struct clk_regmap_div_data){
> >> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> >> +               .shift = 9,
> >> +               .width = 3,
> >> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> >> +       },
> >> +       .hw.init = &(struct clk_init_data){
> >> +               .name = "cpu_clk_axi_div",
> >> +               .ops = &clk_regmap_divider_ro_ops,
> > out of curiosity (this applies to all CPU clock post-dividers):
> > did you check whether CLK_DIVIDER_POWER_OF_TWO is correct on G12A?
> > I'm asking because on Meson8b the post-dividers select between one of:
> > "cpu_clk divided by 2, 3, 4, 5, 6, 7 or 8". also some of the
> > post-dividers use register value 0 for cpu_clk_div2 while others use
> > register value 1 for cpu_clk_div2.
>
> It's correct !
thanks for looking this up again and double-checking!


Martin
