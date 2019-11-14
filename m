Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAE52070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DG/SbwJL";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DG/SbwJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKNIiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:38:13 -0500
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:57157
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfKNIiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awgo8mzDAScoElNVrNOTr423ZXzTsReQcbX4ga4vw0k=;
 b=DG/SbwJL5aBUBqnYQ27d8+wk05JPaJSUWgqErDMd1C7yRsGGCZSm+vsSdC6BuSHHzCnj5/0kJCXrRewAlBWwogDjtpx5IJy/2fM3bePuKwLFdHikVnTaVia+RDNHnJAxNgeSgnrjMIYFWaRtGun+UICTYMpDHfxf6LKU4WfbGrU=
Received: from DB6PR0801CA0060.eurprd08.prod.outlook.com (2603:10a6:4:2b::28)
 by VI1PR08MB5310.eurprd08.prod.outlook.com (2603:10a6:803:13d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26; Thu, 14 Nov
 2019 08:38:06 +0000
Received: from AM5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by DB6PR0801CA0060.outlook.office365.com
 (2603:10a6:4:2b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26 via Frontend
 Transport; Thu, 14 Nov 2019 08:38:06 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT051.mail.protection.outlook.com (10.152.16.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 08:38:06 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Thu, 14 Nov 2019 08:38:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 69003d00aee04017
X-CR-MTA-TID: 64aa7808
Received: from f462d7ae725a.2 (cr-mta-lb-1.cr-mta-net [104.47.10.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 708EC68A-99CA-4C08-807A-AB2EBCDE3179.1;
        Thu, 14 Nov 2019 08:38:01 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f462d7ae725a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Nov 2019 08:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATTWuPjdRBeX/mrOR7ziH/LXObhLZItp4+lCPuBlReMlTHcI0eP94vfgWPKQ4WD1JWxs01Hciw7P3SIe/adl/CphsjxYKTQyTHZehIImdFZGU+xeAlo0kFSVv610Snes5HUpmsel6cboPLy0LojF3bomRDlMY5F/gEm/RE8V/Wf8dONxtTO5KN/LsZ+fHJdhRSQ41Shd9u3/pliIRI48bsC0qqUUkEOz430r1pW9FOeCfbRLT4H6OlduLucqLtVqhms4TQePx+4nbXJoXrxHOWq/J5T56iAo9DzZya2hA45Uujk2UaHdA+rP4QXCHrYcQQovCgWmX0LbI6GlRZGCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awgo8mzDAScoElNVrNOTr423ZXzTsReQcbX4ga4vw0k=;
 b=aufO+bHCBV8MLJJQqAr671VTsoAl1Lq2j8StSG3uUKUjUc7Fi0+mZBPVmHQa5UCwPoR/uogfPtvUYHiCMkjyLvNC75JTvlY9nkPhrBDn1DAgZV5IHYRJSz5sk4JwqLw/NWWDfUHu6kNBFSgk0/85yOQpCD6x2vGa381wkccNgN+yeZ5UccEp8cA3CbH90LYJOKcW9l/X4+epL8WyqLhVwe6u3xF6saqzNQOe+8042b8UzSB7Rn8eZ6PfVmsP/+B1+Lbv1J/L0wcx/HRlVpebD2A7PnSEqcchXA5QRlZEg8GSXVt4m7pyfuqaYSGSFXvwRkOBgOdgTtzE/152nsv0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awgo8mzDAScoElNVrNOTr423ZXzTsReQcbX4ga4vw0k=;
 b=DG/SbwJL5aBUBqnYQ27d8+wk05JPaJSUWgqErDMd1C7yRsGGCZSm+vsSdC6BuSHHzCnj5/0kJCXrRewAlBWwogDjtpx5IJy/2fM3bePuKwLFdHikVnTaVia+RDNHnJAxNgeSgnrjMIYFWaRtGun+UICTYMpDHfxf6LKU4WfbGrU=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4768.eurprd08.prod.outlook.com (10.255.114.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Thu, 14 Nov 2019 08:37:59 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 08:37:58 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 6/6] drm/komeda: Expose side_by_side by sysfs/config_id
Thread-Topic: [PATCH v3 6/6] drm/komeda: Expose side_by_side by
 sysfs/config_id
Thread-Index: AQHVmsbRCzpCw/jsq0ibptLi8SePxg==
Date:   Thu, 14 Nov 2019 08:37:58 +0000
Message-ID: <20191114083658.27237-7-james.qian.wang@arm.com>
References: <20191114083658.27237-1-james.qian.wang@arm.com>
In-Reply-To: <20191114083658.27237-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68e1f228-c639-4cd8-a7a5-08d768ddf8bd
X-MS-TrafficTypeDiagnostic: VE1PR08MB4768:|VE1PR08MB4768:|VI1PR08MB5310:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB53102D192C5A84016C79D5C7B3710@VI1PR08MB5310.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2201;OLM:2201;
x-forefront-prvs: 02213C82F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39850400004)(189003)(199004)(71200400001)(71190400001)(36756003)(305945005)(2906002)(7736002)(110136005)(54906003)(6116002)(316002)(3846002)(99286004)(103116003)(446003)(11346002)(6486002)(8936002)(2616005)(476003)(6436002)(66476007)(66556008)(64756008)(66446008)(66946007)(478600001)(6512007)(50226002)(66066001)(486006)(14454004)(2501003)(5660300002)(76176011)(52116002)(256004)(14444005)(386003)(55236004)(25786009)(6636002)(102836004)(6506007)(8676002)(4326008)(26005)(81156014)(81166006)(1076003)(186003)(2201001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4768;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uxWJBK2FNuHy+XpfXqh1dz4UMc6Rh8NyurPVA/k4IFMEzR2XnDbaom/pjm/3hq+3+ytAIveH+OBQ2T9osjw0Ma/mj6Lq0qzMFAK8FXXZ1rh2Rrgq/ZcZg4kipDXgdj07pADhLj1KySp3aUtdr00VVjzOOCZzA8AVDwr2pTpHM0/jsDEPO64A7a13wVTpWORXt82dJFf+pH3YvyO4wRC44etoAJZZ+PQeWG4hzs0l9sxQ1zqHDy8RZgT9rESmad9xPf6PEYW61j8NwvBDiu6VHMhIqgbJhpZZ+acMr3+Ja199g44hzY2JpJrLq2C+iQRDX8T7myAcg8PFTJU1ZMfocnjRjioUIhN0C+UaSu9HxpEwXy5pB5EjbP6NvtQjugb38sJpMgej9Zh8ylMuzKfr424hYd/lO8KaD0uEjwt/HgJObH9s7dhuHDmlFp2urFOg
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4768
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(376002)(136003)(1110001)(339900001)(189003)(199004)(103116003)(14454004)(22756006)(3846002)(8746002)(4326008)(8676002)(6116002)(8936002)(81156014)(23756003)(50466002)(6636002)(81166006)(2906002)(305945005)(7736002)(6486002)(6512007)(47776003)(66066001)(356004)(14444005)(50226002)(36756003)(1076003)(99286004)(70586007)(2616005)(446003)(11346002)(126002)(476003)(70206006)(486006)(478600001)(6506007)(102836004)(25786009)(26826003)(386003)(36906005)(76176011)(316002)(186003)(336012)(76130400001)(54906003)(110136005)(5660300002)(86362001)(2501003)(26005)(2201001)(105606002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5310;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c2c8f05f-7838-4c0b-069a-08d768ddf3e0
NoDisclaimer: True
X-Forefront-PRVS: 02213C82F8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0COpR5XcDS/KguOF2rHiet8LixACqPCEPFJKXoW6NIIDtRogVRPBivTidju+2/4ibcQSQIjCLvhqSZ0MYGRzg+57H3//Q8v2LwMPw/u99p+BCoEpOoCHSoSKeyJrYLow5fVINS3dTWHabn+sNhXZWHHTD+OxY1E+qSpo9QkdVwPjPRtvL6krQx0HqHKyuxMtZvQa90t6muR+ON90079V00ot1mMsYL0XY0WFUo1rI47pA4gyutfuXFDrclCLZF7p2r/EU/qDvfUilPQYw4WkgXslYhJhgMmx8AWunj+4mVGAAPt/30p0H5PCqJW5eebvMBdKvJ/o/0Mr9cF9eKZsqLtRzti4dAzt8WE198u4ZpY5IXREdeXThIcalipUYUX5tur7tTLxv+JEXfWARIWtFoa5PxH6j8YfKyG8gIG5Qkvuwv48ysMX4PfD8ZXqfhEp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 08:38:06.5823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e1f228-c639-4cd8-a7a5-08d768ddf8bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5310
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

