Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52D1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9096A2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GlWlZuhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfDJLe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:34:58 -0400
Received: from mail-eopbgr720045.outbound.protection.outlook.com ([40.107.72.45]:63072
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727206AbfDJLe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDazmL4jxGhMFKxVIN1BH2viyngjgUTetdMEllbTPKU=;
 b=GlWlZuhQGSWJpF75TLLVtzZ9WpfnjGcG++6XdTKEa32nis00u55pshiyM9oFHm8eLhhec1lpzHidfUGZZy54WClpsfPAm0o+FMoJBmy19z1+pSQucFp0l/7tbJ2lgJbyY70WC/FlDPQtLR/GflK49pBl2c2ku41CuevhP9carrY=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3360.namprd02.prod.outlook.com (10.164.187.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 11:34:54 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e%6]) with mapi id 15.20.1792.016; Wed, 10 Apr 2019
 11:34:54 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: RE: [LINUX PATCH v2] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Thread-Topic: [LINUX PATCH v2] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Thread-Index: AQHU72CQokUgK4c5p0uN3jcGhVB6d6Y1MkAAgAAHvTA=
Date:   Wed, 10 Apr 2019 11:34:54 +0000
Message-ID: <MWHPR02MB26238A8F658DED8B3B32A5CAAF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1554875085-25350-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190410103106.GE6106@sirena.org.uk>
In-Reply-To: <20190410103106.GE6106@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ac4cbf6-13d0-4cff-1719-08d6bda88d9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR02MB3360;
x-ms-traffictypediagnostic: MWHPR02MB3360:
x-microsoft-antispam-prvs: <MWHPR02MB3360B5DE7B602AB09F349860AF2E0@MWHPR02MB3360.namprd02.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(376002)(136003)(13464003)(199004)(189003)(8676002)(68736007)(76176011)(3846002)(26005)(7736002)(5660300002)(14454004)(74316002)(305945005)(102836004)(86362001)(478600001)(6246003)(4326008)(186003)(81156014)(54906003)(81166006)(9686003)(8936002)(6506007)(53936002)(53546011)(446003)(97736004)(99286004)(486006)(316002)(11346002)(476003)(55016002)(7696005)(71200400001)(71190400001)(256004)(52536014)(33656002)(6116002)(25786009)(6916009)(6436002)(229853002)(105586002)(14444005)(106356001)(66066001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3360;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YYIkbgm+vr6ADzsgwn+uIVycBRmQ4U2dx8SJXhUBAMmRRM2Iwlb9UZeTvwcXbIioLvn/rHxZqd2rllrO9ryDuEK08MDvt0m8A3EdSEWlWCCg5kBxzUsEqG1WNai1NNYT/JpETQInsFrU6Xg49xE8J+rO3d8M/+hQ3MqkKKfQUsst+xseGFzFZIukRlznCx3xiLOq0xdU5MqqWV9ir7Q5GAlTBwBTnffs7yVM+HHFTvUyPbTdyIbEITj14Vow54uV7zuyGer3ECHlikQRiicjcVFqEpHmKJZG1JhUNGxYN446C3iK1+oMD2n+iOx+sDfw/4ZXv3nDwDqBc3Z4Kw2Cl0XPaKZ+Ns+Gf2RAjRW5cMPvDpVERyVfyc3Y1YAzF7Iwx31ULfVXU3kKdLhCK7lfyjD+Q1G2EweMn6gWQua9Ct4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac4cbf6-13d0-4cff-1719-08d6bda88d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 11:34:54.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3360
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, April 10, 2019 4:01 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: yuehaibing@huawei.com; vigneshr@ti.com; linux-kernel@vger.kernel.org;=
 linux-
> spi@vger.kernel.org; Michal Simek <michals@xilinx.com>; nagasuresh12@gmai=
l.com
> Subject: Re: [LINUX PATCH v2] spi: spi-mem: Fix build error without CONFI=
G_SPI_MEM
>=20
> On Wed, Apr 10, 2019 at 11:14:45AM +0530, Naga Sureshkumar Relli wrote:
> > When building with CONFIG_SPI_MEM is not set gc warns this:
> >
> > drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
> > spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_=
supports_op'
> >
> > Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI
> > controller")
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > Signed-off-by: Naga Sureshkumar Relli
> > <naga.sureshkumar.relli@xilinx.com>
>=20
> Why is there a signed off by for YueHaibing here?  Did they write the pat=
ch (in which case the
> authorship is incorrect)?
Yes, YueHaibing has wrote this patch.
I will update the Author name.

>=20
> You've also got an extra blank line between the Fixes and the rest of the=
 tags which is unusual
> and might confuse some tools.
Ok I will remove that extra line.

Thanks,
Naga Sureshkumar Relli

