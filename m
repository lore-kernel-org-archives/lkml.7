Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B642CC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725DF206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KQ8nSjUM";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KQ8nSjUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfHME4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:56:37 -0400
Received: from mail-eopbgr30047.outbound.protection.outlook.com ([40.107.3.47]:26855
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbfHME4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+0u85TYIqzebZPwRrp3l710GQKtayDKSXGIPRoI9M0=;
 b=KQ8nSjUMsPy0YMldoGAAxWKGCgZe+Ri+ckkDtD5KPAn50uBDPJlRtwSNBDBMUdCwk3V+GcOmbRsEJ54yYkIx6v9amadXBp9zI2K6/+Vc0mqgkWtUGmJWoTw3NriSvh7+MYVXxy6nrnE15M8he/FJCHpnqvq/PXuW1o7rA0YEo04=
Received: from VI1PR08CA0230.eurprd08.prod.outlook.com (2603:10a6:802:15::39)
 by AM6PR08MB4950.eurprd08.prod.outlook.com (2603:10a6:20b:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.20; Tue, 13 Aug
 2019 04:56:28 +0000
Received: from VE1EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by VI1PR08CA0230.outlook.office365.com
 (2603:10a6:802:15::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Tue, 13 Aug 2019 04:56:28 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT020.mail.protection.outlook.com (10.152.18.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 13 Aug 2019 04:56:27 +0000
Received: ("Tessian outbound 40a263b748b4:v26"); Tue, 13 Aug 2019 04:56:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c98b36d8a0807742
X-CR-MTA-TID: 64aa7808
Received: from 72c8a93d845b.2 (cr-mta-lb-1.cr-mta-net [104.47.2.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 823FA6D8-80AB-4B6F-AD61-678636BDA14C.1;
        Tue, 13 Aug 2019 04:56:16 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 72c8a93d845b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 13 Aug 2019 04:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDs23oBNL4yiNYf6D2k6EzSKCvmPrz1ssPg1aWeYfShSyX5V1fsCrakxMaXl7zHkBKI/xvpBSNdShN7D/ipDmPJ7ZxWd5/s+HXaVjyVsG60MJw8C9daI2gWAbP4ERgF6CByJ0uTzShMDHFcEKkSRx7x3zw3+AgOh4+h7gkL/OQUNE+UfHLyxMONi3487aKb0p5Ni2vLOlOquH7l6Vg5/RfLsVErbJ2+YwQ1TnIUfNDSWw5eBCA2m/J5hGp7Nov9Nug+/5uriNlxcuSi7Hb9ZAOZ2Knxlxo7SJK7X3b+04Oa744e34dZnxjRiV+h5qQv4fWNLNq07JyYjY+AohnE4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+0u85TYIqzebZPwRrp3l710GQKtayDKSXGIPRoI9M0=;
 b=gmvtb98YUejL9TfRKWAoD0CyfQJuMXXU7T4NR0FELOkMm9v+/kJSJJnKOMeTKcRbVL/skJ5Mhv9MnYR5hOl7eTz/i8Sooi1lBLcNDY2tTYaqP/ELQR4eDJQ2HKVhOMjVtYyOTpMjtmUFJfqF3IBIu9LHWhT7dZ9kiliWPYV/CvqKd9BWZk91nchenjBE8avWMoas971aC3dnzQGvkbUUkUP7Emc1nlvNb/DA4nANt4zmVcRsha33Fbi+mSbcjk1NwTzU0xZl9zFPvls03WhEHuEIUNfM5M9i73acZi8ax3PJQvzZi2h6O7ClxAA3SaAX8uDfbiv8GDZoLkpZYl3d2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+0u85TYIqzebZPwRrp3l710GQKtayDKSXGIPRoI9M0=;
 b=KQ8nSjUMsPy0YMldoGAAxWKGCgZe+Ri+ckkDtD5KPAn50uBDPJlRtwSNBDBMUdCwk3V+GcOmbRsEJ54yYkIx6v9amadXBp9zI2K6/+Vc0mqgkWtUGmJWoTw3NriSvh7+MYVXxy6nrnE15M8he/FJCHpnqvq/PXuW1o7rA0YEo04=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4752.eurprd08.prod.outlook.com (10.255.112.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Tue, 13 Aug 2019 04:56:13 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 04:56:13 +0000
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
Subject: [PATCH v2 3/4] drm: Increase DRM_OBJECT_MAX_PROPERTY to 32
Thread-Topic: [PATCH v2 3/4] drm: Increase DRM_OBJECT_MAX_PROPERTY to 32
Thread-Index: AQHVUZNuExuVOSGvIUuvlOEBz51WoQ==
Date:   Tue, 13 Aug 2019 04:56:13 +0000
Message-ID: <20190813045536.28239-4-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: ed045760-ceb7-44cd-7c2c-08d71faa9943
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4752;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4752:|AM6PR08MB4950:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4950A5AC424EA9FCF9D2119CB3D20@AM6PR08MB4950.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3383;OLM:3383;
x-forefront-prvs: 01283822F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(50226002)(5660300002)(2201001)(110136005)(26005)(316002)(66066001)(6116002)(3846002)(305945005)(2906002)(7736002)(103116003)(71190400001)(71200400001)(4744005)(8676002)(1076003)(54906003)(446003)(55236004)(66946007)(478600001)(81156014)(14454004)(386003)(6506007)(4326008)(36756003)(52116002)(2616005)(102836004)(25786009)(256004)(11346002)(14444005)(81166006)(186003)(76176011)(6486002)(64756008)(66556008)(66476007)(99286004)(2501003)(6512007)(6436002)(86362001)(66446008)(8936002)(486006)(476003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4752;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: ReEIy0SpfB0bF4e+4ch+ModvRHJLMrbASfNAdfw0U/nxFdLFd/XK9d9difLEnNdTPSFC6glpj+HbA8++5XV94N3iOrUCrFrYXEk4jcqVTfB/UGi1pSxXfaFobgqNty8Ph9ueYMkGcmiViTfvbq/lVm+pYysyzuQ1Yr+syLRHcfQME3qciqOxmz/KxC6X3nIIcKAbGc30Rtq001r1Fo3OdJC0W2DC53ro4bOfKUoXi/nMs6XmpdaCB6vnEL3OzjX4FaMRU2iPsoshp4gtp0kR1MuOmwEPEMO0iIjyudosji6j38ONfKUXFZR/bNilSyLOG0nhyz884rqKbMWxVnZ+grUn3G9/stjYrT0vaYkuos2w3bVN4joL3E5/43UuYFmQODOtUDFKFCF/T5U0gxS2tjrdl6DImjZiVMeNJnWZkIc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4752
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(189003)(199004)(26826003)(2501003)(1076003)(6512007)(478600001)(336012)(486006)(81156014)(4326008)(81166006)(2906002)(36756003)(14444005)(2201001)(22756006)(50466002)(386003)(63370400001)(446003)(70586007)(63350400001)(6486002)(70206006)(6506007)(76176011)(23756003)(86362001)(126002)(5660300002)(2616005)(103116003)(4744005)(8676002)(99286004)(14454004)(76130400001)(356004)(11346002)(50226002)(316002)(36906005)(186003)(47776003)(66066001)(102836004)(8746002)(8936002)(476003)(26005)(25786009)(54906003)(110136005)(7736002)(305945005)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4950;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4c508d22-354b-495e-4a79-08d71faa90ee
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB4950;
NoDisclaimer: True
X-Forefront-PRVS: 01283822F8
X-Microsoft-Antispam-Message-Info: 9FBPgiVwc8rh0jzlAyXLdeI2sEPLpKLDyzSJQ4L0f7rx11c0yfCvDUBSEkVqOzS3JtG8bRBZwxGqqzerszHIAmNeSQudbd45ZPSm2wLrZLAs9qCg4ZufBCU4Ou3551Htm50+dDbnjFaT7EmnyWWkiu4FCbB20ZaVNALJfP9O8CezQw/ahM/wtkQzYJ4GhfaoMVNT04nlytxlTwkQHSfU+58jecmsXQ0+r7XzJImMqWKiKbvoXmx6W0kd6CAJGUqRrX+wrFvH4wNrE9xLoYUCmbqhcBYl9P44O7w3ixJk4gWJHQmgNHhSBfvGxbUt5mXSefu7GTZiR4ze+UvQ2b1Jcx+sbR1iNP7oc03wCbtLSKMAROhDnAwME3ILUYw6BEIJ4AROyjWUt5mCznr8BN2+F2aTfd3wsYU+9GYdjBYZyaM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 04:56:27.0891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed045760-ceb7-44cd-7c2c-08d71faa9943
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4950
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM_OBJECT_MAX_PROPERTY number 24 is not enough for komeda usage, increase
it to 32 to fit komeda's requirement.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 include/drm/drm_mode_object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index c34a3e8030e1..fd7666048197 100644
--- a/include/drm/drm_mode_object.h
+++ b/include/drm/drm_mode_object.h
@@ -60,7 +60,7 @@ struct drm_mode_object {
 	void (*free_cb)(struct kref *kref);
 };
=20
-#define DRM_OBJECT_MAX_PROPERTY 24
+#define DRM_OBJECT_MAX_PROPERTY 32
 /**
  * struct drm_object_properties - property tracking for &drm_mode_object
  */
--=20
2.20.1

