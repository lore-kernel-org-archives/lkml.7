Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B35C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832AA21E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="NJb0APCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbfHGRp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:45:59 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:31286
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729278AbfHGRp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:45:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNwTfZ0wrE+jt28SJvIhXnkuU+n/1GuJebgT9ss+ko15QQhSDK2RFVqo8ckacAtIuains4xSDitA0pHoh6+vMSleGADcDa74VR4JPN0qIXtlcv+omeb/GNg8zwaUPVrShpcMDtvPv4ckW5uO4EpKKXrQoE7AJQMshO2RMcE+6iu7H5TmSVPdfArzAAZ1qtTHOE7jxmxJQIwn4Qm8Un7RGmOM3z6v14kn/PfiWD+BM94jCWE5EMVE0kcQdee4FGsQAuOIcnAOR/xv5EZH4/CmNI9hu+5g58IFUCb1BwdjAHeRmyBcCZNliBNxSLNTDTdn8vfudJLyp8dAdEaCGuHhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvvJ2eL2eZjkefdvEIf+VsH6qjNAkNeA8tF8jjvs00Y=;
 b=jMhFfihAW9rtjL4uUHcZhfCi5vg2J6A2lwmxoeQrMIlAlrIsua38NlIRUlKYJh4n4BoardYApSr/UMiU0EbXv1jOT55REa3oqjLS1zXvQWE7pDi+Ye7BG2T9Zv9fgycscac3IM36SZzvknC/0IsRZ9J55t9jAxLqo8/rjdb+K5PJPona61L41S96zftKmB6syayKiUkUdjzKQt8BsUvkVBNgXV+wRF1QF8fDsmIqLFJcvawzsLOAzXDoh/iR0k2Whr6HgbA78XZLPq2A4ufG5VBb3NDNdMW6uV5wGcDJ41VA+ick77+GK1v3PFVancJnCVk981a9QmPDKI9zRtuTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvvJ2eL2eZjkefdvEIf+VsH6qjNAkNeA8tF8jjvs00Y=;
 b=NJb0APCOIhWxOMMjzvUQp/k/Ra8sJQJB1yDxf1xgZ+5SqDIdLTQ08uNiWk2LeRpmCzuvJXZz8jYio98RCwFmpjWSV0rVxG54UAt7gRepK+RahYS5cxdWSAeeE+h2HQuisLd2IubD5n3kf15i5dv5u5bvpt2jeglKKIBB4qJzR/4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6607.eurprd05.prod.outlook.com (20.178.205.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 17:45:53 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 17:45:53 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Thread-Topic: [PATCH 04/15] mm: remove the pgmap field from struct
 hmm_vma_walk
Thread-Index: AQHVTHDc5B4IgstYQk6yBJaVfn8xGqbv9wIA
Date:   Wed, 7 Aug 2019 17:45:53 +0000
Message-ID: <20190807174548.GJ1571@mellanox.com>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-5-hch@lst.de>
In-Reply-To: <20190806160554.14046-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::41) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c99e3ea0-d749-413d-05b3-08d71b5f17cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6607;
x-ms-traffictypediagnostic: VI1PR05MB6607:
x-microsoft-antispam-prvs: <VI1PR05MB66071160AE89CD17BEE8D55BCFD40@VI1PR05MB6607.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(26005)(446003)(186003)(81156014)(54906003)(2616005)(36756003)(1076003)(33656002)(110136005)(6116002)(66446008)(66476007)(66556008)(64756008)(3846002)(4326008)(66946007)(2906002)(25786009)(486006)(5660300002)(86362001)(6512007)(6486002)(68736007)(66066001)(102836004)(229853002)(305945005)(256004)(316002)(7416002)(81166006)(476003)(53936002)(11346002)(6436002)(6246003)(386003)(8676002)(52116002)(99286004)(14454004)(7736002)(6506007)(76176011)(8936002)(71190400001)(478600001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6607;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aNoLDYWnlYfmrPNtvKWoB776Gsw5k+YFnOM1DyH9TLFc5HK4v/0vvNa+9xz0/KDtJqYT8AI45YV3IW8MOl3LUqhklynN+fAdiqaxrUgfeov4tQzGifHLet5MeKNkmxnd9afI6KwRfTO3FrF0xUdfXYg1Zg4SqwpGqaCYRGm2OCchfnZ7OM731iDo/wNn4GqBjt1GNKJjZu8a7tP73fEPWY1XFoPGgsfcQVePV5oz+N+ktMafrO5P0JkmsC9kSCFtg/oRuKPgPQbD8yH9Xjfvpv9aPU/rJrka8mEnWjBSbEYRH0lLcgw+kDs90/IFqads/V266w3TDNkGn45PnKbP95hebDgFDZjYyf08DAn8dScYHma6SxBzB4OKfTkkT8zW8PMWXP1gRbEdS1n3D06XupdwCRb6U/czC2Ly/SH/gTg=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1920BF82988BC542A48F1F6D6A0BA986@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99e3ea0-d749-413d-05b3-08d71b5f17cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 17:45:53.3318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6607
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:05:42PM +0300, Christoph Hellwig wrote:
> There is only a single place where the pgmap is passed over a function
> call, so replace it with local variables in the places where we deal
> with the pgmap.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  mm/hmm.c | 62 ++++++++++++++++++++++++--------------------------------
>  1 file changed, 27 insertions(+), 35 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 9a908902e4cc..d66fa29b42e0 100644
> +++ b/mm/hmm.c
> @@ -278,7 +278,6 @@ EXPORT_SYMBOL(hmm_mirror_unregister);
> =20
>  struct hmm_vma_walk {
>  	struct hmm_range	*range;
> -	struct dev_pagemap	*pgmap;
>  	unsigned long		last;
>  	unsigned int		flags;
>  };
> @@ -475,6 +474,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
>  	struct hmm_range *range =3D hmm_vma_walk->range;
> +	struct dev_pagemap *pgmap =3D NULL;
>  	unsigned long pfn, npages, i;
>  	bool fault, write_fault;
>  	uint64_t cpu_flags;
> @@ -490,17 +490,14 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
>  	pfn =3D pmd_pfn(pmd) + pte_index(addr);
>  	for (i =3D 0; addr < end; addr +=3D PAGE_SIZE, i++, pfn++) {
>  		if (pmd_devmap(pmd)) {
> -			hmm_vma_walk->pgmap =3D get_dev_pagemap(pfn,
> -					      hmm_vma_walk->pgmap);
> -			if (unlikely(!hmm_vma_walk->pgmap))
> +			pgmap =3D get_dev_pagemap(pfn, pgmap);
> +			if (unlikely(!pgmap))
>  				return -EBUSY;

Unrelated to this patch, but what is the point of getting checking
that the pgmap exists for the page and then immediately releasing it?
This code has this pattern in several places.

It feels racy

>  		}
>  		pfns[i] =3D hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
>  	}
> -	if (hmm_vma_walk->pgmap) {
> -		put_dev_pagemap(hmm_vma_walk->pgmap);
> -		hmm_vma_walk->pgmap =3D NULL;

Putting the value in the hmm_vma_walk would have made some sense to me
if the pgmap was not set to NULL all over the place. Then the most
xa_loads would be eliminated, as I would expect the pgmap tends to be
mostly uniform for these use cases.

Is there some reason the pgmap ref can't be held across
faulting/sleeping? ie like below.

Anyhow, I looked over this pretty carefully and the change looks
functionally OK, I just don't know why the code is like this in the
first place.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

diff --git a/mm/hmm.c b/mm/hmm.c
index 9a908902e4cc38..4e30128c23a505 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -497,10 +497,6 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 		}
 		pfns[i] =3D hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
 	}
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap =3D NULL;
-	}
 	hmm_vma_walk->last =3D end;
 	return 0;
 #else
