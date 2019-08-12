Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D161AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06FE2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/FQAQab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfHLJu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:50:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35906 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfHLJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:50:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so24447295otr.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kb6hKbAOMVuL+Z26AT+EFtx5MG6TEv4wDdw/myrwQ+U=;
        b=J/FQAQab+aixe22PRiNBu7L0NDde/C2hXCpVftTRoFGOw8pRPugy3jP0wAggy8vjCm
         t6iYDnybfvsXId9UDaJ6ra2ggQZjX/pPV7V0RaQQo5sWAlef03HV1CBPikWbu35fGUaP
         +2CY8yvvMO5AVEWYwePAUANCHClK5pvFLXHuGXJ8zJYXkHxttupBdaMQ+vMsDf0Ek7Io
         GSxTlREe+2RKcuaQIPUqEbKOEoGsUH1zL6busYQSHgBYFmjYzScZKtab9ogTkKx4BaGZ
         omp227gqxhuEVfzZTRokfaSkUgdbU3MKAkbZqDJEn7Qcy4Dqnx1ITa/GaH5H0y4pYKxQ
         MGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kb6hKbAOMVuL+Z26AT+EFtx5MG6TEv4wDdw/myrwQ+U=;
        b=r0IYdxF4+/PkCsQuXYIVYfnp4aeP50XIH9dv3CjZOBAlq2tYtnn8Odt4XaIic701lk
         HVgpf1Jdkd5DWaSVvKzPA1LCYM3Hpzg7x4b+9GJLaYSbC6G3Polu++r6EjphArhr2RnH
         fIKNcM1XXiqvDlz9cr0A/OYO0LNvDR+HJiZO27MnoElB/BmuathO2xWhWsFlu4RDVr5f
         HZZ1CIfpvM/KscfTL9fBO7ZGCXyt4a2Su6+az0QFQXnii50zS583Fz/Np/q3tsxQUjhi
         NjBzUm34Z/JApiQBtBUCLS02fVZspLkOUuRjWRPC17rJmcQjWqSK0gEm1HDurdedThVN
         abhw==
X-Gm-Message-State: APjAAAUCCHJ5UTINX3pHEUAEmLzwHOeuublpsfEEvWQof7uwG6ZyllFo
        0cpID5L7Y97LPx/6JDQcB/S1LQmduh2gWcMfMr+kLg==
X-Google-Smtp-Source: APXvYqz4lQF7XDSq19OS08secxgAHIh9LEA1ri4DLDT1TwYKNppMdi6ToK3pQQF+F0v8y5u7kQqQDs82eRZLhuJM5A8=
X-Received: by 2002:aca:6056:: with SMTP id u83mr14334202oib.27.1565603457156;
 Mon, 12 Aug 2019 02:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de> <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
 <20190809144124.3as3rtctlywxkudr@pengutronix.de> <CAMz4ku+o6dCyxhR3-5yM+zr2nBpTQG5A8Pbnxpo7yRciwPbv3Q@mail.gmail.com>
 <20190812083556.dvprpwv6mjy3cjae@pengutronix.de> <CAMz4kuJA81ZP6Kc63dPV1jEn1ah=jow6tQBfO=UDCcTzSf3y-A@mail.gmail.com>
 <20190812094607.yg7efmvefewxicke@pengutronix.de>
In-Reply-To: <20190812094607.yg7efmvefewxicke@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 12 Aug 2019 17:50:45 +0800
Message-ID: <CAMz4kuKDcFxbNPqS-MToiCGQCXKDSvFX75ML+iVJGZx6kL0gzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
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

On Mon, 12 Aug 2019 at 17:46, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Baolin,
>
> On Mon, Aug 12, 2019 at 05:11:56PM +0800, Baolin Wang wrote:
> > On Mon, 12 Aug 2019 at 16:36, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Mon, Aug 12, 2019 at 03:29:07PM +0800, Baolin Wang wrote:
> > > > The clock framework supplies 'assigned-clocks' and
> > > > 'assigned-clock-parents' properties to set parent, but for our case=
 we
> > > > still want to set a default clock rate if failed to set parent when
> > > > met some abnormal things.
> > >
> > > Without understanding the complete problem I'd say this is out of the
> > > area the driver should care about.
> >
> > Fair enough, I will try to use 'assigned-clocks' and
> > 'assigned-clock-parents' to simplify the code.
>
> There is also assigned-clock-rates if you need that.

Thanks for reminding, but we have no use case to set clock rate in PWM driv=
er.

--=20
Baolin Wang
Best Regards
