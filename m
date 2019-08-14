Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FADFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10262084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXx160LR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfHNMXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:23:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34693 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfHNMXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:23:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so9227480otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 05:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sbhZKzd7vqgNoDW9IPEpnkuIB5y4bFHuIKfmylQ9ll0=;
        b=kXx160LRH9QDQOZSXk5f4o5HFMgGsRvlUfSAsPvCa/x6+JZeo7ppHWHkpOYDsdim1C
         G6zRki1QOA6llZRI7ETuDe4GDrBsEnOG524umjIJ7b5aTs+ukAMCwpXk1xgRzpwEkYra
         E78npoAFRclNUrECdq9KWjYqBWJIzpShBVNHr1w4gCemsdM6IDFQpS1CeR6MWhAanwVD
         8VdqTXbjSWEoc9uFxIJanQQg8b1OUMT1Sa8S+q0XDyd8oTvtyWMZMEzL3SIllg26eBdH
         kTj/wUuu0uVXuvf97uwr+9kEYZ4US0SJaQS+95SX/28uj/aRzTZcXcFN530q+BIGN6sp
         9ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sbhZKzd7vqgNoDW9IPEpnkuIB5y4bFHuIKfmylQ9ll0=;
        b=tn2jP+JHEgm79NU4DUX4w/Xwi9e7XXJn9qo7IervEKe1/+ml0Z22TKLC22an8a/hgI
         qnDAfcYlxsUHe2jzsf6XfSMjU0dnJWO5Yr3SsHVVnY8JD/f+EPInq0l5DNkh1kQoQoRn
         Qy1kC3eZYSMuWRhDcpNQIogzI3RZ1ra0kH7jYpqW+nROimvijMZmcROgnmR+J5Yt4dNG
         0nVcAh8/a3jl+vv1NusFuTPAE9bOUNk6tDmeJ3pBW3kwSGJQRPewRiNq72wSmENUs8WP
         2kzzxYIExT/C4VY0UJKR1y6MA5abB8jspoQyG/lnwjTZ0qGUKjLsZVgmC1LUExGDB1qS
         ThMg==
X-Gm-Message-State: APjAAAUNQnqX3r3CSQbDqJhZEoD76i5MSSnGmKWvgwbfci6f9V/QHqwT
        50RVSFYs0D8KJ4N046fmEvaXgNfIS60sD0S0OllabQ==
X-Google-Smtp-Source: APXvYqyWNYBLV4BC5Sv5fLkv9GmqJnZaQDbjj5Qtse3dhDZOPkGzz+SdDYrUQWZeJfzXJwYOCdFroOvUXMpRCwlQUYE=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr26526583otk.145.1565785430200;
 Wed, 14 Aug 2019 05:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
 <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de> <CAMz4kuJURx=fPE6+0gP4ukzMcXr_z3t1ZH0K3Gv6=o4Od4uc7w@mail.gmail.com>
 <20190814092339.73ybj5mycklvpnrq@pengutronix.de> <CAMz4ku+3txx5kO-u_+_pxFwoovnX81WFF-moNBasUUgEpvQb+Q@mail.gmail.com>
 <20190814105535.svslc57qp3wx5lub@pengutronix.de>
In-Reply-To: <20190814105535.svslc57qp3wx5lub@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 14 Aug 2019 20:23:37 +0800
Message-ID: <CAMz4ku+H1++pzZ9pAw2N6Z342j3NMBwfRj9VZTdsihtZYzuFOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: sprd: Add Spreadtrum PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Wed, 14 Aug 2019 at 18:55, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Baolin,
>
> On Wed, Aug 14, 2019 at 06:01:50PM +0800, Baolin Wang wrote:
> > On Wed, 14 Aug 2019 at 17:23, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Wed, Aug 14, 2019 at 04:42:28PM +0800, Baolin Wang wrote:
> > > > On Tue, 13 Aug 2019 at 23:16, Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > On Tue, Aug 13, 2019 at 09:46:41PM +0800, Baolin Wang wrote:
> > > > > [...]
> > > > Not really, our hardware's method is, when you changed a new
> > > > configuration (MOD or duty is changed) , the hardware will wait for=
 a
> > > > while to complete current period, then change to the new period.
> > >
> > > Can you describe that in more detail? This doesn't explain why MOD mu=
st be
> > > configured before DUTY. Is there another reason for that?
> >
> > Sorry, I did not explain this explicitly. When we change a new PWM
> > configuration, the PWM controller will make sure the current period is
> > completed before changing to a new period. Once setting the MOD
> > register (since we always set MOD firstly), that will tell the
> > hardware that a new period need to change.
>
> So if the current period just ended after you reconfigured MOD but
> before you wrote to DUTY we'll see a bogus period, right? I assume the
> same holds true for writing the prescale value?

I confirmed again, I am sorry I missed something before. Yes, like you
said before, writing DUTY triggers the hardware to actually apply the
values written to MOD and DUTY to the output. So write DUTY last. I
will update the comments and change the PWM configure like:

sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);

>
> > The reason MOD must be configured before DUTY is that, if we
> > configured DUTY firstly, the PWM can work abnormally if the current
> > DUTY is larger than previous MOD. That is also our hardware's
> > limitation.
>
> OK, so you must not get into a situation where DUTY > MOD, right?
>
> Now if the hardware was configured for
>
>         period =3D 8s, duty =3D 4s
>
> and now you are supposed to change to
>
>         period =3D 2s, duty =3D 1s
>
> you'd need to write DUTY first, don't you?
>
> > > > > > +static int sprd_pwm_remove(struct platform_device *pdev)
> > > > > > +{
> > > > > > +     struct sprd_pwm_chip *spc =3D platform_get_drvdata(pdev);
> > > > > > +     int ret, i;
> > > > > > +
> > > > > > +     ret =3D pwmchip_remove(&spc->chip);
> > > > > > +
> > > > > > +     for (i =3D 0; i < spc->num_pwms; i++) {
> > > > > > +             struct sprd_pwm_chn *chn =3D &spc->chn[i];
> > > > > > +
> > > > > > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn=
->clks);
> > > > >
> > > > > If a PWM was still running you're effectively stopping it here, r=
ight?
> > > > > Are you sure you don't disable once more than you enabled?
> > > >
> > > > Yes, you are right. I should check current enable status of the PWM=
 channel.
> > > > Thanks for your comments.
> > >
> > > I didn't recheck, but I think the right approach is to not fiddle wit=
h
> > > the clocks at all and rely on the PWM framework to not let someone ca=
ll
> > > sprd_pwm_remove when a PWM is still in use.
> >
> > So you mean just return pwmchip_remove(&spc->chip); ?
>
> right.
>
> I just rechecked: If there is still a pwm in use, pwmchip_remove returns
> -EBUSY. So this should be safe.

Yes. Thanks for your comments.


--
Baolin Wang
Best Regards
