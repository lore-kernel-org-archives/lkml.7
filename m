Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8CC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 01:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDC620821
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 01:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HzBR0hn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFVB5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 21:57:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42048 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfFVB5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 21:57:10 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so402648ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 18:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o9ja0i0Kug7ietEVv2OfLuys7cgqJI9m6rpk9IL0EUk=;
        b=HzBR0hn4KCWwDX+Vkzot/ZKRs4r5AauGDqMQCxOAxaV/MhiHj048asHssYNjzftB7I
         9h5aJdVoZLNHz2r9RYQr71i/16oAShL61RDEor+N8QsXWGviZshG+V5b5wy4UwP79xA1
         L8ZDzvZKqbl9Yc5wv1xUIbY8Isy4EQ0M+Hx9m8sUILe17JOaqb2SBV+s63asn6lychrC
         mmJARO+etSJ5No/l0NmFlOp8LtK0Z+x1YjlU2z/EaXahD/j/vuM/0HDt3cRmOxJ6EnlD
         ivo8a8uXQoLgN0E8iduwYPXl3CwmfbyqxlvytQ2Wnf/jbHaG5IjpBexaPqZSxopFKNYE
         5e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o9ja0i0Kug7ietEVv2OfLuys7cgqJI9m6rpk9IL0EUk=;
        b=ISkVLmx9bd+lOVFWDeMJ4OAX3mVKIaGciauD1JYrBpz69xfG8cDaLitohaJbNMHysP
         KAybpgSWnRAUDPgVCUUwRE8QhG5A8pJvcJwLW9c9BJ5EuB6OvFiz4Hwkpl5Ym1tU7qzZ
         hh8annUwcmEAbU+MclcjQa6ROiKpY3+SFIickCZWSOViqx/Hn7dnScpfQepdc+VY6+Yx
         r0PesMDcjMA3qoZm883wlXIe8HYgdhvcbc3bnCgdsbwtHI6KKhVxdqmnR6cfEaNBcM5z
         EIjC9V5qwgBYNBhQJ2+qBVKNTNg1APNuoUEgEBeT772suKLLz6R+CZS2ASsk9jk2GKb4
         744Q==
X-Gm-Message-State: APjAAAXKMxk9lMptcWZrAfCaahiJhhB7k81BrMQ0MeRE67cs+rntjnzl
        qkjI6i8Onpp3KOfWffBBtGuzGg==
X-Google-Smtp-Source: APXvYqxWrlo+p2pAdyLS/a87FUfJYGiJuj5XLuLxdQKEXX0fzdDnTOccTpu5aGPdNY0/8gKuBBUkLA==
X-Received: by 2002:a02:c88e:: with SMTP id m14mr99834292jao.69.1561168629296;
        Fri, 21 Jun 2019 18:57:09 -0700 (PDT)
Received: from [192.168.1.196] ([216.160.37.230])
        by smtp.gmail.com with ESMTPSA id x22sm5669166iob.84.2019.06.21.18.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 18:57:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <A3E7D245-ABFA-4D81-87D6-3F6983AA3A93@sifive.com>
Date:   Fri, 21 Jun 2019 20:57:07 -0500
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "sachin.ghadi@sifive.com" <sachin.ghadi@sifive.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "yash.shah@sifive.com" <yash.shah@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <54493821-0155-4826-B165-B75FBB329D1A@sifive.com>
References: <1561114429-29612-1-git-send-email-yash.shah@sifive.com>
 <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
 <18c7992607dd1fed062bd295ac0738a759eff078.camel@wdc.com>
 <CAF5mof3QB8C7VjOyEvCsf9NEDkJhV3cBO5sBD+8z-GrWrnrAyg@mail.gmail.com>
 <3f91c8032e113a19dcec10ca71b017af1427ef7e.camel@wdc.com>
 <43da99709709d2a480b78f25356cda9255205372.camel@wdc.com>
 <A3E7D245-ABFA-4D81-87D6-3F6983AA3A93@sifive.com>
