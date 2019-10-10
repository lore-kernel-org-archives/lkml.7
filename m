Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE070C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAAE20679
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="rEAgOEFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbfJJJc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:32:56 -0400
Received: from mail-eopbgr770132.outbound.protection.outlook.com ([40.107.77.132]:7502
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733134AbfJJJc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:32:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcVtowPkP7jwJJ5bqOm+J9nzzmQcX/KCdEB+rcpCgaftjUKGK6fuZtWS/8C0UeDk745suaSsDJDhwvQcVp+wjKe4SrXPTuT/DtoFQ0qa62r4fwocAx10S6KwvVgItetsAF8kyMNLbiePZuHwYcR9NVaX4nwUiVCCzTozLGrdKC/bYSjXZYLHiRTdFll2uuZCfrGWA/2+SrYl4TzvUd5W500Cbiy04dy/jh0ZD2dxm/36BX5bCRILJecicm5xzSx82c0E5wNBQWL3IZejwAin0ZQNOHFiY8YTY1pEfFsVx2732XYqHqk4PSphC/ml4bO34Npm0xul22Jro8Fogt4A1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrgTNskGg8ZuhmFhtCjGXkTrtLDGZr+OZQHgY6yQ/BY=;
 b=UzQh2Yprnxob11qgJyfhmfCA4Ysvx11nxXrj3qBhIGSXhvHeX2mB6iO3QDVTdjd5E/bGg9GZF2BlCCjsuexAouzq3/1dfCjEQ+Dm4qsxJls66adPz7QyCFvp33A1IpU8uvngMg+oPGlU2zwinceynLMuyffhG15bRyGJKbsMgRXJEOpM2Eq8ZWddOdIH0nMXE9brk+yB9aLOM69OJGh4Adu6Nwt5miC2Avbv1ncayWYBSJmAfkdZs3yQI9izaL7YMLJMYTj4DoDfvP5FIhffN+5Z37FboWHei8pVrnLUXsVrnwOv/syE3YlYp9JQ3TflMcp+PtdQmhQwU/+KkFAkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrgTNskGg8ZuhmFhtCjGXkTrtLDGZr+OZQHgY6yQ/BY=;
 b=rEAgOEFUHoPvhEJ3NyR/nEy5N/dTH/EWRwBOuBH0oDbkNDJ598RcwLKtqWX3+R37y3T6C7G34dsgX1beFPv5jCRWa4tE1erGhHeFZX2z76DiAE5Gg/hRnUAqEbi5DhbXlCFmyf2E9L8lnUnK2Xtr9SrBBZqgyvh0NbiDC/vXA6c=
Received: from SN6PR04MB4543.namprd04.prod.outlook.com (52.135.120.29) by
 SN6PR04MB5374.namprd04.prod.outlook.com (20.178.6.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 10 Oct 2019 09:32:53 +0000
Received: from SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87]) by SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87%5]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 09:32:53 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Thread-Topic: [PATCH v2 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Thread-Index: AQHVf02w0tar4Vo+gkmhei+cTfK0uQ==
Date:   Thu, 10 Oct 2019 09:32:53 +0000
Message-ID: <75bb8a47d2c3c1f979c6d62158c21988b846e79b.1570699576.git.xji@analogixsemi.com>
References: <cover.1570699576.git.xji@analogixsemi.com>
In-Reply-To: <cover.1570699576.git.xji@analogixsemi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::22) To SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a8::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a98796f1-9818-403c-f437-08d74d64d346
x-ms-traffictypediagnostic: SN6PR04MB5374:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB53746A930F2088112C8EB57FC7940@SN6PR04MB5374.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(366004)(136003)(346002)(376002)(199004)(189003)(99286004)(4326008)(71200400001)(71190400001)(6506007)(256004)(52116002)(386003)(76176011)(316002)(305945005)(2906002)(7736002)(186003)(102836004)(478600001)(25786009)(118296001)(26005)(14454004)(66066001)(8676002)(446003)(11346002)(86362001)(6436002)(5660300002)(8936002)(6306002)(2501003)(81166006)(81156014)(6512007)(486006)(54906003)(110136005)(7416002)(6116002)(3846002)(2616005)(6486002)(476003)(66556008)(66946007)(66476007)(107886003)(64756008)(66446008)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5374;H:SN6PR04MB4543.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VNKIk+ezn9/3Oq0wGijk9CdJElpYUOP9DKOfMMxD+12e/jpY2j1DZ+uCwdgjvIcVPI2YBEoFmkMpdmmqlNnPj3Odpb5CvNBr6HhMUEMfeMVuXPJrhx+Oo+j5yzHowFXsMw744UYzeDLpKEJ3KTN4DZehvgCQRBDmYieH3MXgy/kuntEbHNzlZ5LOBlroU4PGQH3oippssDEPxB3zSESK55IGChKCWvcoic8mdHA1FGzEcRC3xUc11ahE7zy8iIq5slkNc+3qgl1u6cM8xehNuAV6kupF2vVOQFWKMfyV0Fevv25egBvrraCHJWeWWePeekusQnzpgxmmNaH/zXEcXrneMEZWLRMSzlhnAtakFMHSTHGruyWRWHrkz0vCoymZoj//BAuO5BxB7cLg9UpRU7O1paVTX1TX9javd+Z9sZ5pjpMYTEIuaYJS/Ld8NJC40Paj0RXX4gBWFbUXl4inug==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8563689AB4F514E8864186E35B468E8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98796f1-9818-403c-f437-08d74d64d346
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 09:32:53.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ttDePMQPlv/HbvZHwTUYZlKGjgabEC7gzxNUNyxB0emIBYp/EBr/jyjmOZX036t1346PuDi17nTfilsUObOug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5374
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

		port@3 {
		  reg =3D <3>;
		  anx_1_out: endpoint {
		    remote-endpoint =3D <&panel_in>;
		  };
		};
	};

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../bindings/display/bridge/anx7625.yaml           | 96 ++++++++++++++++++=
++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx762=
5.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/anx7625.yaml =
b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
new file mode 100644
index 0000000..fc84683
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
@@ -0,0 +1,96 @@
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
+    description: indicate the panel is internal or external
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
+      A port node pointing to external connector port node.
+
+  port@3:
+    type: object
+    description:
+      A port node pointing to eDP port node.
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+  - port@0
+  - port@3
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
+        port@3 {
+          reg =3D <3>;
+          anx_1_out: endpoint {
+            remote-endpoint =3D <&panel_in>;
+          };
+        };
+    };
--=20
2.7.4

