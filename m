Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554E1C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFC820644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="ee+o00Ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfHAO2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:28:52 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com ([40.107.6.108]:15073
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729240AbfHAO2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:28:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7z3hbSItqEDJ2UBHWfPqCjR3APgP42sP2H6sD4d1+HkijErb3xkGIBIjzoVPeCPu2JFeXYydlvPQc8fuh9HiwgxRM53QVLGSWPJCdAPGPp0q582U6tnWo1yRQX8C6ILNMIT12sdyJs2QJXzkQlqfD5FQs0TGYQSUaxszf5bEEYbq5JGqutgQHrFJoZgRg3ljppv5p6jiWcS+Gv4lJpn1LpH7imA91SQg/Ub4ctyWN1J8VeeK/Ram0S+YLaFUwayP2dYB6J1RbqDidMiy5imn3nYg9irdDj9dgWg4zl5owl67qCVGSA3ERPkGM14UIuK5yeiRS536Q8vDYTVXFULGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IPCRgTZZUFUmaha2uXJcTnfZSDjNCbWgR5X34zGbBw=;
 b=S8FYU6SLmnLredEStmCyozEeTUZeoIYkG/ajWVUYW+SAn3DYVoLJk14Ou+PIOz5CXokWruFD4uHu1+RuoAXSj9oiujOZ/D7zMVQ32w9DlZntL4aNI5tvXK1UgnDBEYSrJp5gqPC5oUxSN3tdutGENa3mJhh1LAqsztl5lgmj+DJcnKSIsAHbtU7gfXszLChx+SIlEgDrqaPFDBcJn5OO60AWzFXdFy60o6w+C1OXsD1INuyVV3MSVgBHBO4tgwNfByY83wMYO1pi3z4kMWJxOHOdfAeXqOwck/5kOWGMI/ITnH3XRi1+yB68OT7Nl7xIL9yawSfgwdC4a3u/rtjWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IPCRgTZZUFUmaha2uXJcTnfZSDjNCbWgR5X34zGbBw=;
 b=ee+o00RaiUhcN1uUh5oI8Ny+/6xxY7N2p4wcrB6iHAQ9lWdS9URzilB2DEcIYQXii1JMIgygfs8sd/N/vO+TQe5SCcYxBwARTahm3RhXRDTGvfigV5dNGBu/i1zPdhxU4f7sr1rVc+L6IWY7NCeep9AgjjbeBaHWHva5Tz/tp9s=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB3679.eurprd02.prod.outlook.com (52.134.26.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 14:28:45 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f%4]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 14:28:45 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] habanalabs: Add descriptive names to PSOC scratch-pad
 registers
Thread-Topic: [PATCH 1/2] habanalabs: Add descriptive names to PSOC
 scratch-pad registers
Thread-Index: AQHVSHVsM5QUywG+ykitiGZGueQBMA==
Date:   Thu, 1 Aug 2019 14:28:45 +0000
Message-ID: <20190801142834.329-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0069.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::33) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e250d742-70df-4f59-b6c9-08d7168c8f53
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB3679;
x-ms-traffictypediagnostic: VI1PR02MB3679:
x-microsoft-antispam-prvs: <VI1PR02MB36794319E2E15D6E13F83397D2DE0@VI1PR02MB3679.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39850400004)(199004)(189003)(66946007)(5640700003)(66446008)(8936002)(53936002)(81166006)(81156014)(71190400001)(71200400001)(50226002)(66476007)(66556008)(64756008)(6512007)(305945005)(86362001)(478600001)(6486002)(5660300002)(2906002)(1076003)(2351001)(2501003)(6436002)(6116002)(3846002)(36756003)(476003)(486006)(4326008)(186003)(66066001)(102836004)(26005)(52116002)(386003)(6506007)(99286004)(7736002)(2616005)(25786009)(6916009)(14454004)(316002)(1361003)(256004)(14444005)(19627235002)(68736007)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3679;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HQM45HuCRlm5dHxvjE+MiUNcjsHfsY3cW8UZC9BvbfcHyKG4heeuDCYGSLqvrDP1wOeAKMkAMY+vFXDoM0CHWyZchrWN32NqraIg7iXFBjsaGwMBojnCq3IKErvfE5C4TMiK2ILQObfu9+vGTQPdx5fg1/GjhP6o0OxFZf4AHSmGZhOSR1qbl4OUeaWQsgwav8wy7jTuSMKSDObmBZOesuYGg7gUeWdeWd3XtLwVsroiabM+V1Jgrqep0Tj6gpGvUs+fiUQw+cMiFE+Pf3nAwnd8l/MZkvnTYLVh7CY/FkgIuZUZr8rpkwT1sW5EaPCPmJXlj4NmMJZu5ggg+PPa95QseFqGM4kCi72hdR5EDiRDW7tidq8qAdPi1osbdvGrJDW+/tCd6GCMOLi7SI2rOCQduDDX11l3ku57msJ4w2o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: e250d742-70df-4f59-b6c9-08d7168c8f53
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 14:28:45.3594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttayar@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PSOC scratch-pad registers are used for communication with the
device CPU. This patch adds new definitions for these registers which
are more descriptive than their general names.

