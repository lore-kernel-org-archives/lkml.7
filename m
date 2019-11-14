Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C84CC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE2320709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="rK1RCvSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfKNSYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:24:09 -0500
Received: from mail-eopbgr150135.outbound.protection.outlook.com ([40.107.15.135]:12935
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbfKNSYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:24:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTM8OAU/r22fFxnBwkbtHem04B7y4AE9oNl6dWjkF40Sv3fjTuTxZyhJ94ZUzslIt9zT2MhYbUSgwvCXI0SXNMDR2+LD6Q4b420f2bpKmhvfa4A3sPpGHjfXk0xXyXypADipWondtKkB+7KCOvY/jYw/56hWXRAoojAGYTvqkYm3xOXtn+hcDUrZyMexaKFd0BjthuuCUIFueXJ8VvsP/+hfScr4Aq9lTHfdkezV1I++jsRUi473ZIOg23QAyXklT/GEgsb5F+PytLEAxS3rY+Dn8HFH4cP202wWbFBB+8bB62muLwE7en5Q9tyjZfFvp9WzHpHrLceMuA30oqgXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ6yEoxFAgRpeyXE7+g3U/MJoyIVqBWav/HcOaH6sn8=;
 b=Gt8NNRsP5fjGMGsCcEARx0I1JlGguttzOLrBYcYOGThtG8sAPT33t+Gy11Uu0/9rYcftpbLO0sZtTPEz1XXwv/6gXx6V8nnCFf+ydLZdh87mpCwPMyDS0zz/om0Kb+p44S8soMV8+YjjZF5zuo2fBTH8UxXSdTyK529aYMHHl54plB66tG3VOc5XxLkls3LOOvCwPnBU5fd1wEkJc5xDH+Yas5yQiX2cuM8w7C+OWCe38wzz1qSMdNkhdbZUKFMVLw1t6pZiuXUHZA1hbKTpkzZgUFPQwgs93ey87vDtPmsgX3eRMUGqIj6t9rRdDPu1D5OmEyV2pcsgtxK1FhFieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ6yEoxFAgRpeyXE7+g3U/MJoyIVqBWav/HcOaH6sn8=;
 b=rK1RCvSH/lkO2Yo23fbF99YTd+HQjciBrRVGo8BSP7hHdtP1Uk/JcPi9vYvHo30pIEgyA1A8n7tV9th09Pi7b1DwjL87rzxg+FDoxsqYlo0vPu79PE+YgtuI2F3vkjvHxLxScvb5TU773nX/t6iGNM8EwAgJRpnDSOuD+wsN4C4=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3383.eurprd02.prod.outlook.com (52.133.29.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 18:23:57 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:23:57 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] habanalabs: optimize MMU unmap
Thread-Topic: [PATCH 5/8] habanalabs: optimize MMU unmap
Thread-Index: AQHVmxitSJusm6cdykSOEqlkGV9AMg==
Date:   Thu, 14 Nov 2019 18:23:57 +0000
Message-ID: <20191114182346.22675-5-oshpigelman@habana.ai>
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
x-ms-office365-filtering-correlation-id: 3a874ca4-fb6f-409a-54ca-08d7692fcff3
x-ms-traffictypediagnostic: AM6PR0202MB3383:
x-microsoft-antispam-prvs: <AM6PR0202MB3383D8960712FBE17DA5F0ADB8710@AM6PR0202MB3383.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:303;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(189003)(199004)(71200400001)(6436002)(5640700003)(81166006)(26005)(478600001)(81156014)(186003)(386003)(25786009)(8936002)(14444005)(50226002)(14454004)(256004)(76176011)(6486002)(71190400001)(8676002)(102836004)(2906002)(52116002)(316002)(5660300002)(36756003)(86362001)(4326008)(66556008)(66476007)(66446008)(1361003)(6506007)(64756008)(99286004)(6512007)(7736002)(305945005)(2501003)(66946007)(446003)(1076003)(486006)(2616005)(476003)(6116002)(3846002)(11346002)(2351001)(66066001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3383;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r6Z9aBXDrkBwfGbTEdDW8HQ8WHEiX1yxOPFVFKb/AdJQRhnpz5mZu6rcBSY+iPnEL736LsY+cgYYWQEW+XeaE/SO9BXb3p8kkqyhiWO8fsbctpl3ELtSdmZALuZBtq5tWrCt9BCl8OirfNZcPE6IwdDE/vT0T/BPVnKPB6H9E02tfr4OE6Lnzcfp//zTUdmomKgL+kwBZC27Ma/xv+CGF8730FGcIUd+IOe4eEgTubys7W8hYFMR2qWITPn7r9/W0GQusr4AEPLeEiD5YrD2IaNpG81lcmJFiu8QQiddFHa9gq6B1+t4N0QZKETlQ3pR9sISdz5a12BshUDgtBtzWDw7//AzboG/rKVmL1YC3g2zshnQJ5NRJkcVi4rTvxDM/xpP49ruRo5F8ajpISRtmJXrcS0MwITReSuaqtPkZceLCmE3RQoRJQXmKz8APtRP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a874ca4-fb6f-409a-54ca-08d7692fcff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:23:57.2712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSTyhWpjfo2k5hsxsbozaq2TrX6wGwtNBRBY8ExeHgdTeB7X3GkfCCMlJPU1oQJRYPIaALZ24EWpPQqbEHx6fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce context close time by skipping hash table lookup if possible in
order to avoid hard reset with open contexts.
Reset with open contexts can potentially lead to a kernel crash as the
generic pool of the MMU hops is destroyed while it is not empty because
some unmap operations are not done.
This commit affect mainly when running on simulator.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/mmu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 3a7f8ff19eb2..6262b26e2086 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -25,10 +25,9 @@ static struct pgt_info *get_pgt_info(struct hl_ctx *ctx,=
 u64 hop_addr)
 	return pgt_info;
 }
=20
-static void free_hop(struct hl_ctx *ctx, u64 hop_addr)
+static void _free_hop(struct hl_ctx *ctx, struct pgt_info *pgt_info)
 {
 	struct hl_device *hdev =3D ctx->hdev;
-	struct pgt_info *pgt_info =3D get_pgt_info(ctx, hop_addr);
=20
 	gen_pool_free(hdev->mmu_pgt_pool, pgt_info->phys_addr,
 			hdev->asic_prop.mmu_hop_table_size);
@@ -37,6 +36,13 @@ static void free_hop(struct hl_ctx *ctx, u64 hop_addr)
 	kfree(pgt_info);
 }
=20
+static void free_hop(struct hl_ctx *ctx, u64 hop_addr)
+{
+	struct pgt_info *pgt_info =3D get_pgt_info(ctx, hop_addr);
+
+	_free_hop(ctx, pgt_info);
+}
+
 static u64 alloc_hop(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev =3D ctx->hdev;
@@ -159,7 +165,7 @@ static inline int put_pte(struct hl_ctx *ctx, u64 hop_a=
ddr)
 	 */
 	num_of_ptes_left =3D pgt_info->num_of_ptes;
 	if (!num_of_ptes_left)
-		free_hop(ctx, hop_addr);
+		_free_hop(ctx, pgt_info);
=20
 	return num_of_ptes_left;
 }
@@ -516,13 +522,14 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 	dram_default_mapping_fini(ctx);
=20
 	if (!hash_empty(ctx->mmu_shadow_hash))
-		dev_err(hdev->dev, "ctx is freed while it has pgts in use\n");
+		dev_err(hdev->dev, "ctx %d is freed while it has pgts in use\n",
+			ctx->asid);
=20
 	hash_for_each_safe(ctx->mmu_shadow_hash, i, tmp, pgt_info, node) {
-		dev_err(hdev->dev,
+		dev_err_ratelimited(hdev->dev,
 			"pgt_info of addr 0x%llx of asid %d was not destroyed, num_ptes: %d\n",
 			pgt_info->phys_addr, ctx->asid, pgt_info->num_of_ptes);
-		free_hop(ctx, pgt_info->shadow_addr);
+		_free_hop(ctx, pgt_info);
 	}
=20
 	mutex_destroy(&ctx->mmu_lock);
--=20
2.17.1

