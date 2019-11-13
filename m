Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF985C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E2206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Iw8Nhmlg";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Iw8Nhmlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKMBby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:31:54 -0500
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:23872
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726960AbfKMBby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nyx0rS85HVXh2e9/mWrIwZooFHXGSUXUSNOu3h/ruE=;
 b=Iw8NhmlgdkHi0CXv/C7ypGG6SzX7HdL9nB71Ee9UQ+eUlSBNzaqW85Lz0FcNOTdEoObh1RIsNWKh3wz/Zou0g7QuypT7g/TUI8Fg+giWLkOTjQ0YLR+3Usw5c3QSdIhWk75CxJOS9oqLzqRzsdygRwd2pnhV1aoFSDLn6HtzfXI=
Received: from VI1PR08CA0158.eurprd08.prod.outlook.com (2603:10a6:800:d1::12)
 by DB6PR0802MB2343.eurprd08.prod.outlook.com (2603:10a6:4:85::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Wed, 13 Nov
 2019 01:31:48 +0000
Received: from VE1EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR08CA0158.outlook.office365.com
 (2603:10a6:800:d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Wed, 13 Nov 2019 01:31:48 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT029.mail.protection.outlook.com (10.152.18.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.21 via Frontend Transport; Wed, 13 Nov 2019 01:31:48 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Wed, 13 Nov 2019 01:31:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 073bf625c0848a69
X-CR-MTA-TID: 64aa7808
Received: from 3a6e1fc25020.2 (cr-mta-lb-1.cr-mta-net [104.47.6.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 57701F1F-4423-470D-B315-3CECC0B652FB.1;
        Wed, 13 Nov 2019 01:31:42 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3a6e1fc25020.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 13 Nov 2019 01:31:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhOc0whresK85hSO4GfRa7oU0RZ+D6d6uKKJEtM1VARYyxrkK2XqwAgHrLLsSyNLfkmECH4L1jby+m0+d1Qt5rEY7cJIXyg8ri7eJirry+VtQnSYzqBcogJlcwHpf+lzWSz2tUQPRVGdg3++vk4TpCe7aUSqr6ngqa/r9oBF/4u9hu8bZDlR5cmooLW4r90kOixCjO1ab0pdvb5PwYPi2RbJnoD/3cl//roJrDUSxd6QrlPlKA5L8//wu0qo+k1ZZrFDIMTWFWx+YHt/S3YMhzuFFOqoYi2zOZ6prFd+fXBnR+nfYl4395ldxPSaJmSfgN50wCp6hsxLOtC+cu2Iww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nyx0rS85HVXh2e9/mWrIwZooFHXGSUXUSNOu3h/ruE=;
 b=D+iZlLfgkNkB9oGN1uHXe59fYv1sAADb+Eog8c/r1JofGZdrM3Fq7xJFuP8FRcDnMFqGUxd3tolMC0OVafoFMsuAdxI4xuYQvb3hkMjRdksQk4G3DxALIUwM9a9b/aEvMXbTT6LwfXUINbSK2OW/umqvocIvvUCKsLnUYwhksLceQZhmdPm98X//p2RLX/rC3BVRbDe2x/iLK2FsQIQy2ajZtHDiRI2YSs9ACLoiirqc+QjzMiOqY51R6BXJ2JXhj1uDMfOYg8id8zuYLXEaNV/AogLqK3p4fXsun5ONhXHy/o51PcP05JNzk6Ys30cAGJWXnEUBsfKBEHKf+Jdn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nyx0rS85HVXh2e9/mWrIwZooFHXGSUXUSNOu3h/ruE=;
 b=Iw8NhmlgdkHi0CXv/C7ypGG6SzX7HdL9nB71Ee9UQ+eUlSBNzaqW85Lz0FcNOTdEoObh1RIsNWKh3wz/Zou0g7QuypT7g/TUI8Fg+giWLkOTjQ0YLR+3Usw5c3QSdIhWk75CxJOS9oqLzqRzsdygRwd2pnhV1aoFSDLn6HtzfXI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5085.eurprd08.prod.outlook.com (20.179.29.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 01:31:37 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 01:31:37 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "sean@poorly.run" <sean@poorly.run>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH] drm/komeda: Fix komeda driver build error
Thread-Topic: [PATCH] drm/komeda: Fix komeda driver build error
Thread-Index: AQHVmcIXdL7uHyjPDkKsAqgwFS9XVQ==
Date:   Wed, 13 Nov 2019 01:31:37 +0000
Message-ID: <20191113013114.3013-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0188.apcprd02.prod.outlook.com
 (2603:1096:201:21::24) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fa2cedb-d9b9-4f9e-898f-08d767d94085
X-MS-TrafficTypeDiagnostic: VE1PR08MB5085:|VE1PR08MB5085:|DB6PR0802MB2343:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2343D0CA44E99BBCE3B4DCFEB3760@DB6PR0802MB2343.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:298;OLM:298;
x-forefront-prvs: 0220D4B98D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(189003)(199004)(486006)(476003)(36756003)(66476007)(256004)(64756008)(66556008)(386003)(2616005)(50226002)(26005)(8936002)(6506007)(55236004)(102836004)(66946007)(52116002)(186003)(8676002)(81156014)(81166006)(103116003)(5660300002)(66446008)(66066001)(4744005)(71190400001)(71200400001)(1076003)(2906002)(6116002)(3846002)(6486002)(6436002)(2201001)(86362001)(54906003)(110136005)(316002)(2501003)(99286004)(14454004)(478600001)(6636002)(6512007)(25786009)(305945005)(7736002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5085;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jON7GbO34HfmCsvwcy2GlIDBfq4YuBr+VJLNUzuEMDupcnGHVJ7ByroicsraCUrcNuLhaYu4TbBeGFV9DtNu1lqPDmqwTUNS9qRp9z+a3dcNDX4HhXkTBWuFag3H6xJEm4UVVOqzBmM/8Sd1cPja5Ua/OieCR0Tf1gxBW8s6YbwZ2PDz83jLbQt8FxI+F6Ov8Eyx45E2QyfpvcHLBR4Pr4w99EJ4Kzju6EuPXPeFWTfvKsz/6lb5KcQZIp/QlZbJg50lGP9Rkq5Wzq7heOl/kgk0qdVBKUhzEsLawRYF9qB0LCTHQ7c8soM29zBFGZWnLtlRj/bxQq+mf9z+K/Y0jBVfSfgnAJQRcFhfS1+S3KXyuUfN1f3LadpIn0i5+w0riEBS5iqd/q2chACbonz0H+2lQyOSIB4IASXBFIYqyJF0nsngTa/zQJoueCulCL1L
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(1110001)(339900001)(189003)(199004)(7736002)(102836004)(4326008)(81166006)(8676002)(103116003)(70586007)(478600001)(105606002)(6636002)(23756003)(5660300002)(8936002)(8746002)(66066001)(3846002)(6116002)(4744005)(6486002)(316002)(186003)(47776003)(2906002)(6512007)(26826003)(126002)(81156014)(25786009)(110136005)(486006)(1076003)(2616005)(476003)(54906003)(2501003)(70206006)(50466002)(26005)(386003)(6506007)(99286004)(50226002)(2201001)(22756006)(86362001)(14454004)(36756003)(76130400001)(356004)(36906005)(336012)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2343;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 621a7c9e-51bc-4398-4b1f-08d767d939c0
NoDisclaimer: True
X-Forefront-PRVS: 0220D4B98D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dyXzLczDLDnxq28mjrDSDrovCOgJFPrIi4J+sIo5Qlsgq/xLpbjSMDwvH0mpIKEht4Bvd0CybniA2JJ7BReL9J3/a3cWooglHVFPJcpN9URh3vVO+x0xZFrkG5KzBzgZdISuiFXjiNSq+NoPfwhxrjJIaNssftlK36NasKbTG/CTHMyAOljGZ4qil7gViD0ZsGsbJf1JdWGa1Vkjbq1vKnywwh4MABMbOIrm9ui/FNOmFyDDAzL2yPG76MrSnUhTGjSejM1mH6HPtcEm20cC6s8oHHxBm83rnV4PYMlSt/Is8Hlyj38vmaopDJKp498ZD2OzbeUSd6p6VOorUZLFXzWKglCyKUdZwCw5Jj0KgKwuUr30fQuQHmQnnunKz96AV7YN+oKJzCy3fZyOLANTM0LJmvNP0kG3CXInTwCf79aWsk1Bds3ha4XPKVcXJ+Q
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 01:31:48.3081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa2cedb-d9b9-4f9e-898f-08d767d94085
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the build errors lead by

'commit 4039f0293bbd ("drm/komeda: Add option to print WARN- and INFO-level=
 IRQ events")'

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 15f52e304c08..d406a4d83352 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -51,12 +51,12 @@
=20
 #define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE
=20
-#define KOMEDA_INFO_EVENTS ({0 \
+#define KOMEDA_INFO_EVENTS (0 \
 			    | KOMEDA_EVENT_VSYNC \
 			    | KOMEDA_EVENT_FLIP \
 			    | KOMEDA_EVENT_EOW \
 			    | KOMEDA_EVENT_MODE \
-			    })
+			    )
=20
 /* malidp device id */
 enum {
--=20
2.20.1

