Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F5AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6862067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="teY1jyB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfJOHds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:33:48 -0400
Received: from mail-eopbgr800102.outbound.protection.outlook.com ([40.107.80.102]:32408
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbfJOHds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG2rM5djP0CxkzT8JIpNQp0NLSYQF9y6mAl4YlJAeU6wzwFOD7nU1Ix8AQDpY4qNBCgH0wSnx6dpY9QXFgd5LFHW7BFaSdnPL6xhB77zUhxxWvIFEkVQ0el7pDe/oRKQxDA4Q+l1308JySetrFcP1ngLKOvkme6oA3NNWUgBIk6CGG6xuaqRw3bcr33eDiy8ewTphNU2rqyoH93NZNyOb2mUFd4MAeYkaV64d0yhq0qVmFUt1YCihE0tHGOHz7BCdkXsAKFaTHpOd2iYHRoEugyCMgmFzda9acCnK5aR2i0z3t9WFhkRd+VlyFSLo8Cm3vD3Ue/BtcFf0d1zP7LNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+GYu9VYFD1uOnMGbRWIfFjJqLaFA4oX3QHgEOliP0=;
 b=QLVPDKp2ijFrLtI7hKvEPtuGqMgSSMpf6ILn1u2vfo+zE9y6G6eROp31ka/UMcz731WiwQiVUJWXpdq1W2lcixqh3tkV+nTZX1sEJODsEQm9KrzEd0P15ANgmKe3NQz66a/4Obz7YLDLve5apc5CMqGG7RN0ukT/nZypG9pxmr2QzqjgMMZlsR6YSrALLemHQjXfv/tGa5cJhIf/xVPjzbIW7kP+zdUNqL97TWO7zlaFGn52Xupu2Obv9kS2kCHUt1mRJPUVEedLjMs2FKoiKl/plS/kp0F8zQP7AErtNODblvk31z2k8DUtF3YyPP9wuXKczc14ohC6WITTgTSA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+GYu9VYFD1uOnMGbRWIfFjJqLaFA4oX3QHgEOliP0=;
 b=teY1jyB8PuOUU1Cl/yh0zG/nVWvTWrYYf+v4+zQnv6xH4mUDsXaYaNiFaoj1GQ39s5FKyYQMsFH9Awx0Ad5KUNiAADkspIAHQILZhqZ+TQ7ibrTyKzPmLsC8jzw2B5iVv3Ig/ajVxp/8wnhXB0xkAljzOnZT+aMy773g/yd3BN4=
Received: from SN6PR04MB4543.namprd04.prod.outlook.com (52.135.120.29) by
 SN6PR04MB4254.namprd04.prod.outlook.com (52.135.71.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 07:33:42 +0000
Received: from SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87]) by SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87%5]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 07:33:42 +0000
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
        Sheng Pan <span@analogixsemi.com>
Subject: [PATCH v3 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Thread-Topic: [PATCH v3 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Thread-Index: AQHVgyre+S/t6KpHxkeNBy40Rhs+Kw==
Date:   Tue, 15 Oct 2019 07:33:41 +0000
Message-ID: <67ccead807b7d0a50df479cab2c9d325041224bc.1571124579.git.xji@analogixsemi.com>
References: <cover.1571124579.git.xji@analogixsemi.com>
In-Reply-To: <cover.1571124579.git.xji@analogixsemi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR04CA0133.eurprd04.prod.outlook.com (2603:10a6:207::17)
 To SN6PR04MB4543.namprd04.prod.outlook.com (2603:10b6:805:a8::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3c83893-f8b1-4c50-e349-08d75142009d
x-ms-traffictypediagnostic: SN6PR04MB4254:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB42545BBA73B828295AE09AC5C7930@SN6PR04MB4254.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(346002)(136003)(376002)(366004)(199004)(189003)(305945005)(256004)(316002)(71200400001)(186003)(107886003)(36756003)(71190400001)(110136005)(81156014)(81166006)(54906003)(6506007)(76176011)(7416002)(99286004)(86362001)(386003)(66446008)(66946007)(64756008)(14454004)(66476007)(52116002)(8676002)(8936002)(7736002)(66556008)(118296001)(6116002)(6436002)(3846002)(66066001)(5660300002)(4326008)(2501003)(2906002)(102836004)(478600001)(6486002)(26005)(486006)(6512007)(2616005)(25786009)(476003)(446003)(11346002)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4254;H:SN6PR04MB4543.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTM6ZKNLu646IvCcfoGqXIV6eV/YDMAmTPq06hGroi6GWQCcdDtYHhFsQN9FiUNtjkml7KwIiRFSVeTiyAvWGnrZDVvj01b4ONyBH2aNo6DjuURT8a684vr0cTwOIHCWxHK5jRmbJahg4YTKKLPQ7R8bY/1/ewpLMZLFzpVgegM2tB0JqcZagcgv+poXST+Ps76Ph3t75x+imq8hbiEDyefjIZt+XeJsZNW3Qqyz8/25ZfYJ8E67vTDOI0qvsOPVCJ0gVIGrEEBFUGvXdyoQ+JjV4QJUYKAJX7jXcVY2xEjJ6gGfyewxcKdcqaVimwblW6XygFD9OrBc8BBGcGM7pdB1oqwNDOxSUmvH1jFdnLozYBrK+3sbgD72uZQgc4r+fFcaZRe6NcYpkl7WvldkMBbPn52dNTbsLsynhuKAJGZyon/jtEHB/pq/2FKiOj/BoEpnGFk7FJHkOCb/OmdJBQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5542EDD13B600F4AAB83B2BE8F0A6C4A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c83893-f8b1-4c50-e349-08d75142009d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 07:33:42.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYyMqhNvnxQVAXysP6ntH+i7TE3k7LxcBU1deL1H9FJv55yN7Oq47oEzE9FUZ2IA2QQgukQ4vyjOitp8dddARA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4254
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

