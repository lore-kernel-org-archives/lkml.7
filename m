Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62020C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1462082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DiiJgO6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfDBTXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:23:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40773 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:23:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id t8so13087318otp.7;
        Tue, 02 Apr 2019 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n5qyPlBMNh5sZ/jbDN+VjVIz9+XoNdXWKJOvxQgpQY0=;
        b=DiiJgO6sFgcCKr3BbrFwgApQg7ROfOp1I6jB2BStf81axSgeOdc6snwCpQbo19QlUS
         zmU2m08pszfpPTZgsoMcsSAXqpS9hTyI/VK5G4tp+LcG3EfIHUWsI2OU6kbPx7Z8dWCY
         9tNgNSqlJU59tqZSqFr3uJhm05gYTeTelF4Lc0wdOk8odJd7muZmOXb+/UGRBXY1z5lK
         q6yS9S9I0RLnhJcQetvitsPqhX3XIv34ZR9qMtVc+pKCona/fo2eeD5nLhDoztwReUYs
         9+O0ElX2praaveIDQgjg2fzKbEuMGfTuyfn4AJWED+o9u7+erQWmxPSOXDybOWrgkB03
         w+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n5qyPlBMNh5sZ/jbDN+VjVIz9+XoNdXWKJOvxQgpQY0=;
        b=HHQz8uvTB8MMe7qKC2HfIdyTR0wUlGmzmr6MAlG1lUzjbDjLn3QIRObqYfjHcw053G
         fnkIPUCKxr5AQsXMlau/KPPBja8rSDfr6tt5cN/kem8ZdYNRfZZY7tg3R6X3EsIwtGdN
         lG820EyRRtKXEp9C9ZTCsJVltWphjKqwxddgnSitOqOBg78t+SO/yITW9xqyxfpTTbel
         OUSQ3LPjHGlZcPIg6RbEbGpDAWlqFCjSY3UEhxhcLWZDikNyi319CDi62BpYcZBDHv3M
         sDzF1cj6yKlu3H/O0l3m6lyNlpYqjDxVFhPpr7P279IW6833KubGSddH79POd1NiV5Sy
         8akg==
X-Gm-Message-State: APjAAAWNRwXNABry0v4uK8gmYWkAXJ1CdC+d1Orst/Q5F3JovDIrhWw2
        mPBabRX/6L1GnhG3LNeJQcNwQ+7D6jNj/MRf4Bc=
X-Google-Smtp-Source: APXvYqxHChjMSVeSCaMIfXO0Edx/fjzUjYllYZaWM0ZGmeLEEos+8a08qfu2Mt0g/xNbOPUPd2PiynuALA6sY6OfqaA=
X-Received: by 2002:a9d:6e88:: with SMTP id a8mr34372516otr.117.1554232986753;
 Tue, 02 Apr 2019 12:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
 <20190401181817.11999-2-martin.blumenstingl@googlemail.com> <20190401183847.7xhlgff63cvlzz2h@pengutronix.de>
In-Reply-To: <20190401183847.7xhlgff63cvlzz2h@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 2 Apr 2019 21:22:55 +0200
Message-ID: <CAFBinCDac9189=+UVLPLqdmJsJvudys_L0GE=Zf0FRkOWsruuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pwm: meson: consider 128 a valid pre-divider
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bichao.zheng@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On Mon, Apr 1, 2019 at 8:38 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Martin,
>
> On Mon, Apr 01, 2019 at 08:18:16PM +0200, Martin Blumenstingl wrote:
> > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > index f6e738ad7bd9..4b708c1fcb1d 100644
> > --- a/drivers/pwm/pwm-meson.c
> > +++ b/drivers/pwm/pwm-meson.c
> > @@ -188,7 +188,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
> >       do_div(fin_ps, fin_freq);
> >
> >       /* Calc pre_div with the period */
> > -     for (pre_div =3D 0; pre_div < MISC_CLK_DIV_MASK; pre_div++) {
> > +     for (pre_div =3D 0; pre_div <=3D MISC_CLK_DIV_MASK; pre_div++) {
> >               cnt =3D DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
> >                                           fin_ps * (pre_div + 1));
> >               dev_dbg(meson->chip.dev, "fin_ps=3D%llu pre_div=3D%u cnt=
=3D%u\n",
>
> You could even calculate pre_div without the loop.
>
> Something like:
>
>         u64 pre_div =3D (u64)period * rate;
>         do_div_round_up(pre_div, NSEC_PER_SEC * 0xffff);
>         pre_div--;
>
> (I didn't check rounding and maybe its off by one and ...) This would
> also get rid of the strange 1000 that is currently used in the
> calculation without a real benefit (unless I missed something).
personally I prefer using this simple patch applied first as it is
easy to review and (due to the Fixes tag) may get backported to stable
kernels.
I'm not saying I don't like your suggestion, I propose to postpone
implementing this cleanup. I need to have a closer look at the
calculation because three values are derived from the input clock rate
(pre_div, cnt, duty_cnt) and I don't want to mess up the cases that
are already working as of today.

Please let me know what you think.


Regards
Martin
