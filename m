Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7642CC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 06:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36221208E3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 06:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbeklqhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfFIGSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 02:18:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41914 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfFIGSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 02:18:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id s21so5098977lji.8;
        Sat, 08 Jun 2019 23:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Vo5eaKQWCMq7v7z2ph7sxEFSNuB5Lf75LyEjuFRQsU=;
        b=gbeklqhv5CVhh907QpjsEgaQqjswCM1044mz4/7WNlhZg6tywR07JjbEinmhaPFc79
         p21Nhu7NcWjGThV8grm4UdhkGlFDzkToOqmGRquLjJDndricciBQIFu7VG2IUy8eId/g
         xASjqXHd+XMDy+twqrE4jMu4ZTE5xzD5cEFuFnle5HrN/NB6H8bA+PAJe5kt4FbK0qDR
         dHiJkXpNYFv7Pf3yHzfuw2chVHkO9gVL9bT1BgWX4avTIIVTQinbfmTgB4Xm+MGQDffP
         3g9hpVK2eK2OkuMlMT5It2urrbG8hBhvH95tNSbCmgv82S4odc5wGq9HzDXZqBXf85Ql
         ZlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Vo5eaKQWCMq7v7z2ph7sxEFSNuB5Lf75LyEjuFRQsU=;
        b=Zz3SHgL4K/cSHrIvliAV0Yp2Nmndkomc4DnCXE0zVMMEjkMoTlzTxW+suQTx9pNsn3
         7VRU+dqAJLNMHtIHDN3SbbDq+HXLFp2JgYcKOYqC8/GF3M9cBGlnO51tndW9PRB2Mi9J
         kkBS/4KUDQMVjSyr2aSTpDOeB1MKTFcspTiw7hTHUz3cyk3TIdo+7/vr41xqsAJyR+Wq
         /ZgATrj4gNrjU8HjijQb8Pl+M1p3ZHH3A/i/2C9i+VWj4XfK/n4K7X/w4M/OZxxbzIQo
         zg3GRJErRP1xBCNiWCP7599edIFjHW0LRs/LbE2C66vbBXXmIZdnMr2MfBCwLArQp4kA
         qZVw==
X-Gm-Message-State: APjAAAXX/QatQ4HYkZWp78b/L5p17tbkOXC/lLw8QBCXuEiqT2vcLQXn
        7cq5UsE8l9iNqUCNeUS+zbI=
X-Google-Smtp-Source: APXvYqye6JnuBAsP0g3mvLnlp32I7Us4WHTg9hj/ifomjyySkFiDqstvspKK7uMtV+n3dxSibLa+mw==
X-Received: by 2002:a2e:6e0e:: with SMTP id j14mr4075717ljc.85.1560061102240;
        Sat, 08 Jun 2019 23:18:22 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id q13sm1296215lfk.65.2019.06.08.23.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Jun 2019 23:18:21 -0700 (PDT)
Date:   Sun, 9 Jun 2019 09:18:19 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 5/5] riscv: dts: add initial board data for the
 SiFive HiFive Unleashed
Message-Id: <20190609091819.2d1a97c90c0b44aa9120d373@gmail.com>
In-Reply-To: <20190602080500.31700-6-paul.walmsley@sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com>
        <20190602080500.31700-6-paul.walmsley@sifive.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  2 Jun 2019 01:05:00 -0700
Paul Walmsley <paul.walmsley@sifive.com> wrote:

Hi!

> Add initial board data for the SiFive HiFive Unleashed A00.
>=20
> Currently the data populated in this DT file describes the board
> DRAM configuration and the external clock sources that supply the
> PRCI.
>=20
> This third version incorporates changes based on more comments from
> Rob Herring <robh+dt@kernel.org>.
>=20
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/boot/dts/sifive/Makefile           |  2 +
>  .../boot/dts/sifive/hifive-unleashed-a00.dts  | 67 +++++++++++++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sifive/Makefile
>  create mode 100644 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>=20
> diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/si=
five/Makefile
> new file mode 100644
> index 000000000000..baaeef9efdcb
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sifive/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-y +=3D hifive-unleashed-a00.dtb
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/r=
iscv/boot/dts/sifive/hifive-unleashed-a00.dts
> new file mode 100644
> index 000000000000..1de4ea1577d5
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2018-2019 SiFive, Inc */
> +
> +/dts-v1/;
> +
> +#include "fu540-c000.dtsi"

You already have "/dts-v1/;" in the fu540-c000.dtsi file.

You can omit it in the hifive-unleashed-a00.dts file.

> +/* Clock frequency (in Hz) of the PCB crystal for rtcclk */
> +#define RTCCLK_FREQ		1000000
> +
> +/ {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	model =3D "SiFive HiFive Unleashed A00";
> +	compatible =3D "sifive,hifive-unleashed-a00", "sifive,fu540-c000";
> +
> +	chosen {
> +	};
> +
> +	cpus {
> +		timebase-frequency =3D <RTCCLK_FREQ>;
> +	};
> +
> +	memory@80000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x80000000 0x2 0x00000000>;
> +	};
> +
> +	soc {
> +	};
> +
> +	hfclk: hfclk {
> +		#clock-cells =3D <0>;
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <33333333>;
> +		clock-output-names =3D "hfclk";
> +	};
> +
> +	rtcclk: rtcclk {
> +		#clock-cells =3D <0>;
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <RTCCLK_FREQ>;
> +		clock-output-names =3D "rtcclk";
> +	};
> +};
> +
> +&qspi0 {
> +	flash@0 {
> +		compatible =3D "issi,is25wp256", "jedec,spi-nor";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <50000000>;
> +		m25p,fast-read;
> +		spi-tx-bus-width =3D <4>;
> +		spi-rx-bus-width =3D <4>;
> +	};
> +};
> +
> +&qspi2 {
> +	status =3D "okay";
> +	mmc@0 {
> +		compatible =3D "mmc-spi-slot";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <20000000>;
> +		voltage-ranges =3D <3300 3300>;
> +		disable-wp;
> +	};
> +};
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


--=20
Best regards,
=A0 Antony Pavlov
