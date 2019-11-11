Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C69C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD5621925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cvvIxmTn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0JCD0jWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKKOVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:21:20 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56611 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573482079; x=1605018079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H9zX0Z03m1/s45FOzq/NRRoefdvEnMBmZj3HEXgbN2Q=;
  b=cvvIxmTnFSi7Df6zA/h2LiUdC/ZILKxz0oqpa7T4ARiF/nvP2e/STKp3
   jzpM83Brz0yHjrG3rzimpWmmS1qAMmXmSteR50D0oB6JEbvUMeoKoqplw
   eEYmOrKB1EwYyW+rUMtGtoVXqCbrosB5YelaptH245hlbylk7Y8fGwhIv
   NdxxzmaPo14QdV/BJimFA1VbEH5jqgLqr1lpAbVPYyJmOnm5CdWlGibWH
   y13dN3ZxKSdLOnCFysI+yiaT1l6bUtq8y4qNqAwRZCO5rburPiKl16SMG
   8R1fiN5ydO9KyX7zlgL5POf4MuPJKzLF/XGtcakBpWSOvVqbj8PH4PVTS
   A==;
IronPort-SDR: xNKDda+GjchRMYRybDIrsUQGU4PVGS05hCXvZL3CRwPcN8o0omyCZ6dE/k30IivuqYH7h3fA+j
 J0fIGucO9gVC87o/U5v2Qhho4IXNGjiq3HT+150R7z16Zy0cS76BjzxKQdk2Pi/jBEWqbYxIct
 2M5MLqdS4MjZJSkSqoV7ghvuhM13ptS5UhY/fAMbQuqNAOcCUnE1Vk0SoOMeOqFIhRxK/m5aIb
 K80wr4ln0ed1ZasEznF/Pcv1QTrUDjltM3mdycg2KUyoD3TwrM1x3Wr9cqR7j5BQHYpHFdBVCs
 QBE=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; 
   d="scan'208";a="124272872"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2019 22:21:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba0VdEZefxUcjfbEQ51Z2HJvFxFOpV6dRIj4s4/d1ZRpne71j4Rzk7BPLkDPHVsBAU8QyrXzPFgVDMIjfQYBDeLXktbUXowxtKWBJ8iGEbAgBj44PUeJlEC2GVTFC9z1nkQDGdZM3shdOxsljsxtjssFT/fNhf0EjmsDb/Nn9E81q0yfCH3RO0+0zQdyN8SSUBz0XDqBjdRLzBB6vcc3zy7poYKGn3qJ2KRY1Sfr9qRx9z8NoDWdg0Z2wWHd9PmQ+oqYJtNfKb8+tTGgBhWvTCdX5OZsQrCRHtnIXe4pO4Db0t+4/0fjkW+MnyhtyZxXYgVoNgYeGpgcuco5XPfU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG77yiC/4u7GNqYrkuJiaeYUIHkbzkmZtGiXbOOzqOY=;
 b=gaP52lpejkKxPfK3trAd10NBpIPvJNXNeTw5bx/VB7ktgnq2FEiHKVdtrCXBYkvZagLTLZO5tuSqFjJr8DtdoCIhahL7+tmvXIYU8u8WH20mlRhqw8U++wEqyMv8HXtOl635pZrjHetKjA3wEzw/ZOYA37EC4dR28h0V5WxBXdWvkmlhFuhyqGt77GTsAj2FhnbuYWsPyT1ReFRdQGih0ol42k4qZQA15IFuxB+BX8FoILoisurkCd7Ji/HYvOKOFBGatHAN3ACxvMxl9MDyTdgpUA/EOuvEkIGvoBK+pogYEz/Hc4nKjmn5urKDordIbCd8Z4W5yfsN40QWbkTgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG77yiC/4u7GNqYrkuJiaeYUIHkbzkmZtGiXbOOzqOY=;
 b=0JCD0jWR9Wr0fkXDl03rjbAvVqqovF/CSF104tiqB8z49PGklbKcg0H1okWHGWf7GItA2pYaB7eOTvDgtBLJgQdq04UhbLaXFTzvifdqdn149vf8ey7LXfJaCe8QEuzOJctT/FhHdXDSfqzKqkasys8RkoK4yrrJJtUf24gMtzc=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6207.namprd04.prod.outlook.com (20.178.247.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Mon, 11 Nov 2019 14:21:17 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd%6]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 14:21:17 +0000
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
Thread-Index: AQHVmJTPyH8iXg4fS0aBJhwN0J4ATaeGAc8PgAADVaA=
Date:   Mon, 11 Nov 2019 14:21:17 +0000
Message-ID: <MN2PR04MB60616625B9BEFF634FA680728D740@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20191111133421.14390-1-anup.patel@wdc.com>
 <mvmv9rqcxpq.fsf@suse.de>
