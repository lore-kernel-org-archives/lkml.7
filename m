Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ABDC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1391A20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IADQVgxw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nbJeuwoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfE1Tjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:39:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24036 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfE1Tjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559072393; x=1590608393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pDm+yZFIujJ7QTWmqI58E0O5KhL8o5L1P7FmsIb+nYo=;
  b=IADQVgxwnZg3FXWhIiSWVgKPOl/7D7hvdZkn/vZ7W54zaqT086j+l4j/
   MX7Q88ADIXN84qZCKIZVFsXPvFoEE/kONRF8BNFgSa2eMm1IAciqVf5FK
   0ObNy5UHtsmuXx/4grtW55X59OQZyQrIbz1vW4VwRnOOxn4Ofo0sVdf08
   QR1Kzn9PiFxrsvdEnqJDoL7a5cYRiXvz68pnxHL5ADPIQXmB98cjgbJu8
   /TpytZQGdafMIW7G/NsviMK2faxEWrfN7fVGBnVyrrrPanpgInGQur3Fp
   luyDZ5SmPe+uhsHlE7Gm7wt6mrpyONgmHK5TSCE0g2gmFlKcT86x3UnId
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,524,1549900800"; 
   d="scan'208";a="110501281"
Received: from mail-bn3nam01lp2051.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.51])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2019 03:39:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W67Qir3BIAsf/NdGF83FfMN8+DPqyn4zD+vfmNA2cOc=;
 b=nbJeuwocRZDs4Siq2bs5ysk1L52rHQmQpPaiOFhGHoh6fIvLASb5J73WK9gYqvTOEDV00ztf/F6gkPTEpi2KpJ/dLVjGMP2kijhfwUHw3OuXh0ASzd+GO2BQwBOaSMjYLRL9W6brxuKveY7Mi3KLeIbMuy4tbe/3g8ruvYHy0b8=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB6101.namprd04.prod.outlook.com (20.178.234.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.16; Tue, 28 May 2019 19:39:48 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ce8:bf96:aaf8:d2b0]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ce8:bf96:aaf8:d2b0%4]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 19:39:48 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
