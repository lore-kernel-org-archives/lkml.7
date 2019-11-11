Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C465DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D744206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rF2qmtD0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z4NHDNy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKKQvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:51:33 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45367 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKKQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573491092; x=1605027092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j1i1GdBiiAUApn+f5I7B/Tttwyq6lfC8CZRHcfTsuqc=;
  b=rF2qmtD0cT+UahwRp4eLCpI3l/jaYL2UaUeYan0hhrIbtuThyOaYb894
   33ue14vU8Ud5PqOXP3L4SJWsaTTWkOVMH6ktW6VDBx+WKsvLi86csLQUO
   mq0alHvD7XChqIeNagWJOf8I2NjK/r1glHFQZVMiS0ll+9bU+qqtH0J4W
   ku1CVETtRpl1YkaPDMKbSj129AT5nypCiZcrtTxo/++Ng+4Mk7vGmpuOy
   BV5dehh3uHIvn6hhFns/yivHg2OFgKrZW61vBQ7bi65nsiCUpfacInue5
   7pqL1o+rD39IGge+1ph4K1+W/XOyzF4FIOaI0tjhvfPI5JrxjMvcq1dcS
   Q==;
IronPort-SDR: /s0ItR/q+5nfgm3GsBRbiYK1Douw0hGEn2P25+P4Xfi5bneDFcXT8Y4N9nyl9HJLLzoxy4IeXC
 glQrlWsR+4P9/H5RGuEiwBzm5aPoV5nf8gx/ag7mvG8bwGFaHE7RGjx6MLi+lEXcdH2+/Vj7gy
 7A8zKiso6vRQxg4gu7cCaukMszo8Mgl4PMoHbOPhSYzHj7+lkm5ARJQVWO2xhQtSgcRMU6vX8B
 Qs83ha+gLDJudjqzqpgXanshbwV3dXBUlg+8DvcEvs3goATKdKfe22jDnqLcVIkPM5kT8GqyPQ
 2js=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; 
   d="scan'208";a="229970518"
Received: from mail-dm3nam05lp2052.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.52])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 00:51:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS4COFiboKjakDh0pBwZfxwaIyhnAasvMNW8O/OareHqLWp2wBD4zzNJqWbl/k8M17Ux+qXQouFHPBrd7KC1TPKkHkaDKEMzbs8bc5tADRgO2GtynHEbtFg3+qYpWMvhNyO86S2rBxqrNzAsaFBUhme3ITteS2XRrkFASvEZyc4yze9N4i6CJmdQG3t++6HKd+QS9Zr7frXND5Tq0QkqrfolJEPG+JSoIVkZnerQh6bMK2ovJCplIfnSmvsjAHfymTksa3BY2so2gEOEEFkT6jiWdqESYgAJ1eub6/eLWlN+y1aPOdMj6i1ajrv3sf4fPWuS5juPjr6yXpBj0+q3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1i1GdBiiAUApn+f5I7B/Tttwyq6lfC8CZRHcfTsuqc=;
 b=Yx39zNaFQ/5vy/AJflF5X+KpcJQ3CwdXY0iQqhxdv1SjZGGoeucerO48Te4333WAwTf8pWGnxs9oQAz8T6WX5eF53XYreGgMUOrLqyYMtdhVVXDvSYx5RorCox9waNlUPGI6f69oaCsNcp6GhYM8h+cujYsk3wvPebAWhJuqwFGGszKAFvty2TWb7dxN72Av0jN2fqP1XDUlDUMxT9apiVd7VXXSWJFv8wuXLegsiy1bK5pLcoycnC4LdDRRTcqp0w5VVlEImSObzkEX15kWEfl5VdxQovTtes2bo/PFebXtzpct1ilzdPiyYEPqwyiWUOnw+GeCx2nu7tuivgYwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1i1GdBiiAUApn+f5I7B/Tttwyq6lfC8CZRHcfTsuqc=;
 b=z4NHDNy1GWioxsAn7+0mKiH2egjaXd80DX/kH5RReXcufIKynjU8Dh1612gXR8NAWnrynjQOQ4P2rsE5+b+gHiSJX8YoHdIfGgWM5OSf9PacubZpsqlUw8KLD/Rg9dUGfcoj1RSi799gp/RLac92/DX5+pmgfA9qzPlApvWWqhI=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB7088.namprd04.prod.outlook.com (10.186.144.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 16:51:30 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd%6]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 16:51:30 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Andreas Schwab <schwab@suse.de>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
