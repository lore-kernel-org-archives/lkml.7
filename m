Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89151206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfCEIXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:23:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32895 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEIXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:23:23 -0500
Received: by mail-qk1-f196.google.com with SMTP id x9so4363934qkf.0;
        Tue, 05 Mar 2019 00:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRV0wKjHYYuyn9Bi+YyAEETyDCNf4Wg8c+7jvNxLf/o=;
        b=do6UucaYq98pVuLabZ6kN/lVFtJia5cRJVmKSO1fUj/hQWJlWblYOX50+Dalska5zS
         fmN/7hT6Ln49yrhk7z9sZ/wT/0zDTJqVfx0aGWf0UzDhN1IkbNMJd73/cNPuab9mj+/E
         GdbZqI/5PvwVAqLhQK+j9jRdHLmyCBYXU9K5WTUJwRxdSZ3LIGPJbwrlN60NeVHcECON
         uILcUT8KfwOXvGVgC4ddW+9S4GsNOEf0VOPvPb3J/sudPhLdkm8mn5PH/cj2rTOCmz8Q
         F7nPMmAEZGTMioXHZMBvNG70qKXJdSc7lyQtXdj5QQEiuihiyWSrVABjfyxxq6qSUSGt
         CDGg==
X-Gm-Message-State: APjAAAVNTiJZxK48zav0DunC7fxCXzSPjTwovqIBsUSNC57bGIBOgvKG
        yxwJTOMaQzfrB2O/wxDJ3Nh9Rau+fT0Yvz5lX6M=
X-Google-Smtp-Source: APXvYqwOB9MrRuqeDsBaZfwubYSiZMv7fb3Ix1YUIFKU+r53M1r29vxTjm/RknIfMWRkhohbplzAINUi5y36iEM+NxQ=
X-Received: by 2002:a05:620a:1478:: with SMTP id j24mr794621qkl.343.1551774202397;
 Tue, 05 Mar 2019 00:23:22 -0800 (PST)
MIME-Version: 1.0
References: <20190304201930.1622839-1-arnd@arndb.de> <20190304201930.1622839-2-arnd@arndb.de>
 <a94c3c6a-481e-96a5-74e1-8c3299c74129@metux.net>
In-Reply-To: <a94c3c6a-481e-96a5-74e1-8c3299c74129@metux.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 09:23:06 +0100
Message-ID: <CAK8P3a0vdhCTNTF-K0mXjRWkPvv0qr3nf_52=8n6zTa7p3ELLw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: apuv2: fix input dependencies
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linus Walleij <linusw@kernel.org>,
        Enrico Weigelt <info@metux.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 1:18 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 04.03.19 21:19, Arnd Bergmann wrote:
>
> > This could be fixed using either a dependency or a 'select' statement.
> > I'm chosen 'depends on' here since it is simpler has a lower risk of
> > introducing circular dependencies.
>
> I'd rather prefer using 'select'.
>
> Otherwise the driver won't appear at all if INPUT or INPUT_KEYBOARD
> aren't enabled (eg. when you start w/ minimal config - which I do
> frequently), and people have a hard time actually finding/enabling it.

No, that wouldn't be good here. In effect that means that with INPUT disabled,
most of the x86 platform drivers are disabled, until you enable the
PCENGINES_APU2 symbol, which then ends up showing all the other
symbols at once, and changing them to their default states.

Another problem is that you likely run into circular dependency chains
after trying that. The best practice for select vs. depends are

1. try to use 'depends on' if you can
2. use 'select' on hidden symbols, but not user visible ones
3. for each symbol, use either 'depends on'  or 'select' from all other
    drivers that need it, and do it consistently
4. never select entire subsystems, only helper code.

Those are sometimes at odds. I used 'select' for the LEDS code
because of 3. and 4, even though that goes against 2. For INPUT,
there is no real debate though.

   Arnd
