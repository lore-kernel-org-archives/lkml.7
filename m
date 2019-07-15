Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99699C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D2E206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DwpRcf9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfGOKKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:10:17 -0400
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:38006
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729541AbfGOKKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:10:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyv78UNZmuvfPqnRCXd2HJNQqQqYjD8uz5wvbvYbyJj084j9UmmX6gOshPagf2y+JxXdhAoKOeaSiCXojZQz8R3+l1XEAbk+co7Y30vVpHB05I0eq0W5Ec403o2QcDMmiUVX+1cq9V6EeH/537GZx+PW123FjDteBtKIG8ygLDACvOLI0n+vK1562SPi/HvzqRwqto/GSCPIVOqkTbaF07Qk1MaJQjiaNvorT8O54NS/YjoEifIha0AypOiSEnearCBjGypeZlf64WJ2+tMgfH0w9+cHEJcBFhdOkZ6N2QWzj85tG4dmJOT5ryuBUgbUbTJE9CcJzoh4ULnIjFwAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMPKKSIRspN5ganPLxr2YKdh0EHmbfjvslctydqFXys=;
 b=k5axLIOm0dBGUUiuiUZX9CCEfpZsWoSFULSdWcIGsanHU5u9hSFqdihYuuEdclgkhjYLiIO28OP4JPA+X9l2Zw5zIeGBUhoWby6y9CRMk7YrRQso/9J70naAYChhZMAVYvsHz/+mfg26V1ZA7yvdxLSi+90eQchyFOqBgRMxsDBU3ciPQ1GVdse8KpBJYBfkL3EJAel3M3lM2yXQpFkJoRBrxX3y8R+fg2HTAmg5MgmatOaMvlyCdOp6lu02peVy+6bhboJtBLJ5W40o+xoXQ+LMWkk58vD9g7kAMDwOf8pwuk6aRilAOuDxPzfb9UKn/slBGnFASTC5NWurOkiQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMPKKSIRspN5ganPLxr2YKdh0EHmbfjvslctydqFXys=;
 b=DwpRcf9atL7oEo+AJlbc5VvbRsDIdL8tDcKEpJxj7kF10a5i+06NqRfQszExHBvO9BhhZa8jCrdc9ho7Sc1j2kLXSnm9HUQeri+Syhi32OJV52ZshorrixPUy/jRTbg3qIZNlgYp83VhGOVYog24U/cQi5Ywj3D6DwGsCKhBlrI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4356.eurprd04.prod.outlook.com (52.134.93.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 10:10:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47%5]) with mapi id 15.20.2052.020; Mon, 15 Jul 2019
 10:10:11 +0000
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
Subject: [PATCH v3 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH v3 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVOvV8miufREPgWk29kTcXKZEuBQ==
Date:   Mon, 15 Jul 2019 10:10:10 +0000
Message-ID: <1563184103-8493-2-git-send-email-peng.fan@nxp.com>
References: <1563184103-8493-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1563184103-8493-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:2e::36) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 075c2886-9846-4998-d6be-08d7090c9ecc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4356;
x-ms-traffictypediagnostic: AM0PR04MB4356:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB4356C7933144024FC78B4FC488CF0@AM0PR04MB4356.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(68736007)(2501003)(7736002)(305945005)(110136005)(316002)(7110500001)(99286004)(54906003)(50226002)(8936002)(52116002)(386003)(44832011)(8676002)(186003)(102836004)(446003)(2616005)(11346002)(26005)(14454004)(486006)(66446008)(64756008)(66556008)(66476007)(66946007)(81156014)(81166006)(6306002)(25786009)(2906002)(3846002)(6116002)(2201001)(15650500001)(2420400007)(6486002)(478600001)(86362001)(6436002)(14444005)(966005)(256004)(76176011)(6506007)(5660300002)(71190400001)(476003)(71200400001)(36756003)(6512007)(53936002)(4326008)(53376002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4356;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AtzLDsRvqKTXNVTLt/FmlK5BH5wNFAutUrF7UpeiSwI4o2wlHXFh30G1CKoPeuZEhEpEExiELlF5gd2FsUAja5nufRfT+Szxd3bnBPwNZXz/MDNXf6l7Nwx4KZ6p906VSamBviJ8H4xyTz6/XQI0gm/5LSRog/7l0EHkVB5tayjbCWgxXyOdX2uKgDe7038IC/kjAgBUCs4wUOVquB4kZe3UANdy2Xj26ZWYZzO+WIqDhF3dg7QSDuhQunStlRha6BZDajmYeq6ciSM+m4aAoah6izoFnosYoB4zR0omCMvcXZasKjQ3pOl9K81iHrOUJP+Xqqs56e3rFWOp982A4R8ke/wMwiUOFKwyAtfeTWmmGKHVqOb+s5O9DoYsMBGn44mesxGNHHl7hTsaBkVn/p+v7gUCqKWeu8vsYp7LULc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075c2886-9846-4998-d6be-08d7090c9ecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 10:10:10.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4356
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

V3:
 Convert to yaml
 Drop interrupt
 Introudce transports to indicate mem/reg
 The func id is still kept as optional, because like SCMI it only
 cares about message.

V2:
 Introduce interrupts as a property.

 .../devicetree/bindings/mailbox/arm-smc.yaml       | 124 +++++++++++++++++=
++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Docum=
entation/devicetree/bindings/mailbox/arm-smc.yaml
new file mode 100644
index 000000000000..da9b1a03bc4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
@@ -0,0 +1,124 @@
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
+  executing on the very same core as the caller. By nature this operation
+  is synchronous and this mailbox provides no way for asynchronous message=
s
+  to be delivered the other way round, from firmware to the OS, but
+  asynchronous notification could also be supported. However the value of
+  r0/w0/x0 the firmware returns after the smc call is delivered as a recei=
ved
+  message to the mailbox framework, so a synchronous communication can be
+  established, for a asynchronous notification, no value will be returned.
+  The exact meaning of both the action the mailbox triggers as well as the
+  return value is defined by their users and is not subject to this bindin=
g.
+
+  One use case of this mailbox is the SCMI interface, which uses shared me=
mory
+  to transfer commands and parameters, and a mailbox to trigger a function
+  call. This allows SoCs without a separate management processor (or when
+  such a processor is not available or used) to use this standardized
+  interface anyway.
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
+  Any core which supports the SMC or HVC instruction can be used, as long =
as
+  a firmware component running in EL3 or EL2 is handling these calls.
+
+properties:
+  compatible:
+    const: arm,smc-mbox
+
+  "#mbox-cells":
+    const: 1
+
+  arm,num-chans:
+    description: The number of channels supported.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  method:
+    items:
+      - enum:
+          - smc
+          - hvc
+
+  transports:
+    items:
+      - enum:
+          - mem
+          - reg
+
+  arm,func-ids:
+    description: |
+      An array of 32-bit values specifying the function IDs used by each
+      mailbox channel. Those function IDs follow the ARM SMC calling
+      convention standard [1].
+
+      There is one identifier per channel and the number of supported
+      channels is determined by the length of this array.
+    minItems: 0
+    maxItems: 4096   # Should be enough?
+
+required:
+  - compatible
+  - "#mbox-cells"
+  - arm,num-chans
+  - transports
+  - method
+
+examples:
+  - |
+    sram@910000 {
+      compatible =3D "mmio-sram";
+      reg =3D <0x0 0x93f000 0x0 0x1000>;
+      #address-cells =3D <1>;
+      #size-cells =3D <1>;
+      ranges =3D <0 0x0 0x93f000 0x1000>;
+
+        cpu_scp_lpri: scp-shmem@0 {
+          compatible =3D "arm,scmi-shmem";
+          reg =3D <0x0 0x200>;
+        };
+
+        cpu_scp_hpri: scp-shmem@200 {
+          compatible =3D "arm,scmi-shmem";
+          reg =3D <0x200 0x200>;
+        };
+    };
+
+    firmware {
+      smc_mbox: mailbox {
+        #mbox-cells =3D <1>;
+        compatible =3D "arm,smc-mbox";
+        method =3D "smc";
+        arm,num-chans =3D <0x2>;
+        transports =3D "mem";
+        /* Optional */
+        arm,func-ids =3D <0xc20000fe>, <0xc20000ff>;
+      };
+
+      scmi {
+        compatible =3D "arm,scmi";
+        mboxes =3D <&mailbox 0 &mailbox 1>;
+        mbox-names =3D "tx", "rx";
+        shmem =3D <&cpu_scp_lpri &cpu_scp_hpri>;
+      };
+    };
+
+...
--=20
2.16.4

