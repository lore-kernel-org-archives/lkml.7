Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867E0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431AC206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="F1vjj5pG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfLLI5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:57:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:19995 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfLLI5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:57:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 00:53:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,305,1571727600"; 
   d="scan'208";a="216043247"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2019 00:53:18 -0800
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Dec 2019 00:53:18 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Dec 2019 00:53:18 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 12 Dec 2019 00:53:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwNf+wau7cccKV6NMmtokU6DLROGsXIHSOKqv2C6WAQbmNnegfUL8JtHkNVPkOadUlYxEm/qRBvMU5egOFD+ibG16H3RlGtr82vlWQTQLrhZ+ZQ5okP4jf8aQK+ZJS2iMt2vDvjbNEhb3abAJUq09Ot1SBHpHz7tqhsuArmysBl0NRpIpzQsNn2L3AVWmM0X5fLyfNfL6sxAParvtJyDrcgjEyoxwZy/COQ9g/1i+Nt1jH0zhq6laUylOZNzgct/0Y52fJYpqaby3x+To8S9qavr+830144TNSzrgWdrWq/474BSomJ5IV2cAnZdrnZnBI81GFV6bEaTkimdC2ZpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8MJPOIpaxlfI3TxZ9rdU8Co+4nWl8wE8T+c/NWMX1Y=;
 b=LRG7d8xKVQaTEVD2hRVqlXun08DJ9eifa66HTKG6Y7L43sr3g0r7JbIEYU9v4yJMIdWY494k4pAvCScDWkpT5KfsIwO4yvx0ZXu+4IKdDwSDq525oHmwnStxm6QTwHvjWYcOLA0XEH5mWn5TB74Y6aRNg33CXzMVdLDwfJh2bCReHom2hwy8YGekEDHfyFV0RR9aSXnwdbBdQkT5oJDXCj8PjbT/psoM2LlOfABILNmEmNEj1dBEhcPrkW5EFj8i9i7Oi/iSRY0EB3MXyhhkVSM4zP9p2bPe1Qjk+VzaO5HPphVHbxPUyOUYMli8hTOg/Ecja6hr5XHdQ291MheRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8MJPOIpaxlfI3TxZ9rdU8Co+4nWl8wE8T+c/NWMX1Y=;
 b=F1vjj5pGVMufSOaUNXaeVOe72qk+hd03BwfA3CA7SF75ypgCsHHWUI/b2bqYnKIaRLuuXwllzXwSsMtLOddz0heyWeEvXosOEtfSm/OylGkhZa429M+BFfKcL7NlHWSVYN4cbhtTvx7W8DIQZP7v9P2k7AF4vDQ5TQKbOfRYZFo=
Received: from MN2PR11MB4509.namprd11.prod.outlook.com (52.135.39.90) by
 MN2PR11MB3679.namprd11.prod.outlook.com (20.178.252.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 08:53:16 +0000
Received: from MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::bd81:f020:90e3:a12d]) by MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::bd81:f020:90e3:a12d%7]) with mapi id 15.20.2538.016; Thu, 12 Dec 2019
 08:53:16 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>, Ley Foon Tan <lftan@altera.com>
CC:     "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
Subject: RE: [PATCH] nios2: Fix ioremap
Thread-Topic: [PATCH] nios2: Fix ioremap
Thread-Index: AQHVqxWN5Yfa/Wds60a5c3Xujj9FsKe2PLNQ
Date:   Thu, 12 Dec 2019 08:53:16 +0000
Message-ID: <MN2PR11MB45099E938133B381D57EFEBCCC550@MN2PR11MB4509.namprd11.prod.outlook.com>
References: <20191205024100.1066-1-linux@roeck-us.net>
In-Reply-To: <20191205024100.1066-1-linux@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTBlZjU2YjItZWJmZS00MGY2LTkwMzItNzBiOGUyOWE2NGI1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTGVJcmE3YjFSSXJ0eDlzNmNGd1NCREdUWkV4ajVpdXVYZlwvSGJoZkJVaklTXC9GV08rajN1NVpWMjk4S3paVm03In0=
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ley.foon.tan@intel.com; 
x-originating-ip: [192.198.147.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 785c055d-5c3f-4666-1f55-08d77ee0bacb
x-ms-traffictypediagnostic: MN2PR11MB3679:
x-microsoft-antispam-prvs: <MN2PR11MB3679035B35566CB5A556C393CC550@MN2PR11MB3679.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(13464003)(55016002)(8936002)(9686003)(54906003)(86362001)(110136005)(186003)(4326008)(2906002)(71200400001)(33656002)(26005)(6506007)(53546011)(7696005)(4744005)(76116006)(52536014)(66476007)(498600001)(8676002)(66446008)(5660300002)(81156014)(81166006)(64756008)(66556008)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB3679;H:MN2PR11MB4509.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TlWx8znXFx2eVxmFO3n5g53FIDxw/w8LIV7sBZVEFQ2xgvgpm0q9IxakifHoNz51I0Kf3tlXw+hnTcopZBy1wrCVaWVmcPwFK+3V4oE/YEFS+JsgXIikpDFTU3nXBRAWCq8iviH4Vc46DIbG21xJlyMVMUVrQJEop8Pg44JNMU8NDKk+NQrKQO36cKoXqHdhk0iig7RsS15wHdEM50j9M65many83C6dOBpXdcLIQ9QsyTXN6zgG6jACNkbwGIK5KcK4YsvSQu/CqDy2du3wIdw3lWkRdYNTv4QnYIzuDI+Jq5vdpUyWlcLdQF0lEU0fm4C8FCdCHmuOIXVbqr0GJrfDgdoADqSwh9MXT7H3amKFtbqyyEVhWE8hX4ZWD80gbJS2QXJN9LZUqCd2rOff7uvf8kxy5yZcoE98/aMp/5rIRt46DZo+9RU7Mcz99xR3yszvmxevzxeGWlfa8v4XfHnZXTlbz6IBBZkUvpO7iBfa/KBT+4Xe/LljfsdN8AGC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 785c055d-5c3f-4666-1f55-08d77ee0bacb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 08:53:16.6483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUVVqwPJQ9CePNfdDxNbgjPNkDJbYRK31JJLtKurGTvUlP0OO/aARfuBOw+cSOM0TdKvxGhVfvhKHnwHY98OKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3679
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Thursday, December 5, 2019 10:41 AM
> To: Ley Foon Tan <lftan@altera.com>
> Cc: nios2-dev@lists.rocketboards.org; linux-kernel@vger.kernel.org;
> Guenter Roeck <linux@roeck-us.net>; Christoph Hellwig <hch@lst.de>
> Subject: [PATCH] nios2: Fix ioremap
>=20
> Commit 5ace77e0b41a ("nios2: remove __ioremap") removed the following
> code, with the argument that cacheflag is always 0 and the expression wou=
ld
> therefore always be false.
>=20
>         if (IS_MAPPABLE_UNCACHEABLE(phys_addr) &&
>             IS_MAPPABLE_UNCACHEABLE(last_addr) &&
>             !(cacheflag & _PAGE_CACHED))
>                 return (void __iomem *)(CONFIG_NIOS2_IO_REGION_BASE +
> phys_addr);
>=20
> This did not take the "!" in the expression into account. Result is that
> nios2 images no longer boot. Restoring the removed code fixes the problem=
.
>=20
> Fixes: 5ace77e0b41a ("nios2: remove __ioremap")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Will add to next rc.=20
Thanks.

Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
