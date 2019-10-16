Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABB2FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1323D20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2VwOvll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404877AbfJPLMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:12:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43790 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390844AbfJPLMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:12:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id n14so23518146ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v71FlkQ6J0UpJP7xXEoyiSKAD0pF3wX4jouOoO7MnLU=;
        b=p2VwOvllbg/0/Neh5/P7m4vAWBzv1dXkn+WNCkRcqrMNWDx9pfbHIa1twG4R8nWXjf
         X0M7OXDXTJjEo6uAH35h6Pb+KV8ArvF5+d3HYtX/xO1AsS0HaJJlRtU8llEBmLpfkGwX
         qoYLlT9L7uvJ/T+E+qUzOdI6FY45brr2Bv6PTnSoZJ71z9Vvwf01D5P/l9RmTXc+IC2N
         lbO6S9Db5rrGVTg5iZLHpv5cQ7fUNfoslwR10po8ClfKUicmkFsBs9TTsTHq9Kkd+uc3
         NlHHMouM3yK4d/F+R4Mow1+AUxpLJFyFS0nNGhD2SjvgZwuSNWd09Ebc9nuNkfqJfYao
         beIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v71FlkQ6J0UpJP7xXEoyiSKAD0pF3wX4jouOoO7MnLU=;
        b=OHqIHmKqJjL7qXfwU/lYkq6kNu10Uk13yNxR7fKr1FaOHiG+iDkSCzlR9Tr/Z5S8mR
         Dh72gLNwixSeC94eYWx3eHCl4ejsFBbzJxAr5qTatgsfSWVS/cj4XGsWELobVJXHDEIj
         rKulIPjLseF3GuTmKJf9U/xLFrkMejhyrpfoiZeHZnz8IUpu4dnjpU1xaCBHwpQqJF4v
         Ocv0tO6PhSDhanFzyvtRg3OQL5bdgOd7f/4KPPSqem6mZ7c6qaakx0v9Qt3XgUjt3oj5
         oevyctAErHEBEHbLivkI+op3LJ7uJiSrEr/QrQrl/wHUhMPvO5ZWvU/VmL520EGMnNvD
         RWvw==
X-Gm-Message-State: APjAAAVp9mqsse3ZiAMpWY4aXunuffyLymryJRITYA0tj3r40Q/O4tWb
        lvocN71e/tIaqrSa4RrjFjIrnpnlAGLlCTWAGxnYsg==
X-Google-Smtp-Source: APXvYqy4lzrmB+aQANagIA9pI4peUp9E83YYX2I1eb8nCIhO/KTMZcmTe+F/iRjlb9lEwc7ZwWZU9GViug9WdVdMM3s=
X-Received: by 2002:a2e:481a:: with SMTP id v26mr18093137lja.41.1571224358312;
 Wed, 16 Oct 2019 04:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191004122923.22674-1-amelie.delaunay@st.com>
 <CACRpkda6CyYCt-s-VkaK856Jt3TxQg+HVDz-5Ww9T9KNHHAjaQ@mail.gmail.com> <8eb2090a-e50e-2e4f-982b-073ad24e553c@st.com>
In-Reply-To: <8eb2090a-e50e-2e4f-982b-073ad24e553c@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 13:12:25 +0200
Message-ID: <CACRpkda1H+fUidZG3wccM-YCyk_Ya9gRb8s-JV35qWvEBOKWPQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: stmfx: add irq_request/release_resources callbacks
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 4:53 PM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
> On 10/5/19 6:49 PM, Linus Walleij wrote:
> > On Fri, Oct 4, 2019 at 2:29 PM Amelie Delaunay <amelie.delaunay@st.com>

> >> +       pctl->irq_chip.irq_request_resources = stmfx_gpio_irq_request_resources;
> >> +       pctl->irq_chip.irq_release_resources = stmfx_gpio_irq_release_resources;
> >
> > What about just adding
> >
> > pctl->irq_chip.irq_enable and do stmfx_gpio_direction_input()
> > in that callback instead? gpiolib will helpfully wrap it.
>
> Thanks for pointing that out to me.
>
> I can't use .irq_enable because of I2C transfer to set gpio direction
> (scheduling while atomic BUG occurs in this case). Indeed, .irq_enable
> is called under raw_spin_lock_irqsave in __setup_irq() while
> irq_request_resources is called before.
>
> I could apply gpio direction in stmfx_pinctrl_irq_bus_sync_unlock
> depending on pctl->irq_gpi_src[] (checking which one is set, to set
> input direction), but this will be applied each time a consumer requests
> a stmfx gpio irq.

Oh I get it, hm. I thought it would be covered by the sync_unlock()
but I guess not then.

> IMHO, keeping .irq_request/release_resources callbacks and using
> gpiochip_reqres_irq()/gpiochip_relres_irq() seems to be the best compromise.

OK let's go with that for now, please put in some comments as
to why this gets done there so we know when reading the
code.

Yours,
Linus Walleij
