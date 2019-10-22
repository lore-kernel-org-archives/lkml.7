Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E44DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40342184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="KqoxFdc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfJVGak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 02:30:40 -0400
Received: from mail-eopbgr130098.outbound.protection.outlook.com ([40.107.13.98]:50144
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfJVGak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 02:30:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rby33SIKKkRYfV4hQjqFEaS8Bi3n3h2PQC8ezAhNaYO/HhKSRE8EFk656pBVU1vepT0XROA575kHPGl6eyCZjhap/8OctL4B3oo5BCXz2WnIHsZWIUhgvqhmlM+s8OtaEHLc7+rD+6a5cgJ5OWUrN38gKtMR4PjPo2c3ZlvGzM05CaDGO6Lr/xkK8uMbNyA2icM63v3sSwpohg+oWA53gWc6KJ4ZNIBVm6GcWR6KLOYLUATUQLSGHh0ay5KlekTB3Z7fBrxTHUNp0zDRkYRtMaaazZCsgCOPPKe68vs4u5dQ7gpNhJKJrpsiIPSH+Uf9cqu7cpD3D65RRmlqy+lS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnuaqQ4bH90aBwuXL2PHM7Iwe3YHwt/LmK7HqRRRPmM=;
 b=lLGLjPTXVonHzMuWATaLX0HpqVqn2KVgMTgkCZ5tBVOsc9wo4rvdfd9bn0hh4BF/BNKtUpwi2jM8I6lkXfeOTeViyTBt4kqOWqLTuVYNFb6pxCeDtCKFUz8/G3J1WxaF9IrYSHtMwFCv33RnandgWEv19vLjC6TL4Wz2XP+LmoHWZ/bFhVxjleJjDqPrOEq0o/AM5G3Mfi1+7u0EB0j//tvGnIb0MyYBQxxSUqxWm1LUGwFUCDilW3AyvHJGUHRn8STkAKJ/l2zTYltSO2OrCYGddz2uIASzckAklmZxtl+IO7Le2scIPEBpq4b2IKJrCW+6W1Kljwdd5pC4FeCv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnuaqQ4bH90aBwuXL2PHM7Iwe3YHwt/LmK7HqRRRPmM=;
 b=KqoxFdc6Rgx9adaKRVKxCk7J7+SjDZHBkx5z7r8ivuvQOxy1NS3BfYggAe0A9GBz71HBo7UDcx/p2F7Yw65UeFCEH93hM4NU8SA3wkiLKBH5uGhiy+xSVu4oJwRXTvJmWmXbZI9V5woHBFjsjLS6H5A1hPnel6d6MRIfAlYZVFc=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3349.eurprd02.prod.outlook.com (52.133.28.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Tue, 22 Oct 2019 06:30:36 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251%5]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 06:30:36 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] habanalabs: handle large memory on MMU
Thread-Topic: [PATCH v2 2/2] habanalabs: handle large memory on MMU
Thread-Index: AQHViKI2UIDlhElzEUSZP66JEfJAOg==
Date:   Tue, 22 Oct 2019 06:30:36 +0000
Message-ID: <20191022063028.9030-2-oshpigelman@habana.ai>
References: <20191022063028.9030-1-oshpigelman@habana.ai>
In-Reply-To: <20191022063028.9030-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0501CA0054.eurprd05.prod.outlook.com
 (2603:10a6:200:68::22) To AM6PR0202MB3382.eurprd02.prod.outlook.com
 (2603:10a6:209:20::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93a85c75-f852-4053-e221-08d756b9592a
x-ms-traffictypediagnostic: AM6PR0202MB3349:
x-microsoft-antispam-prvs: <AM6PR0202MB3349657A1BCEEF8F7F47D5E7B8680@AM6PR0202MB3349.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39840400004)(136003)(396003)(199004)(189003)(476003)(102836004)(52116002)(26005)(486006)(186003)(11346002)(66446008)(64756008)(36756003)(66476007)(66556008)(99286004)(71200400001)(71190400001)(4326008)(2616005)(76176011)(2351001)(1076003)(5660300002)(446003)(6506007)(66066001)(66946007)(386003)(5640700003)(6916009)(86362001)(6512007)(2906002)(7736002)(305945005)(8676002)(316002)(14444005)(1361003)(3846002)(478600001)(25786009)(6436002)(14454004)(8936002)(81166006)(50226002)(81156014)(6116002)(2501003)(6486002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3349;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJKdapYto0rrk0gQ5niTQ5QaTUoWVQXCtRsYTXeuRT3rW334WMlIF9lRQaMgaRdmBwy80o90D4BtveoFuCcztvJn0avZ0CdYal43imTr0Ljjc5dMRCBa1XJV523lKGJnAiEqofUGpIzgjH3BEZ7HY+5haY0LLlfdcOs5IXCxLoj8qYz3mvvwQd4yUNZ1Lxl15Puks7dddcjPd5lQeTsmGBeWPapfY9M2lP3kR88H5TxOqtadDvBG37IiHqxhapsNDEogekgDz0Cdf33VTCRAl0v80NpojRSC3AJqoJpldAT3Fr/U+1C68Rxt1jtKlOUALLiQCY8OKXRS3cGpsUdPdyzngv8pKb1grNyeDOExabqzoipjXuW96zyWF9Dv8O0POw+HTv/UUowkCB7ZGJfeZ3kFWX8Iq4/SrC6SpQdFDmg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a85c75-f852-4053-e221-08d756b9592a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 06:30:36.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buksjxeOTBU85YpReaOgCvdLmN+pK1GlXVJ9pkoh2/W2yI396N4V4I7ZuazeWIK4iumBCPkRj48anSdtFNFCEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3349
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
index 552a47126567..ed3976f2198d 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1228,7 +1228,7 @@ static int init_sg_list_for_vmalloc_memory(struct hl_=
device *hdev, u64 addr,
 	u64 tmp_addr;
 	int i, rc;
=20
-	pages =3D kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
+	pages =3D kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
=20
@@ -1249,17 +1249,11 @@ static int init_sg_list_for_vmalloc_memory(struct h=
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

