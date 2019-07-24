Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB8AC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B634F2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="lELbBaZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfGXLxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:53:46 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:65415
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727453AbfGXLxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:53:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzWQSByEwwk8E+6HPy2lZhP8S4EL+IK4fmeoHWAUguS1pgQJj7anIbnUC2vuXOMx9EEGxK1jjeW9FgVziXjCqXsZFclFU2gvuguBtP9UHC20duIFB1kdwI4HPcAFowSQCsYyP/PJLz3+nCCU+KIwVfQLDG5w6RrziFZGBBjkWQpF2+Cm+0p0dyfEVb2tP3W03Ae67/qnSX2C/1F/8+yzDIK+qUwsDz/yt5pxOie1mMgDZwhjBXKMP+6tvtZEoxUJPf9TkZqIDhn0ulyauJ3Zq7AZu/apyZN62fbroYMXdqvZ+uQyLA9mikLYYB+KKoEGhbQ/XOzG5dktPITz1ZSonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKMSqL7E3nQpU8sO2KjV7GudNvff42sYCZ4w46wRt+Y=;
 b=BERbHQjt/OKFwOEq+xQbFuvhgtsBJIq6nb4leA2/0ZIzNJWupjVWPvzd9qS+WslTgI2SDAMte6912Zb+YlZeRAKgnupRuGJ97iegF1mfC3qxMw6SKZkV+J/Sy68Q3LVxcfiDHHesBLHzkCFj4mCsLRxrNxgeNMtcmUkGqBzoPh8Yy7sy4TiTvoI9zxZYMdYy/4mowfjgVDU2Amvl7sC+B2NGE0OSo8mDCmrbIEs7b4YONeVAf93liPkXiByo2zy2vC+BCChwMqO4d3P1doH2B7xJrxQidU778xHOws+0m7yesaU/2exQWXVaOBezNawClwfWpPnSerX03q+rYkB1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKMSqL7E3nQpU8sO2KjV7GudNvff42sYCZ4w46wRt+Y=;
 b=lELbBaZyBrTMaXP6Mn25bZYcpR3wfh7g3T0HN4yeFq5djCEcIFSWdfB41+CgUB7LYR9W50kOEe3OzM9fMrrMpTU4Lx22Y/YDJw4oIjIKq4R0aiW/JaHnQR5WZQ1xz9zfVFoGzrTReuSyehTJPz/6p1xUnR0VpYBSv+PSmdXSk8Q=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB4889.eurprd05.prod.outlook.com (20.176.235.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Wed, 24 Jul 2019 11:53:42 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::9115:7752:2368:e7ec]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::9115:7752:2368:e7ec%4]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 11:53:42 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>
Subject: Re: [PATCH 2/2] mm/hmm: make full use of walk_page_range()
Thread-Topic: [PATCH 2/2] mm/hmm: make full use of walk_page_range()
Thread-Index: AQHVQa6dZmZInZmjtUOST7LDwfSgk6bZVScAgABUVwA=
Date:   Wed, 24 Jul 2019 11:53:42 +0000
Message-ID: <20190724115338.GA30264@mellanox.com>
References: <20190723233016.26403-1-rcampbell@nvidia.com>
 <20190723233016.26403-3-rcampbell@nvidia.com> <20190724065146.GA2061@lst.de>
In-Reply-To: <20190724065146.GA2061@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:208:120::38) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd513704-5974-4d86-dc6a-08d7102d92c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB4889;
x-ms-traffictypediagnostic: DB7PR05MB4889:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB7PR05MB488964A3555C5BE250494988CFC60@DB7PR05MB4889.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(25786009)(2616005)(99286004)(66476007)(476003)(446003)(6246003)(53936002)(11346002)(66946007)(66446008)(66556008)(102836004)(305945005)(6512007)(478600001)(6306002)(7736002)(64756008)(54906003)(6436002)(186003)(386003)(52116002)(81156014)(6506007)(81166006)(6486002)(76176011)(14454004)(966005)(26005)(316002)(4326008)(8936002)(86362001)(2906002)(6916009)(1076003)(66066001)(3846002)(229853002)(486006)(5660300002)(36756003)(8676002)(33656002)(68736007)(256004)(6116002)(71200400001)(71190400001)(562404015);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4889;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7R2YgFtzTCR5D2IbgBNrlgUaAMNCNk6gD+IQoByXCQePyahHA9oIqH6K0+cd4gdTR7LEcJ7Q1mMfyefg1M7m7o8RDXwXWxypfmevvdgJsLu6wQFe88ZWDsjukH6UhK5me1NgDWQjgMLFbh8++3hriQE2xopHA34zfxYfsMzyur10ZvEfd5yIMCR2YjzNeWZsNgW/ba/ym1EtjRg5YtOjiYoEFgZBazvsJvx05X92Fcqa7yCWfm6H7JFW90UyTTpNVykA0oyHPTAkH7lp/tBQsQ3mpskeMuBRkDKduBPvHl6KmJFDUXqPy97ovRBiozB4xj4vwkioK1fluh4wFvmq53nUiw3MzejgGvjYXZL2Ffn7wFHxlCqffSjj29dU9YIBsvPwV+2w8MEkKZD6jpSOBhbwLPgyUU0Uyyr6LcEW9Kw=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DFFBF111B21DAF46A07C8DC9EA2A022D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd513704-5974-4d86-dc6a-08d7102d92c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 11:53:42.1875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4889
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 08:51:46AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 23, 2019 at 04:30:16PM -0700, Ralph Campbell wrote:
> > hmm_range_snapshot() and hmm_range_fault() both call find_vma() and
> > walk_page_range() in a loop. This is unnecessary duplication since
> > walk_page_range() calls find_vma() in a loop already.
> > Simplify hmm_range_snapshot() and hmm_range_fault() by defining a
> > walk_test() callback function to filter unhandled vmas.
>=20
> I like the approach a lot!
>=20
> But we really need to sort out the duplication between hmm_range_fault
> and hmm_range_snapshot first, as they are basically the same code.  I
> have patches here:
>=20
> http://git.infradead.org/users/hch/misc.git/commitdiff/a34ccd30ee8a8a3111=
d9e91711c12901ed7dea74
>=20
> http://git.infradead.org/users/hch/misc.git/commitdiff/81f442ebac7170815a=
f7770a1efa9c4ab662137e

Yeah, that is a straightforward improvement, maybe Ralph should grab
these two as part of his series?

> That being said we don't really have any users for the snapshot mode
> or non-blocking faults, and I don't see any in the immediate pipeline
> either.

If this code was production ready I'd use it in ODP right away.

When we first create a ODP MR we'd want to snapshot to pre-load the
NIC tables with something other than page fault, but not fault
anything.

This would be a big performance improvement for ODP.

Jason
