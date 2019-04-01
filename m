Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38DFC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C743120883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfDAMm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:42:27 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34592 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfDAMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:42:27 -0400
Received: by mail-vs1-f68.google.com with SMTP id t78so5400930vsc.1;
        Mon, 01 Apr 2019 05:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZaABUbe2GaXrA4anWl3B0XqHYwuzcQC9FQUs2sqt0k=;
        b=YR949cZ+wr+HBj6TTCkuNNjbiruJhQM5G3GnbvIhjTwUN3Vd6LUU3hDvWC5jp01vvm
         DhMtfK7VVsqicUM6FQYwPTh4yk4sxv0rWx/sn8w5VHFNoPOqKs4ddz3D7XWao24H3mB3
         Jn1/v0XQluWG5vMzUtxg2oO8pVyz//XJEpLQhSZkXUbVgjNmvscJvD0IHoxOGzNalEx4
         4kEuPyE4DB+X9QAwgizHoPzGnWNqYacVRi62avHkJfc8abLHL8LfUbGRjhBIC1xN1bgH
         n4pz3rMrwj6tbYkniUDjTA0r+dWjY14p9+8vBqiibmbf5mEkNyXIELLWpuHavCaYpQ5t
         o9Cw==
X-Gm-Message-State: APjAAAXwi40O/3onWhdDra/1vuHijHQYniYVUlJ9pnB1NQYoG/8Ggk1d
        oshAJS38/EnlExJGodtWOpA3iXynApjvH7iVn40=
X-Google-Smtp-Source: APXvYqwxwJ7/HA7DSdM9bycDAvNLlAoNAn3jJi01q3MxB2XB0uGSye346l6xogXg5INC6YQIogkxWOm7TlK/xlYnMas=
X-Received: by 2002:a67:ba03:: with SMTP id l3mr29321605vsn.96.1554122546118;
 Mon, 01 Apr 2019 05:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190401084143.uqbiktkt2vltgrxa@ninjato> <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
 <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Apr 2019 14:42:14 +0200
Message-ID: <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
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

Hi Steve,

On Mon, Apr 1, 2019 at 2:39 PM Steve Twiss
<stwiss.opensource@diasemi.com> wrote:
> On 01 April 2019 10:00, Geert Uytterhoeven wrote:
> > Subject: Re: [PATCH 1/2] rtc: da9063: set range
> > On Mon, Apr 1, 2019 at 10:43 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > On Thu, Mar 21, 2019 at 11:15:56AM +0100, Alexandre Belloni wrote:
> > > > The DA9062 and DA9063 have a year register that can go up to 0x3F.
> > > >
> > > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >
> > > I couldn't test the upper limit (DA9063 hooked to a 32bit system here),
> > > but lower limit works and RTC in general works.
> >
> > BTW, does the RTC alarm interrupt work for you?
>
> As far as I can tell, there are no RTC alarm regressions.
>
> I am using an i.MX6Q board and with an unmodified v5.1-rc1 kernel, for the
> alarms, I see everything working okay WITHOUT Alexandre's patches ...

Thanks!

I was just wondering whether they work for Wolfram, who has a similar
but different board than I have. Last time I tried, they didn't work for me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
