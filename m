Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92932C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699CA2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYWBiNew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLIPio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:38:44 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35586 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfLIPio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:38:44 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so15248226iol.2;
        Mon, 09 Dec 2019 07:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZJHtdl64eSg7tX1bls5wY/hgwg2SeBy1mqhpZlCukvg=;
        b=sYWBiNewuyqeitxp4PMfrWb8D5LArfvGYVlnna4mBtaRMWcybALmK4TSqg7M/HKA1i
         85aVtTxdrFrUZO5be9qMmHnxoj2f16hCkwRN6gtWVx+L9JUsxL5DLcePNscgNynYhloC
         VEm6MCqqrVLY1aRK63NYHp9pg3+pwb5JS4nOdvLU+JWQh1qcMOXZjhrE9qxaP0Q4BehK
         Gsn2K/LiOp2/s0TUyEEvu1PvhZpNTUN8pemOAMe5iT4VX7Ac1b2opKqp8pl7TSLhmffY
         HobeBr/5FkeX5fDbHWmaxUGCJKWKMFHairadzP8yQM6TqaCNEtvIec58Uw99BqricfOM
         k+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZJHtdl64eSg7tX1bls5wY/hgwg2SeBy1mqhpZlCukvg=;
        b=r6HIcT/wrZJe5hli8ReOBHqc4OxKhzGQ74KXShZLl4f8SsMA1eG6OqULVmdZT7nw18
         SpjYsPKSuIMmGJyJ6xgfGBcGMDt/lxEw/cRzLyJoVpDZI82m3G3JYAoVRLYmdNpFffBK
         MsSYrGlYUeUgywN6lCfQ6BArlvX2o+t2Hl0mJhwnhPnVsJmpcyPOo0ypqVglZHU192Jf
         cce9+5fLe6i/KVvyM5ouRqnQ80IvIxJPblqcFPnHfYe+NgHZmgTdv3Oi/fFFTIi8xLoe
         WZC4GkhH1jIvKGY2AydgN4jEpkPRZwGtiI5v1BGHoXB7Jw9aoE09vGip1z5xNSt+vG1r
         VC/Q==
X-Gm-Message-State: APjAAAXUI3IaXwvGrumCBGnDZRNAmgQBOt5okZJhAsyK1HU2cIQNRG8G
        DYuzdn7dpTduRAvOVVFy7ataENu4fhII2qNeCbM=
X-Google-Smtp-Source: APXvYqyKe81SV620SWPT3vlC+s2nmZV57gLiyzYp6LoXO4TmESagI9KWQZJxUmkLqawCteKkmS0vffcB403S2IYmD8Y=
X-Received: by 2002:a02:8817:: with SMTP id r23mr28310766jai.120.1575905923417;
 Mon, 09 Dec 2019 07:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20191206184536.2507-1-linux.amoon@gmail.com> <20191206184536.2507-3-linux.amoon@gmail.com>
 <f1327196-66c9-d152-c0ca-914d43d6f55e@arm.com>
In-Reply-To: <f1327196-66c9-d152-c0ca-914d43d6f55e@arm.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 9 Dec 2019 21:08:31 +0530
Message-ID: <CANAwSgTSDX=36eF3UxVyVykguRjd90=x4iT27s=nJg5ezG_V7w@mail.gmail.com>
Subject: Re: [RFCv1 2/8] mfd: rk808: use syscore for RK805 PMIC shutdown
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Schultz <d.schultz@phytec.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, 9 Dec 2019 at 19:04, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 06/12/2019 6:45 pm, Anand Moon wrote:
> > Use common syscore_shutdown for RK805 PMIC to do
> > clean I2C shutdown, drop the unused pm_pwroff_prep_fn
> > and pm_pwroff_fn function pointers.
>
> Coincidentally, I've also been looking at RK805 for the sake of trying
> to get suspend to behave on my RK3328 box, and I've ended up with some
> slightly different cleanup patches - I'll tidy them up and post them for
> comparison as soon as I can.

No issue if their is better clean approach, I will definitely test that ser=
ies.
>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >   drivers/mfd/rk808.c | 33 +++++++++++++++++----------------
> >   1 file changed, 17 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> > index e637f5bcc8bb..713d989064ba 100644
> > --- a/drivers/mfd/rk808.c
> > +++ b/drivers/mfd/rk808.c
> > @@ -467,16 +467,6 @@ static void rk808_update_bits(unsigned int reg, un=
signed int mask,
> >                       "can't write to register 0x%x: %x!\n", reg, ret);
> >   }
> >
> > -static void rk805_device_shutdown(void)
> > -{
> > -     rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF, DEV_OFF);
> > -}
> > -
> > -static void rk805_device_shutdown_prepare(void)
> > -{
> > -     rk808_update_bits(RK805_GPIO_IO_POL_REG, SLP_SD_MSK, SHUTDOWN_FUN=
);
> > -}
> > -
> >   static void rk808_device_shutdown(void)
> >   {
> >       rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF_RST, DEV_OFF_RST);
> > @@ -491,10 +481,23 @@ static void rk8xx_syscore_shutdown(void)
> >   {
> >       struct rk808 *rk808 =3D i2c_get_clientdata(rk808_i2c_client);
> >
> > -     if (system_state =3D=3D SYSTEM_POWER_OFF &&
> > -         (rk808->variant =3D=3D RK809_ID || rk808->variant =3D=3D RK81=
7_ID)) {
> > -             rk808_update_bits(RK817_SYS_CFG(3), RK817_SLPPIN_FUNC_MSK=
,
> > -                             SLPPIN_DN_FUN);
> > +     if (system_state =3D=3D SYSTEM_POWER_OFF) {
> > +             dev_info(&rk808_i2c_client->dev, "System Shutdown Event\n=
");
> > +
> > +             switch (rk808->variant) {
> > +             case RK805_ID:
> > +                     rk808_update_bits(RK805_GPIO_IO_POL_REG,
> > +                                     SLP_SD_MSK, SHUTDOWN_FUN);
> > +                     rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF, DE=
V_OFF);
>
> Why this change? Shutdown via the SLEEP pin is working just fine on my
> box :/
>
> Robin.

As per RK-805 datasheet [0] below.
For clean poweroff we need to set in DEV_CTRL_REG reg
Bit 0 DEV_OFF: write =E2=80=9C1=E2=80=9D to turn down the PMU.

[0] http://files.pine64.org/doc/rock64/Rockchip_RK805_Datasheet_V1.1%C2%A02=
0160921.pdf

-Anand
