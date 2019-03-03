Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B59C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418E920836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAhL/+Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfCCPNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:13:19 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41029 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfCCPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:13:19 -0500
Received: by mail-oi1-f194.google.com with SMTP id e7so1900848oia.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 07:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1fOunaAKcyPCCNyw0ddTOu9T6+VMhiyYDrXiBKfml+A=;
        b=aAhL/+JatGvuPMBAigDbOVHEkweouKjZFeODalSOj+JVSgfbyL8wY/VRl43Hbz8+uu
         qclUOu3kYzD5iV1DE/dNol9mdGpTLZ2aEJwr834lkwvscnYMjCaFAe5MU0fEWAhcUTDG
         XFsqDG7q3aD6PHhjF89Aglh7mjVqhHH72AwbaKa0KenC0KT3MEGDJM6KYv4IQlikc8wG
         VxMzZjvP77GpbPHGP08UvBKcGhi3mva2i/uYXuw++vvhBTlNBlUtCMHxKcQz6WjRC4Wz
         dy+TsIdcMocfT/r7qLr+T3lh0Sk3rgwcB6a0kBcvppcjPgFYQBl4KLzvm0E1OQFCtKMR
         3pGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1fOunaAKcyPCCNyw0ddTOu9T6+VMhiyYDrXiBKfml+A=;
        b=V7mga5gD2m86/BoffXuHGHk/Bp25rtMkDxseKB9Pcdwz1F0+nucIGV3ce34g5fGUhO
         QcJhMRR4h9mpTM9lKBHUcHWawl1Lz1M9e2xa+jNSKiEEhufzru+Jj8YP92LTX4gWnqMD
         F6rI8Wfoa/CL3hlnCdDHSabbMvPkLqGIW5mjZHmZfJH60fN00bzG2lxSMkitvbEnTi/n
         WwNv/1gGonH+JTF2rgKANZenRZZpnQo1GrKP1Ik7yk58AZR5U+w7vPT8Q3sMfwfhwuWa
         A+XIdHY1Z6YG05AcdWi9x6veeMsMXn0G90giTJoCkBc30zZq8OpZOjrBxvSLI5XSddff
         7yUw==
X-Gm-Message-State: APjAAAU08ZIvTTQBB03bGfLvkr3QCOXLDXZfsfJZd4CJjkG+HrprfgFD
        fFv6115tzwlMEMlo2f9OJERElWYvbmu0fELJFD0=
X-Google-Smtp-Source: APXvYqxLHLLYwbEGS82oFQjGF82HTGA+Q06iXs1dd7hbGvTSa/tU8gl0hCV+hyiEcABdkI9GCPw4clt9y9/VoJhlFJk=
X-Received: by 2002:aca:bdd5:: with SMTP id n204mr4587007oif.14.1551625998206;
 Sun, 03 Mar 2019 07:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20190303122705.27094-1-katsuhiro@katsuster.net>
 <1623469.Hy6pdcMFRX@phil> <e722acb4-167f-8333-5c8a-b693815273f4@katsuster.net>
In-Reply-To: <e722acb4-167f-8333-5c8a-b693815273f4@katsuster.net>
From:   Tony McKahan <tonymckahan@gmail.com>
Date:   Sun, 3 Mar 2019 10:13:05 -0500
Message-ID: <CAERgoknAV1sACSPjM_u4WyWzLvmUntXMoEx=ccpFsqYZVeu__Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: decrease rising edge time of UART2
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        Brian Norris <briannorris@chromium.org>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Levin Du <djw@t-chip.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 9:04 AM Katsuhiro Suzuki <katsuhiro@katsuster.net> w=
rote:
>
> Hello Heiko,
>
> Thank you for comments.
>
> On 2019/03/03 22:19, Heiko Stuebner wrote:
> > Hi,
> >
> > Am Sonntag, 3. M=C3=A4rz 2019, 13:27:05 CET schrieb Katsuhiro Suzuki:
> >> This patch increases drive strength of UART2 from 3mA to 12mA for
> >> getting more faster rising edge.
> >>
> >> RockPro64 is using a very high speed rate (1.5Mbps) for UART2. In
> >> this setting, a bit width of UART is about 667ns.
> >>
> >> In my environment (RockPro64 UART2 with FTDI FT232RL UART-USB
> >> converter), falling time of RockPro64 UART2 is 40ns, but riging time
> >> is over 650ns. So UART receiver will get wrong data, because receiver
> >> read intermediate data of rising edge.
> >>
> >> Rising time becomes 300ns from 650ns if apply this patch. This is not
> >> perfect solution but better than now.
> >>
> >> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> >> ---
> >>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 +++++++--
> >>   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > your changing a core rk3399 property here, so I'd really like to get
> > input from other board stakeholders on this before applying a core
> > change.
> >
> > Could you either include the submitters of other rk3399-boards in the
> > recipient list so that they're aware or limit the change to rockpro64 f=
or
> > the time being (aka overriding the property in the board-dts) please?
> >
>
> OK, I'm adding other boards members.
> by ./scripts/get_maintainer.pl arch/arm64/boot/dts/rockchip/rk3399-*.dts
>
>
> RockPro64 directly connect UART2 pins of RK3399 to external connector.
> I think maybe other RK3399 boards are facing same problem, but I cannot
> check it because I have RockPro64 only...
>
> I'm happy if someone tell me other boards situation.

I'm pulling out other rockchip boards momentarily to see what kind of
population we have.

Note these are not all running 5.x kernels, however none of them have
the UART2 drive levels modified to my knowledge, and regardless, none
show over 100 ns.

board:    rise/fall

rk3399-roc-pc: 90ns/90ns
rk3399-rockpro64 V2.0:  90ns/45ns
rk3399-rockpro64 V2.1:  40ns/41ns

Please make sure there's not a large amount of flux or something
around the terminals on your board, that seems excessively high.

>
> Best Regards,
> Katsuhiro Suzuki
>
>
> > Thanks
> > Heiko
> >
> >
> >
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boo=
t/dts/rockchip/rk3399.dtsi
> >> index beaa92744a64..e3c8f91ead50 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> @@ -2000,6 +2000,11 @@
> >>                      drive-strength =3D <8>;
> >>              };
> >>
> >> +            pcfg_pull_up_12ma: pcfg-pull-up-12ma {
> >> +                    bias-pull-up;
> >> +                    drive-strength =3D <12>;
> >> +            };
> >> +
> >>              pcfg_pull_up_18ma: pcfg-pull-up-18ma {
> >>                      bias-pull-up;
> >>                      drive-strength =3D <18>;
> >> @@ -2521,8 +2526,8 @@
> >>              uart2c {
> >>                      uart2c_xfer: uart2c-xfer {
> >>                              rockchip,pins =3D
> >> -                                    <4 RK_PC3 RK_FUNC_1 &pcfg_pull_up=
>,
> >> -                                    <4 RK_PC4 RK_FUNC_1 &pcfg_pull_no=
ne>;
> >> +                                    <4 RK_PC3 RK_FUNC_1 &pcfg_pull_up=
_12ma>,
> >> +                                    <4 RK_PC4 RK_FUNC_1 &pcfg_pull_no=
ne_12ma>;
> >>                      };
> >>              };
> >>
> >>
> >
> >
> >
> >
> >
> >
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
