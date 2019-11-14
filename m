Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE53C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB232071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Au8RSW2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKNSYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:24:12 -0500
Received: from mail-eopbgr150135.outbound.protection.outlook.com ([40.107.15.135]:12935
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbfKNSYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:24:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmqARF6UXct+nmsY7HKZig803/I8lMwT9jJWp9jCHTyhVGGHNjexzmxaHH3BER9X4YFkZ6DQ+UEKU1poGVXD/quDh9KN0/NXdfocmsf3KU9dn19L+TWBHhbt8Oxtfjc0ea6+0g7c4c5lkZQGCftZE2KfWi/lfz1fhUIjlnMFygSymBW1O5XthhEhEs7/G58NLeQXIlOUWqNctrTFGUH7e2Z8/0MLvihE+AX8mOZjGNe0jJInZiavEPOg+v/SXWnAI/9CDBuI0bq0Ngr5g2FqCFqkOqEtD1YpB4HJKDICrMOQE485tnkh5t8k6z0Sg2d4EgFI1lZ+hKampDnVygIweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImMvV1ur4QyyHNXdBmzSDHBiX/3kyG+U5LSL4Ch55oc=;
 b=E35vBAL803Wois9ai7ynNYXpwMm7OwwlGBfyFCvKJRHlRoN133m9vmV5OD6mn9efmrk+4znn67FNZ1SpWNUJfv6pnTUnErleXPxpB8N5oDLQDlUWnRVZj4XQtfhEIj6qVNV2x+Q2SeNwEBnRs6tSFr+Dh7oEOAyX7qbSyToggbvgXHgVWtxOS3feCTWY+p+pe0Jjzr+da2l3ZFwI+33EKA9IMLBALjpK7/xV6Sr9x10MhZxNA0ihTqT9CItbBlnZq7DkJPnHQ1UTb4Ldywip8xICWAJz/+14E33/RNQ/5fDqqUnTU8K+BchikW5MfjEIXoSIqJVExVy1MfKXxsI3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImMvV1ur4QyyHNXdBmzSDHBiX/3kyG+U5LSL4Ch55oc=;
 b=Au8RSW2LMBxfSh1gcUbVzKVpqf/lYGTkt+fU+q4bfuaIhruG2l6kDd0UXXaGAUbjCHsxcphuUapFWWNuqtZ7U7lYdW5QVq1Px+DUjH5i6p9Ug82uxytXZ+wG18crydUHvfIUY4301um7IH9BCoQW6E6VzFa+QmZDrY4ECuqJ1fs=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3383.eurprd02.prod.outlook.com (52.133.29.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 18:23:58 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:23:58 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] habanalabs: invalidate MMU cache only once
Thread-Topic: [PATCH 7/8] habanalabs: invalidate MMU cache only once
Thread-Index: AQHVmxiuA86KuInPYEuknUt3NVkU8w==
Date:   Thu, 14 Nov 2019 18:23:58 +0000
Message-ID: <20191114182346.22675-7-oshpigelman@habana.ai>
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
x-ms-office365-filtering-correlation-id: 30b436a8-e275-46a5-f256-08d7692fd0d5
x-ms-traffictypediagnostic: AM6PR0202MB3383:
x-microsoft-antispam-prvs: <AM6PR0202MB33833179E14F875EC706559CB8710@AM6PR0202MB3383.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39840400004)(376002)(396003)(346002)(189003)(199004)(1361003)(6506007)(64756008)(99286004)(66476007)(66556008)(66446008)(66946007)(2501003)(305945005)(7736002)(6512007)(2351001)(11346002)(66066001)(6916009)(3846002)(6116002)(476003)(2616005)(446003)(486006)(1076003)(50226002)(14444005)(14454004)(386003)(25786009)(8936002)(76176011)(6486002)(256004)(6436002)(71200400001)(5640700003)(186003)(26005)(81156014)(478600001)(81166006)(4326008)(5660300002)(86362001)(36756003)(102836004)(8676002)(71190400001)(2906002)(316002)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3383;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5b4d59nV+yOjvDZ21tpf2aacE5ol13PZSfWGMvSGsJoJmxvSIwVzVacZ10LNGoJ1A5ZM/Dtj6H6K2bSfhojonmMeaCMVrJrlk5HhU/thEuT9s4ZiWSrTvGdCeTEGwDyW7ll2vziF83XRUm9tiFvtFragl8lK7UwAIR1HGH3TnIETzT+ZwSQ5wwwLH/KTDyzYTUbM2YAbvvhmWYvwxNR6eUolMob6XYNHqBlvYZqyWZoWo0je/tcTRdVh0W9sBYM/SxNEaBAEs9bBcFpauYVTy27np3wYu+sXyy6BWCswWy7XL8QMI81jplUW6/BkPKKmGKAKH2/+OyMNg8bxZwXvi5Xhnx9VIMcB+uxMgUYsK2XiGeixIm+TM1O8C9bQRQyEvVQQFblp3hkvrhbMNrfTCKu69AJhuEDpd0/p2S+Xc8L6yCcQew6OWu4YE6IYIHBA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b436a8-e275-46a5-f256-08d7692fd0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:23:58.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96yRLzeQXnOfhUzS2PaarkEWqi6RyOFe8dF5GJw3/DGA/IMLex8U25HDKi9WjBuldtADGAj3jK1705cd2tYYiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce context close time by performing MMU cache invalidation once at the
end of the unmap loop rather in each iteration, in order to avoid hard
reset with open contexts.
Reset with open contexts can potentially lead to a kernel crash as the
generic pool of the MMU hops is destroyed while it is not empty because
some unmap operations are not done.
The commit affect mainly when running on simulator.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/memory.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/mem=
ory.c
index be6f42749a61..fa9462ee9d6f 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1066,7 +1066,13 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 v=
addr, bool ctx_free)
=20
 	unmap_phys_pg_pack(ctx, vaddr, phys_pg_pack);
=20
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, *vm_type);
+	/*
+	 * During context free this function is called in a loop to clean all
+	 * the context mappings. Hence the cache invalidation can be called once
+	 * at the loop end rather than for each iteration
+	 */
+	if (!ctx_free)
+		hdev->asic_funcs->mmu_invalidate_cache(hdev, true, *vm_type);
=20
 	mutex_unlock(&ctx->mmu_lock);
=20
@@ -1664,6 +1670,10 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 		unmap_device_va(ctx, hnode->vaddr, true);
 	}
=20
+	/* invalidate the cache once after the unmapping loop */
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_PHYS_PACK);
+
 	spin_lock(&vm->idr_lock);
 	idr_for_each_entry(&vm->phys_pg_pack_handles, phys_pg_list, i)
 		if (phys_pg_list->asid =3D=3D ctx->asid) {
--=20
2.17.1