@@ -604,10 +600,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, un=
signed long addr,
 	return 0;
=20
 fault:
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap =3D NULL;
-	}
 	pte_unmap(ptep);
 	/* Fault any virtual address we were asked to fault */
 	return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
@@ -690,16 +682,6 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 			return r;
 		}
 	}
-	if (hmm_vma_walk->pgmap) {
-		/*
-		 * We do put_dev_pagemap() here and not in hmm_vma_handle_pte()
-		 * so that we can leverage get_dev_pagemap() optimization which
-		 * will not re-take a reference on a pgmap if we already have
-		 * one.
-		 */
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap =3D NULL;
-	}
 	pte_unmap(ptep - 1);
=20
 	hmm_vma_walk->last =3D addr;
@@ -751,10 +733,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 			pfns[i] =3D hmm_device_entry_from_pfn(range, pfn) |
 				  cpu_flags;
 		}
-		if (hmm_vma_walk->pgmap) {
-			put_dev_pagemap(hmm_vma_walk->pgmap);
-			hmm_vma_walk->pgmap =3D NULL;
-		}
 		hmm_vma_walk->last =3D end;
 		return 0;
 	}
@@ -1026,6 +1004,14 @@ long hmm_range_fault(struct hmm_range *range, unsign=
ed int flags)
 			/* Keep trying while the range is valid. */
 		} while (ret =3D=3D -EBUSY && range->valid);
=20
+		/*
+		 * We do put_dev_pagemap() here so that we can leverage
+		 * get_dev_pagemap() optimization which will not re-take a
+		 * reference on a pgmap if we already have one.
+		 */
+		if (hmm_vma_walk->pgmap)
+			put_dev_pagemap(hmm_vma_walk->pgmap);
+
 		if (ret) {
 			unsigned long i;
=20
