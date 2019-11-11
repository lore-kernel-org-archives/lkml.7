Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91117C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545952084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYTrFhSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfKKFko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 00:40:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37164 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfKKFkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 00:40:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id d5so10303281otp.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 21:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVwFZyTl4L89MVBNPAIqT2vmnSRb6oAzSJCvN3fuve0=;
        b=TYTrFhSj/cE7Nr6k0Oiknm3dZMLZzK7o3cd9uY9MlNvvJKHXXyNZPxBgABopOcSxjI
         0sl8gVlSKDFTXOFItZh+JWTFlPknTo9VHQnCJOA1Ob/fRr6x1WiJXh+pUdbWsHg+kON/
         +x4ONLQ6H7fLXgQuYWLOA/J89lC2/VZHZviSTIQNCWi5avGnR4vVOzGdyyUEgz6ZHXFc
         3Z24MT8MSOft64JrYeTSfr5nyrewKDRFteYF+5RSs3y7Va+4Y4yrGqmSlZo51+wf3PLC
         FzhvXy1Io8AbUouk4PkZoOBAGJpIeAi0rMh3HjQkV+3Qn9CPcV0HJDBwrof2rJnyY26U
         OtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVwFZyTl4L89MVBNPAIqT2vmnSRb6oAzSJCvN3fuve0=;
        b=nIto/dG0f1F9KoUXcjc1QwiPHwheKwvYgXoo4VUKbdDNpY0MXO3mjgO7dotw/7yxOO
         P4uW0LMIxXk9+ApIBp9w/LWD9UAddiUIvdGiRBFbY05WKgYsssHV2mjUsljIISH7ACSi
         4ke7lKqhOck9chAuLih0rKGIjEiIrPow193LsXXMHSr73MkpC5RiuMHxavGQavLuVDM5
         Vio0Zrh4pIorGP5juKsbkDjxccT+qnTPeVpcU1jBnGmhS6S4u8SP9cKL0Wy+9tqeJT80
         bi5Hewmje0fa1zinOTMxxSJLUwP6H9aFtTdQBf530N6902ep6QcSF7t6qSWIu7i5Dexm
         aesQ==
X-Gm-Message-State: APjAAAUEBgCqIIVZbAiMkuDD6szZsWDPslUhqkQEbOs3Cw26bHrFl4RT
        b94xnK7Ikgcoz+1LHWQxKi86xbWcpcwt1Zfu3jA=
X-Google-Smtp-Source: APXvYqzlXlUq8fPTm264EpzofYpPZ4upntWwCax/Rx2kDKamyz1s3QPtJ/rgw6soNPjEY+xHw2ovsxHUeLYFTOgtlM8=
X-Received: by 2002:a9d:6acf:: with SMTP id m15mr8288575otq.312.1573450842375;
 Sun, 10 Nov 2019 21:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20190907174833.19957-1-katsuhiro@katsuster.net>
 <CA+E=qVdvKxzFcU-09Ucn1Fr0FdkwSsPcLr8vPn2wsu6-DD1gqg@mail.gmail.com> <abc648cc-0b5d-b407-b74b-639833ba196b@katsuster.net>
In-Reply-To: <abc648cc-0b5d-b407-b74b-639833ba196b@katsuster.net>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sun, 10 Nov 2019 21:40:16 -0800
Message-ID: <CA+E=qVdy-wqmR+XOms5S2zMp+B0vM7Dj_fk9N=08-1WjfKDm0Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add analog audio nodes on rk3399-rockpro64
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 7:30 PM Katsuhiro Suzuki
<katsuhiro@katsuster.net> wrote:
>
> Hello Vasily,

Hi Katsuhiro,

Thanks for response!

> Thank you for reporting.
>
> On 2019/11/11 9:17, Vasily Khoruzhick wrote:
> > On Sat, Sep 7, 2019 at 10:48 AM Katsuhiro Suzuki
> > <katsuhiro@katsuster.net> wrote:
> >>
> >> This patch adds audio codec (Everest ES8316) and I2S audio nodes for
> >> RK3399 RockPro64.
> >
> > Hi Katsuhiro,
> >
> > I tested your patch with my rockpro64 on 5.4-rc6 which has your other
> > patches to es8316 driver, but apparently it doesn't work.
> >
> > 'alsamixer' complains 'cannot load mixer controls: No such device or
> > address' and if I try to play audio with mpg123 it pretends that it
> > plays something but there's no sound.
> >
> > Any idea what can be wrong?
> >
>
> Do you use defconfig? If so I guess we need turn on more configs:
>
> - simple-graph-card driver (CONFIG_SND_AUDIO_GRAPH_CARD)
> - ES8316 (SND_SOC_ES8316)

I have these enabled, card is present in /proc/asound/cards, but
alsamixer doesn't work with it.

> FYI) ASoC related status or logs in my environment as follows:
>
> root@rockpro64:~# uname -a
> Linux rockpro64 5.4.0-rc6-next-20191108 #169 SMP PREEMPT Mon Nov 11 12:21:44 JST 2019 aarch64 GNU/Linux

I'm running 5.4.0-rc6  (commit
00aff6836241ae5654895dcea10e6d4fc5878ca6) with your patch "arm64: dts:
rockchip: add analog audio nodes on rk3399-rockpro64" on top of it.

