Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F42FC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CFA21E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPW34rTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbfHGNLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:11:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35860 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbfHGNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:11:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so6182322ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqX/zsugDIFGqU1o5bPg+mfxcpflibTDWwvc6+6Rsf8=;
        b=HPW34rTvAIhdr9bJvlw2XRGRZ+4vv2vK2kKpLqe50l++3Xb1jjvEwDt61lJZuHxXw1
         Kngs8VEqnx5a4NESoMrYXBT1gnwRvuoeYwNPC5wSwRxId8ONoHhKNyM4uVcoT2Xh23Lw
         +0QCWafH2nIKIV09orsewO1F2Zx100X81YxAeJ4/8uFD6ZZs2RyvsHFxjloI1mQtiT2W
         oCyoH7vXeSNmBSceJyFzetyeKiZFuUC+/I7qKo3IvT+und7w9ERjw9vbvA5iBFS1aL74
         CgnaYx19HChPZEnn11I2xV1W3npYhAbTelac6vXLcc0xgJjlFhxuvztC7YAdp5EzLxTn
         N8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqX/zsugDIFGqU1o5bPg+mfxcpflibTDWwvc6+6Rsf8=;
        b=SzFJaAZ66Q0/+BEoMmg0QEiVQlGMgCmwVeIFTtSyXtGeIdJLhP47eFhK4z7ttxt/dU
         XSEBgdOyxmTWzvkVW4ceZU4IVgsAKmOdgaIipRpvUfeV61shlTnPMk81xFaK6Y4YIZ7+
         Pl2Ys3ENvZu9yvaLL5djEKE3lNiE3Y1yC37ZRh0/0w9PceaTEQS48wkGpxJWd2nuzGbR
         Cn3k55LZ7tMDPY45hlHalYvTUxaGD6hQxJmillMOykQTkbcFFE6zOmosT/w7DWTpdvTy
         VG2r8l+UbXqCG9H9xIulUY9F2r7tLh+d57l1G2lgKtKKYnrbcVUfsi6xv9gHfMjNXZy3
         6Ipg==
X-Gm-Message-State: APjAAAXMzdmte2r7yCLFUSjSdJjpP3+CwJWWQrBgpUJK1zeu3oJfUwht
        VutRhDFmRTrlD34Ywx4jArtfzqbH/vileEdKKTFyyw==
X-Google-Smtp-Source: APXvYqyyDYYjNW4h7b6Yag9vpJCIRMLDKR2d8S/CnXzZgJktyNjXwofh2RTb311bPW1GJsEQlmfPNAEOOU6jKb2QhT8=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr4790826ljc.28.1565183501517;
 Wed, 07 Aug 2019 06:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
 <1564607463-28802-2-git-send-email-skomatineni@nvidia.com>
 <CACRpkdZVR-i1c5eATL2hSPbLXcX1sR8NgXwa4j259XXUi57xug@mail.gmail.com>
 <a2fb3795-5ec1-1d03-f496-f151d1270e90@nvidia.com> <dadf0cc7-fba4-9ab5-6ac9-0c8699eb4401@nvidia.com>
In-Reply-To: <dadf0cc7-fba4-9ab5-6ac9-0c8699eb4401@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Aug 2019 15:11:29 +0200
Message-ID: <CACRpkda+YGfRYXbT2Okq8rO82ZWQAJJPMqK_EyTRe4PLUsxvNw@mail.gmail.com>
Subject: Re: [PATCH v7 01/20] pinctrl: tegra: Add suspend and resume support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jckuo@nvidia.com, Joseph Lo <josephl@nvidia.com>, talho@nvidia.com,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>, spatra@nvidia.com,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 5:40 AM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
> On 8/6/19 2:51 PM, Sowjanya Komatineni wrote:
> >
> > On 8/5/19 2:20 AM, Linus Walleij wrote:
> >> On Wed, Jul 31, 2019 at 11:11 PM Sowjanya Komatineni
> >> <skomatineni@nvidia.com> wrote:
> >>
> >>> This patch adds support for Tegra pinctrl driver suspend and resume.
> >>>
> >>> During suspend, context of all pinctrl registers are stored and
> >>> on resume they are all restored to have all the pinmux and pad
> >>> configuration for normal operation.
> >>>
> >>> Acked-by: Thierry Reding <treding@nvidia.com>
> >>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> >>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> >> Patch applied to the pinctrl tree.
> >>
> >> This patch seems finished.
> >>
> >> Also if the rest don't get merged for v5.4 then at least this is so
> >> your patch stack gets more shallow.
> >>
> >> I hope it's fine to merge this separately, else tell me and I'll
> >> pull it out.
> >>
> >> Yours,
> >> Linus Walleij
> >
> > Yes, this patch can be merged separately. But, there's latest feedback
> > from Dmitry to add barrier after writes to make sure pinmux register
> > writes happen.
> >
> > So will update this patch to add barrier in v8. So, need to wait for v8.
> >
> > Thanks
> >
> > Sowjanya
> >
> I see it merged. So will exclude suspend/resume patch and will add patch
> for necessary write barrier fix in v8 version.

Yeah just make an incremental patch, that's fine.
If you want to overdo it you can add a Fixes: tag to
the original patch, but I don't care much.

Yours,
Linus Walleij
