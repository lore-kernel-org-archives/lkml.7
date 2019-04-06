Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0D0C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470F621019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk4ehX4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDFWXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 18:23:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42976 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDFWXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 18:23:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so11979523wrx.9;
        Sat, 06 Apr 2019 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=gtx3mkOi0aAun8t35et2Gk5OMBNxnmrDO6yeKzaNKNc=;
        b=Qk4ehX4acDgtOlKEbUaJxdFkCVrjimtCB/MdagTvLtay34aol3uTel0ZAovkqs+FVr
         dJHnbgcVb96yQ+tx/+TbLm32Turx9oe/KOG0ah+kZjkCpMMyVYqqFM5yIA8xRfkgsAHV
         fKSfiYQzAlN3qDai5JqBbt6Soqq0VPnyq3BbQGa4CHZPFUdvMYjXBznZH9CIdITndSIm
         e72BrXoRXOl4IemMkcji6iY+nAEAX3gphEZ6bpUl7bpnzxVqfo1Dd3gVIeQ4VUVfhGvi
         Z8uiZ3MyUuwBNUfFYq+XGVPitOEHctPaVxInNovAz7Hc7rxSl1LgG3MbS29d6R3ytjyS
         bGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=gtx3mkOi0aAun8t35et2Gk5OMBNxnmrDO6yeKzaNKNc=;
        b=b1BsVNKC5K8ejyLomq2dV/Dj4G9h2fbtp+I/6lF+ZPGA8NBAnQVTwnx1eg2WwpzJJO
         X9GoNZA5cD4TWf3lW6RzkK8JiiqsKLBDuLN7yPf5PsFK7Q32L3PWMr22NuTZLayohERI
         RUebrjUZnEeJbJ6UhGhOSWmZFD1kvjjNUWagrWezR7pbbPWmwObQQCGFuI+aJaUh89Pn
         PYD7jfrl7MvYUwtqWrRg+8AmIrUEFGkkDWfITHFdbTA9uTFtJdHQzOPC6ZLIMmJd8DcQ
         k0bopARLJ5mgoaBLthkIn2vMOV4Vu9uyG64jTQNLk+KfuPBcTVfqNFUZUoRU3tMe0DW5
         yH4g==
X-Gm-Message-State: APjAAAV2dGfNUhIdlv6hZ6VsplJTQiAIcyuAT2X/72xmwK5fw+eTSgSV
        LzPjN+EM5hlOIlqzhFAq+KTXe5J91fE=
X-Google-Smtp-Source: APXvYqzfqzlTkBHvth7D+N2w6JdJ+bkmJe2LXwgT+YIW7HctHoMQtTQDJ+iN269MXhMeoSRtbPGqmg==
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr12859634wro.170.1554589416018;
        Sat, 06 Apr 2019 15:23:36 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id l23sm4881940wmj.10.2019.04.06.15.23.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Apr 2019 15:23:34 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>
Cc:     <linux-rockchip@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Rockchip SPI: long burst writes produce unexpected result
Date:   Sun, 07 Apr 2019 00:23:33 +0200
MIME-Version: 1.0
Message-ID: <0168f45b-e624-4da0-878e-655f0f731e13@gmail.com>
In-Reply-To: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,
just found the first offending commit:

commit eff0275e5253604429aedc42b008c5fcaa6cc597
Date:   Wed Oct 31 11:57:06 2018 +0100

    spi: rockchip: simplify use_dma logic
   =20
    We only need to know if we're using dma when setting
    up the transfer, so just use a local variable for
    that.

It was mainlined in Linux v5.0.

This is the result of a binary search among this list of commits:
04290192f7ebe892828f69ac57c4684e25da378d
65498c6ae2414a1425aa6c4231e79e2998afec05
01b59ce5dac856323a0c13c1d51d99a819f32efe
74b7efa82b11914c21e30d987ed61d3daa57ff21
420b82f842941a32adf309ca1b193adfc77616b0
eff0275e5253604429aedc42b008c5fcaa6cc597
d790c342e689ea77a5cf72d5b993299911ee5276
eee06a9ee2cd5deaddc5f77ce8f6118c8b82b2a0
fc1ad8ee33480bdf0493b54907b74538bf9b75b8
ce386100d99976442093ff57b5b24a9562c6cc27
fab3e4871f623c8f86e8a0e00749f1480ffa08db
2410d6a3c3070e205169a1a741aa78898e30a642
31bcb57be12fd815a9051f07d64334809b8cb472
30688e4e670d21126aa596df4523940e2f8d24de
a3c174021ce780f5d2e9b2105e2cb4903a37226d
d9071b7e9fc474e474e3b865428a8d30d88daaf4
f340b920511a666b02d371e88801d3817ea7a880
058f7c509e84abd36f988d4e16432366bd793d8f
dcfc861d24ec19f0d0d3d55bb016646794571fbb
dd8fd2cbc73f8650f651da71fc61a6e4f30c1566

