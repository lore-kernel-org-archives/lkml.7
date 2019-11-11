Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CC2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DB121872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fP0+cp4M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wFRlx5At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfKKNnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:43:11 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30255 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKNnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573479796; x=1605015796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9dsJxH1AdFdhL3F8INOFA7wcHqR25WQKuQ/CsP+77io=;
  b=fP0+cp4MOPLkUP1ZjG9RLNfcZoTI9hXMtCGUXikoZLkB0GwDtm1OA2W6
   DIs5VYSUyl5n9hRvwMOfWlaNyASr93Sa19MN+iEFEHVxEmvTwfgejK5t1
   tk918CFWKb40C32npFK01EpORE2cYJPJzkGVOZjwL09GfitMdjp1ogiqX
   Y+MS4x8MlbpHbrbEywxpmjDCWRBopi1uJ/C2kL9z/S0wX0r5sDfldkNWF
   8oqqVCB30SAFWWRdqxRoHBMajfmBx234DUpYzn636YxS8/NYmlEVlcIsD
   aHhxhw/eTGXIRuNxxToun0iKYLgVrHn4zkaYRxfYEYpD+GL6aGpj/7InJ
   w==;
IronPort-SDR: SxVxGgAfL6LbzD235maQAHdvJC5mET1og4ozS+Vqinqw2UQOzUwv8NThVdVpakUOYxaRsgGihp
 IKvpvXk17EpSg39So2F7TDDoGp7whQDO6+76T/wE6LlxzMsIqOdqTcEjkjzp9vBj1RLZEgS7Dm
 GZiRp0njSDMWW74p9og0FpIarfdzTr+LIuTg1rpK0LsdMOWjXFhLgPln+uhw7G+pVuNxZkanQv
 ZS0UN7tMeZi4jeu/ulxInHSho9Z/vJwmctiR2MmADPX3Wfkx/28D7GhtmBB45512eub0IdwxDo
 Jao=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; 
   d="scan'208";a="223909685"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2019 21:43:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqd57I1EweSCe/hEQPWuJuR27UKGO1oV8QSS3x9QlxTq6z+hkbAG7YvaOjnB9Ub2YnvICS1e3mTIQfDnfkDuPXt/UA4LnY9Xlqz8t70EoHX6RUmANhDDHPVOS0A2zHG/CpksrNmUhcij3X7r5XCfLUzU21o/A4Olvfg6kQlwc0RKhs3fAVPc40Gkb3eEauGppjN02H2TBVuBXjJvdFplLpRedMY0A4PTsr2gsMDZ4XHW52USc78EXYpYAQoCPmOS7ZRGmwBwlJn8AV2WR/eoOIPGDZrFRe7VoFzQyLU5Ch+NHbG4L7AY/PzPan24F1RNwZz5PlsLxkoMVfdakk9YsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPU445Ha4Mif9i1eLQ+9kF/A3LiB6f1/vVEFF0+3R/0=;
 b=EeoCV2ZKkCpTTl8PiDklXbw2LoMC+Cjuged1XhYWkV62X//LXlWZLFVTYMiLGNxf/jKGtEgb3CxBFfp7w18xLW7vVth8zqsQBEN5b+TXpl34/DRq/PdSJ03MwuieqdwcIJZVSBlm3S1YtrPONkfplU0zWgzgCN9Sgjs1sYL5KL2UL6mqL135Yu3gA4DyJcpjhf9CaK+ydxJ+uTt62oAN+Hxb8vk+d9qDZ44/MaGyWqf8lbdA/t8mOCoLKK7V9/pvAwGqRw0tQ6NzX9RpqgenpbflVV+raK8Cen4HXLucByx6zwGvwWzL9Fa+31Hw6OqHMhM2OXONeLtrbvGmhwOgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPU445Ha4Mif9i1eLQ+9kF/A3LiB6f1/vVEFF0+3R/0=;
 b=wFRlx5At4u0d4tITFeCsYVYiVhp43ZbPywjg0S+6+d9rCm7dC+SmGzhMxHJzUeLm2rHLEXCzfS010e1FRu4DSdH2mRUzM8As2lZWcyEdwr5QnGVP+laShfo4ThjYiVoEvThgnMVzGGWFR2r1SurAW7vOUdx2NWBqOkykcCxzekY=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6317.namprd04.prod.outlook.com (52.132.170.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 13:43:08 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd%6]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 13:43:08 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
