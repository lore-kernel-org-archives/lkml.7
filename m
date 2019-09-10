Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB23C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A09D218AF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="TIcQ3/YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406362AbfIJGV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:21:29 -0400
Received: from mail-eopbgr50108.outbound.protection.outlook.com ([40.107.5.108]:55813
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729225AbfIJGV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:21:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhg7ZT82NwesiUkcJddPa2yaTm32zBcBHWxEgFv94JirCSy9t7voSOpFP6aLIGjQWOplidNp6Ce3N7vZGArRRHn3fmcR+crJWqleRmd5LAiKebCOqJ0Fw2xZujXvbwmCM8zmiQAwDP1C9bkQY6AZ5C9mzx+sRMaqVr41KDNzDPb4zbbiJgk3zl/6a8xf54AhWvZY7gKEiEyfmuMcNeldYxXIuWXqP3rdGo2EL/inK5fHTeNsdt28ZmIsXywak/JSl6WcU+mPvIcd6Pv0PB/Oi/3wApdZnb83zGytuM5ZpKQZ3sQqOz5KhctiBjinmo+0eWixc3m9QAqtdWtyU9yiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lw/u77qKfClSUC288gg6paJ5ZIe2cgMdlPPPI9hUGbY=;
 b=RFR1qH5uUXXnnCITxxC7Wi79Mc1gf3V8SuaWcjNlj/Gcz2TML1WrqIpRcaIqXaX+C7nvEsiy4OIhPm8YlKg2P5KQadRUH/OHV1461AEiIN7DgFgGoLOA0ULQe0eqPuI3f+2nAWfbZa+/+G5Cnf3Rl/EIAZeGvBF2Hhoa4PH8wVsUJ8T3HbLGmcKb7CzVvbX/gdZxunHwv0lxjYDzYgwYoKK51rH6WBQnElmumqluTMT/grkLdlmrId9XCiqGhRPBwV30kCdV1TAhgCmgFs52/vl19pzenld4XyXL226XyOhzJZMArDRoIwX+NxcqtP+ix6gjZaxJ4Ka1fU+nyEqTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lw/u77qKfClSUC288gg6paJ5ZIe2cgMdlPPPI9hUGbY=;
 b=TIcQ3/YGx8w9HBjAcmwH0Ef32tlSTzblWZ2Lydi5YDGrVSqhzhpCrGhmfLOVweYN6pU23MTv08JPqfbys2ZwinCgtwqu09c7kt31SB00d3rg+NO9lxaiv/dzMZg3UT6N1H386Qk2Ppg8Lw+f7A8SRQe1KV+VACAhPR8KYGNctxw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3054.eurprd05.prod.outlook.com (10.175.21.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Tue, 10 Sep 2019 06:21:19 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 06:21:19 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH v2 3/3] dt-bindings: regulator: add regulator-fixed-clock
 binding
Thread-Topic: [PATCH v2 3/3] dt-bindings: regulator: add regulator-fixed-clock
 binding
Thread-Index: AQHVZ5/14/SgXrjoXUmhwZqwM+HFaA==
Date:   Tue, 10 Sep 2019 06:21:19 +0000
Message-ID: <20190910062103.39641-4-philippe.schenker@toradex.com>
References: <20190910062103.39641-1-philippe.schenker@toradex.com>
In-Reply-To: <20190910062103.39641-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::16) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46aa964c-8e2a-422e-51a6-08d735b717bc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3054;
x-ms-traffictypediagnostic: VI1PR0502MB3054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB30546EAF9F99B9C39BE98E13F4B60@VI1PR0502MB3054.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39850400004)(366004)(346002)(396003)(376002)(189003)(199004)(316002)(25786009)(14454004)(4326008)(256004)(71200400001)(71190400001)(7736002)(305945005)(53936002)(478600001)(50226002)(107886003)(36756003)(8936002)(66476007)(66556008)(81156014)(64756008)(81166006)(66446008)(66946007)(486006)(44832011)(110136005)(99286004)(1076003)(6506007)(386003)(11346002)(446003)(8676002)(2616005)(476003)(2501003)(6512007)(14444005)(26005)(54906003)(5660300002)(86362001)(6116002)(3846002)(102836004)(186003)(2906002)(52116002)(76176011)(6486002)(6436002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3054;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jQ9QjYDPZ9Pb5nRSFo/FFaJN/lajnj1uaC5omyDUtbr9LPa/L+RVwMSuG1Zfz9P9uCGjafESpcpfwVFPksbzT5AnkKy6iLOX5iVXcgq9W1tMI78Me2IgTbZY2wv5pydnqFvAh49qE7clqrGw5mkUKI+ErDImyiVllZGZzDOBL0z3SldfU6DS9T1RpWmkuEjNN8WKnvW58DfNWbJQ3hlqjK47kdn6qhc/4PqjsOMVvAvcJ+S1LILRW5Unisb/2ofjG5Y43zWZGeiYL9g/K3VroEtN9+qm5AlIxW0rWZYtbHtllxLNDMUj4zRQUB+QpgoRzv4yNIYUi15w3G+ULE6k+1m1ZnatpeNku85ImpDOCmGbt0B5bIodt4BG6HNQWNpF6aNFTqd93X78lMaqBwgqTsjI8mNYGwLYnZ246Y6ze5Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46aa964c-8e2a-422e-51a6-08d735b717bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 06:21:19.2378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Rco8yqjB62M5GSss0C1dz5exb62YItsrBkwSc0XTL3NomfMIkSX8XNvTTnMI+Uu3weD4iHI9I5jPkFtjrHrasE0lhg8bdXZw91q0m1sf1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the documentation to the compatible regulator-fixed-clock.
This binding is a special binding of regulator-fixed and adds the
ability to add a clock to regulator-fixed, so the regulator can be
enabled and disabled with that clock. If the special compatible
regulator-fixed-clock is used it is mandatory to supply a clock.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- Change select: to if:
- Change items: to enum:
- Defined how many clocks should be given

 .../bindings/regulator/fixed-regulator.yaml   | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.ya=
ml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index a650b457085d..a78150c47aa2 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -19,9 +19,19 @@ description:
 allOf:
   - $ref: "regulator.yaml#"
=20
+if:
+  properties:
+    compatible:
+      contains:
+        const: regulator-fixed-clock
+  required:
+    - clocks
+
 properties:
   compatible:
-    const: regulator-fixed
+    enum:
+      - const: regulator-fixed
+      - const: regulator-fixed-clock
=20
   regulator-name: true
=20
@@ -29,6 +39,13 @@ properties:
     description: gpio to use for enable control
     maxItems: 1
=20
+  clocks:
+    description:
+      clock to use for enable control. This binding is only available if
+      the compatible is chosen to regulator-fixed-clock. The clock binding
+      is mandatory if compatible is chosen to regulator-fixed-clock.
+    maxItems: 1
+
   startup-delay-us:
     description: startup time in microseconds
     $ref: /schemas/types.yaml#/definitions/uint32
--=20
2.23.0

