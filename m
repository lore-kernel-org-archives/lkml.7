Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A4DC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD36521823
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pP1XYIhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfLBKOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:14:44 -0500
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:36833
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfLBKOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:14:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCJ5ZAFyFOdZaS0Q6hm6uDgzbD59f5nyyC2JJ6y63JpG3LWmC2xq9GY2imsXYV+yQc7z0Vo1uvv4XWulWejkFBdbXN+xyheHqusMTNqTX8LUMKb5BGOkavQzpURvA7i9DT0nUOlDRGeUnr8W7XQkWCANTWwQ74WLbAoj6Kcg7ajwcgvtaHt2D2eBWK9+7N1GEGKu7DNRwEDY7S2JzwuGIm0GpHTmra0a2EmclFNrJck5jtN823mDf4qL4dA+pc7ee/0KH73/gJ88CorwMZPJ2OzqtqlW+z3T6W1PYQskccFS1HW5K0koqFzmjJhwzNrYtG8sIKWj1kLVYL16vuUk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGkiKn57+ceqe+yQEGCoAwwJZadA/8huVOwDRsSK/0s=;
 b=gJ42Tw1fOJmIZBeWWqT13a99Ohw0+YFfxgM2HHMc7R+hlZ1oMxJMETLZ0SED5V3AUoC/HwWt7mnO0JAzITmVh8EEApVbZR2KKa7DaN3x/Weg6kY8T5NBxixlRAw23uQCk9c2/bmvJlvqvUQkts7NXub1pPbwuKlqffq4l+ck+m3YU8LCfAQ4hVMYKJJ1hmPRyDXxGzL94N8SdAn2RhUcjRxolNUxxos1cJP50ETbQqJ4cYd6F+aA9w66DTFjz8cic3NTJWqGg9s8PPeuLA5zwXD4f+L9X7n9E+JNDAWBEk7S8KXqTBtdWbxWtJi0/7Sr1x+J9ZNDn4ZKl9scOX2L0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGkiKn57+ceqe+yQEGCoAwwJZadA/8huVOwDRsSK/0s=;
 b=pP1XYIhUfGJiZ6UW3DLvb8ANiYakzzbeIDGcpMhOIvZVtqJ6hk1YUiHLKype0NVAVrCs1wx/A+qS3k+YRO1A8JrwhyV6QqSpqaTEuHVjWkfu6vwx90Z8gT3TNOINXP1mmijX+O8J3wEqgyhZ8X0ZmzyZuI4fUQ/DwHSkZvZ9/0Q=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4545.eurprd04.prod.outlook.com (52.135.148.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 10:14:40 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 10:14:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v11 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH v11 1/2] dt-bindings: mailbox: add binding doc for the
 ARM SMC/HVC mailbox
