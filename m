Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38F3C2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75249206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAZovbzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLDHKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:10:38 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:33599 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfLDHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:10:38 -0500
Received: by mail-qt1-f181.google.com with SMTP id d5so6778909qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 23:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FoH24prRqjuYLXuwyUpm8iFK/jB9SCwX9PmqD0+uB3k=;
        b=dAZovbzV5b5d/sU3m2nFWIn3kT2RzhUfvdoV74Hs70IdTHVUaObf67ed8gAw9GunIt
         7mcUjEsbonBBeSV/SGSDjP4ojbAkK05wUILd9/NFWoPwq4JIhf7fmaDUTAhCnI+81ksr
         EAPBPRykfVcjK+twCfyPhHhLO9c0nCRdaHMNodoBbNndt6g0RsoAfbXNbfwX3O3ZIiCg
         I3nD5/mJQ74tGRmCUck/16C5E5K8UEvnx0bN9efIDDRDJCJnlhSz67Ei2459JPIBJ+bU
         akTdN58OpV8IOu2M6NTO7ZWnxsoivwZfiIIeD3u4emJqWYYKNelgmp3sIB0Fts8WWLSz
         y1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FoH24prRqjuYLXuwyUpm8iFK/jB9SCwX9PmqD0+uB3k=;
        b=I8K3K2/ePnmy2QyJB/ENEECtxtuOOfGBpOzdbjUBOcVuDonD2bqqLRJpBXz6qmATGx
         o+AHWfixASvdYGlS6KYikoLun4aQg3nFx3xpEeggX7CF8yyp+pknkKUeMJaQ7OBSdWTf
         kNVfC4zNEt3TG8+vNfHdtVZ1PFqfl6QDq0iOCobZ+knUlABTw06hUv7aSsklWcU0obE2
         ecKARsF9N2JVzzBUW9BRdn96fqjbaIoQooon00WkjwPQza+yFQHUxVAldKqydwByQlhI
         1yoNc9AF16vGaMjm8ADnXqeHolm+nTvFFlM5mQ40195TWLPcDQyMPsJr4rSNVaJoiakc
         KNsw==
X-Gm-Message-State: APjAAAXI0mbOz3SCA2Tvjo1md+7dUn01+QfoZpuDsJ77GsnTSQ0U5cJZ
        rwYUANlQOvU1SYCAe1i+FGfE/PpzshGdMeFcd2QWHA==
X-Google-Smtp-Source: APXvYqzdZWkOTSjtEhCab5JFf8/MyIT+x2Q9c27MNI4zCxtt6eydpzFhKrh/KAeIx4HawkCuL8Q6xLqs1rmdQUKrDxY=
X-Received: by 2002:ac8:3177:: with SMTP id h52mr1491863qtb.264.1575443436869;
 Tue, 03 Dec 2019 23:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20191203093704.7037-1-daniel.lezcano@linaro.org>
 <20191203093704.7037-2-daniel.lezcano@linaro.org> <CAP245DV=kd=LdvgZ2x1Q8-ZahpS3423Z9vHXw91N20aQ6DKxAQ@mail.gmail.com>
 <7e851d43-ecb5-179a-ebfd-847dffd29636@linaro.org>
In-Reply-To: <7e851d43-ecb5-179a-ebfd-847dffd29636@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 4 Dec 2019 12:40:25 +0530
Message-ID: <CAP245DXJZ9pTmFBD2EcOk6pkbYr+n1tR1o2AAZvGeiaf=U1rHQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] thermal/drivers/cpu_cooling: Add idle cooling
 device documentation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 12:20 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Amit,
>
> thanks for the review.
>
>
> On 04/12/2019 05:24, Amit Kucheria wrote:
>
> [ ... ]
>
> >> +the CPUs will have to wakeup from a deep sleep state.
> >> +
> >> +     ^
> >> +     |
> >> +     |
> >> +     |-------       -------       -------
> >> +     |_______|_____|_______|_____|_______|___________
> >> +
> >> +      <----->
> >> +       idle  <---->
> >> +              running
> >> +
> >> +With the fixed idle injection duration, we can give a value which is
> >> +an acceptable performance drop off or latency when we reach a specifi=
c
> >> +temperature and we begin to mitigate by varying the Idle injection
> >> +period.
> >> +
> >
> > I'm not sure what it the purpose of this statement. You've described
> > how the period value starts at a maximum and is adjusted dynamically
> > below.
>
> We can have different way to inject idle periods. We can increase the
> idle duration and/or keep this duration constant but make a variation of
> the period. This statement clarify the method which is the latter
> because we want to have a constant latency per period easier to deal with=
.

I think I read period as duration leading to confusion. I suggest
using duty-cycle instead of period throughout this series. I think it
will improve the explanation.

The above paragraph could be rewritten as:

"We use a fixed duration of idle injection that gives an acceptable
performance penalty and a fixed latency. Mitigation can be increased
or decreased by modulating the duty cycle of the idle injection."

Perhaps you could also enhance your ascii art above to show fixed
duration idles and different duty cyles to drive home the point.

> >> +The mitigation begins with a maximum period value which decrease when
> >
> > Shouldn't the idle injection period increase to get more cooling effect=
?
>
> The period is the opposite of the frequency. The highest the period, the
> lowest the frequency, thus less idle cycles and lesser cooling effect.

Yeah, I definitely confused period with duration :-)

> >> +more cooling effect is requested. When the period duration is equal t=
o
> >> +the idle duration, then we are in a situation the platform can=E2=80=
=99t
> >> +dissipate the heat enough and the mitigation fails. In this case the
> >> +situation is considered critical and there is nothing to do. The idle
> >> +injection duration must be changed by configuration and until we reac=
h
> >> +the cooling effect, otherwise an additionnal cooling device must be
> >
> > typo: additional
> >
> >> +used or ultimately decrease the SoC performance by dropping the
> >> +highest OPP point of the SoC.
> >> +
> >> +The idle injection duration value must comply with the constraints:
> >> +
> >> +- It is lesser or equal to the latency we tolerate when the mitigatio=
n
> >
> > s/lesser/less than/
> >
> >> +  begins. It is platform dependent and will depend on the user
> >> +  experience, reactivity vs performance trade off we want. This value
> >> +  should be specified.
> >> +
> >> +- It is greater than the idle state=E2=80=99s target residency we wan=
t to go
> >> +  for thermal mitigation, otherwise we end up consuming more energy.
> >> +
> >> +Minimum period
> >> +--------------
> >> +
> >> +The idle injection duration being fixed, it is obvious the minimum
> >
> > Change to:
> > When the idle injection duration is fixed,
> >
>
> The idle duration is always fixed in the cpuidle cooling device, why do
> you want to add the sentence above?

Ignore for now.

Regards,
Amit
