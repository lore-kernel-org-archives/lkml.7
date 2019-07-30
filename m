Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BD2C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B45020693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGeKrw2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbfG3PVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:21:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33605 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfG3PVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:21:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so62492539ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MG2uESR/rqGAii9OuT81fn+mPhryV7xhqi5TZl0qFMk=;
        b=CGeKrw2UEUvEF9TB41pSbpYqYQas8n0EeDi8PNf5NigJ551ES1S+2iHYS9mB2dY4FA
         TTlHs4Kx+SfLXiKGeF2hhuUmLPIF4Irxq/QSbfSq5eYed/Cw8PLzfPrCq1TkavwpxBkC
         EKq1ijZ4OOY4z8mxIb16mmOcOqn/yST4XTn0yUfT6y+NXSHrp0pK5Umx8yRPfg+ApKlr
         Ml1WrH3xyuktFdPOEOAlpRc1euyKKcyIbWtxejWLqksMQ7u2FdTPU5IGonAOPnXp/cyX
         eoADNw5qsveuBUWZ/48Zq1WqlxAv4Xu8bry2XL8KVtRXuun7EErji9o7j/Q8/C6/wF0z
         /nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MG2uESR/rqGAii9OuT81fn+mPhryV7xhqi5TZl0qFMk=;
        b=jny6mLGh9SIdgGA+Rs49C0GShYxvV1K5uO4PwH9H2IjZouBOg4XXfC0uH8NNkMOO7f
         bpAlvByFMBnUvrZYkWL9qDqmMcbe8LfvH0jSvHwCz5eO7AmR8DX6zTAMiv8lhKAR/hNc
         TQAupzOQiv2OdMBOusOcn9Oc3f67Qy53Iks2bnfJW2IuBmGevw45gdZPFVB5GswkHZet
         Gbm9AVeHlvpcU7ljIUlqfNm7z2RNks9vpwLDcryczOEHYWpIwZAIDjilEe2Me5986PYR
         Mc4z6fYIgEVuwul6e1WCEc+N/z+otaueGAon04L7oNz4y8DWFj0yxQIjAHuq4mjBdjvv
         +zog==
X-Gm-Message-State: APjAAAUfm0gQ5FusqPYJeir2WWrzxqG3npD1Xp3Kh2xOeMyeiFAk4w+H
        Kq+X5jeXZmkQfHLICeVT95Seaa6D5mvY2P2WhUOsWQ==
X-Google-Smtp-Source: APXvYqzi7DOMgLIM8JK5U+buE6uItaAr8eoQ6MggIDs84C7vMEhpVZ3HVq7gl04GkYMg5bDms9Ix71ZA2T3joY+EkxQ=
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr62972518ljj.156.1564500074646;
 Tue, 30 Jul 2019 08:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190726112737.19309-1-anders.roxell@linaro.org>
 <20190726122956.GC26088@lakrids.cambridge.arm.com> <20190726151825.GA12552@e121166-lin.cambridge.arm.com>
 <20190730112415.GB51922@lakrids.cambridge.arm.com> <20190730112758.ctgg6l5gldsefdgs@willie-the-truck>
 <CADYN=9+9wnpX1jSaDmowDov9GerQsdobxnVqwAf=WGk=7-VcRw@mail.gmail.com> <20190730124352.iwh5kbnc2d76mqyf@willie-the-truck>
In-Reply-To: <20190730124352.iwh5kbnc2d76mqyf@willie-the-truck>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 30 Jul 2019 17:21:03 +0200
Message-ID: <CADYN=9+9pUuMVwEw1_mgLsGMmB3Hm_EHr9vbwQZ_Axd7o9VFZw@mail.gmail.com>
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

On Tue, 30 Jul 2019 at 14:43, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jul 30, 2019 at 02:30:27PM +0200, Anders Roxell wrote:
> > On Tue, 30 Jul 2019 at 13:28, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Tue, Jul 30, 2019 at 12:24:15PM +0100, Mark Rutland wrote:
> > > > On Fri, Jul 26, 2019 at 04:18:25PM +0100, Lorenzo Pieralisi wrote:
> > > > > On Fri, Jul 26, 2019 at 01:29:56PM +0100, Mark Rutland wrote:
> > > > > > On Fri, Jul 26, 2019 at 01:27:37PM +0200, Anders Roxell wrote:
> > > > > > > When fall-through warnings was enabled by default the followi=
ng warning
> > > > > > > was starting to show up:
> > > > > > >
> > > > > > > ../drivers/perf/arm_pmu.c: In function =E2=80=98cpu_pm_pmu_no=
tify=E2=80=99:
> > > > > > > ../drivers/perf/arm_pmu.c:726:3: warning: this statement may =
fall
> > > > > > >  through [-Wimplicit-fallthrough=3D]
> > > > > > >    cpu_pm_pmu_setup(armpmu, cmd);
> > > > > > >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > ../drivers/perf/arm_pmu.c:727:2: note: here
> > > > > > >   case CPU_PM_ENTER_FAILED:
> > > > > > >   ^~~~
> > > > > > >
> > > > > > > Rework so that the compiler doesn't warn about fall-through.
> > > > > > >
> > > > > > > Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through =
warning")
> > > > > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > > > > > ---
> > > > > > >
> > > > > > > I'm not convinced that this is the correct patch to fix this =
issue.
> > > > > > > However, I can't see why we do 'armpmu->start(armpmu);' only =
in 'case
> > > > > > > CPU_PM_ENTER_FAILED' and why we not call function cpu_pm_pmu_=
setup()
> > > > > > > there also, since in cpu_pm_pmu_setup() has a case prepared f=
or
> > > > > > > CPU_PM_ENTER_FAILED.
> > > > > >
> > > > > > I agree, think that should be:
> > > > > >
> > > > > >   case CPU_PM_EXIT:
> > > > > >   case CPU_PM_ENTER_FAILED:
> > > > > >           cpu_pm_pmu_setup(armpmu, cmd);
> > > > > >           armpmu->start(armpmu);
> > > > > >           break;
> > > > > >
> > > > > > ... so that we re-start the events before we start the PMU.
> > > > > >
> > > > > > That would be a fix for commit:
> > > > > >
> > > > > >   da4e4f18afe0f372 ("drivers/perf: arm_pmu: implement CPU_PM no=
tifier")
> > > > >
> > > > > Yes that's correct, apologies. Probably we did not hit it because=
 CPU PM
> > > > > notifier entry failures are a pretty rare event; regardless:
> > > > >
> > > > > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > >
> > > > > I can send the updated fix, just let me know.
> > > >
> > > > I'm not sure what Will wants, but assuming you do so:
> > > >
> > > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > >
> > > I gave up waiting
> >
> > I'm sorry for letting you wait.
>
> No, not at all. It's just that everybody was piling in with patches for
> these issues and I suspected you were busy dealing with responses. Rather
> than wait, I figured the best bet was just to get this fixed.

Thanks.

>
> Are you going to respin the SMMUv3 change per Robin's feedback?

Yes, just sent it.

Cheers,
Anders
