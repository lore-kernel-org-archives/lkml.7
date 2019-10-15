Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7CC20659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="roHHYmBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfJOJrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:47:55 -0400
Received: from mail-eopbgr690108.outbound.protection.outlook.com ([40.107.69.108]:6597
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfJOJry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:47:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV2GguyVgEshT+sg1sf+Y6TtaYnNiILQvQyubbPeYjaCYooFzsIHbDiqFvru8jIxy4qvNb6vh9DV8lHK15zvYAyq8O9HgKv0z+585wGyxhbvZeymdTmGUHZ6+1hl+yzT0HrxnbiObFR67dYXCyTpGlcAx4hPWHclNKn1yeo1EQvPzoloVkRuu6cuteQzpnKWl/WdaqLzrA9D3MGKeyN30jUzLtWZGBA3vSrzQYqFMasOo+382qjYDb1h0h9zgVQZL9iVmNbKvEv2L5AOklD0ynBAiypHLvAMQVE8wW7Qkt76A1XyXfWERfo5MvBWoWLK3Mz8pXhKzCTvTnPM90gRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+GYu9VYFD1uOnMGbRWIfFjJqLaFA4oX3QHgEOliP0=;
 b=eeJIKLJ9HkWWGCPQ94K+CrYDBM4rhukYg/qh7djkfbb+cDrI7Mv9NJDx7p3TfA4xPMmg41JtDPxQr1MqDUtUL9PEkzAWkSFEQpB4tdOfDUsHamG8FrYXr4/wJuaiuvq/VnZsaviwVOjjycfQ2yrYtUo5pzB4kGz2muZmNZ7WQRYPpS9A948kVCUu44ciyAoHP2cuIxIBCKRF1y8BTyBBwqp37kFquTGEzzT+nypJSLpTLnJ3vdB+dkwBm+cpAZsf0G5ONX0x7j0B+W1qKSJXuLuoXEjOi3oG3YHjvn6AG/3A8G+dqKOWSLGv57QjY+GqoszDeQWWmaXBjnyQVvE8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+GYu9VYFD1uOnMGbRWIfFjJqLaFA4oX3QHgEOliP0=;
 b=roHHYmBTbOyi1MLwAr5c9y+UuNUBmu9YC8jR/HgBG+tBEG0z+h1/1da3eo1XyL1NqqJFi0BEQxcblqjZ0XLDbSrLq7d/ovuC5TCUU5132gqXMuQ6CRmdtAj5tWM+LZFEtqNALVN06LkYVbKejtyNGFqzI/wfeDoftAY1LRCSWRk=
Received: from SN6PR04MB4543.namprd04.prod.outlook.com (52.135.120.29) by
 SN6PR04MB5360.namprd04.prod.outlook.com (20.178.6.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Tue, 15 Oct 2019 09:47:49 +0000
Received: from SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87]) by SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87%5]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 09:47:49 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>,
        "lkp@intel.com" <lkp@intel.com>
