Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34475C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 00:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA812133F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 00:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO6sQOTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDGAiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 20:38:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37062 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDGAiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 20:38:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so12176963wrm.4;
        Sat, 06 Apr 2019 17:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=QZX6uhu7+jP+x84UVrwqAXLJgWszIC7pDB2CNkalw1g=;
        b=QO6sQOThgRlNR8C28L4s2Jjnt+MSsgYyYmpY/+zqppbjzpUDYlcWZPKlaWIZW/ziX5
         3XgUbia1LrXwWn1Bcobwu7Th8ILA+Go1y0EFvtW03L9vyG/A0bZZwkh7U2lQjALU24T5
         Rp7nfq0naXQz4P1ggzKen8SEIxh+AV8QmL3qQlnjK8F6SKM7K1hzflekdWwlhv+vlQnW
         cn3pmuNk8rkXByf2RE8CIiHBRxnyjBQErhFe0I58yWuxxy2Rje0qvJJkKziMVmZAM2sv
         H5kh7Mf5/9CO7IiMgynj7BADblTzyOSCEdvLe2r5kZb+Gvyy62PtfSp/yHtBFEZyDmjt
         zLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=QZX6uhu7+jP+x84UVrwqAXLJgWszIC7pDB2CNkalw1g=;
        b=M6A4EIRRyBH2F/+JQDstZWxbBWD+K8WpMpQl1TCfORAUWuOrWQyNsnobE/RtR6bdnp
         cclDRf/rLwI4N7+Ievz2RAoP8e0TpPOgb9+qgbJEaUv3rG0HQWPC9bL9yJXt8i8Y7I4j
         18GhZTCDuejF7EGu+Uke69Ts3UpIZZHDISW4R4j2pNHi+/Yoy4ZK2ciLVphB/DC72vzj
         bIweainePjfTagxhYO6kzzCwt6Z5+8CWzSGsGxuJXEUoro6uJxcN+jew9PJiv2ScL/hG
         RcnPK25sGUD81JXuezyyaD3PSfM1lg7zPfmajkdLZDKnP+D5VNdGFbCdIi24ar0CSx9V
         6e2A==
X-Gm-Message-State: APjAAAW78PLaihGfgcQIfV7qlmEzlvRqq1KteuTTT4pC7kNJIoF3C34a
        WgFq/brRRpX6n2GDNhdERVpHIb0/gy8=
X-Google-Smtp-Source: APXvYqylrzSCcQ2MmplFeNtpZuj1VHcmNdZjnmgjCt37KQ7hNjUFaFqeGX1oPpU8bKwVb0XhozcwBA==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr14515635wrn.29.1554597490810;
        Sat, 06 Apr 2019 17:38:10 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id f15sm30604012wru.21.2019.04.06.17.38.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Apr 2019 17:38:09 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>
Cc:     <linux-rockchip@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Rockchip SPI: long burst writes produce unexpected result
Date:   Sun, 07 Apr 2019 02:38:08 +0200
MIME-Version: 1.0
Message-ID: <746e632e-63e2-49af-8e8f-e37270beea73@gmail.com>
In-Reply-To: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
please, forget my previous mail about
  eff0275e5253604429aedc42b008c5fcaa6cc597
  spi: rockchip: simplify use_dma logic
i messed up with commit IDs, sorry.

The first offending commit is one later than that:
commit 420b82f842941a32adf309ca1b193adfc77616b0
Date:   Wed Oct 31 11:57:07 2018 +0100

    spi: rockchip: set min/max speed
   =20
    The driver previously checked each transfer if the
    requested speed was higher than possible with the
    current spi clock rate and raised the clock rate
    accordingly.
   =20
    However, there is no check to see if the spi clock
    was actually set that high and no way to dynamically
    lower the spi clock rate again.
   =20
    So it seems any potiential users of this functionality
    are better off just setting the spi clock rate at init
    using the assigned-clock-rates devicetree property.
   =20
    Removing this dynamic spi clock rate raising allows
    us let the spi framework handle min/max speeds
    for us.

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

