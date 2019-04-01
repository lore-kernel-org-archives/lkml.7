Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB281C10F0F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899B62082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfDANj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:39:57 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45692 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfDANj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:39:56 -0400
Received: by mail-vs1-f66.google.com with SMTP id n14so5464249vsp.12;
        Mon, 01 Apr 2019 06:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RN3BP7uy1Sd+wJTbpyUnfaglRF7r/ttOBt3uUaIa5rs=;
        b=iKU1PE2zPftmpBonSNvtFhlL5hZ0KGqayEAvIUluqVHviPSxdBibfmunfNumbqA62z
         O9p+19pGDcq3vYrV0oMP67E+58GNfYq2bdEZp+vZ7n9X8DVWW+KJ08LIpJarM7b9l6bh
         EP2ILFHX2skKkpLSW6Ls4i47A7mLVA+QuLHOiE+6clbNxwACUANVJkS1lYX1W+bI5NLM
         JlLGfBjUvu1cbpWuOAAVJMTfgRE8dnA0DPgd/QjmgM9PnFKXYCbtJ8vtW7HpFurwaEiu
         hoeJyf+Fe1Xvsb0Dxkm+0JvomtbOhyUgA3LHZeM6h6iU2ZWE8ojn4fj4rZREKPQ3fyDp
         pi6Q==
X-Gm-Message-State: APjAAAX9y9egsk33phgbfWtVf14+ftjX+b481LIHWycuVpwa2ts00crR
        qo1vQ8QIXJ5pFHEIqdp06O8AZCdDfK63WKJ19w8=
X-Google-Smtp-Source: APXvYqyqoORpwZloE+3qBU4vAF/9KdIOp8uBTyz/8xi3PAwjLcZ16qF0n4IePal55e7z5LDB08/goRjAtxbHlWsiST4=
X-Received: by 2002:a05:6102:199:: with SMTP id r25mr16492354vsq.166.1554125995604;
 Mon, 01 Apr 2019 06:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190401084143.uqbiktkt2vltgrxa@ninjato> <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
 <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com> <20190401132109.GA4570@kunai>
In-Reply-To: <20190401132109.GA4570@kunai>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Apr 2019 15:39:43 +0200
Message-ID: <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Mon, Apr 1, 2019 at 3:21 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > I was just wondering whether they work for Wolfram, who has a similar
> > but different board than I have. Last time I tried, they didn't work for me.
>
> How did you test?

tools/testing/selftests/rtc/rtctest.c cfr.
https://lore.kernel.org/lkml/CAMuHMdWbV2=LfSWz0rFTGRakZ=2iXKOYdM_Uwaov8-OsJpUgoA@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
