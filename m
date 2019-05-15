Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DBDC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C2A2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPfTU82i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEOJ41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:56:27 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46357 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEOJ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:56:27 -0400
Received: by mail-vs1-f68.google.com with SMTP id e2so1261084vsc.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/PxU7IOgFaM/vpcRB7+25UT92kn0Avb7GExq6eQckE=;
        b=UPfTU82iv2+QSBeDe9ByO5SIbVG/hJicOeB1sIQMcwRi5hIGPhnXJ9ts5oKGVhx3PS
         TvcreLnXy/bJb/VDf+ZKo4/DuZZPww1U0jRY0Le3X64RE6EQLLQDDj0OMFzQZzF1bO3i
         tOovIGbRlH8KsDvUDGs4gpxPe9mxXG4PRclFLGJ6Fcm6kQktQhq62SGSbnSX1FmJB8cl
         Lo/H2d9FvINiDP9SIsf6MeqBTOcoI/GAy7X9MtOfgx+d2QhvrEg+loPRWRmwWMma/0rT
         2myYIQ+Xp/lly3LJGwGmXIV7qGo2U62kKXoiAq0duOF/HV9toAqd5g0AW1PoyT41l2DQ
         w8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/PxU7IOgFaM/vpcRB7+25UT92kn0Avb7GExq6eQckE=;
        b=jAAYKH5F9hKSkSpBfkdMBeYTTI4tD+HE59iE1uqjKLNA2EaiFPlf3ooIKLpS6ot8tk
         iG0dgbhrwiJrjIWqKNpF9jg5eeg4G6B3Ip03PAu2Tr66N0XxydgK47Bs7STdAYBjAHHm
         acj8xFtYVm4pwYBQ1PvcXvUEgq1Ynw6JWPJUJo3h3LYEbHNc2W0HCb6txolqTJt4qehS
         YUSUoA8aVvZRo9KnW6zEZl4D+m8gc8fWbQeeBAO9t+gqZ/6oNj0zyhFImswot3h95KpV
         WPRXnCYr7klng+WCJFkayQyxylRWeHkTLLCloGDtIpm3+sdwl7/2dcy1fjqkLmxNwJyr
         8uBw==
X-Gm-Message-State: APjAAAUnmnzLJkgIpNR56B4aERrDi8UDxc45T06u0FjAbb5M0pd0oECH
        KAvlZG/HnbXqbvRzq55YUDVtZbucTVLAiaZfujJjaQ==
X-Google-Smtp-Source: APXvYqyVbCc0ntyYjzrbfP4AYQ+9vS8vTevheiFO9USB5K9LCBZ8JwXS+KAyPYy4rMuQKw31NRfsWqnbpqLv6NuTd68=
X-Received: by 2002:a67:dc98:: with SMTP id g24mr8902213vsk.27.1557914186011;
 Wed, 15 May 2019 02:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190508145600.GA26843@centauri> <CAHLCerN8L4np0WAY4hTjTnPXFtTK6EH0BXWLXzB-NiRaAnvcDA@mail.gmail.com>
 <20190510091158.GA10284@e107155-lin> <CAHLCerM83weBBvwurU45d9_M0Wg49WjDFTRJ6KL8vj7cavz03g@mail.gmail.com>
 <20190513094935.GA4885@e107155-lin>
In-Reply-To: <20190513094935.GA4885@e107155-lin>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 15 May 2019 15:26:14 +0530
Message-ID: <CAHLCerM6SVCx5vdrodh+O5nQ0uDwr7zpvOMxVYtreT9EFk22eg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Add PSCI cpuidle support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 3:19 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, May 10, 2019 at 11:58:40PM +0530, Amit Kucheria wrote:
> > On Fri, May 10, 2019 at 2:54 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
>
> [...]
>
> > >
> > > Yes entry-method="psci" is required as per DT binding but not checked
> > > in code on arm64. We have CPU ops with idle enabled only for "psci", so
> > > there's not need to check.
> >
> > I don't see it being checked on arm32 either.
> >
>
> arm_cpuidle_get_ops in arch/arm/kernel/cpuidle.c checks the method, has
> to match "psci" for drivers/firmware/psci.c to work on arm32

That is a check for the enable-method, not entry-method.

We don't check for entry-method anywhere, AFAICT.

> [...]
>
> > >
> > > Why do you want to deprecated just because Linux kernel doesn't want to
> > > use it. That's not a valid reason IMO.
> >
> > Fair enough. Just want to make sure that it isn't some vestigial
> > property that was never used. Do you know if another OS is actually
> > using it?
> >
>
> Not that I am aware of. But Linux uses it on arm32, so it's not entirely
> unused.

entry-method is not read in Linux code (see above).

> > > > Do we expect to support PSCI platforms that might have a different
> > > > entry-method for idle states?
> > >
> > > Not on ARM64, but same DT bindings can be used for idle-states on
> > > say RISC-V and have some value other than "psci".
> >
> > Both enable-method and entry-method properties are currently only used
> > (and documented) for ARM platforms. Hence this discussion about
> > deprecation of one of them.
> >
>
> Yes, it's used on arm32 as mentioned above.

Only enable-method is checked.

> > > > Should I whip up a patch removing entry-method? Since we don't check
> > > > for it today, it won't break the old DTs either.
> > > >
> > >
> > > Nope, I don't think so. But if it's causing issues, we can look into it.
> > > I don't want to restrict the use of the bindings for ARM/ARM64 or psci only.
> >
> > Only a couple of minor issues:
> > 1. There is a trickle of DTs that need fixing up every now and then
> > because they don't use entry-method in their idle-states node. Schema
> > validation ought to fix that.
>
> I understand, scheme should fix it. This is not just restricted to this,
> it's generic DT problem. So let's hope we get schema based validation soon.
>
> > 2. A property that isn't ready by any code is a bit confusing. Perhaps
> > we can mention something to the effect in the documentation?
> >
>
> Not entirely true. We have quite a lot of bindings that are added just
> because downstream drivers use e.g. GPU and even standard ePAPR or DT
> specification has lots of bindings which OS like Linux may choose
> not to use at all. Same applies to ACPI, so I am not for removing bindings
> just because there are no users in Linux.

That is a fair point. But in those cases, the binding is probably used
by another OS. entry-method seems to an example of one that isn't used
by Linux or other OSes.

Regards,
Amit
