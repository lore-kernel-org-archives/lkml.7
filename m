Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24197C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D919A206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="qYPIGX+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfJJOG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:06:26 -0400
Received: from mail-eopbgr140125.outbound.protection.outlook.com ([40.107.14.125]:43673
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbfJJOG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:06:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFL8KV1xlB6lb0V8f/mrSz82zT4l8kwi5XzPOkHxrnnSXKmQxsZYepcWZcl1Ed/U73np5FJi7l9iJpUE2vMVsQJXaCIGeitXsUgFOhuFXq9ShpGPHXpSBJ2SyrbUBdoMck05bUraAi/YuwbRqv8KmCUZ4seabZIvMunROq5SiyQytfnQITQrQAma0xOsuvPjsZgpniyWdjM8Z2UhiHWj5xmQhcXcvCrR8C7OjEIKZi+a01SvfJCQDueSrzmk3jEOfz2syLp0U0c6Bs+m2KKucV6XB2pqQbWOAyQ787njVg5/6b9stAOlisIGvBgYRuGnv/K2mu8QGFJQ0hqb/fzTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS3VTLTa+lWah6pwgnn6MEgKkoqTS0nPBNHBsevWNLw=;
 b=MvHxrb2JS0OkyCPhXqanL21ZyWc+st000aNqvo6Tfr/hpIWUk9BRTjWluBCzsKqjeWad+iYG84GoaPr2ThT/N41qYOwD4FwyC5YI0BqiiG9kOykigsgc4Drj9wi9O/U7vgaBxA9bNVt6GYJw0ZoZ7C7DpXGG3LGugTt9RoT0l9UC2CvsSL/kyq/BG70YJkodpKmtf3xc06fI0vKUqz35012oGYmD27yjXmy0IVmLLZrYcrKvCXZul9bxoMWvFJUBcGIaTRdIt36+8KqYZKARyJxIjoAIzSsQxfEjSAntxyxS1ZiBCAJDWy8I/YzFGDCRbR1K+UkvR01mvrnBvhrKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS3VTLTa+lWah6pwgnn6MEgKkoqTS0nPBNHBsevWNLw=;
 b=qYPIGX+JOsAguxAGFoID2djQ1xkXEzDrVAzKUaTwjJplkVJozJxeJ/DPg/rjtALwe7FEVXGTuvGqcWA+X/utbmBrNcKYFCWoTeBk9TTbkplF1PX/UgsoGTLWhHAEsN3hIRybzQTxzP4hB7xAWP4Vel1Y9Q19cVccv35yqx6Slrg=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3447.eurprd02.prod.outlook.com (52.133.8.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 14:06:23 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251%5]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 14:06:23 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] habanalabs: handle large memory on MMU
Thread-Topic: [PATCH 2/2] habanalabs: handle large memory on MMU
Thread-Index: AQHVf3PlHPTKZvCtw0Oj5rRXIbbVSA==
Date:   Thu, 10 Oct 2019 14:06:23 +0000
Message-ID: <20191010140615.26460-2-oshpigelman@habana.ai>
References: <20191010140615.26460-1-oshpigelman@habana.ai>
In-Reply-To: <20191010140615.26460-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0073.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::14) To AM6PR0202MB3382.eurprd02.prod.outlook.com
 (2603:10a6:209:20::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8a392c3-e384-44d8-7ea0-08d74d8b0816
x-ms-traffictypediagnostic: AM6PR0202MB3447:
x-microsoft-antispam-prvs: <AM6PR0202MB3447E7453ED0500EB64FDCA2B8940@AM6PR0202MB3447.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(346002)(39840400004)(199004)(189003)(4326008)(81166006)(52116002)(2351001)(76176011)(186003)(25786009)(316002)(256004)(386003)(11346002)(14444005)(3846002)(6116002)(7736002)(26005)(50226002)(8936002)(102836004)(446003)(8676002)(5660300002)(1361003)(81156014)(14454004)(1076003)(99286004)(305945005)(6506007)(66066001)(71190400001)(71200400001)(6436002)(66446008)(64756008)(66556008)(66476007)(6916009)(6486002)(86362001)(486006)(36756003)(2501003)(478600001)(66946007)(6512007)(2906002)(2616005)(476003)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3447;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +wa6Fm9DjqJZbL3iIJYyEtOnX4eWxSVQ6uvR8VGJ3SNxuqYaIkK6rDcKs2dGtzBo3o60iWsYsg63btag3zG7Ffw9gtKMGDqQdwgE/1MZRPZeT/Mt/dfE+lw0k5vgdvgQCamtO3ImnYXo4jgwv/39SpTA7B6c7bK2mXdnW/nCSTNaZyt29ygyIPmFyPfJBetjE/3HoCMukjEjNn9vQ4O8F61z6c2c1atkZEVefMEqDIq6V4CeZBbh/spVkMMcGUExkOt9wzenC+WShM3JurziMDIJ/3P5ijN5YhgYflGP+2Zq08CVryeXjDtXsoO3FSB5qtkwOVTvPmCs4lgZtWF7K/C4dCq2ctmL5NYKfcGqlbd/xN2NAY698YVooYJk+DTKROYwlfOr4/dY9Jh1mcZS5+bRj9cRRjIw11SZzpS4qS4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a392c3-e384-44d8-7ea0-08d74d8b0816
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 14:06:23.0347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRk5wAop1/Bq+ohcl/xr9u44PZTWThdhl/kNxcfVWUAyxFl+g9mmy8qMDfGrdJDRIbJHJmtyjh10rAyWdBrCJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the allocation of the host memory pages array to use
vmalloc if needed. This in order to support mapping of large memory
chunks.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/memory.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/mem=
ory.c
index cec4155533af..0cce30922871 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1224,7 +1224,7 @@ static int init_sg_list_for_vmalloc_memory(struct hl_=
device *hdev, u64 addr,
 	u64 tmp_addr;
 	int i, rc;
=20
-	pages =3D kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
+	pages =3D kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
=20
@@ -1245,17 +1245,11 @@ static int init_sg_list_for_vmalloc_memory(struct h=
l_device *hdev, u64 addr,
=20
 	rc =3D sg_alloc_table_from_pages(sgt, pages, npages, offset, size,
 					GFP_KERNEL);
-	if (rc < 0) {
+	if (rc < 0)
 		dev_err(hdev->dev, "failed to create SG table from pages\n");
-		goto free_pages;
-	}
-
-	kfree(pages);
-
-	return 0;
=20
 free_pages:
-	kfree(pages);
+	kvfree(pages);
 	return rc;
 }
=20
--=20
2.17.1

