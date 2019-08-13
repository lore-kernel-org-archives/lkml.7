Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFB5C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B875206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Jtpkwfin";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Jtpkwfin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfHME41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:56:27 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:36484
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbfHME4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuGciigGkwP439dkP0n3XwvBbunHid96eGr9XRrL5Jw=;
 b=JtpkwfinRXAjAP6UHPNk9EaKCUbrtWWMgHZAu12NxpaeTPfYsJ+FJm/oAF9bFyBy02PzLxLKeR4c+aYCd9255wwQRvagT7M7JojyiJcqb3f11FRiCZTSdQVdYsvb5kbbO6cV5jNjjhMJvwv3NQY+q/Rn/UgglTvUFhIdc0Z7dgI=
Received: from DB7PR08CA0048.eurprd08.prod.outlook.com (2603:10a6:10:26::25)
 by VE1PR08MB4959.eurprd08.prod.outlook.com (2603:10a6:803:110::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16; Tue, 13 Aug
 2019 04:56:17 +0000
Received: from DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by DB7PR08CA0048.outlook.office365.com
 (2603:10a6:10:26::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18 via Frontend
 Transport; Tue, 13 Aug 2019 04:56:17 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT012.mail.protection.outlook.com (10.152.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 13 Aug 2019 04:56:15 +0000
Received: ("Tessian outbound 40a263b748b4:v26"); Tue, 13 Aug 2019 04:56:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: de0535b376d47595
X-CR-MTA-TID: 64aa7808
Received: from 5a9e516d9020.2 (cr-mta-lb-1.cr-mta-net [104.47.2.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3CA80F2B-4F52-4659-A844-F0FD2A629A0F.1;
        Tue, 13 Aug 2019 04:56:04 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5a9e516d9020.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 13 Aug 2019 04:56:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2B6ebQP4uaP/RMjLLCVGEhpPODhPQZoYUPe5m5PDporzWepuOJkB1aWZtxfVIjS3aoTEPe5bxhkEhohm5zWPTeiNUfjsDnMnwgw1sHlODIeEBr0lfCgi6VCXHzk9knlSJ7QOmNSh+rmTelPV9x/mdjb3yRcl6eREkgUEDZq/VGAExGJEr1tC8C4JQW0Hy/7LBUUpg12KkzHZY+OAfgkwrkIFOHR8H85JeCb11mQuOYdEH9afEXrJdEEz5FhaRK2Z4CiDkJHDmft0TYO6UdpCjxKN4djMJg3Xetm3QGNFbRAUhO2xEwHDZcy3prPT6jUwcbkOeUKXdT1/ivn/NOUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuGciigGkwP439dkP0n3XwvBbunHid96eGr9XRrL5Jw=;
 b=T2GsNnUxSbK7/cBCzrm65pSPL0SCEISVNYr9xNd5VxdbwakiVej9sBKc9F4lI+KEYiEVtlEE0Gfew3iuGQH8wZ2gwZ97x3O7Y0QqWno68gcD2Tvl3pohgyN6OKdT2w5FD3Vs/az7q7VN9HQDzD4Kol6EBzIP+MNPwBII3KaWTqORNWQKp3L8brJwvMmeQmBnoXcNZ3XFvrUPU4/vrNEdU+zTmCHQ7UMMsgdxgAHnR5vHwk1/m3bPrcPZ/6BYfz8okxLTVPoTNbLSnLwNkbPTXNcmeXJL7THrd3eTkhN1esCXamvk63QsJ8zhuOpOv7vUvri/UgcoeieUtYMfOCCTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuGciigGkwP439dkP0n3XwvBbunHid96eGr9XRrL5Jw=;
 b=JtpkwfinRXAjAP6UHPNk9EaKCUbrtWWMgHZAu12NxpaeTPfYsJ+FJm/oAF9bFyBy02PzLxLKeR4c+aYCd9255wwQRvagT7M7JojyiJcqb3f11FRiCZTSdQVdYsvb5kbbO6cV5jNjjhMJvwv3NQY+q/Rn/UgglTvUFhIdc0Z7dgI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4752.eurprd08.prod.outlook.com (10.255.112.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Tue, 13 Aug 2019 04:56:02 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 04:56:01 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 1/4] drm/komeda: Introduce komeda_coeffs_table/manager
Thread-Topic: [PATCH v2 1/4] drm/komeda: Introduce komeda_coeffs_table/manager
Thread-Index: AQHVUZNn0XyAilFXnEawB/L5bqoU/A==
Date:   Tue, 13 Aug 2019 04:56:01 +0000
Message-ID: <20190813045536.28239-2-james.qian.wang@arm.com>
References: <20190813045536.28239-1-james.qian.wang@arm.com>
In-Reply-To: <20190813045536.28239-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 0221206e-2bba-4f6c-b107-08d71faa9274
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4752;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4752:|VE1PR08MB4959:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB495964C99306371DEB54D68BB3D20@VE1PR08MB4959.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3968;OLM:3968;
x-forefront-prvs: 01283822F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(50226002)(5660300002)(2201001)(110136005)(26005)(316002)(66066001)(6116002)(3846002)(305945005)(2906002)(7736002)(103116003)(71190400001)(71200400001)(8676002)(1076003)(54906003)(446003)(55236004)(66946007)(478600001)(81156014)(14454004)(386003)(6506007)(4326008)(36756003)(52116002)(2616005)(102836004)(25786009)(256004)(11346002)(14444005)(81166006)(186003)(76176011)(6486002)(64756008)(66556008)(66476007)(99286004)(2501003)(6512007)(6436002)(86362001)(66446008)(8936002)(486006)(476003)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4752;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: LoQbVzAb6R/gLMANugwmN1ykWg7l4Yebc6tgWNiiiczZ7ygFlBsvuBy9hHOpZx0kk7Ep64h5I6ELE9WWDzkUXJWWiqLj2ovLJ35eqAWfWFP22t2DJ13IJ5R1NH2QwqMTfgjtY17460JoGmox0qjfX/kSE8e1/ptOQ5paGJmlYqwX0RI/XaWzlj4IXzj62eFEeYyMui+i3+cm5SodCtRcZWyW8hqpPNuhP7G1Sftzz2UP0ZSBJfFdQ2/f8AHIJgKQqyvnpiQdCLtKpND3uzwkgTKURZ94McHCXLrJzftB9KC1ntJ4i/TsNgtVLB7pGbqEIbqDU9vpTywXEgVXD2MiEUpVEtWkJN61e/n8y83egbMmrbBwTKZ0WBOzwonvBW2cxJQJk5NrxCQetSSjqIz4VtT0lJefVIolpTpeq4PbA1s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4752
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(189003)(199004)(305945005)(47776003)(26005)(76176011)(66066001)(81166006)(2501003)(99286004)(7736002)(81156014)(50226002)(102836004)(8936002)(8746002)(6506007)(386003)(36756003)(2906002)(63370400001)(6512007)(446003)(6486002)(2201001)(63350400001)(11346002)(486006)(4326008)(14444005)(336012)(25786009)(86362001)(2616005)(476003)(26826003)(1076003)(103116003)(70586007)(23756003)(70206006)(356004)(126002)(3846002)(478600001)(50466002)(14454004)(316002)(8676002)(186003)(110136005)(54906003)(6116002)(22756006)(76130400001)(5660300002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4959;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 683bd389-c07b-44cf-c8dd-08d71faa89ef
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VE1PR08MB4959;
NoDisclaimer: True
X-Forefront-PRVS: 01283822F8
X-Microsoft-Antispam-Message-Info: hMGqZd224gwaCaKmlw0uct7hzFyY9+UGweFiDya8YU/+YeOJaD7s42Xt8sD3qtoeYU8O6+CnO1xLOADQ/0MKbh9GcKlsok5LnFHNZXUkNOUtWlWxE9DIpfukqhwCSg5tHN4bbkFLcg5s8BhtR4tH0HYx0M/3snM3ka0xBqPP5hiV7+bFNQO/OYLhLJYMWQiqJ5+E7w5yShyIKZvsbPxT+zoom7wPIwpJvK1hHa/H8+kB2Z0bFww+kIibJ7LTVoCmN/HiwFm/kTIqrcwYb3z9L/smxJ9LZIpTTMWKolTqPSg4PNjqGsMian7XRDJhjLXRya5jy/fytWPluW8QmpaNbtpS2dj8RxUpLVUGDsjlOWI3P2Dhn1Smqrma4L0R83cySk4nye3Bym2S2BQHuiY3pKwlFzQY7k2horaRuCWeziA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 04:56:15.7536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0221206e-2bba-4f6c-b107-08d71faa9274
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

komeda display HWs have kinds of coefficient tables for various purposes
like gamma/degamma. ususally these tables are shared by multiple HW
component and have limited number.
Introduce komeda_coeffs_table/manager for describing and managing these
tables, like table reuse, racing.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/Makefile   |   1 +
 .../drm/arm/display/komeda/komeda_coeffs.c    | 119 ++++++++++++++++++
 .../drm/arm/display/komeda/komeda_coeffs.h    |  74 +++++++++++
 3 files changed, 194 insertions(+)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_coeffs.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_coeffs.h

diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index 5c3900c2e764..38aa5843c03a 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -8,6 +8,7 @@ komeda-y :=3D \
 	komeda_drv.o \
 	komeda_dev.o \
 	komeda_format_caps.o \
+	komeda_coeffs.o \
 	komeda_color_mgmt.o \
 	komeda_pipeline.o \
 	komeda_pipeline_state.o \
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_coeffs.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_coeffs.c
new file mode 100644
index 000000000000..d9d35e23003c
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_coeffs.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2019 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include <linux/slab.h>
+#include "komeda_coeffs.h"
+
+static inline bool is_table_in_using(struct komeda_coeffs_table *table)
+{
+	return refcount_read(&table->refcount) > 1;
+}
+
+/* request a coeffs table for the coeffs data specified by argument coeffs=
 */
+struct komeda_coeffs_table *
+komeda_coeffs_request(struct komeda_coeffs_manager *mgr, void *coeffs)
+{
+	struct komeda_coeffs_table *table;
+	u32 i;
+
+	mutex_lock(&mgr->mutex);
+
+	/* search table list to find if there is a in-using table with the
+	 * same coefficient content, if find, reuse this table.
+	 */
+	for (i =3D 0; i < mgr->n_tables; i++) {
+		table =3D mgr->tables[i];
+
+		/* skip the unused table */
+		if (!is_table_in_using(table))
+			continue;
+
+		if (!memcmp(table->coeffs, coeffs, mgr->coeffs_sz))
+			goto found;
+	}
+
+	/* can not reuse the existing in-using table, loop for a new one */
+	for (i =3D 0; i < mgr->n_tables; i++) {
+		table =3D mgr->tables[i];
+
+		if (!is_table_in_using(table)) {
+			memcpy(table->coeffs, coeffs, mgr->coeffs_sz);
+			table->needs_update =3D true;
+			goto found;
+		}
+	}
+
+	/* Since previous two search loop will directly goto found if found an
+	 * available table, so once program ran here means search failed.
+	 * clear the table to NULL, unlock(mgr->mutex) and return NULL.
+	 */
+	table =3D NULL;
+
+found:
+	komeda_coeffs_get(table);
+	mutex_unlock(&mgr->mutex);
+	return table;
+}
+
+/* Add a coeffs table to manager */
+int komeda_coeffs_add(struct komeda_coeffs_manager *mgr,
+		      u32 hw_id, u32 __iomem *reg,
+		      void (*update)(struct komeda_coeffs_table *table))
+{
+	struct komeda_coeffs_table *table;
+
+	if (mgr->n_tables >=3D ARRAY_SIZE(mgr->tables))
+		return -ENOSPC;
+
+	table =3D kzalloc(sizeof(*table), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	table->coeffs =3D kzalloc(mgr->coeffs_sz, GFP_KERNEL);
+	if (!table->coeffs) {
+		kfree(table);
+		return -ENOMEM;
+	}
+
+	refcount_set(&table->refcount, 1);
+	table->mgr =3D mgr;
+	table->hw_id =3D hw_id;
+	table->update =3D update;
+	table->reg =3D reg;
+
+	mgr->tables[mgr->n_tables++] =3D table;
+	return 0;
+}
+
+struct komeda_coeffs_manager *komeda_coeffs_create_manager(u32 coeffs_sz)
+{
+	struct komeda_coeffs_manager *mgr;
+
+	mgr =3D kzalloc(sizeof(*mgr), GFP_KERNEL);
+	if (!mgr)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&mgr->mutex);
+	mgr->coeffs_sz =3D coeffs_sz;
+
+	return mgr;
+}
+
+void komeda_coeffs_destroy_manager(struct komeda_coeffs_manager *mgr)
+{
+	u32 i;
+
+	if (!mgr)
+		return;
+
+	for (i =3D 0; i < mgr->n_tables; i++) {
+		WARN_ON(is_table_in_using(mgr->tables[i]));
+		kfree(mgr->tables[i]->coeffs);
+		kfree(mgr->tables[i]);
+	}
+
+	kfree(mgr);
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_coeffs.h b/drivers/g=
pu/drm/arm/display/komeda/komeda_coeffs.h
new file mode 100644
index 000000000000..172ac2ea17ba
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_coeffs.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) COPYRIGHT 2019 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#ifndef _KOMEDA_COEFFS_H_
+#define _KOMEDA_COEFFS_H_
+
+#include <linux/refcount.h>
+
+/* Komeda display HWs have kinds of coefficient tables for various purpose=
s,
+ * like gamma/degamma. ususally these tables are shared by multiple HW com=
ponent
+ * and limited number.
+ * The komeda_coeffs_table/manager are imported for describing and managin=
g
+ * these tables for table reuse and racing.
+ */
+struct komeda_coeffs_table {
+	struct komeda_coeffs_manager *mgr;
+	refcount_t refcount;
+	bool needs_update;
+	u32 hw_id;
+	void *coeffs;
+	u32 __iomem *reg;
+	void (*update)(struct komeda_coeffs_table *table);
+};
+
+struct komeda_coeffs_manager {
+	struct mutex mutex; /* for tables accessing */
+	u32 n_tables;
+	u32 coeffs_sz;
+	struct komeda_coeffs_table *tables[8];
+};
+
+static inline struct komeda_coeffs_table *
+komeda_coeffs_get(struct komeda_coeffs_table *table)
+{
+	if (table)
+		refcount_inc(&table->refcount);
+
+	return table;
+}
+
+static inline void __komeda_coeffs_put(struct komeda_coeffs_table *table)
+{
+	if (table)
+		refcount_dec(&table->refcount);
+}
+
+#define komeda_coeffs_put(table) \
+do { \
+	__komeda_coeffs_put(table); \
+	(table) =3D NULL; \
+} while (0)
+
+static inline void komeda_coeffs_update(struct komeda_coeffs_table *table)
+{
+	if (!table || !table->needs_update)
+		return;
+
+	table->update(table);
+	table->needs_update =3D false;
+}
+
+struct komeda_coeffs_manager *komeda_coeffs_create_manager(u32 coeffs_sz);
+void komeda_coeffs_destroy_manager(struct komeda_coeffs_manager *mgr);
+
+int komeda_coeffs_add(struct komeda_coeffs_manager *mgr,
+		      u32 hw_id, u32 __iomem *reg,
+		      void (*update)(struct komeda_coeffs_table *table));
+struct komeda_coeffs_table *
+komeda_coeffs_request(struct komeda_coeffs_manager *mgr, void *coeffs);
+
+#endif /*_KOMEDA_COEFFS_H_*/
--=20
2.20.1

