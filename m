Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5F6C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201012089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kW6SnZC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfFXJFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:05:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42387 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXJFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:05:08 -0400
Received: by mail-io1-f65.google.com with SMTP id u19so1420764ior.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RT4lEk5fN7HFZePgHSc4vHCyrKek0LAJIXSg/6ONn94=;
        b=kW6SnZC7+SUahHh8QHkx5EZO/GZhKr4MN2xFKG6Z/Co/A/pvQ9gv2RhrPctSMF99KF
         +cfWXOTaaJm4GiBRUfZ0cy9jj/bbs1jdkzVt/lTnjwNqmBC57ka2rlCnKqyhbfDNVOud
         e2RIkO2eXyOqr1R6unsFUNSfSuiXVYw8V8RvyIJ0GofaU9F/iB7SpA6VPbuBkCd2q3HL
         adQl4q5OSRajsSaqC2clbe9eMtqdmrRJUY6I5mvO+Z5Qa/3UGF/XnZV5nj6rbnGWARz+
         TGzy31TkZOdhiA+Gfiyhn2id34l4xHli2ieBUUIy1uJTH0t1dointiClqCTGlVSQBQRJ
         IXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RT4lEk5fN7HFZePgHSc4vHCyrKek0LAJIXSg/6ONn94=;
        b=bgCr/lEozE0uEFv2AbKpN+ZXtvjdy+b8qbau+goaCXVgyp/3orvxh5cWF7yJq8ImUj
         9ZITyn98FvIk9cSUEn2cSchIycLEf8wph7EFr4KqEE/Q2i+SOiM2nvtFKwit6e5KWjQ+
         izLijt/xqNyTv8EXqW3TaO3L/6CECrvilcDbqdLVmVsY2l72L6lZk/7h7YvR0k4U+pKQ
         6uyiqYM9+6OxCl/ycSjkAtJ9eX7A14KE6uBViZWbXha1xTgl7YTNieKK+DjO5XQ+Yo+w
         qVcww6MVHXJMTRUOQPOO7pi6IpzQN1eDxGp0VJDTwaEWL/TZswdgAxRb8i9+Hf4KRzO9
         e6gg==
X-Gm-Message-State: APjAAAWO+OTTDUG9E5HR+mclekvdEk0EZ0U4TOiGohvSRfZg6mvmpU+0
        S9hKeD05c7qAvk4bkg/LaD3jNCvLvaZQPhfaVlAxRw==
X-Google-Smtp-Source: APXvYqxs+X/MEHIFWNknlHNPwtoAj/m9emqJBt5qpPpYunxdVJPOqth+WqIc74mICJHshxgtlxM3+DrIEe3yOspremU=
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr8686796iof.6.1561367107600;
 Mon, 24 Jun 2019 02:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190617113109.24689-1-colin.king@canonical.com>
 <CAMpxmJVxg2+2mdAQDSo5LTq=w7+ccXnwRmK+iz=4zkNhepE6pQ@mail.gmail.com> <20190624090339.GW28859@kadam>
In-Reply-To: <20190624090339.GW28859@kadam>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 24 Jun 2019 11:04:56 +0200
Message-ID: <CAMRc=MfvzJadT2E7MN=bUjhhjFHoFs7cH2YDmuOFm-fMgDmC7A@mail.gmail.com>
Subject: Re: [PATCH][next] clocksource: davinci-timer: fix memory leak of
 clockevent on error return
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Colin King <colin.king@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 24 cze 2019 o 11:04 Dan Carpenter <dan.carpenter@oracle.com> napisa=
=C5=82(a):
>
> On Mon, Jun 24, 2019 at 10:28:10AM +0200, Bartosz Golaszewski wrote:
> > pon., 17 cze 2019 o 13:31 Colin King <colin.king@canonical.com> napisa=
=C5=82(a):
> > >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > Currently when the call to request_irq falls there is a memory leak o=
f
> > > clockevent on the error return path. Fix this by kfree'ing clockevent=
.
> > >
> > > Addresses-Coverity: ("Resource leak")
> > > Fixes: fe3b8194f274 ("clocksource: davinci-timer: add support for clo=
ckevents")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/clocksource/timer-davinci.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksourc=
e/timer-davinci.c
> > > index a9ca02390b66..8512f12e250a 100644
> > > --- a/drivers/clocksource/timer-davinci.c
> > > +++ b/drivers/clocksource/timer-davinci.c
> > > @@ -300,6 +300,7 @@ int __init davinci_timer_register(struct clk *clk=
,
> > >                          "clockevent/tim12", clockevent);
> > >         if (rv) {
> > >                 pr_err("Unable to request the clockevent interrupt");
> > > +               kfree(clockevent);
> > >                 return rv;
> > >         }
> > >
> > > --
> > > 2.20.1
> > >
> >
> > Hi Colin,
> >
> > I omitted the error checking in this driver on purpose - it doesn't
> > make sense as the system won't boot without a timer.
>
> One way to silence these static checker warnings is to use
> "GFP_KERNEL | __GFP_NOFAIL".
>
> regards,
> dan carpenter
>

Noted, I'll be sending a new version of this driver to Daniel anyway,
so I'll include it.

Thanks,
Bart