Thread-Index: AQHVqPlO1zku/wpLsEKKv8tg+3gpuQ==
Date:   Mon, 2 Dec 2019 10:14:39 +0000
Message-ID: <1575281525-1549-2-git-send-email-peng.fan@nxp.com>
References: <1575281525-1549-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1575281525-1549-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b8d053d-d7ad-48c5-b128-08d777107124
x-ms-traffictypediagnostic: AM0PR04MB4545:|AM0PR04MB4545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB454541DB150C5B236C7BA00588430@AM0PR04MB4545.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(199004)(189003)(3846002)(316002)(66476007)(66446008)(66946007)(64756008)(66556008)(52116002)(86362001)(305945005)(8676002)(81156014)(2420400007)(15650500001)(50226002)(2501003)(256004)(71190400001)(71200400001)(2201001)(66066001)(6116002)(7736002)(2906002)(5660300002)(14454004)(7110500001)(36756003)(81166006)(8936002)(76176011)(4326008)(6306002)(6436002)(6512007)(478600001)(11346002)(25786009)(446003)(44832011)(102836004)(186003)(2616005)(99286004)(110136005)(26005)(54906003)(6506007)(386003)(6486002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4545;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJggaXQl0xVuZQ/HCqhS0aN1bA/cojRVmHXmRJqiyxviDpXYzfsFWFs0uPLoJ24C/H1zXO3xh9MJSXa9CZ3cwj9KFuRdiZHxrar8C5rwid7tktYF7qrosVwOjht5Nw4kAzPwJ6OqcEJbqnaw1UJieg/3sV4HLczzzv9kCFoEKkNrwzwiolzmhOjwesc7btF9RG/rvLGoIbwfgxj9CMJPOMCusiEu1y071UwROtghpNc/zb/PCf2uo1QJC2sRZNPtZA8SX5DU8c5IZJh3RnTEO+LMpX0uWP4F+yURzPJoYoDQt7UXwkGMEMvmkWNmI1WKMjKBeIpuS9XUcQSFz73dsVBPI5TAiKagsB4AiFLuTBS1FIYD2E7muT79JE+XiQ1OoYUPbQJMElkBJ0HkV+DtkAQrW1858lZtDg1Ajo+jnamGXywtrXwAi4rCsYso3mLoteyZ58yVaCBKHseGsYj3xekHOKVi6SKqUqCELQONK6A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8d053d-d7ad-48c5-b128-08d777107124
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 10:14:39.9235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJVViv/fIs30DQ6dSBzbXCNcyq3SgLY2YZythBDNqBA74KWotPRh1C/7235F1xReE5+U+RkK50I1D+Cad8Flng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The ARM SMC/HVC mailbox binding describes a firmware interface to trigger
actions in software layers running in the EL2 or EL3 exception levels.
The term "ARM" here relates to the SMC instruction as part of the ARM
instruction set, not as a standard endorsed by ARM Ltd.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/arm-smc.yaml       | 96 ++++++++++++++++++=
++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Docum=
entation/devicetree/bindings/mailbox/arm-smc.yaml
new file mode 100644
index 000000000000..c165946a64e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/arm-smc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM SMC Mailbox Interface
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  This mailbox uses the ARM smc (secure monitor call) or hvc (hypervisor
+  call) instruction to trigger a mailbox-connected activity in firmware,
+  executing on the very same core as the caller. The value of r0/w0/x0
+  the firmware returns after the smc call is delivered as a received
+  message to the mailbox framework, so synchronous communication can be
+  established. The exact meaning of the action the mailbox triggers as
+  well as the return value is defined by their users and is not subject
+  to this binding.
+
+  One example use case of this mailbox is the SCMI interface, which uses
+  shared memory to transfer commands and parameters, and a mailbox to
+  trigger a function call. This allows SoCs without a separate management
+  processor (or when such a processor is not available or used) to use
+  this standardized interface anyway.
+
+  This binding describes no hardware, but establishes a firmware interface=
.
+  Upon receiving an SMC using the described SMC function identifier, the
+  firmware is expected to trigger some mailbox connected functionality.
+  The communication follows the ARM SMC calling convention.
+  Firmware expects an SMC function identifier in r0 or w0. The supported
+  identifier is listed in the the arm,func-id property as described below.
+  The firmware can return one value in the first SMC result register,
+  it is expected to be an error value, which shall be propagated to the
+  mailbox client.
+
+  Any core which supports the SMC or HVC instruction can be used, as long
+  as a firmware component running in EL3 or EL2 is handling these calls.
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          For implementations using ARM SMC instruction.
+        const: arm,smc-mbox
+
+      - description:
+          For implementations using ARM HVC instruction.
+        const: arm,hvc-mbox
+
+  "#mbox-cells":
+    const: 0
+
+  arm,func-id:
+    description: |
+      An single 32-bit value specifying the function ID used by the mailbo=
x.
+      The function ID follows the ARM SMC calling convention standard.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - "#mbox-cells"
+  - arm,func-id
+
+examples:
+  - |
+    sram@93f000 {
+      compatible =3D "mmio-sram";
+      reg =3D <0x0 0x93f000 0x0 0x1000>;
+      #address-cells =3D <1>;
+      #size-cells =3D <1>;
+      ranges =3D <0x0 0x93f000 0x1000>;
+
+      cpu_scp_lpri: scp-shmem@0 {
+        compatible =3D "arm,scmi-shmem";
+        reg =3D <0x0 0x200>;
+      };
+    };
+
+    smc_tx_mbox: tx_mbox {
+      #mbox-cells =3D <0>;
+      compatible =3D "arm,smc-mbox";
+      arm,func-id =3D <0xc20000fe>;
+    };
+
+    firmware {
+      scmi {
+        compatible =3D "arm,scmi";
+        mboxes =3D <&smc_tx_mbox>;
+        mbox-names =3D "tx";
+        shmem =3D <&cpu_scp_lpri>;
+      };
+    };
+
+...
--=20
2.16.4

