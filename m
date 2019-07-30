Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D72C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D770E2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="CdhlAQfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbfG3RuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:50:21 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:35127
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfG3RuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:50:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsPQkWCgQA2A332qXYrkylLMXCuD2+29/O5ZmJgtMktkNxXU9bO1674b5pES+/3quJkdu/Z00z1Vd8e2r0SaOr1kHHMsoAbM7gf+XJx8NgiWqkifbxSXNuXPZ/JPIH2JSz7uuATT9gt12HQC4P6LHDxgR4GDCvvwoaHXsTcLdZSSkXjl8GiMpXauwEKuyo3/rRY41/ymfECZzZdEvj0AFQyYNEFhQaW9tHZF0SYDo0p6EOYzNrkSEB0YmURFZdyrzdPPtrIE3qktUaiZp2nZZMDPRyG0K+3PZhSyFMRaKxz7tC7Fw7T87B9tDBmbtcsmDSbdGbHQrT5/oyOIPBU2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZZP4+A/TZaxgN3zEx0MeeBZBIZ602To4vmuVwuqZvE=;
 b=oJc085LRKyrUemzH0vYba/WJm5frbPvqj1uFPalUHH5M3Ni4AWWo5dsU3rGfev2w9FkWdEAA0yvAwOMl8eXrgb8qHhQzW9AsA1n3sN829aR2iDxcRvInAiLZTvYKoYFqzZuCZA++6VfqUkLonmjsAm5BMyZYhsPVq7NFD8WnL6In46tPP95aD8CheShgINFa/LshABfA3WEhDCNsf0gfCOrp24FXcZyx5INRV/PwZP3L2ni/EhwCde/cu5YPgB+7XaRt6hc6OrEED9OhfOH0LFp25mxSQRFJQDJBPF7XljK07RVFCGJt7bZu8NVoJ2nPXrMiKNBUtfqSSe7viEgA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZZP4+A/TZaxgN3zEx0MeeBZBIZ602To4vmuVwuqZvE=;
 b=CdhlAQfu+RJBdJMFzZgnUUpI5bQZ6lWavR96DlWB6u3gs9gMAL1l69olau9vdC6JJPUZMAMsvXch9t1ry0zM+HqqJfT0+UMZwE7RZYe1LBRrRHRQmAaiOCMKx/cM3lBEpIllErpb1N30jV5tsrHq61hd5mDZw7DmmZniLq1i6KQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6414.eurprd05.prod.outlook.com (20.179.27.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 17:50:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 17:50:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/13] mm: remove the page_shift member from struct
 hmm_range
Thread-Topic: [PATCH 07/13] mm: remove the page_shift member from struct
 hmm_range
Thread-Index: AQHVRpr/I9wxeKeChkuG0OEJhB2jNabjHtYAgAAFZQCAAE0GgA==
Date:   Tue, 30 Jul 2019 17:50:16 +0000
Message-ID: <20190730175011.GL24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-8-hch@lst.de> <20190730125512.GF24038@mellanox.com>
 <20190730131430.GC4566@lst.de>
