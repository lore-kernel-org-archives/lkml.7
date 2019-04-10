Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF16C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F34A2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4bol1OLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfDJMas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:30:48 -0400
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:24654
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728881AbfDJMas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybV0TLfP2CxtALB4yZqua1Z6zyoDIMTG9enZZUnqViI=;
 b=4bol1OLw28pAEtEp9TQ7X+nW7k6SaozODAmrcHYMQHBmClMwpgevon7YcyW155gYYFio8oUF7J91c25S/Ym9IZSNUjpiDq8GJBy0B1ApQzLAuruXJOzF/umwrMK6vpL9sfj5j96Yq3fKMfDc2AVVlEfO3sAloBPRxi7VyiRFRpg=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2606.namprd02.prod.outlook.com (10.168.205.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.16; Wed, 10 Apr 2019 12:30:38 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e%6]) with mapi id 15.20.1792.016; Wed, 10 Apr 2019
 12:30:38 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Mark Brown <broonie@kernel.org>, YueHaibing <yuehaibing@huawei.com>
CC:     "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: RE: [LINUX PATCH v3] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Thread-Topic: [LINUX PATCH v3] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Thread-Index: AQHU75SYRghFoYZe90G0/RFUWfhl5KY1UPeAgAAAsYCAAADgoA==
Date:   Wed, 10 Apr 2019 12:30:37 +0000
Message-ID: <MWHPR02MB262352F3C89EB163AB1EC2B5AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1554897429-5959-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <2d9cee19-a776-ad18-b8ac-6d0d1b096ad6@huawei.com>
 <20190410122457.GP6106@sirena.org.uk>
In-Reply-To: <20190410122457.GP6106@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ae293f6-3bfe-4cff-015a-08d6bdb05670
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MWHPR02MB2606;
x-ms-traffictypediagnostic: MWHPR02MB2606:
x-microsoft-antispam-prvs: <MWHPR02MB2606EB23F481A5EC1D0C1C56AF2E0@MWHPR02MB2606.namprd02.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(13464003)(199004)(189003)(446003)(11346002)(8936002)(74316002)(97736004)(305945005)(476003)(9686003)(105586002)(33656002)(54906003)(106356001)(316002)(110136005)(99286004)(68736007)(55016002)(4326008)(102836004)(76176011)(53546011)(6506007)(6246003)(7736002)(81166006)(186003)(53936002)(7696005)(26005)(478600001)(81156014)(8676002)(256004)(25786009)(71190400001)(71200400001)(229853002)(2906002)(52536014)(5660300002)(86362001)(3846002)(6116002)(66066001)(486006)(14454004)(4744005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2606;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KgB+VY2FC80vwawJRdAaKRMR2x3A+CXTiclgsoPRvWjWmxAafis364x7g8vy1RGyYMav/JrVTUBd9AkV57FHvppI9ferdnYSwSsrXQseKsJ5Ww0Ubvk/tZ5dpuimYuQRMYSVCYgkUV9t1ClX/GMENeFyo8FJo9g4OaUVTWbvP+2PiqFI/qKwqE8WirmKuDLxdyZg+5AkWZWWvOcDhC3pUutVUMypBugxo943aSIAXfwyKgJfdWnY5HFn7LeAlT2G7HkC/vZf9N68tXc0RjoSuPDryyOMUp/J3H7uOIQt0qGPfbQQmVv1v9WcSdw4vBGheDUrwBsQGBMsGlokwjr8ge6wsEUZN9eWX7CQ3nBfOegQyUY4/CI1a4WESJK0ibEF95Mlrb+Zk2Rfg7nq8eVyWCK1AF96/S9zXktqek1pkFA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae293f6-3bfe-4cff-015a-08d6bdb05670
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 12:30:37.9817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: linux-spi-owner@vger.kernel.org <linux-spi-owner@vger.kernel.org> O=
n Behalf Of
> Mark Brown
> Sent: Wednesday, April 10, 2019 5:55 PM
> To: YueHaibing <yuehaibing@huawei.com>
> Cc: Naga Sureshkumar Relli <nagasure@xilinx.com>; vigneshr@ti.com; linux-
> kernel@vger.kernel.org; linux-spi@vger.kernel.org; Michal Simek <michals@=
xilinx.com>;
> nagasuresh12@gmail.com
> Subject: Re: [LINUX PATCH v3] spi: spi-mem: Fix build error without CONFI=
G_SPI_MEM
>=20
> On Wed, Apr 10, 2019 at 08:22:29PM +0800, YueHaibing wrote:
> > On 2019/4/10 19:57, Naga Sureshkumar Relli wrote:
>=20
> > > +static inline bool spi_mem_default_supports_op(struct spi_mem *mem,
> > > +				 const struct spi_mem_op *op);
>=20
> > Here miss a Function body, right?
>=20
> Yeah, I'm surprised that builds...
Sorry, I tested with CONFIG_SPI_MEM enabled. It's my bad.

Regards,
Naga Sureshkumar Relli
