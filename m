Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5D6CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46677217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gK3wBRCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfJ2BVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:21:32 -0400
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:58965
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbfJ2BVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:21:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOCIocUu5vJ4LxQeW47b2Vhqv7kVuq4nT6yghpN/xs5AYnQDBF5AL66OYXGssJNtvhBFnlKodTM3LqRjPYTeDV9KqPshlrxgUuKQJKG1UFgnl8MO3zCBohCp+VLl6Y5GhEtOUuEgGF8QamUXZd4Sj0YdYhS/9kAerDOK3aF20/TjNIBFnJzDDCkak8oVoJWoMVdou/IYgUetjZE8FLiQEJRUb65cMe0E4Ubjap4iQEN4UwaGpFHHLt/aqkHhGPt9TTFYSlXtYM45oPCTVOVx+DlPL1e0rYgAKok+zCYZ//LcJx3JwHctLVowJMATVo5cmBXTmH5YT6cCiMlMvDL6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA7OsXEXDsyenkyR8UggXGffd8FS1EKINyeth15fdyU=;
 b=LwAs0KbW18n+MNEqHK5wMNbCh1DDmaheocDI2/puSnVRfU1Xw/kn8DogYGo1AqH2bMcXLODhaAzJs+BRon7GMKGdBCjhc+HD4Zc1AAgPRcv/YNemfJEm/aQys9LnQ6d6aXK27A6K0nz1XLhM42sblNHxe867gqCRTKJcoTB4sFCUm4B0Q6mMWReLC0WwicFQLG+KGLlyghzSTf55Vdi0n/5+dvam8z6gcCf7cCt+GmdNLCiFE+O5yeXFHqCjnBvVAPV7lbZ3CKLogU5Yy47gFIPjFzdsmvTDSqKbImLs2lcio55O2vrkczKil5BgIwP54ctmsVsfG63Nmq5N7OmA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA7OsXEXDsyenkyR8UggXGffd8FS1EKINyeth15fdyU=;
 b=gK3wBRCC13So8HAKC07UBhyWVcKjqc1GXcIBH9VKNKm5wVjMhHUtc+pS3R9sO9vBzr/S4ZIBG7ERakLBUR1ja2KGDxY6ecnTrPB65TsSKZ45kOn94FXK5Uy9lL5/EOmAXUF4XPVEMJDDfyiJlvYWAw5Y1X9gRKq13crtXjMkiJY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (52.134.126.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Tue, 29 Oct 2019 01:21:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 01:21:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: regulator: fixed: add off-on-delay-us
 property
Thread-Topic: [PATCH 1/2] dt-bindings: regulator: fixed: add off-on-delay-us
 property
Thread-Index: AQHVjfcvACtvwfUHYE2ECPgsSDAQzg==
Date:   Tue, 29 Oct 2019 01:21:27 +0000
Message-ID: <1572311875-22880-2-git-send-email-peng.fan@nxp.com>
References: <1572311875-22880-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572311875-22880-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f64af98-d855-4a4a-bceb-08d75c0e5228
x-ms-traffictypediagnostic: AM0PR04MB4291:|AM0PR04MB4291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB429144A969E51869CE4A3FBF88610@AM0PR04MB4291.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(14454004)(478600001)(66946007)(8936002)(6512007)(6436002)(76176011)(99286004)(7736002)(54906003)(316002)(52116002)(81156014)(8676002)(110136005)(305945005)(66066001)(186003)(81166006)(4326008)(50226002)(36756003)(6486002)(25786009)(2201001)(86362001)(66446008)(66556008)(476003)(64756008)(5660300002)(44832011)(256004)(486006)(2616005)(446003)(3846002)(6116002)(11346002)(2501003)(71200400001)(71190400001)(386003)(66476007)(6506007)(26005)(102836004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4291;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjxAskEnKmjsLYSeXeBK5u9ViEbGEZgzPlc2BIDborvNGRWcJJaS7V6Qi/HeCYCYKUwlPHqHWmruAknVDXOo3TsVQsndimW/2xhVQBWIupKYobTOLSo+AGvpvH1qAfDbqwuQHF6RkP/vYJbFLL8q2k/MbFCPxQf4DyaISv9T3reZhakv1IUhT8zxHnaASGe3nwoLzsJb/d9Y6/3UKri12f0K+kOjusFU5NrIuT9Ljgc0D/TjMc9WRO7znljsnowsq9rCs5MSVkg7SIXUI0bGvpvE9J9Lrvk4jlQpd3p3bZ9XT4zwP7XsKfffSqqyYnY2e7q3X8VK6PrQ2Ar5u3siI/0kMGjuJpWFOSZNYRrEL1XeJBY5k4c0ZZwfNwu+tb6gCT24LliMOyyVUVxExpQ7jMdPX5Bz+swDkdSwD8pfsdvrUU+tmrSctlp09wsFRmOC
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f64af98-d855-4a4a-bceb-08d75c0e5228
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 01:21:27.7731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAHuUE4sDFzuYXI3Ap9KK0uv0JISv+vPWzelXfYxMOFqyhWiil6N7oFJfoqmT+SEQoSXKrcQpzcbWniJbijP9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When disabling a fixed regulator, it may take some time to let the
voltage drop to the expected value, such as zero. If not delay
enough time, the regulator might have been always enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/regulator/fixed-regulator.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.ya=
ml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index a78150c47aa2..954130a8ccbe 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -50,6 +50,10 @@ properties:
     description: startup time in microseconds
     $ref: /schemas/types.yaml#/definitions/uint32
=20
+  off-on-delay-us:
+    description: off delay time in microseconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   enable-active-high:
     description:
       Polarity of GPIO is Active high. If this property is missing,
--=20
2.16.4

