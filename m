Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB125C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E7B21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="erhvS+Ql";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="CU1JarBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfCOP4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:56:44 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54720 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727826AbfCOP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:56:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2FFo1w5030382;
        Fri, 15 Mar 2019 08:56:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=UDUxqgDBXtocqTZAKpGgG6e5RJEunDUWYkSv75Wtj+A=;
 b=erhvS+QlXbHQJtg8JXe6B4z8rk2p/bb88Hv7fFquB+ZfrP5kJXxk9uJDt7nfrLttvY2K
 /gl4h+7BuGCnmb32cNcKcfaKpGYJQgMyrMeLQtkJL6XU7GbsFfYrpBR1wUR54PQDoLzi
 WrH02Bl8AC7XNHavABaQ5b5iZRVCdEDV6DrcK1jn9szGRtmyEE8QFLYsQcSbC2RcmrHC
 60GEbxPt5cFfKTuuRV6ntWU7NSLjxf7CPkT6bPw/OGLltdA5SHalNnaceijDw5l2IyiS
 7Ls8ClHgJA8z3TOOq/krig4B/sQqKcVfl4RUINySjfa0tZRbaqsnHWtFucRAzCZaokhE tw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2r832uhy42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Mar 2019 08:56:31 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 15 Mar
 2019 08:56:24 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 15 Mar 2019 08:56:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDUxqgDBXtocqTZAKpGgG6e5RJEunDUWYkSv75Wtj+A=;
 b=CU1JarBmX0B9+ESOWI7MiE0l8vWjqLFOmqZHqOfbyl115UWuGh3Waip3ADwo0XboG1AcUlSsWkVx4t4V/12DDdToh/gIJWfBv/3H2zZXxrc913GfKw0UsZh+J7bHHFRMXlPoQ92o8UKW6A7FleWb9mJVmIP6ekeruAgbIUJ/xMU=
Received: from BL0PR18MB2305.namprd18.prod.outlook.com (52.132.30.25) by
 BL0PR18MB2098.namprd18.prod.outlook.com (52.132.29.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 15:56:20 +0000
Received: from BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6]) by BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6%5]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 15:56:20 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/iova: Fix tracking of recently failed iova address size
Thread-Topic: [PATCH] iommu/iova: Fix tracking of recently failed iova address
 size
Thread-Index: AQHU20ehRvgf+8CoyU63ky+ykU5Omg==
Date:   Fri, 15 Mar 2019 15:56:20 +0000
Message-ID: <20190315155553.11857-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0058.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::35) To BL0PR18MB2305.namprd18.prod.outlook.com
 (2603:10b6:207:43::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [77.11.41.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f35873f5-b2cb-4389-dc8c-08d6a95ec3c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR18MB2098;
x-ms-traffictypediagnostic: BL0PR18MB2098:
x-microsoft-antispam-prvs: <BL0PR18MB20984D540C44BF5573A13227D9440@BL0PR18MB2098.namprd18.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39850400004)(366004)(136003)(199004)(189003)(305945005)(478600001)(4326008)(8936002)(7736002)(14444005)(256004)(476003)(99286004)(5660300002)(54906003)(6512007)(2906002)(6506007)(66066001)(386003)(6916009)(71200400001)(86362001)(71190400001)(486006)(102836004)(25786009)(97736004)(68736007)(105586002)(81166006)(6436002)(8676002)(106356001)(3846002)(6486002)(26005)(6116002)(316002)(50226002)(81156014)(2616005)(53936002)(52116002)(186003)(14454004)(36756003)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR18MB2098;H:BL0PR18MB2305.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dAcpqf/w+vtmz7Xu94VD2EGJ6pTBfKt5NeZURWzGeXz6sN3ql9aWw/+ni2ovq/8+Et7+GyCFiM3tHZUAYB62sqYobAMdTW+gN5SirxqRMHInzyB4Gv4l64quMIV6BG9Xire5bfoyMH+MkK5c7fEk4MhmepTUByCkPXdyyEfZop8RH/zZa43kois/d6UfthnBZ2HwdELZ7LgTqKYqf0tCnNcC3B2gmUEqmn2n5H1QoFqzgbFqSyLX2+wC2zw8qJP8dtev0Blym5gGM4M3yM+1AjGWgq67nyrJEEjygnqIuezjrFY8bwehQ/47/2ipon8Pw5bl2q+SvOFos4+//561wsSeMjUWdkTGbTSkcVS+hU9mOS+ywzinxHHiQ4xPcDwiuag7oi/ChmJY/tC6tXWSuVRa4jmCpio/9iG3j349ZWw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f35873f5-b2cb-4389-dc8c-08d6a95ec3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 15:56:20.3473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2098
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We track the smallest size that failed for a 32 bit allocation. The
Size decreases only and if we actually walked the tree and noticed an
allocation failure. Current code is broken and wrongly updates the
size value even if we did not try an allocation. This leads to
increased size values and we might go the slow path again even if we
have seen a failure before for the same or a smaller size.

Cc: <stable@vger.kernel.org> # 4.20+
Fixes: bee60e94a1e2 ("iommu/iova: Optimise attempts to allocate iova from 3=
2bit address range")
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

