Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA3F206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="c8oliPbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfDASko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:40:44 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:3555 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfDASkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:40:43 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca25b280000>; Tue, 02 Apr 2019 02:40:40 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 01 Apr 2019 11:40:40 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 01 Apr 2019 11:40:40 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Apr
 2019 18:40:39 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.59) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 1 Apr 2019 18:40:39 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Mon, 1 Apr 2019 18:40:37 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 18:40:36 +0000
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
Subject: RE: [PATCH V1 18/26] spi: tegra114: add support for hw based cs
Thread-Topic: [PATCH V1 18/26] spi: tegra114: add support for hw based cs
Thread-Index: AQHU5GIKKpTkIfSTtEWeqLFxMgMCeKYm9fSAgAC1kqA=
Date:   Mon, 1 Apr 2019 18:40:36 +0000
Message-ID: <BYAPR12MB339817E7F593A70D3F9D3D7AC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-18-git-send-email-skomatineni@nvidia.com>
 <20190401074857.GK2059@sirena.org.uk>
In-Reply-To: <20190401074857.GK2059@sirena.org.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d3ea233-67ee-437e-cb6a-08d6b6d18842
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR12MB2710;
x-ms-traffictypediagnostic: BYAPR12MB2710:
x-microsoft-antispam-prvs: <BYAPR12MB2710D13A46098A82704D6478C2550@BYAPR12MB2710.namprd12.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(54906003)(68736007)(186003)(26005)(316002)(86362001)(81166006)(76176011)(81156014)(5660300002)(8936002)(8676002)(55016002)(9686003)(52536014)(53936002)(99286004)(102836004)(6506007)(6246003)(105586002)(106356001)(7696005)(6116002)(33656002)(3846002)(478600001)(71200400001)(71190400001)(74316002)(6916009)(14454004)(14444005)(256004)(66066001)(25786009)(97736004)(2906002)(11346002)(476003)(7736002)(446003)(229853002)(305945005)(486006)(6436002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2710;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QKE47HGPy8nxDKWn2VCkynRtSEhWgyXWjdnWf70d5BkPi2wQkvhQCFoeJj2C00IXnvgTLa2nbJ+PXzKDap7DAM1oGuUAJ08ojVGbyz9pxYbB9n8sk9n3UKIeBxifKykNupF6zHtDS35XMmt/s1l0rf7HrDRBHjpE2yKr//eG4ibU3rFODmZjG/JpSeoMaFcoKOG8lsKp6d2j0bSSRi4/gDJ9uULtd1i5ef9Hf+jA32gQ+sYMpWE6spot6nz/w9lR25irFI03Sl+7cF0cF/HPTn6JApVovbm2PsaMHPS0tCgkAgcmum4ZyhQ2Y5IMVotiFEBQZKaqfVduFJIWV9n+GfrkL+v0QX6s9hQGZ5iaBWgMqMX15HXB8iJbtnx9DHzCQV3sTV1X8QiDkJjmdnqlPZ7tvyshm1wvq05Nt3flvRc=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3ea233-67ee-437e-cb6a-08d6b6d18842
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:40:36.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2710
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554144040; bh=TffHUIiyqlo13jA/W9t1Vw9GzK6ChcvvJJxr5fjySn0=;
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
        b=c8oliPbXxpGuuBh7oomw4wdhrl+Y0bdku+3UmFmvw6bGcEcPwcQhTJxMO70DZcfH2
         rjK+l+nAs0iknE/4ME3MzIaMQleDiRUNokluICTt0QNAYHbP3yTnujik5SoGZdwmb2
         wnE57veMum/X3B8U8VQJ3AY48griyt+VTyicNthB859frXJbM/sF/rn3nSfA00DESN
         vd3OQMVYAjsYvf1dgkZIvtFJLjKxI5SXWibHl05KKVutXSFeFO0fjyYhwGY7Zlzx7f
         TWx5MBvoVDLy2TbutqCELwkC2EpbFDl+b8tiWV5kRbyk86fVr5QLmM4sMsSn3P9Nod
         Uk8SKmlEgSXRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 26, 2019 at 10:56:39PM -0700, Sowjanya Komatineni wrote:
>=20
> > Tegra SPI driver default uses SW CS control for transfers and HW CS=20
> > control can be enabled through SPI client device node DT property=20
> > nvidia,enable-hw-based-cs and is used only for single transfers.
>
> Why have a property - if this feature works and is useful why would a sys=
tem ever not want to use it?

> > +	single_xfer =3D list_is_singular(&msg->transfers);
> >  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> >  		u32 cmd1;
> > =20
> >  		reinit_completion(&tspi->xfer_completion);
> > =20
> > -		cmd1 =3D tegra_spi_setup_transfer_one(spi, xfer, is_first_msg);
> > +		cmd1 =3D tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
> > +						    single_xfer);
>
> It's not sufficient to check if there's only one transfer, you also need =
to make sure that the driver isn't using cs_change to use non-standard chip=
 select handling.

Yes we can avoid DT and force to use HW CS incase of all single transfers w=
ithout cs_change. Will update in next version.