To:     Atish Patra <Atish.Patra@wdc.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 21, 2019, at 7:33 PM, Troy Benjegerdes =
<troy.benjegerdes@sifive.com> wrote:
>=20
>=20
>=20
>> On Jun 21, 2019, at 4:59 PM, Atish Patra <Atish.Patra@wdc.com> wrote:
>>=20
>> On Fri, 2019-06-21 at 14:46 -0700, Atish Patra wrote:
>>> On Fri, 2019-06-21 at 14:18 -0500, Troy Benjegerdes wrote:
>>>> Can you post the fsbl and other images you used to boot/test this?
>>>>=20
>>>=20
>>=20
>> Resending it without the attachment. Obviously, the mail did not go
>> through with the binary blob attached :( :(. My bad.
>>=20
>> Let me know if you still want me to share the binary with you. I will
>> probably share it via some other method.
>=20
> The bl came through as it was sent direct to me, and I can deal with
> the tftp config manually. I have a kernel image, but not the =
boot.scr.uimg
> that it looks like you are using. Is that from Yocto?

I got console output, after extracting the boot script from yocto.

The important part seems to be calling
=E2=80=98bootm $kernel_addr_r - $fdt_addr_r=E2=80=99

Which maybe leads into a discussion of what can we do to at
least output some sort of useful debug information if the device
tree is not found or invalid?

I=E2=80=99d also like to propose that on RiscV, we use the chosen node
for kernel command line and initrd location (like qemu does), and
in u-boot, default to always passing the device tree from bootm
and other commands (like bootelf)

>=20
>>=20
>>> I have not changed fsbl. It's the default one came with the board.
>>> Here are the heads of OpenSBI + U-Boot + Linux repo.
>>>=20
>>> OpenSBI: cd2dfdc870ed (master)
>>> U-boot: 77f6e2dd0551 + Anup's patch series (v4)
>>> https://github.com/atishp04/u-boot/tree/unleashed_working
>>>=20
>>> Linux: bed3c0d84e7e + Yash's Macb Series + this patch
>>> https://github.com/atishp04/linux/tree/5.2-rc6-pre
>>>=20
>>> I have also attached the OpenSBI + U-boot binary as well. But this =
is
>>> pre-configured with my tftpboot server. You need to change that.
>>>=20
>>>> I keep running into various failures when I build from source and I
>>>> want to rule out potential hardware issues related to clock and/or
>>>> ddr initialization
>>>>=20
>>>> On Fri, Jun 21, 2019, 2:14 PM Atish Patra <Atish.Patra@wdc.com>
>>>> wrote:
>>>>> On Fri, 2019-06-21 at 16:23 +0530, Yash Shah wrote:
>>>>>> DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver
>>>>> added
>>>>>> Signed-off-by: Yash Shah <yash.shah@sifive.com>
>>>>>> ---
>>>>>> arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 16
>>>>>> ++++++++++++++++
>>>>>> arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  9
>>>>> +++++++++
>>>>>> 2 files changed, 25 insertions(+)
>>>>>>=20
>>>>>> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>>> b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>>> index 4e8fbde..c53b4ea 100644
>>>>>> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>>> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>>>>>> @@ -225,5 +225,21 @@
>>>>>>                     #address-cells =3D <1>;
>>>>>>                     #size-cells =3D <0>;
>>>>>>             };
>>>>>> +             eth0: ethernet@10090000 {
>>>>>> +                     compatible =3D "sifive,fu540-macb";
>>>>>> +                     interrupt-parent =3D <&plic0>;
>>>>>> +                     interrupts =3D <53>;
>>>>>> +                     reg =3D <0x0 0x10090000 0x0 0x2000
>>>>>> +                            0x0 0x100a0000 0x0 0x1000>;
>>>>>> +                     reg-names =3D "control";
>>>>>> +                     status =3D "disabled";
>>>>>> +                     local-mac-address =3D [00 00 00 00 00 00];
>>>>>> +                     clock-names =3D "pclk", "hclk";
>>>>>> +                     clocks =3D <&prci PRCI_CLK_GEMGXLPLL>,
>>>>>> +                              <&prci PRCI_CLK_GEMGXLPLL>;
>>>>>> +                     #address-cells =3D <1>;
>>>>>> +                     #size-cells =3D <0>;
>>>>>> +             };
>>>>>> +
>>>>>>     };
>>>>>> };
>>>>>> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-
>>>>>> a00.dts
>>>>>> b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>>>>>> index 4da8870..d783bf2 100644
>>>>>> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>>>>>> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>>>>>> @@ -63,3 +63,12 @@
>>>>>>             disable-wp;
>>>>>>     };
>>>>>> };
>>>>>> +
>>>>>> +&eth0 {
>>>>>> +     status =3D "okay";
>>>>>> +     phy-mode =3D "gmii";
>>>>>> +     phy-handle =3D <&phy1>;
>>>>>> +     phy1: ethernet-phy@0 {
>>>>>> +             reg =3D <0>;
>>>>>> +     };
>>>>>> +};
>>>>>=20
>>>>> Thanks. I am able to boot Unleashed with networking enabled with
>>>>> this
>>>>> patch.
>>>>>=20
>>>>> FWIW,=20
>>>>> Tested-by: Atish Patra <atish.patra@wdc.com>
>>>>>=20
>>>>> Regards,
>>>>> Atish
>>>>> _______________________________________________
>>>>> linux-riscv mailing list
>>>>> linux-riscv@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20