The new set of definitions also gathers and documents the current usage
of the scratch-pad registers by the driver and the device CPU.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/goya/goya.c           | 33 +++++++++----------
 .../habanalabs/include/goya/goya_reg_map.h    | 32 ++++++++++++++++++
 2 files changed, 48 insertions(+), 17 deletions(-)
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_reg_map.h

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index 1a2c062a57d4..9699e7d4903e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -9,6 +9,7 @@
 #include "include/hw_ip/mmu/mmu_general.h"
 #include "include/hw_ip/mmu/mmu_v1_0.h"
 #include "include/goya/asic_reg/goya_masks.h"
+#include "include/goya/goya_reg_map.h"
=20
 #include <linux/pci.h>
 #include <linux/genalloc.h>
@@ -1006,36 +1007,34 @@ int goya_init_cpu_queues(struct hl_device *hdev)
=20
 	eq =3D &hdev->event_queue;
=20
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_0,
-			lower_32_bits(cpu_pq->bus_address));
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_1,
-			upper_32_bits(cpu_pq->bus_address));
+	WREG32(mmCPU_PQ_BASE_ADDR_LOW, lower_32_bits(cpu_pq->bus_address));
+	WREG32(mmCPU_PQ_BASE_ADDR_HIGH, upper_32_bits(cpu_pq->bus_address));
=20
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_2, lower_32_bits(eq->bus_address));
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_3, upper_32_bits(eq->bus_address));
+	WREG32(mmCPU_EQ_BASE_ADDR_LOW, lower_32_bits(eq->bus_address));
+	WREG32(mmCPU_EQ_BASE_ADDR_HIGH, upper_32_bits(eq->bus_address));
=20
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_8,
+	WREG32(mmCPU_CQ_BASE_ADDR_LOW,
 			lower_32_bits(VA_CPU_ACCESSIBLE_MEM_ADDR));
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_9,
+	WREG32(mmCPU_CQ_BASE_ADDR_HIGH,
 			upper_32_bits(VA_CPU_ACCESSIBLE_MEM_ADDR));
=20
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_5, HL_QUEUE_SIZE_IN_BYTES);
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_4, HL_EQ_SIZE_IN_BYTES);
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_10, HL_CPU_ACCESSIBLE_MEM_SIZE);
+	WREG32(mmCPU_PQ_LENGTH, HL_QUEUE_SIZE_IN_BYTES);
+	WREG32(mmCPU_EQ_LENGTH, HL_EQ_SIZE_IN_BYTES);
+	WREG32(mmCPU_CQ_LENGTH, HL_CPU_ACCESSIBLE_MEM_SIZE);
=20
 	/* Used for EQ CI */
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_6, 0);
+	WREG32(mmCPU_EQ_CI, 0);
=20
 	WREG32(mmCPU_IF_PF_PQ_PI, 0);
=20
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_7, PQ_INIT_STATUS_READY_FOR_CP);
+	WREG32(mmCPU_PQ_INIT_STATUS, PQ_INIT_STATUS_READY_FOR_CP);
=20
 	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
 			GOYA_ASYNC_EVENT_ID_PI_UPDATE);