Regards,
  Vicen=C3=A7.

On Saturday, April 6, 2019 7:34:32 PM CEST, Vicente Bergas wrote:
> Hi,
> i have been experiencing issues writing to NOR-Flash SPI Memories
> from two RK3399-based platforms: gru-kevin and sapphire board.
> For kevin, this resulted in a bricked device because that memory
> is the only boot device.
> Fortunately an external programmer is available.
>
> In order to isolate where the issue can be, several tests have been
> done, after which it makes me think the issue is related to the
> Rockchip SPI driver.
>
> 4KB burst reads work fine.
> The issue is only observed on the write burst length.
>
> Test user     user/kernel kernel    RK3399  Num  space   =20
> interface   space       SoC   Status Notes=20
> --------------------------------------------------------
> 1    flashrom linux_mtd   MTD/RKspi RKspi   Fail
> 2    flashrom linux_spi   RKspi     RKspi   Fail
> 3    flashrom linux_spi   spi_gpio  GPIO    OK
> 4    custom   linux_spi   spi_gpio  GPIO    OK   260-byte burst writes
> 5    custom   linux_spi   RKspi     RKspi   Fail 260-byte burst writes
> 6    custom   linux_spi   RKspi     RKspi   OK     1-byte burst writes
> 7    custom   linux_spi   RKspi     RKspi   OK    47-byte burst writes
> 8    custom   linux_spi   RKspi     RKspi   Fail  48-byte burst writes
>
> 3, 4) Unaccetably slow, device tree is
>  spi_gpio {
>    compatible =3D "spi-gpio";
>    #address-cells =3D <1>;
>    #size-cells =3D <0>;
>    cs-gpios   =3D <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
>    sck-gpios  =3D <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
>    mosi-gpios =3D <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
>    miso-gpios =3D <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
>    num-chipselects =3D <1>;
>    spidev@0 {
>      compatible =3D "spidev";
>      reg =3D <0>;
>      spi-max-frequency =3D <50000000>;
>    };
>  };
> 2, 5, 6, 7, 8) device tree is
>  &spi1 {
>    status =3D "okay";
>    spidev@0 {
>      compatible =3D "spidev";
>      reg =3D <0>;
>      spi-max-frequency =3D <50000000>;
>    };
>  };
> 5, 6, 7, 8) Burst writes are performed this way
>  enum { BURST =3D 48 };
>  struct spi_ioc_transfer msg[0x105];
>  unsigned i =3D 0;
>  for (unsigned j =3D 0; j < wcnt; j +=3D BURST) {
>    msg[i++] =3D { .tx_buf =3D warr, .len =3D BURST<wcnt-j ? BURST : wcnt-j =
};
>    warr +=3D BURST;
>  }
>  if (rcnt)
>    msg[i++] =3D { .rx_buf =3D rarr, .len =3D rcnt };
>  ioctl(fd, SPI_IOC_MESSAGE(i), msg);
> 1, 2, 5, 8) I have no logic analyzer to see what is happenning on the
> SPI bus, but when it fails at 48-byte bursts, the contents of the memory
> are like this:
> Addr Expected                                        Actual
> 000  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 010  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 020  FF FF FF FF FF FF FF FF FF FF FF FF F1 F2 F3 F4  FF FF FF=20
> FF FF FF FF FF FF F1 F2 F3 F4 FF FF FF
> 030  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 040  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 050  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 060  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 070  FF FF FF FF FF FF FF FF FF FF FF FF E1 E2 E3 E4  FF FF FF=20
> FF FF FF E1 E2 E3 E4 FF FF FF FF FF FF
> 080  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 090  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0A0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0B0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0C0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0D0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0E0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 0F0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 780  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 790  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7A0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7B0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7C0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7D0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7E0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7F0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 FF FF=20
> FF FF FF FF FF FF FF FF FF FF FF FF FF
> 800  01 02 03 04 00 00 00 00 00 00 00 00 00 00 00 00  01 02 03=20
> 04 00 00 00 00 00 00 00 00 00 00 00 00
> 810  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 820  00 00 00 00 00 00 00 00 00 00 00 00 05 06 07 08  00 00 00=20
> 00 00 00 00 00 00 05 06 07 08 00 00 00
> 830  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 840  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 850  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 860  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
> 870  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00=20
> 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> Regards,
>  Vicen=C3=A7.
>
>
>

