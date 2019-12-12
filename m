Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4986DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A19622527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dM+ynWl8";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dM+ynWl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfLLH2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:28:12 -0500
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:29346
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728052AbfLLH2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GShXzcxC2k/K5I6YlZvkw74prrKjN3Y5mFl7f8tKYpY=;
 b=dM+ynWl8i87x9GSO1I0+6D/r0eqylU7qDGq/sp8nh4l+nMaPqg9Q4uqvGInhBCyycT+jamP12qn1qc+qzsYf7T25oN8atygv80B6zRbxTqBPKLA/GTEaLJQ31l3ONwPrArBC8vV9ai8JLwAY6gBmMDmQfibr6r3SF77pidb1WEA=
Received: from VI1PR08CA0107.eurprd08.prod.outlook.com (2603:10a6:800:d3::33)
 by AM5PR0801MB1635.eurprd08.prod.outlook.com (2603:10a6:203:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.16; Thu, 12 Dec
 2019 07:28:06 +0000
Received: from DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR08CA0107.outlook.office365.com
 (2603:10a6:800:d3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Thu, 12 Dec 2019 07:28:06 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT012.mail.protection.outlook.com (10.152.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 12 Dec 2019 07:28:06 +0000
Received: ("Tessian outbound 5574dd7ffaa4:v37"); Thu, 12 Dec 2019 07:28:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7b85e8732cd7b7cb
X-CR-MTA-TID: 64aa7808
Received: from 4574cc9b9828.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CF913403-6482-4999-ABDE-C833EAA97C4E.1;
        Thu, 12 Dec 2019 07:28:00 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4574cc9b9828.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 12 Dec 2019 07:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZhcKYTFG+hCZhvWg1H5TRGHNSQZYLCT3ccPY0CY4/f4bncQGf0qRn+w3DJRi57wt48oEm+3qMHMuO7BZ3nZfHweWmVDczwdd1QgYWZn5LYWQ19P/7tgNznHcWLmbGc0XTrZ0nz7ZJpKoP1C/t4/4G5yge0LkdThMCAfb1wN0y9T5RQgH+jbcw6I5m7sharW7Volvxya8LUp/+91biRY9FxLepOxma0BrQZgl5+w/r3DWY3KaOp/76eHvWReLLUgA6Fr7OQ8H3NWZ6XKmI6+PbfP+2LAWdym8yn2P5n/VBJeqziyDHJj4xKSKzuCkCjNIooH1EOMivbU/B78/V2mfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GShXzcxC2k/K5I6YlZvkw74prrKjN3Y5mFl7f8tKYpY=;
 b=CjZ85I6mcLBxzWgf0gs/+FTQR8/Jndqr+j/Wdw1Co11zW5SoF0u3pKe21Y+Oi00eViY+UzNjrsrCZ+d1M6YcOzYtbiggVwHqh1bEoN5WI1u6TxuKEK5gjJPmR4UbOLXAbsBBwJ8WgPTX4wMMlr4DboDf20yuwoQ0ZMHCq6VwrDpAXBzsf79NcNVHrS+dV47WuNvm6Qe3+1Kbf31WLY/e5cMpdWEteRU6azvyuY0X0ukAO/ab9cgBl1qT0sUDkPs4xFkqbb8x0jq1XsXLjvdcTpoOOaY6r/rAZfCwqTjcNgTGFWEjMBZcZIU7PEREeRE8Hj9AOb7bhn8xgj9w/Jzjyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GShXzcxC2k/K5I6YlZvkw74prrKjN3Y5mFl7f8tKYpY=;
 b=dM+ynWl8i87x9GSO1I0+6D/r0eqylU7qDGq/sp8nh4l+nMaPqg9Q4uqvGInhBCyycT+jamP12qn1qc+qzsYf7T25oN8atygv80B6zRbxTqBPKLA/GTEaLJQ31l3ONwPrArBC8vV9ai8JLwAY6gBmMDmQfibr6r3SF77pidb1WEA=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4734.eurprd08.prod.outlook.com (10.255.112.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 12 Dec 2019 07:27:56 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2538.016; Thu, 12 Dec 2019
 07:27:55 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH] drm/komeda: Add event handling for EMPTY/FULL
Thread-Topic: [PATCH] drm/komeda: Add event handling for EMPTY/FULL
Thread-Index: AQHVsL2rU4ctbxXpak2vHcPGkTYTbw==
Date:   Thu, 12 Dec 2019 07:27:55 +0000
Message-ID: <20191212072737.30116-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c006cd02-0836-4e2d-13fb-08d77ed4d4ca
X-MS-TrafficTypeDiagnostic: VE1PR08MB4734:|VE1PR08MB4734:|AM5PR0801MB1635:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1635429A10EE9653956DC600B3550@AM5PR0801MB1635.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;OLM:5516;
x-forefront-prvs: 0249EFCB0B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(478600001)(52116002)(6862004)(54906003)(55236004)(4326008)(36756003)(86362001)(316002)(186003)(26005)(6506007)(6512007)(2906002)(81156014)(8676002)(6486002)(71200400001)(66946007)(37006003)(1076003)(103116003)(6636002)(2616005)(66446008)(5660300002)(64756008)(8936002)(81166006)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4734;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: b5uB4U1+fv95fLqlr4qp/rWmOPr966dZq/s3rfwqwI3Xyogh1a1cuOKsRZ2dUnG3WsuBjTSFG9KC9d1t/ZYcaWx0Hn6jLUeyNPapZ/Zowrd7ePg5yXi/aeax7eQj4Aw6QFjCnFESc693zfZWYRk6KdgEPPkTEXrxYiniSzutjsxU51OnPn6T2p8LiIl3wWJansuVmyc4gJYVETlgaeyQFkw13n1+yKSI+iJlyeuUoRzDJUecax4g8WJjJy1wm2rKa5XCFEKRfsmmojqOGYv+TGkwF7fyuowQIoG9PZiJxIqP4BTcDe/fMRcjWmLk9Hy8oKoQPOkr6qpNIMvGHxR5KjWKT4yL1TjxkvVpx39Eb0vMtkPeilQHD77LJT9d88ak6rw/IQqVVKgCZLchs0onn/YX6QOQnNU6tjMGiZjhjKfG7mQvsBdp9kbZLkqbq+pK
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4734
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(186003)(2906002)(70206006)(1076003)(6486002)(8676002)(316002)(8936002)(70586007)(336012)(6862004)(26005)(81166006)(2616005)(37006003)(356004)(36756003)(54906003)(6506007)(4326008)(5660300002)(6636002)(103116003)(478600001)(6512007)(76130400001)(26826003)(81156014)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1635;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 827c85cc-b7a7-48e2-ba96-08d77ed4ce40
NoDisclaimer: True
X-Forefront-PRVS: 0249EFCB0B
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soluRlVh/wPJrhLHZTbUg9Dx69kLJiqCfX824dN71oZX1Fe0N2HmjdDkfOtmag7zNIuiRv4xrA2A6zwgLgJ1L/3i5dFk0B9dLkNn/Mz01WaGWsQsJAhTgxLbRQOd7tJE0iV9QHFkA60qN3JSn1AUv5dDjpczWt+rceon1omg3hrLOBTB4oRrTYQBaoZ+N802BNcbXaCzl6eNPm+0NY+1QP5sV2/otgTKHwIESPY9mEtlnyU6BaPhNQ73sGybOUxOeoj7Je0NfqWSJLxiWmXlLUxptPxQ7vU8SmDlZSY2jscQA+G6W1TOe3c2ae5XqfuZyAaxif+YGpDCvnRpI79BJrYoXA8PNr7Oi9NpZH5D9mKIfOUhdx1guEh3BKvKjTTipuXFtOgZZhvgZZoUYKq60qPpCB18JGBHgR8P3MRG2BVwq409XCWnXUfWCkiW2NCw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 07:28:06.3843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c006cd02-0836-4e2d-13fb-08d77ed4d4ca
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EMPTY/FULL are HW input/output FIFO condition identifer, which are
useful information for addressing the problem, so expose them.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c  | 13 ++++++++++++-
 drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h |  3 +++
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   |  5 ++++-
 drivers/gpu/drm/arm/display/komeda/komeda_event.c |  2 ++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index dd1ecf4276d3..00fa56c29b3e 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -20,8 +20,10 @@ static u64 get_lpu_event(struct d71_pipeline *d71_pipeli=
ne)
 		evts |=3D KOMEDA_EVENT_IBSY;
 	if (raw_status & LPU_IRQ_EOW)
 		evts |=3D KOMEDA_EVENT_EOW;
+	if (raw_status & LPU_IRQ_OVR)
+		evts |=3D KOMEDA_EVENT_OVR;
=20
-	if (raw_status & (LPU_IRQ_ERR | LPU_IRQ_IBSY)) {
+	if (raw_status & (LPU_IRQ_ERR | LPU_IRQ_IBSY | LPU_IRQ_OVR)) {
 		u32 restore =3D 0, tbu_status;
 		/* Check error of LPU status */
 		status =3D malidp_read32(reg, BLK_STATUS);
@@ -45,6 +47,15 @@ static u64 get_lpu_event(struct d71_pipeline *d71_pipeli=
ne)
 			restore |=3D LPU_STATUS_ACE3;
 			evts |=3D KOMEDA_ERR_ACE3;
 		}
+		if (status & LPU_STATUS_FEMPTY) {
+			restore |=3D LPU_STATUS_FEMPTY;
+			evts |=3D KOMEDA_EVENT_EMPTY;
+		}
+		if (status & LPU_STATUS_FFULL) {
+			restore |=3D LPU_STATUS_FFULL;
+			evts |=3D KOMEDA_EVENT_FULL;
+		}
+
 		if (restore !=3D 0)
 			malidp_write32_mask(reg, BLK_STATUS, restore, 0);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/drivers/gp=
u/drm/arm/display/komeda/d71/d71_regs.h
index 81de6a23e7f3..e80172a0b320 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
@@ -175,6 +175,7 @@
 #define TBU_DOUTSTDCAPB_MASK	0x3F
=20
 /* LPU_IRQ_BITS */
+#define LPU_IRQ_OVR		BIT(9)
 #define LPU_IRQ_IBSY		BIT(10)
 #define LPU_IRQ_ERR		BIT(11)
 #define LPU_IRQ_EOW		BIT(12)
@@ -185,6 +186,8 @@
 #define LPU_STATUS_AXIE		BIT(4)
 #define LPU_STATUS_AXIRP	BIT(5)
 #define LPU_STATUS_AXIWP	BIT(6)
+#define LPU_STATUS_FEMPTY	BIT(11)
+#define LPU_STATUS_FFULL	BIT(14)
 #define LPU_STATUS_ACE0		BIT(16)
 #define LPU_STATUS_ACE1		BIT(17)
 #define LPU_STATUS_ACE2		BIT(18)
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 4a67a80d5fcf..ce27f2f27c24 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -20,6 +20,8 @@
 #define KOMEDA_EVENT_OVR		BIT_ULL(4)
 #define KOMEDA_EVENT_EOW		BIT_ULL(5)
 #define KOMEDA_EVENT_MODE		BIT_ULL(6)
+#define KOMEDA_EVENT_FULL		BIT_ULL(7)
+#define KOMEDA_EVENT_EMPTY		BIT_ULL(8)
=20
 #define KOMEDA_ERR_TETO			BIT_ULL(14)
 #define KOMEDA_ERR_TEMR			BIT_ULL(15)
@@ -49,7 +51,8 @@
 	KOMEDA_ERR_ZME		| KOMEDA_ERR_MERR	| KOMEDA_ERR_TCF |\
 	KOMEDA_ERR_TTNG		| KOMEDA_ERR_TTF)
=20
-#define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE
+#define KOMEDA_WARN_EVENTS	\
+	(KOMEDA_ERR_CSCE | KOMEDA_EVENT_FULL | KOMEDA_EVENT_EMPTY)
=20
 #define KOMEDA_INFO_EVENTS (0 \
 			    | KOMEDA_EVENT_VSYNC \
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_event.c
index 977c38d516da..53f944e66dfc 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -78,6 +78,8 @@ static void evt_str(struct komeda_str *str, u64 events)
=20
 	/* LPU errors or events */
 	evt_sprintf(str, events & KOMEDA_EVENT_IBSY, "IBSY|");
+	evt_sprintf(str, events & KOMEDA_EVENT_EMPTY, "EMPTY|");
+	evt_sprintf(str, events & KOMEDA_EVENT_FULL, "FULL|");
 	evt_sprintf(str, events & KOMEDA_ERR_AXIE, "AXIE|");
 	evt_sprintf(str, events & KOMEDA_ERR_ACE0, "ACE0|");
 	evt_sprintf(str, events & KOMEDA_ERR_ACE1, "ACE1|");
--=20
2.20.1

