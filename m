Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BA3C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99CF230F2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="PgDNSUkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfICIEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:04:00 -0400
Received: from mail-eopbgr80139.outbound.protection.outlook.com ([40.107.8.139]:43751
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728243AbfICID6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:03:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6cUZhND4p1QKdzPYrhwouEy+0Vyx8z/HYblBP2fIwsuqzGbI5IuWkf/cA5jvbYJV4txTthr/1e8IfQ9bwZq6MTmjXZbDrn2UUr3ISpzj+9KWPbOdG1buBWpl9eKTUHT5zILD4i9a0jBHtmC2ywLbyQgYWH0IZMMujDGlabwRgJOa/iQMKdww1eRwlfPKGcdu3ooJS9RnkWsAteqaYqcmbBWNa0lc1kGfM/1x2WlQBJkFZRMorTMhv4k4SYwrpr4fvBxUt+AjOSh+oYBYgagZMFcYwuLiejTyDHGZU9huSxCU5U+yhaMNVcGCoX+ZnkzH8+fjmHLpeoAsEtPabyKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gniKOo0SnsYFqrD12kEq29RZZFUXSbKn/+E+c/3w7mk=;
 b=B/+NbRM0+KL7l7m87Vf89auZ6fjRMBZ59MZN25jnPsPnPhzreA+rFDE496SmDaOR8ASeedgg7NEMLifuLWzjxjoJ2rOQiPbdxWDXqjqM3KYsUMV9rxEeSqE5RITMGd1bKy6MihOgbrL7rE9dkv1N81NCEBR842aslo7EhiutLV16IBSQYNpf7NzBNFw/IrMXmPrfm40/3hHYU0jreBKW0U8QtmmJnYkS+tzx7vffymGgf+nWNm/drHAFJIIlLKgVGJQ0xiZZGGBpmcEulSmWqb2C5Xcta5jdmiV0zBeN/MOibshzb7HiHwaKWPWUEsRwM3xPCURWIGYWahgXO+An/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gniKOo0SnsYFqrD12kEq29RZZFUXSbKn/+E+c/3w7mk=;
 b=PgDNSUkpeHxQMnxbQkPgcZ+WsbHEKZfSdCYZqIPiMRbSIf3GTRe2N6VeGOqvxpAPV0GA5GGbz9pQdHJ8+HO2HUAU3cjNnz+gNW9GSC2sx5WgSZzBmrZ88ehs8v1ZZMU8rpJeCslZEO3dBLLipsn9kwBm/iBA9g+Ytp6qFGTLeJA=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB4014.eurprd05.prod.outlook.com (52.134.18.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Tue, 3 Sep 2019 08:03:49 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 08:03:49 +0000
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
Subject: [PATCH 3/3] dt-bindings: regulator: add regulator-fixed-clock binding
Thread-Topic: [PATCH 3/3] dt-bindings: regulator: add regulator-fixed-clock
 binding
Thread-Index: AQHVYi4eVTMHP4rOrkKfHmYdMpCNbA==
Date:   Tue, 3 Sep 2019 08:03:49 +0000
Message-ID: <20190903080336.32288-4-philippe.schenker@toradex.com>
References: <20190903080336.32288-1-philippe.schenker@toradex.com>
In-Reply-To: <20190903080336.32288-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0015.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::25) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0061a344-0c95-449d-ff0d-08d73045408c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB4014;
x-ms-traffictypediagnostic: VI1PR0502MB4014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB40146281034C0EF00BA36FD8F4B90@VI1PR0502MB4014.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(6436002)(66066001)(81166006)(110136005)(54906003)(5660300002)(71200400001)(305945005)(2501003)(25786009)(476003)(81156014)(2616005)(44832011)(107886003)(6512007)(66446008)(99286004)(66946007)(66556008)(186003)(64756008)(66476007)(26005)(6486002)(71190400001)(4326008)(53936002)(446003)(52116002)(486006)(102836004)(11346002)(1076003)(6116002)(478600001)(86362001)(50226002)(14454004)(2906002)(36756003)(8936002)(76176011)(14444005)(3846002)(6506007)(386003)(316002)(256004)(8676002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB4014;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L24A3LiePa4WGVkdNA/XGOXGjeqe7KkLaEHWgqmTS5T3v5TcBpZ65x1NliRMagWDveTbwO1GtG3k7hpPD6cboTeAGY/Y/GSEyCUQVXHBiOt6n9QwVQUtYlFo2fVse4OICwdhm7lis2SP4jac1NghfGPrL1ShJatvqlnHzghu8sWMqzIzkkjFd+cWbPX02RN0s8ESMw31IUYnhInrZM0eBsh4KOa4KeGonzCcuNkwJYi5E2rc/ea0581G/H/CL4vIAPvp4MtniC5aSErXZbZuIu2FjKGilp0uD8+m8hkUrh6xKwMZOVCeymZEbYJUJ3CFVxwQQc9Dp51syzMm9myTJKIawgwcnMcPJ7b+rhF+DCAAZBfYOZogkJzVbE8YxKXM3wPJC2F58L1cID76v8F9yEm4CUf67c2W7dHn22YjmY4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0061a344-0c95-449d-ff0d-08d73045408c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 08:03:49.2481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7m3AcRtwKh8dNEFB3kiabPpSbklZObmpcg55spaIOigxyBsJFxIF7z25plwOStcmkKNorGbXwuy4Loc/ySvit59+GXf0JeKTprGumLy8lII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the documentation to the compatible regulator-fixed-clock

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 .../bindings/regulator/fixed-regulator.yaml    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.ya=
ml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index a650b457085d..5fd081e80b43 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -19,9 +19,19 @@ description:
 allOf:
   - $ref: "regulator.yaml#"
=20
+select:
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
+    items:
+      - const: regulator-fixed
+      - const: regulator-fixed-clock
=20
   regulator-name: true
=20
@@ -29,6 +39,12 @@ properties:
     description: gpio to use for enable control
     maxItems: 1
=20
+  clocks:
+    description:
+      clock to use for enable control. This binding is only available if
+      the compatible is chosen to regulator-fixed-clock. The clock binding
+      is mandatory if compatible is chosen to regulator-fixed-clock.
+
   startup-delay-us:
     description: startup time in microseconds
     $ref: /schemas/types.yaml#/definitions/uint32
--=20
2.23.0

