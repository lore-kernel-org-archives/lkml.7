Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CD9C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092F8206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HOFh4GCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbfIPJop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:44:45 -0400
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:50033
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732076AbfIPJol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:44:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrMgPtMpG/hWzDYZygCaqyYLBcZdci7wPeHaVR0hxZ5t+nQnqSI6T88Z1Y/mzmJoeVcQ8gYnUoHzn0Ys+R3cOT+2U+6rjrmyPhacKT+AW5UWan+/Bn9KE0QNPJ7GapDdgWjsv+3FX/6uop+PrIHEJyJ5vnsXnXgeEmTvHTaoCsNB6APHl7fW7kOBC2EhyVcfzfDy9+6agYTqby0+uIaGe4gx+elrZsUfPATOBE5g9bVaqKV5RLcC2+3D+6mboYtAGc7MliOjRQREKgflxaT4wC9hvlq72CKgyo21hooamraFeNB4bXsWG5SPJeGgPtsVsqIXluoUY5id2vkQ1aTlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUuVzbJ7bf1qJ9ZJupqO/l65iQ3g97WS2BhWetOqOL8=;
 b=cFQdr5knmlXDaFqZsMSXpTKYKp5FmJw7dW03hX+fZ91XDkGuQemgnPEvmcMOQ2MqVx1Iwvf0gkJRKiMummqs8UMa39PVgMX7m0JaMet6sxbtpGzLAcA2RkqUiHbZ5TSmGZvx0Pk5BVwqkelzQwBSycbdmqT5Oh4fXETlegAz5/9kpLOBPwTbhueZ6ziEIey1IEc/aszsqXB/+OSa3v8w/SFYvbXQLMyz+qqPKz/fq5qm938N1DsDOeb3gzReImZAYd1uK2Tllo7LBmqmBsn7q8cFPF0kvqtHnTyFX90qCSbyLmAZrwQwpjaIHrMOYWHQLmGzWAbJQUoXK2wpQAL6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUuVzbJ7bf1qJ9ZJupqO/l65iQ3g97WS2BhWetOqOL8=;
 b=HOFh4GCZaNDGTJpaOMypZEKm6iOk4qrNJrINqH6gSSa3nX1Y8L9rzlUb0svFfR5wxCdp1nFaeWYCJfaTi3Esw3uC0SUXFKlTnKtrgl7B8b978Q64b6xsPRps1jhC3e2y8+iC3VyUG2ajeyoR0jfulkSOCR+cfqQ173IIEozkY14=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4674.eurprd04.prod.outlook.com (52.135.149.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Mon, 16 Sep 2019 09:44:37 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:44:37 +0000
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
Subject: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVbHNaBQCH9BWPL0mqFSSgcphDeg==
Date:   Mon, 16 Sep 2019 09:44:37 +0000
Message-ID: <1568626884-5189-2-git-send-email-peng.fan@nxp.com>
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b08cb44-9ab6-42d5-b561-08d73a8a7d2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4674;
x-ms-traffictypediagnostic: AM0PR04MB4674:|AM0PR04MB4674:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4674966911B7ED8CB6E8643E888C0@AM0PR04MB4674.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(50226002)(81156014)(44832011)(8676002)(8936002)(81166006)(66946007)(14454004)(52116002)(99286004)(15650500001)(2420400007)(7110500001)(6436002)(316002)(2616005)(53936002)(486006)(305945005)(7736002)(86362001)(476003)(76176011)(66066001)(36756003)(2201001)(54906003)(6486002)(446003)(11346002)(2906002)(66556008)(5660300002)(6512007)(110136005)(53376002)(386003)(6506007)(4326008)(71200400001)(26005)(71190400001)(102836004)(966005)(6116002)(66476007)(3846002)(186003)(64756008)(256004)(66446008)(6306002)(2501003)(478600001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4674;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P0yr8gN/7qVEOJLa7L/P93lXyuOF86xeufiZE+a4zHW6uacqR+rTf8ZYXUHW52EDs0xLyioZpy10XA2+CcuFJdJqFlt5YAMaLk7I6r8a+7qWDyhTbX7NjNvbXyOkCE5MyqIOcKKMpOJ6iKyNeznLretlvRrhNj1rTCkIwFe7UZGworoP+L5ZqLOm2a6hZxzqZGlBk58Ro6YVbxDqj3NlLBwApGRGJEsUsCV1YqGr5q7UT9qYA215TwRHEUe3/cGZI+QdobDVmhgV4JcpgzlCbfmc1ouRwq9EzhJwMnRM9uzjAjsS7JlmV+0QBRCZenUFMl5U1v4IIZLoRkb+ACjXcqAnRXRkBzrnHktG58p7MMxA/AD+EyNPHSQQtaKjELUS/zctLj6+KrMdBDVseR+oFrupNqx/+N2kz4W4Zuv1qRk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b08cb44-9ab6-42d5-b561-08d73a8a7d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:44:37.7940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g32uLYARLfEaadu6+JimH9zDeP8h/ryoqMSkjHTO365+Oqmt7VmwlobNy4rBN7jW/FR8fDI3TWvtWpzJwvbMlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4674
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
 .../devicetree/bindings/mailbox/arm-smc.yaml       | 96 ++++++++++++++++++=
++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Docum=
entation/devicetree/bindings/mailbox/arm-smc.yaml
new file mode 100644
index 000000000000..bf01bec035fc
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
+  This mailbox uses the ARM smc (secure monitor call) and hvc (hypervisor
+  call) instruction to trigger a mailbox-connected activity in firmware,
+  executing on the very same core as the caller. The value of r0/w0/x0
+  the firmware returns after the smc call is delivered as a received
+  message to the mailbox framework, so synchronous communication can be
+  established. The exact meaning of the action the mailbox triggers as
+  well as the return value is defined by their users and is not subject
+  to this binding.
+
+  One use case of this mailbox is the SCMI interface, which uses shared
+  memory to transfer commands and parameters, and a mailbox to trigger a
+  function call. This allows SoCs without a separate management processor
+  (or when such a processor is not available or used) to use this
+  standardized interface anyway.
+
+  This binding describes no hardware, but establishes a firmware interface=
.
+  Upon receiving an SMC using one of the described SMC function identifier=
s,
+  the firmware is expected to trigger some mailbox connected functionality=
.
+  The communication follows the ARM SMC calling convention.
+  Firmware expects an SMC function identifier in r0 or w0. The supported
+  identifiers are passed from consumers, or listed in the the arm,func-ids
+  properties as described below. The firmware can return one value in
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
+    const: 1
+
+  arm,func-id:
+    description: |
+      An 32-bit value specifying the function ID used by the mailbox.
+      The function ID follow the ARM SMC calling convention standard [1].
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
+      #mbox-cells =3D <1>;
+      compatible =3D "arm,smc-mbox";
+      /* optional */
+      arm,func-id =3D <0xc20000fe>;
+    };
+
+    firmware {
+      scmi {
+        compatible =3D "arm,scmi";
+        mboxes =3D <&smc_tx_mbox 0>;
+        mbox-names =3D "tx";
+        shmem =3D <&cpu_scp_lpri>;
+      };
+    };
+
+...
--=20
2.16.4

