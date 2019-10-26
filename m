Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EFCCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616D3206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFwlM8wU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJZUKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:10:13 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42898 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfJZUKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:10:13 -0400
Received: by mail-vs1-f65.google.com with SMTP id a143so2981199vsd.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 13:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDEMq12+GoZjAjo4O+FCfz1yHRDZsbKXXPN9zoSDxK0=;
        b=xFwlM8wUS/ocMSwnz7vYdPl97Jbn9Maggf3byK+zfxuQHkFDWaGGzoLtrI4gk/6lxj
         IsVlIQdZ0dwVmDTTDAyZ9lX779AJvocr5BnS6QcsOBfLrk7hUf9rmnYUBgCU8pFQPPlS
         HUXMH1PytYkVsWDqFRisFwhQ753ojWlkMkAKlWnhVZzeS0JBwje2pjL7DKfsq1YK65Un
         NFueN3qUeY+NaR5Vw5FSnZfImXqviARWcVxUaaHiRmHYkjxccpdVS+Na4c7KHEIdxqq0
         F3Emi448IoJIWAkWsfhtpPv9YdSne/i/qgf8kCWsNZqA8nmEbNavZBzi1OalOOPekIAN
         5PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDEMq12+GoZjAjo4O+FCfz1yHRDZsbKXXPN9zoSDxK0=;
        b=H/Nopij3sXDNxnQjFO9LKYy7PXaZ0dZCYkMZEIZisLsMcaTDXvlrlLLYlmVrg3KBlw
         TdyvGinn/af+J1Hw+HQrveu1loqH9V5+2V3QKzsXoWuVF425D/VwtOmwkjJKliOYwmBu
         WSoWFccOqYJQbL3PCVTH8ddEbM8Ufq33RnBPx6vbxb+DVVtzZWUlMlxgUT+tsvqWR7v0
         rE67R8ay4FSSvtIHQaCy4ML+2PzSCi8mUCKo9ESaHwgKNJvbZZFXs2nE6CAk6Xdda/vX
         l5Sw4wyPvMgrqMT7qaRHcupZOQ1Qwd+dm5jliYhXDtAa6VUQDfSnUYDZgXBhIu+gDYnY
         we2Q==
X-Gm-Message-State: APjAAAVs5jugaGo45rr/26xI06AEG92OKCTzv1pCfCO3mC234femgLih
        zl+w0l5+wGSrlQXGD6mBFqrfsS1yWmJYn4PMWg1q5Q==
X-Google-Smtp-Source: APXvYqxU920mp9qcwnk8ynkwv330PRbuxw9Ysgfc+fhsrvp9fxNiq55+PWi47/PAVLlBc9jwAMRFUojY3mp8eGZCNdI=
X-Received: by 2002:a05:6102:2436:: with SMTP id l22mr5341278vsi.93.1572120612501;
 Sat, 26 Oct 2019 13:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191026122708.12060-1-linus.walleij@linaro.org> <20191026143711.GA3195@gerhold.net>
In-Reply-To: <20191026143711.GA3195@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Oct 2019 22:10:01 +0200
Message-ID: <CACRpkdYQDkrRTzk5hrhvLhVZryHMH+Cqg6DVR6VAPG1DAdDesA@mail.gmail.com>
Subject: Re: [PATCH] mfd: db8500-prcmu: Support U8420-sysclk firmware
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 4:37 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> >       irqchip_init();
> > +     prcmu_early_init();
> >       np = of_find_compatible_node(NULL, NULL, "stericsson,db8500-prcmu");
>
> Maybe it would make sense to give the struct device_node *np pointer as
> parameter to prcmu_early_init() to avoid duplicating the lookup of the
> device tree node there? But not sure if this is worth it.

I wanted to make the PRCMU driver more stand-alone, looking up
its own resources etc, so I prefer to keep it like this. The other
use in mach-ux500/cpu-db8500.c is the power domains that
should ideally also become a separate driver.

This is called very early on init_IRQ() -> machine->init_irq()
and I just don't know any better way to sneak in before
init_time(), else I would use it...

Fixed the rest!

Thanks a lot,
Linus Walleij
