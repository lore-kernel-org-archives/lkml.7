Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB97CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E0E20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CIgzUwOc";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CIgzUwOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfKNIh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:37:56 -0500
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:41243
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbfKNIhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3++1QZdC80NGy6G5njjTcDA6GCim0mGQCIXwovXYvEE=;
 b=CIgzUwOcwMpdVL6p5YeyT6h2wjSZF1skpGTjnNOs1vgI54UT3SWXc/zAKxe3UsXJhwjJO0/H4cNz3ps5qGbHqAUFeiKqyUY3Dtf79fVyCAPTzSWBZ1JmMrQTc+Q3gNN4eHM7a46XjNQxQwHgnFNms3w9hGib3yVBUOv6p2Fb7RA=
Received: from VI1PR0802CA0001.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::11) by DB7PR08MB3387.eurprd08.prod.outlook.com
 (2603:10a6:10:45::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 14 Nov
 2019 08:37:48 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR0802CA0001.outlook.office365.com
 (2603:10a6:800:aa::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Thu, 14 Nov 2019 08:37:48 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 08:37:48 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Thu, 14 Nov 2019 08:37:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d691436bd38737d0
X-CR-MTA-TID: 64aa7808
Received: from 80036d3a1b23.2 (cr-mta-lb-1.cr-mta-net [104.47.6.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 35374780-B310-4321-9BF4-484ACFA5DAA5.1;
        Thu, 14 Nov 2019 08:37:40 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 80036d3a1b23.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Nov 2019 08:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz8TGmBtQ8CyinHK4JjAs/uQT4m7VOOi9RwL9HtT4BY+2SeZvnEpUPe9Qr+jd/wqYjZ2ToZOKNQfM6lwBDqPh1r6TwQnjSE6kiAWkuPEim1nX5fIXEtK7tPJP/GGZ0b6UkHgfKiE9VTBbwBFHXlKIbmBqNiHvxOqrg88k+UnKb63k936NoO1hhkbwjIt21zqC7KsFIybN/wMZrOCdCfAjeenvZ4ne+umATldpQp/v7vJeIt7QpLIENQgDEwyjigjxXqYIs+bSFvPEEfxlhWSuyZucAwWbQ67PnuTiNq4vc4Y32qtjwPrD6/Wm5vJIZbr9vUwd5l1I36IXTHXsLKHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3++1QZdC80NGy6G5njjTcDA6GCim0mGQCIXwovXYvEE=;
 b=h0XiO6ZqIdY82Da6lcKTLWoof2bxBPuL6xZIVoW5P2dlbdOt4cglsC5sDkMyIb9x7gaRsjuCPVJK672zN/sQLXwAHuciuxEgDiEf7XgY73cPMnNiYphhEl/srry7K+6Xz9rp6wM5PDRODQi5j3o6NOctahmT1n1oJ53snPmtJNu/QQXa1p/VuNfweu0MD9qTcoMDPYxZRgVrmn6o4n1R4PpaHv3nt9XPl4uJ98QVe05nBRGsBs9W245Oy58CfSjJ2BNof9aFE8p+Ih3RSPN2DQGubIdue0uMJLjL7wlxGHBKYtW2+2qTBgaPN5yQV5m+iL07teygOLNim9T7b28auA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3++1QZdC80NGy6G5njjTcDA6GCim0mGQCIXwovXYvEE=;
 b=CIgzUwOcwMpdVL6p5YeyT6h2wjSZF1skpGTjnNOs1vgI54UT3SWXc/zAKxe3UsXJhwjJO0/H4cNz3ps5qGbHqAUFeiKqyUY3Dtf79fVyCAPTzSWBZ1JmMrQTc+Q3gNN4eHM7a46XjNQxQwHgnFNms3w9hGib3yVBUOv6p2Fb7RA=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4782.eurprd08.prod.outlook.com (10.255.115.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 14 Nov 2019 08:37:38 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 08:37:38 +0000
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
Subject: [PATCH v3 3/6] drm/komeda: Build side by side display output pipeline
Thread-Topic: [PATCH v3 3/6] drm/komeda: Build side by side display output
 pipeline
Thread-Index: AQHVmsbFPlVD5fCaoUuaMu14YyMtdg==
Date:   Thu, 14 Nov 2019 08:37:38 +0000
Message-ID: <20191114083658.27237-4-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13faa52b-dc90-46d1-f2d6-08d768ddede4
X-MS-TrafficTypeDiagnostic: VE1PR08MB4782:|VE1PR08MB4782:|DB7PR08MB3387:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3387A6B02F7768EFE23A03CFB3710@DB7PR08MB3387.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1284;OLM:1284;
x-forefront-prvs: 02213C82F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39850400004)(366004)(396003)(189003)(199004)(25786009)(486006)(66476007)(66446008)(66946007)(66556008)(64756008)(66066001)(11346002)(4326008)(386003)(6636002)(8936002)(446003)(2616005)(476003)(305945005)(14454004)(2501003)(478600001)(36756003)(7736002)(1076003)(5660300002)(54906003)(256004)(14444005)(316002)(6436002)(6512007)(71190400001)(52116002)(71200400001)(110136005)(76176011)(8676002)(102836004)(6506007)(6486002)(2201001)(55236004)(50226002)(103116003)(26005)(86362001)(186003)(3846002)(2906002)(81166006)(81156014)(6116002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4782;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: m9v+1TC8Nyk7tYssII/MOs6xNDuLqiFamvEiPHfOYeGLijW+FaKqcfNZk7MCNpxqj/O5R4CkMZfs9jmrXGFvEPwfJTNRBfb0ShH051FmaO67u4Pce5R3kRi5ju4byHM5TS9sc93D2KVMUmJybYmBgUyfnxI27ETKHUhI4q4Ny4yuJ1TBXvEPxEDkpvdJqKTXfmBhdvt0pGI97j+raVGMRlecCKDeLIgBb8PmTMK1cHFcM/h2U12oeEU6QM7OCZ94EzrGGAlteU91Lqg5wPX9AKd0HJND4ynaPaXvjwpx9ynBXMSO+0MSIh9UwQ5d9uCya8gPo8YT8Q19mQ1arc1+p6Z9DoRdrnt6N7ekf5xJ0rG0zi3H3lU5W4SzRg5wooe9GyJEAmavicYOMvvQ17R3zTUDWQNIABfsvnUKEPTDszX2F7scTFNT1FJhuQV7c8LN
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4782
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(1110001)(339900001)(189003)(199004)(316002)(126002)(486006)(23756003)(47776003)(36906005)(99286004)(66066001)(5660300002)(11346002)(6486002)(70206006)(476003)(2616005)(105606002)(446003)(103116003)(26826003)(1076003)(70586007)(54906003)(110136005)(3846002)(14454004)(7736002)(6116002)(25786009)(76130400001)(2906002)(478600001)(305945005)(50466002)(8746002)(8676002)(8936002)(81166006)(81156014)(50226002)(36756003)(86362001)(2201001)(356004)(2501003)(4326008)(186003)(76176011)(102836004)(22756006)(14444005)(6512007)(336012)(26005)(6506007)(386003)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3387;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 15fa1217-cc37-4e47-84d6-08d768dde7ce
NoDisclaimer: True
X-Forefront-PRVS: 02213C82F8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uH5rMvi+kTn5GLXfPMn7FLRjy6YbbspAjt9+qbLafONV63U36dmdRgJNbXNgx5jsF18oToVfb+cupGKGuGYYkxRn0Ddobfb3y4A0VZiDkHvZoEB0Ekx1Sxa9FEk450OtBykId341l0QXkXUJm2wqBfgiYo/9w+ZSb/vQN+09T4F49c7O01CXdabESbKk+o8TFoiIsi8Rv/gKF1skdlHtQe44qI/dZ6hDkEehXyWW8n9CYPwyuHJXifigp5WzgBPWCmE6+Un4ulx4YwGWZY6MvJSyXYJD7lrfbPfaeslbeU932y1r6My4rVGS86eSx2Jp4lVfE3r36pWMoSzfo88ZaKf+9jVsqBkqg0EmZtCcAKYyY5vBxj3FOqZ4jOP1KYeSag9fqkB660mRSYobfB+p9vA6fHicEuj78ytiLk76dJeE5Mwd2rW2nPI6ybXTNJdo
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 08:37:48.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13faa52b-dc90-46d1-f2d6-08d768ddede4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For side by side, the slave pipeline merges to master via image processor

 slave-layers -> slave-compiz-> slave-improc-
                                             \
 master-layers -> master-compiz -------------> master-improc ->

v3: Rebase.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../arm/display/komeda/d71/d71_component.c    |  4 ++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 18 +++++--
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 .../display/komeda/komeda_pipeline_state.c    | 51 ++++++++++++++-----
 .../arm/display/komeda/komeda_wb_connector.c  |  2 +-
 5 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index b6517c46e670..6dadf4413ef3 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -1085,6 +1085,10 @@ static void d71_improc_update(struct komeda_componen=
t *c,
 	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB444)
 		ctrl |=3D IPS_CTRL_YUV;
=20
+	/* slave input has been enabled, means side by side */
+	if (has_bit(1, state->active_inputs))
+		ctrl |=3D IPS_CTRL_SBS;
+
 	malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index cee9a1692e71..24928b922fbd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -385,15 +385,23 @@ komeda_crtc_atomic_flush(struct drm_crtc *crtc,
 	komeda_crtc_do_flush(crtc, old);
 }
=20
-/* Returns the minimum frequency of the aclk rate (main engine clock) in H=
z */
+/*
+ * Returns the minimum frequency of the aclk rate (main engine clock) in H=
z.
+ *
+ * The DPU output can be split into two halves, to stay within the bandwid=
th
+ * capabilities of the external link (dual-link mode).
+ * In these cases, each output link runs at half the pixel clock rate of t=
he
+ * combined display, and has half the number of pixels.
+ * Beside split the output, the DPU internal pixel processing also can be =
split
+ * into two halves (LEFT/RIGHT) and handles by two pipelines simultaneousl=
y.
+ * So if side by side, the pipeline (main engine clock) also can run at ha=
lf
+ * the clock rate of the combined display.
+ */
 static unsigned long
 komeda_calc_min_aclk_rate(struct komeda_crtc *kcrtc,
 			  unsigned long pxlclk)
 {
-	/* Once dual-link one display pipeline drives two display outputs,
-	 * the aclk needs run on the double rate of pxlclk
-	 */
-	if (kcrtc->master->dual_link)
+	if (kcrtc->master->dual_link && !kcrtc->side_by_side)
 		return pxlclk * 2;
 	else
 		return pxlclk;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 4c0946fbaac1..59a81b4476df 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -540,6 +540,7 @@ struct komeda_crtc_state;
 struct komeda_crtc;
=20
 void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
+			       bool side_by_side,
 			       u16 *hsize, u16 *vsize);
=20
 int komeda_build_layer_data_flow(struct komeda_layer *layer,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 5de0d231a1c3..4dbf71455d1d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -654,12 +654,13 @@ komeda_merger_validate(struct komeda_merger *merger,
 }
=20
 void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
+			       bool side_by_side,
 			       u16 *hsize, u16 *vsize)
 {
 	struct drm_display_mode *m =3D &kcrtc_st->base.adjusted_mode;
=20
 	if (hsize)
-		*hsize =3D m->hdisplay;
+		*hsize =3D side_by_side ? m->hdisplay / 2 : m->hdisplay;
 	if (vsize)
 		*vsize =3D m->vdisplay;
 }
@@ -670,12 +671,14 @@ komeda_compiz_set_input(struct komeda_compiz *compiz,
 			struct komeda_data_flow_cfg *dflow)
 {
 	struct drm_atomic_state *drm_st =3D kcrtc_st->base.state;
+	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
 	struct komeda_component_state *c_st, *old_st;
 	struct komeda_compiz_input_cfg *cin;
 	u16 compiz_w, compiz_h;
 	int idx =3D dflow->blending_zorder;
=20
-	pipeline_composition_size(kcrtc_st, &compiz_w, &compiz_h);
+	pipeline_composition_size(kcrtc_st, to_kcrtc(crtc)->side_by_side,
+				  &compiz_w, &compiz_h);
 	/* check display rect */
 	if ((dflow->out_x + dflow->out_w > compiz_w) ||
 	    (dflow->out_y + dflow->out_h > compiz_h) ||
@@ -687,7 +690,7 @@ komeda_compiz_set_input(struct komeda_compiz *compiz,
 	}
=20
 	c_st =3D komeda_component_get_state_and_set_user(&compiz->base, drm_st,
-			kcrtc_st->base.crtc, kcrtc_st->base.crtc);
+			crtc, crtc);
 	if (IS_ERR(c_st))
 		return PTR_ERR(c_st);
=20
@@ -721,17 +724,19 @@ komeda_compiz_validate(struct komeda_compiz *compiz,
 		       struct komeda_crtc_state *state,
 		       struct komeda_data_flow_cfg *dflow)
 {
+	struct drm_crtc *crtc =3D state->base.crtc;
 	struct komeda_component_state *c_st;
 	struct komeda_compiz_state *st;
=20
 	c_st =3D komeda_component_get_state_and_set_user(&compiz->base,
-			state->base.state, state->base.crtc, state->base.crtc);
+			state->base.state, crtc, crtc);
 	if (IS_ERR(c_st))
 		return PTR_ERR(c_st);
=20
 	st =3D to_compiz_st(c_st);
=20
-	pipeline_composition_size(state, &st->hsize, &st->vsize);
+	pipeline_composition_size(state, to_kcrtc(crtc)->side_by_side,
+				  &st->hsize, &st->vsize);
=20
 	komeda_component_set_output(&dflow->input, &compiz->base, 0);
=20
@@ -757,7 +762,8 @@ komeda_compiz_validate(struct komeda_compiz *compiz,
 static int
 komeda_improc_validate(struct komeda_improc *improc,
 		       struct komeda_crtc_state *kcrtc_st,
-		       struct komeda_data_flow_cfg *dflow)
+		       struct komeda_data_flow_cfg *m_dflow,
+		       struct komeda_data_flow_cfg *s_dflow)
 {
 	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
 	struct drm_crtc_state *crtc_st =3D &kcrtc_st->base;
@@ -771,8 +777,8 @@ komeda_improc_validate(struct komeda_improc *improc,
=20
 	st =3D to_improc_st(c_st);
=20
-	st->hsize =3D dflow->in_w;
-	st->vsize =3D dflow->in_h;
+	st->hsize =3D m_dflow->in_w;
+	st->vsize =3D m_dflow->in_h;
=20
 	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
 		u32 output_depths, output_formats;
@@ -808,8 +814,10 @@ komeda_improc_validate(struct komeda_improc *improc,
 		drm_ctm_to_coeffs(kcrtc_st->base.ctm, st->ctm_coeffs);
 	}
=20
-	komeda_component_add_input(&st->base, &dflow->input, 0);
-	komeda_component_set_output(&dflow->input, &improc->base, 0);
+	komeda_component_add_input(&st->base, &m_dflow->input, 0);
+	if (s_dflow)
+		komeda_component_add_input(&st->base, &s_dflow->input, 1);
+	komeda_component_set_output(&m_dflow->input, &improc->base, 0);
=20
 	return 0;
 }
@@ -1146,7 +1154,7 @@ komeda_split_sbs_master_data_flow(struct komeda_crtc_=
state *kcrtc_st,
 	u32 disp_end =3D master->out_x + master->out_w;
 	u16 boundary;
=20
-	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+	pipeline_composition_size(kcrtc_st, true, &boundary, NULL);
=20
 	if (disp_end <=3D boundary) {
 		/* the master viewport only located in master side, no need
@@ -1209,7 +1217,7 @@ komeda_split_sbs_slave_data_flow(struct komeda_crtc_s=
tate *kcrtc_st,
 {
 	u16 boundary;
=20
-	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+	pipeline_composition_size(kcrtc_st, true, &boundary, NULL);
=20
 	if (slave->out_x < boundary) {
 		DRM_DEBUG_ATOMIC("SBS Slave plane is only allowed to configure the right=
 part frame.\n");
@@ -1384,7 +1392,20 @@ int komeda_build_display_data_flow(struct komeda_crt=
c *kcrtc,
 	memset(&m_dflow, 0, sizeof(m_dflow));
 	memset(&s_dflow, 0, sizeof(s_dflow));
=20
-	if (slave && has_bit(slave->id, kcrtc_st->active_pipes)) {
+	/* build slave output data flow */
+	if (kcrtc->side_by_side) {
+		/* on side by side, the slave data flows into the improc of
+		 * itself first, and then merge it into master's image processor
+		 */
+		err =3D komeda_compiz_validate(slave->compiz, kcrtc_st, &s_dflow);
+		if (err)
+			return err;
+
+		err =3D komeda_improc_validate(slave->improc, kcrtc_st,
+					     &s_dflow, NULL);
+		if (err)
+			return err;
+	} else if (slave && has_bit(slave->id, kcrtc_st->active_pipes)) {
 		err =3D komeda_compiz_validate(slave->compiz, kcrtc_st, &s_dflow);
 		if (err)
 			return err;
@@ -1400,7 +1421,9 @@ int komeda_build_display_data_flow(struct komeda_crtc=
 *kcrtc,
 	if (err)
 		return err;
=20
-	err =3D komeda_improc_validate(master->improc, kcrtc_st, &m_dflow);
+	/* on side by side, merge the slave dflow into master */
+	err =3D komeda_improc_validate(master->improc, kcrtc_st, &m_dflow,
+				     kcrtc->side_by_side ? &s_dflow : NULL);
 	if (err)
 		return err;
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index e465cc4879c9..17ea021488aa 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -21,7 +21,7 @@ komeda_wb_init_data_flow(struct komeda_layer *wb_layer,
 	dflow->out_h =3D fb->height;
=20
 	/* the write back data comes from the compiz */
-	pipeline_composition_size(kcrtc_st, &dflow->in_w, &dflow->in_h);
+	pipeline_composition_size(kcrtc_st, false, &dflow->in_w, &dflow->in_h);
 	dflow->input.component =3D &wb_layer->base.pipeline->compiz->base;
 	/* compiz doesn't output alpha */
 	dflow->pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
--=20
2.20.1

