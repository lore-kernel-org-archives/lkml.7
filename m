Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DD6C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EA32245B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjVppIUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfKMPCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:02:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35351 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfKMPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:02:19 -0500
Received: by mail-qt1-f196.google.com with SMTP id n4so2908747qte.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 07:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2YLxw/q3FZr6omCXRBp0Mr2j6AnQdam6b70u/Sm0jVk=;
        b=gjVppIURWTLm0d9f+NpI7+qhqC0RgjrlzJPi+DxWuNshyIHwuw+phyL/BMoj3G4YmA
         6e2oLholw5RkSk3ErtcdWN+g2ZH3qKAHOytODEIBfMevF3UGLIxsSUKbAwEg0XbqPpPM
         yWIn1lj1TaHJhQlanRV6yHN8gqAcLRrfQDiXwcd1JvjZGspAPlemzocVzxF+5pUIElCS
         Xg3/ahIPlKjoPbf0U+a8BPGT9lRz77GjDsIdn2TANsfxpvRf2rjWU0lbeUrEA6vfuNLD
         /e8sBMidAiB4FSt+z05qAlyR65R4hQ9/o+ZQPQgwTT86XFqdgbHOhCoeaUi+UjN4ZEnd
         gf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2YLxw/q3FZr6omCXRBp0Mr2j6AnQdam6b70u/Sm0jVk=;
        b=roHbKwog4kbFoIwxYvXgniAMTU3RL9mi2y7BybH5qXYIEPQUFy8Oj3Ddxa/sH86HAr
         ACtASmRLEOOzSjGBg01ZM/5hacKfd2pPmI5UbjCFh5upLY0WHr1KE7tcoRwYZZFbaXsI
         2Yh0izFakqo/EIjm3AVvH9Vc+OTs0hD+YeISgOfFwmIBS4sTg6XxhjdUrOYmf0nlUtyb
         vjvXmj6Y6Wney3PRMkiAkG33bvQdh7SfknEuA/rD+X6xAgChbfCClhp8vp3JNY22+bcs
         SjqS1XCQFQ4/paYzUkcrn6PYR3GPsz73xU4dpBtSrDj4eWm3SgN90ZThrjJgpeg9IGH+
         WtKw==
X-Gm-Message-State: APjAAAXqCI+Y35XWDHSGgWyNFJb7Ypo2ukAVmTuVgE1bJSc/tdFmk1hR
        lLsllx4Myb2+YRWzhxtKCy3P30ymAheDIw==
X-Google-Smtp-Source: APXvYqxuRs8sA9jAIhaudhBYPysRL+KIZ16g39NQsNFkMulcQ7y1LnOmmIAhcqDfR0webSA6QL1wcQ==
X-Received: by 2002:aed:3702:: with SMTP id i2mr2845791qtb.312.1573657337005;
        Wed, 13 Nov 2019 07:02:17 -0800 (PST)
Received: from [192.168.109.33] ([208.91.121.54])
        by smtp.gmail.com with ESMTPSA id t2sm1042720qkt.95.2019.11.13.07.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 07:02:16 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] arm64: dts: rockchip: add analog audio nodes on
 rk3399-rockpro64
From:   Hugh Cole-Baker <sigmaris@gmail.com>
In-Reply-To: <CA+E=qVcXcUJCa86ru+0=wwY7_3GFLJaGQtLeZ1wVZZqqG4-KrA@mail.gmail.com>
Date:   Wed, 13 Nov 2019 10:02:10 -0500
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEA6221E-A09B-46F2-A3F3-3771CE2368B3@gmail.com>
References: <20190907174833.19957-1-katsuhiro@katsuster.net>
 <CA+E=qVdvKxzFcU-09Ucn1Fr0FdkwSsPcLr8vPn2wsu6-DD1gqg@mail.gmail.com>
 <abc648cc-0b5d-b407-b74b-639833ba196b@katsuster.net>
 <CA+E=qVdy-wqmR+XOms5S2zMp+B0vM7Dj_fk9N=08-1WjfKDm0Q@mail.gmail.com>
 <CA+E=qVdLzHbNTemMSmhA=-0dsNumQZJhjE-EnXBDu+j7sXTnVw@mail.gmail.com>
 <81666aeb-f3d0-e653-6597-0711a05f9b8d@katsuster.net>
 <CA+E=qVcgs=2T_9axUCJwTKgmKhjsJJ9mUfvYJbyjg59rGGjcTg@mail.gmail.com>
 <CA+E=qVe5QmJ8-zSbKj23mb-GksjD+qN=aFaCT7OGUYPYc9Y_ow@mail.gmail.com>
 <1ecd115a-1d33-020d-4a09-6fc451588920@katsuster.net>
 <CA+E=qVcXcUJCa86ru+0=wwY7_3GFLJaGQtLeZ1wVZZqqG4-KrA@mail.gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 12 Nov 2019, at 14:46, Vasily Khoruzhick <anarsoul@gmail.com> =
