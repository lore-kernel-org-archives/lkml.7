Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083E3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8D520882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YFPZF0bE";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YFPZF0bE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfJUQrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:47:37 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:43654
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729203AbfJUQrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3V9noWMBRpfRoY49oT6UDQXbQXYaQlVevKp/l4BnO0=;
 b=YFPZF0bEjsvnl8jGivdvohf2ST2CFTc8CeOWpirnDyQMIcHOuQBArHvCNmL2/Mb3Qv5Rqb8IsUG1s7bjZJZ9l5vjcAr8R/pRdmoTnrXd9updP3JNx42i7n2pHb9varxHiLokq6g7rh+jJqTCoog8Q2RH/G9xYGqnch2zTYmvSZA=
Received: from AM6PR08CA0027.eurprd08.prod.outlook.com (2603:10a6:20b:c0::15)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.24; Mon, 21 Oct
 2019 16:47:31 +0000
Received: from AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by AM6PR08CA0027.outlook.office365.com
 (2603:10a6:20b:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 16:47:31 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT052.mail.protection.outlook.com (10.152.17.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Mon, 21 Oct 2019 16:47:30 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Mon, 21 Oct 2019 16:47:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d78833cbaa10bce8
X-CR-MTA-TID: 64aa7808
Received: from eb75fcf24e5c.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A2E6B801-A93A-4E86-9164-10572C3BB85B.1;
        Mon, 21 Oct 2019 16:47:21 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eb75fcf24e5c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 16:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSQV9/h+1vdCTNaSAmAUORQjM4SNA/f4gta6Znaorvr2GMCSiESLOjTk8uuo+ZBgfZG9K3XlWScusJsUoP4gcJK/mgOGzouU825OnkgatzYLMi0MdEQyFM8YOwJ0p4Wqz4QN3f0zY+z2+Teq1zXRQPF1qn5K0V0VFgneWaccbLvjfp3IcBoaUzrHK4M8ONrfdd5jQETOYlwqZySm2YXG/zgVJziKBQSQiO33fuvNMbBWGahCsKRgWFmtlAaE6hthJe8Ukp80HV/MsJIcoIBElvihmPfOGj+qFZ0Wx3IOcVb9UM9+G/HG7wwePVrQ53zWXMKu6jOyoXnxPiAFoOvOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3V9noWMBRpfRoY49oT6UDQXbQXYaQlVevKp/l4BnO0=;
 b=UXStiOLzEU+PCSEQTa+8ZrA1SLE60sLUdMDhvIEkx0XWRc+heWOKzt6OjoHhu4oLFr66XUWVbYWge2JqB/jd7PJib78+aqpsi9StqYPg2nRLV8AlS0RMbQD0l5hB0TMKfb1ZQKENzAsLGLd9fIw57F4e7JLBi8DMAFG9GWQdP/t1cpm0sG8eBG010sKLsY0rHvOJgZXnPHWKaF9vEmOP3HER6adXRmmdKoEIy7w9NZLrzccSZL8ISUegJr/5ElwJR/CHMol/Pi4bVDk2YoxdPIgUvLKGqc0aluGpu2JMLWxBgd58OeijxOVLyFlfufcaY3L0pAe8kzPKHpW7stl5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3V9noWMBRpfRoY49oT6UDQXbQXYaQlVevKp/l4BnO0=;
 b=YFPZF0bEjsvnl8jGivdvohf2ST2CFTc8CeOWpirnDyQMIcHOuQBArHvCNmL2/Mb3Qv5Rqb8IsUG1s7bjZJZ9l5vjcAr8R/pRdmoTnrXd9updP3JNx42i7n2pHb9varxHiLokq6g7rh+jJqTCoog8Q2RH/G9xYGqnch2zTYmvSZA=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3693.eurprd08.prod.outlook.com (20.178.13.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 21 Oct 2019 16:47:19 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 16:47:19 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] drm/komeda: Remove CONFIG_KOMEDA_ERROR_PRINT
Thread-Topic: [PATCH 2/5] drm/komeda: Remove CONFIG_KOMEDA_ERROR_PRINT
Thread-Index: AQHViC80o3rsgkgVM0CzSwA5fpvmTw==
Date:   Mon, 21 Oct 2019 16:47:19 +0000
Message-ID: <20191021164654.9642-3-mihail.atanassov@arm.com>
References: <20191021164654.9642-1-mihail.atanassov@arm.com>
In-Reply-To: <20191021164654.9642-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::15) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 23812715-157e-4071-f25f-08d756465ce4
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3693:|VI1PR08MB3693:|AM6PR08MB4850:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4850EA5539F45FA509880F1F8F690@AM6PR08MB4850.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1051;OLM:1051;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(11346002)(6436002)(316002)(54906003)(256004)(8936002)(6512007)(14444005)(2501003)(71200400001)(5640700003)(71190400001)(50226002)(486006)(2906002)(446003)(6486002)(2616005)(44832011)(5660300002)(8676002)(476003)(305945005)(66066001)(36756003)(86362001)(25786009)(14454004)(186003)(478600001)(6506007)(386003)(102836004)(26005)(4326008)(2351001)(81156014)(1076003)(6116002)(3846002)(66946007)(81166006)(66556008)(52116002)(66476007)(7736002)(64756008)(66446008)(99286004)(76176011)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3693;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: g3WiCLgsbKoApXfA2UA3urdyAfQO0BPdci21FtjmX9GR0cbejAqeM+sQJhbcqaIewfSyd2OO96h18P9RcsbWct17rcL738xILGF4nFYVEr2zWCAFGGEvWn9eLhWvkbYWW0LmsPt6opAySot00T0juxDLIHXMke2bqakOjznrLL7oMEnGGlwqE47utRv1V18uLvVxLUxK5T7G0IwfHMzGZ4wAu3CnUHOamfWHoa3Jo+Zdi77WvYVxpZlwr06WstOGy2Qo/Hccg620naUQRxhsv0DQD8zBTwIEy9dTsC7D/LFRa1lmEyuVYnRhpzZhWHWaagdjkgShuRu773xd85JdcXCkuFnpOkEFWPxAk2hSy46gZlEZiciQI57EN6Gpx5EGULUN8/woDMJHMjhj/Xrat2MJKTYqGoOWn3kGEmb7hK9RkAAmq1Wys71BZQdo21K7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3693
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(7736002)(305945005)(6116002)(22756006)(3846002)(6862004)(4326008)(6486002)(99286004)(47776003)(76176011)(23756003)(54906003)(316002)(6512007)(5640700003)(36756003)(36906005)(2906002)(50466002)(25786009)(478600001)(81156014)(8746002)(81166006)(8936002)(8676002)(26826003)(86362001)(14454004)(446003)(11346002)(1076003)(50226002)(356004)(5660300002)(2616005)(386003)(6506007)(102836004)(26005)(336012)(14444005)(63350400001)(2501003)(486006)(126002)(66066001)(70206006)(70586007)(76130400001)(2351001)(476003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4850;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7fd0f2a2-b54f-4f90-6dbb-08d75646566f
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKFyQil1ZjoPMZPQmSmEg3v6BUnsR9yJgPHRftX1GA/W82HaYa/eUZ/7C2WQkx1xWMG0PgDOi8C2pBMgsbtXaR84tmEjnPL1gMSkP8CV/2yB+BpmHBFMHaDddm45i4kdJylFv/DEJtymGSjSu3KUctGpWj9Bi90FX2sDCiFlFghx5PaL1YW2yQRuLI6cGVz9xcRqTXFYfNa/9e3XyE5FyqPpcMdyrdCb+UlS6VsWRpEhuVL5nKSy0r6GmBJqs/4lwCN0QqUVY7a28GpovJFDBDc0y95ZhGROJpfqMNKPsJguA1ZRUdXGRBC0SamkTzbbt1ajvZuuLKb5LBimtukgyOdMLCrN+wCR+xbx6NiMEg0KGxmjiDWYeGG9ZCJ/AA3nwjqE/Drw+x2GGOne1vY3Ms3lU5GPhFJjcqF6vJHAxjUAZ34Q1QrwQZhk8ewLdWWb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 16:47:30.1861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23812715-157e-4071-f25f-08d756465ce4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there's a debugfs node to control the same, remove the
config option.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/Kconfig             | 6 ------
 drivers/gpu/drm/arm/display/komeda/Makefile     | 5 ++---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 6 ------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/Kconfig b/drivers/gpu/drm/arm/disp=
lay/Kconfig
index e87ff8623076..cec0639e3aa1 100644
--- a/drivers/gpu/drm/arm/display/Kconfig
+++ b/drivers/gpu/drm/arm/display/Kconfig
@@ -12,9 +12,3 @@ config DRM_KOMEDA
 	  Processor driver. It supports the D71 variants of the hardware.
=20
 	  If compiled as a module it will be called komeda.
-
-config DRM_KOMEDA_ERROR_PRINT
-	bool "Enable komeda error print"
-	depends on DRM_KOMEDA
-	help
-	  Choose this option to enable error printing.
diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index f095a1c68ac7..1931a7fa1a14 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -16,12 +16,11 @@ komeda-y :=3D \
 	komeda_crtc.o \
 	komeda_plane.o \
 	komeda_wb_connector.o \
-	komeda_private_obj.o
+	komeda_private_obj.o \
+	komeda_event.o
=20
 komeda-y +=3D \
 	d71/d71_dev.o \
 	d71/d71_component.o
=20
-komeda-$(CONFIG_DRM_KOMEDA_ERROR_PRINT) +=3D komeda_event.o
-
 obj-$(CONFIG_DRM_KOMEDA) +=3D komeda.o
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index b5bd3d5898ee..831c375180f8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -226,13 +226,7 @@ void komeda_dev_destroy(struct komeda_dev *mdev);
=20
 struct komeda_dev *dev_to_mdev(struct device *dev);
=20
-#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
 void komeda_print_events(struct komeda_events *evts, struct drm_device *de=
v);
-#else
-static inline void komeda_print_events(struct komeda_events *evts,
-				       struct drm_device *dev)
-{}
-#endif
=20
 int komeda_dev_resume(struct komeda_dev *mdev);
 int komeda_dev_suspend(struct komeda_dev *mdev);
--=20
2.23.0

