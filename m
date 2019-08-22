Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84341C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5401A233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Oja8D6Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbfHVJu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:50:56 -0400
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:48278
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732342AbfHVJuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:50:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbPZvGeHzxt1gVkDp4xJ4wUHiRAAEllIdNoXcd84RbbpaknNn+FIdf0C4SnzPN4JKTdpb86KOMVFbLQfeoqd4vAAFQLzP0AujEBfcRpFdBZwXtRPeM0kV3aKtsy/ZLeeEiAZvjJ4ohJxHsuFnG5cGFft9pEALVYfSqnpF+vUUqNS254ISSphXLZbuSOKRCD4Ejedq4sA5yrWylbod7n4bLvO1jxOH9fq9BvX+cdRDnvZ8SCsFEni6VODOPRVu13kze3+CKFz6TV/vWcL2OTdkNVrCT/RJ4f5VBZfsM6Jab5GtSOCdojc26GUN2mP1od94NQqkMIEO1uXSeKW2lo+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy5NYcz3YQGqvFickTPE8rCmOxQ89LZUxr844/KmZNM=;
 b=jXQKjQMb1V33T2dDC5//hvN4fcfUWQVqz5HXmJJZ/X94snXXqfZEefOYkSQTtIgSCHO9WDIcsUKvtLJOL6FHATiDd53UAjlrTNOVmrtxZi675sxOWgKtPQ1u3q9E2rzYgUTfLzG6caA1H+FideSzcs/Auj/beJbXQI+1EdWfugXb//WWE4zf/OpO1DUfbaj8NTHh+dHxNzV+MSpa11PQay6Enm0vv5hiLX2UXjVkXe55v4YoLsqUtLb2hZpkKes2T6iFk8SOpNnyOV33mIUkrZWrWv+Fl5f90UZJwgN7D6Igv4dr3JleKK+KTivPFx6R2hteDQ/QOhlYGSq2nsBYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy5NYcz3YQGqvFickTPE8rCmOxQ89LZUxr844/KmZNM=;
 b=Oja8D6Gxo5fw8P0SP+7JnyNCltjsndk0nnkaODeo1nKSfpOgncjR4PRC7/7z50cHGBovPYlyZfH68Ur1CFfY1ERXPm3SR92l9h8zsMoPlHer/2rAaYrpmicT6QnJ8d7sby+5gvYM8bdfSxaK4kzE/3ETa0Ca/icF7YjveS1b54s=
Received: from VI1PR08MB2782.eurprd08.prod.outlook.com (10.170.236.143) by
 VI1PR08MB5343.eurprd08.prod.outlook.com (52.133.244.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 09:50:51 +0000
Received: from VI1PR08MB2782.eurprd08.prod.outlook.com
 ([fe80::2969:e370:fb70:71a]) by VI1PR08MB2782.eurprd08.prod.outlook.com
 ([fe80::2969:e370:fb70:71a%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 09:50:51 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH 1/3] skbuff: use kvfree() to deallocate head
Thread-Topic: [PATCH 1/3] skbuff: use kvfree() to deallocate head
Thread-Index: AQHVWM8UcDgw7z7BeEmDOhtfD9ZoOA==
Date:   Thu, 22 Aug 2019 09:50:51 +0000
Message-ID: <1566467448-9550-2-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1566467448-9550-1-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1566467448-9550-1-git-send-email-jan.dakinevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0088.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::32) To VI1PR08MB2782.eurprd08.prod.outlook.com
 (2603:10a6:802:19::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bb44f78-009f-4835-376d-08d726e6374e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB5343;
x-ms-traffictypediagnostic: VI1PR08MB5343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB5343E7E1FD0BEF27F4E191D28AA50@VI1PR08MB5343.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:328;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39840400004)(396003)(346002)(376002)(199004)(189003)(44832011)(66556008)(66946007)(6436002)(14444005)(256004)(53936002)(52116002)(4326008)(25786009)(76176011)(107886003)(6916009)(81166006)(99286004)(8936002)(81156014)(8676002)(71200400001)(71190400001)(2906002)(478600001)(6512007)(14454004)(36756003)(86362001)(54906003)(6486002)(2351001)(316002)(386003)(5640700003)(26005)(3846002)(186003)(102836004)(446003)(2616005)(476003)(6506007)(11346002)(6116002)(5660300002)(4744005)(7736002)(50226002)(66066001)(486006)(305945005)(66476007)(2501003)(66446008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB5343;H:VI1PR08MB2782.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L04JlDRMDVcS6ZUB1vNLlagk+4RDN54O8AguN1C989Mss3CcwS3giOEVucUN2CDlfZEV9DNKHAutegyZYq1adBO1V8GP7aZJ9WVj/f7cPSgiTWk6rWPx8d4H6J3ZvRqMB+DHjzATWXXXCD5R3d9F+sUuwxIHGv0qrlIOPrGJ44uCeKhScQTr9feafGkhXsXfjvNrXo46mkBLmqLQgOihyFFrnht14KECR3M/3Cz+w6x9bQZaK0m2f+UiSF7EoNEIcMtlLVtcYSBIFdxG3U8iAicKExUmRwUkmX5Uj7TU1ltmAOEhMCpFIFyNr9h8biHDlcUgG3AGiQlANRdHwJ8njLo5LQXzqROrt76KVwuCT/cou/nT0LWJHveKO560gLhUseQGoha7FqW2z4P3zeydykGQJ84zXNq21nsdrIEN3jY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb44f78-009f-4835-376d-08d726e6374e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 09:50:51.0529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bl/np7G5nIV8H8z3NEg1QC6jVDS7UQOHZ8Py868yKpVM+idtkPBqFDLkVFIIHjbRSKj73ReLKV4zeVE7uI+FufYdDDPth9o3whd3b23ZYqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If skb buffer was allocated using vmalloc() it will make simple its
further deallocation.

Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0338820..55eac01 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -588,7 +588,7 @@ static void skb_free_head(struct sk_buff *skb)
 	if (skb->head_frag)
 		skb_free_frag(head);
 	else
-		kfree(head);
+		kvfree(head);
 }
=20
 static void skb_release_data(struct sk_buff *skb)
--=20
2.1.4

