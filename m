Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF1C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C566222CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RLaDkwMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfH1DDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 23:03:04 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:37765
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfH1DDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 23:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c96HKBb1qeBOQ+iA2CUaxirI7XuL0A7Ps1JcxGtDWuX/xKUap35V0Ws5V2e0btRXnvsGoZYq2U0rbgrO5vpJbkK29A5OpY50Ut8qwSGxC8k/2ydi/bn6pNfUtAoilFYc6X9pW+E0FJaqGQDQTJ9ByUKEA0m1sH2lCj/wosx8ShCjwpXFns3kTmAnc0DF5PI0xDThT6uMJ1nGhzaRPCqVwGuH2MqRKOekQomQ2li9cks6Fkyk+l0G9GyWAyF77ev7LWdMXvqyx49GFdXc89TmsT7mVVL498modTscGfDlf45mCbtKHGdWJuobruO0kHf085yzdn5dyL2OmoQBiYuzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awinw9b12dd9s2A6zxL5K3zJto4eNcrgOJ8yUcCg18Q=;
 b=nAi/lzozeTeWtg+TMc1OSBDI27WEPxbsObnFtOeMpu6g7zbWujzY58bSawd3cDqODAr8Yf+6nLDSVV4t50bxTL/NYLvp3x4LB/hr8AAe/k1OoOHnmib5cJ1RlfHuCycaIZ/2r+zRxD2mlx71kyYn8jhRZdeevWjT0rCSgV7Pk0OxGdHis+18IpHgmolq/xxAwcGAtazayGhQR+b7FKcM0tYBkkq9WnIIt2lrMzIz2rWmKDAMpd5IxglHvFxvNPicTBD2CBfvm+YLeODPWvKLCGCl+qSbWRPHHa+1QPMrkPlcVDV4Q3GpAYCvbxLhpq82NRSoNwCyn1e6PxPI6QK1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awinw9b12dd9s2A6zxL5K3zJto4eNcrgOJ8yUcCg18Q=;
 b=RLaDkwMeQt1O6/H6FNX1wjcQnRO4yXyn1/3qia6mvOrRTee673xNkaiWPnewlcwg+LMWdVpkYV1GdY0iYGsHANNDVZMjPdMWiZ790nGHYTCZ8ZTknMPCeVlmi/KwcRt2+pX3krVnn0aRMEsTV806jxdsmwkuROsiRnyi4ZZYtJw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6033.eurprd04.prod.outlook.com (20.179.33.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 28 Aug 2019 03:02:58 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Wed, 28 Aug 2019
 03:02:58 +0000
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
Subject: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVXU0YJPArUxY1ok6XlIUgkri4VQ==
Date:   Wed, 28 Aug 2019 03:02:58 +0000
Message-ID: <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5fd0184-f381-46bd-1cf8-08d72b643afd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB6033;
x-ms-traffictypediagnostic: AM0PR04MB6033:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB60338E4F12E4D8323780814288A30@AM0PR04MB6033.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(7110500001)(476003)(25786009)(6116002)(76176011)(66446008)(53936002)(3846002)(66476007)(66946007)(66556008)(64756008)(8936002)(6512007)(14444005)(478600001)(386003)(44832011)(6306002)(305945005)(15650500001)(54906003)(2201001)(86362001)(2616005)(14454004)(486006)(6506007)(256004)(966005)(7736002)(6436002)(53376002)(2906002)(50226002)(446003)(4326008)(81166006)(102836004)(81156014)(8676002)(6486002)(36756003)(5660300002)(26005)(2420400007)(71190400001)(2501003)(99286004)(66066001)(52116002)(316002)(186003)(11346002)(71200400001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6033;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FGiOyoN7IKyhNPZm/xsHFBKXmCFxbThH7afBckTmzWmoRWba48DsO5EesoTKuB8WsIIRB9UGb4n40NhVpkVmI/6rotbv9LqAUzxKTLY7ST8jMgVJr+eCqxNW9wSLJEsBpipdwsgPTU3uadJzTWeweHG6swJSD4hU7JoQf9rfWTm4Kqk6b9XJX2PkF6leqESvNVvOxbcR21TXAs8RPVOn92inxhGlEQ1xDZcVGxm2u7LurT43AEzC77Q5NGnV2NyfWCikj4VgwlEdQr6jNw2cmW3l6qcDj8Tl49leGBz9iTGg9slB2rHYLx+lsJn9ugB6pehOI/wu7ByxAvG0/qjPHtQNAWem3HfS1LJuDfAq6RkCv6wpStXiHNdvMwW9nd6m8/1n2pcTQsQ0qTSbjYIHN5FY1iYhOdy+feAjI8p1ZAs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fd0184-f381-46bd-1cf8-08d72b643afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 03:02:58.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOPCOOLww1fBkbeR80LKPhQJ/8PKygZIKpUbPXlkLRE/J4Iu616OOiPZe/cYiBhSmKej4ynx6IGoeStOG+W1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6033
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
 .../devicetree/bindings/mailbox/arm-smc.yaml       | 125 +++++++++++++++++=
++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Docum=
entation/devicetree/bindings/mailbox/arm-smc.yaml
new file mode 100644
index 000000000000..f8eb28d5e307
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
@@ -0,0 +1,125 @@
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
+    items:
+      minimum: 1
+      maximum: 4096 # Should be enough?
+
+  method:
+    - enum:
+        - smc
+        - hvc
+
+  transports:
+    - enum:
+        - mem
+        - reg
+
+  arm,func-ids:
+    description: |
+      An array of 32-bit values specifying the function IDs used by each
+      mailbox channel. Those function IDs follow the ARM SMC calling
+      convention standard [1].
+
+      There is one identifier per channel and the number of supported
+      channels is determined by the length of this array.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
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
+      cpu_scp_lpri: scp-shmem@0 {
+        compatible =3D "arm,scmi-shmem";
+        reg =3D <0x0 0x200>;
+      };
+
+      cpu_scp_hpri: scp-shmem@200 {
+        compatible =3D "arm,scmi-shmem";
+        reg =3D <0x200 0x200>;
+      };
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
+        mboxes =3D <&smc_mbox 0>, <&smc_mbox 1>;
+        mbox-names =3D "tx", "rx";
+        shmem =3D <&cpu_scp_lpri>, <&cpu_scp_hpri>;
+      };
+    };
+
+...
--=20
2.16.4

