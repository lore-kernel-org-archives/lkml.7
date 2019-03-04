Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D367C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB10720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/pqUSxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfCDWiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:38:03 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40745 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDWiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:38:02 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so4708703lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 14:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhzJRAZt/R3PF5BQzh2oLYrOEtPSkbVjGUE3eqKeFF4=;
        b=i/pqUSxtkZTGQee4dyx8hrGiQrrcDTKPONLULgYNsJ2AzkjzVjfdBDhjIHInC62gfg
         DW7IvlZrIxjqbN9ivBT61CTVwE573URms1XXpmpJ7tYce4+jTWlWb4qa2mc3dYtL3Sph
         o+lAcxX96jnbMrttUrBFJYkjh+JNAN+544IGWLhJv1I7Qg0ngpndI8XHvACB8hQhOupT
         F9+mOnmrz+zeaYhxzXiPA+ZQCbto65SSHf8/44JSbxuiSZoWYqv75JgCZfIvSVewPfEL
         zWAs2f6+ED3qgR1osxaG9eDYNs2+HnLB13VTPjz6tqNrnxETFtreoYDQ513hqrG/8kw9
         1ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhzJRAZt/R3PF5BQzh2oLYrOEtPSkbVjGUE3eqKeFF4=;
        b=IT9tEqRGYjY7yXG5kx9HEp6TUrOLPKybz5e5cGq6TaEUsbIgmVGIdt/hTiuxEuBoyf
         U/sDGBwyTYCTiqWIJDfC4V1cjxt+jdKkPQ3OHnfjwPIQQKTiG5qYvAx2bl5oug5LF8D5
         O7PzLwKN2UQnwdUC8Bvl2+1GKIZx71f7T3cPmAEMgtPo1eFRK54aah1cGzSCqaPboIE+
         MgguZchf5+Yd45MoYRaysQ5udSM/RRt2v2Tnrz7CoNvH5K6RZiwOHlolaMLsvZO1V3nI
         5bsnQHPcg9SkMKauffuOuu4pq1tah6qW0Tr8qO6aJH5P48+todDzJbjcmuymCs4ttdcv
         vU5w==
X-Gm-Message-State: APjAAAVPodHx/sowxUQtDlzC7ygOodZ5iR1MNR6O+R2WtNldthaXPfW5
        lJoGndfTPuPuArogT8vJksaVUSRoC6+TnR/ucjCKuA==
X-Google-Smtp-Source: APXvYqxVKHRb41Wd2WOnYPv9vOYsDDZaIXMzjxDoSa/W5A+CwtjIrx8OHtkfSEfyBwCR8HWS/le0gY70BOKnXzVeixE=
X-Received: by 2002:a19:a417:: with SMTP id q23mr7220186lfc.27.1551739080195;
 Mon, 04 Mar 2019 14:38:00 -0800 (PST)
MIME-Version: 1.0
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
 <20190301155523.GA1915@Mani-XPS-13-9360> <CACRpkdb=E9_rm4_7DQV3dS5uOs1gozxEwN9MtWr0tTwmjcYe=A@mail.gmail.com>
 <20190304144829.GA5265@Mani-XPS-13-9360>
In-Reply-To: <20190304144829.GA5265@Mani-XPS-13-9360>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Mar 2019 23:37:48 +0100
Message-ID: <CACRpkda+8QZnaT-YoeccQGjg78y9-E-JoWBr3LJs62T03H4wQw@mail.gmail.com>
Subject: Re: [PATCH 01/15] ARM: actions: fix a leaked reference by
 addingmissing of_node_put
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        avifishman70@gmail.com, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Xu Wei <xuwei5@hisilicon.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>, wang.yi59@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 3:48 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Mon, Mar 04, 2019 at 01:29:33PM +0100, Linus Walleij wrote:
> > On Fri, Mar 1, 2019 at 4:55 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > Hi Wen,
> > >
> > > On Fri, Mar 01, 2019 at 04:56:42PM +0800, Wen Yang wrote:
> > > > The call to of_get_next_child returns a node pointer with refcount
> > > > incremented thus it must be explicitly decremented after the last
> > > > usage.
> > > >
> > > > Detected by coccinelle with the following warnings:
> > > > ./arch/arm/mach-actions/platsmp.c:112:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 103, but without a corresponding object release within this function.
> > > > ./arch/arm/mach-actions/platsmp.c:124:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 115, but without a corresponding object release within this function.
> > > > ./arch/arm/mach-actions/platsmp.c:137:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 128, but without a corresponding object release within this function.
> > > >
> > >
> > > We have a floating patch for this:
> > > https://www.spinics.net/lists/arm-kernel/msg694544.html
> > >
> > > Andreas: Can you please take a second look at the patchset submitted by Linus
> > > Walleij and Russel for simplifying the Actions startup code?
> >
> > Andreas wrote a version of simplifying secondary startup in the
> > same spirit as Russell's patches, and it's merged and all
> > is fine I think.
> >
>
> Oops. I think I missed that! Can you please point me to that patch? And how it
> got merged? I did the PR for actions stuff this time and haven't included any
> mach-actions patches.

I just did git log arch/arm/mach-actions but I think it came in quite some time
ago, not last merge window:

But you see:
commit 6c2eb3e76fb84e2eb46d484f71fab469c0d9532c
"ARM: owl: smp: Drop owl_secondary_boot()"
commit bad29933fef76fb6ee577f4a0b6d145c1f52f663
"ARM: owl: smp: Use __pa_symbol()"
commit 18cfd9429d8a82c49add8f3ca9d366599bfcac45
"ARM: owl: smp: Drop bogus holding pen"

platsmp.c looks just fine these days. Except for what Wei's patch is fixing,
of_node_put().

Yours,
Linus Walleij
