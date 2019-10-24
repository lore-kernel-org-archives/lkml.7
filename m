Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F4C47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186E4205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="fpAp9ltE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393055AbfJXJWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:22:44 -0400
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:20743
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390366AbfJXJWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:22:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgCMlrM6Ecti4Hd9hTdHLzS/83+wmxsfPYThGVe6xHaw0kR0se7lSjccTpL/MDsWA35AHEHykXua1tL1kE1reW07Q1Z3KdiCFl3iFjr+Tvw79YOGvYwQTgjU0flFqbbnuTiRPy5bykl/MAkypdk/qCuyEcsaTes3W8Z+9HJ0gHUWtneY/hqN6d+UC898qjXq8vuzRKFAPs75uf2HKc8VGTzoV4tQxaYc/eewN5sQhAfDpsqa6OKb/5hETUkU40nAQcUfzjhCu2nyfQ49ZoOhPLIjXt97pMHzipuwWpWu4CWHuiNT7UOf3Q7MxcCx9T/YG8GC5KoLAbSp8SmhYMQS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hp2/tszh1uV2uZFTm/3yFBy1aiyTRNcA5omq7eB7/78=;
 b=HIaSukiw0/+D4J+z2mdviPSrdlR0RZkAvPdRkXTQ2+j+nel0I1/6iL45BYoG2ycvvKgw3ppLAXHRE15pv0Eynbeswwvm8q0Qa280qFwozpDnd7YIUSP6RSBWkPe4LYr25cQjfsIThXXPTXqyKJCwItp6NbtO1amNRKazr6yRMLOkjlVzUrkxQp4BK0rMWAZlcXLWI/NtUvr3lKfoY4FkEOyqoV8J/Bfd0i6LDbWzLjb3q1rEf9cZd4+QI1Cjz7YDOcXidB3WD78f9ZL3Q3JlO4ZZDXXvmq5I3GW2xifd7m4nwOQQcSiJWCP6eebXh7bZuDmp6KJPa+GI1tNrG8hFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hp2/tszh1uV2uZFTm/3yFBy1aiyTRNcA5omq7eB7/78=;
 b=fpAp9ltEqCfX52I7g2nf6FuwVbYzgkfy2QOnaP8qIAB/1Cz4hZgdcarJ1fKOmETua+aimYkzAPetHdPEWtXyntQ+Slr5vxUhAA3ZzILSiMUWYFoCn/CkGJ34/yJTmJO1nycbVqyB0AzhQQOOde/Sw4dQno/8Q9mHzJi4aoyItpM=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB1797.eurprd09.prod.outlook.com (10.171.76.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 09:22:38 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::b1b2:ecb1:9c98:6b74]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::b1b2:ecb1:9c98:6b74%6]) with mapi id 15.20.2367.025; Thu, 24 Oct 2019
 09:22:38 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "oliver.graute@gmail.com" <oliver.graute@gmail.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        =?iso-8859-1?Q?S=E9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] dt-bindings: arm: fsl: Document Variscite i.MX6q
 devicetree
Thread-Topic: [PATCH v1] dt-bindings: arm: fsl: Document Variscite i.MX6q
 devicetree
Thread-Index: AQHVikyT2KF91MXB10mxyuBdtabWTw==
Date:   Thu, 24 Oct 2019 09:22:37 +0000
Message-ID: <20191024092019.4020-1-oliver.graute@kococonnector.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::16) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-patchwork-bot: notify
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e15ed6d-1f7c-4ba2-4f0b-08d75863b601
x-ms-traffictypediagnostic: DB6PR0902MB1797:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0902MB17970E6E870CE4DE6A2EB5E0EB6A0@DB6PR0902MB1797.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39830400003)(136003)(199004)(189003)(26005)(2351001)(508600001)(36756003)(2906002)(6486002)(99286004)(102836004)(8676002)(14454004)(1730700003)(316002)(50226002)(52116002)(6512007)(25786009)(44832011)(6436002)(81166006)(5640700003)(66556008)(64756008)(66446008)(66476007)(386003)(6506007)(8936002)(66946007)(66066001)(4326008)(256004)(4744005)(476003)(5660300002)(1076003)(305945005)(2616005)(7416002)(71190400001)(7736002)(486006)(54906003)(6916009)(86362001)(71200400001)(6116002)(186003)(2501003)(3846002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB1797;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9K0UAVaEfYD4N7AriQr5s4cKZ5MpEaepEB4/2KRt9gr4MpYoFcu7+CayrOnmmmz6y0UWSnm2Dccv7fioRbJlKWGJyN0ljc8IwoQbXc1RjooCza0ElB8ZvobDB5CCmq7Lq+yK6WM1eFnE3p6tn6ndMMmm4BH+322PqwzsbjR6267YEyj8mT3VfIZXnWnJ/z/7zFOFLY6vEoKQavZ4G0TD83m2UNgGyqjDB+ZPIuynLCNqrOU+QzyknBuSQv68bjW4a1fRHDi5rYjlJBCqbgsrB0KCMbrujgHYyrszQ/M6qDoRRpq0+5JofFbHKvIm27zQhhdpqGbROzusf0HfjWzl9cvOraTsIkGmHk7YjWL7lFAP2BfFrKkS6oWt7UH5E/O9iJWBameKvfrsPR8P4Ob6P9fXT7EgVwC3V/WBR6DXc/UOLWP/Pa/n6rvsc1gjQPl
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e15ed6d-1f7c-4ba2-4f0b-08d75863b601
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 09:22:37.7558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21/8QaNnwz/woFKN3tPNPQTMaL081MuyCj/c88kkhb9FE2RSgefr+955etu91GIM53Vby0YyRfhR6r539t2WS/B5TtiYKtWwkTQaYTEF4Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB1797
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Variscite i.MX6qdl board devicetree binding
already supported:

- variscite,dt6customboard

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation=
/devicetree/bindings/arm/fsl.yaml
index 41db01d77c23..f0ddebfcf1a1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -121,6 +121,7 @@ properties:
               - fsl,imx6q-sabresd
               - technologic,imx6q-ts4900
               - technologic,imx6q-ts7970
+              - variscite,dt6customboard
           - const: fsl,imx6q
=20
       - description: i.MX6QP based Boards
--=20
2.17.1

