Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0DAC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A22C206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POxFZTmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfLCFC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:02:57 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34813 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCFC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:02:56 -0500
Received: by mail-ua1-f67.google.com with SMTP id w20so871681uap.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 21:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ERmn5rq1lNnKn/P5AfwLSlBRWPm9K3lY7uKonmiuBQ=;
        b=POxFZTmnXWUJj/QSh7bNjrQKeTsKp9x3JT1UUj5Ox6CqdlasjfT0Sd+kJ3yIifanpH
         HW2KVRp/PAkRCh2/C7bnkMFPgn4E1kk6Bzfl6NKEJgMromg15+AgJGXTCKsn4fDbGhNN
         OSh5T7Lb8Ux1Hea4sE7xKWAMtj2ar9CYDt0pFzeBeufb8xWPARB2lBCWO9vTD8ITG15l
         6tte8NbCCmSfn4qKmeTnC0WLC2yg8+vRWEd31YGTDiCbzpmVDG7f7SM2yJwQz9r5509K
         uLrb+EceyEOJqhtbWNSDxAD+Ll3BJHT3t2BjpEjLLZYAgHbkeB1sHX4dS8mduopLI8uj
         7NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ERmn5rq1lNnKn/P5AfwLSlBRWPm9K3lY7uKonmiuBQ=;
        b=UiQAao3ZHMWbbIEV9TsTuOlfabKL5Wi+AnFaxi79zXBI4yz1yBcDYEOjp7zFuBe8FB
         U7DniThgRq8kAzkQ4hex1bDs+ZjfugicJOrHEkP47MZgtO7fokDIjjlUbF+9qMDtOdN/
         vnVoxaRGxvYfu/qinLC33NGGn3R9/k5eAeiwTItfCmoc0v0td113KBnVPacNVqQ7nnAN
         /CfCTZ7+92YlHenqTYjAnKomIDtTyukYcMRDnPunFZDm31sKxwJ7OQacB5kIgbOTFnYl
         UbhOxNIDhmd4vjX/n7+bsNbuexSGFBm4luP0rVYrqfrr5PyjSFDrdYtKlB1Nz1ejzwOw
         k7ew==
X-Gm-Message-State: APjAAAV/cOwNSmLzZYTCP868Wbvz9F6ZGPY48FI0FDXGT2xVkkeLrEdz
        8Ts/zP0VWeDcMKeKD4Ds0lJGX3QGCFU+1WWe8FFY3g==
X-Google-Smtp-Source: APXvYqyk8mjX0oY3ryDpuMEExI9RS0dYRl+SayJdvhnyj2hjEpQI3jjLtCw/e3hNiCcN7gK3acNuNVLsVTiJEV5H3RE=
X-Received: by 2002:ab0:7027:: with SMTP id u7mr2136566ual.94.1575349375038;
 Mon, 02 Dec 2019 21:02:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573499020.git.amit.kucheria@linaro.org>
 <4b949a4f401a7f9d403ed0f0c16c7feb083f3524.1573499020.git.amit.kucheria@linaro.org>
 <20191112193852.GC3140946@builder> <CAHLCerN1VXhU0VQWN15PB2R16mkCV0i6Mn3+LW=xXtB5_7Z6JQ@mail.gmail.com>
 <20191128214339.GL82109@yoga>
In-Reply-To: <20191128214339.GL82109@yoga>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 3 Dec 2019 10:32:43 +0530
Message-ID: <CAHLCerPmdTTfANng2uNnTRs0-Sz+jtstOD9N0MbLEvV3DYDUFw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drivers: thermal: tsens: Add critical interrupt support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 3:13 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 28 Nov 10:46 PST 2019, Amit Kucheria wrote:
>
> > On Wed, Nov 13, 2019 at 1:08 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Mon 11 Nov 11:21 PST 2019, Amit Kucheria wrote:
> > >
> > > > TSENS IP v2.x adds critical threshold interrupt support for each sensor
> > > > in addition to the upper/lower threshold interrupt. Add support in the
> > > > driver.
> > > >
> > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > ---
> > > >  drivers/thermal/qcom/tsens-common.c | 129 ++++++++++++++++++++++++++--
> > > >  drivers/thermal/qcom/tsens-v2.c     |   8 +-
> > > >  drivers/thermal/qcom/tsens.c        |  21 +++++
> > > >  drivers/thermal/qcom/tsens.h        |  73 ++++++++++++++++
> > > >  4 files changed, 220 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > > > index 4359a4247ac3..2989cb952cdb 100644
> > > > --- a/drivers/thermal/qcom/tsens-common.c
> > > > +++ b/drivers/thermal/qcom/tsens-common.c
> > > > @@ -23,6 +23,10 @@
> > > >   * @low_thresh:     lower threshold temperature value
> > > >   * @low_irq_mask:   mask register for lower threshold irqs
> > > >   * @low_irq_clear:  clear register for lower threshold irqs
> > > > + * @crit_viol:      critical threshold violated
> > >
> > > "violated" as in "temperature is above crit_thresh"?
> >
> > Yes.
> >
> > >
> > > > + * @crit_thresh:    critical threshold temperature value
> > > > + * @crit_irq_mask:  mask register for critical threshold irqs
> > > > + * @crit_irq_clear: clear register for critical threshold irqs
> > > >   *
> > > [..]
> > > > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > > > index 7d317660211e..784c4976c4f9 100644
> > > > --- a/drivers/thermal/qcom/tsens.c
> > > > +++ b/drivers/thermal/qcom/tsens.c
> > > > @@ -121,6 +121,27 @@ static int tsens_register(struct tsens_priv *priv)
> > > >
> > > >       enable_irq_wake(irq);
> > > >
> > > > +     if (tsens_version(priv) > VER_1_X) {
> > > > +             irq = platform_get_irq_byname(pdev, "critical");
> > > > +             if (irq < 0) {
> > >
> > > Treating this as a fatal error breaks backwards compatibility with
> > > current devicetree; and even within your patch series, tsens should fail
> > > to probe between this patch and the application of patch 3.
> >
> > Good catch.
> >
> > > Please flip this around and do:
> > >
> > > irq = platform_get_irq_byname(pdev, "critical");
> > > if (irq >= 0 && tsens_version(priv) > VER_1_X) {
> > >         request_irq()...
> > > }
> >
> > Won't this still break with current devicetree since irq < 0 until
> > patch 3? Or are you saying we shouldn't check for
> > platform_get_irq_byname() failure?
> >
>
> I'm trying to say that dtsi without "critical" defined should cause the
> driver to simply skip this segment, not fail to initialize.
>
> > I can see two ways out:
> > 1. We patch the dtsi before the code change.
>
> You're expected to maintain backwards compatibility with existing dtb
> files out there. The support for critical interrupt is an additional
> feature, so you should be able to do this by detecting if "critical" is
> defined (e.g. by checking the return value of
> platform_get_irq_byname()).
>
> > 2. We make critical interrupt failure non-fatal by just printing some
> > messages and still returning success.
> >
>
> Try to make it as specific as possible (without adding a bunch of code)
> and throw in a dev_info() if no "critical" is found.

I believe I have now addressed the problem in v2 explicitly overriding
the return value in case of failure in the critical interrupt irq
setup path and simply printing a warning.

In hindsight, critical interrupt support should've been added in the
same series as uplow interrupt support so avoid having to support
"intermediate" DTS file state for one kernel version.

Regards,
Amit
