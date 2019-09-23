Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF3DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E6420835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Xosq1/0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393524AbfIWIS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:18:57 -0400
Received: from mail-eopbgr40095.outbound.protection.outlook.com ([40.107.4.95]:11266
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388933AbfIWIS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i82nAsjazQ0wi8/b2mGaYFfUMdjJZkXg0o30N9ICCiQOqVb99e2RUUCvokJbXPESScYgtugQAYfXnLpKrNlpukzUEDcQb/uTdRXdD8H0BQjueH2ab55JP+a9Ee4kAdXkVSstljV9rWIz04zyG9Omnh/ew/dTNo1RJWnIcBAvClmIDuf0bUD9l5bALge/TfBGPxQQxg7892GTphNDavJwvbaqOzdD4OtUCuJBkrKB76v+h6JwrKKUNk4UpIwG5rrGRuY/EfNCJ8pacQd9FVuSo1vdoj8O43388j1Z+IaxUGz7mDF5/b6RNwgMgOi6vAnD/BukwrYIcUULlYgeRclvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouc8B1fyULoPu0k5IaAFty3VQHQRF8moAhSQy9SBOEQ=;
 b=CWKclOXYf0yKCMPVr2k22cyb8NekVHA50h94TacemrijXfAnVk7Al6KrUpzr3eT05HPOmkzN2BtK2NxytSzEBbSErYQkdssXxZjSaJamaAH/7f1txKSi4t2rLH7ZvILQHPoeqtkAqIshyESYJIiz7sRqbs1bskVxjOAWZGfJqeXdrkZ3DxL2JFnDxzzQBuuVQKnTF9jmI2OIGGYHT/ENShtbFtWRENGCphVyTfI8d5RJk2kC6hPpUoyhE2unHGe+7rLMXXt3W42y2ql3SLKY9fi18edhCjvvMApZwORp9FOTywqLMrUNpWIAowdLfGbBHkwPXojR2hG70rYAauQMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouc8B1fyULoPu0k5IaAFty3VQHQRF8moAhSQy9SBOEQ=;
 b=Xosq1/0uuinoWxw5bGqW1l4RQw5qk4sZqNRzo2ZkcUUJZ9HzbWDMzPivkas6ttNufIPyb3ucK9soannqdJp2rD5H+ztZX+PL9zGTgTwcHHJqfUwZ6Vx74JxYnV38iao/maAaH83fnDyid/yRlECcyOIBRvH9XBfLlH25I+iyD8o=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB4064.eurprd05.prod.outlook.com (52.134.18.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Mon, 23 Sep 2019 08:18:50 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::1179:c881:a516:644d]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::1179:c881:a516:644d%3]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 08:18:50 +0000
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
Subject: [PATCH] dt-bindings: fixed-regulator: fix compatible enum
Thread-Topic: [PATCH] dt-bindings: fixed-regulator: fix compatible enum
Thread-Index: AQHVceeHVIIm60zvTk22ZU5xn+t7mg==
Date:   Mon, 23 Sep 2019 08:18:49 +0000
Message-ID: <20190923081840.23391-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2P264CA0036.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::24) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a431d751-c87e-4b88-fcfa-08d73ffea9b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB4064;
x-ms-traffictypediagnostic: VI1PR0502MB4064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB40641CBA4E1D9467080DB529F4850@VI1PR0502MB4064.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39840400004)(376002)(136003)(346002)(189003)(199004)(71190400001)(186003)(81156014)(81166006)(54906003)(4326008)(44832011)(66556008)(64756008)(66446008)(66946007)(8676002)(476003)(2616005)(99286004)(107886003)(14454004)(66066001)(26005)(66476007)(316002)(486006)(478600001)(25786009)(8936002)(110136005)(2501003)(305945005)(36756003)(52116002)(50226002)(6512007)(6116002)(5660300002)(7736002)(86362001)(6436002)(1076003)(256004)(386003)(3846002)(102836004)(6486002)(4744005)(6506007)(71200400001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB4064;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bdj9mrTebMJrdW/e+9n+9UcvFgoA+xB2VXcWBO4W1Dn843lnJ59Ae2znSaHQImai+sfwzncE8OZIu74A6zaLMlXxWBknIdILaFkLWGhiNcTLcKLjdGyZQZsPZgfvcPe01H49KGavI/izkGOcxelfCCvNCtK1/ZiL1cXn9cYvLL1iwD1sRANkRT187WPhYwZZ6dYHBgbEvOyaYXhB0+HlZnxdoORY5KqaNIqE66HwwXweib3P9/0B2JpSgdsvD4SKKnVZGKRdwNE3EkvKZPkDNtStsUpOqvg0UsFRF0aACozV4+27sTZdVlhg5pdNQU6ptNG5IVZNwPdKY2aSEf+wGjZAK2w2sfDew5rpY07q1gLOb7c6x/j5Y1zTapIzWwIunb0aQz0aVCLBltNEXMfVf9U52swk3q5AWAMQsJ93tKU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a431d751-c87e-4b88-fcfa-08d73ffea9b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 08:18:50.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cHA4jz8caEPD33i+sTcif7sz6TBPCLCuhvzTmOWl5TedrrId57yuPS0kGljx/WHMrsfunw+K6s3wLvOlF6uKszG/Hv5MinG+yATu6TRX2+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'const:' in the compatible enum. This was breaking
make dt_binding_check since it has more than one compatible string.

Fixes: 9c86d003d620 ("dt-bindings: regulator: add regulator-fixed-clock bin=
ding")
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 .../devicetree/bindings/regulator/fixed-regulator.yaml        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.ya=
ml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index a78150c47aa2..f32416968197 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -30,8 +30,8 @@ if:
 properties:
   compatible:
     enum:
-      - const: regulator-fixed
-      - const: regulator-fixed-clock
+      - regulator-fixed
+      - regulator-fixed-clock
=20
   regulator-name: true
=20
--=20
2.23.0

