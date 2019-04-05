Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E804C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C920D2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="UGxse3l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfDEKzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:55:01 -0400
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:55360
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730283AbfDEKzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q26ff80t9wQEUM04yFN9o+yULPrH638Iafb/1aYhMQc=;
 b=UGxse3l5PBjxjVRcCHyqcvF3fiSV6p203mHfJoSTU5hzjybDWB6/6P8HIwtSF1wouPjNOQuyRAOB+GP5ymERaw69nEa8RK6PqPPXGXeroguJ5WMqUX108vYNn6l7TYXBjxdTlTBAqOn2iUe4QL/xmHtRzUdLj7EE+sbuS17/E64=
Received: from AM6PR06MB5557.eurprd06.prod.outlook.com (20.178.94.211) by
 AM6PR06MB5493.eurprd06.prod.outlook.com (20.178.94.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Fri, 5 Apr 2019 10:54:56 +0000
Received: from AM6PR06MB5557.eurprd06.prod.outlook.com
 ([fe80::c0b4:b693:fdc7:e476]) by AM6PR06MB5557.eurprd06.prod.outlook.com
 ([fe80::c0b4:b693:fdc7:e476%4]) with mapi id 15.20.1750.014; Fri, 5 Apr 2019
 10:54:56 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH 1/1] power: reset: nvmem-reboot-mode: use NVMEM as reboot mode
 write interface
Thread-Topic: [PATCH 1/1] power: reset: nvmem-reboot-mode: use NVMEM as reboot
 mode write interface
