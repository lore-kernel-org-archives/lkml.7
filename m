Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E7CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C34B2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lLDMEqBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfCLGxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:53:18 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42728 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLGxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:53:17 -0400
Received: by mail-lf1-f47.google.com with SMTP id p1so1166123lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6xisYs80ssI8KWvqpJCloMNnHCixE15ZiurfRfZv50w=;
        b=lLDMEqBsXVftMfldjou+NzRmWFT4xHrEMy8EPknp+fpKYBvyQUrydO+M2qDhb6xlPl
         FzP4vNOubB3X4MW+Ao3L6cMWBK+EKIPlKN0YNoAKCb8leKU4U/B9DqabU4ssrMsh7xxi
         ZjGoeiy7W/0on3Ez+2wQIBWCdJyArlZwve15FOnFvWxGwYZjpg6ME2Q3s9AGRJc7LgLV
         dWGyCAXbzhAuoV0aX2hFHYYChLtnsyCT/45emAgdIzfgNuqvV2ThOus9dDA/JVWeSF2Z
         Xq8UbDTKcmcxoGgtvI50ypvEGIhSjvHo4SYGgCe7FbcF20I/31X1Nl7sVhpsiyrSt7Ft
         Mh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6xisYs80ssI8KWvqpJCloMNnHCixE15ZiurfRfZv50w=;
        b=lg9P2LQVYVAeOVOKdPEjKDawePo1z3SGyvCoELKm9hfqk2/03lTvfpsjV17fTRJ8hp
         eVQHPjTCNuA1BFfzkubU1lOs8KfaZl3Ej4nnuD4Or1nyzduck1p6AFtXHyo3J/lU0d75
         lv/DeMs/KfRovXJtYhI7FFXeLZrtnREDi6acLtpSEBiGIh51JRyaglngU2+nZEHW5rw8
         oWosuEoXzJGK5UiSUY/aEBp/mXckKsWnMwajYo6HW/Qw58JaBkoTpHSoB8mKAlszoVQ6
         pY3Na8ftai7lbNSzHpA49y360h3z7I6tmOn2xXKi7kzZTosXeB629NSWDQZinVuc/EiN
         I//Q==
X-Gm-Message-State: APjAAAVOFEvnbTZyxj9Bd7F4qjXyz4NFRGOabatuFoEgfnlhrnAcRzK2
        qtTtCtlGkodnDlFTRsoIFJX6FsRVQwdJPODyv6i0ZQ==
X-Google-Smtp-Source: APXvYqwQh2JUQlYoy7Gy4hY12G7htGVabNcJO2SwXA0sRyuMTEQQwtoyM6ztR4X2r+XHbB1GEIa0EiyKMCRE+zcZJ30=
X-Received: by 2002:a19:9e8b:: with SMTP id h133mr13321038lfe.167.1552373595165;
 Mon, 11 Mar 2019 23:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
 <1551437599-29509-3-git-send-email-yash.shah@sifive.com> <20190307152745.kaiv6q4ygf2apmuv@pengutronix.de>
 <CAJ2_jOFvr=sw7mWR53JbzMJa1jxwjhJSTibCsKYsxrht+PLPWw@mail.gmail.com>
 <20190308115726.smgooacsr37fmxwg@pengutronix.de> <CAJ2_jOFtg2_MAUYkTQM-=6KE2RN+FMxfEhLjZZfzM0k3A5RQiA@mail.gmail.com>
 <20190311132922.iowselp7qvmroiaa@pengutronix.de>
In-Reply-To: <20190311132922.iowselp7qvmroiaa@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 12 Mar 2019 12:22:38 +0530
Message-ID: <CAJ2_jOG50Bh0Zu64-htwy+VFy5Bce1Wj5dnMKVEE35C3MEbLPA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 6:59 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Mon, Mar 11, 2019 at 05:10:17PM +0530, Yash Shah wrote:
> > On Fri, Mar 8, 2019 at 5:27 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Mar 08, 2019 at 04:59:36PM +0530, Yash Shah wrote:
> > > > On Thu, Mar 7, 2019 at 8:57 PM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > +     if (state->period !=3D cur_state.period) {
> > > > >
> > > > > Did you test this with more than one consumer? For sure the follo=
wing
> > > > > should work:
> > > > >
> > > > >         pwm1 =3D pwm_get(.. the first ..);
> > > > >         pwm_apply_state(pwm1, { .enabled =3D true, .period =3D 10=
000000, .... });
> > > > >
> > > > >         pwm2 =3D pwm_get(.. the second ..);
> > > > >         pwm_apply_state(pwm2, { .enabled =3D true, .period =3D 10=
000000, .... });
> > > > >
> > > > > but for the second pwm_apply_state() run state->period is likely =
not
> > > > > exactly 10000000.
> > > >
> > > > Yes, I have tested multiple consumers using sysfs interface. It is =
working.
> > >
> > > Can you provide details about your testing here? What is the parent c=
lk
> > > rate? Which settings did you test? Can you confirm my claim that the
> > > above sequence would fail or point out my error in reasoning?
> > >
> >
> > I have tested on HiFive Unleashed board using sysfs interface.
> > Parent clk rate is around 512 Mhz.
> > I have tested scenarios as you mentioned above with various period and
> > duty_cycle values.
> >
> > After considering your below suggestion,
> >  | To get the result independent of the prior configuration you better =
use
> >  | the real targeted period length as input instead of the last configu=
red
> >  | approximation
> > I will introduce approx_period feild, which will be used as the
> > targeted period length.
> > Also, in pwm_sifive_get_state, I will make below change
> > - state->period =3D pwm->real_period;
> > + state->period =3D pwm->approx_period.
> > So with this change in place, I believe the cur_state.period for the
> > second pwm_apply_state() above (pwm2) will be exactly 10000000
>
> I don't understand your intention completely. Just send a new patch
> round, then I will gladly take another look.

I was planning to go with above-mentioned change but then I realized
that pwm state should always reflect the current hardware state, so I
have dropped the above idea.
Coming back to your concern on

 |     if (state->period !=3D cur_state.period) {

It is not failing for the scenario you mentioned but failing for
another way around.

         pwm1 =3D pwm_get(.. the first ..);
         pwm_apply_state(pwm1, { .enabled =3D true, .period =3D 10000000, .=
... });

         pwm2 =3D pwm_get(.. the second ..);
         pwm_apply_state(pwm2, { .enabled =3D true, .period =3D 20000000, .=
... });

The pwm2 should get an error for period mismatch but with v8 patch, it
is not getting any error.

I am sending a v9 patch which has the fix for this.
With v9 changes, I have tested all scenarios and it is working fine.

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
