Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA7CC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52619208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qiyGh73t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfD0AdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 20:33:21 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:32496 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfD0AdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 20:33:21 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc3a34c0000>; Sat, 27 Apr 2019 08:33:16 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 17:33:16 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 26 Apr 2019 17:33:16 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 27 Apr
 2019 00:33:15 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.56) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 27 Apr 2019 00:33:15 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3080.namprd12.prod.outlook.com (20.178.54.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sat, 27 Apr 2019 00:32:58 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::a426:a072:b48b:530c]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::a426:a072:b48b:530c%5]) with mapi id 15.20.1835.010; Sat, 27 Apr 2019
 00:32:58 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 3/9] spi: add SPI_LSBYTE_FIRST mode
Thread-Topic: [PATCH V3 3/9] spi: add SPI_LSBYTE_FIRST mode
Thread-Index: AQHU89KBhHDIG9CWN0enZX6jwt4riaZDn6gAgAuZfqA=
Date:   Sat, 27 Apr 2019 00:32:58 +0000
Message-ID: <BYAPR12MB33989D8DCEFCDE5DB76429E7C23F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-4-git-send-email-skomatineni@nvidia.com>
 <20190419152208.GT2803@sirena.org.uk>
In-Reply-To: <20190419152208.GT2803@sirena.org.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9af43e16-dc99-4643-14c2-08d6caa7e628
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR12MB3080;
x-ms-traffictypediagnostic: BYAPR12MB3080:
x-microsoft-antispam-prvs: <BYAPR12MB308078CE664108ACBFBB193BC23F0@BYAPR12MB3080.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0020414413
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(366004)(396003)(376002)(136003)(189003)(199004)(53936002)(55016002)(25786009)(256004)(6246003)(66476007)(73956011)(305945005)(316002)(9686003)(33656002)(66556008)(99286004)(52536014)(486006)(476003)(6916009)(54906003)(446003)(4326008)(66946007)(74316002)(5660300002)(11346002)(3846002)(102836004)(64756008)(76116006)(14454004)(81156014)(6116002)(68736007)(7736002)(86362001)(66446008)(8676002)(8936002)(81166006)(4744005)(229853002)(14444005)(97736004)(26005)(2906002)(71200400001)(6506007)(478600001)(76176011)(71190400001)(7696005)(66066001)(6436002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3080;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5V1TSIy5zcxlkWw/mCyqvOrEqzlUMiWxcvQmMinSiuebhlrPrwdBHZBTxXWEdubbXTOyI+m54/Vom++kzlOX1vMNkVVvbLqjm6hj53LbcXpdXEq5fAmevpavTk3BynW/n0f4bgncx0ffr2ZcZ91atH9AorImUoB532lmPyYjkZWI+m20VXcmc7WBc1bH+iYdKh3Ri+IYUDIN3Joh0U3JdD6qxI1h0a1VMEzoFxvF1Wdb6deb/sV3NTQLG46kbk/PEGZpWV6LPK+XF3UHM1orsVqVay+Dq2ASk3DVRhMLNVvlnWE31XYEBnelXSxgBWre9fs6m4MRsVuoZ5LVLCsTAG6jDJWGPN8CXp16sc8F0WekaqkO8jx1wXvDe3uyBH1brlRlmCSIgF2//sGL0m3mChUGvyoF/M67Qjm39EkG9HU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af43e16-dc99-4643-14c2-08d6caa7e628
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2019 00:32:58.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3080
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556325196; bh=/PAyj9SIETjbz9hVdHMTT1eE1nSnM/5TvhGH3D3UcUM=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=qiyGh73tQTeIclBhXE0vz7Mvt5yG6nbaV7ej1HsQBj1KfSvjZfPlZ2pfaslfRgsdD
         e6cB/NsJ/IaD3n8DMcNoXYzeWhGP8zUn3oC7SPwHQHw6ByjQO/JH0UVj3FOpBvRm66
         vmx9c8ca0HPRpuozuVGHvTa+E3oSSG97oCQlaY05x4J9LCVWm+PaKSMQT0NvNDMBb0
         9uSJRMqO9MuJClVadz1aivv9zWRKhPrI21k/I7Yz1zWUjXYLVElBA8oPG5K448doXA
         ESve6VlE2ab8l0Os/JmgLpb5ooTl4hOiyzu+vAntDeOp1MUDbDA4ziXxew+X+/n07s
         cAF1alhZ9K9JA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Apr 15, 2019 at 02:30:28PM -0700, Sowjanya Komatineni wrote:
> > Some SPI slaves expect bytes to be in least significant first order=20
> > and some expects most significant first oder.
> >=20
> > This patch adds support for requesting SPI master controllers for=20
> > least significant first order using SPI_LSBYTE_FIRST mode.
>
> This is byte ordering as opposed to bit ordering which the core already s=
upports.  Do you have any examples of devices that need this or is it just =
being added for completeness?  If devices are going to rely on this we prob=
ably need emulation > support in the core I guess given that this is a pret=
ty unusual controller feature.

Current upstream platforms have no specific device requirement but added th=
is feature as Tegra support it for specific requirements of some slaves.

[Changed mail client message format word wrap limit to 74 columns]

Thanks
Sowjanya
