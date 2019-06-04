Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDEEC28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDB52075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qei4RrI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfFDQhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:37:12 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:32902 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfFDQhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:37:12 -0400
Received: by mail-yb1-f195.google.com with SMTP id w127so8205161yba.0;
        Tue, 04 Jun 2019 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6EnQflcPAKJYTyCzJ+zEujJYDVfKA0owpr+lk17ZNW8=;
        b=Qei4RrI/1FCqlNMNuhbQrfUb1HMjOhIUyjvKVZF2uPzdKh6tdkXxbjqLHfEMjZwu9d
         Vm9H0kLW0GqY6JojRiyBTYzXjLNlZ1b5CuD39bY3lRPCG72qqkPnrEO7dsSzKq8DGw0c
         +r0iYtAKCAvZcv3rsj77bBlBEdbHuJ8B+Qa2CoKbkXU+m+m+Ynz9Lqb/gwuGSbb0v9XN
         dUREDZfu+7/NXFXdz2MUT+cLZ9rprUg9i9EZsmJNe6zYk4ZjiJsG2vIu63FzzqKmzMvp
         rw4nij6HCqXcM2F9RaH2tKkGrR7fQoEci8oFC/m7tVlj6wiFSsiCVLoi2EBZIjUclhjT
         zN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=6EnQflcPAKJYTyCzJ+zEujJYDVfKA0owpr+lk17ZNW8=;
        b=UoxQjoZuJpKlW+abcWgvJpjW6apB+yogqt2w/q9zTq7wHXhZZTkXOEM/LRy5BsHvFO
         wDEUDW7+G1+yMRMBB9aNq0uXnV4HVbma+ZzfBKLG2SYHlTBXTLxFmbDmi1o6lB0qx9IF
         KucFPsj0P86mSsFCHwYOO9I1Gqcazz05mCwALhihOp6/9I/NeARhcNpMpCUAFgmP+JPg
         7ARrqnsWFORCNPp7CqfrUAovV20dQQN8GdBecK4N5aSqakjbIEjX7Fm2GUJt7DtPnHaI
         T6q08lZibce2qXzAV2sZt1ns12Yd9q2psvJjB6koyCv8FmwICuLsI0+dNn9DFhqddmQb
         RY7A==
X-Gm-Message-State: APjAAAVwffdfls00K+1pwKYW6yuqJRPdWHfYNofv51Hqfg6rhP6t1TTf
        ZIUuokA5EHQYD6YgZV+l07nXOJVoQdXBxUgSIlE=
X-Google-Smtp-Source: APXvYqxwJuhFrohaMgLvCY52gUSasNGBItGgFchTeFYNUqKjkBF/kQzQ+7oFlK+HaW6p2xRHlixagQcen2pn3bUa/2o=
X-Received: by 2002:a25:6148:: with SMTP id v69mr13936600ybb.401.1559666231415;
 Tue, 04 Jun 2019 09:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190604154036.23211-1-megous@megous.com> <CAJiuCcda0ZDDrbdOF7TpTeoUOgt7GeS6wcgy45DRCo_U2XX6bQ@mail.gmail.com>
 <20190604162144.hba5bmkdnidco7pf@core.my.home>
In-Reply-To: <20190604162144.hba5bmkdnidco7pf@core.my.home>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 4 Jun 2019 18:36:59 +0200
Message-ID: <CAJiuCcddcf=pPByV+=2+QOfEKwuT03EkgFe97nPV7qKX35t6KQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2] clk: sunxi-ng: sun50i-h6-r: Fix
 incorrect W1 clock gate register
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

On Tue, 4 Jun 2019 at 18:21, Ond=C5=99ej Jirman <megous@megous.com> wrote:
>
> Hi Cl=C3=A9ment,
>
> On Tue, Jun 04, 2019 at 06:14:15PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Ondrej,
> >
> > On Tue, 4 Jun 2019 at 17:40, megous via linux-sunxi
> > <linux-sunxi@googlegroups.com> wrote:
> > >
> > > From: Ondrej Jirman <megous@megous.com>
> > >
> > > The current code defines W1 clock gate to be at 0x1cc, overlaying it
> > > with the IR gate.
> > >
> > > Clock gate for r-apb1-w1 is at 0x1ec. This fixes issues with IR recei=
ver
> > > causing interrupt floods on H6 (because interrupt flags can't be clea=
red,
> > > due to IR module's bus being disabled).
> > >
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > Fixes: b7c7b05065aa77ae ("clk: sunxi-ng: add support for H6 PRCM CCU"=
)
> > > ---
> > >  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sun=
xi-ng/ccu-sun50i-h6-r.c
> > > index 27554eaf6929..8d05d4f1f8a1 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> > > @@ -104,7 +104,7 @@ static SUNXI_CCU_GATE(r_apb2_i2c_clk,       "r-ap=
b2-i2c",   "r-apb2",
> > >  static SUNXI_CCU_GATE(r_apb1_ir_clk,   "r-apb1-ir",    "r-apb1",
> > >                       0x1cc, BIT(0), 0);
> > >  static SUNXI_CCU_GATE(r_apb1_w1_clk,   "r-apb1-w1",    "r-apb1",
> > > -                     0x1cc, BIT(0), 0);
> > > +                     0x1ec, BIT(0), 0);
> > Just for information where did you find this information?
> > Using the vendor kernel or user manual?
>
> Informed guess. All gates and resets are in the same register. And
> you can see below that reset register for w1 is 0x1ec. (reset register
> for ir is 0x1cc)
Ok, I thinks this can confirm the value:
https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/drivers=
/clk/sunxi/clk-sun50iw6.h#L161

Acked-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Regards,
Cl=C3=A9ment
>
> regards,
>         o.
>
> > Thanks,
> > Cl=C3=A9ment
> >
> > >
> > >  /* Information of IR(RX) mod clock is gathered from BSP source code =
*/
> > >  static const char * const r_mod0_default_parents[] =3D { "osc32k", "=
osc24M" };
> > > --
> > > 2.21.0
> > >
> > > --
> > > You received this message because you are subscribed to the Google Gr=
oups "linux-sunxi" group.
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to linux-sunxi+unsubscribe@googlegroups.com.
> > > To view this discussion on the web, visit https://groups.google.com/d=
/msgid/linux-sunxi/20190604154036.23211-1-megous%40megous.com.
> > > For more options, visit https://groups.google.com/d/optout.
