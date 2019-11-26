Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED5C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E0520748
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="u9kQXAHs";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="u9kQXAHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfKZKy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:54:56 -0500
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:37858
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727777AbfKZKy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sOo+nWrgd3smlitn5MAGdRnsVHO2u3YzHIXLXG2r68=;
 b=u9kQXAHsmzWHLnZMInFuCHp5fxiMqnB3LdE5G0E5B3hdN9xZPYwuMaSedcipC1fKfRYg0dvzBvqxtOpOlcQvvuFx+XH2fSYG1rtNmUrS7UFzKTPsrLXjmxr4nRoZ4k1A8PAxSQhK5D9rXOB2USWuZArlsLwwfVRHHip2v0Y/ocg=
Received: from VI1PR0802CA0040.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::26) by AM5PR0801MB1746.eurprd08.prod.outlook.com
 (2603:10a6:203:3b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Tue, 26 Nov
 2019 10:54:50 +0000
Received: from DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR0802CA0040.outlook.office365.com
 (2603:10a6:800:a9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 10:54:49 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT061.mail.protection.outlook.com (10.152.21.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 10:54:49 +0000
Received: ("Tessian outbound dbe0f0961e8c:v33"); Tue, 26 Nov 2019 10:54:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d80a95215e049f5c
X-CR-MTA-TID: 64aa7808
Received: from c84123d83267.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3AB1782E-47AE-4F93-ACF0-949591FDC2A4.1;
        Tue, 26 Nov 2019 10:54:43 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c84123d83267.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 10:54:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dkji1v1g0lVPo6F4IjN1CLfVCHoPcizwTWJ3CDCYTKZQjdRPWe+5sGC9tC96R8aq+UoFS52v1smnQblM5XZibAYP1cFVB9mJJIIruh8sC5iiLZE3elC54t/UoyXwDgphBfTw6AMe/23mN703KlGQKa95SZF32LuznaRrvugR3aB244ILkwODk0w7EKIIItweG5OnuQxpjIi0g82XRg+hgLC3FZS3vuo0WhgQDL7I+xOqNmpATk1sdm7tv4qiVbGJypWgX6mx2NY55sff8PcvT2tVRC+gP7r2ZXacnG/J5+wunzjnfDSMRyP7Ohxud1/pGiSrmKpZ7bQ/bWJykyxUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sOo+nWrgd3smlitn5MAGdRnsVHO2u3YzHIXLXG2r68=;
 b=C21DLbmV0IafkAoacPnp8H0pJ1dXhKPkdlPwQh3Ld803OqKJWL05AvO8iBb33kEDjtpF16A4La2bF/8EwVR3KyJUQOYGlKpxlxv+OuW/DFz2ZyDU0YdowjT4KWltIzQRo9NAlhfRSxffqNrnhvoqKZLyayw6eVTKZr2WJsCel5LKBq7WX44eHLlKn1oXH9/jjH8LFExqQSdLjG+q6O5hO76DxlKM0mLXRKjV7MrUnWEiMtIlxTb2LJDoEioQ83RVr/6Ifn9gcjkg/ThtqgylGF3dSoYOBUVBSPo8iFrbvOJoxzHlK0VvUDbqp4nbgwIBxXgfPd3V/fVzQn/aiy0prg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sOo+nWrgd3smlitn5MAGdRnsVHO2u3YzHIXLXG2r68=;
 b=u9kQXAHsmzWHLnZMInFuCHp5fxiMqnB3LdE5G0E5B3hdN9xZPYwuMaSedcipC1fKfRYg0dvzBvqxtOpOlcQvvuFx+XH2fSYG1rtNmUrS7UFzKTPsrLXjmxr4nRoZ4k1A8PAxSQhK5D9rXOB2USWuZArlsLwwfVRHHip2v0Y/ocg=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4703.eurprd08.prod.outlook.com (10.255.27.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 10:54:41 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 10:54:41 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
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
Subject: [PATCH v1 1/2] drm/komeda: Add a new file komeda_sysfs.c
Thread-Topic: [PATCH v1 1/2] drm/komeda: Add a new file komeda_sysfs.c
Thread-Index: AQHVpEfnhh6q9tR5rkGokNkWSivwvA==
Date:   Tue, 26 Nov 2019 10:54:41 +0000
Message-ID: <20191126105412.5978-2-james.qian.wang@arm.com>
References: <20191126105412.5978-1-james.qian.wang@arm.com>
In-Reply-To: <20191126105412.5978-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0010.apcprd03.prod.outlook.com
 (2603:1096:202::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48fc419e-e9d1-4c32-141a-08d7725f0f2e
X-MS-TrafficTypeDiagnostic: VE1PR08MB4703:|VE1PR08MB4703:|AM5PR0801MB1746:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB174673566C28A6ABAF1A7AE5B3450@AM5PR0801MB1746.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:949;OLM:949;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(14444005)(2616005)(6436002)(71190400001)(71200400001)(50226002)(446003)(6486002)(11346002)(3846002)(6116002)(103116003)(36756003)(5660300002)(7736002)(6512007)(1076003)(305945005)(66476007)(66946007)(99286004)(66446008)(64756008)(66556008)(102836004)(8676002)(66066001)(86362001)(76176011)(54906003)(81166006)(81156014)(52116002)(110136005)(316002)(2501003)(14454004)(478600001)(186003)(26005)(25786009)(4326008)(386003)(6506007)(6636002)(8936002)(55236004)(2906002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4703;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: DOgFdZlhjySEZM+eQqj6/MSHMdQ6PC/ddtVCGJWZAIRrpV6PXxUe9GC2dn1whfEAmWxeH9oHzSM/urnbamBBsFTm5oApZJq/TH/MDFg1bslgZa1XKr5RinMHXiJakU0oP4lJGmRrmh70lq8OPSdbQo4+fVwvG2q3kXoAg2Ts8I0ln4tmLn3vX705H/RSi1dEVStBlxON0f/lWVBFywHtO+xqp27443EghE3/wrcN91uRIJ5YT08HZpsYPtvddaZlQxwjcs6g1Jbl0mUNk0MbIKa3LJZmW7PnRUGgGlqNGXX/CAXKMeKTLeiGmVu+2suMN4tKGMR7+tHwBPm4WENvtbuRbnMvRP0e+DnGAci02oq9FgjqT3XmWzwtl6gg3XPjpDWJ4vbbqPVBWHt3JH309GdWM4rK/A5ti0aefKoVPFgZwnhqVyGIF4uA904ZOY8+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4703
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(199004)(189003)(103116003)(356004)(14444005)(446003)(6512007)(7736002)(6486002)(26005)(386003)(11346002)(47776003)(336012)(23756003)(2616005)(50466002)(2501003)(76176011)(6506007)(99286004)(66066001)(102836004)(305945005)(186003)(2906002)(14454004)(110136005)(26826003)(6636002)(54906003)(478600001)(8746002)(81166006)(86362001)(316002)(106002)(3846002)(8676002)(6116002)(70586007)(70206006)(81156014)(4326008)(8936002)(1076003)(25786009)(50226002)(36756003)(5660300002)(76130400001)(22756006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1746;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5e6dc417-ceff-4a26-0166-08d7725f0a1f
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LviMzIPJtg90yUbktywMlGVKd5xGZ2ykauTyOBbqhD+Aa/C39XjbwFa827il4T68ryvbDatjrU//JR/MNJ1AZAv2XgfhpOuxCqfNJtM/r734JDvM528pfBeV4OWfMzxq5N7J0E60B4XSHhLVAG2jO8COMuDA7k0kwUj+T5GoLzvRPe2/45W6DaWZd5cWB+NFTXdN2Hd+CDBBf38+yUe48qxQV0ucQrhWQjl7qbNlvQKYjovafcp4Z6CaUbtVU8/33XCMo0LN8GYs+lYCF4I0eAOERgD9ichCPeBZrFRkM30nnslyZ0uCC49EM2MZi13oE3zEvZ4EZG6Gprg0Y07TmZPtnkK+cd5RqKmIpS/vni50347ehMFp83rb6HXB37ayiAWlcSlUDaSGzZmtHv+UB16PSTntu9bTNrtRtzCpWhY1Oa4aZNNSq2xm2QO3zS0P
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 10:54:49.7831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fc419e-e9d1-4c32-141a-08d7725f0f2e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1746
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>

Add a new file komeda_sysfs.c and move all sysfs related code to it.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/Makefile   |  1 +
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 61 +-------------
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +
 .../gpu/drm/arm/display/komeda/komeda_sysfs.c | 81 +++++++++++++++++++
 4 files changed, 88 insertions(+), 58 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c

diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index 1931a7fa1a14..706674ca5928 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -7,6 +7,7 @@ ccflags-y :=3D \
 komeda-y :=3D \
 	komeda_drv.o \
 	komeda_dev.o \
+	komeda_sysfs.o \
 	komeda_format_caps.o \
 	komeda_color_mgmt.o \
 	komeda_pipeline.o \
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 8e0bce46555b..734b88b88d94 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -63,59 +63,6 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
 }
 #endif
=20
-static ssize_t
-core_id_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct komeda_dev *mdev =3D dev_to_mdev(dev);
-
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", mdev->chip.core_id);
-}
-static DEVICE_ATTR_RO(core_id);
-
-static ssize_t
-config_id_show(struct device *dev, struct device_attribute *attr, char *bu=
f)
-{
-	struct komeda_dev *mdev =3D dev_to_mdev(dev);
-	struct komeda_pipeline *pipe =3D mdev->pipelines[0];
-	union komeda_config_id config_id;
-	int i;
-
-	memset(&config_id, 0, sizeof(config_id));
-
-	config_id.max_line_sz =3D pipe->layers[0]->hsize_in.end;
-	config_id.side_by_side =3D mdev->side_by_side;
-	config_id.n_pipelines =3D mdev->n_pipelines;
-	config_id.n_scalers =3D pipe->n_scalers;
-	config_id.n_layers =3D pipe->n_layers;
-	config_id.n_richs =3D 0;
-	for (i =3D 0; i < pipe->n_layers; i++) {
-		if (pipe->layers[i]->layer_type =3D=3D KOMEDA_FMT_RICH_LAYER)
-			config_id.n_richs++;
-	}
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", config_id.value);
-}
-static DEVICE_ATTR_RO(config_id);
-
-static ssize_t
-aclk_hz_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct komeda_dev *mdev =3D dev_to_mdev(dev);
-
-	return snprintf(buf, PAGE_SIZE, "%lu\n", clk_get_rate(mdev->aclk));
-}
-static DEVICE_ATTR_RO(aclk_hz);
-
-static struct attribute *komeda_sysfs_entries[] =3D {
-	&dev_attr_core_id.attr,
-	&dev_attr_config_id.attr,
-	&dev_attr_aclk_hz.attr,
-	NULL,
-};
-
-static struct attribute_group komeda_sysfs_attr_group =3D {
-	.attrs =3D komeda_sysfs_entries,
-};
-
 static int komeda_parse_pipe_dt(struct komeda_pipeline *pipe)
 {
 	struct device_node *np =3D pipe->of_node;
@@ -277,11 +224,9 @@ struct komeda_dev *komeda_dev_create(struct device *de=
v)
=20
 	clk_disable_unprepare(mdev->aclk);
=20
-	err =3D sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
-	if (err) {
-		DRM_ERROR("create sysfs group failed.\n");
+	err =3D komeda_dev_sysfs_init(mdev);
+	if (err)
 		goto err_cleanup;
-	}
=20
 	mdev->err_verbosity =3D KOMEDA_DEV_PRINT_ERR_EVENTS;
=20
@@ -304,7 +249,7 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 	const struct komeda_dev_funcs *funcs =3D mdev->funcs;
 	int i;
=20
-	sysfs_remove_group(&dev->kobj, &komeda_sysfs_attr_group);
+	komeda_dev_sysfs_destroy(mdev);
=20
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove_recursive(mdev->debugfs_root);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index dacdb00153e9..6183e0f394f0 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -248,4 +248,7 @@ void komeda_print_events(struct komeda_events *evts, st=
ruct drm_device *dev);
 int komeda_dev_resume(struct komeda_dev *mdev);
 int komeda_dev_suspend(struct komeda_dev *mdev);
=20
+int komeda_dev_sysfs_init(struct komeda_dev *mdev);
+void komeda_dev_sysfs_destroy(struct komeda_dev *mdev);
+
 #endif /*_KOMEDA_DEV_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_sysfs.c
new file mode 100644
index 000000000000..740f095b4ca5
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2019 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include <drm/drm_print.h>
+
+#include "komeda_dev.h"
+
+static ssize_t
+core_id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", mdev->chip.core_id);
+}
+static DEVICE_ATTR_RO(core_id);
+
+static ssize_t
+config_id_show(struct device *dev, struct device_attribute *attr, char *bu=
f)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+	struct komeda_pipeline *pipe =3D mdev->pipelines[0];
+	union komeda_config_id config_id;
+	int i;
+
+	memset(&config_id, 0, sizeof(config_id));
+
+	config_id.max_line_sz =3D pipe->layers[0]->hsize_in.end;
+	config_id.side_by_side =3D mdev->side_by_side;
+	config_id.n_pipelines =3D mdev->n_pipelines;
+	config_id.n_scalers =3D pipe->n_scalers;
+	config_id.n_layers =3D pipe->n_layers;
+	config_id.n_richs =3D 0;
+	for (i =3D 0; i < pipe->n_layers; i++) {
+		if (pipe->layers[i]->layer_type =3D=3D KOMEDA_FMT_RICH_LAYER)
+			config_id.n_richs++;
+	}
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", config_id.value);
+}
+static DEVICE_ATTR_RO(config_id);
+
+static ssize_t
+aclk_hz_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", clk_get_rate(mdev->aclk));
+}
+static DEVICE_ATTR_RO(aclk_hz);
+
+static struct attribute *komeda_sysfs_entries[] =3D {
+	&dev_attr_core_id.attr,
+	&dev_attr_config_id.attr,
+	&dev_attr_aclk_hz.attr,
+	NULL,
+};
+
+static struct attribute_group komeda_sysfs_attr_group =3D {
+	.attrs =3D komeda_sysfs_entries,
+};
+
+int komeda_dev_sysfs_init(struct komeda_dev *mdev)
+{
+	struct device *dev =3D mdev->dev;
+	int err;
+
+	err =3D sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
+	if (err)
+		DRM_ERROR("create sysfs group failed.\n");
+
+	return err;
+}
+
+void komeda_dev_sysfs_destroy(struct komeda_dev *mdev)
+{
+	struct device *dev =3D mdev->dev;
+
+	sysfs_remove_group(&dev->kobj, &komeda_sysfs_attr_group);
+}
--=20
2.20.1

