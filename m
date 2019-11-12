Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946AFC17448
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6595F21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="AAmV6Ddc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfKLHT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:19:58 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:5508 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:19:57 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: gse+QrJjRFeY45ZEmXAeOEJwM8PKFN7qLBJyz2SBAnYdYaRKeGKWMAkWRosGp787i5OOXCOnsq
 G2gZTAJg77fcMMaEAbc4AvK9LLYErTDFOfu4i3idfFpCbt5R0snCBnW736c8l1mNAeE4509pP7
 vdfReBvPxWNH3R9lPNtwNMsXV5sxpEZeTEm7/zzp3aYVXtJgKCHSgVG8Q/I2TE/mGpN/meZnSu
 v073c4jZ5w9frqqshZyGdn0DNty5lPgQFXN0BPkp2NA0cAwenTPccogQ4ObzwKJ0ERZBVsp+N2
 oos=
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="54997976"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Nov 2019 00:19:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Nov 2019 00:19:55 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Nov 2019 00:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hnp4fkOhF8nj6appXM7jixHWw43F93lDYJeI3/S5E3Cwz1PkWbPgA+J17OpLTS9MxXkPxjzDEhdo1LAoX9TD8nyGMg7NjzQD3p1Aa8U74quW7j1+Lh++NDXQJHeAV+LGd0k4n1um1I3v8oUiNg8WEnRYM5YavebNz76yyg+bokDEFbnilkWSNQym47AH2LGWEdvKS6+5+Xdqsnx6U3CQ46VQ0rC/fEg8HQ+Xiijj2WjS0z6AsAGzUsoy1XuX2Ul8hds0k/u+a5lJ8zhlq24BL6TLNw6s2NtHhcQHufBLY8/LTLg5DDVBLXEuMkoCmY5Vcb89OS7Gyjb9nl39LdMD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4zvpzU1dHBaau5xgFgQfv3ykGoS2xg815guwz/k3pM=;
 b=Oo4gQWbaNITLyxY+e/z0jw1x01lQU1yTHLoCrhcWDo2pNrQiJ0FrCrxK86jWXA25wfirXIj3AtfupA/YmXFi7aajyzhYzGcENAN+2/i5eHN9GywIbHNxkgHnjONeJWeW/8MSIke2esMGdyAp9FioGgXINwgUf2x8K78xsusRXFkbr3Tp7uLbrF7et9u6ZLsUI6yET8UCAnujJz5vDeHmpxA0yAsZ5w9zMJszUwP1hY3tRPbeC6oYAmleLR6RRC6XQk/D6S1+pw9fAXq3b72HmkDLnoS0yaNyetqwJpqN7N2LchZlQ7pAphxkdP33xGpBJ9yE520B5HME+jBv9tQmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4zvpzU1dHBaau5xgFgQfv3ykGoS2xg815guwz/k3pM=;
 b=AAmV6DdcsKiR1qjqwocAWciHpaFnp57yFJ82ThRtuyTArA4N03b1FKHklxqO/1GJh2O1Sk9J/ZRHcoXK6AW4D6oK7MBZ/wvXzsMfBXvq2gOPuWGOrGeRgUcMJj5ol5w0h4HTE9KtQ/irQt+BszxboPzKwdlBuD5+w0EEAajhv+s=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1323.namprd11.prod.outlook.com (10.168.108.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 07:19:54 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::d594:bcd0:98a9:d2c8]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::d594:bcd0:98a9:d2c8%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 07:19:54 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 3/4] dt-bindings: ARM: at91: Document SAMA5D27 WLSOM1 and
 Evaluation Kit
Thread-Topic: [PATCH 3/4] dt-bindings: ARM: at91: Document SAMA5D27 WLSOM1 and
 Evaluation Kit
Thread-Index: AQHVmSmUmdWh9wC/W0i+jBXSiLSCpw==
Date:   Tue, 12 Nov 2019 07:19:54 +0000
Message-ID: <1573543139-8533-3-git-send-email-eugen.hristev@microchip.com>
References: <1573543139-8533-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1573543139-8533-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0013.eurprd04.prod.outlook.com
 (2603:10a6:208:15::26) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42cf0db8-8509-4b29-f58c-08d76740b6b9
x-ms-traffictypediagnostic: DM5PR11MB1323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB13233E34B584F803760AC229E8770@DM5PR11MB1323.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:366;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(81156014)(8676002)(8936002)(81166006)(50226002)(6116002)(3846002)(7736002)(2906002)(54906003)(36756003)(6636002)(478600001)(2501003)(110136005)(316002)(6436002)(71200400001)(71190400001)(86362001)(14454004)(25786009)(305945005)(486006)(2616005)(66946007)(5660300002)(76176011)(52116002)(4326008)(26005)(476003)(386003)(6486002)(66066001)(102836004)(6506007)(66556008)(446003)(256004)(6512007)(64756008)(107886003)(99286004)(66476007)(11346002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1323;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QdBm/QcNZjeYKRIh6JScMtY6HkOmwZA+r3p9N3BgByIofpem5mRVQIwK8TMv4FvBpRKIqZqxZy+pvFgFBXyrnJ0aLHkln44dDMZlz3bIdkK0XBDQjJnCZDkKuUPrymwRJn5lTYBd63subNbsxPShbJRUeJJF99+bQGrSHVRQb9DtqfbO/3+RnpPoGwR72LXf7ca6JubGwDbh+pdAb+fiOyNJDIVAqEKbFVCrQzZWFQzsw980iUbXalsgBvszcdYtQKtYQPE8rr41YVwfLKqbTHnhhEWCceGjBPToitob1g8mwzeziNt/Z5vGJP8H8exqDpS5oTMT4rRyqd3gP7pPx6+zGLFLSEL6Y/IZL8ZPHTh1XXM17FG5ijQAeA8q06bpVyJtisz7ZeLoXk7ifd8x4aXmxiyagRMFrlOLFU6Rwmx5KVP0JXamylHpsISK+fwb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cf0db8-8509-4b29-f58c-08d76740b6b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 07:19:54.2070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8uiWCqb5LPBgDtygiJ5pkotxBFeZCQqfefSPh2/Idg7PtE1H8sL5iMrVCqJkDv7fntUBEFMr0U+VKLqH1n46GUTQjihkVi2vS/rKaxSnEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Document device tree binding of SAMA5D27 WLSOM1 - Wireless module;
and SAMA5D27 WLSOM1 EK - Wireless module evaluation kit, from Microchip.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Docume=
ntation/devicetree/bindings/arm/atmel-at91.yaml
index 6dd8be4..7b512be 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -52,6 +52,21 @@ properties:
           - const: atmel,sama5d2
           - const: atmel,sama5
=20
+      - description: Microchip SAMA5D27 WLSOM1
+        items:
+          - const: microchip,sama5d27-wlsom1
+          - const: atmel,sama5d27
+          - const: atmel,sama5d2
+          - const: atmel,sama5
+
+      - description: Microchip SAMA5D27 WLSOM1 Evaluation Kit
+        items:
+          - const: microchip,sama5d27-wlsom1-ek
+          - const: microchip,sama5d27-wlsom1
+          - const: atmel,sama5d27
+          - const: atmel,sama5d2
+          - const: atmel,sama5
+
       - items:
           - const: atmel,sama5d27
           - const: atmel,sama5d2
--=20
2.7.4