Subject: [PATCH v3 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Thread-Topic: [PATCH v3 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Thread-Index: AQHVgz2aARDq5pUGhEq7iSQbrjmgeg==
Date:   Tue, 15 Oct 2019 09:47:49 +0000
Message-ID: <67ccead807b7d0a50df479cab2c9d325041224bc.1571132350.git.xji@analogixsemi.com>
References: <cover.1571132350.git.xji@analogixsemi.com>
In-Reply-To: <cover.1571132350.git.xji@analogixsemi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::41) To SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a8::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fa2170f-2f16-42a2-9470-08d75154bd20
x-ms-traffictypediagnostic: SN6PR04MB5360:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5360B6AE6F5CF2D1A0644DB4C7930@SN6PR04MB5360.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(396003)(366004)(376002)(346002)(189003)(199004)(118296001)(99286004)(6486002)(4326008)(2906002)(256004)(14454004)(66066001)(36756003)(2501003)(5660300002)(25786009)(8936002)(386003)(8676002)(81156014)(6436002)(81166006)(478600001)(71200400001)(71190400001)(486006)(476003)(54906003)(316002)(64756008)(66556008)(2616005)(6306002)(6512007)(110136005)(6506007)(446003)(7416002)(305945005)(7736002)(76176011)(11346002)(3846002)(66946007)(26005)(186003)(52116002)(6116002)(66446008)(102836004)(86362001)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5360;H:SN6PR04MB4543.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZzdFdt/kcrL5M229sMgVXQsjkz8ulRrTsv5OqXLVAqAhvfTnlTKcGFQJxbSZC+ngNs9tVindRZn6yKYf/NCfyHNGkG+YfRMK6ylfZ1ryQMDGC0VnCE9MXqC/orooBW45Lxjedi0gMjxXkzNHQjRYzXK7OjuMGXE/k0whevVAO7P1MbJ7ZiWgdOgU+vW4l9nYCiedUW8VS/UvGiKC2RUB6DxkNSZwog62N8+BuMibLtYVc9j6dM13rA/xSKrGlHloRrw3fWqcprRY19ybKjWfo+lGBdDgecKASh8nD1h22nBKbG2+6xyvGJ3QGTYK0cB0OMmc0zpIAuaLokdQjsHHw4POE9HUDZeikOX6Kj9w/PsIN7fmtdeEmK8lrWxm+kHE8JfLLCupejc/ebn5GIxS3zMtzqfIgEdb05dsIcaeM8xYZXtxZFcz1Fh8ORR3m+XkM42Hk3Iv0vHojc8pqvBlg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0C10784B4823C45925D40791815413A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa2170f-2f16-42a2-9470-08d75154bd20
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 09:47:49.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g42dOBjQ4AHTwICyyI5HrBMsBeCrxo4gg/y3an5HnaNQYdatw8NHTVs5BVOSFhkUAz4cHeBB+5r6zTst19KmOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5360
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
for portable device. It converts MIPI to DisplayPort 1.3 4K.

You can add support to your board with binding.

Example:
	anx7625_bridge: encoder@58 {
		compatible =3D "analogix,anx7625";
		reg =3D <0x58>;
		status =3D "okay";
		panel-flags =3D <1>;
		enable-gpios =3D <&pio 45 GPIO_ACTIVE_HIGH>;
		reset-gpios =3D <&pio 73 GPIO_ACTIVE_HIGH>;
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		port@0 {
		  reg =3D <0>;
		  anx_1_in: endpoint {
		    remote-endpoint =3D <&mipi_dsi>;
		  };
		};

		port@2 {
		  reg =3D <2>;
		  anx_1_out: endpoint {
		    remote-endpoint =3D <&panel_in>;
		  };
		};
	};

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../bindings/display/bridge/anx7625.yaml           | 91 ++++++++++++++++++=
++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx762=
5.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/anx7625.yaml =
b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
new file mode 100644
index 0000000..1149ebb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Analogix Semiconductor, Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/display/bridge/anx7625.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analogix ANX7625 SlimPort (4K Mobile HD Transmitter)
+
+maintainers:
+  - Xin Ji <xji@analogixsemi.com>
+
+description: |
+  The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
+  designed for portable devices.
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    items:
+      - const: analogix,anx7625
+
+  reg:
+    maxItems: 1
+
+  panel-flags:
+    description: indicate the panel is internal or external.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  enable-gpios:
+    description: used for power on chip control, POWER_EN pin D2.
+    maxItems: 1
+
+  reset-gpios:
+    description: used for reset chip control, RESET_N pin B7.
+    maxItems: 1
+
+  port@0:
+    type: object
+    description:
+      A port node pointing to MIPI DSI host port node.
+
+  port@1:
+    type: object
+    description:
+      A port node pointing to MIPI DPI host port node.
+
+  port@2:
+    type: object
+    description:
+      A port node pointing to panel port node.
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+  - port@0
+  - port@2
+
+example:
+  - |
+    anx7625_bridge: encoder@58 {
+        compatible =3D "analogix,anx7625";
+        reg =3D <0x58>;
+        status =3D "okay";
+        panel-flags =3D <1>;
+        enable-gpios =3D <&pio 45 GPIO_ACTIVE_HIGH>;
+        reset-gpios =3D <&pio 73 GPIO_ACTIVE_HIGH>;
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        port@0 {
+          reg =3D <0>;
+          anx_1_in: endpoint {
+            remote-endpoint =3D <&mipi_dsi>;
+          };
+        };
+
+        port@2 {
+          reg =3D <2>;
+          anx_1_out: endpoint {
+            remote-endpoint =3D <&panel_in>;
+          };
+        };
+    };
--=20
2.7.4

