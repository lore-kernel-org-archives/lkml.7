Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FDFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D375C20868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IooW1a0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfCHSiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:38:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46501 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfCHSiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:38:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id a22so2178156pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5sGr/qK2Hp8UxIrFRvCqGsTl0l4fq50X0Fbr8W1d/pw=;
        b=IooW1a0aPJAaHHRMXaFSMiPHweBgn0JSopfudbxsr7nawzmGnfWg3QlsRd5H0OTsA1
         8nJCN/xce9xNRFaslTdtkCNMHJXMrHBsDW7bRRhvRo4VEBsrBQQKwCfMA0jQ/xXj9suV
         2rmZu6+t0jhyWPEJLMov4HLosqBPT5JHIy+njrDvGI8X7NMe3r2KGuxoOz9X9cOTmH1r
         79xQq4Q3ALUEdiqK2F/6aGcNE1kxxBTRE8NoJ02yyLIYgi2QHzeH7e206eeQKBA6KdDW
         9ATxquvk2Kwj2bVf2xzLcmCZqMZveJD0i05oZNPjNoTCHc/bgNQ5GjxVOGG3nJYaQ0g8
         uJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5sGr/qK2Hp8UxIrFRvCqGsTl0l4fq50X0Fbr8W1d/pw=;
        b=HW8b2eska3/igYlUT9QZZFC8DXjhq6wCbNnm9xuhCDzfQ5yd/62myxVJua0beJ5Mc1
         jnmoQY7yqnB4y2iBNPu+VixeOF7lvY1js44azNLQjMKEHIqX1aC8MG/cBYmKIPsbtZm2
         kR6U0ugIuTOmcaRKOcUgnIxOUvtz14C8RBJERPwY/7uM4cN1ql862cbA08PF+rQqObA5
         n9F2yqpj/O692ptqUiylb5RsmgrVMesnB/pYx3wUvwxkW722hbTMuI+OHCTF4UcmvfhC
         7PbWRBlThp9oqBBrGaNXNNpAP8Drxf3tgLv1LIXkeCcqlvI4M+Y7VKTxlq5t1k0q+AZI
         OZag==
X-Gm-Message-State: APjAAAUvkZ6vticCheL6EzoFCxUEHqsbrL6XBA0xuCw3qSQ/PHB+ZKmo
        S1n08xUv7s4gsbzNLIaZ3q+FSPtt3DerBwWvS0Bskg==
X-Google-Smtp-Source: APXvYqzByu7GiJYp+I6KpYQ4/OnQ3mjdSiHMUlkaTP5IHhdGm7/YKuatUoIJbIk+CCmHSVSL+cEea5kN+nyFjtOgPeg=
X-Received: by 2002:a62:2b88:: with SMTP id r130mr19820710pfr.93.1552070302290;
 Fri, 08 Mar 2019 10:38:22 -0800 (PST)
MIME-Version: 1.0
References: <20190307223628.21270-1-natechancellor@gmail.com> <20190308085316.7eaynrb746o6xsz7@pengutronix.de>
In-Reply-To: <20190308085316.7eaynrb746o6xsz7@pengutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 10:38:11 -0800
Message-ID: <CAKwvOdmA6=_-_uC8PAC8i+-mLA8FN6GOeY544139N2AsA8RbsQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in img_pwm_config
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:53 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Mar 07, 2019 at 03:36:28PM -0700, Nathan Chancellor wrote:
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> > uninitialized whenever 'if' condition is false
> > [-Werror,-Wsometimes-uninitialized]
> >
> > The final else if functions as an else; make that explicit so that Clan=
g
> > understands that timebase cannot be used uninitialized.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/400
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/pwm/pwm-img.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> > index 815f5333bb8f..1cc5fbe1e1d3 100644
> > --- a/drivers/pwm/pwm-img.c
> > +++ b/drivers/pwm/pwm-img.c
> > @@ -123,7 +123,7 @@ static int img_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> >       } else if (mul <=3D max_timebase * 512) {
> >               div =3D PWM_CTRL_CFG_SUB_DIV0_DIV1;
> >               timebase =3D DIV_ROUND_UP(mul, 512);
> > -     } else if (mul > max_timebase * 512) {
> > +     } else {
> >               dev_err(chip->dev,
> >                       "failed to configure timebase steps/divider value=
\n");
> >               return -EINVAL;
>
> This can even be simplified further.
>
> From the probe function we have:
>
>         pwm_chip->max_period_ns =3D NSEC_PER_SEC * 512 * max_timebase / i=
nput_clk_hz

I had trouble verifying `input_clk_hz` in the above.  The divisor is
`clk_get_rate(pwm->pwm_clk)`, but is it guaranteed to always be
`input_clk_hz`? If so, where?

>
> Then in img_pwm_config there is:
>
>         mul =3D =E2=8E=A1 input_clk_hz / =E2=8E=A1 NSEC_PER_SEC / period_=
ns=E2=8E=A4=E2=8E=A4
>
> (Not sure this term is the best we can come up with. The rounding
> strategy looks strange because the first DIV_ROUND_UP makes mul smaller
> while the second makes it bigger. This is similar to
>
>         =E2=8E=A1 input_clk_hz * period_ns / NSEC_PER_SEC =E2=8E=A4
>
> which is probably more exact and cheaper to calculate.)
>
> If we now had
>
>         mul > max_timebase * 512
>
> this results in (apart from rounding errors):
>
>         input_clk_hz * period_ns / NSEC_PER_SEC > max_timebase * 512
>  <=3D>    period_ns > max_timebase * 512 * NSEC_PER_SEC / input_clk_hz
>  <=3D>    period_ns > pwm_chip->max_period_ns
>
> This however is already ruled out by the first check in
> img_pwm_config().
>
> So if the rounding would be fixed, the else is a dead branch and could
> be dropped completely.

--=20
Thanks,
~Nick Desaulniers
