Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD504C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB0F2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C2exFM09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfEOVu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:50:26 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40852 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEOVuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:50:25 -0400
Received: by mail-vk1-f193.google.com with SMTP id v140so446126vkd.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYNYXgU+/PVoj2y5Yn+qCV5g/0Te3hA7zTkDB0qlSMY=;
        b=C2exFM09NZ8pxiHyFzuOnfdw580VmYx8l289M3cy8cfVo3obMrlMZsJt86jH9W5PIl
         WH6tqH/v3LJRZF/a66EsiHG3nOAj84sMOIFcvk6+HrRsWToX1SBV1UyCKehx4R/b6jsK
         UNSSYJ0rLIbL1cM/H9l41ucAvn2nFJR1EjlSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYNYXgU+/PVoj2y5Yn+qCV5g/0Te3hA7zTkDB0qlSMY=;
        b=LWpusDF5d1dH/rN15UtzZ9h/plM9FJLtW9VbQ0H8qgeLhmrIB9UclHur0VYpvG3no+
         2Cuu6MEjzJzpzQuofISzxZ31cwLX1wM1QoHIdH3UJW6d8JR2R+ObBBtTV6azsK249gBI
         ntByEoH8aCFAXDtlhMMizoKi3RYm33PugzDWYSmnyNXRiKEGLAbhSxWAq3Q/81374M9K
         HPt/RmD1zAor3Q1bCcVgtO/Ho0mDtdXUseQ6q/0b+V4lJiTMrZ/egl4xHbtFMGQXJNqc
         eMz8XDua24sbr6NTJ/9tl2Y3B+t1sTdCEDU/AEyYB1fj3b4boEog92wImi4XGiTp03S9
         /IQA==
X-Gm-Message-State: APjAAAW7p1rXZFQVVbwSnZnG8Z4H2m3RdOOhLju+kpumKZAEvhVyvJ4D
        WG3lpiB9oN4MfcvdSHokieFE4J5hSts=
X-Google-Smtp-Source: APXvYqzWPF42MZWOQNQJU/zqyjMG9slFrheBU7+4H6gebaVz0h1WwMsNJKbfxjKTJyUj27tGiuADxg==
X-Received: by 2002:a1f:9501:: with SMTP id x1mr20648093vkd.12.1557957024173;
        Wed, 15 May 2019 14:50:24 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id t124sm828082vkf.49.2019.05.15.14.50.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 14:50:22 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id l20so970751vsp.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:50:22 -0700 (PDT)
X-Received: by 2002:a67:ebd6:: with SMTP id y22mr6664210vso.87.1557957022174;
 Wed, 15 May 2019 14:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190509184415.11592-1-robdclark@gmail.com> <20190509184415.11592-3-robdclark@gmail.com>
 <CAD=FV=WXW3aApS=c7baxhtfr1Nf-UnBN2s=rEBBkjj4=TCdT+g@mail.gmail.com> <CAJs_Fx5PDj+T+DVixzHjun_wCG5fhZsxH8xUqRwmkfwN87UP_A@mail.gmail.com>
In-Reply-To: <CAJs_Fx5PDj+T+DVixzHjun_wCG5fhZsxH8xUqRwmkfwN87UP_A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 May 2019 14:50:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vgiej=+hCZ_Eekoa4FJfpKxhOge8Wy29EEmtjB8JeF9g@mail.gmail.com>
Message-ID: <CAD=FV=Vgiej=+hCZ_Eekoa4FJfpKxhOge8Wy29EEmtjB8JeF9g@mail.gmail.com>
Subject: Re: [RFC 2/3] arm64: dts: qcom: sdm845-cheza: Re-add reserved memory
To:     Rob Clark <robdclark@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 14, 2019 at 9:10 PM Rob Clark <robdclark@chromium.org> wrote:

> On Mon, May 13, 2019 at 3:48 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, May 9, 2019 at 11:44 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > > From: Douglas Anderson <dianders@chromium.org>
> > >
> > > Let's fixup the reserved memory to re-add the things we deleted in
> > > ("CHROMIUM: arm64: dts: qcom: sdm845-cheza: Temporarily delete
> > > reserved-mem changes") in a way that plays nicely with the new
> > > upstream definitions.
> >
> > The message above makes no sense since that commit you reference isn't
> > in upstream.
> >
> > ...but in any case, why not squash this in with the previous commit?
>
> Yeah, I should have mentioned this was my intention, I just left it
> unsquashed since (at the time) it was something I had cherry-picked on
> top of current 4.19 cros kernel..
>
> anyways, I pushed an (unsquashed, converted to fixup!'s) update to:
>
> https://github.com/freedreno/kernel-msm/commits/wip/cheza-dtb-upstreaming
>
> which has updates based on you're review comments (at least assuming I
> understood them correctly).. plus some unrelated to cheza-dt patches
> on top to get things actually working (ie. ignore everything on top of
> the fixup!'s)

Looks OK to me.  Are you going to post this?  Bjorn / Andy: do you
guys have opinions here?


> I didn't see any comments on the 'delete zap-shader' patch, so
> hopefully that means what I did there was a sane (or at least not
> insane) way to handle android/linux tz vs what we have on cheza?

I wasn't CCed, so I assumed you were looking for feedback from others
on that one.  ;-)  Oh, but I guess Jordan and Bjorn also weren't
CCed...  In any case, I replied now.