Thread-Topic: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
Thread-Index: AQHVmJTPyH8iXg4fS0aBJhwN0J4ATaeGAc8PgAADVaCAAANcKIAAJlcw
Date:   Mon, 11 Nov 2019 16:51:30 +0000
Message-ID: <MN2PR04MB60611FB55CDCF6AB5930C73A8D740@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20191111133421.14390-1-anup.patel@wdc.com>
        <mvmv9rqcxpq.fsf@suse.de>
        <MN2PR04MB60616625B9BEFF634FA680728D740@MN2PR04MB6061.namprd04.prod.outlook.com>
 <mvm5zjqcwlr.fsf@suse.de>
In-Reply-To: <mvm5zjqcwlr.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.51.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c88a25d-6e2f-438f-9a3f-08d766c766ed
x-ms-traffictypediagnostic: MN2PR04MB7088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB70881358435C856EFB0997A98D740@MN2PR04MB7088.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(13464003)(189003)(199004)(26005)(256004)(478600001)(6916009)(6116002)(316002)(6436002)(55236004)(102836004)(99286004)(25786009)(3846002)(486006)(71190400001)(71200400001)(74316002)(305945005)(4326008)(86362001)(81166006)(81156014)(6246003)(54906003)(8936002)(14454004)(8676002)(7736002)(2906002)(9686003)(11346002)(446003)(52536014)(476003)(55016002)(66946007)(5660300002)(7696005)(76176011)(229853002)(186003)(33656002)(66066001)(66476007)(53546011)(6506007)(66556008)(64756008)(66446008)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB7088;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fxd/bB2rTKsfOhRCX+Go+l14ELxa7uFzQtad2Ju3HKpZKK3wWNKce0YDgjKK5Z7SSGHSY3/WZPUo/mYpZhWu61Wruh1Pv3Z1qbtbUR67vpxIwPKmcYTpGaMPChICSkgAtn5SJ0RvMuW4zta0gQzV7MLyUManZG2GtuJtJjfx/DmRezcDlaaDdlNAbOFCWKZHv3X6lnu+/Ebkx2uGn0E8XInuXufAFKvwRF9gxJNIC8UU6TsGE8+/zN2lNQ2x0OkcO1imn+D2Sh5pJyBR9k6aez8s9yBr+TxfkArj11iC9HK/z6Soq3+myEhtyW+NwfSTXPPEtm2gcyhcUgZ2N29/Ay1c7WAA+sjozy12lQETPwwcUsRCQW8aTB2QHiTPMDVO1vE9DhREInFdBIBXvAXVhcf/3Wi9eO0jFUIHEuw6zXxPVGmcTTcEa9yujVXNydPS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c88a25d-6e2f-438f-9a3f-08d766c766ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 16:51:30.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtzjWfwxgaaatwa6s9sgld8kCUz5ebDhNbbvINDQwZJOQerYXXEdVfOX3AQi+KwNgHKsEvkfoDV6TtGlyP8zdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andreas Schwab <schwab@suse.de>
> Sent: Monday, November 11, 2019 8:02 PM
> To: Anup Patel <Anup.Patel@wdc.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>; Paul Walmsley
> <paul.walmsley@sifive.com>; Atish Patra <Atish.Patra@wdc.com>; Alistair
> Francis <Alistair.Francis@wdc.com>; Christoph Hellwig <hch@lst.de>; Anup
> Patel <anup@brainfault.org>; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
>=20
> On Nov 11 2019, Anup Patel wrote:
>=20
> >> -----Original Message-----
> >> From: Andreas Schwab <schwab@suse.de>
> >> Sent: Monday, November 11, 2019 7:38 PM
> >> To: Anup Patel <Anup.Patel@wdc.com>
> >> Cc: Palmer Dabbelt <palmer@sifive.com>; Paul Walmsley
> >> <paul.walmsley@sifive.com>; Atish Patra <Atish.Patra@wdc.com>;
> >> Alistair Francis <Alistair.Francis@wdc.com>; Christoph Hellwig
> >> <hch@lst.de>; Anup Patel <anup@brainfault.org>;
> >> linux-riscv@lists.infradead.org; linux- kernel@vger.kernel.org
> >> Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff
> >> drivers
> >>
> >> On Nov 11 2019, Anup Patel wrote:
> >>
> >> > We can use SYSCON reboot and poweroff drivers for the SiFive test
> >> > device found on QEMU virt machine and SiFive SOCs.
> >>
> >> I don't see any syscon-reboot compatible in the device tree.
> >
> > I have sent patch to QEMU as well for generating SYSCON DT nodes.
>=20
> What about the kernel DT?

For QEMU virt machine, the DT is generated by QEMU at runtime
so we don't need an explicit DT file in Linux sources.

Regards,
Anup
