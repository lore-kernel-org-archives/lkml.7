Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6197EC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E50E214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UwN/rx3G";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UwN/rx3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbfKGLmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:42:52 -0500
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:23496
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfKGLmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNd6MJSFo+gICC6cfGG5jN+STD2M9K1MfN8WY7NyFS8=;
 b=UwN/rx3G5TDCIZrNv3nXg3hl/xr1r9Trs7l3CgI3t4TbjuN/y1D9uONSBhyf/svXeFEVmxEaL1YBGoTYjlwNzPpaCIG2Y/699xZHSdmGX9aMf6EEzCbO/TOLIdQgMSuchI4VMoxP6uvsO3vo69drllVkgKS4K8p+lnQetC/V39Q=
Received: from VI1PR08CA0114.eurprd08.prod.outlook.com (2603:10a6:800:d4::16)
 by AM4PR08MB2804.eurprd08.prod.outlook.com (2603:10a6:205:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Thu, 7 Nov
 2019 11:42:46 +0000
Received: from DB5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VI1PR08CA0114.outlook.office365.com
 (2603:10a6:800:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 11:42:46 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT047.mail.protection.outlook.com (10.152.21.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 11:42:46 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Thu, 07 Nov 2019 11:42:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ab1cdf98c70ca652
X-CR-MTA-TID: 64aa7808
Received: from a8bf8e949972.2 (cr-mta-lb-1.cr-mta-net [104.47.10.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 215E9767-0A9C-4AC4-9364-6F886BCDD82A.1;
        Thu, 07 Nov 2019 11:42:38 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2051.outbound.protection.outlook.com [104.47.10.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a8bf8e949972.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 07 Nov 2019 11:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKxtUfUqjpuChkc7XNwD1LV7QVleleWVeMuU8JZt/1r6HO2QTwVAXo+Z306Z2vZEAlAJC3JeC0SMI5sxiaQ6dV98VteMHJjc0Vjzt8Ok6zalLGy3VVVGDVUKW1zVcYGj7vvWhD9s9WS6CuVe0VqseIS0u58kqJWtYQYkrZ8ivkLlmfsLLc4XU7exjJwh6aP/gKyyiwXbMPBZoZ3xDGuep2/RCMBB6acBcLOsYotSaRMBHdRyHbN+4XGmQCQBw3gqGckLztkkWi6UHXiAFEmrAWBuw33iuXuoGCYGPW0/u343OZEJCFApUoWzEWUQkLl13JbtMnnOCBfyp93sts9Z+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNd6MJSFo+gICC6cfGG5jN+STD2M9K1MfN8WY7NyFS8=;
 b=Vp37GNBtwbdaVFxhrxgN+lr3kYZAv22SezYCPVI+nyJhiaqwkliYpZuIjJB63rrE7pqduOuFm7j7xdC/Do9g43OzqCz9a43XTuhP9r/fKogCYnM59Wu4bQcnQ1vR9aSFrLLxhCLOsXsX09SHroHymJ8WlCSko3QIUM+iTVjdncAmiElz+EnQFJBec1eO6F5ErxS7a4y9rnIR2nK/FU2YT5Bg8uChzzqIwWbwrSpFyyBvOl3zudg+AhIhqFSrix3UsMbh+gE/3zibOMjvc9IzaVt3poZkv+CYSCMMMbWng9t8kxyD5yqHspDhRbai1J9+0khY7NAvHWnaruLRSQi2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNd6MJSFo+gICC6cfGG5jN+STD2M9K1MfN8WY7NyFS8=;
 b=UwN/rx3G5TDCIZrNv3nXg3hl/xr1r9Trs7l3CgI3t4TbjuN/y1D9uONSBhyf/svXeFEVmxEaL1YBGoTYjlwNzPpaCIG2Y/699xZHSdmGX9aMf6EEzCbO/TOLIdQgMSuchI4VMoxP6uvsO3vo69drllVkgKS4K8p+lnQetC/V39Q=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4351.eurprd08.prod.outlook.com (20.179.27.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 11:42:36 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 11:42:36 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] drm/komeda: Optionally dump DRM state on interrupts
Thread-Topic: [PATCH v2 3/5] drm/komeda: Optionally dump DRM state on
 interrupts
Thread-Index: AQHVlWBzAPfnXaxWaUmc63HFBTtG6g==
Date:   Thu, 7 Nov 2019 11:42:36 +0000
Message-ID: <20191107114155.54307-4-mihail.atanassov@arm.com>
References: <20191107114155.54307-1-mihail.atanassov@arm.com>
In-Reply-To: <20191107114155.54307-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0249df58-89a3-4623-1a4d-08d763779bbb
X-MS-TrafficTypeDiagnostic: VI1PR08MB4351:|VI1PR08MB4351:|AM4PR08MB2804:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR08MB28041E0AA30A90F9A2534CFF8F780@AM4PR08MB2804.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0214EB3F68
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(11346002)(316002)(54906003)(446003)(476003)(50226002)(71200400001)(6512007)(305945005)(6916009)(2906002)(8936002)(2616005)(44832011)(4326008)(6436002)(66066001)(256004)(486006)(86362001)(26005)(71190400001)(36756003)(52116002)(2351001)(14444005)(6506007)(99286004)(6486002)(102836004)(2501003)(76176011)(386003)(186003)(6116002)(14454004)(66946007)(66476007)(66556008)(64756008)(66446008)(25786009)(478600001)(1076003)(3846002)(8676002)(81166006)(81156014)(7736002)(5640700003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4351;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Sppi3GhYqwNfLGi3lL4FzrrODmoGBeeZPhG/Rvy9xFsZ7JwMck5Je0cAGpHTOKjmHGooMr5HoqVptTmT/9AaDxqi7WsQeUNFbR8TGD3rllK9MrpBwfbO0ylaADQ60DrdYWjn2iix4pBTRHxMcb4MJ1e0BiPLB30gULt7XfrnDsh5QWz3k30J6q59efawANKe5vlwseK6TVua7T6TgLjamtViFGYHE5sKf0wpxzlz+fL+n2HCyPRndcKitgt6vRNfuq8KW4G45cGPrmcqdQo8efr3PcKS0sfJmnrZ+1ixG177ARdyk8kWi8eHyMTKLAjb66wsMDPYJwIPglRgyPU1L+I8nz2acVjTmuSq4gGOnX6igKZk8zGS9w+VawFugtuwB9TiYGtvh41NPc/y2A/ZL/2FXd4QmdtpTBY+4qBNVSLLidYUHbvYcnTOcXZnoSMb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4351
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(1110001)(339900001)(189003)(199004)(50466002)(6862004)(25786009)(336012)(23756003)(105606002)(4326008)(22756006)(8676002)(66066001)(14454004)(6486002)(446003)(86362001)(2616005)(6116002)(47776003)(478600001)(11346002)(26005)(36756003)(6512007)(476003)(5660300002)(81156014)(26826003)(486006)(2501003)(99286004)(102836004)(386003)(76130400001)(6506007)(316002)(54906003)(14444005)(3846002)(5640700003)(7736002)(356004)(2906002)(126002)(186003)(8936002)(70586007)(76176011)(305945005)(2351001)(50226002)(70206006)(8746002)(1076003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB2804;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b3d7cc57-46bc-4c34-000b-08d7637795f4
NoDisclaimer: True
X-Forefront-PRVS: 0214EB3F68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYDqJXyBE6cWRCaNOlvoJYK2h0lMpsKcH7HLoYfPov7LYSjnU90gkdxExGjbb2MOpS9OrjYaf4ZS0EqRElZknBa5SU4jXOwRU+6f+PxjkwXGrJxc57vKEDZp+L3t/78mK3YzhJe8gsNkiWtDqRUgRicZkERqcUTkWT1EZRiN9rUe27UVhepaICZKikoc1e+99xKSYWh5g4pD39Uw2vef7X5XWk1yDgoqt8RFqloVWfqpfgYvjSco6OjahuUXTFMhKuqjesn1uhgkajGFPo83T/+5Z1jLDWJsBqQ/Jeyr0sVDiHhpBif33Dcy3mItu8JmF4fvgcNSxpAAb5Cr0j75MmFHQ+YlxmmgkQ+aB/0mXeV+8Ups/oPBgG+GoCc1e/mNoITljEefuDFiOiTvndAQk474Vv3m72vqWnfZAjTsU7mDJYCIi+tOEg2KCtw/Dgc/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 11:42:46.0672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0249df58-89a3-4623-1a4d-08d763779bbb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's potentially useful information when diagnosing error/warn IRQs, so
dump it to dmesg with a drm_info_printer. Hide this extra debug dumping
behind another komeda_dev->err_verbosity bit.

Note that there's not much sense in dumping it for INFO events,
since the VSYNC event will swamp the log.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---

 v2: Clean up continuation line warning from checkpatch.

 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 5 ++++-
 drivers/gpu/drm/arm/display/komeda/komeda_event.c | 8 +++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 831c375180f8..4809000c1efb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -205,11 +205,14 @@ struct komeda_dev {
 	/**
 	 * @err_verbosity: bitmask for how much extra info to print on error
 	 *
-	 * See KOMEDA_DEV_* macros for details.
+	 * See KOMEDA_DEV_* macros for details. Low byte contains the debug
+	 * level categories, the high byte contains extra debug options.
 	 */
 	u16 err_verbosity;
 	/* Print a single line per error per frame with error events. */
 #define KOMEDA_DEV_PRINT_ERR_EVENTS BIT(0)
+	/* Dump DRM state on an error or warning event. */
+#define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
 };
=20
 static inline bool
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_event.c
index 575ed4df74ed..de99a588ed75 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -4,6 +4,7 @@
  * Author: James.Qian.Wang <james.qian.wang@arm.com>
  *
  */
+#include <drm/drm_atomic.h>
 #include <drm/drm_print.h>
=20
 #include "komeda_dev.h"
@@ -113,6 +114,7 @@ void komeda_print_events(struct komeda_events *evts, st=
ruct drm_device *dev)
 	static bool en_print =3D true;
 	struct komeda_dev *mdev =3D dev->dev_private;
 	u16 const err_verbosity =3D mdev->err_verbosity;
+	u64 evts_mask =3D evts->global | evts->pipes[0] | evts->pipes[1];
=20
 	/* reduce the same msg print, only print the first evt for one frame */
 	if (evts->global || is_new_frame(evts))
@@ -123,9 +125,10 @@ void komeda_print_events(struct komeda_events *evts, s=
truct drm_device *dev)
 	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
 		print_evts |=3D KOMEDA_ERR_EVENTS;
=20
-	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts) {
+	if (evts_mask & print_evts) {
 		char msg[256];
 		struct komeda_str str;
+		struct drm_printer p =3D drm_info_printer(dev->dev);
=20
 		str.str =3D msg;
 		str.sz  =3D sizeof(msg);
@@ -139,6 +142,9 @@ void komeda_print_events(struct komeda_events *evts, st=
ruct drm_device *dev)
 		evt_str(&str, evts->pipes[1]);
=20
 		DRM_ERROR("err detect: %s\n", msg);
+		if ((err_verbosity & KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT) &&
+		    (evts_mask & (KOMEDA_ERR_EVENTS | KOMEDA_WARN_EVENTS)))
+			drm_state_dump(dev, &p);
=20
 		en_print =3D false;
 	}
--=20
2.23.0

