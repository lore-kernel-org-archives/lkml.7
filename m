Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6D8C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119F520872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7vm3jIUm";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7vm3jIUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKUHNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:13:09 -0500
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:46243
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfKUHNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awgo8mzDAScoElNVrNOTr423ZXzTsReQcbX4ga4vw0k=;
 b=7vm3jIUmTSObHMUF7FSiImwjCcYyCxLDOxmQfOrTXDprYk0Q2yyFcHaCJ9PVC3/MXrlq7ffjxsmD4UnxDmJFVvIHvKt6rPKzVx5JrOIMqCfKk9YoiGD6wlRMCvSMDmEuEKfDnbGLpUqY+Ps6QdqTvW9OKToI09GOyXFH/3rv3rA=
Received: from VI1PR08CA0091.eurprd08.prod.outlook.com (2603:10a6:800:d3::17)
 by AM6PR08MB5157.eurprd08.prod.outlook.com (2603:10a6:20b:e8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Thu, 21 Nov
 2019 07:13:03 +0000
Received: from VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR08CA0091.outlook.office365.com
 (2603:10a6:800:d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Thu, 21 Nov 2019 07:13:03 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT003.mail.protection.outlook.com (10.152.18.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 07:13:03 +0000
Received: ("Tessian outbound a8f166c1f585:v33"); Thu, 21 Nov 2019 07:13:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f4880ec7cc266765
X-CR-MTA-TID: 64aa7808
Received: from 4a9d07b44583.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 721367F0-2AB1-468E-B7FD-1618019B0634.1;
        Thu, 21 Nov 2019 07:12:57 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4a9d07b44583.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 07:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjUnlFdCBcaGrQBGCq5G3f7DrS7NoBTwinxP3R/V/jDNIHwiXx4A5t3W69Zmj4+Ag6N/XcbPw66EMowMK15Z8ZTF/VZPEgYXkE5dA/L2K8dJUxl/BfIh2o190EyGZMs9JNm4CPayuxtMarOWO1UtErRycWnvQtRLdolqa4boJpCcIDbftDQ+eM+oQOsgxP5B+dOq8CLPfcXV2ZoPUmxyCajqCNjzVWLZ7wSxtTkjVOb8NhyoalTreYZJapc4kfzjHTyvXlPdOJ7VQgBEnANtecwvHh8wPVv/jijN5vn6yjOlkMC1e6u60tzXsOOarSyHdAHD7wMO1R+7vZMq46/Hyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awgo8mzDAScoElNVrNOTr423ZXzTsReQcbX4ga4vw0k=;
 b=MnBfew00yZpA4AwFWJ8RhyNGxDtEHeQZKEd5RgFA3bBbsck2VqYdkfa/bnOr+tVdWeJun/HkVU6IFdZYvmTiVfEyVh0Vb3PqpTgjYCz4IcKFMrdp5aJ7Vf4MMibEkUEZL63rlurvzH1FRIHcxBdgLzOioBdDNlKLMRCn/dfDNZ2kTWuC3pjHRX6umYrJ9CALp9korgGNs1aM1GdbObULfjSNbgeHETluInOMTex4eQANfHL7nQSURq/XBU2Q8SR26eDUS0sANFLEQdRQHxTF+uLeUzXr/SuV0ydNJ1Uljn+7kDhpnMhmMChZ9NlMwtAmNbKR68xeHmugg87qYw0v5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awgo8mzDAScoElNVrNOTr423ZXzTsReQcbX4ga4vw0k=;
 b=7vm3jIUmTSObHMUF7FSiImwjCcYyCxLDOxmQfOrTXDprYk0Q2yyFcHaCJ9PVC3/MXrlq7ffjxsmD4UnxDmJFVvIHvKt6rPKzVx5JrOIMqCfKk9YoiGD6wlRMCvSMDmEuEKfDnbGLpUqY+Ps6QdqTvW9OKToI09GOyXFH/3rv3rA=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5069.eurprd08.prod.outlook.com (20.179.29.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 07:12:55 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 07:12:55 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v4 6/6] drm/komeda: Expose side_by_side by sysfs/config_id
Thread-Topic: [PATCH v4 6/6] drm/komeda: Expose side_by_side by
 sysfs/config_id
Thread-Index: AQHVoDsY3wS7JXHxKU+92h5A5rXdAA==
Date:   Thu, 21 Nov 2019 07:12:55 +0000
Message-ID: <20191121071205.27511-7-james.qian.wang@arm.com>
References: <20191121071205.27511-1-james.qian.wang@arm.com>
In-Reply-To: <20191121071205.27511-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3b82be1-e1ae-4c4b-9dfb-08d76e523fcf
X-MS-TrafficTypeDiagnostic: VE1PR08MB5069:|VE1PR08MB5069:|AM6PR08MB5157:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5157044EE60120E503220523B34E0@AM6PR08MB5157.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2201;OLM:2201;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(189003)(199004)(386003)(6636002)(55236004)(102836004)(6506007)(76176011)(256004)(52116002)(2906002)(14444005)(50226002)(7736002)(305945005)(66446008)(186003)(81166006)(81156014)(8676002)(8936002)(66946007)(6512007)(26005)(2616005)(71200400001)(6486002)(446003)(478600001)(11346002)(71190400001)(6436002)(64756008)(66476007)(66556008)(86362001)(66066001)(4326008)(36756003)(2501003)(6116002)(316002)(3846002)(14454004)(103116003)(99286004)(54906003)(110136005)(25786009)(1076003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5069;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZVL6Pefp/KpI9j1dlD5MFMEhTYbRJjNoxdsrboCru2D98uw0JOKWty9FQk00nMhsyDsLFLTGIw8o54K6BCyqasvYfsUkFKP4DIqIxtjh4JdK8mbSthEBmB6dQGVGUHFlZ8m8vwH1nrwnAbJLuyAZMqi2n3esi36xiU/u/8GtS35FztUYiOXJWR+Fy73nea/g55p1bdw+ehde/k4wRgbr1+qtZ7WHiJTYgZU7gKF4TPWgqWAA8gGj1KQlESWfOlbf/wukThzWPvHAUWx95SnemXfGHFADrpSv3UJEPjf5bBI8P6iWrVJmdL+qWB1tAbvmutAiXSvhtoELdcEgSDsGeQ2X5k706+zqpNj3ZerTsfZL2Nd4+hEbct0Gfau3e6qag/eG5FC46Thal7hv6WZiFBIKAhJoHbJ+A8ZCxqBBQENq9byqZZSYp8rEhNAWx7ww
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5069
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(1110001)(339900001)(189003)(199004)(103116003)(86362001)(76130400001)(8746002)(1076003)(6506007)(478600001)(305945005)(66066001)(105606002)(110136005)(36756003)(99286004)(7736002)(26005)(23756003)(5660300002)(386003)(6486002)(102836004)(8676002)(22756006)(50226002)(356004)(54906003)(2501003)(81156014)(81166006)(76176011)(70586007)(6636002)(50466002)(186003)(70206006)(26826003)(11346002)(2616005)(36906005)(25786009)(336012)(446003)(47776003)(14444005)(2906002)(8936002)(14454004)(4326008)(316002)(6116002)(6512007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5157;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 16cc174f-07f0-41f1-9f65-08d76e523b10
NoDisclaimer: True
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKl3d0Bz2lD85Gmv9XnYIb7W9q3pbkzq029O2jjKa5t0oJkVoAHRnvF5U+oAr6k3BWPR86Zkoflt9RZs7LDmelyabwbUM8T4GY3NHtf9mis5AvlViJRakhkDCMk1VB9hjFEKta5uGGZZf++Jb9p3su0l5k0HV/9P/isGrSeJhkXPVZmVmc/JQiwE1wfVORejEDserXgCZTW9e/poCyREsgM9YjD2hBiFtpKQxmLfrbrYjU/Q0TDa0zaREWU3DtS1y1+UnRGpmRXXIk9OyQSVwxcMrAjvhmxtzhwNVTs276CtA4QGGIILLTYzqYHN+OJ+qDx5UeAY+shIVp8SVSotlEXKlCRxUwM1av/OB/hVCqyA38kQP6bn3arz2urGa7kcIVt8dF0yHzKfYWBIqXD9Ex1IUUxDSs81RJPtnz//AX3ezp1ufRKYv10INkwSmPyv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 07:13:03.2048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b82be1-e1ae-4c4b-9dfb-08d76e523fcf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some restrictions if HW works on side_by_side, expose it via
config_id to user.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/include/malidp_product.h | 3 ++-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers=
/gpu/drm/arm/display/include/malidp_product.h
index 1053b11352eb..96e2e4016250 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_product.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
@@ -27,7 +27,8 @@ union komeda_config_id {
 			n_scalers:2, /* number of scalers per pipeline */
 			n_layers:3, /* number of layers per pipeline */
 			n_richs:3, /* number of rich layers per pipeline */
-			reserved_bits:6;
+			side_by_side:1, /* if HW works on side_by_side mode */
+			reserved_bits:5;
 	};
 	__u32 value;
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index c3fa4835cb8d..4dd4699d4e3d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -83,6 +83,7 @@ config_id_show(struct device *dev, struct device_attribut=
e *attr, char *buf)
 	memset(&config_id, 0, sizeof(config_id));
=20
 	config_id.max_line_sz =3D pipe->layers[0]->hsize_in.end;
+	config_id.side_by_side =3D mdev->side_by_side;
 	config_id.n_pipelines =3D mdev->n_pipelines;
 	config_id.n_scalers =3D pipe->n_scalers;
 	config_id.n_layers =3D pipe->n_layers;
--=20
2.20.1

