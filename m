Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF21C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3E92189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mKAwPuxp";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mKAwPuxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfH1PAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:00:45 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:52896
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726394AbfH1PAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM1IEgb87yGxGmqT6sYLlZkZjBxtjy4yeyRXYt4Mt6c=;
 b=mKAwPuxpEplh6RAsyV4bEypVyEna80EeP5JSvVU/ObBlZnvwzjF42fjur90piydRo4gARoGGEcj67AelqAs/X65CPCODYoilBD8/ZzFG+IPpdr/V+ry6oA0A5vGha2qqPBnKWXDRLgYP2wacylc1Kl9TAzimfBLzDWhZTUpARJY=
Received: from AM6PR08CA0001.eurprd08.prod.outlook.com (2603:10a6:20b:b2::13)
 by DB6PR0802MB2599.eurprd08.prod.outlook.com (2603:10a6:4:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Wed, 28 Aug
 2019 15:00:37 +0000
Received: from DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by AM6PR08CA0001.outlook.office365.com
 (2603:10a6:20b:b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.14 via Frontend
 Transport; Wed, 28 Aug 2019 15:00:37 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT039.mail.protection.outlook.com (10.152.21.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Wed, 28 Aug 2019 15:00:35 +0000
Received: ("Tessian outbound aa6cb5c8f945:v27"); Wed, 28 Aug 2019 15:00:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ce30f03f349cbbe7
X-CR-MTA-TID: 64aa7808
Received: from a64bf5be92b7.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 738CCCAB-1CF4-4A87-99DC-284A7E01FF1D.1;
        Wed, 28 Aug 2019 15:00:25 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2051.outbound.protection.outlook.com [104.47.0.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a64bf5be92b7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 28 Aug 2019 15:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcNszn9gwKjyOxLOweNcRL2gbDpbGq9LFYtQTqU4DgPiTyHf/BuLvDSO17NevpN1euXyizPpLdCeudKUApTTAiXrosU7LekhazP/F47ka99AXz6zX+eCbCA1+EaLsowNh1O81khXzOLJy5hNYIUszHHT1hl0rIV59yKph+jfscsfBK7jTWoZVMUWBZwT3xquX1cI2S9LMw3nDWCMpT+i9IM2ZFS890rgHx45QKwcERgCa48aMIly9Zy9BSxAMpjCWbI2G0CKY5UgPL2SxrbFcClXKiSba9XCbNqrGDWWqK6nNXq/Zs7PUInZGAHtnZVYxv/OXMaENO8tt+XoCRF5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM1IEgb87yGxGmqT6sYLlZkZjBxtjy4yeyRXYt4Mt6c=;
 b=WvFXwapjgJ7wR9u13s5vjcu0k1dCDW11stl+BzwE7gQkSqKD6WhfKC34mdXQ0t2LrOYw8aU7l2NYse6Klbtl2Vi7L5WpddWPRrhXkuJvCezxe1YPx2yD6b2KaxeF2z6MQ1YLip06SHecNi6BI/rzDGTknoVB3RKkStBiX60vRUdgxRT1nw0yR9Elol76pAdDFhb9wLFE4xcVYLJR4CRog0893sWTL1bpmFQOLjRr36gwe1zJOTVq1aRd8XZv1K6CXQWNgOkOTrgJD/4bzbSEv2Np7cfGWoZpaaj7rliEl8bQD6lXE4atX1x/nKIaFzlGFfwpbCZ/J9mkQGhk564mGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM1IEgb87yGxGmqT6sYLlZkZjBxtjy4yeyRXYt4Mt6c=;
 b=mKAwPuxpEplh6RAsyV4bEypVyEna80EeP5JSvVU/ObBlZnvwzjF42fjur90piydRo4gARoGGEcj67AelqAs/X65CPCODYoilBD8/ZzFG+IPpdr/V+ry6oA0A5vGha2qqPBnKWXDRLgYP2wacylc1Kl9TAzimfBLzDWhZTUpARJY=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.212.135) by
 AM0PR08MB3955.eurprd08.prod.outlook.com (20.178.119.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 15:00:19 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::1de:178b:2ca:42e5]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::1de:178b:2ca:42e5%2]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 15:00:19 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Subject: [PATCH v2] drm/komeda: Reordered the komeda's de-init functions
Thread-Topic: [PATCH v2] drm/komeda: Reordered the komeda's de-init functions
Thread-Index: AQHVXbFOPtkOyMBO7Em37TZu77ub2Q==
Date:   Wed, 28 Aug 2019 15:00:19 +0000
Message-ID: <20190828145945.15904-1-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::25) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::7)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7de397b7-f250-4d05-818b-08d72bc87b33
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB3955;
X-MS-TrafficTypeDiagnostic: AM0PR08MB3955:|DB6PR0802MB2599:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2599D85E09533CABA8ED27A0E4A30@DB6PR0802MB2599.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:78;OLM:78;
x-forefront-prvs: 014304E855
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(66946007)(26005)(66556008)(102836004)(66476007)(64756008)(86362001)(52116002)(50226002)(99286004)(5660300002)(186003)(110136005)(1076003)(54906003)(6486002)(6436002)(316002)(3846002)(66446008)(2201001)(4326008)(478600001)(2906002)(476003)(66066001)(25786009)(2616005)(6506007)(5024004)(386003)(14454004)(486006)(6512007)(44832011)(71190400001)(6116002)(71200400001)(7736002)(81156014)(81166006)(8936002)(2501003)(36756003)(305945005)(256004)(14444005)(8676002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3955;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: DtlUvpQ/raR5nEkk0UAaVab5doBrb3G4hTOB54l3wcN0R/kjgF7Z0vM4hOF187wWAqWWLmIaT+WoJymVWpdvHwqyTZE6EulnbKXjh4w4mM4qCDmOAbKERASJBLivhfLxlo+DglZkP4lY8TQiyQ8OgYKdzGa/5VaI4PmV5p9SbK277yCHk7DO2oTc++Lpzv7uvV7TApGtbYWxC1CTwxsVIxJ3x1/mBGTxBsGayFmJ9Xninl1e1PfgqpM1E+3LRtviayiuul48bfCounm7XGk2/rT/mk4CZuiNMIR+vW18gn87Q29rF8lAY0Cf4Tu71FCEIN0ZNKtDtiV4qvwo8rZUMSmAZh0xq8ZZgu4GMi6AXDszkWMxLCG4AXOhPKk46Q+w7KcHDjbBuIrkwgVdWuXCn3sv1rxlgkdQ7qFDdrb1gV4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3955
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(199004)(189003)(356004)(8746002)(8936002)(50226002)(81156014)(81166006)(36756003)(14454004)(25786009)(6116002)(26826003)(14444005)(2201001)(26005)(86362001)(5024004)(7736002)(8676002)(305945005)(186003)(23756003)(99286004)(102836004)(478600001)(4326008)(6506007)(54906003)(386003)(110136005)(316002)(336012)(2501003)(50466002)(6512007)(63350400001)(486006)(126002)(476003)(2616005)(2906002)(76130400001)(47776003)(70586007)(6486002)(22756006)(1076003)(70206006)(3846002)(63370400001)(66066001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2599;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9461d39a-582f-4f1f-870b-08d72bc8715a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR0802MB2599;
NoDisclaimer: True
X-Forefront-PRVS: 014304E855
X-Microsoft-Antispam-Message-Info: GlohHSbiE5pAR/MTrnVnvTHnArTGDA+AXqeSh7TvYFgl/11T35WRVRiDc9+IcWkMCip9M6o3M1e7+KmBlpD9r1vz6nfepPRi9pmnQsgWr/ChaGWvifsHsjJov8THTqwoo6KD6RIxaoUU0ewG6Q7+dHrUqB4dT6ayckZ4Rponv686WwcY/5Rr8El5TMuKXB7c4/HiAyux+gFxxbnOmtsGSAFzbJEN22FPyDlDjxPJcgVc1V+2Bo6LYuVhCmq5XAQk45ZRbQAtP3XPRKEahX2yFcKnJnJoQfC0OaXGDRTv8HyHM+aa/icbFM2u9cfLjo/c1Y2dWqXcXmMLKuDlE49E65vvMK8OHSGZhrJyfLxKHuMnexkyqkGQvrF70z2TMX2YSUZJUJUJPbcd8eX6NsQcvq6dc4kvOMeNjj0gh6Tl7nQ=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2019 15:00:35.6100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de397b7-f250-4d05-818b-08d72bc87b33
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ayan Halder <Ayan.Halder@arm.com>

The de-init routine should be doing the following in order:-
1. Unregister the drm device
2. Shut down the crtcs - failing to do this might cause a connector leakage
See the 'commit 109c4d18e574 ("drm/arm/malidp: Ensure that the crtcs are
shutdown before removing any encoder/connector")'
3. Disable the interrupts
4. Unbind the components
5. Free up DRM mode_config info

Changes from v1:-
1. Re-ordered the header files inclusion
2. Rebased on top of the latest drm-misc-fixes

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 1f0e3f4e8d74..69d9e26c60c8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -14,8 +14,8 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_irq.h>
-#include <drm/drm_vblank.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
=20
 #include "komeda_dev.h"
 #include "komeda_framebuffer.h"
@@ -306,11 +306,11 @@ struct komeda_kms_dev *komeda_kms_attach(struct komed=
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
@@ -318,15 +318,21 @@ struct komeda_kms_dev *komeda_kms_attach(struct komed=
a_dev *mdev)
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
 	drm_kms_helper_poll_fini(drm);
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
@@ -337,13 +343,14 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
 	struct drm_device *drm =3D &kms->base;
 	struct komeda_dev *mdev =3D drm->dev_private;
=20
-	drm->irq_enabled =3D false;
-	mdev->funcs->disable_irq(mdev);
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
+	drm->irq_enabled =3D false;
+	mdev->funcs->disable_irq(mdev);
 	component_unbind_all(mdev->dev, drm);
-	komeda_kms_cleanup_private_objs(kms);
 	drm_mode_config_cleanup(drm);
+	komeda_kms_cleanup_private_objs(kms);
 	drm->dev_private =3D NULL;
 	drm_dev_put(drm);
 }
--=20
2.21.0

