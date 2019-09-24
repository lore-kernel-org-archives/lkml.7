Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E418C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22BF20673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TrIOhJ2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503820AbfIXBON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:14:13 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:24205
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391681AbfIXBOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:14:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goStEW2sYLJO9z0CQfEAeEuG7805zQSLxj6k+CLRuPfrkhs8LWlifyvtLhGtz03X/9QckWCCYmidAIL1DqlNgun7BhP6rmcSZ0lVJS/8m/d5rjqfYVwYE50KxhzN/tWmih+wV7w0LGdmQWldQktHLliQy6gFYNx8RoGVGSQwjI/9ES1rIMQ/38YCK0RMJDrlOxIW5urY31XrRiQfmLbVZfmZSOWL95FaJjqNZ8tlHlObL7hOQtPBuRWkt8n+3NoPgP/xc99t+e8rOd288qj2JAqbj/bU23UCmO/w962GZwuiz1uBLqn3HFtGEuaLXmLMYk8Cej0RekF2NFLJwkb4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZEmrTrLvcHhk4Rwl/9jaIFU1TZCoQCs1/2nesl5Lhs=;
 b=ClNE6LsJgXjKAO7bQhBbEI+aUpcT/IaLTA2ekf0Fh/up5zgH/C4+YH9wEhipz1d1hF0GECOixJRkEw+t/MnM/4k4v3GglrlOgFj3j9AzJwE5cW3zjI1M7yA22T2/t3ZT57TC1991B/E0B9rIU3ElsDmKxrEJRXdfugy60dU4yu14nbDqWaFIo526CtQ1jcjqh4+cD+nO1886ejsW7AyRlSZpG4lWprVrmU/xayMn37ocFRFyeG6wD4NilsXQFPmcNWucrwo+voGsWJztW3xu94Uyim8oUbVEDABZ+FTy4qBzpNpy1v24wPeHDe+ORXMBIO5puAIgvsBQ8Zkr8tn64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZEmrTrLvcHhk4Rwl/9jaIFU1TZCoQCs1/2nesl5Lhs=;
 b=TrIOhJ2cOC5MQ2ohbFwCIA5znBjyQXvzaRu8X5rokTwuAFkHuIIm3ThV1vDP3alyUKuMgsk9widyl3VsQc4I9ZBNXouGiZk5kVG/rjgWALP4Z83UWyY+VpYGKO3HkQX4hq6E6DEB76D6hiYdKfpWK9OhGVRjtK484qfyojcBEVM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5396.eurprd04.prod.outlook.com (20.178.113.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 01:14:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 01:14:07 +0000
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
Subject: [PATCH V8 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH V8 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVcnVdFX3gX9rzB0uylBnhc7LQFw==
Date:   Tue, 24 Sep 2019 01:14:07 +0000
Message-ID: <1569287538-10854-2-git-send-email-peng.fan@nxp.com>
References: <1569287538-10854-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1569287538-10854-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f52c62cc-63ee-44b0-c97d-08d7408c7f6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5396;
x-ms-traffictypediagnostic: AM0PR04MB5396:|AM0PR04MB5396:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5396C7B936459F2FDAB3EA5988840@AM0PR04MB5396.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(66066001)(6436002)(2420400007)(7110500001)(36756003)(478600001)(2201001)(316002)(14454004)(966005)(305945005)(66946007)(26005)(86362001)(71200400001)(66446008)(64756008)(66476007)(71190400001)(6116002)(3846002)(256004)(99286004)(6306002)(386003)(66556008)(486006)(6512007)(186003)(76176011)(6486002)(2501003)(6506007)(2906002)(4326008)(446003)(2616005)(102836004)(8676002)(54906003)(11346002)(110136005)(8936002)(52116002)(81166006)(50226002)(5660300002)(81156014)(44832011)(15650500001)(7736002)(25786009)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5396;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /6ZBm1RhjiAsnelTsWi9meaFflB62ZngcCbfdAcpYuWqYyAKOTlJf90SoF45RQ7ha0v/gmPhalIO+ohaMGFvVI9NEVa1nqySxZwTWCyN7+afFo71+3dKl9be5EQXxGPrzYJW53E8MTJuCxG4tG0u141S8quZnHNOAUGOjWh+K3SY1a0QOftzoVvItbuNyKOHn0Hw5PKSUaURgdFNBsNLC4SVWnOeW1Z6l/141+wX57EqB2+xENqtve6M6rpSKgLw19L3PesIxUAJc6UndSIzQQ7bV3iZmDC+REuBL6IyJXIzQK0IPb9z7bCjWJGfjIS33KCQJ/zaOliKxW3+uU26fVT0CHSBIDAFISqhkCs2nNzVKrRQ9P8Y2bE0QhNCZ+s5So4pNxF0svFuuYwv6lyDDX2tGX2xf7Nc5qPFZW0xlok=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52c62cc-63ee-44b0-c97d-08d7408c7f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 01:14:07.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWXANa/jYaGy5//Goesp2hdW0NSyCLY34ABqlgkpihcLus7JosbgTjie5JjVLPYUOCDUyZnPcPxtpl6IqcjhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5396
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The ARM SMC/HVC mailbox binding describes a firmware interface to trigger
actions in software layers running in the EL2 or EL3 exception levels.
The term "ARM" here relates to the SMC instruction as part of the ARM
instruction set, not as a standard endorsed by ARM Ltd.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/arm-smc.yaml       | 95 ++++++++++++++++++=
++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Docum=
entation/devicetree/bindings/mailbox/arm-smc.yaml
new file mode 100644
index 000000000000..8764ad2726b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
@@ -0,0 +1,95 @@
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
+  identifier are passed from consumers, or listed in the the arm,func-id
+  property as described below. The firmware can return one value in
+  the first SMC result register, it is expected to be an error value,
+  which shall be propagated to the mailbox client.
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

