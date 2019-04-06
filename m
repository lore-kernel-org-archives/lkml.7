Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34504C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29EE213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMu6tqRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDFReh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 13:34:37 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:32983 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfDFReh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 13:34:37 -0400
Received: by mail-wr1-f52.google.com with SMTP id q1so11621017wrp.0;
        Sat, 06 Apr 2019 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:user-agent
         :content-transfer-encoding;
        bh=922JEjccApCj82iz5uZPCYJJCIUu+JvOgZ+xR8ZEMjY=;
        b=iMu6tqRcaj9vZlfdH8r/b//41d+HURHTSDwmuCj1Ey3Z28VNJIrnLZ2s5qjBp4jJbS
         gdEJZosuyA3LmhhlIgEeTqqC8WGZhBFSYl5sdzjx0y8akM4a3Dw0IBoYgetrhweXLS+b
         p0cx33GGo57C+ym3oJf1Z87/ruyyLc1Esc3GgKKx+Tvoyyq46CMWQB6FZ3GdtwIFWP5j
         4rqXHxgSbRIsUhFLFsprQNct7lZU5Qla5duNyRHEOVa34KBPgPjO5s4fVUwa2E6VaLaf
         KI7bYO/fkUiwUZNidHvKuNVILwBMtq82rgxGeSwPiWkcILtinziFnCr8KyJcpRdqxTv2
         acBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :user-agent:content-transfer-encoding;
        bh=922JEjccApCj82iz5uZPCYJJCIUu+JvOgZ+xR8ZEMjY=;
        b=lmc/aLSUGEvc9caZly3rFyCz9ONMBAum297oOUY7eRcAIK5fC5+XM2x/Ixec2a7EN4
         HJIDh0r7CiqW5ZrBqEByEVP/aQqdZjk9jYrDkkKeApzf2FiPHQbKJU5cOuzZjbKTpoCo
         bkACG3xPFNaRsGdGWPl8MRx+/dmxk46hGcrD9lmY9f/B0/YBgUKx7jBJx8+tc9EnkYuU
         /crv0sTrRK3L46dABXKmIX6ZBmXFocyW+zVR+rgrnICTzIBDj4um+MvXhNS+HsbzUyGu
         PNj0LGS+HdAmdIjFKaMgprNPVDyubCR95emlrtGLYOcqfmZuMCbwKXkwhpzsLn4psIKQ
         TjNw==
X-Gm-Message-State: APjAAAUSeJdRJ1/JZeXUscMec2HAuhQijRtG85JvXl9OdKih063adaJh
        eU6Jr0Yb/yXVwp2jh4dVBaQ=
X-Google-Smtp-Source: APXvYqxfUMc6aeKxasGUhz7yDeGFRa58nbyVu3vChxiQ8BgtNPy5nfr8GiRMZPuf1n00pSeG+TYyTg==
X-Received: by 2002:adf:eac9:: with SMTP id o9mr12158138wrn.85.1554572074876;
        Sat, 06 Apr 2019 10:34:34 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id d6sm35360220wrx.62.2019.04.06.10.34.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Apr 2019 10:34:33 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     <linux-rockchip@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [BUG] Rockchip SPI: long burst writes produce unexpected result
Date:   Sat, 06 Apr 2019 19:34:32 +0200
MIME-Version: 1.0
Message-ID: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i have been experiencing issues writing to NOR-Flash SPI Memories
from two RK3399-based platforms: gru-kevin and sapphire board.
For kevin, this resulted in a bricked device because that memory
is the only boot device.
Fortunately an external programmer is available.

In order to isolate where the issue can be, several tests have been
done, after which it makes me think the issue is related to the
Rockchip SPI driver.

4KB burst reads work fine.
The issue is only observed on the write burst length.

Test user     user/kernel kernel    RK3399 =20
Num  space    interface   space       SoC   Status Notes=20
--------------------------------------------------------
1    flashrom linux_mtd   MTD/RKspi RKspi   Fail
2    flashrom linux_spi   RKspi     RKspi   Fail
3    flashrom linux_spi   spi_gpio  GPIO    OK
4    custom   linux_spi   spi_gpio  GPIO    OK   260-byte burst writes
5    custom   linux_spi   RKspi     RKspi   Fail 260-byte burst writes
6    custom   linux_spi   RKspi     RKspi   OK     1-byte burst writes
7    custom   linux_spi   RKspi     RKspi   OK    47-byte burst writes
8    custom   linux_spi   RKspi     RKspi   Fail  48-byte burst writes

3, 4) Unaccetably slow, device tree is
  spi_gpio {
    compatible =3D "spi-gpio";
    #address-cells =3D <1>;
    #size-cells =3D <0>;
    cs-gpios   =3D <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
    sck-gpios  =3D <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
    mosi-gpios =3D <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
    miso-gpios =3D <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
    num-chipselects =3D <1>;
    spidev@0 {
      compatible =3D "spidev";
      reg =3D <0>;
      spi-max-frequency =3D <50000000>;
    };
  };
2, 5, 6, 7, 8) device tree is
  &spi1 {
    status =3D "okay";
    spidev@0 {
      compatible =3D "spidev";
      reg =3D <0>;
      spi-max-frequency =3D <50000000>;
    };
  };
5, 6, 7, 8) Burst writes are performed this way
  enum { BURST =3D 48 };
  struct spi_ioc_transfer msg[0x105];
  unsigned i =3D 0;
  for (unsigned j =3D 0; j < wcnt; j +=3D BURST) {
    msg[i++] =3D { .tx_buf =3D warr, .len =3D BURST<wcnt-j ? BURST : wcnt-j }=
;
    warr +=3D BURST;
  }
  if (rcnt)
    msg[i++] =3D { .rx_buf =3D rarr, .len =3D rcnt };
  ioctl(fd, SPI_IOC_MESSAGE(i), msg);
1, 2, 5, 8) I have no logic analyzer to see what is happenning on the
SPI bus, but when it fails at 48-byte bursts, the contents of the memory
are like this:
Addr Expected                                        Actual
000  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
010  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
020  FF FF FF FF FF FF FF FF FF FF FF FF F1 F2 F3 F4  FF FF FF FF FF FF FF=20=

FF FF F1 F2 F3 F4 FF FF FF
030  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
040  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
050  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
060  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
070  FF FF FF FF FF FF FF FF FF FF FF FF E1 E2 E3 E4  FF FF FF FF FF FF E1=20=

E2 E3 E4 FF FF FF FF FF FF
080  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
090  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
0A0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
0B0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
0C0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
0D0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
0E0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
0F0  FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
780  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
790  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
7A0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
7B0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
7C0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
7D0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
7E0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
7F0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 FF FF FF FF FF FF=20=

FF FF FF FF FF FF FF FF FF
800  01 02 03 04 00 00 00 00 00 00 00 00 00 00 00 00  01 02 03 04 00 00 00=20=

00 00 00 00 00 00 00 00 00
810  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
820  00 00 00 00 00 00 00 00 00 00 00 00 05 06 07 08  00 00 00 00 00 00 00=20=

00 00 05 06 07 08 00 00 00
830  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
840  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
850  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
860  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00
870  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00=20=

00 00 00 00 00 00 00 00 00

Regards,
  Vicen=C3=A7.

