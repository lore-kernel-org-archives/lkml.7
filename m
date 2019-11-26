Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4845AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F181F20727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qSn+6wfZ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qSn+6wfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfKZNRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:14 -0500
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:44641
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728165AbfKZNRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P787VNlH7d2aYxO15L1R1Soowsg8PZrcEAWIXJ087W4=;
 b=qSn+6wfZID5ZlCos+n+y4zL8Fzjt419K8lVnbcgCSBOzVxkz5apr8gM9jAR5ZauSQzxPTzXuEAFes+ItMwi8X89QfUk+IxDSqaLRg8KIZ5J77z28nveHhXnMemJ4iXfeJJzJQntkaZSmHnSaXV2WqP6WjzGTRhO66wj7EKvv2Yk=
Received: from DB6PR0802CA0048.eurprd08.prod.outlook.com (2603:10a6:4:a3::34)
 by AM0PR08MB5313.eurprd08.prod.outlook.com (2603:10a6:208:17f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Tue, 26 Nov
 2019 13:17:07 +0000
Received: from VE1EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by DB6PR0802CA0048.outlook.office365.com
 (2603:10a6:4:a3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:17:07 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT013.mail.protection.outlook.com (10.152.19.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:17:07 +0000
Received: ("Tessian outbound dbe0f0961e8c:v33"); Tue, 26 Nov 2019 13:17:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: affa3eaeb7309305
X-CR-MTA-TID: 64aa7808
Received: from 053d1c1fc842.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B83F0D2B-6D92-422F-81DA-9412E3644710.1;
        Tue, 26 Nov 2019 13:16:59 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 053d1c1fc842.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBJbLMllsJUEua/SnzJDxeLu1qWbDI/svch0Srx9n2MhztOeZFG33TdvEerhzpyKJELFXFDvxQwR7SHeeAGSN162GE9O0+iU89gvUZy/ChqBB23FLL0dv7D1cizZZWWqkxhMGNfYjokdBJA6NYvOMUgNmHxz1YZIDyxl1X+hz2bN8g0FlQOcx0w/NmcD9+Mnqu9RUOv3w1sEdv2BVmatcFxwofc8+I4Za94N8D5SQZA+7Q55CYNd+wVVifzZzvrVKM7Xs+ZZio/LqclJV934CUSkphgGPsrtTaROMlINW2xM+1dfhzAG1cDL94bwAvCtacKwCA3S/4SZ8EYaVE5PXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P787VNlH7d2aYxO15L1R1Soowsg8PZrcEAWIXJ087W4=;
 b=QY647PFZ15qvI3lyuYvu1oOEJyxkA5IfBK6peEWNqPBM3NxN6/Y6UTw/y0pGVs079GIxZsRe6FBqH6SehhaMVo4i+Y/SPVNGy+me+keKJYjH2Mv1ITWcSZC799Fg32OlQoZgC5vpkR//1eYnMYyKiJBd9KHQJMiW3S6GJ5Aw64XExOIyq3dgO6tZ0xGuIMiyfsplpBOx/nawZAQz2nPeAKgzOKKkIovY+nAkTCm+R0PQSb/I75S7f1DdAfL8AOtfmltArUwI8Vh4KB1IXjK42SlUIkf1wqrJaqixmDGdkbKeq8CgF+yElg1YamUOtCDmXqfnQ8rvtbs2ggHuxS+lYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P787VNlH7d2aYxO15L1R1Soowsg8PZrcEAWIXJ087W4=;
 b=qSn+6wfZID5ZlCos+n+y4zL8Fzjt419K8lVnbcgCSBOzVxkz5apr8gM9jAR5ZauSQzxPTzXuEAFes+ItMwi8X89QfUk+IxDSqaLRg8KIZ5J77z28nveHhXnMemJ4iXfeJJzJQntkaZSmHnSaXV2WqP6WjzGTRhO66wj7EKvv2Yk=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:58 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:58 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 30/30] drm/komeda: Use drm_bridge interface for pipe outputs
Thread-Topic: [PATCH 30/30] drm/komeda: Use drm_bridge interface for pipe
 outputs
Thread-Index: AQHVpFu1/dwArMKc0027RihyptTKCg==
Date:   Tue, 26 Nov 2019 13:16:27 +0000
Message-ID: <20191126131541.47393-31-mihail.atanassov@arm.com>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
In-Reply-To: <20191126131541.47393-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0453.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::33) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bc53e6e-e9bd-448e-1728-08d77272effb
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|AM0PR08MB5313:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB531365B42C90825295FD8FF38F450@AM0PR08MB5313.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:124;OLM:124;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(6666004)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(5024004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: R5Felx19e0efcHzOKBgG5QUqHNPEFuhTW1e8Q9Si3tvavXXJnSLPHnwelU+27fAl35Wytmmi+nAniZdjT2DezQfMf96fkdHLo2VrU70s4DfXUZ9OwnBGE9WN9dgfBEQ+NWGaJK3bCQVwY4GtpMF8vaAw9GBKavnHw8emR0BvESFAiCOXTHipxz7pPbyLUgvfKQwp2zhRJEPy1PKd7XVOPoCJISHCrrAVvc0Qonf3BGra2/673EqpJ9kc4Bx3jMPSsRAnfv8jAgsN7hoU8f3m/NvCQYyCrOD2P9K3jpTO9yGPTnYNysbJrjKb5nY3/ZaZ9WmUmEmteMYbs6+8PeC9Fo9E9FpK/R1QmhlaWCY3moHtiPcX86CfaIeQWd946Xn88AekoQVR/WOl2pGEpyAQHqGGCJEnK3ZNIfFuglEeZE0uX8yZ5Zemg1oiAkC7I2Ky
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(2906002)(70586007)(5640700003)(3846002)(86362001)(54906003)(106002)(2351001)(36906005)(66066001)(7736002)(305945005)(23756003)(70206006)(478600001)(316002)(6116002)(8676002)(25786009)(47776003)(6486002)(76130400001)(26005)(102836004)(14454004)(26826003)(386003)(6506007)(76176011)(1076003)(4326008)(186003)(5660300002)(2501003)(6862004)(99286004)(2616005)(50226002)(50466002)(8746002)(6512007)(446003)(336012)(36756003)(11346002)(8936002)(5024004)(356004)(81156014)(6666004)(81166006)(22756006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5313;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3232a280-4c05-4c94-4486-08d77272d837
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sywenV0HRWHKZYLA8GU9iQVt7qyGUKeUp39Jjzn1vUoV0KfQsf6syoPH1Xj0bYeuViVI5CX9y6umduoaml3zNFuCf/Dm6C2nrgzINV/tvm9K2prLrNciWB/3HUJkxHygjed9SP0SFX8vSjkmqcbP9ObYvzbk1eKrQp5E7pdM5d+tYvrMwE7gtCOkboHPHUYKFvKg4pL/xAhs6XaBWFzommHAp99K7dRJ1HwWu2MnGc6BfAqHUzU8mbn0YSbO74ehAddb336TJraSzRccUmC8CpfFQheLlZPvKZ6og9tOeRYIcIUJI8fpXzS8RLrMU10mZDPvbb5VRHh4vfl6P0VAA9xbjL9fymDE33hNyMRWz5ZHLHwS8LILV2Hqz/HC7Xa80tpO4qnK7qmurzM8G/u9yMKrFqpvd+UO/WzRLznq1YsXbVt/rsbaPKGqoVRkKaHA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:17:07.2661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc53e6e-e9bd-448e-1728-08d77272effb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5313
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support more transmitters, we need to allow non-component framework
bridges to be attached to a dummy drm_encoder in our driver.

A/B tested for equivalence against tda998x, and also tested ti_tfp410 as
an alternate transmitter.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 54 ++++++-------
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 77 +++++++++++++++++--
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 +
 3 files changed, 100 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index d6c2222c5d33..2870123bef37 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -6,10 +6,10 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/of_graph.h>
 #include <linux/platform_device.h>
-#include <linux/component.h>
 #include <linux/pm_runtime.h>
-#include <drm/drm_of.h>
+#include <drm/drm_bridge.h>
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
@@ -72,35 +72,29 @@ static int komeda_bind(struct device *dev)
 	return err;
 }
=20
-static const struct component_master_ops komeda_master_ops =3D {
-	.bind	=3D komeda_bind,
-	.unbind	=3D komeda_unbind,
-};
-
-static int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node =3D=3D data;
-}
-
-static void komeda_add_slave(struct device *master,
-			     struct component_match **match,
-			     struct device_node *np,
-			     u32 port, u32 endpoint)
+static int komeda_add_slave(struct device_node *np, u32 port, u32 endpoint=
)
 {
 	struct device_node *remote;
+	struct drm_bridge *bridge;
+	int ret =3D 0;
=20
 	remote =3D of_graph_get_remote_node(np, port, endpoint);
-	if (remote) {
-		drm_of_component_match_add(master, match, compare_of, remote);
-		of_node_put(remote);
-	}
+	if (!remote)
+		return 0;
+
+	bridge =3D of_drm_find_bridge(remote);
+	if (!bridge)
+		ret =3D -EPROBE_DEFER;
+
+	of_node_put(remote);
+	return ret;
 }
=20
 static int komeda_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
-	struct component_match *match =3D NULL;
 	struct device_node *child;
+	int ret;
=20
 	if (!dev->of_node)
 		return -ENODEV;
@@ -109,17 +103,25 @@ static int komeda_platform_probe(struct platform_devi=
ce *pdev)
 		if (of_node_cmp(child->name, "pipeline") !=3D 0)
 			continue;
=20
-		/* add connector */
-		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT, 0);
-		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT, 1);
+		/* attach any remote devices if present */
+		ret =3D komeda_add_slave(child, KOMEDA_OF_PORT_OUTPUT, 0);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+		ret =3D komeda_add_slave(child, KOMEDA_OF_PORT_OUTPUT, 1);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
 	}