wrote:
>=20
> On Tue, Nov 12, 2019 at 10:34 AM Katsuhiro Suzuki
> <katsuhiro@katsuster.net> wrote:
>>=20
>> On 2019/11/12 14:49, Vasily Khoruzhick wrote:
>>> On Mon, Nov 11, 2019 at 9:43 PM Vasily Khoruzhick =
<anarsoul@gmail.com> wrote:
>>>>=20
>>>> On Mon, Nov 11, 2019 at 9:34 PM Katsuhiro Suzuki
>>>> <katsuhiro@katsuster.net> wrote:
>>>>>=20
>>>>> Hello Vasily,
>>>>>=20
>>>>> Thank you for valuable information.
>>>>>=20
>>>>> On 2019/11/12 4:25, Vasily Khoruzhick wrote:
>>>>>> On Sun, Nov 10, 2019 at 9:40 PM Vasily Khoruzhick =
<anarsoul@gmail.com> wrote:
>>>>>>>=20
>>>>>>> On Sun, Nov 10, 2019 at 7:30 PM Katsuhiro Suzuki
>>>>>>> <katsuhiro@katsuster.net> wrote:
>>>>>>>>=20
>>>>>>>> Hello Vasily,
>>>>>>>=20
>>>>>>> Hi Katsuhiro,
>>>>>>>=20
>>>>>>> Thanks for response!
>>>>>>=20
>>>>>> Looks like on my board codec sits at address 0x10, and according =
to
>>>>>> schematics that's what its address is supposed to be.
>>>>>>=20
>>>>>> See http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
>>>>>>=20
>>>>>> Codec address is selected by pin CE of ES8316, and on rockpro64 =
it
>>>>>> goes to GND through R226. So address should be 0x10.
>>>>>>=20
>>>>>=20
>>>>> Yes, I agree. The schematics both v2.0 and v2.1 say that ES8316
>>>>> address is 0x10. Thank you for pointing.
>>>>>=20
>>>>> But I wonder that my RockPro64 behavior is strange, he is in =
address
>>>>> 0x11. (R226 on my board is broken...??)
>>>>>=20
>>>>> root@rockpro64:~# i2cdetect 1
>>>>> WARNING! This program can confuse your I2C bus, cause data loss =
and worse!
>>>>> I will probe file /dev/i2c-1.
>>>>> I will probe address range 0x03-0x77.
>>>>> Continue? [Y/n] y
>>>>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 10: -- UU -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>> 70: -- -- -- -- -- -- -- --
>>>>>=20
>>>>> I plan to check R226 resistance value to judge R226 is broken or =
not
>>>>> after return to home. And share the result with you.
>>>>> Please give me a time.
>>>>=20
>>>> Thanks for confirming that on your board it's on address 0x11. I
>>>> checked with some other rockpro64 owners and they have it on 0x10, =
but
>>>> looks like we have boards with codec on different address in the =
wild.
>>>=20
>>> Another datapoint is that my board is 2.0. If yours is 2.1 it can be =
a
>>> difference between 2.0 and 2.1.
>>>=20
>>=20
>> I'm using v2.1 board.
>>=20
>>=20
>> I'll share the checking result. It's a little strange.
>>=20
>> 1) Voltage of CE pin of ES8316
>>=20
>> It is 1.8V when booting linux-next kernel.
>>=20
>>=20
>> 2) My board
>>=20
>> I can't find no crack nor broken parts on my board.
>>=20
>>=20
>> 2) R225, R226
>>=20
>> As you know, RockPro64 board has no silk print so we cannot know
>> perfectly which resistance is R226. So this is my assumption.
>>=20
>>        PCIe, SD card slot
>>           (top)
>> LAN (left)ES8316(right) USB, reset button
>>=20
>> On the left space of ES8316 there is no resistance, only a pattern.
>> This is maybe R225. And 10K resistance on the right side of a
>> pattern. I assume this is R226.
>>=20
>> If my assumption is correctly, board implementation and schematics
>> are different.
>>=20
>> schematics of v2.1 gets something wrong...??
>=20
> Guess we need few more RockPro64 v2.1 owners to confirm that it's
> indeed the case.