In-Reply-To: <20190730131430.GC4566@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c1699fe-0d84-4dfe-8b52-08d71516614c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6414;
x-ms-traffictypediagnostic: VI1PR05MB6414:
x-microsoft-antispam-prvs: <VI1PR05MB64144959A16828D401397E56CFDC0@VI1PR05MB6414.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(51444003)(189003)(199004)(386003)(2906002)(66556008)(66446008)(64756008)(76176011)(478600001)(14444005)(486006)(1076003)(86362001)(66946007)(71190400001)(7416002)(446003)(305945005)(7736002)(68736007)(53936002)(66066001)(6512007)(2616005)(71200400001)(6506007)(11346002)(476003)(66476007)(5660300002)(81166006)(186003)(52116002)(6436002)(6246003)(256004)(8936002)(36756003)(6486002)(8676002)(3846002)(4326008)(102836004)(229853002)(25786009)(26005)(316002)(81156014)(6116002)(33656002)(54906003)(99286004)(6916009)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6414;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e+zU7fci+K1WDyo6Q7hyPxNzVC3a1Cb9hpT7qlJ1qJpCXrFC3VtM51Y0I69imVKk4fgjJB7oQUPYCaj0oGkiNvhRo9DvuJT91Yc5aX05k8sag9F7jzPoWwJCu4aO+XyotRagRgrIj+GCkoPsRWbxMPy9BR5hnlEyQGY42NO5Lu8Wsx1f6H9EpaAoQ6IOF09vTR8qj0zQqjSnmXuTNDbw+M29Ntz/7pTbF8uGbPwqO2DryQ3HnmKU4l2bAA5VGNMywD5RGW1xAci5zwUE7GGoJUukn93HCclZX5bSi+scnsV1HHnw75KA2inlIHuzlJLyakPA8CIs/y/NkyO9hds9mcQAVQmybvchUOvzgE79XJk+bPWOWbqyRXn8cko7e/Oy+Hd6NmvTUJkcMq0pRxMEUJabfY7srFIgyaatgI1/QSQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C2F97CE8AB885F42907BDBA1823FEA57@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1699fe-0d84-4dfe-8b52-08d71516614c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 17:50:16.4913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 03:14:30PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 30, 2019 at 12:55:17PM +0000, Jason Gunthorpe wrote:
> > I suspect this was added for the ODP conversion that does use both
> > page sizes. I think the ODP code for this is kind of broken, but I
> > haven't delved into that..
> >=20
> > The challenge is that the driver needs to know what page size to
> > configure the hardware before it does any range stuff.
> >=20
> > The other challenge is that the HW is configured to do only one page
> > size, and if the underlying CPU page side changes it goes south.
> >=20
> > What I would prefer is if the driver could somehow dynamically adjust
> > the the page size after each dma map, but I don't know if ODP HW can
> > do that.
> >=20
> > Since this is all driving toward making ODP use this maybe we should
> > keep this API?=20
> >=20
> > I'm not sure I can loose the crappy huge page support in ODP.
>=20
> The problem is that I see no way how to use the current API.  To know
> the huge page size you need to have the vma, and the current API
> doesn't require a vma to be passed in.

The way ODP seems to work is once in hugetlb mode the dma addresses
must give huge pages or the page fault will be failed. I think that is
a terrible design, but this is how the driver is ..

So, from this HMM perspective if the caller asked for huge pages then
the results have to be all huge pages or a hard failure.

It is not negotiated as an optimization like you are thinking.

[note, I haven't yet checked carefully how this works in ODP, every
 time I look at parts of it the thing seems crazy]

> That's why I suggested an api where we pass in a flag that huge pages
> are ok into hmm_range_fault, and it then could pass the shift out, and
> limits itself to a single vma (which it normally doesn't, that is an
> additional complication).  But all this seems really awkward in terms
> of an API still.  AFAIK ODP is only used by mlx5, and mlx5 unlike other
> IB HCAs can use scatterlist style MRs with variable length per entry,
> so even if we pass multiple pages per entry from hmm it could coalesce
> them. =20

When the driver takes faults it has to repair the MR mapping, and
fixing a page in the middle of a variable length SGL would be pretty
complicated. Even so, I don't think the SG_GAPs feature and ODP are
compatible - I'm pretty sure ODP has to be page lists not SGL..

However, what ODP can maybe do is represent a full multi-level page
table, so we could have 2M entries that map to a single DMA or to
another page table w/ 4k pages (have to check on this)

But the driver isn't set up to do that right now.

> The best API for mlx4 would of course be to pass a biovec-style
> variable length structure that hmm_fault could fill out, but that would
> be a major restructure.

It would work, but the driver has to expand that into a page list
right awayhow.

We can't even dma map the biovec with today's dma API as it needs the
ability to remap on a page granularity.

Jason
