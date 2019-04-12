Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FDCC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE202171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NNAs4gTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDLR3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:29:09 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:47039 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfDLR3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:29:09 -0400
Received: by mail-vs1-f67.google.com with SMTP id e2so5970848vsc.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XkWraLgMjYQXOFvMDPQ6BgisdR6SKwNuTLZ8CZqppKk=;
        b=NNAs4gTkHhdy/FfBnG3wDOH1ZcHChfZQyqYvlq9tOX5svUQ3M0bLi5Mn24Vl1LR0Yr
         fDeiLZaXkiUq6QHaFq7C0wBxE2sNshtExjoI7d2At4OTAz/XQS56j6TO+Zp56s1Lon4t
         IgDYJz5E1CquWcC7pm2edW8HGCXzpF5M86lak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XkWraLgMjYQXOFvMDPQ6BgisdR6SKwNuTLZ8CZqppKk=;
        b=pDWgUFzi+/cDFR28IplKs9C2dAUxLddbDvM+AWFOsEMf1hR+/ZVFo0wuRqJUcr8jfM
         b30vI2lXFYkLXM68ud46Fmb68P3PvOat+KhiF/ae9mQ3MipWDk4L7JDwsOyilGNB9W/P
         N4o5qd7kQCGLcV/NuR2SJtXsyRG8DNgFEiox8jUCB4iBsdmmNiK6p4M5daaJpuGdXhgj
         LBT29cv6FykhufTecGZBrkSGiSQ6e+t1bv39uzwAChUmuEa/9VVUxR+Q+OmBpVoxoUZ6
         NWHQhtoENFBs3XZ8iXch0Pd3pRiNOfGORp5xKbctHanBH6AsfuRejoCpRuT+RE0MlW7k
         2cug==
X-Gm-Message-State: APjAAAWGSagt0FUIKgDT9rm98Sirvgm0bHqouIuMlD1kELYJuZeqfRjH
        5Up67ofV9oe3q4G/Zv3QwsPrnp5AyAI=
X-Google-Smtp-Source: APXvYqz2w3Yo7CbKxibiaMD0DDd2FOl/CW4OTE69bh0evwNua6ERB95BCY5rcs4EeFkSdpY0Wc7G7Q==
X-Received: by 2002:a67:f441:: with SMTP id r1mr15866018vsn.38.1555090147344;
        Fri, 12 Apr 2019 10:29:07 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id w79sm14217672vkw.51.2019.04.12.10.29.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 10:29:05 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id t78so6011570vsc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 10:29:05 -0700 (PDT)
X-Received: by 2002:a67:7f44:: with SMTP id a65mr12648937vsd.179.1555090145127;
 Fri, 12 Apr 2019 10:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com>
 <1554284649-26764-1-git-send-email-zhangqing@rock-chips.com> <5677286.2uEqRd8HI1@diego>
In-Reply-To: <5677286.2uEqRd8HI1@diego>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 12 Apr 2019 10:28:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzDZHX7q-h7jAGpoqXyz_C5RJhbZuXo2gM=1kZeAwRUQ@mail.gmail.com>
Message-ID: <CAD=FV=XzDZHX7q-h7jAGpoqXyz_C5RJhbZuXo2gM=1kZeAwRUQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] clk: rockchip: add pll up and down when change pll freq
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, xxx <xxx@rock-chips.com>,
        xf@rock-chips.com, =?UTF-8?B?6buE5rab?= <huangtao@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 12, 2019 at 5:16 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Elaine,
>
> Am Mittwoch, 3. April 2019, 11:44:09 CEST schrieb Elaine Zhang:
> > set pll sequence:
> >       ->set pll to slow mode or other plls
> >       ->set pll down
> >       ->set pll params
> >       ->set pll up
> >       ->wait pll lock status
> >       ->set pll to normal mode
> >
> > To slove the system error:
> > wait_pll_lock: timeout waiting for pll to lock
> > pll_set_params: pll update unsucessful,
> >               trying to restore old params
>
> Can you tell me on what soc this was experienced?
>
> The patch includes rk3399, but I don't think the CrOS kernel
> does powerdown the pll when changing the cpu-frequency
> [added Doug and Brian for clarification and possible testing :-) ]

