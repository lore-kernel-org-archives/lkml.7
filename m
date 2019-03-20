Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA285C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852DA21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JSmyPecH";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="M6JU9abf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCTS5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:57:35 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50432 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727062AbfCTS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:57:34 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KIoGio015674;
        Wed, 20 Mar 2019 11:57:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=l37ta0odjHkXOKVWzO/JIZlwYKfiZyYsjhOpLEq+ob0=;
 b=JSmyPecHKg8zBtKYaVotRmoKQLRFgOzZPVaHoAovelE7TLLD3H/Y6GUbcGdSirwBxkZn
 vSLI4F8hVVW+ar/gQQzmaHVeiNiibcY2YzbLe/vQhpu5lVEIXSF8VtTVvJlA7ypDMHo0
 DCKrCVZBJ9NDJAOfNtPlI+CbX11e8H45v+8/Ny12qvOTd7g1bOdNjDPlP0t+ICdwerSt
 KFrP/RiyXArk52COo9fdabJ20Cs0htUWpGo/GSlcAjry3+enCYZuEB7/abnqSPHh0rQ0
 QSDA7z7AJaK8BR2oUl6kqFpEiToudVvY73zuOOnfGMsJsnIgvYeNkM6guhh3gDd3rODv xw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2rbjvm1ttv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Mar 2019 11:57:26 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Mar
 2019 11:57:25 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.53) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Mar 2019 11:57:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l37ta0odjHkXOKVWzO/JIZlwYKfiZyYsjhOpLEq+ob0=;
 b=M6JU9abfbz6XkQHw3xB6Dpnx/AkGtkBscgRBhiLG8NugPIrucV16gfssG8gat/nTT4navit7a9Zz1x0rcVod7lgs8rcpgmGDxpFrkEl+IWOrsnJ9VW5v/cq/YE8WJCpbjP1fagZRK4j58ZxE2Jyv8a8A+rYpDdjphUS+36XhRWE=
Received: from BL0PR18MB2305.namprd18.prod.outlook.com (52.132.30.25) by
 BL0PR18MB2259.namprd18.prod.outlook.com (52.132.30.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 20 Mar 2019 18:57:24 +0000
Received: from BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6]) by BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6%5]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 18:57:24 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iommu/iova: Fix tracking of recently failed iova address
Thread-Topic: [PATCH v2] iommu/iova: Fix tracking of recently failed iova
 address
Thread-Index: AQHU307AEdaxNF9UUkmc+mwpnWSWUw==
Date:   Wed, 20 Mar 2019 18:57:23 +0000
Message-ID: <20190320185718.jhr6gvs7jdbn4x3p@rric.localdomain>
References: <20190315155553.11857-1-rrichter@marvell.com>
 <7515342b-f4b2-9406-5249-93ae7880835a@arm.com>
In-Reply-To: <7515342b-f4b2-9406-5249-93ae7880835a@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::25) To BL0PR18MB2305.namprd18.prod.outlook.com
 (2603:10b6:207:43::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.191.24.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea1c95ec-eb05-410d-cea4-08d6ad65e349
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR18MB2259;
x-ms-traffictypediagnostic: BL0PR18MB2259:
x-microsoft-antispam-prvs: <BL0PR18MB22597F17B1527028F9D918DCD9410@BL0PR18MB2259.namprd18.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(305945005)(6436002)(81156014)(256004)(316002)(9686003)(53936002)(105586002)(106356001)(6486002)(4326008)(71190400001)(6512007)(54906003)(8936002)(25786009)(71200400001)(1076003)(97736004)(5660300002)(6916009)(99286004)(8676002)(52116002)(6506007)(76176011)(186003)(7736002)(66066001)(486006)(102836004)(53546011)(478600001)(3846002)(476003)(2906002)(68736007)(6116002)(86362001)(11346002)(26005)(14454004)(386003)(14444005)(81166006)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR18MB2259;H:BL0PR18MB2305.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XyHEiuqnHK5J5Z0J6x3J24POzC/6vSM8QFpG/oAHppySdz+ZgoNn0FKe613h9Tvy5fv5K5pPzvp5bjPj/iEVtThJHsJhfLTLOV0wTytvE2jFdmuqdVUypB6lPRv710Eev/Btx8UPu+nq/QaawyIbZf2zC9Qr/YYhHRZepccgIor4Y8kjTYUhSo4bmRVCIpfOz2aApR2yXgEsSbmdcf4ejpNY+mI3wv2f6qLhcB0FomCSJRKLhm55GBcqIzSgAATk7tVnXmOf+PrFlXHrhsOEU9BsYoHJHTE7UFb4dXfMCHUNdKRf4UYWh+FlyhBkJ82ee+2EraXSftOLA0TD61EkmGM0CHCOBg5hVDuhjtCmZi3xDxDB77PJL5kpypo0iFWA5zX8bvB7vwTbdEBi3VtqaJnDsjtzkYVG8RJ2OMXnZwU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E854B9372BE4340AD425230E1258AD2@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1c95ec-eb05-410d-cea4-08d6ad65e349
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 18:57:23.8692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2259
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.19 15:19:23, Robin Murphy wrote:
> On 15/03/2019 15:56, Robert Richter wrote:
> > We track the smallest size that failed for a 32 bit allocation. The
> > Size decreases only and if we actually walked the tree and noticed an
> > allocation failure. Current code is broken and wrongly updates the
> > size value even if we did not try an allocation. This leads to
> > increased size values and we might go the slow path again even if we
> > have seen a failure before for the same or a smaller size.
>=20
> That description wasn't too clear (since it rather contradicts itself by
> starting off with "XYZ happens" when the whole point is that XYZ doesn't
> actually happen properly), but having gone and looked at the code in cont=
ext
> I think I understand it now - specifically, it's that the early-exit path
> for detecting that a 32-bit allocation request is too big to possibly
> succeed should never have gone via the route which assigns to
> max32_alloc_size.
>=20
> In that respect, the diff looks correct, so modulo possibly tweaking the
> commit message,
>=20
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Robin, thanks for your review.

I hope the following description is better now.

Thanks,

-Robert

-- >8 --
From: Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2] iommu/iova: Fix tracking of recently failed iova addres=
s
 size

If a 32 bit allocation request is too big to possibly succeed, it
early exits with a failure and then should never update max32_alloc_
size. This patch fixes current code, now the size is only updated if
the slow path failed while walking the tree. Without the fix the
allocation may enter the slow path again even if there was a failure
before of a request with the same or a smaller size.

Cc: <stable@vger.kernel.org> # 4.20+
Fixes: bee60e94a1e2 ("iommu/iova: Optimise attempts to allocate iova from 3=
2bit address range")
Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/iommu/iova.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index f8d3ba247523..2de8122e218f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -207,8 +207,10 @@ static int __alloc_and_insert_iova_range(struct iova_d=
omain *iovad,
 		curr_iova =3D rb_entry(curr, struct iova, node);
 	} while (curr && new_pfn <=3D curr_iova->pfn_hi);
=20
-	if (limit_pfn < size || new_pfn < iovad->start_pfn)
+	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+		iovad->max32_alloc_size =3D size;
 		goto iova32_full;
+	}
=20
 	/* pfn_lo will point to size aligned address if size_aligned is set */
 	new->pfn_lo =3D new_pfn;
@@ -222,7 +224,6 @@ static int __alloc_and_insert_iova_range(struct iova_do=
main *iovad,
 	return 0;
=20
 iova32_full:
-	iovad->max32_alloc_size =3D size;
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return -ENOMEM;
 }
--=20
2.20.1