In-Reply-To: <mvmv9rqcxpq.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.51.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa30377c-904e-4af0-4254-08d766b26adb
x-ms-traffictypediagnostic: MN2PR04MB6207:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB62076D6611D57A95651455358D740@MN2PR04MB6207.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(199004)(189003)(13464003)(54906003)(478600001)(74316002)(486006)(64756008)(66446008)(66946007)(76116006)(6116002)(3846002)(4326008)(55016002)(9686003)(66556008)(66476007)(6246003)(6436002)(6916009)(33656002)(316002)(86362001)(14454004)(11346002)(102836004)(7736002)(305945005)(81156014)(2906002)(81166006)(52536014)(26005)(76176011)(71200400001)(71190400001)(53546011)(446003)(6506007)(4744005)(66066001)(5660300002)(55236004)(186003)(8676002)(99286004)(8936002)(25786009)(476003)(256004)(7696005)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6207;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h/rHSEA0DEeUxxiXF4WUbfFgMFD80dJrXwPzI/tupQXPAcJy+ZjzIQmdHCGNvFjYQxzcMy/d645eJzovg+41sXn/wLcaQ/QcfR7cxnkiqDHBjm0U/O3hFmDvRFisT2dY9ZebMshV5BuJev4k2QQtJOMe70Wja5JPdEHnD2uua3YQfZssXq+N1fXtBBa+0CLucTiu3zaKWlw4HFnRjO9+x9XYM0gEpmx9pBDJcZ1cjowqn/CaU/42aVfyd3z4mFSB7BCcP+UvsJNrjX+EY8Y1L9puR3mVAuShmV8+3Onb7mEBEUQpt8sEqqZqb4BFU5ljHM8mCIYAUXpdqFUt+D3giq8CvD8tty50y7JW6RX7HmwYnTR/areZtuW2DyS/PnNJsdZh0yZ9f+wjLBjZF8OhS6tZ3mNjDpgBFoO2CwpOUQ6c5kaWHS7UN5ujjrwmmo6M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa30377c-904e-4af0-4254-08d766b26adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 14:21:17.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HiVAtZZQIuUpc3PBxLSEiGxc7dGk5SqquTS8J79zH61gOojOm7YbP/4k+xq//SQgf991YNPPv/VwMbfjrvOOrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andreas Schwab <schwab@suse.de>
> Sent: Monday, November 11, 2019 7:38 PM
> To: Anup Patel <Anup.Patel@wdc.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>; Paul Walmsley
> <paul.walmsley@sifive.com>; Atish Patra <Atish.Patra@wdc.com>; Alistair
> Francis <Alistair.Francis@wdc.com>; Christoph Hellwig <hch@lst.de>; Anup
> Patel <anup@brainfault.org>; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
>=20
> On Nov 11 2019, Anup Patel wrote:
>=20
> > We can use SYSCON reboot and poweroff drivers for the SiFive test
> > device found on QEMU virt machine and SiFive SOCs.
>=20
> I don't see any syscon-reboot compatible in the device tree.

I have sent patch to QEMU as well for generating SYSCON DT nodes.

Regards,
Anup

>=20
> Andreas.
>=20
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de GPG Key fingerprint =3D 0196
> BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7 "And now for something
> completely different."
