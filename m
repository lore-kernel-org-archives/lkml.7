Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E40BC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7C22DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfHTRqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:46:43 -0400
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:25497
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729833AbfHTRqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeAqChYb+xMSB36Is9YHtIowRWMUwlMz/dz4dVsxAb0=;
 b=WV1dUR4SxFLwNm13EEUupx+8Jl4JGJWzh8y3oi5MmHmI0m7v7C8quVPRhD4Fr/P+D1mrj/LLX4FY2pTx4vbfb4YXH6dfLKqrHln+hfvZc98356dQzf20kmRn9CO09SMNWsKhi0G5sgBXOYGDa6de43ggTigMEK6BIdkZuNV4/qw=
Received: from VI1PR08CA0265.eurprd08.prod.outlook.com (2603:10a6:803:dc::38)
 by VE1PR08MB4957.eurprd08.prod.outlook.com (2603:10a6:803:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Tue, 20 Aug
 2019 17:46:36 +0000
Received: from DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VI1PR08CA0265.outlook.office365.com
 (2603:10a6:803:dc::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Tue, 20 Aug 2019 17:46:36 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT039.mail.protection.outlook.com (10.152.21.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Tue, 20 Aug 2019 17:46:34 +0000
Received: ("Tessian outbound 578a71fe5eaa:v26"); Tue, 20 Aug 2019 17:46:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3e106def2ec4df2b
X-CR-MTA-TID: 64aa7808
Received: from be28f872337c.1 (cr-mta-lb-1.cr-mta-net [104.47.2.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AB360F74-5088-45AF-ADE2-1A366B85D7F7.1;
        Tue, 20 Aug 2019 17:46:21 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id be28f872337c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 20 Aug 2019 17:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSY6q4nUenKmmLmzH8i7vj+8QN/M+GMH+wgJIWViLnOIzOos73cSYglA4SByAcAFak8osNKptunCfS7tyUWgfAwymZxdJm/sp9oAULay9f/GCOI8tkEPg4tf0Ejt/1CDEGKiuvGaAQQAB6nQGJFrDSRnXuEteie1GvoGBjbN+DXVW8pjClnGeO4hkiqjSLkVFL6vIYibGiOixXMIJaz/9ZlYV0n0C/C8ANQYlpVNOpCG/XFSYqCbI2qgq36u/cS7OwoOQOvrH+5zYga2VmivVUGIvsq2PCqVmj+19QG1DQ0kKUTBZk8h16kZlhxzq4H5jv+dAsFS2Wzrsd0fAoOUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeAqChYb+xMSB36Is9YHtIowRWMUwlMz/dz4dVsxAb0=;
 b=mMtTOzUBTwfvjbuYPUqb+kjMYc5wELqnj5N1Q1F4i8aLsiTatgO2wL5u0UlgNMpVw3wuBEqfIk2uwSjpRVIv1DBUGMC610H5gNJqnlVR0MyGaGGko6PHCGymABdhtkUIWD1zfQ28pI8M5b105CbrQEqjz41OZaq02Rh5Rr0ZWE95KhSow7Ql78Y13SnOuSPrbcSQjcmYO1pXQpzVi/6QXymhLmG9nSGxrQBUkqqRWGsGJ5a3zezg8EuZvK9Z71UdltBsWrqZQ4wRr59bBWO/cnlY5jDa40qIm5lNifjP8jODw6Ns+tIk040KrgBfJfbrGw44rgDsbJr9d1vdtwQCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeAqChYb+xMSB36Is9YHtIowRWMUwlMz/dz4dVsxAb0=;
 b=WV1dUR4SxFLwNm13EEUupx+8Jl4JGJWzh8y3oi5MmHmI0m7v7C8quVPRhD4Fr/P+D1mrj/LLX4FY2pTx4vbfb4YXH6dfLKqrHln+hfvZc98356dQzf20kmRn9CO09SMNWsKhi0G5sgBXOYGDa6de43ggTigMEK6BIdkZuNV4/qw=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.212.135) by
 AM0PR08MB4065.eurprd08.prod.outlook.com (20.178.119.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 17:46:20 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::7532:a9e4:63b6:6a55]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::7532:a9e4:63b6:6a55%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 17:46:20 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [PATCH] drm/komeda: Reordered the komeda's de-init functions
Thread-Topic: [PATCH] drm/komeda: Reordered the komeda's de-init functions
Thread-Index: AQHVV38sxxLTSIs2FkGlnIkeXiN2Eg==
Date:   Tue, 20 Aug 2019 17:46:19 +0000
Message-ID: <20190820174606.1133-1-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::36) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::7)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f73be9d8-9d71-40db-8afa-08d7259657e4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB4065;
X-MS-TrafficTypeDiagnostic: AM0PR08MB4065:|VE1PR08MB4957:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB49570E67A6625A1F92D380FBE4AB0@VE1PR08MB4957.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:57;OLM:57;
x-forefront-prvs: 013568035E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(189003)(199004)(4326008)(2906002)(50226002)(7736002)(305945005)(71190400001)(71200400001)(36756003)(99286004)(256004)(14444005)(5024004)(8936002)(8676002)(81156014)(81166006)(6512007)(66446008)(64756008)(66556008)(66476007)(3846002)(6116002)(53936002)(1076003)(25786009)(110136005)(66946007)(86362001)(14454004)(52116002)(2201001)(316002)(2501003)(26005)(186003)(66066001)(44832011)(486006)(476003)(2616005)(5660300002)(6436002)(102836004)(6506007)(386003)(6486002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4065;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: qUxw3S9AZVLxbjMIFpTPNC+daCu3BvN0kahoiHD7KTsGx2AyqR/L7kzAqfF/qOahw0dEoViLzNoUQ83jYoKZEvnaH0CgGsLtDm04OWKcarpvwSXyltACh1mFft4KTGtG8zA9KjaOSVFWNlSj6wK44FHFGeSewfZrxgxyNnvyvMK6mZhJtauNpcQzHcHha8+mh9M3/z/fjzAvpW38SThIQU3XmCRIUNepWrJR5nNPQgtebO68/hk4KkvWE6cXxHl3e9yfW9QVCPQZBFIR4LuRMg5ghdLAz9jHp+yb3UP/qLjCrgY8QCwj28yOLJYLCHnt3i6qzTaHDmylMp414+HDhljbPk9Wj2uZWLts/Vf888FaC564VrBYq6UBaEDC+ccEbWDeBZxW8wUPCX9URhD3pXQ5dxWa30st/vKjF6kmIS0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4065
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(2980300002)(199004)(189003)(86362001)(50226002)(386003)(476003)(6506007)(23756003)(26005)(6512007)(336012)(6486002)(4326008)(316002)(2906002)(66066001)(14454004)(63370400001)(63350400001)(102836004)(36756003)(126002)(50466002)(478600001)(22756006)(2616005)(186003)(7736002)(8676002)(2201001)(305945005)(5024004)(14444005)(5660300002)(47776003)(25786009)(81156014)(81166006)(356004)(8936002)(486006)(26826003)(70586007)(3846002)(70206006)(6116002)(8746002)(1076003)(2501003)(76130400001)(110136005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4957;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7e3e3f1b-5373-4d10-f0d2-08d725964f07
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VE1PR08MB4957;
NoDisclaimer: True
X-Forefront-PRVS: 013568035E
X-Microsoft-Antispam-Message-Info: 9dkhc0UuA4Y0nfBcx48k/2jL7GKW3YPxAVlx+CoytKWvHp4Jn5ofmTQTCOd9JF127Z1D9mkzWujhQZeu+VA5zMFGiBnftl2ih5WOU60PnBOXUCXCJAuIJJm4X6d+FKEv6V8ikDDrBIrCFmvfSzTct1rU6111ALn5KPi4wAXTbK+98imQ1WVSTJiE4Lo9FVManbVls+4hz6fKx8izJzHmRW1UhYKtt/MA6j6c3z2IZfAOiDJmt4wt97/Bw+07FyEEQL+ncUB8hKv6pO6BltZNCprlESJZWhj+Ol7JoJXo7heJ4nkJs/FJ5xuM0SJ0urXnqIvbGlb7s8l1inHYSqmWo3jZv7moo0DxjljbaaohG2rBhAgvDd2Yk6+EziYMnx21nNqVPZk52ebzvYVG2tdy/UGmMx7nrDcvDeqfjhIYSL0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2019 17:46:34.5601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f73be9d8-9d71-40db-8afa-08d7259657e4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The de-init routine should be doing the following in order:-
1. Unregister the drm device
2. Shut down the crtcs - failing to do this might cause a connector leakage
See the 'commit 109c4d18e574 ("drm/arm/malidp: Ensure that the crtcs are
shutdown before removing any encoder/connector")'
3. Disable the interrupts
4. Unbind the components
5. Free up DRM mode_config info

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 89191a555c84..e219d1b67100 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -13,6 +13,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_irq.h>
 #include <drm/drm_vblank.h>
=20
@@ -304,24 +305,30 @@ struct komeda_kms_dev *komeda_kms_attach(struct komed=
a_dev *mdev)
 			       komeda_kms_irq_handler, IRQF_SHARED,
 			       drm->driver->name, drm);
 	if (err)
-		goto cleanup_mode_config;
+		goto free_component_binding;
=20
 	err =3D mdev->funcs->enable_irq(mdev);
 	if (err)
-		goto cleanup_mode_config;
+		goto free_component_binding;
=20
 	drm->irq_enabled =3D true;
=20
 	err =3D drm_dev_register(drm, 0);
 	if (err)
-		goto cleanup_mode_config;
+		goto free_interrupts;
=20
 	return kms;
=20
-cleanup_mode_config:
+free_interrupts:
 	drm->irq_enabled =3D false;
+	mdev->funcs->disable_irq(mdev);
+free_component_binding:
+	component_unbind_all(mdev->dev, drm);
+cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
 	komeda_kms_cleanup_private_objs(kms);
+	drm->dev_private =3D NULL;
+	drm_dev_put(drm);
 free_kms:
 	kfree(kms);
 	return ERR_PTR(err);
@@ -332,12 +339,13 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
 	struct drm_device *drm =3D &kms->base;
 	struct komeda_dev *mdev =3D drm->dev_private;
=20
+	drm_dev_unregister(drm);
+	drm_atomic_helper_shutdown(drm);
 	drm->irq_enabled =3D false;
 	mdev->funcs->disable_irq(mdev);
-	drm_dev_unregister(drm);
 	component_unbind_all(mdev->dev, drm);
-	komeda_kms_cleanup_private_objs(kms);
 	drm_mode_config_cleanup(drm);
+	komeda_kms_cleanup_private_objs(kms);
 	drm->dev_private =3D NULL;
 	drm_dev_put(drm);
 }
--=20
2.21.0