CC:     Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
Thread-Topic: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
Thread-Index: AQHVCue2HEus4pRvEEGYJRX3qv0JO6Zzr7wAgA01ZYCAAB9GgA==
Date:   Tue, 28 May 2019 19:39:48 +0000
Message-ID: <D5957468-5A82-46FA-9D12-A35CF59C7DED@wdc.com>
References: <mhng-2b0ca072-2d6d-4422-96a2-2a4254255cc6@palmer-si-x1e>
In-Reply-To: <mhng-2b0ca072-2d6d-4422-96a2-2a4254255cc6@palmer-si-x1e>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2607:fb90:9e4d:a2f5:7c7d:af93:6799:77fe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3d3fb38-b60b-42d0-67da-08d6e3a43ed2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6101;
x-ms-traffictypediagnostic: BYAPR04MB6101:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB610173B68036EC99F4E032A0FA1E0@BYAPR04MB6101.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(366004)(39860400002)(376002)(189003)(199004)(53754006)(68736007)(36756003)(7736002)(305945005)(76116006)(91956017)(82746002)(256004)(4326008)(6246003)(46003)(54906003)(2501003)(66946007)(66476007)(66556008)(33656002)(6486002)(25786009)(53936002)(73956011)(110136005)(64756008)(66446008)(186003)(476003)(229853002)(446003)(2616005)(486006)(11346002)(81166006)(316002)(53546011)(102836004)(72206003)(83716004)(478600001)(81156014)(86362001)(76176011)(71190400001)(14454004)(5660300002)(8676002)(6116002)(2906002)(71200400001)(6436002)(6512007)(99286004)(6506007)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6101;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /LUGS4mxWdKS+kChM5P8Xl/etz/qCq3fWYReMI2IJsx1K/tEqLec/bUnB754tzRQySAHt/WzaKB8mzZ/rE1hgnPPbi9izd5yhIkAUHfCcZwP4oB5RUoeptlc437Orfx1pqXgpzrcyFmIAs85WUWcXHhvgCBVdudZoUlCiNN+L/K8/9kKX9pN1EKJ1VQ5bc3cYjFjs7HpIWeLgSXdQUxv696WByKZ5ELRNLiAMzXPo+tnFWUJ4KHXFEizSVERZECm7sBA7OEx09TAXVQNYqK8q8mcaK5vpCqEF6Jn5SRLs0xM6JW/eJoks4v8q16zHlLKfp73jAQpmdgAbS+oOrRj0L0Y5BdMB/rHpoWf88kYRLkI2+5tK7BaM1sO1yKxSuYtbZDJcMTUd4t3a3gxfhqD5xSOocUFa3nR4lY2RkXrm9U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4BBE119699369469910373B8DD1AFC8@sharedspace.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d3fb38-b60b-42d0-67da-08d6e3a43ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 19:39:48.6112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 5/28/19 10:47 AM, Palmer Dabbelt wrote:
>> On Mon, 20 May 2019 01:05:22 PDT (-0700), anup@brainfault.org wrote:
>>> On Wed, May 15, 2019 at 12:00 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>>>=20
>>> This patch enables NO_HZ_IDLE (idle dynamic ticks) and HIGH_RES_TIMERS
>>> (hrtimers) in RV32 and RV64 defconfigs.
>>>=20
>>> Both of the above options are enabled by default for architectures
>>> such as x86, ARM, and ARM64.
>>>=20
>>> The idle dynamic ticks helps use save power by stopping timer ticks
>>> when the system is idle whereas hrtimers is a much improved timer
>>> subsystem compared to the old "timer wheel" based system.
>>>=20
>>> This patch is tested on SiFive Unleashed board and QEMU Virt machine.
>>>=20
>>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>>> ---
>>>  arch/riscv/configs/defconfig      | 2 ++
>>>  arch/riscv/configs/rv32_defconfig | 2 ++
>>>  2 files changed, 4 insertions(+)
>>>=20
>>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfi=
g
>>> index 2fd3461e50ab..f254c352ec57 100644
>>> --- a/arch/riscv/configs/defconfig
>>> +++ b/arch/riscv/configs/defconfig
>>> @@ -1,5 +1,7 @@
>>>  CONFIG_SYSVIPC=3Dy
>>>  CONFIG_POSIX_MQUEUE=3Dy
>>> +CONFIG_NO_HZ_IDLE=3Dy
>>> +CONFIG_HIGH_RES_TIMERS=3Dy
>>>  CONFIG_IKCONFIG=3Dy
>>>  CONFIG_IKCONFIG_PROC=3Dy
>>>  CONFIG_CGROUPS=3Dy
>>> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv3=
2_defconfig
>>> index 1a911ed8e772..d5449ef805a3 100644
>>> --- a/arch/riscv/configs/rv32_defconfig
>>> +++ b/arch/riscv/configs/rv32_defconfig
>>> @@ -1,5 +1,7 @@
>>>  CONFIG_SYSVIPC=3Dy
>>>  CONFIG_POSIX_MQUEUE=3Dy
>>> +CONFIG_NO_HZ_IDLE=3Dy
>>> +CONFIG_HIGH_RES_TIMERS=3Dy
>>>  CONFIG_IKCONFIG=3Dy
>>>  CONFIG_IKCONFIG_PROC=3Dy
>>>  CONFIG_CGROUPS=3Dy
>>> --
>>> 2.17.1
>>=20
>> Hi All,
>>=20
>> Any comments on this one?
>>=20
>> @Palmer, It would be nice to have this in Linux-5.2
> My only issue here is testing: IIRC last time we tried this it ended up c=
ausing
> trouble. =20

Are you talking about the trouble with CONFIG_NO_HZ_IDLE we were seeing las=
t year or something else ?

CONFIG_NO_HZ_IDLE was well tested and fixed last year.

I'm in the process of switching to Yocto right now for my tests, so
> it'll be a bit slow.


--=20
Regards,
Atish
