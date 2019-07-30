Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D819C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B6E206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcHbAFaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfG3Mam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:30:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43781 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbfG3Mak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:30:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so44580873lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CSfAM+gQ83XDaCNQg7r2LymDSaYozQKa9yvOaipRrHw=;
        b=YcHbAFaq93T4Zd6Gr5USiR2fPHQ71TjN2iFO68zfokUsiUXHtSvTQhdwY4Fwwhw4p2
         QAFwFQe3kSqg7/+Ad4vM4NoB5JGqpFcMIDw38BlA9kIe8YNk3A89nlp9hz5D9hNSAdxR
         51sz9+kqtPSfhaH4zUX6M2DK9Gl46AeG3S/uvMj68hNHzdgx4Uas/1yi4sP0kkJuSIf+
         DloKwpPnqTb+gN4kQEj3C/DOiShZrBI979u3ZLjl9we3uYL5sMQdidw5IN1h9v2C24k1
         gP7wOmDYR4KBmq1AQTULDiNPw61vGuHnG4HiCjYNdSTEX/0J/yZX8K2kz1PR98Ic2abB
         zMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CSfAM+gQ83XDaCNQg7r2LymDSaYozQKa9yvOaipRrHw=;
        b=sBZAoRJKGhARvbNYxezb2sSN+1cgGFpq0u/zKcj9f9m/yx+gNGlUSzIckBdxcjaLip
         FUo2xSz8a+irLpwEQ87SORXWxvFlRAguIMXD9Tgtb8iuMGGqFw1PggzRt/kauqECuLE3
         RYUc6Jl8ltK7bBSutiHoXMxVo8ktf/RB1znkusEOFiBH4QX/H1tw5nS4LHDzRGXXho3K
         Rh4y3II3aeBvB+6aprIg1ypX4Ar4PFYrXK5vIXLA/Mpysy3UjuwSYuB0P3p0lHqqgeYV
         HD8CF4G+MN86md+pd/Nza22io1HG7gkWqeHKD9gn+180NGbCnQImH7PqbwK4GQVeAgqG
         FWBg==
X-Gm-Message-State: APjAAAWs0B1wrSloe7UJQUn1tSgCdGcd9VB6EHxAlR+BZep0k2zEvSrD
        Ua6m/uR+EEv6F+05VQ322P9y/NdffIM3EQGklyj8ow==
X-Google-Smtp-Source: APXvYqwfYsLN+ZvekCLKF3p2gBcRgDY5HwZspqX9F2tsBCNfvaaPjNDOymzkH2LYNrRBJDwAY/7q4iGv3TvWJHaT59o=
X-Received: by 2002:ac2:4c82:: with SMTP id d2mr37163207lfl.89.1564489838284;
 Tue, 30 Jul 2019 05:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190726112737.19309-1-anders.roxell@linaro.org>
 <20190726122956.GC26088@lakrids.cambridge.arm.com> <20190726151825.GA12552@e121166-lin.cambridge.arm.com>
 <20190730112415.GB51922@lakrids.cambridge.arm.com> <20190730112758.ctgg6l5gldsefdgs@willie-the-truck>
In-Reply-To: <20190730112758.ctgg6l5gldsefdgs@willie-the-truck>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 30 Jul 2019 14:30:27 +0200
Message-ID: <CADYN=9+9wnpX1jSaDmowDov9GerQsdobxnVqwAf=WGk=7-VcRw@mail.gmail.com>
Subject: Re: [PATCH] arm_pmu: Mark expected switch fall-through
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 at 13:28, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jul 30, 2019 at 12:24:15PM +0100, Mark Rutland wrote:
> > On Fri, Jul 26, 2019 at 04:18:25PM +0100, Lorenzo Pieralisi wrote:
> > > On Fri, Jul 26, 2019 at 01:29:56PM +0100, Mark Rutland wrote:
> > > > On Fri, Jul 26, 2019 at 01:27:37PM +0200, Anders Roxell wrote:
> > > > > When fall-through warnings was enabled by default the following w=
arning
> > > > > was starting to show up:
> > > > >
> > > > > ../drivers/perf/arm_pmu.c: In function =E2=80=98cpu_pm_pmu_notify=
=E2=80=99:
> > > > > ../drivers/perf/arm_pmu.c:726:3: warning: this statement may fall
> > > > >  through [-Wimplicit-fallthrough=3D]
> > > > >    cpu_pm_pmu_setup(armpmu, cmd);
> > > > >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > ../drivers/perf/arm_pmu.c:727:2: note: here
> > > > >   case CPU_PM_ENTER_FAILED:
> > > > >   ^~~~
> > > > >
> > > > > Rework so that the compiler doesn't warn about fall-through.
> > > > >
> > > > > Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warn=
ing")
> > > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > > > ---
> > > > >
> > > > > I'm not convinced that this is the correct patch to fix this issu=
e.
> > > > > However, I can't see why we do 'armpmu->start(armpmu);' only in '=
case
> > > > > CPU_PM_ENTER_FAILED' and why we not call function cpu_pm_pmu_setu=
p()
> > > > > there also, since in cpu_pm_pmu_setup() has a case prepared for
> > > > > CPU_PM_ENTER_FAILED.
> > > >
> > > > I agree, think that should be:
> > > >
> > > >   case CPU_PM_EXIT:
> > > >   case CPU_PM_ENTER_FAILED:
> > > >           cpu_pm_pmu_setup(armpmu, cmd);
> > > >           armpmu->start(armpmu);
> > > >           break;
> > > >
> > > > ... so that we re-start the events before we start the PMU.
> > > >
> > > > That would be a fix for commit:
> > > >
> > > >   da4e4f18afe0f372 ("drivers/perf: arm_pmu: implement CPU_PM notifi=
er")
> > >
> > > Yes that's correct, apologies. Probably we did not hit it because CPU=
 PM
> > > notifier entry failures are a pretty rare event; regardless:
> > >
> > > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > >
> > > I can send the updated fix, just let me know.
> >
> > I'm not sure what Will wants, but assuming you do so:
> >
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> I gave up waiting

I'm sorry for letting you wait.

>, so it's already queued here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=
=3Dfor-next/fixes&id=3D0d7fd70f26039bd4b33444ca47f0e69ce3ae0354

Thanks for fixing it.

Cheers,
Anders
