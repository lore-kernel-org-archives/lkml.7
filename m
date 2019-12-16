Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A46BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440B620717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3vDU5Ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLPQJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:09:30 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37436 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPQJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:09:29 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so5846193ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cpRMnpuuG37oGQE0b+ougpVuIyKezxFskSDMX9nBV5c=;
        b=o3vDU5WwoZleI9RZZByuruOMHxPX8Jc5G00bN37o+oyiIOxoN1f5N7mqV6PbThbbFC
         MqB8GZKW9O26Eq9jxnEcvfGX6OfzmhtfZPs3/efSwsyaO/mBi7Ms3Om0YpU5RE5bEtNJ
         +xQkREB7Wd87S6ncvydsXeCz6o9Ybl9x1kJMFPsZeKoQzrFUtW4JbtoumLnlnxJmZqHv
         US4xrmV3Jt3gD8RXV8ulr5TPfu6O9yZtKePVvxw3mIzL8kr5RQqD01oC/+FbOSl0QaOc
         wCR7zugYf/jZxlKtC+65vbxgmPO26NmQ93Lq1I0Hg4fiyyzERgHGX+H2sQvJxVVnoiTf
         v5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cpRMnpuuG37oGQE0b+ougpVuIyKezxFskSDMX9nBV5c=;
        b=mMXVwn5mdaL3J0BpMOmaL9UNuyuVd1Pjc/56GdyAZUAI1cG7vE3d5omwNDXd1Exp7h
         U9mgsBXccS+P4r/mHqXyK2DIViiIrbCsSKn8QWfSI40GBU6aVV22rYNItyfaHczpsX0Z
         +8Bc7umUszgOGW7avtx34EyM8TkbhC1vZ9OGAHmW32Mp9JeRWeQolaHT6nkbScg0YJlW
         2nAiurhGQD22BAA4A0hF4viG/VnNRrdgndcNzTDa4mlosmPoe0Cya02UiuubZ/g2d4Rh
         8lD5jJwlLQdOrCqptWjzlfpslL29rYW2ruoj+RbicTtgPCrd2AsQpvvszwFu004osxJM
         dV0Q==
X-Gm-Message-State: APjAAAXlSwYWuSTUgT77udyRTIy/PAn2+RxcYzo5ZcbFAcx2vjPPOerJ
        jmfEB3/CZjJ3WQ8yme/CvSRnIuBJgq9kzzhrqa4=
X-Google-Smtp-Source: APXvYqxEvIc3fVXtPmXDLJ0VzbQjsPADshGSsN+ZGGQgy7Xl9n0T94gIIsHFoqHSeFPclKiXgOB6GpXAuRsOmKaTkuI=
X-Received: by 2002:a02:8817:: with SMTP id r23mr12728830jai.120.1576512568600;
 Mon, 16 Dec 2019 08:09:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575932654.git.robin.murphy@arm.com> <8642045f0657c9e782cd698eb08777c9d4c10c8d.1575932654.git.robin.murphy@arm.com>
 <CANAwSgTtzAZJqpsD7uVKskTnDmrT1bs=JuHxnPrkpQKtnZLhvQ@mail.gmail.com>
 <2681192.H4ySjFOPB8@diego> <CANAwSgTL-9VCFFj-+4xsLZOxKCHtjyN4P6fYnuRSOe7cZRiWew@mail.gmail.com>
 <f29fbb91-ffd0-5650-30b4-5791c970a834@arm.com>