> root@rockpro64:~# dmesg | grep -i asoc
> [   21.509903] asoc-simple-card hdmi-sound: i2s-hifi <-> ff8a0000.i2s mapping ok
> [   21.510550] asoc-simple-card hdmi-sound: ASoC: no DMI vendor name!
> [   21.567906] asoc-audio-graph-card sound: ES8316 HiFi <-> ff890000.i2s mapping ok
> [   21.568565] asoc-audio-graph-card sound: ASoC: no DMI vendor name!

Similar here:

[vasilykh@rockpro64 ~]$ dmesg | grep -i asoc
[   15.627685] asoc-audio-graph-card sound: ES8316 HiFi <->
ff890000.i2s mapping ok
[   16.250196] asoc-simple-card hdmi-sound: i2s-hifi <-> ff8a0000.i2s mapping ok

> root@rockpro64:~# cat /proc/asound/pcm
> 00-00: ff8a0000.i2s-i2s-hifi i2s-hifi-0 : ff8a0000.i2s-i2s-hifi i2s-hifi-0 : playback 1
> 01-00: ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : playback 1 : capture 1

Same here:

[vasilykh@rockpro64 ~]$ cat /proc/asound/pcm
00-00: ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : ff890000.i2s-ES8316
HiFi ES8316 HiFi-0 : playback 1 : capture 1
01-00: ff8a0000.i2s-i2s-hifi i2s-hifi-0 : ff8a0000.i2s-i2s-hifi
i2s-hifi-0 : playback

> root@rockpro64:~# cat /sys/kernel/debug/asoc/components
> hdmi-audio-codec.3.auto
> ff8a0000.i2s
> ff8a0000.i2s
> ff890000.i2s
> ff890000.i2s
> ff880000.i2s
> ff880000.i2s
> es8316.1-0011
> snd-soc-dummy
> snd-soc-dummy

Same here.

> root@rockpro64:~# cat /sys/kernel/debug/asoc/dais
> i2s-hifi
> ff8a0000.i2s
> ff890000.i2s
> ff880000.i2s
> ES8316 HiFi
> snd-soc-dummy-dai

Same here.

Yet alsamixer doesn't work for me. It terminates with 'cannot load
mixer controls: No such device or address'. Strace shows that fails
here:

openat(AT_FDCWD, "/dev/snd/controlC0", O_RDWR|O_CLOEXEC) = 3
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
ioctl(3, SNDRV_CTL_IOCTL_PVERSION, 0xfffffd3ad04c) = 0
fcntl(3, F_GETFL)                       = 0x20002 (flags O_RDWR|O_LARGEFILE)
fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK|O_LARGEFILE) = 0
ioctl(3, SNDRV_CTL_IOCTL_ELEM_LIST, 0xfffffd3ad228) = 0
ioctl(3, SNDRV_CTL_IOCTL_ELEM_LIST, 0xfffffd3ad228) = 0
ioctl(3, SNDRV_CTL_IOCTL_ELEM_INFO, 0xfffffd3ace38) = 0
ioctl(3, SNDRV_CTL_IOCTL_ELEM_READ, 0xfffffd3ac160) = -1 ENXIO (No
such device or address)

Looks like it fails to talk to the codec?

mpg123 thinks that it's playing audio, but my headphones connected to
3.5mm output are silent.

Regards,
Vasily


> Best Regards,
> Katsuhiro Suzuki
>
>
> > Regards,
> > Vasily
> >
> >> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> >> ---
> >>   .../boot/dts/rockchip/rk3399-rockpro64.dts    | 28 +++++++++++++++++++
> >>   1 file changed, 28 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> >> index 0401d4ec1f45..8b1e6382b140 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> >> @@ -81,6 +81,12 @@
> >>                  reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> >>          };
> >>
> >> +       sound {
> >> +               compatible = "audio-graph-card";
> >> +               label = "rockchip,rk3399";
> >> +               dais = <&i2s1_p0>;
> >> +       };
> >> +
> >>          vcc12v_dcin: vcc12v-dcin {
> >>                  compatible = "regulator-fixed";
> >>                  regulator-name = "vcc12v_dcin";
> >> @@ -470,6 +476,20 @@
> >>          i2c-scl-rising-time-ns = <300>;
> >>          i2c-scl-falling-time-ns = <15>;
> >>          status = "okay";
> >> +
> >> +       es8316: codec@11 {
> >> +               compatible = "everest,es8316";
> >> +               reg = <0x11>;
> >> +               clocks = <&cru SCLK_I2S_8CH_OUT>;
> >> +               clock-names = "mclk";
> >> +               #sound-dai-cells = <0>;
> >> +
> >> +               port {
> >> +                       es8316_p0_0: endpoint {
> >> +                               remote-endpoint = <&i2s1_p0_0>;
> >> +                       };
> >> +               };
> >> +       };
> >>   };
> >>
> >>   &i2c3 {
> >> @@ -505,6 +525,14 @@
> >>          rockchip,playback-channels = <2>;
> >>          rockchip,capture-channels = <2>;
> >>          status = "okay";
> >> +
> >> +       i2s1_p0: port {
> >> +               i2s1_p0_0: endpoint {
> >> +                       dai-format = "i2s";
> >> +                       mclk-fs = <256>;
> >> +                       remote-endpoint = <&es8316_p0_0>;
> >> +               };
> >> +       };
> >>   };
> >>
> >>   &i2s2 {
> >> --
> >> 2.23.0.rc1
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