As far as I can tell you're right.  We don't seem to have it and I'm
not aware of problems.


> But I did find that the M0 code in ATF does actually power-down the
> PLL and follow your outline from above. So essentially I'd just like
> a thumbs up from chromeos people if they have the time.

It does seem like it should be fine in general to do it.  It's one
extra step but presumably it should be fine.

In general the Rockchip PLL programming guidelines have always been a
bit funny.  Looking at the version of the doc I have, I see phrases
like "The PLL programming support changed on-the-fly and the PLL will
simply slew to the new frequency" which makes me feel like you're
supposed to be able to change the PLL frequency without powering down.
This is repeated in another part of the manual which talks about the
glitches that can happen when changing the PLL on the fly: it doesn't
say not to do it, it just says to expect glitches (which can be
avoided by changing the parent first).

...but then in another section of the doc it talks about asserting PD
before doing a frequency change!  :-P

Though in that same section it says: "Release PD after no less than
1us from the time it was asserted."  Even though probably 1 us has
passed, I'd still expect a udelay(1) to be explicit here.


One other thing that concerns me a little about this patch is that I
wonder if it is legal to call rockchip_rk3399_pll_set_params() while
the PLL is off.  AKA is it OK to change the rate of a PLL while it is
not enabled?  I'm not saying that this would have worked before
(actually, you might end up hitting the exact error "timeout waiting
for pll to lock"), but now it seems even worse because we'll
implicitly turning on the PLL.  ...a part of me wonders if this is the
root cause of the problem Elaine's patch is trying to solve: that some
code was trying to set the rate of a PLL before enabling it.


So, tl; dr:
* I doubt this patch is needed on rk3399, but it probably won't hurt.
* If you're going to do the power down, you should add the udelay()
* There's a bug on 3036.  See below.
* You should change your patch so it doesn't enable the PLL if it
wasn't already enabled.


> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > ---
> >  drivers/clk/rockchip/clk-pll.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-=
pll.c
> > index dd0433d4753e..9fe1227e77e9 100644
> > --- a/drivers/clk/rockchip/clk-pll.c
> > +++ b/drivers/clk/rockchip/clk-pll.c
> > @@ -208,6 +208,11 @@ static int rockchip_rk3036_pll_set_params(struct r=
ockchip_clk_pll *pll,
> >               rate_change_remuxed =3D 1;
> >       }
> >
> > +     /* set pll power down */
> > +     writel(HIWORD_UPDATE(1,
> > +                          RK3036_PLLCON1_PWRDOWN, 13),

This does not do what you think it does.  It should be:

HIWORD_UPDATE(RK3036_PLLCON1_PWRDOWN,
     RK3036_PLLCON1_PWRDOWN, 0)

...without that my compiler yells at me:

signed shift result (0x40000000000) requires 44 bits to represent

...and the compiler is, indeed, correct.


> > +            pll->reg_base + RK3036_PLLCON(1));
> > +
> >       /* update pll values */
> >       writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3036_PLLCON0_FBDIV_MA=
SK,
> >                                         RK3036_PLLCON0_FBDIV_SHIFT) |
> > @@ -229,6 +234,10 @@ static int rockchip_rk3036_pll_set_params(struct r=
ockchip_clk_pll *pll,
> >       pllcon |=3D rate->frac << RK3036_PLLCON2_FRAC_SHIFT;
> >       writel_relaxed(pllcon, pll->reg_base + RK3036_PLLCON(2));
> >
> > +     /* set pll power up */
> > +     writel(HIWORD_UPDATE(0, RK3036_PLLCON1_PWRDOWN, 13),
> > +            pll->reg_base + RK3036_PLLCON(1));

In a similar vein, the above should be:

writel(HIWORD_UPDATE(0, RK3036_PLLCON1_PWRDOWN, 0),

...since RK3036_PLLCON1_PWRDOWN already has the shift.