Thread-Index: AQHU654BwTX0hyqV3k+NJKej8Pv3Vw==
Date:   Fri, 5 Apr 2019 10:54:55 +0000
Message-ID: <20190405105432.21941-1-nandor.han@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::13)
 To AM6PR06MB5557.eurprd06.prod.outlook.com (2603:10a6:20b:9c::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad7c6cb1-5e4d-420d-851c-08d6b9b5238b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR06MB5493;
x-ms-traffictypediagnostic: AM6PR06MB5493:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <AM6PR06MB5493D15BAF951CE6DABD775B85510@AM6PR06MB5493.eurprd06.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(366004)(136003)(346002)(199004)(189003)(81156014)(386003)(478600001)(4326008)(2616005)(5660300002)(97736004)(110136005)(36756003)(1076003)(106356001)(25786009)(8936002)(8676002)(105586002)(50226002)(6506007)(53936002)(81166006)(476003)(7736002)(2906002)(71190400001)(71200400001)(6486002)(102836004)(486006)(6436002)(6512007)(68736007)(186003)(14454004)(66066001)(3846002)(14444005)(26005)(86362001)(2201001)(305945005)(99286004)(52116002)(256004)(107886003)(2501003)(6116002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR06MB5493;H:AM6PR06MB5557.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F/PTiReVoD+ypZs5pOywCSb57thcIqyFIue7jRmllSnYVxxascVwx5QxnOngZBwICF+GCjmMjWgU9h/uQQQEAzNrwUuadx5uo8JddyOaOwl51mL+7roLSpdS/RQlpNFDkhqUNPxFWCYjhcEp2O4sKcARDpEjOROR+Z+ihqLOATL2imZbXi+GFRcIPGNy8updFGTs5LGzLsnv5JXkE/MRrWg4GmjMIZ0aqppsthXxmweTngiTlH23WuJl9rvMXzRE0iyrgSgrHaTroQ9VZY/RGcBQpBlsdoaRzeiH7xUGnvqgbX+x8rSNPYwMlJJfqR7MZ5XfZW0Y8msqsBXjtbeaSMqTp81xEfRaoT/AFDbBf+eU5v5q2AWqySYOx00PHhVoBInqNCWGXEa1g2RhcyUblckedhzis/PvU0jl3DkKqEw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7c6cb1-5e4d-420d-851c-08d6b9b5238b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 10:54:55.9361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new reboot mode write interface that is using a NVMEM cell,
called "reboot-mode", to store the reboot mode magic.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---

Description
-----------
Extend the reboot mode driver to use a NVMEM cell as writing interface.

Testing
-------
The testing is done by configuring DT from a custom board.
The NVMEM cell is configured in an RTC non-volatile memory.

DT configurations:
`
...
reboot-mode-nvmem@0 {
    compatible =3D "simple-mfd";
    reboot-mode {
        compatible =3D "nvmem-reboot-mode";
        nvmem-cells =3D <&reboot_mode>;
        nvmem-cell-names =3D "reboot-mode";

        mode-test       =3D <0x21969147>;
     };
};
...
reboot_mode: nvmem_reboot_mode@0 {
        reg =3D <0x00 0x4>;
};
...
`

1. Reboot the system using the command `reboot test`

2. Verify that kernel logs show that reboot was done in mode `test`:
PASS
`[  413.957172] reboot: Restarting system with command 'test' `

3. Stop in U-Boot and verify that mode `test` magic value is present
in RTCs non-volatile memory: PASS

 .../power/reset/nvmem-reboot-mode.txt         | 32 ++++++++
 drivers/power/reset/Kconfig                   |  9 +++
 drivers/power/reset/Makefile                  |  1 +
 drivers/power/reset/nvmem-reboot-mode.c       | 75 +++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-reb=
oot-mode.txt
 create mode 100644 drivers/power/reset/nvmem-reboot-mode.c

diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mod=
e.txt b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
new file mode 100644
index 000000000000..2e1b86c31cb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
@@ -0,0 +1,32 @@
+NVMEM reboot mode driver
+
+This driver gets reboot mode magic value from reboot-mode driver
+and stores it in a NVMEM cell named "reboot-mode". Then the bootloader
+can read it and take different action according to the magic
+value stored.
+
+This DT node should be represented as a sub-node of a "simple-mfd"
+node.
+
+Required properties:
+- compatible: should be "nvmem-reboot-mode".
+- nvmem-cells: A phandle to the reboot mode provided by a nvmem device.
+- nvmem-cell-names: Should be "reboot-mode".
+
+The rest of the properties should follow the generic reboot-mode descripti=
on
+found in reboot-mode.txt
+
+Example:
+	reboot-mode-nvmem@0 {
+		compatible =3D "simple-mfd";
+		reboot-mode {
+			compatible =3D "nvmem-reboot-mode";
+			nvmem-cells =3D <&reboot_mode>;
+			nvmem-cell-names =3D "reboot-mode";
+
+			mode-normal     =3D <0xAAAA5501>;
+			mode-bootloader =3D <0xBBBB5500>;
+			mode-recovery   =3D <0xCCCC5502>;
+			mode-test       =3D <0xDDDD5503>;
+		};
+	};
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 6533aa560aa1..bb4a4e854f96 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -245,5 +245,14 @@ config POWER_RESET_SC27XX
 	  PMICs includes the SC2720, SC2721, SC2723, SC2730
 	  and SC2731 chips.
=20
+config NVMEM_REBOOT_MODE
+	tristate "Generic NVMEM reboot mode driver"
+	select REBOOT_MODE
+	help
+	  Say y here will enable reboot mode driver. This will
+	  get reboot mode arguments and store it in a NVMEM cell,
+	  then the bootloader can read it and take different
+	  action according to the mode.
+
 endif
=20
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0aebee954ac1..85da3198e4e0 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_POWER_RESET_ZX) +=3D zx-reboot.o
 obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
+obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/=
nvmem-reboot-mode.c
new file mode 100644
index 000000000000..31b73c7a0dad
--- /dev/null
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) Vaisala Oyj. All rights reserved.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/platform_device.h>
+#include <linux/reboot-mode.h>
+
+struct nvmem_reboot_mode {
+	struct reboot_mode_driver reboot;
+	struct nvmem_cell *cell;
+};
+
+static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
+				    unsigned int magic)
+{
+	int ret;
+	struct nvmem_reboot_mode *nvmem_rbm;
+
+	nvmem_rbm =3D container_of(reboot, struct nvmem_reboot_mode, reboot);
+
+	ret =3D nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	if (ret < 0)
+		dev_err(reboot->dev, "update reboot mode bits failed\n");
+
+	return ret;
+}
+
+static int nvmem_reboot_mode_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct nvmem_reboot_mode *nvmem_rbm;
+
+	nvmem_rbm =3D devm_kzalloc(&pdev->dev, sizeof(*nvmem_rbm), GFP_KERNEL);
+	if (!nvmem_rbm)
+		return -ENOMEM;
+
+	nvmem_rbm->reboot.dev =3D &pdev->dev;
+	nvmem_rbm->reboot.write =3D nvmem_reboot_mode_write;
+
+	nvmem_rbm->cell =3D devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
+	if (IS_ERR(nvmem_rbm->cell)) {
+		dev_err(&pdev->dev, "failed to get the nvmem cell reboot-mode\n");
+		return PTR_ERR(nvmem_rbm->cell);
+	}
+
+	ret =3D devm_reboot_mode_register(&pdev->dev, &nvmem_rbm->reboot);
+	if (ret)
+		dev_err(&pdev->dev, "can't register reboot mode\n");
+
+	return ret;
+}
+
+static const struct of_device_id nvmem_reboot_mode_of_match[] =3D {
+	{ .compatible =3D "nvmem-reboot-mode" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, nvmem_reboot_mode_of_match);
+
+static struct platform_driver nvmem_reboot_mode_driver =3D {
+	.probe =3D nvmem_reboot_mode_probe,
+	.driver =3D {
+		.name =3D "nvmem-reboot-mode",
+		.of_match_table =3D nvmem_reboot_mode_of_match,
+	},
+};
+module_platform_driver(nvmem_reboot_mode_driver);
+
+MODULE_AUTHOR("Nandor Han <nandor.han@vaisala.com>");
+MODULE_DESCRIPTION("NVMEM reboot mode driver");
+MODULE_LICENSE("GPL v2");
--=20
2.17.2

