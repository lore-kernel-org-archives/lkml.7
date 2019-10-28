Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083CACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF9E20873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="N6RD9jvq";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="N6RD9jvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbfJ1LeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:34:17 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:31300
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfJ1LeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6il6sxITRdAwJfKtfV6LQsgctX++EphGt7UZmLreZ4U=;
 b=N6RD9jvq4UTZwDI0RNB4vJGstY9UYhvh5UnNP6Zve9S987Ibec/KT68rMPXhOhbuV8eN2a+F6YCjI10qUWOuPGzHiVImX9kH87+pKXOnJBqLt4mCmgapJQYJJbrMvnyngl5DjpAnkyjbaXG/F3/W8wk8+/RtfEaeWcsLHlCFoPs=
Received: from VI1PR08CA0152.eurprd08.prod.outlook.com (2603:10a6:800:d5::30)
 by AM6PR08MB5541.eurprd08.prod.outlook.com (2603:10a6:20b:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Mon, 28 Oct
 2019 11:34:09 +0000
Received: from AM5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by VI1PR08CA0152.outlook.office365.com
 (2603:10a6:800:d5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22 via Frontend
 Transport; Mon, 28 Oct 2019 11:34:09 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT018.mail.protection.outlook.com (10.152.16.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 11:34:09 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Mon, 28 Oct 2019 11:34:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 52a3f67fbbaef14a
X-CR-MTA-TID: 64aa7808
Received: from 834f1c9a4e8a.2 (cr-mta-lb-1.cr-mta-net [104.47.2.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B0A60217-3987-4A24-8B37-BDAE23795DE5.1;
        Mon, 28 Oct 2019 11:34:02 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 834f1c9a4e8a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 28 Oct 2019 11:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GURlxGHTs4z8oA3WI95ph7LiVe9ufTqPT/462/Ax5PF5QPNCyzVjVQk6VjFvgqbB5vQ6YJ5+qAsjueeu0ByJPEiMBKCgh+vUsJ1SAXW5sFART07+fVxoFI4jOzq0tVrOONhDeBuxxB3bH83sS52/mki+GQxThZQrrT7eZSbFGKkhO8BPdaar4KspX8JRL4uml55+qOHvUqdjDW5ZU5mb7gJH+jAbez2gzJlbc7sMvOVuilXU7sRO7cVAWQaNT/PgZqXqsn6dCKUwnxJoM/MXdX6bzqx89/u54YTpMi0FA5ppV6qGBs6dsyZfmAcSWaFwMykw7O2JP0kpozMfGsVBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6il6sxITRdAwJfKtfV6LQsgctX++EphGt7UZmLreZ4U=;
 b=ln5vW/NdOVMgf4dofbPlt0MDqaNBBHXD6GZnhhYhnyaBAFbfvB79tewSJ9NkRV1NA+2PBHKGNbq51U95wEVjbUN6yJjM2l0149icFPHbyzgtZNDzI606m7y4A8P8meyrFVyHhaTNdhZ5keZAI3bS9EwyIZ2lklvquYhczPIwKz64+1FNNIreZf2NjgIS2jUAqUWXK8M+7MjeFvfnIkurRfkEqCfqzZbUZQXDzCNnkciGSH8NO20LuFEJtZrLE2oRiY9oPsiQ19XU85EXpcTrtvTU+z/Rtt6zGuUSXY1TvlY8f+nEphEOoWEes2kMDxUnVSSb3Z05Cy9RNgN/cH7LtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6il6sxITRdAwJfKtfV6LQsgctX++EphGt7UZmLreZ4U=;
 b=N6RD9jvq4UTZwDI0RNB4vJGstY9UYhvh5UnNP6Zve9S987Ibec/KT68rMPXhOhbuV8eN2a+F6YCjI10qUWOuPGzHiVImX9kH87+pKXOnJBqLt4mCmgapJQYJJbrMvnyngl5DjpAnkyjbaXG/F3/W8wk8+/RtfEaeWcsLHlCFoPs=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2372.eurprd08.prod.outlook.com (10.172.218.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 11:34:01 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89%12]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 11:34:01 +0000
From:   James Clark <James.Clark@arm.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>, "acme@redhat.com" <acme@redhat.com>,
        "irogers@google.com" <irogers@google.com>,
        James Clark <James.Clark@arm.com>
Subject: [PATCH] Fixes issue when debugging debug builds of Perf.
Thread-Topic: [PATCH] Fixes issue when debugging debug builds of Perf.
Thread-Index: AQHVjYOYRLLudNMVSkWDWCd/TfiO3A==
Date:   Mon, 28 Oct 2019 11:34:01 +0000
Message-ID: <20191028113340.4282-1-james.clark@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LO2P265CA0276.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::24) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a65364fc-6ce5-40d4-8de0-08d75b9abfa7
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2372:|AM4PR0802MB2372:|AM6PR08MB5541:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB55412015A926CE0955210994E2660@AM6PR08MB5541.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;OLM:5516;
x-forefront-prvs: 0204F0BDE2
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(99286004)(476003)(8676002)(5660300002)(2501003)(256004)(4326008)(2616005)(6116002)(486006)(3846002)(54906003)(71200400001)(86362001)(305945005)(1076003)(7736002)(26005)(2906002)(6486002)(102836004)(71190400001)(110136005)(6512007)(14454004)(81156014)(36756003)(478600001)(386003)(6506007)(8936002)(66446008)(66476007)(64756008)(66556008)(66066001)(66946007)(186003)(50226002)(316002)(81166006)(44832011)(6436002)(52116002)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2372;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: P6Ro9RZkg+QZSoc3VgA58p5Vk+X8gIib5b0t2l8I8JK7e3igcnU31kic1WBJ1v+yNW8ML4Qtwco1NlP8gIoWILkQBcGelEY84ibC75ngeU+t2NO1VwTlFeyMThm9c68at9KPuOHFKT03JJcznY5ADIlomEKm4lbnj3IwnGRIIXfo0UDkgT86CyL7EHAx54nf8gzJqYMiNuLakPoc/T0fDKgpP58zlcCqrqhigQhMdEWBkzvhRD40nWLwVPL90RjpkNUrCNI+FVt/+TBIQFCEyasKHlezkxperITLzI8mxEvzMbhWKyfDMii4UpHp9JIy9mPRwdC/51P4aZeYzFbCCc3fxVJ7Jr0tpxwq8vcHomzCiVrjGdgvznw8z4UhJPaP76dHzKXFKqR+cYeruu52+qK8U1GRHpkjPVq0WXuhokuy5K3Xe+V5mS92RXJIFRdg
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2372
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(376002)(396003)(136003)(39860400002)(1110001)(339900001)(189003)(199004)(8676002)(6486002)(8936002)(81166006)(81156014)(6512007)(8746002)(1076003)(305945005)(50226002)(7736002)(4326008)(70206006)(70586007)(99286004)(186003)(336012)(486006)(2616005)(126002)(476003)(36906005)(356004)(66066001)(5660300002)(76130400001)(47776003)(386003)(6506007)(102836004)(26005)(36756003)(25786009)(478600001)(26826003)(2501003)(110136005)(54906003)(14454004)(22756006)(450100002)(23756003)(2906002)(6116002)(3846002)(105606002)(86362001)(316002)(50466002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5541;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9d8bd1c2-3fe6-4b79-5619-08d75b9abada
NoDisclaimer: True
X-Forefront-PRVS: 0204F0BDE2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXdPpnGY6Wyq1YDoUAj7xnmHE1k0T2RM4RVvg+TkWsUXsOw+khZFYQ3GMpt0/uuadYKh4nfEjG5Dn+gGNLk6iUaweOnvTxMAd/Lde2jnraUnilLCM68TTfKKvUrPti5cn11Ts6pUMQ0gZGaSUGLUrjCYfagjfSZ9BpZWxyhkXsk4cHjl0jA13PgiV7/8L1XTRU+GsYt5JgqQAE8hp2EeD3e8oj8to8Pqubmi/ql/99559NvLLqASJ1StvgP1aklWkn82ucZLhM6nO5S5+wM+gMvgeju50KLv+AlLk3WFhKcFVGvX6VtpPstcdjP7vKf7DvSKi3rzJFBm9i/h0AgUCCu8XsANfzQEK4KiAtbV4LeIU801+jyzrjrNd81E++vN9oZpangoSAYkK5Q5/1KS3SVwtHUBVQCM59HALyjDMARzMNqM7fTd14S8xeGV+hPH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 11:34:09.3834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65364fc-6ce5-40d4-8de0-08d75b9abfa7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5541
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a 'make DEBUG=3D1' build is done, the command parser
is still built with -O6 and is hard to step through.

This change also moves EXTRA_WARNINGS and EXTRA_FLAGS to
the end of the compilation line, otherwise they cannot be
used to override the default values.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/lib/subcmd/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 5b2cd5e58df0..1c777a72bb39 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -19,8 +19,7 @@ MAKEFLAGS +=3D --no-print-directory
=20
 LIBFILE =3D $(OUTPUT)libsubcmd.a
=20
-CFLAGS :=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS +=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -fPIC
+CFLAGS :=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -fPIC
=20
 ifeq ($(DEBUG),0)
   ifeq ($(feature-fortify-source), 1)
@@ -28,7 +27,9 @@ ifeq ($(DEBUG),0)
   endif
 endif
=20
-ifeq ($(CC_NO_CLANG), 0)
+ifeq ($(DEBUG),1)
+  CFLAGS +=3D -O0
+else ifeq ($(CC_NO_CLANG), 0)
   CFLAGS +=3D -O3
 else
   CFLAGS +=3D -O6
@@ -43,6 +44,8 @@ CFLAGS +=3D -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D6=
4 -D_GNU_SOURCE
=20
 CFLAGS +=3D -I$(srctree)/tools/include/
=20
+CFLAGS +=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
+
 SUBCMD_IN :=3D $(OUTPUT)libsubcmd-in.o
=20
 all:
--=20
2.23.0