I also have a RockPro64 board v2.1, and my ES8316 codec is at address =
0x11.
I'm using a kernel with Katsuhiro's patch and I can use alsamixer and =
play
sounds out of the analog jack. My i2cdetect output:

root@kodi64:~# i2cdetect 1
WARNING! This program can confuse your I2C bus, cause data loss and =
worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- UU -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- =E2=80=94

Regards,
Hugh

>=20
>>=20
>>>>> Best Regards,
>>>>> Katsuhiro Suzuki
>>>>>=20
>>>>>=20
>>>>>>>> Thank you for reporting.
>>>>>>>>=20
>>>>>>>> On 2019/11/11 9:17, Vasily Khoruzhick wrote:
>>>>>>>>> On Sat, Sep 7, 2019 at 10:48 AM Katsuhiro Suzuki
>>>>>>>>> <katsuhiro@katsuster.net> wrote:
>>>>>>>>>>=20
>>>>>>>>>> This patch adds audio codec (Everest ES8316) and I2S audio =
nodes for
>>>>>>>>>> RK3399 RockPro64.
>>>>>>>>>=20
>>>>>>>>> Hi Katsuhiro,
>>>>>>>>>=20
>>>>>>>>> I tested your patch with my rockpro64 on 5.4-rc6 which has =
your other
>>>>>>>>> patches to es8316 driver, but apparently it doesn't work.
>>>>>>>>>=20
>>>>>>>>> 'alsamixer' complains 'cannot load mixer controls: No such =
device or
>>>>>>>>> address' and if I try to play audio with mpg123 it pretends =
that it
>>>>>>>>> plays something but there's no sound.
>>>>>>>>>=20
>>>>>>>>> Any idea what can be wrong?
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Do you use defconfig? If so I guess we need turn on more =
configs:
>>>>>>>>=20
>>>>>>>> - simple-graph-card driver (CONFIG_SND_AUDIO_GRAPH_CARD)
>>>>>>>> - ES8316 (SND_SOC_ES8316)
>>>>>>>=20
>>>>>>> I have these enabled, card is present in /proc/asound/cards, but
>>>>>>> alsamixer doesn't work with it.
>>>>>>>=20
>>>>>>>> FYI) ASoC related status or logs in my environment as follows:
>>>>>>>>=20
>>>>>>>> root@rockpro64:~# uname -a
>>>>>>>> Linux rockpro64 5.4.0-rc6-next-20191108 #169 SMP PREEMPT Mon =
Nov 11 12:21:44 JST 2019 aarch64 GNU/Linux
>>>>>>>=20
>>>>>>> I'm running 5.4.0-rc6  (commit
>>>>>>> 00aff6836241ae5654895dcea10e6d4fc5878ca6) with your patch =
"arm64: dts:
>>>>>>> rockchip: add analog audio nodes on rk3399-rockpro64" on top of =
it.
>>>>>>>=20
>>>>>>>> root@rockpro64:~# dmesg | grep -i asoc
>>>>>>>> [   21.509903] asoc-simple-card hdmi-sound: i2s-hifi <-> =
ff8a0000.i2s mapping ok
>>>>>>>> [   21.510550] asoc-simple-card hdmi-sound: ASoC: no DMI vendor =
name!
>>>>>>>> [   21.567906] asoc-audio-graph-card sound: ES8316 HiFi <-> =
ff890000.i2s mapping ok
>>>>>>>> [   21.568565] asoc-audio-graph-card sound: ASoC: no DMI vendor =
name!
>>>>>>>=20
>>>>>>> Similar here:
>>>>>>>=20
>>>>>>> [vasilykh@rockpro64 ~]$ dmesg | grep -i asoc
>>>>>>> [   15.627685] asoc-audio-graph-card sound: ES8316 HiFi <->
>>>>>>> ff890000.i2s mapping ok
>>>>>>> [   16.250196] asoc-simple-card hdmi-sound: i2s-hifi <-> =
ff8a0000.i2s mapping ok
>>>>>>>=20
>>>>>>>> root@rockpro64:~# cat /proc/asound/pcm
>>>>>>>> 00-00: ff8a0000.i2s-i2s-hifi i2s-hifi-0 : ff8a0000.i2s-i2s-hifi =
i2s-hifi-0 : playback 1
>>>>>>>> 01-00: ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : =
ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : playback 1 : capture 1
>>>>>>>=20
>>>>>>> Same here:
>>>>>>>=20
>>>>>>> [vasilykh@rockpro64 ~]$ cat /proc/asound/pcm
>>>>>>> 00-00: ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : =
ff890000.i2s-ES8316
>>>>>>> HiFi ES8316 HiFi-0 : playback 1 : capture 1
>>>>>>> 01-00: ff8a0000.i2s-i2s-hifi i2s-hifi-0 : ff8a0000.i2s-i2s-hifi
>>>>>>> i2s-hifi-0 : playback
>>>>>>>=20
>>>>>>>> root@rockpro64:~# cat /sys/kernel/debug/asoc/components
>>>>>>>> hdmi-audio-codec.3.auto
>>>>>>>> ff8a0000.i2s
>>>>>>>> ff8a0000.i2s
>>>>>>>> ff890000.i2s
>>>>>>>> ff890000.i2s
>>>>>>>> ff880000.i2s
>>>>>>>> ff880000.i2s
>>>>>>>> es8316.1-0011
>>>>>>>> snd-soc-dummy
>>>>>>>> snd-soc-dummy
>>>>>>>=20
>>>>>>> Same here.
>>>>>>>=20
>>>>>>>> root@rockpro64:~# cat /sys/kernel/debug/asoc/dais
>>>>>>>> i2s-hifi
>>>>>>>> ff8a0000.i2s
>>>>>>>> ff890000.i2s
>>>>>>>> ff880000.i2s
>>>>>>>> ES8316 HiFi
>>>>>>>> snd-soc-dummy-dai
>>>>>>>=20
>>>>>>> Same here.
>>>>>>>=20
>>>>>>> Yet alsamixer doesn't work for me. It terminates with 'cannot =
load
>>>>>>> mixer controls: No such device or address'. Strace shows that =
fails
>>>>>>> here:
>>>>>>>=20
>>>>>>> openat(AT_FDCWD, "/dev/snd/controlC0", O_RDWR|O_CLOEXEC) =3D 3
>>>>>>> fcntl(3, F_SETFD, FD_CLOEXEC)           =3D 0
>>>>>>> ioctl(3, SNDRV_CTL_IOCTL_PVERSION, 0xfffffd3ad04c) =3D 0
>>>>>>> fcntl(3, F_GETFL)                       =3D 0x20002 (flags =
O_RDWR|O_LARGEFILE)
>>>>>>> fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK|O_LARGEFILE) =3D 0
>>>>>>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_LIST, 0xfffffd3ad228) =3D 0
>>>>>>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_LIST, 0xfffffd3ad228) =3D 0
>>>>>>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_INFO, 0xfffffd3ace38) =3D 0
>>>>>>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_READ, 0xfffffd3ac160) =3D -1 ENXIO =
(No
>>>>>>> such device or address)
>>>>>>>=20
>>>>>>> Looks like it fails to talk to the codec?
>>>>>>>=20
>>>>>>> mpg123 thinks that it's playing audio, but my headphones =
connected to
>>>>>>> 3.5mm output are silent.
>>>>>>>=20
>>>>>>> Regards,
>>>>>>> Vasily
>>>>>>>=20
>>>>>>>=20
>>>>>>>> Best Regards,
>>>>>>>> Katsuhiro Suzuki
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>> Regards,
>>>>>>>>> Vasily
>>>>>>>>>=20
>>>>>>>>>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>>>>>>>>> ---
>>>>>>>>>>    .../boot/dts/rockchip/rk3399-rockpro64.dts    | 28 =
+++++++++++++++++++
>>>>>>>>>>    1 file changed, 28 insertions(+)
>>>>>>>>>>=20
>>>>>>>>>> diff --git =
a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts =
b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>>>>>>>> index 0401d4ec1f45..8b1e6382b140 100644
>>>>>>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>>>>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>>>>>>>> @@ -81,6 +81,12 @@
>>>>>>>>>>                   reset-gpios =3D <&gpio0 RK_PB2 =
GPIO_ACTIVE_LOW>;
>>>>>>>>>>           };
>>>>>>>>>>=20
>>>>>>>>>> +       sound {
>>>>>>>>>> +               compatible =3D "audio-graph-card";
>>>>>>>>>> +               label =3D "rockchip,rk3399";
>>>>>>>>>> +               dais =3D <&i2s1_p0>;
>>>>>>>>>> +       };
>>>>>>>>>> +
>>>>>>>>>>           vcc12v_dcin: vcc12v-dcin {
>>>>>>>>>>                   compatible =3D "regulator-fixed";
>>>>>>>>>>                   regulator-name =3D "vcc12v_dcin";
>>>>>>>>>> @@ -470,6 +476,20 @@
>>>>>>>>>>           i2c-scl-rising-time-ns =3D <300>;
>>>>>>>>>>           i2c-scl-falling-time-ns =3D <15>;
>>>>>>>>>>           status =3D "okay";
>>>>>>>>>> +
>>>>>>>>>> +       es8316: codec@11 {
>>>>>>>>>> +               compatible =3D "everest,es8316";
>>>>>>>>>> +               reg =3D <0x11>;
>>>>>>>>>> +               clocks =3D <&cru SCLK_I2S_8CH_OUT>;
>>>>>>>>>> +               clock-names =3D "mclk";
>>>>>>>>>> +               #sound-dai-cells =3D <0>;
>>>>>>>>>> +
>>>>>>>>>> +               port {
>>>>>>>>>> +                       es8316_p0_0: endpoint {
>>>>>>>>>> +                               remote-endpoint =3D =
<&i2s1_p0_0>;
>>>>>>>>>> +                       };
>>>>>>>>>> +               };
>>>>>>>>>> +       };
>>>>>>>>>>    };
>>>>>>>>>>=20
>>>>>>>>>>    &i2c3 {
>>>>>>>>>> @@ -505,6 +525,14 @@
>>>>>>>>>>           rockchip,playback-channels =3D <2>;
>>>>>>>>>>           rockchip,capture-channels =3D <2>;
>>>>>>>>>>           status =3D "okay";
>>>>>>>>>> +
>>>>>>>>>> +       i2s1_p0: port {
>>>>>>>>>> +               i2s1_p0_0: endpoint {
>>>>>>>>>> +                       dai-format =3D "i2s";
>>>>>>>>>> +                       mclk-fs =3D <256>;
>>>>>>>>>> +                       remote-endpoint =3D <&es8316_p0_0>;
>>>>>>>>>> +               };
>>>>>>>>>> +       };
>>>>>>>>>>    };
>>>>>>>>>>=20
>>>>>>>>>>    &i2s2 {
>>>>>>>>>> --
>>>>>>>>>> 2.23.0.rc1
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> _______________________________________________
>>>>>>>>>> linux-arm-kernel mailing list
>>>>>>>>>> linux-arm-kernel@lists.infradead.org
>>>>>>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>=20
>>>>>=20
>>>=20
>>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

