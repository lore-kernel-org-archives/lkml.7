Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009A8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EBE2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BtYl6AfD";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BtYl6AfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfKZNRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:06 -0500
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:48843
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728165AbfKZNQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22yLRF+OD4SGmB+ZPAp6mmB9i3wb2rmCRZA/8wtNzW4=;
 b=BtYl6AfDKJf5AUHeLBp1Xu0b0ZWHwd5Kh/QJ2ght1+5FzJH9v/eKebCg67AEiuxR9pnVsPfjW9c/W9jwqIaldk62TvrQcyZFLoGTYcTXGwuleChjMm79AZ3MdtrY/77WSmKVoMNm4tOJlcekRAp4ILsksN029qCkcTxVAL8DDhE=
Received: from DB6PR0802CA0034.eurprd08.prod.outlook.com (2603:10a6:4:a3::20)
 by VI1PR0802MB2381.eurprd08.prod.outlook.com (2603:10a6:800:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Tue, 26 Nov
 2019 13:16:39 +0000
Received: from VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by DB6PR0802CA0034.outlook.office365.com
 (2603:10a6:4:a3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:39 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT012.mail.protection.outlook.com (10.152.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:39 +0000
Received: ("Tessian outbound f7868d7ede10:v33"); Tue, 26 Nov 2019 13:16:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d914095c1eeeccd7
X-CR-MTA-TID: 64aa7808
Received: from a4bda1e7f4c9.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 09D6DE19-468D-4F1F-B9A4-A85333043EAF.1;
        Tue, 26 Nov 2019 13:16:28 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2058.outbound.protection.outlook.com [104.47.4.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a4bda1e7f4c9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTvJXLYIp5rAgMJhpUqkBWq3XTa26jZ9m+gtVPjhbyA7cgnsQVLFfv38rkhHNWGnnDpumkBQdzZ1hlCXgKjtemyi64DDXZqmIGDpShjaZlfsGAHBoTPL87/TgxWrbuv/D5TMfMf0UoeLnHmBSefSzwfgdwVSK8/4ZuCJOsgwp1wqEqp2UY56mqia2D4Syq+bONRLO3+wXF3WHVcSqutNfNcJNwdNSy1plOfnG/rZFlk47zxkiohVxIWtGSNl5V9WFpeHmf3R3kKBYDBHrzwMJQV2uUXUsD8IzMbziF1nicFZhfvGo6n/qjgc/u13KaKetUHgAmBLEr1VdrjVI85hfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22yLRF+OD4SGmB+ZPAp6mmB9i3wb2rmCRZA/8wtNzW4=;
 b=K0B24MUoiItjJ47K++yO57G7RyvV4IPku5eQ5IFON30OWCql68WD16tLxn4oN1zojh5QVorDbdPYtRFvHcaFhRrkQEUrA9kksZeT0zItE+DiPd0lFcdnrCN/hQebo5N5Lq58l8RMSzivmwnDR+KgrDRa1Wf7Z+ISb3YUKF58XYk2IXbT00f4SmDOQn7CWAkpElKmFnC77+RJwL4YWXerdG0O2H8GLP8k4/Gi2WpJXmA1w0KmOQTs6dEo5T1jogFf8O/x01zkaxiBLRpQ/g/Apa76Yn8XdFnGe9LKxZOGZ2kq2ZJdq8TKv7hMdm19qWEUZ8whR1Ti/SJOEgEMA+W38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22yLRF+OD4SGmB+ZPAp6mmB9i3wb2rmCRZA/8wtNzW4=;
 b=BtYl6AfDKJf5AUHeLBp1Xu0b0ZWHwd5Kh/QJ2ght1+5FzJH9v/eKebCg67AEiuxR9pnVsPfjW9c/W9jwqIaldk62TvrQcyZFLoGTYcTXGwuleChjMm79AZ3MdtrY/77WSmKVoMNm4tOJlcekRAp4ILsksN029qCkcTxVAL8DDhE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4560.eurprd08.prod.outlook.com (20.179.24.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 13:16:27 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:27 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 29/30] drm/bridge: add support for device links to bridge
Thread-Topic: [PATCH 29/30] drm/bridge: add support for device links to bridge
Thread-Index: AQHVpFu1iHJCIvZyo0WUUQNtpUlixw==
Date:   Tue, 26 Nov 2019 13:16:26 +0000
Message-ID: <20191126131541.47393-30-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: cce352f6-5e41-48bb-3b99-08d77272df48
X-MS-TrafficTypeDiagnostic: VI1PR08MB4560:|VI1PR08MB4560:|VI1PR0802MB2381:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2381A1FDE74776E1769FAAAC8F450@VI1PR0802MB2381.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;OLM:5797;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(71190400001)(478600001)(1076003)(66476007)(186003)(26005)(5640700003)(52116002)(64756008)(256004)(8676002)(2351001)(66946007)(54906003)(81156014)(44832011)(3846002)(6116002)(6436002)(2616005)(66556008)(71200400001)(2906002)(11346002)(66446008)(99286004)(14454004)(81166006)(6916009)(5660300002)(25786009)(2501003)(8936002)(102836004)(5024004)(66066001)(36756003)(6486002)(6512007)(386003)(14444005)(4326008)(50226002)(76176011)(316002)(86362001)(7736002)(446003)(6506007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4560;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: IEzpmioFC9HXH/GMPwyuotFzMFChNW9v7z9ednY2Nth2mD3q3HnLQ3/mNFUDO/sQp+pcQWCqRKZG6KrCamm8dDmYhrp5wF1Aam/k9S4N+M1WBbAABYYF9nbc65dMhgKjCNp4YvHOHR0NMIB9Axx77gHi0VUNwDqTJ7R7aQN8r9xujdQofBGY3aZmVhfRicIya/rnP6IvfWPZVzCu2n0pMaSnlqMREjNE71OFOH9FfEflz4+4yWA8mB5ftPtuXMPOAvKkEzdpKeTzE+ut63Ht0YmIJXXQEJNA40mxLpqfW/Wjb9zvrgn+by7e9CODVdLH4hGQHndF/VOFF+R76FIrrp4fP7MiWYM2fioB/xmNTYpDOW+0GAWDJd3h+rx3qjoibmbhQmRxzqA/t954RRsApcjxzmKXdqKQhfE9BV9ODLkhh24tQ+92Y6HuSZxNQIQA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4560
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(99286004)(81166006)(14454004)(305945005)(25786009)(2501003)(102836004)(7736002)(50226002)(478600001)(26826003)(26005)(186003)(8936002)(5660300002)(8746002)(8676002)(47776003)(5024004)(14444005)(81156014)(6116002)(36756003)(3846002)(386003)(6506007)(50466002)(1076003)(76176011)(66066001)(2351001)(23756003)(107886003)(2616005)(2906002)(6862004)(22756006)(4326008)(5640700003)(76130400001)(6512007)(86362001)(356004)(70586007)(106002)(11346002)(70206006)(54906003)(336012)(36906005)(316002)(446003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2381;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a0850149-8228-499b-51bd-08d77272d7b7
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkJggVVyuJsiY+wZObxSuwiWQi84tEZlL6YV3UaJ5S6w7+dBs1cw5wRw8TrD+lwYJ434WU3TEnZJdh/BOx0Tg0Xzt6nWL5SDk36PiL+/Zq3CPMCxbyio+xlYXgJElFHtdPpCiinKP6pzswdEj4FVhAGEqVNjqvuKVGzO//mUYPftMs8NcLWXIykpxE/BE7b1J7ITjo6arA6EPXvAF5CNgurJNQ4rYkhV1+kQykGPaJVCLjEigf63RyCy86YD2c67XNGC3VCYiqQTrlCDtkMZX4DXrfbXkk7yBD230e4Ole9BSIA/AiQ5qbjt5hTu19y0dYuzp41txOHgw2OLGRIEFp83pybh1a7FrjEgPeKuiKz6qePuVbdNlq8zixJSFi204Z9mKjrh8yzZmN0xf8FLE6QEaNA6E8xZZRNkD2jpuvG6wHaby/Zgqm6ZUMLlcDMA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:39.3004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce352f6-5e41-48bb-3b99-08d77272df48
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Bridge devices have been a potential for kernel oops as their lifetime
is independent of the DRM device that they are bound to.  Hence, if a
bridge device is unbound while the parent DRM device is using them, the
parent happily continues to use the bridge device, calling the driver
and accessing its objects that have been freed.

This can cause kernel memory corruption and kernel oops.

To control this, use device links to ensure that the parent DRM device
is unbound when the bridge device is unbound, and when the bridge
device is re-bound, automatically rebind the parent DRM device.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Tested-by: Mihail Atanassov <mihail.atanassov@arm.com>
[reworked to use drm_bridge_init() for setting bridge->device]
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/drm_bridge.c | 49 ++++++++++++++++++++++++++----------
 include/drm/drm_bridge.h     |  4 +++
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index cbe680aa6eac..e1f8db84651a 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
=20
 #include <drm/drm_bridge.h>
+#include <drm/drm_device.h>
 #include <drm/drm_encoder.h>
=20
 #include "drm_crtc_internal.h"
@@ -109,6 +110,7 @@ void drm_bridge_init(struct drm_bridge *bridge, struct =
device *dev,
 	bridge->encoder =3D NULL;
 	bridge->next =3D NULL;
=20
+	bridge->device =3D dev;
 #ifdef CONFIG_OF
 	bridge->of_node =3D dev->of_node;
 #endif
@@ -492,6 +494,32 @@ void drm_atomic_bridge_enable(struct drm_bridge *bridg=
e,
 EXPORT_SYMBOL(drm_atomic_bridge_enable);
=20
 #ifdef CONFIG_OF
+static struct drm_bridge *drm_bridge_find(struct drm_device *dev,
+					  struct device_node *np, bool link)
+{
+	struct drm_bridge *bridge, *found =3D NULL;
+	struct device_link *dl;
+
+	mutex_lock(&bridge_lock);
+
+	list_for_each_entry(bridge, &bridge_list, list)
+		if (bridge->of_node =3D=3D np) {
+			found =3D bridge;
+			break;
+		}
+
+	if (found && link) {
+		dl =3D device_link_add(dev->dev, found->device,
+				     DL_FLAG_AUTOPROBE_CONSUMER);
+		if (!dl)
+			found =3D NULL;
+	}
+
+	mutex_unlock(&bridge_lock);
+
+	return found;
+}
+
 /**
  * of_drm_find_bridge - find the bridge corresponding to the device node i=
n
  *			the global bridge list
@@ -503,21 +531,16 @@ EXPORT_SYMBOL(drm_atomic_bridge_enable);
  */
 struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 {
-	struct drm_bridge *bridge;
-
-	mutex_lock(&bridge_lock);
-
-	list_for_each_entry(bridge, &bridge_list, list) {
-		if (bridge->of_node =3D=3D np) {
-			mutex_unlock(&bridge_lock);
-			return bridge;
-		}
-	}
-
-	mutex_unlock(&bridge_lock);
-	return NULL;
+	return drm_bridge_find(NULL, np, false);
 }
 EXPORT_SYMBOL(of_drm_find_bridge);
+
+struct drm_bridge *of_drm_find_bridge_devlink(struct drm_device *dev,
+					      struct device_node *np)
+{
+	return drm_bridge_find(dev, np, true);
+}
+EXPORT_SYMBOL(of_drm_find_bridge_devlink);
 #endif
=20
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index d6d9d5301551..68b27c69cc3d 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -382,6 +382,8 @@ struct drm_bridge {
 	struct drm_encoder *encoder;
 	/** @next: the next bridge in the encoder chain */
 	struct drm_bridge *next;
+	/** @device: Linux driver model device */
+	struct device *device;
 #ifdef CONFIG_OF
 	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
@@ -407,6 +409,8 @@ void drm_bridge_init(struct drm_bridge *bridge, struct =
device *dev,
 		     const struct drm_bridge_timings *timings,
 		     void *driver_private);
 struct drm_bridge *of_drm_find_bridge(struct device_node *np);
+struct drm_bridge *of_drm_find_bridge_devlink(struct drm_device *dev,
+					      struct device_node *np);
 int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *brid=
ge,
 		      struct drm_bridge *previous);
=20
--=20
2.23.0

