Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EC6C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA2D2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGG0G4TD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKULOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:14:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51848 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKULOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:14:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id g206so2990451wme.1;
        Thu, 21 Nov 2019 03:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+XKnyLW7EkXsYW0OJmmjEyRkfOHk15VlPRrsfW5K/GQ=;
        b=nGG0G4TDZ07B5ePVOevmNed8Et1MxEL8/RLS2CZCsI3i2+dw5ppqEaLBa0/XU+Hn9C
         vwj7h6rhsaO1fP/VpRHyiZxu97Qg7Vh8Lg/EV0EN7KDxAKyjscm+ivNN0nR7Hq16zlDn
         UxBoWD4TOdk0M0dAwS61sQJmIQr4v5mu4zt8bTficpjzxGVqXiRBHOdEECVs2cO2bVDP
         36MN5auC1PKorNXd5Acq/UTBB3TnKhvbn7UabyyG0Ba+D4jAN1F+LNccAFm7reJG7Psl
         OH1rlHrIR3vDmCqgS5mwQrmL4GtPN6vQkri9GRQD3LdnOClpiS3cx3C/O+NBui3nBRhs
         jNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+XKnyLW7EkXsYW0OJmmjEyRkfOHk15VlPRrsfW5K/GQ=;
        b=ZtHA8VrSBjy6alkSnGjPbqElLh3CAWsyspsPLImlMRdgBSWYXtyXJHgwnvjzPzlKzu
         n2T/xmr5ahsuMvK7tS3ZefQElmbPdOYYQ1gxrwX/99WPpSi7hB97wyCW9mrjLZuBIWwn
         LCSc+V15CPt8ndWbRHXKi1h5g8RxFb+OX8FKufocCpJpQhfwyFIdz45CDkEkd0a6nHhG
         XUkdkemdm1r+/9sRlWEU4Yl+diXysjQZHejgdQKU118Fu17TtdmAix+N0qc4Loeblbzv
         n6UAA485xwAJCgJwoxSkv1pU8MUucSSs/W04wHdsEg0H4j6ygdVBcWFRNmUyOlH8F9rU
         HxZg==
X-Gm-Message-State: APjAAAXYSCZtVjX+tZOgMR9rn7ZzzXjfhVs0uHq7d6xh+ktnhkm+Zs3l
        lCJyjkBRpgXNIYYmGZujdMunFSpQR+sLt72yPrU=
X-Google-Smtp-Source: APXvYqy4gWhRFyEMy2eA/GJL+WSgZR1v22hDCvHKX8RxCdIYCTXzWX/G5nJmVbFrWcNa9M53KSqxoxL+RA6fDm/PDhg=
X-Received: by 2002:a1c:a512:: with SMTP id o18mr8822754wme.4.1574334885350;
 Thu, 21 Nov 2019 03:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20191119175319.16561-1-peron.clem@gmail.com> <20191119175319.16561-5-peron.clem@gmail.com>
 <20191121072829.vitly7altcvlt4sj@pengutronix.de>
In-Reply-To: <20191121072829.vitly7altcvlt4sj@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 21 Nov 2019 12:14:34 +0100
Message-ID: <CAJiuCceMjLGsFW8sVsHO3iz+rOXpvGfSYUDDOsbhx3A159cZQg@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] pwm: sun4i: Add an optional probe for bus clock
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Thu, 21 Nov 2019 at 08:28, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Cl=C3=A9ment,
>
> On Tue, Nov 19, 2019 at 06:53:15PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > +     /*
> > +      * We're keeping the bus clock on for the sake of simplicity.
> > +      * Actually it only needs to be on for hardware register accesses=
.
> > +      */
> > +     ret =3D clk_prepare_enable(pwm->bus_clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Cannot prepare and enable bus_clk\n"=
);
>
> Maybe add the error code to the message?

Ok I will change it for the reset control deassert if you agree.

Clement

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