Thread-Topic: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
Thread-Index: AQHVmJTPyH8iXg4fS0aBJhwN0J4ATaeF+pjw
Date:   Mon, 11 Nov 2019 13:43:08 +0000
Message-ID: <MN2PR04MB60612DF0F3191A8240F71F458D740@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20191111133421.14390-1-anup.patel@wdc.com>
In-Reply-To: <20191111133421.14390-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [106.51.25.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad485637-2810-48e0-c475-08d766ad1641
x-ms-traffictypediagnostic: MN2PR04MB6317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB63171D2513B145C3B4B6874B8D740@MN2PR04MB6317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(13464003)(199004)(189003)(76116006)(26005)(476003)(52536014)(74316002)(99286004)(486006)(54906003)(6246003)(86362001)(186003)(8936002)(55236004)(4326008)(7736002)(53546011)(5660300002)(6506007)(7696005)(66946007)(110136005)(446003)(11346002)(305945005)(33656002)(76176011)(102836004)(71200400001)(71190400001)(66476007)(2906002)(66446008)(64756008)(66556008)(66066001)(25786009)(478600001)(229853002)(9686003)(81156014)(81166006)(55016002)(6116002)(3846002)(8676002)(6436002)(14454004)(256004)(9456002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6317;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gu108lucp+mDkyfiAicBIUy5rEObkl8jybeLEzUc5xZ645JYPT/cXgfSQkYfOr/nb+5FwKLRopVihuVRTb+M+nLyGPO5kjvEqAcJm5jyO80q87UoRRkRtukfgL8rXYWvBGmNXTQxoLynn715I14jUZJ90b0u5tDUU/i5jBcVH8C6yYWjw2oK2Xpz/05ifrT1wdyY/fhVuAv7/L5ZjJD0Zzl+rr9JpFt75//i/OD/bpdEqqu9ZqYc97AF0V/iaifD4FcqDg3S7L2qXAXhRcFQgGnCuW9Ls+RYs3oUEE0slsb1Hg/2YZuVQpzgvEt/FoxUHJbGUs2DkbKsh3yK2kPiO4pDKC3yPwVcn0sXMuzBSZH4t0MSJh5pA0DTWylRIwfizJbPBIdBpY0P4dH4m/DJkbSvIGtJ6rXJOluMa+mDpv7HGVjyyDKRgdQssv3lL60a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad485637-2810-48e0-c475-08d766ad1641
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 13:43:08.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yC5kr073KzBlSOySOWniDTRkB1M6SoLAhHUmpIRqljwHyRMGsE7WgnA+BjrzRic+Xi3TvDoXIgQS8uVPTr1lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct Palmer's email address

> -----Original Message-----
> From: Anup Patel
> Sent: Monday, November 11, 2019 7:05 PM
> To: Palmer Dabbelt <palmer@sifive.com>; Paul Walmsley
> <paul.walmsley@sifive.com>
> Cc: Atish Patra <Atish.Patra@wdc.com>; Alistair Francis
> <Alistair.Francis@wdc.com>; Christoph Hellwig <hch@lst.de>; Anup Patel
> <anup@brainfault.org>; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Anup Patel <Anup.Patel@wdc.com>
> Subject: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
>=20
> We can use SYSCON reboot and poweroff drivers for the SiFive test device
> found on QEMU virt machine and SiFive SOCs.
>=20
> This patch enables SYSCON reboot and poweroff drivers in RV64 and RV32
> defconfigs.
>=20
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/configs/defconfig      | 4 ++++
>  arch/riscv/configs/rv32_defconfig | 4 ++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 420a0dbef386..73a6ee31a7d2 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -63,6 +63,10 @@ CONFIG_HW_RANDOM_VIRTIO=3Dy  CONFIG_SPI=3Dy
> CONFIG_SPI_SIFIVE=3Dy  # CONFIG_PTP_1588_CLOCK is not set
> +CONFIG_POWER_RESET=3Dy
> +CONFIG_POWER_RESET_SYSCON=3Dy
> +CONFIG_POWER_RESET_SYSCON_POWEROFF=3Dy
> +CONFIG_SYSCON_REBOOT_MODE=3Dy
>  CONFIG_DRM=3Dy
>  CONFIG_DRM_RADEON=3Dy
>  CONFIG_DRM_VIRTIO_GPU=3Dy
> diff --git a/arch/riscv/configs/rv32_defconfig
> b/arch/riscv/configs/rv32_defconfig
> index 87ee6e62b64b..1429e1254295 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -61,6 +61,10 @@ CONFIG_VIRTIO_CONSOLE=3Dy
> CONFIG_HW_RANDOM=3Dy  CONFIG_HW_RANDOM_VIRTIO=3Dy  #
> CONFIG_PTP_1588_CLOCK is not set
> +CONFIG_POWER_RESET=3Dy
> +CONFIG_POWER_RESET_SYSCON=3Dy
> +CONFIG_POWER_RESET_SYSCON_POWEROFF=3Dy
> +CONFIG_SYSCON_REBOOT_MODE=3Dy
>  CONFIG_DRM=3Dy
>  CONFIG_DRM_RADEON=3Dy
>  CONFIG_DRM_VIRTIO_GPU=3Dy
> --
> 2.17.1

