Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC489C4320D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C8C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hJrJALWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633794AbfIYCJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 22:09:13 -0400
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:39153
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394666AbfIYCJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 22:09:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJdBYc0n2n1nz6DcpnC+/7sQ+scl/EgUujA2Kznrf+OkD4Q5pgfrtgYaXucZ4G7a9Y9bFiq2E6rznDpyrFoI6L65cLCgDVcS26i0pf3rVo5oF4EL224Kd9CL4tHdzQF6fBjNhAq+Ci+2GEWmQU5LoRue4P7uqZiXb8lZEL2neAZk4VtaFBMbJYvrVk3zPzljY4+AjF5D/tR/HQDQeFbwuNOJyJnQERvs0bGxk9DyRXPDvjYEqz2qcHOQBxXUEJjAK2tSXlBrQBLjoWppdrcuFXihqodeYZoCHwFO+Zw6kjRwrlqmp5/y+HyIvbw6bh4Xw8Tu4x6OmEOBpJwdJqoJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZOMJ4MChVpWcVTNCQOkpoKg9clHfoUZrRLyCl+ldGM=;
 b=FSTxhReAf7zrwgQBzh12jNGvJlgoIquEFnJK9aqC9LZq0UcTVVV3lnxkwD/geV822FFT5+xYpMmCwSRfBK/aTk8E679uZI80njNL+gQeWYsLUHiAt59SRGhIkyMIDv8p7Y9fgNq37DTO4jOtr/EkgG/oGgKlnfbk/xl9KwOlEBzoS+VqGXKz+Jq0UW0nOOGoxxVwgJ4iPbqb9XzqHgyF0dOCSi+AT2kPuSjUF+saJVPt1IkaA2sIuUoG/VADBlFoOOL+zfQh75KKqRY4qdPliXBq7izBtfICXjbfrZsqVRITxP3C1kFoTGpYVlQe75AyJE3xmpBJCxDZ9Zu/+MCvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZOMJ4MChVpWcVTNCQOkpoKg9clHfoUZrRLyCl+ldGM=;
 b=hJrJALWFrk54m87wDG/G0qsK/4hVrNfh75ObeCG0l6dpTJFWpb/tVyT2abKt2Lw/aHbFmcnYaGdMqfazj7ez5Q8M7mUDKQ1+aOI24P+aI+wfgMbfNWNM2wPcGCTt8SJ7ILZnInCKnR2gPH6XfehMtZHih/tofSrmj/L6yNb0Z7I=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4451.eurprd04.prod.outlook.com (52.135.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Wed, 25 Sep 2019 02:09:08 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 02:09:08 +0000
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
Subject: [PATCH V9 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH V9 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVc0Y291KPBxEKYUuzX6RMzv1TyQ==
Date:   Wed, 25 Sep 2019 02:09:08 +0000
Message-ID: <1569377224-5755-2-git-send-email-peng.fan@nxp.com>
References: <1569377224-5755-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1569377224-5755-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0041.apcprd03.prod.outlook.com
 (2603:1096:203:2f::29) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2c68e1a-3066-4696-63e2-08d7415d591f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4451;
x-ms-traffictypediagnostic: AM0PR04MB4451:|AM0PR04MB4451:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB44516D94A22A557EEF3C138E88870@AM0PR04MB4451.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(8676002)(2501003)(66446008)(6116002)(66946007)(6512007)(6306002)(102836004)(6436002)(66476007)(64756008)(26005)(186003)(86362001)(44832011)(386003)(6506007)(54906003)(7110500001)(76176011)(66556008)(486006)(316002)(8936002)(2616005)(446003)(11346002)(476003)(25786009)(7736002)(256004)(15650500001)(2420400007)(305945005)(99286004)(66066001)(14454004)(71200400001)(50226002)(81166006)(81156014)(110136005)(3846002)(478600001)(2906002)(52116002)(966005)(2201001)(36756003)(5660300002)(71190400001)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4451;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f8C/G9ZETagMY0slCkSc90dCO59JOWpvtx3kLUIz5FzHWG5cYOWaUpWug3ElmVykm8LPu/XjRoezfngkrZ3ISuGS2yEWMLgM6zKZ6rJy36r9wCMQFDphlYZyC5e6fL4OXvN7qWk85gjH7fk1JLirSxkObkzwYFfNGQt4cHvQmPI9FRiesowyzKF5NUvgQXsTQkxs9cIT4VjpFYIvw0pmLlOCLDqR5Go2BwKOvQ/YqhptOisakDJL08KRSc3VAXABo+MdSr1hZDoktorE+OaPcmW3Xr2NbVZKvkEJkDfXG3bxiYPACdljcjbB3MIGL7JSh2xwxHAEr4GnqDgwjApXW+KX4p5CqXtcSX51l/ExHE7K2i+EDwHngAL9ln/KVTXJqenfTg7B8rFPPIiE9B+yDkD+cWvh6ICNzceiW9S2RCEMsclrXWbpXLnULfZxSptA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c68e1a-3066-4696-63e2-08d7415d591f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 02:09:08.0587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0vVMXspMMTDgcgDBaX5SGlMuzLSyL0UeeoOO26TEi4piqDBgeJrb782+r1OJmcWvOJUAsvJoStW0VoWesNPeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4451
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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/mailbox/arm-smc.yaml       | 96 ++++++++++++++++++=
++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Docum=
entation/devicetree/bindings/mailbox/arm-smc.yaml
new file mode 100644
index 000000000000..b061954d1678
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

