Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E25C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E182E214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="cRuJWMQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfKHJAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:00:07 -0500
Received: from mail-eopbgr820134.outbound.protection.outlook.com ([40.107.82.134]:15624
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730281AbfKHJAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:00:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJyWU0h31FC43F7PLDtgG0axCJ9XXUVDVVx8wHNN4PuysJIAxTA7xl3+Mu7rKuPySGrwrwThIu6szs8A/0WihiOoxQ758ZwdnpbNZXzNkp11sGum8iEQDfiRi5crScDukTbv+PjQ/oaqRbYO22mgjXRznnVu7HNZodB0k1c0yItWNa51r9cxRv629nCdz6O+NOMZ2r1k6tX5PqcKoRP24+YgpGGwQr221xTZbGdN6W5+BlkRyUAhg7G+eO3hPNFxI/oXhZUgWBOK/5/jjWdTW2QSH4mCh+/z5v4AXLckw8Dw4NpP9Z2JvrJL+yndwSrgOdcJXrIeE/IXJDrZ7zTOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+GYu9VYFD1uOnMGbRWIfFjJqLaFA4oX3QHgEOliP0=;
 b=nH//AnFZVOZuro4vVpuxiZQKRb9pcotK8TP6+8GfHjkhDycWX6cznF6i8gf/ajO1je/m1Jvj8Cfs1MuokFaS3LSRZlngVcJRx652qLx0ZhPLp+muOtyCYJXNoalIdobHlZZJr/uidczIwlZDtsaaMJoQeufKeqyd/6uiQ0b1MBt/9C5KJWgySoys090gO9saHNIaSTk3OtZN/FJmo0OzrEepX58OF/zkH/1BA0N/HWyWS2gunt8Oo21w8Ju1tST/T4Ju7Fb+CXVguKqYOmqw0ioGiruYbOzf8/5Xr6kLEM0Lndm6+oMlokQmhjpd4OpwyUJQ2J+VdxAPRjkiZ0KoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+GYu9VYFD1uOnMGbRWIfFjJqLaFA4oX3QHgEOliP0=;
 b=cRuJWMQeN83dRadZQJknUZDy+lAYeJeCI4F4fVB9WRbrUcOhiIEgVL1m9EvnbxDolCRXiuyaurLHeBk8X7Q+VU50H4+rRLqTdv4LYjzJRTVcPpiBaLV0DqNOXD4Rpoz7azq2t96+PaBWpa6P0plr8HaaT5sLvz1Jz4BnKaqqKvg=
Received: from SN6PR04MB4543.namprd04.prod.outlook.com (52.135.120.29) by
 SN6PR04MB4942.namprd04.prod.outlook.com (52.135.114.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 08:59:29 +0000
Received: from SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::859:2d31:1f00:fa16]) by SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::859:2d31:1f00:fa16%5]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 08:59:29 +0000
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
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: [PATCH v4 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Thread-Topic: [PATCH v4 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Thread-Index: AQHVlhLT9mIfq1mje06JeNP9Te/Hmg==
Date:   Fri, 8 Nov 2019 08:59:27 +0000
Message-ID: <67ccead807b7d0a50df479cab2c9d325041224bc.1573203023.git.xji@analogixsemi.com>
References: <cover.1573203022.git.xji@analogixsemi.com>
In-Reply-To: <cover.1573203022.git.xji@analogixsemi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0036.apcprd03.prod.outlook.com
 (2603:1096:203:2f::24) To SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a8::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 782ee8a9-9f06-4456-7310-08d76429f4e4
x-ms-traffictypediagnostic: SN6PR04MB4942:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4942AB984473BE8BC5EA31B6C77B0@SN6PR04MB4942.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(71200400001)(256004)(2501003)(486006)(8676002)(54906003)(2906002)(6486002)(107886003)(6512007)(6306002)(11346002)(446003)(6436002)(2616005)(4326008)(476003)(25786009)(102836004)(66066001)(8936002)(26005)(118296001)(7416002)(52116002)(7736002)(66446008)(66476007)(66556008)(66946007)(99286004)(316002)(5660300002)(86362001)(71190400001)(186003)(36756003)(305945005)(386003)(81166006)(110136005)(81156014)(3846002)(6506007)(76176011)(14454004)(6116002)(64756008)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4942;H:SN6PR04MB4543.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DBLSB9luvgYbuGSsNVOTbiyltskqmeKuDE2mgktBGrVI9Dtji22ITF+8POKHN2xobynzSsuDy8E4dPffclr3J0c9frW7TMGT4oxAZf6iZVcd33qrcyN3cyvvDOrFFhV5wDyX/vjM3gQVdegF9E4IgVhQlno0BEE4XGum1ZVo3NyPSDhljuVS/vmKw/pqcBJcw9DPhnbYyrWU9wIAup+9iOwIo/N/p1Y096KNOcPsKVaT7MYYYAZBSjGyKRsDzVMQVEuj/ZBsID7rHrmUSlJQgFE9w6jM2lE/U0ND9cY9Qe+ECrln9LjKItnMqq4pGkPv74ZYUjulvCkOfakGLrmBkFT3bVkoiZrTKl5a2OxJ6W3UTW0HBnxK7V5fGvAnN5rDDlmwN+bylaH5bLf+gX+GiPGPXxsTG/ON2UBA9IqlUXPSbkCrhj1HuaOKRfPOKXRk/it/qdm9W7vT2gUb3toxwDFKmbM0UtlmI5DcOvlKQiQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <457F594ADA47CC4FBDFBC5F56E002D87@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782ee8a9-9f06-4456-7310-08d76429f4e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 08:59:28.3150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiu1z2SSoVEDFsKT9cLQ1LCv5eWmMJbvXh7MISMY9KPIDWr14UGQ56/Xes9hmms1dQeqT2BkVi3N01JU0ksi2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4942
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