=20
 	err =3D hl_poll_timeout(
 		hdev,
-		mmPSOC_GLOBAL_CONF_SCRATCHPAD_7,
+		mmCPU_PQ_INIT_STATUS,
 		status,
 		(status =3D=3D PQ_INIT_STATUS_READY_FOR_HOST),
 		1000,
@@ -2205,12 +2204,12 @@ static void goya_read_device_fw_version(struct hl_d=
evice *hdev,
=20
 	switch (fwc) {
 	case FW_COMP_UBOOT:
-		ver_off =3D RREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_29);
+		ver_off =3D RREG32(mmUBOOT_VER_OFFSET);
 		dest =3D hdev->asic_prop.uboot_ver;
 		name =3D "U-Boot";
 		break;
 	case FW_COMP_PREBOOT:
-		ver_off =3D RREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_28);
+		ver_off =3D RREG32(mmPREBOOT_VER_OFFSET);
 		dest =3D hdev->asic_prop.preboot_ver;
 		name =3D "Preboot";
 		break;
@@ -3936,7 +3935,7 @@ void goya_add_end_of_cb_packets(struct hl_device *hde=
v, u64 kernel_address,
=20
 void goya_update_eq_ci(struct hl_device *hdev, u32 val)
 {
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_6, val);
+	WREG32(mmCPU_EQ_CI, val);
 }
=20
 void goya_restore_phase_topology(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/include/goya/goya_reg_map.h b/drivers/=
misc/habanalabs/include/goya/goya_reg_map.h
new file mode 100644
index 000000000000..554034f47317
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2019 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef GOYA_REG_MAP_H_
+#define GOYA_REG_MAP_H_
+
+/*
+ * PSOC scratch-pad registers
+ */
+#define mmCPU_PQ_BASE_ADDR_LOW	mmPSOC_GLOBAL_CONF_SCRATCHPAD_0
+#define mmCPU_PQ_BASE_ADDR_HIGH	mmPSOC_GLOBAL_CONF_SCRATCHPAD_1
+#define mmCPU_EQ_BASE_ADDR_LOW	mmPSOC_GLOBAL_CONF_SCRATCHPAD_2
+#define mmCPU_EQ_BASE_ADDR_HIGH	mmPSOC_GLOBAL_CONF_SCRATCHPAD_3
+#define mmCPU_EQ_LENGTH		mmPSOC_GLOBAL_CONF_SCRATCHPAD_4
+#define mmCPU_PQ_LENGTH		mmPSOC_GLOBAL_CONF_SCRATCHPAD_5
+#define mmCPU_EQ_CI		mmPSOC_GLOBAL_CONF_SCRATCHPAD_6
+#define mmCPU_PQ_INIT_STATUS	mmPSOC_GLOBAL_CONF_SCRATCHPAD_7
+#define mmCPU_CQ_BASE_ADDR_LOW	mmPSOC_GLOBAL_CONF_SCRATCHPAD_8
+#define mmCPU_CQ_BASE_ADDR_HIGH	mmPSOC_GLOBAL_CONF_SCRATCHPAD_9
+#define mmCPU_CQ_LENGTH		mmPSOC_GLOBAL_CONF_SCRATCHPAD_10
+#define mmUPD_STS		mmPSOC_GLOBAL_CONF_SCRATCHPAD_26
+#define mmUPD_CMD		mmPSOC_GLOBAL_CONF_SCRATCHPAD_27
+#define mmPREBOOT_VER_OFFSET	mmPSOC_GLOBAL_CONF_SCRATCHPAD_28
+#define mmUBOOT_VER_OFFSET	mmPSOC_GLOBAL_CONF_SCRATCHPAD_29
+#define mmUBOOT_OFFSET		mmPSOC_GLOBAL_CONF_SCRATCHPAD_30
+#define mmBTL_ID		mmPSOC_GLOBAL_CONF_SCRATCHPAD_31
+
+#endif /* GOYA_REG_MAP_H_ */
--=20
2.17.1

