Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C6C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B87D222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ig7/cLvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbfHGRSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:18:06 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:41600
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729960AbfHGRSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:18:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M38IFZTtLXhblLeUKSTOOyY+BzP5VWo2NxFpFzFwsSqL+5D1WSw3A42cJnXH5TiCRayVqKFZ/Bfc22qbGvGxoRHxL/6ToaI+ZJeNohrGahSVStM0Xm7+8MhermUY7N3a9g9IJwASLTMEEpfjx2cUrkuGPiqkoH1n8ubVfqjURQ3lvfOMI8jTiZb4ftvJ4zSCiXGJolt2MkOQmUvueKUHQZn56LyqVsIFD397xBtsYISJaPQhroaJcCgwGGP78QXI/RnxF43yCljkSpEy9cvyT4qWPMBWQyCIsLTa4c9RSy6gpyQGFhVmWxTyNoQXk+VJgCLqksZftFbNthMbkGdOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4huSkCeVNugOTHQQcM6pySCS6vXgZT5Dzc2lhNeyww=;
 b=l2mAxgVVWXYxtwncWCfB/L6SZSZ7k8JfjYlANp+YoptrbzgWe7lXBk3vOq2bo+2KV0UA1j+JEqdnP8DF6qcI3bfteRGLxIbA2P6aH6x8d9IlK7MtMyoLNcCAvih/CXKs2qLpP9H/sVa1Ek/3h5ML6Ga+hYPYG9JQMKI1CcRhDwWh8tLamShUlyMQyhNBt2cXTg2hWjB5mszT8w3g5jSwXGe6XY76nbwe7tIuUYrTGBEwyf+cbF6E80kVdvYgC+oYuJgQl2+OZhnXi/QYulSd5+btBX1tTn/C4Dprf8m9w5rL0wz2VtatfuLBVwh6OhotsqLhcH5WHT8I5Puv2qYWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4huSkCeVNugOTHQQcM6pySCS6vXgZT5Dzc2lhNeyww=;
 b=ig7/cLvzVZOMNO+zztVocw6DLqmOk29OTrf6rZ2X7ZKua0vsUnomtAQRo1svdHUv8s6uISaDHFY6LgbVHR9qvRnEBfoTMG6ejM7vHHuDzwlgxXs11O7tahRu6YxbjLTCLxpo+owGhyodk0CKMpYfvCrdMxraPNNXMyub0L++Bg0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4671.eurprd05.prod.outlook.com (20.176.3.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Wed, 7 Aug 2019 17:18:01 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 17:18:01 +0000
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
Subject: Re: [PATCH 09/15] mm: don't abuse pte_index() in hmm_vma_handle_pmd
Thread-Topic: [PATCH 09/15] mm: don't abuse pte_index() in hmm_vma_handle_pmd
Thread-Index: AQHVTHDjVWJoFh6NnUauF/brrPZnVqbv7ziA
Date:   Wed, 7 Aug 2019 17:18:01 +0000
Message-ID: <20190807171755.GI1571@mellanox.com>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-10-hch@lst.de>
In-Reply-To: <20190806160554.14046-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c56f4fe-05c7-40ef-c6c0-08d71b5b333e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4671;
x-ms-traffictypediagnostic: VI1PR05MB4671:
x-microsoft-antispam-prvs: <VI1PR05MB4671C8FA48DC93F50C99C2F0CFD40@VI1PR05MB4671.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(6246003)(53936002)(33656002)(6436002)(6486002)(6512007)(6116002)(68736007)(54906003)(3846002)(2906002)(66066001)(316002)(36756003)(71190400001)(476003)(2616005)(11346002)(186003)(446003)(14444005)(26005)(102836004)(99286004)(66476007)(64756008)(7416002)(66556008)(71200400001)(256004)(305945005)(25786009)(5660300002)(6506007)(386003)(66446008)(8936002)(86362001)(52116002)(6916009)(14454004)(229853002)(8676002)(1076003)(4326008)(81166006)(478600001)(66946007)(4744005)(81156014)(7736002)(486006)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4671;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y5w2T4TwDEqVW/A/CS5dCgeAwrt8PXGrtm3uRFpMUQxqZmB+oFSvM857UGs06YXyJV1Opb+rNLObiLz2oz48V4ILUx67rdmHAh7jF9WQQzStmE67vdRyKeC91312yvdFPK7QrHPS85XneYw91kz3ArXf1ktjAmP89EfXUOBwPwZqXtC7Fdjq0yEOLfPNTWFGHNLdu75ZvrIXN7EBCXOGkhQu2YfcH8n2FwrK+CPdGvCNhQks2gVxXRrAS3cmhtCGwx08yK1pH2H10rwUWRzDCMPrm/Poynzo+p2AZ2rCAvNZNJ2NG+dOEr4V8O+SHkCh4/PhIg8HO6L5wlXFF9hi2FgYbN3CmNN3WBTa441cdg9OlCfmlA3XrqA+o/NyPwFbtLjRnPXzSBHRt8a9bBek4Qa+hk0mLXMyGBqeA2rLTOk=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C7103DD7868C384CA830F3D0DA65CF22@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c56f4fe-05c7-40ef-c6c0-08d71b5b333e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 17:18:01.4239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:05:47PM +0300, Christoph Hellwig wrote:
> pte_index is an internal arch helper in various architectures,
> without consistent semantics.  Open code that calculation of a PMD
> index based on the virtual address instead.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/hmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

There sure are a lot of different ways to express this, but this one
looks OK to me, at least the switch from the PTRS_PER_PTE expression
in the x86 imlpementation to PMD_MASK looks equivalent
=20
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
