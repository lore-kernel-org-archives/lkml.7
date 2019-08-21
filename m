Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5B5C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CFF2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfHUJf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:35:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43617 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfHUJf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:35:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id h13so2142543edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 02:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfU8K2+XLYidqJ3RYJr0NsqUHW7a3b14hBOppxr6+tU=;
        b=Jbo97f9F2Whwmls1P3itpT1wAKlNmdFjXJFrvQzQvGGui+pm9VrnryEj6YKz2OKWy2
         cxa1ETryiH69bocNQzmDGBVrhjge15qFPhDtnXnl1lOCT3v7P9RExw/l6+E7FaRTxLDI
         cqsT8LAxL0OFdG0W9+VBqbGjy15dwyFBD78Gm4XMg6Svpa2KPKVeQhyBhDb/k13YuA8u
         X5M/61B1ZJV5embzr1cCXbG+JPaXIU5Y8O4En7bda5PbEEEOvtSte6EruEdN1XT7txPc
         U/zYKxbV6EOix1oqwxg1abDwPsl6MdPXps4myKmvFrVIp2PRNhsYZSB74X1HRJv3Y6tK
         tG6A==
X-Gm-Message-State: APjAAAWbkuBpIxy+Jt7xloIXpj4NnEr4u4T+X5Tg9336BvMPlxXr0MsL
        03oM25JVxTPrAGQMluTaoeKdfzfS5fI=
X-Google-Smtp-Source: APXvYqxZg/Yl9RJ7en61d2izi7WyagkA8y5ALRJw2z6g8PVE6zHn+g8YNpof/t6OIX5IPwh+iOfKEQ==
X-Received: by 2002:a17:906:1dd6:: with SMTP id v22mr15793569ejh.277.1566380157019;
        Wed, 21 Aug 2019 02:35:57 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id x11sm3051453eju.26.2019.08.21.02.35.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 02:35:56 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id p74so1382676wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 02:35:56 -0700 (PDT)
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr4849166wml.25.1566380156278;
 Wed, 21 Aug 2019 02:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-10-codekipper@gmail.com>
 <CAEKpxB=9NNoZgZoY_GpcEuDYoMUGzb+ATgZOSM64qy9tirC_MQ@mail.gmail.com>
In-Reply-To: <CAEKpxB=9NNoZgZoY_GpcEuDYoMUGzb+ATgZOSM64qy9tirC_MQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 21 Aug 2019 17:35:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v67JfquPoLbUVARSzX3ua22N_3Vg5Ys1JXht4ew_PXto5Q@mail.gmail.com>
Message-ID: <CAGb2v67JfquPoLbUVARSzX3ua22N_3Vg5Ys1JXht4ew_PXto5Q@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v5 09/15] clk: sunxi-ng: h6: Allow I2S
 to change parent rate
To:     Code Kipper <codekipper@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 5:19 PM Code Kipper <codekipper@gmail.com> wrote:
>
> On Wed, 14 Aug 2019 at 08:09, <codekipper@gmail.com> wrote:
> >
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > I2S doesn't work if parent rate couldn't be change. Difference between
> > wanted and actual rate is too big.
> >
> > Fix this by adding CLK_SET_RATE_PARENT flag to I2S clocks.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Applied for 5.4