=20
-	return component_master_add_with_match(dev, &komeda_master_ops, match);
+	return komeda_bind(dev);
 }
=20
 static int komeda_platform_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &komeda_master_ops);
+	komeda_unbind(&pdev->dev);
 	return 0;
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index e30a5b43caa9..2fc6cd9956fd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -4,8 +4,8 @@
  * Author: James.Qian.Wang <james.qian.wang@arm.com>
  *
  */
-#include <linux/component.h>
 #include <linux/interrupt.h>
+#include <linux/of_graph.h>
=20
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -14,6 +14,9 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_irq.h>
+#include <drm/drm_of.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
=20
@@ -257,6 +260,69 @@ static void komeda_kms_mode_config_init(struct komeda_=
kms_dev *kms,
 	config->helper_private =3D &komeda_mode_config_helpers;
 }
=20
+static void komeda_encoder_destroy(struct drm_encoder *encoder)
+{
+	drm_encoder_cleanup(encoder);
+}
+
+static const struct drm_encoder_funcs komeda_dummy_enc_funcs =3D {
+	.destroy =3D komeda_encoder_destroy,
+};
+
+static int komeda_encoder_attach_bridge(struct komeda_dev *mdev,
+					struct komeda_kms_dev *kms,
+					struct drm_encoder *encoder,
+					struct device_node *np)
+{
+	struct device_node *remote;
+	struct drm_bridge *bridge;
+	u32 crtcs =3D 0;
+	int ret =3D 0;
+
+	remote =3D of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
+	if (!remote)
+		return 0;
+
+	bridge =3D of_drm_find_bridge_devlink(&kms->base, remote);
+	if (!bridge) {
+		ret =3D -EINVAL;
+		goto exit;
+	}
+
+	crtcs =3D drm_of_find_possible_crtcs(&kms->base, remote);
+
+	encoder->possible_crtcs =3D crtcs ? crtcs : 1;
+
+	ret =3D drm_encoder_init(&kms->base, encoder, &komeda_dummy_enc_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret)
+		goto exit;
+
+	ret =3D drm_bridge_attach(encoder, bridge, NULL);
+	if (ret)
+		goto exit;
+
+exit:
+	of_node_put(remote);
+	return ret;
+}
+
+static int komeda_encoder_attach_bridges(struct komeda_kms_dev *kms,
+					 struct komeda_dev *mdev)
+{
+	int i, err;
+
+	for (i =3D 0; i < kms->n_crtcs; i++) {
+		err =3D komeda_encoder_attach_bridge(
+			mdev, kms,
+			&kms->encoders[i], mdev->pipelines[i]->of_node);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
 {
 	struct komeda_kms_dev *kms =3D kzalloc(sizeof(*kms), GFP_KERNEL);
@@ -295,7 +361,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_=
dev *mdev)
 	if (err)
 		goto cleanup_mode_config;
=20
-	err =3D component_bind_all(mdev->dev, kms);
+	err =3D komeda_encoder_attach_bridges(kms, mdev);
 	if (err)
 		goto cleanup_mode_config;
=20
@@ -305,11 +371,11 @@ struct komeda_kms_dev *komeda_kms_attach(struct komed=
a_dev *mdev)
 			       komeda_kms_irq_handler, IRQF_SHARED,
 			       drm->driver->name, drm);
 	if (err)
-		goto free_component_binding;
+		goto cleanup_mode_config;
=20
 	err =3D mdev->funcs->enable_irq(mdev);
 	if (err)
-		goto free_component_binding;
+		goto cleanup_mode_config;
=20
 	drm->irq_enabled =3D true;
=20
@@ -325,8 +391,6 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_=
dev *mdev)
 	drm_kms_helper_poll_fini(drm);
 	drm->irq_enabled =3D false;
 	mdev->funcs->disable_irq(mdev);
-free_component_binding:
-	component_unbind_all(mdev->dev, drm);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
 	komeda_kms_cleanup_private_objs(kms);
@@ -347,7 +411,6 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
 	drm_atomic_helper_shutdown(drm);
 	drm->irq_enabled =3D false;
 	mdev->funcs->disable_irq(mdev);
-	component_unbind_all(mdev->dev, drm);
 	drm_mode_config_cleanup(drm);
 	komeda_kms_cleanup_private_objs(kms);
 	drm->dev_private =3D NULL;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 456f3c435719..b40ba0f476b1 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -12,6 +12,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_device.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_writeback.h>
 #include <drm/drm_print.h>
=20
@@ -123,6 +124,7 @@ struct komeda_kms_dev {
 	int n_crtcs;
 	/** @crtcs: crtcs list */
 	struct komeda_crtc crtcs[KOMEDA_MAX_PIPELINES];
+	struct drm_encoder encoders[KOMEDA_MAX_PIPELINES];
 };
=20
 #define to_kplane(p)	container_of(p, struct komeda_plane, base)
--=20
2.23.0

