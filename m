Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11178C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 04:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A4D206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 04:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rAOUxsw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfHAErU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 00:47:20 -0400
Received: from mail-eopbgr780084.outbound.protection.outlook.com ([40.107.78.84]:15098
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfHAErT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 00:47:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMuRDy2hBLAo+ofi1/Uxzwj+2Y9ldpxZFPf+JPNRvN2lxHNqMOQFY7jJuLMYhcvLuIUT261TY7bZQEywNh1MXzX5Ag7rVt3FK8Gc2vVONBQJBgkob4+e7NCw4tnNI/TpPrSucyNxB06kBLAv8ThM6Qth0rTvgO2wxLy8zhr1yRgvWueGWCy47gBdEYQOiGYK+EaMyVACfIJhhg1IDYVFvGN4BQG6BHWnJEa8o8MRPaYq2Wa+VRWsfuCds9cWNCuVI3nMXOnzwCBn+wyeeu4Rlge7oWc7hOREQllJ85KWCjFduyRx/T8yeWXctQxKPAsp6yopF9eZ9KcbSU6mfxPgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxKCiTbq4j+Vc1KBIMgWsXKYB0NIwhbDnocE3z+B2H8=;
 b=NWq+GI0mKGB7Mzm9edn/CpmGFoNpTNb8iaQB3Xa2/S3WjtwKTh1Uu4hIFLuCe/9RD9CFgYhNyx3CGZAdoEnr/yPOek2HlqG4BgQhHAzyG6EBiPKOzZZJkJG54aNziVjar51c6KeS/yq4W1cZxv6Me55HILxZb4mbgTpMk4MqWSp4pGTUT7CB+Tu+N3yAqgRPkuv4ev++m4uhOZeeK33dU9LDVbuAklRqbW2KFlFnKxzdGMMLt6dAn00XJ8J0dpPv/L146vxF+NGctfqSomnMERj+EtrMhUwgKnaNgdEFbOE1iZqQys4N3GA7MbQ58bFGD4C7UXT6Z1hQwQdG/4KjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=xilinx.com;dmarc=pass action=none
 header.from=xilinx.com;dkim=pass header.d=xilinx.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxKCiTbq4j+Vc1KBIMgWsXKYB0NIwhbDnocE3z+B2H8=;
 b=rAOUxsw1Tip4jPQiLZ/Dw1li2KvNflfbqQ9fxxLyt3Gp7inJIWLlNExV7iEJZT0JT9SBHqEa5dY4ENrBGiRoAeAUbXJbFMZx/W8k04y/z/veOzX2OkVCmS/nG6bZY/MRRNAQ+oZfMUyM4RsTIHhg0ll3kIlhtcpWtzNvpRq3emo=
Received: from MN2PR02MB5727.namprd02.prod.outlook.com (20.179.85.153) by
 MN2PR02MB7102.namprd02.prod.outlook.com (20.180.27.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Thu, 1 Aug 2019 04:47:13 +0000
Received: from MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::3873:a3ea:1f66:fc89]) by MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::3873:a3ea:1f66:fc89%7]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 04:47:13 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Topic: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Index: AQHVR4AuPtwOhxyzBUKoXu06OueqLabkpU9AgAAFXgCAAQ6NsA==
Date:   Thu, 1 Aug 2019 04:47:12 +0000
Message-ID: <MN2PR02MB5727F1EB06E3363E8978BEB6AFDE0@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
        <20190731091145.27374-6-tudor.ambarus@microchip.com>
        <MN2PR02MB5727FF8617B1A2FC89739601AFDF0@MN2PR02MB5727.namprd02.prod.outlook.com>
 <20190731143822.79fa7c82@collabora.com>
In-Reply-To: <20190731143822.79fa7c82@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 256e44c3-e3e6-40b0-ef49-08d7163b5209
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR02MB7102;
x-ms-traffictypediagnostic: MN2PR02MB7102:
x-microsoft-antispam-prvs: <MN2PR02MB71027DA95B4D488D3B2F97CCAFDE0@MN2PR02MB7102.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(13464003)(51914003)(189003)(199004)(26005)(33656002)(66066001)(6246003)(52536014)(54906003)(316002)(6436002)(229853002)(8676002)(71190400001)(71200400001)(186003)(53936002)(102836004)(81156014)(4744005)(6916009)(7696005)(305945005)(99286004)(256004)(8936002)(7736002)(81166006)(5660300002)(76176011)(6116002)(3846002)(476003)(66946007)(14444005)(2906002)(446003)(9686003)(55016002)(4326008)(74316002)(14454004)(11346002)(478600001)(7416002)(68736007)(53546011)(6506007)(486006)(25786009)(86362001)(64756008)(66556008)(76116006)(66476007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB7102;H:MN2PR02MB5727.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b6RO5zC6C2ycFOoTydBNWmRgBuykmuEJ7copsyKaoB4QsqCVKr2L0dByL7CBMonChSaK4Zuo5PWl5YjxHlmLwid5lRCINw9qOML0VK9tYiXDg2wpY1N+RNVJosLvSdNtTond2N51tiNaC7e2mGnDGBd9CRtH0PTUIcKmQe5oYrLLz0geClXWTUA+/Scl4JaxRxAZgruYZ+fwOenRMGK0/ZPPbul33vxn3KxW1JdcDM1gxyNyHoDtvM+/YeFWeNO3iPu9LgORHNbOroqeBP653dd0sBQUlA9BGA4M0qjjaK/9o879+BbuOmHoHXfrlHkU+ukv6/Bgs+6Gl3gmoB9HZDCYnOdjJaBRzQRS65P58i8THRMWur0pA/U7Iav9isX3A8ZNGQ7WheZzf6SWsq1kCUU78V4sBaF700CzsAzxFAM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256e44c3-e3e6-40b0-ef49-08d7163b5209
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 04:47:13.0079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Sent: Wednesday, July 31, 2019 6:08 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: Tudor.Ambarus@microchip.com; marek.vasut@gmail.com; vigneshr@ti.com;
> richard@nod.at; linux-kernel@vger.kernel.org; linux-mtd@lists.infradead.o=
rg;
> miquel.raynal@bootlin.com; computersforpeace@gmail.com; dwmw2@infradead.o=
rg
> Subject: Re: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
>=20
> On Wed, 31 Jul 2019 12:31:19 +0000
> Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
>=20
> > Hi Tudor,
> >
> > Thanks for the updates. With these kind of updates, we can add Vendor
> > specific Code easily, like Xilinx Dual parallel and stacked modes.
> > In these configurations we need to tweak the nor parameters like page_s=
ize, sectors etc.
> > So with the help of these patches. we can easily update these parameter=
s.
>=20
> Absolutely not. This is just a solution to recover from broken SFDP table=
s.
Ok.

Thanks,
Naga Sureshkumar Relli
