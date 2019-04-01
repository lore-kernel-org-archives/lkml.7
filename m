Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA46C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DBD20663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cx3p+Otv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfDASHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:07:55 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:4256 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbfDASHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:07:52 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca253740001>; Tue, 02 Apr 2019 02:07:48 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 01 Apr 2019 11:07:48 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 01 Apr 2019 11:07:48 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Apr
 2019 18:07:48 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.56) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 1 Apr 2019 18:07:48 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2936.namprd12.prod.outlook.com (20.179.91.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Mon, 1 Apr 2019 18:07:45 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 18:07:45 +0000
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
Subject: RE: [PATCH V1 24/26] spi: tegra114: de-assert CS before SPI mode is
 reset to its default
Thread-Topic: [PATCH V1 24/26] spi: tegra114: de-assert CS before SPI mode is
 reset to its default
Thread-Index: AQHU5GIMZGFJTMMz0U+IEn8v+fuhv6Ym9icAgACrszA=
Date:   Mon, 1 Apr 2019 18:07:45 +0000
Message-ID: <BYAPR12MB33984E9D0FA76FCC77FD72BFC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-24-git-send-email-skomatineni@nvidia.com>
 <20190401074940.GL2059@sirena.org.uk>
In-Reply-To: <20190401074940.GL2059@sirena.org.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61b5bcd0-c3a1-4ae8-efaa-08d6b6ccf100
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB2936;
x-ms-traffictypediagnostic: BYAPR12MB2936:
x-microsoft-antispam-prvs: <BYAPR12MB29369F4472E0FED0AB3C71CDC2550@BYAPR12MB2936.namprd12.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(86362001)(9686003)(256004)(106356001)(8936002)(3846002)(8676002)(14444005)(14454004)(68736007)(81156014)(66066001)(33656002)(105586002)(81166006)(5660300002)(55016002)(74316002)(476003)(446003)(11346002)(97736004)(229853002)(76176011)(6246003)(4744005)(53936002)(486006)(7696005)(305945005)(6436002)(54906003)(6116002)(71200400001)(6916009)(186003)(71190400001)(52536014)(99286004)(6506007)(316002)(26005)(25786009)(4326008)(102836004)(2906002)(478600001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2936;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Thsz406iWRaNfkaxGODi1S/yKTe58JCQAjC6YYrz+7Io3m66D/ZVSvIlZTT4ZaPKVwDxjsNvh6rs3LyPZqLcCRU74I0HJGftBZUuSJJCLZ6ioPikaLVMpCxx8I96nL7wcQymBRbo4HZJbIOx6sHgTJivUJFVnFkW570k3Q+rytT0B2ZuNJ8xgTWEPppxZVXQr7T5Mik8HiY1vKoXGwbxAgM7wIBjCFpa5g1mBv3szHImB1MJUWu90ZaJMYCL/aTJf3M9uiOPBbg0fZ/lTibHNyg7mhrD7if04XXggigbFK/Fjsrq1SXD1TzqVImNn5qgGiKWb1ph+5RQJ3LqnxsthWLjWmsLqeM89pmLuRjLCnvayGJbJ3Wket95uhWi3lFnqFutY6UeD2eiJhfo0vTNEbBNGTciAoq9xZFCSlTSiQ4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b5bcd0-c3a1-4ae8-efaa-08d6b6ccf100
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:07:45.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2936
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554142069; bh=Pq0D7fWixUPci1w8wkc0qr2viJIX9yQXNtw6DTZaSKE=;
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
        b=cx3p+Otv9CbYB8uGMlcUZ189/7NHCQdU2JGY6rBCKL0N3cPB57YdwYtrALczV23sp
         rrGM039uHYocJtLOnjdHTw4PQd4bv642v9UmSfU7iJC26wccFrSlING9hilbIXd+pQ
         pcTTMlpSHAXqU7q4n9csqyEsmKek0oIff2Ugv4IRfO0mAzFbwdo4UPzo/+pqDPGSUV
         hvs0s89T3Xx1/I0zTQwROfiWdMeyg7gjAQIZcbihTftik4bWNM1LTpXWy/39lc/XL+
         U5FFQGKfq+4XrxcmkfDyfs2ZCjqFVLOF0T4fs4wrcSfM81by29U4sO6K1XilG9GEbR
         GXbDpcQbfEyEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Mar 26, 2019 at 10:56:45PM -0700, Sowjanya Komatineni wrote:
> > With SW CS, during transfer completion CS is de-asserted by writing=20
> > the default command1 register value to SPI_COMMAND1 register. With=20
> > this both mode and CS state are set at the same time and if current=20
> > transfer mode is different to default SPI mode and if mode change=20
> > happens prior to CS de-assert, clock polarity can change while CS is=20
> > active before transfer finishes.
>
> This is a bug fix so I'd expect it to be much earlier in the series befor=
e any of the new features.

Thanks Mark. Will change order as per your feedback in next version of patc=
h series.

I see you have applied some patches in V1 series so should I re-send again =
those as well along with feedback changes in next version or just only the =
patches that are not applied.
