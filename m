Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65722C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 18:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9342070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 18:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="at0ibNP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFVSPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 14:15:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42435 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVSPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 14:15:36 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so2346614ior.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BIcRqsgDXayymj+Ku1N955o6u3WrPmmoPvChsB+QKGI=;
        b=at0ibNP5XuqFVFVIo8SswkbJu1g6jk8r4zMQhu18QrNYqV66ulyKPfysi4MW+yonvu
         dSVYNeWEFEX9BVtKTOvAMRyvH0EUZIk246vNZYA1OmjwXfYbNN2Zx1mpz2Typjt7Yu5a
         QoRG/aWeaGtoScqn+wmzvpoTblze7EvD/iuLH8xvm5jfDA8BqBxqPpo9WIhJZ2PTLJtn
         jtR9skmCSNbjwJecOoeNa038Zdc09KlKcqbZKyVRdIFoBs9vcGfcI5+MNb4qwgU8owI6
         eycrZ0b5e0qh+ske1yf+RUenwv0Ip5i7dx18JtxGhu/GAzja8We3mYXAhtw5T4kLyrWP
         ivbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BIcRqsgDXayymj+Ku1N955o6u3WrPmmoPvChsB+QKGI=;
        b=SAKHU934eKY7gKep4FHCNgS4szVnIXlJjH50OCNQmcBM7uqKYpysXwIXsh9bLsNTms
         dwsHc5sxrTv/cCNc7OACIlpfGZzKc2BjK0hl+xdeKMcDKec8y7kbzYZvAwhcHMm0AaHd
         VhWa9bNLAfutXRMOibfrliAtf2EJzMrwNDy/89ZfVtolkUeb1ns+UNvHqdtHVj4gok73
         XSGd/qcaS0QILa3FqrSC9XZ1zjo3ljFk+A1r0TUDGkK1rXSej8b6+Q9DQWi7C/Dq/Sbh
         OssgR/3zc8xL7Ie+28XjoZCvRx4P2XM1z5uN/U8ZOrK+5JV7CGMww50nZ5N3CsrQTRzz
         8b5g==
X-Gm-Message-State: APjAAAUasU0pLILTNT/0GxVxF/zuiawHM3NfaTaYKtvCBAVDvQn/WMLd
        ahhzFp8Xrdt+JYa+lzsRGztcmQ==
X-Google-Smtp-Source: APXvYqwbUuI6pYqEW3xUO9duU+C7aelY2bo+uYR/A2Ny5gYHLTlczbg6foBJTh1C3L//AV4ckU7iAQ==
X-Received: by 2002:a5e:da47:: with SMTP id o7mr8936752iop.83.1561227335113;
        Sat, 22 Jun 2019 11:15:35 -0700 (PDT)
Received: from [192.168.1.196] ([216.160.37.230])
        by smtp.gmail.com with ESMTPSA id l11sm7667385ioj.32.2019.06.22.11.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 11:15:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <18c7992607dd1fed062bd295ac0738a759eff078.camel@wdc.com>
Date:   Sat, 22 Jun 2019 13:15:33 -0500
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sachin.ghadi@sifive.com" <sachin.ghadi@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <24385C38-D1FC-46B0-8AAA-0FB0B371784A@sifive.com>
References: <1561114429-29612-1-git-send-email-yash.shah@sifive.com>
 <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
 <18c7992607dd1fed062bd295ac0738a759eff078.camel@wdc.com>
To:     Atish Patra <Atish.Patra@wdc.com>,
        "yash.shah@sifive.com" <yash.shah@sifive.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 21, 2019, at 2:14 PM, Atish Patra <Atish.Patra@wdc.com> wrote:
>=20
> On Fri, 2019-06-21 at 16:23 +0530, Yash Shah wrote:
>> DT node for SiFive FU540-C000 GEMGXL Ethernet controller driver added
>>=20
>> Signed-off-by: Yash Shah <yash.shah@sifive.com>
>> ---
>> arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 16
>> ++++++++++++++++
>> arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  9 +++++++++
>> 2 files changed, 25 insertions(+)
>>=20
>> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> index 4e8fbde..c53b4ea 100644
>> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> @@ -225,5 +225,21 @@
>> 			#address-cells =3D <1>;
>> 			#size-cells =3D <0>;
>> 		};
>> +		eth0: ethernet@10090000 {
>> +			compatible =3D "sifive,fu540-macb";
>> +			interrupt-parent =3D <&plic0>;
>> +			interrupts =3D <53>;
>> +			reg =3D <0x0 0x10090000 0x0 0x2000
>> +			       0x0 0x100a0000 0x0 0x1000>;
>> +			reg-names =3D "control";
>> +			status =3D "disabled";
>> +			local-mac-address =3D [00 00 00 00 00 00];
>> +			clock-names =3D "pclk", "hclk";
>> +			clocks =3D <&prci PRCI_CLK_GEMGXLPLL>,
>> +				 <&prci PRCI_CLK_GEMGXLPLL>;
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> 	};
>> };
>> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>> b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>> index 4da8870..d783bf2 100644
>> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>> @@ -63,3 +63,12 @@
>> 		disable-wp;
>> 	};
>> };
>> +
>> +&eth0 {
>> +	status =3D "okay";
>> +	phy-mode =3D "gmii";
>> +	phy-handle =3D <&phy1>;
>> +	phy1: ethernet-phy@0 {
>> +		reg =3D <0>;
>> +	};
>> +};
>=20
> Thanks. I am able to boot Unleashed with networking enabled with this
> patch.
>=20
> FWIW,=20
> Tested-by: Atish Patra <atish.patra@wdc.com>
>=20
> Regards,
> Atish

I am able to boot using a build from the dev/new-dts branch of
my freedom-u-sdk development tree [1] which has this patch
with an additional reset-gpios entry for the ethernet phy in the
DTS provided by the legacy U-boot[2].

Tested-by: Troy Benjegerdes <troy.benjegerdes@sifive.com>

[1] https://github.com/tmagik/freedom-u-sdk=20
[2] =
https://github.com/sifive/HiFive_U-Boot/blob/081373fa3eb0ca79ba3f4a703e8e8=
3a15135a6d1/arch/riscv/dts/hifive_u540.dts#L73=
