Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B91C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EFB20727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GhsYqEDT";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GhsYqEDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfKZKzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:55:02 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:56161
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727777AbfKZKzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuPORfjEkbFbDMZqgxVIbmFO6TGaVWP1axYlY287T+I=;
 b=GhsYqEDTQ5bB4BfL0hVYkz97wY91oLt/oiCdQKIIgP2VEqGDGv35QCP6iM8Uag8rysgvtj8U6mYRdj/WMdco2CDqYEWknAZV10hEOz+tT5biIf74G8f2ju//GamrZfxKGRzME49qF2V+o77KT+nt3N7JE00yXaKikKkJ6iPlRGQ=
Received: from VE1PR08CA0016.eurprd08.prod.outlook.com (2603:10a6:803:104::29)
 by AM6PR08MB5238.eurprd08.prod.outlook.com (2603:10a6:20b:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18; Tue, 26 Nov
 2019 10:54:56 +0000
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by VE1PR08CA0016.outlook.office365.com
 (2603:10a6:803:104::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 10:54:56 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 10:54:56 +0000
Received: ("Tessian outbound af6b7800e6cb:v33"); Tue, 26 Nov 2019 10:54:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 107a7d95670af9cd
X-CR-MTA-TID: 64aa7808
Received: from 6f39bf02dbf5.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AD497D39-2940-4F20-82A6-34243C90BC0E.1;
        Tue, 26 Nov 2019 10:54:49 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6f39bf02dbf5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 10:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvCHzNVZyflxNII8fqkDsWLhbbO9tpv6XvFr3kX+EgJBQnFTUePfyA/Gj5E1KETtf2vEJ9Z9Nx5Y0RfMBKwe17579YTUeY5MapoZ5N2wFuWj9LPVRz7YqtARaOSSgL2s/rCm5bFuyuzolOxa7kW/auyudoQIaStJD5nZyFyCri3KaXF0PO/s0QtMQ4Xco7Or4JsFwL6x29dbDlWJEM7zwr60wOpI7pl9Hvzc5KLu6qQcpd6XIsv9tWLDOmrTBIz77aqFlipeyTukbK72hE85YWQap1Ouh0TDvPi79YNYVMril/+vwfQzuzVayHeltYuBE9mH6KMTbE9NaaXuPs1VYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuPORfjEkbFbDMZqgxVIbmFO6TGaVWP1axYlY287T+I=;
 b=odrB3FLFJDsKFO849L55xANpJS6CbUNqPXIai+FBg6zXOZq42f+TsPe8Mx7jqb6gAhTrO+gEYjArsG1lyw/O9m5VOtnWhdauI9G6d+t/SzFgcsqPJncGfhwpa5G8hjYiSlzNw6n1rQJXlPeh1PEiUqU+jeqBrWNe0eux3exzBZUm1jV8CPI1Q9JvyeExJQ3Rv6T3eGEoSFKGz7OqVCly09yx3c9izMjCseZHfC0FXp1nXQ10QL1V5adPVG1A16IbJZKLo3A2n2vr7w6x37Cgiqq+zK3bFgyh2yzizXadtaRVLxWVi9o/SiX9QlPwAsr+b63qfWiVnEVj2QzRcuqqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuPORfjEkbFbDMZqgxVIbmFO6TGaVWP1axYlY287T+I=;
 b=GhsYqEDTQ5bB4BfL0hVYkz97wY91oLt/oiCdQKIIgP2VEqGDGv35QCP6iM8Uag8rysgvtj8U6mYRdj/WMdco2CDqYEWknAZV10hEOz+tT5biIf74G8f2ju//GamrZfxKGRzME49qF2V+o77KT+nt3N7JE00yXaKikKkJ6iPlRGQ=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4703.eurprd08.prod.outlook.com (10.255.27.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 10:54:47 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 10:54:47 +0000
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
Subject: [PATCH v1 2/2] drm/komeda: Refactor sysfs node "config_id"
Thread-Topic: [PATCH v1 2/2] drm/komeda: Refactor sysfs node "config_id"
Thread-Index: AQHVpEfreeFjBGX9KE2GMbcm5nukJA==
Date:   Tue, 26 Nov 2019 10:54:47 +0000
Message-ID: <20191126105412.5978-3-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: f429dc60-8dab-4ac0-e4c0-08d7725f1306
X-MS-TrafficTypeDiagnostic: VE1PR08MB4703:|VE1PR08MB4703:|AM6PR08MB5238:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5238807B95549D109E466B5CB3450@AM6PR08MB5238.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2331;OLM:2331;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(2616005)(6436002)(71190400001)(71200400001)(50226002)(446003)(6486002)(11346002)(3846002)(6116002)(103116003)(36756003)(5660300002)(7736002)(6512007)(1076003)(305945005)(66476007)(66946007)(99286004)(66446008)(64756008)(66556008)(102836004)(8676002)(66066001)(86362001)(76176011)(54906003)(81166006)(81156014)(52116002)(110136005)(316002)(2501003)(14454004)(478600001)(186003)(26005)(25786009)(4326008)(386003)(6506007)(6636002)(8936002)(55236004)(2906002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4703;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: HAzNkrM44Bv1RZf0geZEys74+wfn7BRQ0fhZMLy3sK0CkmqZSBx+BiAW0hv9E33X0ua2yrEMjWS9nuGUjo1TgUgyx89QdCeWFAOlsLzc2paq79dSDuC7NQuskNKIK/Y/SKWCLQpLfI9tPsWhSoipUScYY8V7oLhPTNv1g9pa+IWNbUxSn+cP9ejOwpg8hiHXmFtKw+VlL28lX5uCuqc8nK8rA38qqgzcKk2RyI8rl80G/NJEV4xS2tdP4We9P1jopQOVCnKqXulhGDRg//wcMu4FVsYwdKJ2tKGwaBOKvJomx66GpvI8UPpQ6WYrxFNPzW7OY37j1WJTbvCjgw5rISuWtu9pLgEbZPzc+5/mOOSkvMmM/Dy1yKKzODkI4R6R8lYt05tJT2sGmKRnggLgQD6gV8rQX2qvOHLw2NAOrLC2MMyx52wZsvzFX0Z9YLFb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4703
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(336012)(6512007)(11346002)(6486002)(2616005)(14454004)(386003)(76176011)(36906005)(106002)(102836004)(478600001)(6506007)(26005)(25786009)(4326008)(103116003)(26826003)(54906003)(6636002)(446003)(22756006)(50466002)(86362001)(36756003)(186003)(2501003)(1076003)(76130400001)(47776003)(5660300002)(305945005)(70206006)(70586007)(7736002)(110136005)(8936002)(8746002)(50226002)(356004)(8676002)(6116002)(3846002)(66066001)(81156014)(2906002)(99286004)(23756003)(316002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5238;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0bbacef3-e02d-45c5-bfac-08d7725f0d89
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZNRTydnp8+eUpqTWII7juzLzqFMmQTVc60npe5DX9DzH4khEte5xgHjWClWQGlV5FmjEu3HLoeD03cJz5v7bedkXd/j/wSOdgxcqCtgQrnwU+kY1Mqm+dW3Q6dbKywEqb8qMBNIKDr1UM7GFgyAkUREannxFUFKyv0mgtaOHSOvLUArvRNR6Q+R3x/teYsicIFMAI6oXuW2BLlzbyGHE62jj+8OI6tvjS/CurqjUGfLzDbtYpDTFN/+8xMmxo19GE3tbflMvJV2ynIpoiMhyOLnJT8p/qa4QyInmpii98I8h/FuhxHTaHD2kl81OWUZ0GR8LIj0ccl5PwwH4It/YaixDeNs84IePo5anTQ+TA8/2H5XFEOMMJ4qbtoAUHyoj9fNyC+Ik26A7xraS9dquXREDnyZLQUCeFnhiYiZihHkLmNhq4xE9Czchk8ytSzK
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 10:54:56.1792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f429dc60-8dab-4ac0-e4c0-08d7725f1306
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>

Split sysfs config_id bitfiles to multiple separated sysfs files.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/include/malidp_product.h  | 13 ---
 .../gpu/drm/arm/display/komeda/komeda_sysfs.c | 80 ++++++++++++++-----
 2 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers=
/gpu/drm/arm/display/include/malidp_product.h
index dbd3d4765065..b21f4aa15c95 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_product.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
@@ -21,17 +21,4 @@
 #define MALIDP_D71_PRODUCT_ID	0x0071
 #define MALIDP_D32_PRODUCT_ID	0x0032
=20
-union komeda_config_id {
-	struct {
-		__u32	max_line_sz:16,
-			n_pipelines:2,
-			n_scalers:2, /* number of scalers per pipeline */
-			n_layers:3, /* number of layers per pipeline */
-			n_richs:3, /* number of rich layers per pipeline */
-			side_by_side:1, /* if HW works on side_by_side mode */
-			reserved_bits:5;
-	};
-	__u32 value;
-};
-
 #endif /* _MALIDP_PRODUCT_H_ */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_sysfs.c
index 740f095b4ca5..5effab795dc1 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c
@@ -18,28 +18,67 @@ core_id_show(struct device *dev, struct device_attribut=
e *attr, char *buf)
 static DEVICE_ATTR_RO(core_id);
=20
 static ssize_t
-config_id_show(struct device *dev, struct device_attribute *attr, char *bu=
f)
+line_size_show(struct device *dev, struct device_attribute *attr, char *bu=
f)
 {
 	struct komeda_dev *mdev =3D dev_to_mdev(dev);
 	struct komeda_pipeline *pipe =3D mdev->pipelines[0];
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
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", pipe->layers[0]->hsize_in.end);
+}
+static DEVICE_ATTR_RO(line_size);
+
+static ssize_t
+n_pipelines_show(struct device *dev, struct device_attribute *attr, char *=
buf)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", mdev->n_pipelines);
+}
+static DEVICE_ATTR_RO(n_pipelines);
+
+static ssize_t
+n_layers_show(struct device *dev, struct device_attribute *attr, char *buf=
)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+	struct komeda_pipeline *pipe =3D mdev->pipelines[0];
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", pipe->n_layers);
+}
+static DEVICE_ATTR_RO(n_layers);
+
+static ssize_t
+n_rich_layers_show(struct device *dev, struct device_attribute *attr, char=
 *buf)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+	struct komeda_pipeline *pipe =3D mdev->pipelines[0];
+	int i, n_richs =3D 0;
+
+	for (i =3D 0; i < pipe->n_layers; i++)
 		if (pipe->layers[i]->layer_type =3D=3D KOMEDA_FMT_RICH_LAYER)
-			config_id.n_richs++;
-	}
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", config_id.value);
+			n_richs++;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", n_richs);
+}
+static DEVICE_ATTR_RO(n_rich_layers);
+
+static ssize_t
+n_scalers_show(struct device *dev, struct device_attribute *attr, char *bu=
f)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+	struct komeda_pipeline *pipe =3D mdev->pipelines[0];
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", pipe->n_scalers);
+}
+static DEVICE_ATTR_RO(n_scalers);
+
+static ssize_t
+side_by_side_show(struct device *dev, struct device_attribute *attr, char =
*buf)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", mdev->side_by_side);
 }
-static DEVICE_ATTR_RO(config_id);
+static DEVICE_ATTR_RO(side_by_side);
=20
 static ssize_t
 aclk_hz_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -52,7 +91,12 @@ static DEVICE_ATTR_RO(aclk_hz);
=20
 static struct attribute *komeda_sysfs_entries[] =3D {
 	&dev_attr_core_id.attr,
-	&dev_attr_config_id.attr,
+	&dev_attr_line_size.attr,
+	&dev_attr_n_pipelines.attr,
+	&dev_attr_n_layers.attr,
+	&dev_attr_n_rich_layers.attr,
+	&dev_attr_n_scalers.attr,
+	&dev_attr_side_by_side.attr,
 	&dev_attr_aclk_hz.attr,
 	NULL,
 };
--=20
2.20.1

