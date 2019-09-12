Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA20CC4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1A92081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JEmzmKD2";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JEmzmKD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbfILOzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:55:25 -0400
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:24269
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732729AbfILOzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x0KNH2yEPCuBYU/BfEtS1uGVAIv/XvLPZIwHH2ouH0=;
 b=JEmzmKD2TDOJdj63P5DW3GysJKljGM4HK09BprV+68XYfFu/YfkrlyvmirTYBRGPePvZ3n9Fhk1+r9+OWIK09o6r5daPPp/ljyTFgUUL/RHzhov/wQLL8VXbnX25DVqcd4sM+C9G4DcX9T8G1tTKscprSWQ44rA+rTI2YPhB2Uc=
Received: from HE1PR08CA0061.eurprd08.prod.outlook.com (2603:10a6:7:2a::32) by
 DB6PR0802MB2248.eurprd08.prod.outlook.com (2603:10a6:4:85::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Thu, 12 Sep 2019 14:55:17 +0000
Received: from DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by HE1PR08CA0061.outlook.office365.com
 (2603:10a6:7:2a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15 via Frontend
 Transport; Thu, 12 Sep 2019 14:55:17 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT060.mail.protection.outlook.com (10.152.21.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.14 via Frontend Transport; Thu, 12 Sep 2019 14:55:16 +0000
Received: ("Tessian outbound 96594883d423:v31"); Thu, 12 Sep 2019 14:55:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9eed926c5887bec2
X-CR-MTA-TID: 64aa7808
Received: from b92be0c61732.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5FF63C5B-A65C-4D27-B9CD-4FCCD85B947E.1;
        Thu, 12 Sep 2019 14:55:10 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2051.outbound.protection.outlook.com [104.47.6.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b92be0c61732.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 12 Sep 2019 14:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGAuCegEUEsI8OXG9swE2pV5zaFysQPQktuGqoWWS3cxouC3rmwNFWLBc8EGgPiJPJuxpPQwFtujAubVr0/iF2Wnrz5cqPTp0iV/myhuziFNRjV2zRu78BnBXQugrUyFLsz6S97O2ky1K2YZbOywZ9WuHnp7Uwm/1fBPg9zIONTb+9A4tGVpSKvV9rKoO9qm3VhdJFaT1LUmLUOClFQBav8mSM5OdSzAQcTBI+W35NdU4UCHqJdd4hHFXByGMkE1xsiE2/xDtRWZ2EerUE+eUT72HLE1Z5H5Bec3z9fP7AHd8YEtq9JCMb9mlTZAH5jnmOuh6hChUG5ROCj7xsEZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x0KNH2yEPCuBYU/BfEtS1uGVAIv/XvLPZIwHH2ouH0=;
 b=HT+b3VQ/kmo4A6xq3X/JG7Vh9CkW9uFF9T5mrUpgtGIyHBGZtsBNHqZGh3TpYO13zyLWAez14Xp1RZK18vtEN7CThs+YlHlUEOKKrnhMZNO5GxVd/DSwP8idPGmPza+IAN2YoHaQ2XOFI3w5zQ9YgIC3Xp/7uSDwULKBWzul8IhDbW8ynuyKhuNYtjKVhsuGtDer6B4gKCibXn90ohDIfqh9Mf65oxCJgS5U0fw8MQwcStjJIXALcbAJW5+shRrlXY4apHYRdT1vY4rc+M66/Zvn8Dbc3+meBvenuuay4NSAUCcN4Gp+tFL18Ge0hbgCj2jSj0SzYdfG1wAi4RlZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x0KNH2yEPCuBYU/BfEtS1uGVAIv/XvLPZIwHH2ouH0=;
 b=JEmzmKD2TDOJdj63P5DW3GysJKljGM4HK09BprV+68XYfFu/YfkrlyvmirTYBRGPePvZ3n9Fhk1+r9+OWIK09o6r5daPPp/ljyTFgUUL/RHzhov/wQLL8VXbnX25DVqcd4sM+C9G4DcX9T8G1tTKscprSWQ44rA+rTI2YPhB2Uc=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.172.255.7) by
 VI1PR0802MB2351.eurprd08.prod.outlook.com (10.172.14.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 12 Sep 2019 14:55:08 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::c111:a196:e33b:a90f]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::c111:a196:e33b:a90f%7]) with mapi id 15.20.2263.015; Thu, 12 Sep 2019
 14:55:08 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     nd <nd@arm.com>
Subject: [PATCH] lib/lzo: fix alignment bug in lzo-rle
Thread-Topic: [PATCH] lib/lzo: fix alignment bug in lzo-rle
Thread-Index: AQHVaXoSvLu3L9byUkuHb4wcO7CSFQ==
Date:   Thu, 12 Sep 2019 14:55:08 +0000
Message-ID: <20190912145502.35229-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::27) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:ad::7)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-arm-no-footer: FoSSMail
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c66a8fdd-e47e-475f-bc6a-08d7379138ea
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0802MB2351;
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2351:|VI1PR0802MB2351:|DB6PR0802MB2248:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2248CC8EDD75E3787A58839D8FB00@DB6PR0802MB2248.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:138;OLM:138;
x-forefront-prvs: 01583E185C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(189003)(199004)(66446008)(66556008)(64756008)(66946007)(66476007)(66066001)(186003)(71190400001)(53936002)(52116002)(508600001)(102836004)(26005)(3846002)(6116002)(110136005)(71200400001)(14454004)(305945005)(7736002)(316002)(2906002)(5660300002)(6486002)(6436002)(4744005)(2501003)(256004)(14444005)(86362001)(2201001)(36756003)(1076003)(4326008)(476003)(486006)(44832011)(25786009)(386003)(6506007)(2616005)(8936002)(6512007)(99286004)(8676002)(81156014)(81166006)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2351;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: fhyjUbTi6M8TvgZR/SHakGXe6bD4YosutnDEYpFSLLir8rBfz3D0k/3b1bAj2wmqMj1wjszrx9ez9nHXA8O3gJsI0zl/v7BTh+4pyj81ON9eLp75YPfGuH/44cRHzPMCw+17e+cQSOBJMyF77DzbQa3+Q9oDeI4NUrGbwq494h5Lup9Rxc7sHwTaf14yuvfxz4UKZbNQquLvhzdR2ZcPbicnK8Snbivhgtd0XivJJ8ueKbB4l2uY2egRcyR2u1VIK0NwZfELoC4DXSN+mAbsYYl86441Q0sDz/3Q7RX7KjB0Qv2+qVzy4vZqyjeHqG4uHxux7E4+Il1+flK20a6YDIZm34olZ4+naqDeSE834+3/27efKMAdyAjL2GTbra5Dg1OUKyaMEJjC2dqtg3WkuEIBOkB6OWKS42SmDHS+Ncg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2351
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(70586007)(70206006)(8676002)(81156014)(81166006)(8746002)(8936002)(50226002)(22756006)(6512007)(356004)(47776003)(316002)(5660300002)(26826003)(66066001)(76130400001)(110136005)(14454004)(126002)(476003)(14444005)(26005)(186003)(23756003)(86362001)(50466002)(3846002)(99286004)(102836004)(7736002)(508600001)(6506007)(6116002)(336012)(63350400001)(305945005)(386003)(25786009)(2501003)(44832011)(2616005)(2201001)(36756003)(6486002)(1076003)(2906002)(4326008)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2248;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 35b0707a-d0c4-4f2c-3a43-08d73791346b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR0802MB2248;
NoDisclaimer: True
X-Forefront-PRVS: 01583E185C
X-Microsoft-Antispam-Message-Info: JVs9FxuJLQfq7sTUZy8dY0AshHhJ9BWKm36Ti+xqA1CMcnkafojTQbIJq8yKLzYuFc41QpZ+zRE73eh+hSvXdauLf/PkIUSnshIdifH6nopfsxT6P0nUZ57kt7ZFaR7foB7//pPmJdYejG0blkChyV914tDi7rDZuWH4l61399LAFxRsRtmZ8kAMP3kUwOhqB0nR6qQewW4uVLrDJdrmhgI39VS8CfaV93zl15q6PVrGbABqn+do+/2Q8JKADchrYzkH36HPAlkW2JLRo0kWyVmyzvUeJsAHvm7tfm9daDKw0LzT1d5IadgH1q5+OzwKgB2yzPhFYcWwOox/HqjiownNeEtR0GCL98KUiq+58yqfrogMdkO7skZw6oerEiJqWFIP130RVXC9MhquxqAb7lhK95T8d8AlsetNhJATlnE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2019 14:55:16.0342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66a8fdd-e47e-475f-bc6a-08d7379138ea
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an unaligned access which breaks on platforms where this is not
permitted (e.g., Sparc).

Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
---
 lib/lzo/lzo1x_compress.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 4525fb094844..3ea7b93596c6 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -82,17 +82,19 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_=
len,
 					ALIGN((uintptr_t)ir, 4)) &&
 					(ir < limit) && (*ir =3D=3D 0))
 				ir++;
-			for (; (ir + 4) <=3D limit; ir +=3D 4) {
-				dv =3D *((u32 *)ir);
-				if (dv) {
+			if (IS_ALIGNED((uintptr_t)ir, 4)) {
+				for (; (ir + 4) <=3D limit; ir +=3D 4) {
+					dv =3D *((u32 *)ir);
+					if (dv) {
 #  if defined(__LITTLE_ENDIAN)
-					ir +=3D __builtin_ctz(dv) >> 3;
+						ir +=3D __builtin_ctz(dv) >> 3;
 #  elif defined(__BIG_ENDIAN)
-					ir +=3D __builtin_clz(dv) >> 3;
+						ir +=3D __builtin_clz(dv) >> 3;
 #  else
 #    error "missing endian definition"
 #  endif
-					break;
+						break;
+					}
 				}
 			}
 #endif
--=20
2.23.0

