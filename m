Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B63C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FD52071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="pZajZWDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKNSYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:24:23 -0500
Received: from mail-eopbgr150108.outbound.protection.outlook.com ([40.107.15.108]:50913
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727582AbfKNSYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:24:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2hlIYxgpjxCvwSbOUS5uV6xNFTFwnNCSD5ErnQTpXzHbrrEhpDZqtBeHRtioWmRe3FE4X0flpDvQ8NfRvGH54TpFYCxJRhK6p2F4lPHKTbq/CRah5U4KGPhXhanCKfFrwppq5ub9O6CN+bvedKxwLygO7Ifw/liGJiIhL6DsQ8Apm4UmLScmY1cyzGZtg/zABrjM6hH4ZjVy3+yJbwRYNW29dqH+3Bz7V/D+MRchRWJR4592G2LRCEQKL+Q4mjua9FqrDHvvAWh/glIP/+1aDU8qqp5e2tHDPOLP0uoCNCCPnXbJwkhUzaVI47whF70zmP+LD0NnbprV/bG0TgyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df+BC9lsG0s7TDvA0RnS2COhPKAinXPXVkcqOvWbO7s=;
 b=XB0jse2HpHFGLgoQ57feY6mhb1LqykORGkvbqIugc/+wP4pw/dJHzb4hcIh98wXXJf8M/bRAYahmqFn8lgZpSUSiAjP4Pha9M9y2j8PAxGYUWoM5gkV5LKlkzedAmIyFG8AWKrHG+Xp3xCfUxMycXT7QFNKle9QfTwWTMtVSTzECuoUnqr2ZdQzR7K+kzv+5w6XekCEzCbofTdZ9CklmuuXi8iryXz1lnxD+26TJigu1nlWlqb9tO0KcJpU6+jqo9Cpe5o4glSk0U8CHgTCkQiDzcCiQhhWUQ8d4ioY5pwntbwg4wwgVAzVu6IXgFjYUq5nCm6lJr6dj82B4feNRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df+BC9lsG0s7TDvA0RnS2COhPKAinXPXVkcqOvWbO7s=;
 b=pZajZWDNApktJqRuHQjUOdeGtsagh/QBE7NJSt7i7rBdMVZ3AR+OZ+VGGDsItqvu7SnX5xwKok+jUW8uc61B+rpGqvJt0lnKfvw9lnxiuVHReyAp32PnoOSwpRF6e8DSAXtstlnAqK5ZknbOOpYRsFfauVHvDrZiP0dfHTW/6Pc=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3383.eurprd02.prod.outlook.com (52.133.29.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 18:23:59 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:23:59 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] habanalabs: remove unnecessary checks
Thread-Topic: [PATCH 8/8] habanalabs: remove unnecessary checks
Thread-Index: AQHVmxiugmGcOGBm+Ea2f4Vu8lk6DQ==
Date:   Thu, 14 Nov 2019 18:23:59 +0000
Message-ID: <20191114182346.22675-8-oshpigelman@habana.ai>
References: <20191114182346.22675-1-oshpigelman@habana.ai>
In-Reply-To: <20191114182346.22675-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:208:15::20) To AM6PR0202MB3382.eurprd02.prod.outlook.com
 (2603:10a6:209:20::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 465bb8c9-968f-4c50-93aa-08d7692fd145
x-ms-traffictypediagnostic: AM6PR0202MB3383:
x-microsoft-antispam-prvs: <AM6PR0202MB33838281C2459AC7C39A47F1B8710@AM6PR0202MB3383.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39840400004)(376002)(396003)(346002)(189003)(199004)(1361003)(6506007)(64756008)(99286004)(66476007)(66556008)(66446008)(66946007)(2501003)(305945005)(7736002)(6512007)(2351001)(11346002)(66066001)(6916009)(3846002)(6116002)(476003)(2616005)(446003)(486006)(1076003)(50226002)(14444005)(14454004)(386003)(25786009)(8936002)(76176011)(6486002)(256004)(6436002)(71200400001)(5640700003)(186003)(26005)(81156014)(478600001)(81166006)(4326008)(5660300002)(86362001)(36756003)(102836004)(8676002)(71190400001)(2906002)(316002)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3383;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ve5oUy4dAJI4poA/3Nna/NlGhAHygN24MbyKBUjYisfjRxvCJTH5QhOey0OwalWVmU3nr9F2CUHRhe6zui8NnnhehdN+6ETMij/8lcw8HRLlHUsGuhgmc77n9EpPd5XfhCreSN+PgsoXRuTkknamC9snz1ogjwgIP2Qe8N1z0SVA+xwoYntXhnGXljzcC4fHdnhWOT6C2606Avap+c2laees8KNbZ5oTpeeY55V7JPQpegudnP3m0+2VEURgRBEEB/FwxTyp+3zGQfg4kSpUXl66hb/3VAcKRmAMg9mL490/Zrq+rK2ZphFq3td8UCjrR+HjbAwhAz0u1SFpVjTQZEb2vWcCi4yWFiwtcFfYjutaK/ASxusWEbVUJ3z9GCZKRIfcovsacG29Wt7eyab1CqhzLypJLP2p6u9HdxbbcekmFhyCrL9rmPAUfDRm47Yp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 465bb8c9-968f-4c50-93aa-08d7692fd145
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:23:59.3500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mX7J9Tp5X4pmK7akt/eenAeglgQl3F3fy0mM8ohDkeLwN2Y4PIuosbwhaLn7b80bx1rdH7iZ2Dn5RZCkGwA1uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the VA block free list is not updated on context close in order
to optimize this flow, no need in the sanity checks of the list contents
as these will fail for sure.
In addition, remove the "context closing with VA in use" print during hard
reset as this situation is a side effect of the failure that caused the
hard reset.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/memory.c | 40 +++++++-------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/mem=
ory.c
index fa9462ee9d6f..b009ac4c62c0 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -544,7 +544,6 @@ static u64 get_va_block(struct hl_device *hdev,
 		/* calc the first possible aligned addr */
 		valid_start =3D va_block->start;
=20
-
 		if (valid_start & (page_size - 1)) {
 			valid_start &=3D page_mask;
 			valid_start +=3D page_size;
@@ -1589,43 +1588,16 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
  * @hdev                : pointer to the habanalabs structure
  * va_range             : pointer to virtual addresses range
  *
- * This function initializes the following:
- * - Checks that the given range contains the whole initial range
+ * This function does the following:
  * - Frees the virtual addresses block list and its lock
  */
 static void hl_va_range_fini(struct hl_device *hdev,
 		struct hl_va_range *va_range)
 {
-	struct hl_vm_va_block *va_block;
-
-	if (list_empty(&va_range->list)) {
-		dev_warn(hdev->dev,
-				"va list should not be empty on cleanup!\n");
-		goto out;
-	}
-
-	if (!list_is_singular(&va_range->list)) {
-		dev_warn(hdev->dev,
-			"va list should not contain multiple blocks on cleanup!\n");
-		goto free_va_list;
-	}
-
-	va_block =3D list_first_entry(&va_range->list, typeof(*va_block), node);
-
-	if (va_block->start !=3D va_range->start_addr ||
-		va_block->end !=3D va_range->end_addr) {
-		dev_warn(hdev->dev,
-			"wrong va block on cleanup, from 0x%llx to 0x%llx\n",
-				va_block->start, va_block->end);
-		goto free_va_list;
-	}
-
-free_va_list:
 	mutex_lock(&va_range->lock);
 	clear_va_list_locked(hdev, &va_range->list);
 	mutex_unlock(&va_range->lock);
=20
-out:
 	mutex_destroy(&va_range->lock);
 }
=20
@@ -1660,8 +1632,14 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
=20
 	hl_debugfs_remove_ctx_mem_hash(hdev, ctx);
=20
-	if (!hash_empty(ctx->mem_hash))
-		dev_notice(hdev->dev, "ctx is freed while it has va in use\n");
+	/*
+	 * Clearly something went wrong on hard reset so no point in printing
+	 * another side effect error
+	 */
+	if (!hdev->hard_reset_pending && !hash_empty(ctx->mem_hash))
+		dev_notice(hdev->dev,
+				"ctx %d is freed while it has va in use\n",
+				ctx->asid);
=20
 	hash_for_each_safe(ctx->mem_hash, i, tmp_node, hnode, node) {
 		dev_dbg(hdev->dev,
--=20
2.17.1