In-Reply-To: <f29fbb91-ffd0-5650-30b4-5791c970a834@arm.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 16 Dec 2019 21:39:16 +0530
Message-ID: <CANAwSgSpe=7-jCs4OtnnOoosfG89M-TAu-epC7sG0Gw2c7DrHA@mail.gmail.com>
Subject: Re: [PATCH 4/4] mfd: rk808: Convert RK805 to syscore/PM ops
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Soeren Moch <smoch@web.de>, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, 16 Dec 2019 at 18:08, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2019-12-16 9:50 am, Anand Moon wrote:
> > Hi Heiko / Robin / Soeren,
> >
> > On Mon, 16 Dec 2019 at 01:57, Heiko St=C3=BCbner <heiko@sntech.de> wrot=
e:
> >>
> >> Hi Anand,
> >>
> >> Am Sonntag, 15. Dezember 2019, 19:51:50 CET schrieb Anand Moon:
> >>> On Tue, 10 Dec 2019 at 18:54, Robin Murphy <robin.murphy@arm.com> wro=
te:
> >>>>
> >>>> RK805 has the same kind of dual-role sleep/shutdown pin as RK809/RK8=
17,
> >>>> so it makes little sense for the driver to have to have two complete=
ly
> >>>> different mechanisms to handle essentially the same thing. Bring RK8=
05
> >>>> in line with the RK809/RK817 flow to clean things up.
> >>>>
> >>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >>>> ---
> >>
> >> [...]
> >>
> >>> I am sill getting the kernel warning on issue poweroff see below.
> >>> on my Rock960 Model A
> >>> I feel the reason for this is we now have two poweroff callback
> >>> 1  pm_power_off =3D rk808_device_shutdown
> >>> 2  rk8xx_syscore_shutdown
> >>
> >> Nope, the issue is just the i2c subsystem complaining that the
> >> Rocckhip i2c drives does not provide an atomic-transfer function, see
> >>          "No atomic I2C transfer handler for 'i2c-0'"
> >> in your warning.
> >>
> >> Somewhere it was suggested that the current transfer function just
> >> works as atomic as well.
> >>
> >>
> >>> In my investigation earlier common function for shutdown solve
> >>> the issue of clean shutdown.
> >>
> >> This is simply a result of your syscore-shutdown function running way =
to
> >> early, before the i2c subsystem switched to using atomic transfers.
> >>
> >> This also indicates that this would really be way to early, as other p=
arts
> >> of the kernel could also still be running.
> >>
> >
> > Yes, you are correct syscore-shutdown initiates
> > shutdown before all the device do clean shutdown.
> >
> > So for best approach for clean atomic shutdown is to use
> >    /* driver model interfaces that don't relate to enumeration  */
> >          void (*shutdown)(struct i2c_client *client);
> > drop the registration of syscore and use core .i2c_shutdown.
>
> Huh? If you understand that the syscore shutdown hook is too early, why
> would it seem a good idea to pull the plug even earlier from driver
> shutdown? Not to mention that your patch as proposed breaks all the
> GPIO-based shutdown flows.
>
Ok opps, I might have missed some thing.
I just look into logs to between syscore shutdown and I2C shutdown
get more insight, so I feel I2C shutdown dose clean shutdown.

> If you really care about avoiding the spurious warning, implement the
> expected polled-mode transfer function in the I2C driver. Trying to hack
> around it by issuing I2C-based shutdown from anywhere other than
> pm_power_off is a waste of everyone's time.

I have tired this I2C shutdown approach earlier, but as their were
issue with clean restart, so I dropped this line.
Then I tired to add restart notifier to handle restart that also
did not work my boards, so I am exploring more.

>
> > I have prepare this patch on top of this series for RTF
> > This patch dose clean shutdown of all the devices before poweroff.
> > see the log below.
> >
> > *Note*: This feature will likely break the clean reboot feature.
> > Rockchip device do not perform clean reboot as some of the IP
> > block are not released before clean reboot and it's remain stuck.
> > Like PCIe and MMC, We need to look into this as well.
>
> As mentioned before, that likely has nothing to do with the PMIC, and
> really sounds like the issue with Trusted Firmware not reenabling all
> the SoC power domains before reset - a fix for that has already been
> identified, see here:
> https://forum.armbian.com/topic/7552-roc-rk3399-pc-renegade-elite/?do=3Df=
indComment&comment=3D90289
>
> Robin.
>

If we go with I2C shutdown feature, some how some device will not
release resources and it remains stuck before the initialization next u-boo=
t.
See the log below. https://pastebin.com/xxwvERaz

ATF changes will some into affect after the restart of the devices.
FYI I am testing with all the latest AFT patches from Armbian and latest u-=
boot.

-Anand
