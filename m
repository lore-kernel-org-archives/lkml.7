Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53777C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16380206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C8MHHWHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfDASi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:38:56 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:6670 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbfDASiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:38:54 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca25ab90000>; Tue, 02 Apr 2019 02:38:49 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 01 Apr 2019 11:38:49 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 01 Apr 2019 11:38:49 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Apr
 2019 18:38:48 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.52) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 1 Apr 2019 18:38:48 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3288.namprd12.prod.outlook.com (20.179.93.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 18:38:45 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 18:38:45 +0000
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
Subject: RE: [PATCH V1 04/26] spi: tegra114: use packed mode for 32 bits per
 word
Thread-Topic: [PATCH V1 04/26] spi: tegra114: use packed mode for 32 bits per
 word
Thread-Index: AQHU5GH4krq+WJC5Ek2kxSzyLNt/MaYm8zCAgAC38LA=
Date:   Mon, 1 Apr 2019 18:38:45 +0000
Message-ID: <BYAPR12MB33985144F175FB9D01DA5E12C2550@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-4-git-send-email-skomatineni@nvidia.com>
 <20190401073903.GI2059@sirena.org.uk>
In-Reply-To: <20190401073903.GI2059@sirena.org.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3168bedb-5e07-4456-d7b8-08d6b6d145ae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB3288;
x-ms-traffictypediagnostic: BYAPR12MB3288:
x-microsoft-antispam-prvs: <BYAPR12MB3288F1DE19F325F5A40BDCD9C2550@BYAPR12MB3288.namprd12.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(366004)(189003)(199004)(6506007)(256004)(76176011)(102836004)(9686003)(6916009)(99286004)(53936002)(5660300002)(8676002)(6246003)(68736007)(81166006)(305945005)(476003)(6116002)(2906002)(26005)(186003)(478600001)(229853002)(486006)(4326008)(86362001)(11346002)(6436002)(446003)(7696005)(74316002)(25786009)(71190400001)(3846002)(33656002)(14454004)(8936002)(66066001)(105586002)(55016002)(52536014)(106356001)(4744005)(316002)(97736004)(81156014)(71200400001)(7736002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3288;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aY1BF/WhplMXn8w3X/D4WetuRvUyysDquUBqgu/y9sVSbaZGsjQrvrNY70lGdmSup7/K29l/MSNbU6RhVupBKi4ah98idPf1FSbFNFnn+FoqJdA3M2wA3ZrlFgjoBqhhXpKkAiMWKKlznN4FbX0ApNrneevuUDBTCnhCI+7C3hsueitczKdDyds0TicIIvpNKJJbAkhjjcXUTxDcyZp0aG/2/7jUYxrFbUb4Hoqy56VOFfFe66jOyfSdPxmvxtWDVIXbzN7MeOhPG4O3WCKoBo9E1T7bPRf/q0xxTU1UjOyoezfTAQ59qrHBorNgV/jm8OEmMLKap9xE2NP8shT361znR5Qcfj4+PktE7iatNVaoqw/1JGVZGrRj0tek4xbbvniLpg0bjqGPBiEDwC/GD6haOhSGUSCOhL0gB3c1ydA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3168bedb-5e07-4456-d7b8-08d6b6d145ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:38:45.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3288
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554143929; bh=o8kvv1yVeS+GJOIzqG1nALdAT+ZtCSLgAp77EZxpJZw=;
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
        b=C8MHHWHFMw0D6HDEHAKF2kpmQrNJCycSO/0Fn+G/LduDSizqqY9l9ObPvI7XSoUSX
         hn3gyKX9P8bb1w6Me3vMsmyAhz3D7+zyxXGNMvV+3MFU2F1zl0evXonOQrnZ8x8HpK
         9P9COWmHgjkkTN88HtwEgZ48WE8FUCQrO6DsyWOWtmlZzvxXwlBX6AOrk7ixXSpbfv
         XlKShYvJei07ahDY6TuMjktxKSLceCRzU4mj0hGy/9UuQoa9cBdH0Ioy266/5fe8sX
         UxowN6zeTrJzppEY9qcdvp5Cu5fOFZ1fPtzh7wfwrnlXM9z35/ZF3Zzx/Dm8o9ZKzW
         5jfAa5nUAVUWg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Mar 26, 2019 at 10:56:25PM -0700, Sowjanya Komatineni wrote:
> > Fixes: Use packed mode for 32 bits per word transfers to increase=20
> > performance as each packet is a full 32-bit word.
>
> This is an optimization rather than a bug fix, ideally it should be later=
 in the series to make things easier to apply as fixes for Linus.
>
> Also the way you're writing your commit logs with "Fixes: " at the start =
is really weird and conflicts a bit with the Fixes: tag that the kernel use=
s to reference the commit that introduces bugs.

Thanks Mark. Misunderstood use of Fixes tag.
Will remove Fixes tag in commit message in next version as fixes are not re=
ally for specific existing commit.
