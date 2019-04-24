Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E4CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E79B2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="a8i7kH65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfDXLWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:22:04 -0400
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:17576
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbfDXLWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw5+bw4uWxfWLn5eG4UmPeB9BZYXryNZPtJP374T5Zw=;
 b=a8i7kH65bVMIb0HOaACo2oAgOcjbxS1/f/U1EaIkrR4eQ+XqcgtqONfANlj45Qpa0l2ppz3HNlYV9g/7bKDQN7kjXXvXwdbO0hspX1I5i7ZXkb7LTvs9ksTBS4w0fuYdiixnYDAY1QHRZM+2iceKmH6QNjjRjEWV3M36nWKKSBU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5646.eurprd05.prod.outlook.com (20.178.120.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Wed, 24 Apr 2019 11:21:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 11:21:59 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Daniel Drake <drake@endlessm.com>
CC:     "imre.deak@intel.com" <imre.deak@intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: sg_dma_page_iter offset & length considerations
Thread-Topic: sg_dma_page_iter offset & length considerations
Thread-Index: AQHU+m58TPZAEQBwAECtJT1gvanjKKZLKviA
Date:   Wed, 24 Apr 2019 11:21:59 +0000
Message-ID: <20190424112153.GB16077@mellanox.com>
References: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
In-Reply-To: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a95c910-7088-4af2-687e-08d6c8a710dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5646;
x-ms-traffictypediagnostic: VI1PR05MB5646:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB56463F6E5F14AF00DAD3E01ECF3C0@VI1PR05MB5646.eurprd05.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(39860400002)(396003)(199004)(189003)(43544003)(81166006)(1076003)(2616005)(966005)(6916009)(66446008)(86362001)(6436002)(8676002)(64756008)(66556008)(14454004)(2906002)(33656002)(102836004)(186003)(6506007)(386003)(26005)(71200400001)(5660300002)(478600001)(8936002)(73956011)(66946007)(66476007)(81156014)(66066001)(229853002)(71190400001)(25786009)(316002)(54906003)(256004)(6486002)(99286004)(6116002)(476003)(7736002)(486006)(76176011)(3846002)(6246003)(97736004)(305945005)(446003)(11346002)(53936002)(6306002)(68736007)(52116002)(4326008)(6512007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5646;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SHuqpr1nLBHsM6CWbMX1A0dt1TPCoYqmxzXRTTKuEDoK+BklsecUEhtggqAykHhWDsiKjJ8M9vfFcM7LZy1Xm14l3Gk22/+Prkr+qpI9RgWgHpcKbeYK50lxaqhFm49EWHu+bERzpgwRD/L3CUNQ75uQ8WtwJXSRZrJDoUXWiZaoiyve4hp/qogsuTdUZoY8RN/CJlMDCxjk4vNHRlIjvdhYdYJzkCNQfTU+hSHBsxyQ4oDIM576FTJ/aYETR7jT11gXKy8LDn1HEch0BzNipPQmyf8M8Htrob2mHx0VPsWXdMM3OXZO/6sV4dCFaYH9FsacvErm08ikrCRuPL1JgiupwI4MXVng0rClsehwpIJEekUZ0hXn2Xgq+yAfxeyDLVlhHhp2EiwBjemD3EK0ho4KZJS1jHmvnxbc7ZafUkM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47B74799A8FD6B4B8FA5AB4B76B8868C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a95c910-7088-4af2-687e-08d6c8a710dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 11:21:59.4862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5646
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:22:18PM +0800, Daniel Drake wrote:
> Hi,
>=20
> In drivers/mmc/alcor.c we're working with a MMC controller which
> supports DMA transfers split up into page-sized chunks.

Keep in mind that sg_page_iter_page splits into PAGE_SIZE chuncks, so
if you HW needs exactly a 4k chunk or something then it is not the
right API.

I have in mind the idea to move this code:

https://patchwork.kernel.org/patch/10909379/

Into the global scatterlist someday if there are other users in the
tree that need arbitary splitting..

> Specifically I can see userspace generates requests which present a
> sglist such as:
>  - first entry with offset=3D1536 length=3D2560
>  - 7 entries with offset=3D0 length=3D4096
>  - last entry with offset=3D0 length=3D1536
>=20
> I gather that dma_map_sg() will take care off the offsets, i.e. any
> physical address I get with sg_page_iter_dma_address() will already
> have the offset applied, so I don't have to worry about tracking that.

Well the DMA iter aligns everything to pages so all the offsets are
lost.

> But what about the length? For every page returned by the iterator, I
> can't assume that I am being asked to work with the full page,
> right?

So far no user has required the length/offset, but it would be easy
enough to make a function to calculate these values for the current
step.

This is because this API is used by drivers building page lists for
HW, and they usually have additional information outside the SGL that
indicates what the start/end offsets are.

A driver that simply wants a SGL with a capped max size (ie 4k?)
should use the dma_set_max_seg_size() API and just never get a SGE
with a larger length.=20

But the SGE may still cross a page boundary..

Jason
