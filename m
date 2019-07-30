Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655BEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302D02087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="aDrcpjUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfG3Rj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:39:58 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:31712
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731314AbfG3Rjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:39:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX/kHSzV8Jul4w625nrsWxaBJXFG4ubDhlLJBlpiyxwew7BbgzkdzIGquWYHYqKj/jpmXO5DoB/kH/fjtRE+6ne9Hx4wls22pW9a3b5VwV/Clb/CSfPlwgL+KOLqFiIJuRMJGpSFmKJnHzcSv2WlQUvLTBY215UbyDABuJvVrFY6Q0jNgF4ccTtQomKr3fJxXM8D+BMdQKcP23U1FLOx+OTV+kSkiVrlNTksNZwV4bkt8hKwOgqOPoko+LyKiV1C0xPHMnveFSA5Y8g4E/WkMBRGtjj2GpBmeD/oQ+zncU1Hjo41qGKGLaAM2LhYutAH/lUE1RIUW11pHrpnC8Ug1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIXXrDH3RIIAh6Q/221asRxfL/RJZciP4vnd+I0w0ls=;
 b=lwLCvVcBdUIlOfGDrd3keOkNwaSDF5Jc2wGF14w9qo4KRSO+ombw7FLRMMURcKzeXgLG8B73NMNQPL/zq9kZPldmLIlsq7W+TQwf8OlNtlq0ly/Ghgytk8yaARECbuqVdtTo34/q4IzOLIX44OeNcYL4pCLQrHDNyMjH/54QGKpOodspc4+Pc3biiy0gvZCIq5WIwQzzWgY7qWg76MS0AjymfQRUS+C20FLvJE5qubIXr4LcGlQBjpSD11UUA2UHCuGVkm4v6liSFhFR6qrez7tmQaqX5Fdk5f91BsAk3SVdFZz/q5n4QOBJM4YYPBXiNEIqbB42x17X0BXKQKJ+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIXXrDH3RIIAh6Q/221asRxfL/RJZciP4vnd+I0w0ls=;
 b=aDrcpjUxOPdDC3JtKWodmUkQHpjT9TxN87EXf5vvRfbCbIP3VPxKitvNCQTKkRuz4annmWjiMymaiQ/FmY2RTxTgODhvUClXOjAt9q9xSezaKu7vNlDvB8nkpdnOVRr7CC/Il46/YvgVvIk+j6AE40jrO9ZpikW6an9Fij5kBCg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6829.eurprd05.prod.outlook.com (10.186.160.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 17:39:50 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 17:39:50 +0000
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
Subject: Re: [PATCH 08/13] mm: remove the mask variable in
 hmm_vma_walk_hugetlb_entry
Thread-Topic: [PATCH 08/13] mm: remove the mask variable in
 hmm_vma_walk_hugetlb_entry
Thread-Index: AQHVRpsBxp87/2vfUUuxY9sZD/Qj2KbjblgA
Date:   Tue, 30 Jul 2019 17:39:50 +0000
Message-ID: <20190730173946.GK24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-9-hch@lst.de>
In-Reply-To: <20190730055203.28467-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::31)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a618e036-983c-4381-ded6-08d71514ec54
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6829;
x-ms-traffictypediagnostic: VI1PR05MB6829:
x-microsoft-antispam-prvs: <VI1PR05MB6829E83CA49F6B5B1C893E89CFDC0@VI1PR05MB6829.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(189003)(199004)(7736002)(86362001)(71200400001)(53936002)(2616005)(6486002)(256004)(6436002)(71190400001)(478600001)(8936002)(6512007)(102836004)(6916009)(52116002)(11346002)(36756003)(14444005)(99286004)(476003)(26005)(14454004)(25786009)(81156014)(7416002)(305945005)(3846002)(81166006)(1076003)(486006)(446003)(316002)(4326008)(33656002)(6116002)(64756008)(66446008)(5660300002)(66946007)(6506007)(54906003)(66476007)(76176011)(229853002)(66556008)(386003)(8676002)(68736007)(2906002)(6246003)(66066001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6829;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xrKcYjxImGp5ANkno0SF7XbwaEl1a2Sx59Jxb3fuxL2Ez23xcyxr5pE7Y3cszYtaFenI4emzitTF/fwwTOXYNfSB7oY2fhDCe81QbgRzb0gBWiS8e9TwMd55bnuWYrNvnMjO2fnYbHwhaQgHeC9f0PW2muzlao6GI0YHNRaHpwqJ+Zm1o7xTulYAbFWony+Ku0hZK4RZIpEygPBIYTTGZihg0zunfTpbPgheZVz+qTZVbGkEZC64prBfqHxxG0OIelI94+MN84YG1A/YfliJEgyvq27Gzf0aM+sIV7GIKlS0a9DEK7feOwT+9GHxFxC2sS/SyhxlcPt55H1twIWEcEolrzKABbXfKBLpKlC188z0kK0NNKSbctUg/k06DBWJnfKeDy3BFPO9aODv3K7736kn96DJa/JsirhSVt1BPTY=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DF80A643D5A9864FAC08223380C661B3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a618e036-983c-4381-ded6-08d71514ec54
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 17:39:50.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6829
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 08:51:58AM +0300, Christoph Hellwig wrote:
> The pagewalk code already passes the value as the hmask parameter.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  mm/hmm.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index f26d6abc4ed2..88b77a4a6a1e 100644
> +++ b/mm/hmm.c
> @@ -771,19 +771,16 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, u=
nsigned long hmask,
>  				      struct mm_walk *walk)
>  {
>  #ifdef CONFIG_HUGETLB_PAGE
> -	unsigned long addr =3D start, i, pfn, mask;
> +	unsigned long addr =3D start, i, pfn;
>  	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
>  	struct hmm_range *range =3D hmm_vma_walk->range;
>  	struct vm_area_struct *vma =3D walk->vma;
> -	struct hstate *h =3D hstate_vma(vma);
>  	uint64_t orig_pfn, cpu_flags;
>  	bool fault, write_fault;
>  	spinlock_t *ptl;
>  	pte_t entry;
>  	int ret =3D 0;
> =20
> -	mask =3D huge_page_size(h) - 1;
> -
>  	ptl =3D huge_pte_lock(hstate_vma(vma), walk->mm, pte);
>  	entry =3D huge_ptep_get(pte);
> =20
> @@ -799,7 +796,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, uns=
igned long hmask,
>  		goto unlock;
>  	}
> =20
> -	pfn =3D pte_pfn(entry) + ((start & mask) >> PAGE_SHIFT);
> +	pfn =3D pte_pfn(entry) + ((start & hmask) >> PAGE_SHIFT);

I don't know this hstate stuff, but this doesn't look the same?

static int walk_hugetlb_range(unsigned long addr, unsigned long end, {
        struct hstate *h =3D hstate_vma(vma);
        unsigned long hmask =3D huge_page_mask(h); // aka h->mask

                        err =3D walk->hugetlb_entry(pte, hmask, addr, next,=
 walk);

And the first place I found setting h->mask is:

void __init hugetlb_add_hstate(unsigned int order) {
	h->mask =3D ~((1ULL << (order + PAGE_SHIFT)) - 1);

Compared with
    mask =3D huge_page_size(h) - 1;
         =3D ((unsigned long)PAGE_SIZE << h->order) - 1

Looks like hmask =3D=3D ~mask

?

Jason
