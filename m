Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3DC388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A7321A4C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZDab5U8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfI3GUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 02:20:17 -0400
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:10790
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729661AbfI3GUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 02:20:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpvvact24/x6Xm7gUSmI4+/i3Sj8JzYyh9YdBKxwJOrh+focUX3q5sfxxaKlXPHs0kgNBT/to+tLd4UgC3QrbPKCmLxPFBvb7pYOmN4SbClg/rFIMlu7AJ+saW5dBfVCmKISESNg5ilNBjjafgx/fDjowaxJRjPn8kjJZSz4Hb40tXVqC/Me8Ht/DpiloLKDKR1AwHb64aGFPIUATChv1T8Gt+aqnr3C4v6LWRleiKko5yLE4nIIarMng0Dt+b1UxpgbpgtOqIyKP7RRbmmFABJm9Kk9VdrWN6RkaZOvqMDH8ZM9C0xp92wVMq8FgAL3K/hUQeWm4gBuwgiJGcrJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGkiKn57+ceqe+yQEGCoAwwJZadA/8huVOwDRsSK/0s=;
 b=BWU5ioxoiSn9kRJy+ZQTS7uDWvAzPJS3eGSb8eRm7B164osZpZcBVG7eH8ZPTPoo24E75bD+qpSkFOFNH/oInyF2xrOg0ABW0wirXnmiFRr0f79Jpu+ULKNTraW5zzO0M/UwRhqP/yH/kuzfCMh0dNbH5QBJzT+Bbmb8TyKdiVgIimEgVF/kIZU6kyu0DaGU2qi3hu7P+teIE6w+07LrSh1H9t9kfHsWix5FOy8n7ls3Q2CfeSbnKkzJbUubmXuTET0D2xiyXxwhFfFehgRulTNRNa2k5HKiuCBXANQGhFx2CIs+t1VP7SvwC4VuIBWGn0gmQ0wQr+xqrOZPyF4NIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGkiKn57+ceqe+yQEGCoAwwJZadA/8huVOwDRsSK/0s=;
 b=ZDab5U8KTYTBTv5hVFLmBcnl7z1bAAR/SDx25Yr6YLrIInTaqwODMWOnE8z2eEHJMbZG8HA3cXpJ6JU7mdnRp5U4BDd6js2uR6F88yTmYa+WaS4TBq+t8sdas5K76C2zRAkYi79n4cGo+H4nfzIra5tBJrHRJrEByiYInf8FgXo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5348.eurprd04.prod.outlook.com (20.178.113.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 06:20:10 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 06:20:10 +0000
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
Subject: [PATCH V10 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH V10 1/2] dt-bindings: mailbox: add binding doc for the
 ARM SMC/HVC mailbox
Thread-Index: AQHVd1cc4oMsT3gTH0q+EEC9zpoQVQ==
Date:   Mon, 30 Sep 2019 06:20:09 +0000
Message-ID: <1569824287-4263-2-git-send-email-peng.fan@nxp.com>
References: <1569824287-4263-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1569824287-4263-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0034.apcprd03.prod.outlook.com
 (2603:1096:203:2f::22) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a949f75-8e86-4bfc-6e8a-08d7456e3ed0
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB5348:|AM0PR04MB5348:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB534808DAF274258FF52A9CE888820@AM0PR04MB5348.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(54906003)(64756008)(4326008)(66446008)(186003)(110136005)(5660300002)(71190400001)(2201001)(71200400001)(8936002)(26005)(478600001)(316002)(8676002)(386003)(6506007)(36756003)(81166006)(81156014)(52116002)(102836004)(66946007)(66476007)(66556008)(2906002)(305945005)(7736002)(76176011)(14454004)(66066001)(15650500001)(25786009)(2420400007)(2501003)(7110500001)(50226002)(6116002)(966005)(476003)(11346002)(6436002)(256004)(2616005)(99286004)(3846002)(6512007)(6306002)(86362001)(486006)(44832011)(6486002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5348;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HT/C7J7VJ/gVrLePrRMIHSF3Jf0LYDlIgiwYDXA+lhE3/S0uRWiYgqL+b65ZZyFQ0xZtj3KiH4bAjHEPxjSklf/ZyPRIQtFLyzor/vvu6N3fze68/5PVVse1T4IB8AoyM4VgtLQUBku+86AepUKwsSuen28v7zA7m1B/qhNeybxM4+yVuZq+LtgCLODQjUydU2HXyGPJvoMBpAmzlTLOgHh0d7vyBAvAodjli7MlRR/R1zf0t8za26aEajBSVj7PWRDz71g8pd9Rpz1Cgtgv+iFrMpgpm9XfQszRK8BzcqftcBcbNLPgEs2yktRitllcu/9WfqnJRjweWSzYeqwNR3Jfa9aRf0NEfLNhhm6eO1l3W9i65Q0l73R9Wx6L72DJGjfEYR4gK49OJwiffctJsZQVhbFBXO4mV6P5UYML1JKAB48OfifDMhHJKbsIB4SK
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a949f75-8e86-4bfc-6e8a-08d7456e3ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 06:20:10.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSuq1TXBEiEM5U1kM171spks6+HHmwBcGdIRFA89Mn//zh8JNiUqHptHDEm25bOZbcHOjzeQyELX/ZE0RSZ4YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5348
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

