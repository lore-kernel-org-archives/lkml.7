Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02334C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C670F20692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r5PA1cBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKUQZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:25:42 -0500
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:17734
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfKUQZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:25:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnWYVfmXhJWcRRwX+22RojK1w56NTfpSOSeBomC3wfbv4u9mtOBEMZY7UBaGD1DHTG0BiMzNR6hyDJHA+HWKOKVbqDbD2LdraqtRQw2IWq+IArah57VoG4QJ5o/QjFVSL+VxdcUPCApIA2X6u6MMXgxlSjRCxRbOai1+FszjlnzGRoA8E4qi0PNOQJbdt065dFumcKCdDt51tV/hgZK7dCO28Uiq5WTK5A90wLW5oe0PJ2YBAp9QnXiCTAKgGlBuAwrgP+lHNV3cUHAj/hZtnXsdaJuJcBH4nZXx05Z2nQtG1O2BwnaAkqxZiQ5bxrN3Sb7lG8MYN3Wf1DEtDqPhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0ssCj4l0iaspXdxSuxoEbIfZ+EKQNJI5MrYHs9fwpg=;
 b=AdggKIo4r5u3qeGb0sN4p5bdR7sUA5gia2vLzNEznT68Kk1a7TUSYr7CVu0TPYi6+CQ2EkXstBOuvjFlk8NJBbf371hs2Qp4nRHuchAmVDQLffdf97QQH9uHN3MDSTvuGWDHAEWfYLspeSvObyWDHlXdrupY01AN5u2YJh0L9SS7uE9zj+1EirzbV/6Q5vECT+AL4lZwnAeHwNl90zEuRI9zV5IjG/yaAqytypMpePg9imQxpXqGkKK2+en/m8r1/KHPlEq6BWMkf0pKC0mRGPWyjwY8zF60QAhu4LpZNh9RGpobHDteh0g10zOqqxpHgxLvoDfOC4vm2ht7SFQjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0ssCj4l0iaspXdxSuxoEbIfZ+EKQNJI5MrYHs9fwpg=;
 b=r5PA1cBULSCL9u59EPcsxOqMBpKHq4mJ9p/PClkzXwE6AuLWTn0fKjTL15YUVp6mHkxQ172l+Dxn94I/hzY6T8TFI+bkDyqL7yRMUgWkjdK2rquOerF6nrgjpCL97FttTgwZCrKCSSbIZ5JFA2MuOt8O4g3xpRYKMm0dcN99IJo=
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com (20.179.232.85) by
 VE1PR04MB6750.eurprd04.prod.outlook.com (20.179.234.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 16:25:37 +0000
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6]) by VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6%6]) with mapi id 15.20.2451.032; Thu, 21 Nov 2019
 16:25:37 +0000
From:   Marco Antonio Franchi <marco.franchi@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "atv@google.com" <atv@google.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: Add Google Coral Edge TPU entry
Thread-Topic: [PATCH v2 1/2] dt-bindings: arm: Add Google Coral Edge TPU entry
Thread-Index: AQHVoIhOfCE1q3ejT0iseX+AElaXWA==
Date:   Thu, 21 Nov 2019 16:25:37 +0000
Message-ID: <20191121162520.10120-1-marco.franchi@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::30) To VE1PR04MB6367.eurprd04.prod.outlook.com
 (2603:10a6:803:11a::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marco.franchi@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [177.221.114.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c1cb316-42fa-42e5-6a74-08d76e9f7123
x-ms-traffictypediagnostic: VE1PR04MB6750:|VE1PR04MB6750:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6750FA0F330EAEA5FBA99865F64E0@VE1PR04MB6750.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(199004)(189003)(26005)(3846002)(99286004)(316002)(86362001)(2201001)(2616005)(66066001)(110136005)(186003)(54906003)(66476007)(5660300002)(64756008)(66446008)(66556008)(66946007)(4744005)(1076003)(4326008)(7736002)(305945005)(8936002)(6436002)(6486002)(6512007)(102836004)(6116002)(8676002)(81156014)(81166006)(50226002)(52116002)(2906002)(386003)(6506007)(14454004)(508600001)(25786009)(256004)(71190400001)(71200400001)(36756003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6750;H:VE1PR04MB6367.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQK7CyoHvLLsg5Z4zucHdVcSuGm+Fb6peIr4d0rUpkR6WztzUHTo4z4u7E3PxTEkvyKEhRivr1YjJJzdEiOpepYqCLgp0Y1z4DI5i5D8GD9z7QdGif6+QlVVCG+fVgggmDnjh7eHB0PLswuR+Ix7S19vupDrpbHzt7Wh1JMTZtvmDk12TcwbEBE4FSffoiUP1gUlY49p2YwAHJrtSxlXbWKNS/xMGalAcdxS+UzFFodwp2ezygipwY+t7jyKcEVBZun2kKtmAiXiiQTSielY0It+ODqabWFO8JijfnGlXRky1ltXMzzMqFhqWJdXCksn0FrXezzJAgm7CEVVIL4LA5zw7tNEedjr15jwhHg6haKbijfsGuhkrtL/Nd5Z13IqyqpxSqms53/f1pKR6i0XwkBRjXBCmMtMn6+Nj6qogyC78dzLRRWeSPrS38bHI0EX
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1cb316-42fa-42e5-6a74-08d76e9f7123
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 16:25:37.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUEdmpVkc7l6MWVgtrp6Ea4GmEcFIFDLOtuOvgu/mtmMEun9IC7Xl9F9fcxP98G8DCt0ZW2grI4PiynwWGfwQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Google Coral Edge TPU, named as imx8mq-phanbell, to the
imx8mq supported devices.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v1:
- none

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation=
/devicetree/bindings/arm/fsl.yaml
index f79683a628f0..5d24bd3ecc81 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -284,6 +284,7 @@ properties:
           - enum:
               - boundary,imx8mq-nitrogen8m # i.MX8MQ NITROGEN Board
               - fsl,imx8mq-evk            # i.MX8MQ EVK Board
+              - google,imx8mq-phanbell    # Google Coral Edge TPU
               - purism,librem5-devkit     # Purism Librem5 devkit
               - solidrun,hummingboard-pulse # SolidRun Hummingboard Pulse
               - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
--=20
2.17.1

