Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9368C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A48A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZoulAQK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDKT6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:58:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5721 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKT6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:58:54 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf9c6c0000>; Thu, 11 Apr 2019 12:58:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 12:58:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 11 Apr 2019 12:58:52 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 19:58:52 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.54) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 11 Apr 2019 19:58:52 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3144.namprd12.prod.outlook.com (20.178.55.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Thu, 11 Apr 2019 19:58:34 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::a426:a072:b48b:530c]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::a426:a072:b48b:530c%5]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 19:58:34 +0000
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
Subject: RE: [PATCH V2 11/20] spi: expand mode support and add LSBYTE_FIRST
 mode
Thread-Topic: [PATCH V2 11/20] spi: expand mode support and add LSBYTE_FIRST
 mode
Thread-Index: AQHU60SLS/Y11B/vH0+MqUfhlpfZo6Yx0fqAgAWYVZA=
Date:   Thu, 11 Apr 2019 19:58:33 +0000
Message-ID: <BYAPR12MB3398CC43DC1F78A10BC51DE8C22F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-11-git-send-email-skomatineni@nvidia.com>
 <20190408062819.GJ2803@sirena.org.uk>
In-Reply-To: <20190408062819.GJ2803@sirena.org.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b283bea-9566-44dc-6bd0-08d6beb81426
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR12MB3144;
x-ms-traffictypediagnostic: BYAPR12MB3144:
x-microsoft-antispam-prvs: <BYAPR12MB31443F361CA28AE3317FBC6DC22F0@BYAPR12MB3144.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(54534003)(86362001)(81166006)(71200400001)(486006)(476003)(5660300002)(7696005)(54906003)(446003)(256004)(6916009)(14444005)(97736004)(7736002)(186003)(11346002)(6436002)(102836004)(26005)(74316002)(305945005)(316002)(229853002)(33656002)(3846002)(25786009)(6116002)(2906002)(76176011)(6506007)(99286004)(52536014)(14454004)(9686003)(105586002)(478600001)(6246003)(8676002)(4326008)(68736007)(106356001)(66066001)(53936002)(81156014)(8936002)(55016002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3144;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 43wGRhZ1U4IgrwV8sE+kHqG45PFT4JeTg9tk96re0xW6MIr0LJm++zH5OuE/AgBx6JFzGv448zI1IU+yKwTCjjxFTnYFr0W3c5o0dfQ3MKjfENH9fVnF8aoeYq4u12SJFoRX+tMxJM4n3ut4dw46brTgtwXw9tb2u5YIlullwAtz8JNVXoGCUgiBpoYgzJ7fAILHoB8U0oQ3k+Sdg8uMU/V8ybKM+PcM3kgDQY0p9/71NKc46Bg7tBQ1I/OPbsvCcUiBwjfgY21V17S6kIsNqgekCUsD8F36UpC9xwftH6uCEI58WzKSeTHRfPvd1bF9wU4954iNbujqeUBi/qI3+P9ATvzQ8bbXuovzyanGsWGFVOFz5HsZrYEpTSmAth7WFqE1wm8AIoDjaTewfWD3VvZX9FyVy5FmGUAmtBi1ldU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b283bea-9566-44dc-6bd0-08d6beb81426
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 19:58:33.9455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555012716; bh=yBq8Y2yybM3ObD9yk5/T6ay2KLskrvalVL+9c+QPS3Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=ZoulAQK8TGnX5I70IBlFMjKh2+z5TxEVPye51/31lYuVnG5o2tIu1BYGdBZ0elsr2
         wbHqPGmJOhAC6JWkbkGvRW/CdzndHu6hLI0Cg36EFwDc+6E4P1iUve6p64IL2KpnC7
         IqCI70+H7tKQTYMkR1kmRsZMStZKasMVbcQ/BmHyI8d+DhqcOCfNLGmwzbwmDdTsM7
         mGPxxgnkVD757oHEEA4fNDvjDF0RmbCHcl7jf4KnbapVIxUBzhqBPzuB12uHDRxd10
         qb4j+8wV3DHciKlisX8WzzXCcNYfpKXgTzJEiDAT0x7CHkkGzGFkmxet2iEATs+uRl
         enMn4KSyP9UWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Apr 04, 2019 at 05:14:10PM -0700, Sowjanya Komatineni wrote:
> > Some SPI Master controllers support configuring Least significant byte=
=20
> > first or Most significant byte first order for transfers. Also some=20
> > SPI slave devices expect bytes to be in Least significant first order=20
> > and some devices expect Most significant first order.
> >=20
> > SPI driver declares mode and mode_bits as u16 and all bits are used.
> >=20
> > This patch changes mode and mode_bits to be u32 to allow for more mode=
=20
> > configurations.
> >=20
> > This patch also creates SPI_LSBYTE_FIRST mode to allow SPI clients to=20
> > choose LSByte order or MSByte order through the device tree property=20
> > spi-lsbyte-first.
>
> Please submit one patch per change, each with a clear changelog, as cover=
ed in SubmittingPatches.  This makes it much easier to review things since =
it's easier to tell if the patch does what it was intended to do and means =
that if one part of the patch casues problems it won't hold up the other pa=
rts.

Hi Mark,
I split changes on SPI code side and SPI Tegra side as separate patches.
Do you meant to have both changes on SPI core and SPI Tegra together in a s=
ingle patch?

Thanks
Sowjanya
