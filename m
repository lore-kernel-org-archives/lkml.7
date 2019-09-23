Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783CEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3514720820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eKr5c6Oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392836AbfIWGhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 02:37:10 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:46915
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387519AbfIWGhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvjAWa0ZUVhuPAwPJH1hbwieFdJe+SedWH8hXM3WY5Gkw/qLS0+/2h0o5hQLGQw4spm5bo+kDp/za3+poi9+bOBazcjXHjdFeU1zedsbWcz0SpI1ftE4U2S0VDQm6itLrOsu3AOYfu7mY7XWdQJRyJdjpjsQQHWfC18pNnXR/TmGTlMc0Q4spZS1j3pWNfFuKiTeg5NDTCOlBhxhmnViFeVk+GECjW2u+o2dkXoy7rN4VE+rGevkhoEZLV8rGEPXDI+caH3GzjhiZa8W9McPz/Le++qz1z7MqFj9XUBfp/mSfGRRQFwhKoGMLVAPlZcD7Sc5GN2fBJD+3UtBzFdhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZEmrTrLvcHhk4Rwl/9jaIFU1TZCoQCs1/2nesl5Lhs=;
 b=ErEcqTtzGBoa3CtopA1c/i+rLTdH+hDOMTzeavfqDhdp/EawwRqBEjoxcf4X6/rQCP1E3Jd2i00pEzd0Zg+RxMZuB9Esn+s8gVDnYtrd+M23Gf74+pIbgweNVG9TeFBTlfSvvIXD0ysPu8TcESAygpXkFWNrQO2v0ekDGCLOCdPK1tFryJUHaS/VrN5+3lY7u8xaWbKVgy0K0yZZvAW6fhET6IH9q+s85bBa5YsTfv8tUiu5cjDTK5e7U/oIdpnFeCNU3wRW+rWvbL8wXuBAI8kDipCnEvTyVR+EspnzfewmXQmbJIOnnDR62RTxzwmBTnb/hiaOt4FR3iZkoyz/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZEmrTrLvcHhk4Rwl/9jaIFU1TZCoQCs1/2nesl5Lhs=;
 b=eKr5c6Oz8mXTSyLe/rPILle3jjMvi9ePNa4csrARXHfV5fhRaubY/jeGgUNCMyqSaIzGfRBZTDyy4Z5mrQVkMpdZgIVBu+gzefVEGn+aGCuVhws8k6GOUgsxMjXnVbHfHplhgeaBlBbba8k8F4zpCzN9uK/TipvdPEEH3jrfFNc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4449.eurprd04.prod.outlook.com (52.135.148.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Mon, 23 Sep 2019 06:37:04 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 06:37:04 +0000
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
Subject: [PATCH V7 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH V7 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVcdlQHZZUGWoiukCCEZMk/7qClA==
Date:   Mon, 23 Sep 2019 06:37:04 +0000
Message-ID: <1569220514-27903-2-git-send-email-peng.fan@nxp.com>
References: <1569220514-27903-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1569220514-27903-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:2e::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7793165-2abd-49b0-48b9-08d73ff0726a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4449;
x-ms-traffictypediagnostic: AM0PR04MB4449:|AM0PR04MB4449:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4449E16913CB88286D9F451188850@AM0PR04MB4449.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(2501003)(2201001)(305945005)(7736002)(54906003)(66066001)(64756008)(110136005)(66556008)(66476007)(316002)(66446008)(6306002)(71200400001)(6116002)(4326008)(71190400001)(86362001)(256004)(66946007)(6512007)(50226002)(8936002)(7110500001)(99286004)(52116002)(25786009)(76176011)(6436002)(26005)(3846002)(36756003)(2420400007)(8676002)(2906002)(11346002)(81166006)(81156014)(186003)(15650500001)(102836004)(446003)(44832011)(486006)(966005)(5660300002)(478600001)(6486002)(6506007)(386003)(476003)(2616005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4449;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jbo9zsu9ZX9xlJWaO9hLBVe7tRf4mQF0vlPUEB0NUISeYpISvkdOEs4n9+WMsB3t/7q8hSZk2QTrDAmPDZCwT4u/fBidlObQqElV5OYziCVRPywraVCja/AAc577uZ7I7fLjCkDedvNooeIHbgOrdgyPo/lFF0K03izlWa7YPsOWC/9AXfhIZWdyjcJi2+0sQt7VRYs2KAvDl1fFoCDa0NMHkYwT6xEQ8KKX5DxlyDI5iqYVs5eUb7PsnZMAwzNfVVPwXutyGMIWoApcUvsuyg8PTRx1VuiQ/e4dXMhcgLe4KFcbHtEPvuCvzaQ0gCfGFgv1XNW8JU/1UjglxuZO2P+fWAIlh0iHJJcaifHpIge3M21uY9uQsjKpI56Ut8cpe3TEkHVW8VTSiCNT6tBGrGyd2D7bQQhWBGHQdVx+Tew=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7793165-2abd-49b0-48b9-08d73ff0726a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 06:37:04.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90OakBBbkpAOui4zs/t/FA22behxiFUMCnoSBHJrqZUI59cqryOPxQfo0HG2gSAZa0FcdaHbJHaRWPbMWs+jbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4449
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

