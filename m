Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E6BC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3612183F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564768281;
	bh=khpD6S32XLryQTWPY6MaNlqlYYAxW/nyOe/CxIuALW0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=HiVW5ZEX9XPU2ey3k2yJnSC7bg9nB7lsePpJ+sMBdVfUMjZjGtwplzaVBcxUobHjv
	 mchaSp3d9HA1jcRhcnyLp75vX5OuULlcZ/YiUwAqzB88V4t9+QY5bkb6x4YBwtDewe
	 odlfKBkW8zDlsMgZ3QazNmKiGGWxhZPF4sod5/yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436600AbfHBRvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405813AbfHBRvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:51:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E401217F5;
        Fri,  2 Aug 2019 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564768279;
        bh=khpD6S32XLryQTWPY6MaNlqlYYAxW/nyOe/CxIuALW0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nVMzMboHgX7MfU68J36ZEXxGcflYB3IxcBADYek55/bDOP0TvrlbwsWtm43Uib6VU
         6ToxJ3+HaIUab5BjNhzKKK9UaZbWpk4/iSgR7ofeeaSqBRMzRNVRZCwUFjyWMae0h8
         JFO9WCQuyom8dCf8+VvJeJ5xdeEcdWdVW+TIo4aI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8c259511-d8ea-51b2-0b1d-c85b964bc44c@gmail.com>
References: <1563738060-30213-1-git-send-email-skomatineni@nvidia.com> <1563738060-30213-15-git-send-email-skomatineni@nvidia.com> <e683b417-66fb-38dc-c16b-dab616583a88@gmail.com> <88da46d2-b90d-f57e-7611-b8653b56bdf6@nvidia.com> <ceedb802-7561-488f-3a89-67bee19f2fea@gmail.com> <e2d0e8cc-b4ea-1148-4af1-fee6bb266cca@nvidia.com> <5054f178-db27-9286-d123-3e2b2a885717@gmail.com> <8c259511-d8ea-51b2-0b1d-c85b964bc44c@gmail.com>
Subject: Re: [PATCH V6 14/21] clk: tegra210: Add suspend and resume support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        jason@lakedaemon.net, jonathanh@nvidia.com,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, stefan@agner.ch, tglx@linutronix.de,
        thierry.reding@gmail.com
User-Agent: alot/0.8.1
Date:   Fri, 02 Aug 2019 10:51:18 -0700
Message-Id: <20190802175119.1E401217F5@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-07-22 00:12:17)
> 22.07.2019 10:09, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 22.07.2019 9:52, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>
> >> On 7/21/19 11:10 PM, Dmitry Osipenko wrote:
> >>> 22.07.2019 1:45, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>> On 7/21/19 2:38 PM, Dmitry Osipenko wrote:
> >>>>> 21.07.2019 22:40, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> >>>>>> @@ -2853,9 +2859,8 @@ static int tegra210_enable_pllu(void)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg |=3D PLL_ENABLE;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(reg, clk_base + PLLU_B=
ASE);
> >>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 readl_relaxed_poll_timeout_atomic=
(clk_base + PLLU_BASE, reg,
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg & PLL_B=
ASE_LOCK, 2, 1000);
> >>>>>> -=C2=A0=C2=A0=C2=A0 if (!(reg & PLL_BASE_LOCK)) {
> >>>>>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra210_wait_for_mask(&pllu, PLLU_BAS=
E, PLL_BASE_LOCK);
> >>>>>> +=C2=A0=C2=A0=C2=A0 if (ret) {
> >>>>> Why this is needed? Was there a bug?
> >>>>>
> >>>> during resume pllu init is needed and to use same terga210_init_pllu,
> >>>> poll_timeout_atomic can't be used as its ony for atomic context.
> >>>>
> >>>> So changed to use wait_for_mask which should work in both cases.
> >>> Atomic variant could be used from any context, not sure what do you
> >>> mean. The 'atomic' part only means that function won't cause scheduli=
ng
> >>> and that's it.
> >>
> >> Sorry, replied incorrect. readx_poll_timeout_atomic uses ktime_get() a=
nd
> >> during resume timekeeping suspend/resume happens later than clock
> >> suspend/resume. So using tegra210_wait_for_mask.
> >>
> >> both timekeeping and clk-tegra210 drivers are registered as syscore but
> >> not ordered.
> >=20
> > Okay, thank you for the clarification.
> >=20
> > [snip]
> >=20
>=20
> You should remove the 'iopoll.h' then, since it's not used anymore.

And also add a comment to this location in the code because it's
non-obvious that we can't use iopoll here.

