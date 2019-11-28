Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDC5C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29DF21771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T5uz1dkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK1Tsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:48:35 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:29085
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfK1Tsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:48:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/h6DyklvKmQhXlW9hXF+wrKW/vDlmSFCWCunveQ/aO7VLSFnN/w6pE7HPi5UNtAccdmZNaR9nH8qxcbVljZV8qoV6H9PsGsnpnVCcRryVXkPFCf+NzWGSM91wQ2rDUuXPKV4rYvlyFCLIKvImhDyMaJT03+8Fn6EHRXEM5elRUCVouC62tYUBM4LFoH+gNdF9FVKnTxk3A3AnIhxa1YGBplUYVtTPiXTwkPS5C1ljuv+gd/3s2GE0mDadusO3thyZSVc2PivdEhU/rQgf51PkmGDtjSvd9/UB02e/Gil0sESDSoRWs68cULZjCRh8Ciu0Nj+CyYuPnh7z0wNurxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tLK1d0AxE6+7RFziKJpzS7UQr5LzZtuhsFBV3nzDBY=;
 b=oSS2dXfGn7WSR5DlVWyavyZ8PUnGl6jMfEi8NMUxaIfrKnsEyXzeo42wL3kFSHg/2PaKLJpKkqzzE4sUCEXLmvTEbBuek0g+1ex2t/sxwB3ha/N1WKsYuRMaODtvl+hbTbA3TUa+vpggHO9OPDkfO5e1Kk4q8djgFLrxUqXLFIeaAZvISUnOJOo58WWqdrsrxS13+53bJinARmMDDRF9wuLmLNKERxcd85tb0LzSQ1yDYh8RMf+hNIIFW0hRbN9qF7vP5rYz3kaVoR2XnEhzn15Ok7W10BlFxy8/ik5FWt09zMb6hA1oNl1ZIHt96DPrlG8JRA0VTrqx85QI5vfT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tLK1d0AxE6+7RFziKJpzS7UQr5LzZtuhsFBV3nzDBY=;
 b=T5uz1dkmKc98AACd5tAG1NyvD8USN+HJFdAhdYEZ6zPoPt0gUmQ4fpQ9aDRpj4M7gMP9A/+jLk7Rv62kZqIV5O38gdSGZxwQkA1muPsz1OycZiSCV5il27/RJ9htNFYf/10fdIJY5r75aYQE56k7fL0rHcghHa7bcQpGvQuo0S0=
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com (20.179.232.85) by
 VE1PR04MB6445.eurprd04.prod.outlook.com (20.179.232.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 28 Nov 2019 19:48:31 +0000
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6]) by VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6%6]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 19:48:31 +0000
From:   Marco Antonio Franchi <marco.franchi@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "atv@google.com" <atv@google.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: Add Google Coral Edge TPU entry
Thread-Topic: [PATCH v4 1/2] dt-bindings: arm: Add Google Coral Edge TPU entry
Thread-Index: AQHVpiTQuzVUgq6CHEmXJaawIN/QUg==
Date:   Thu, 28 Nov 2019 19:48:31 +0000
Message-ID: <20191128194815.26642-1-marco.franchi@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CP2PR80CA0233.lamprd80.prod.outlook.com
 (2603:10d6:102:17::27) To VE1PR04MB6367.eurprd04.prod.outlook.com
 (2603:10a6:803:11a::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marco.franchi@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [177.221.114.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a91a4620-0554-442f-54f2-08d7743bf24d
x-ms-traffictypediagnostic: VE1PR04MB6445:|VE1PR04MB6445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6445DE7A39EFDC2310A15213F6470@VE1PR04MB6445.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(8676002)(81166006)(81156014)(71200400001)(36756003)(86362001)(102836004)(99286004)(386003)(2201001)(6116002)(2501003)(6506007)(478600001)(25786009)(26005)(3846002)(54906003)(2906002)(110136005)(5660300002)(4744005)(186003)(7736002)(14454004)(8936002)(66066001)(6486002)(71190400001)(50226002)(256004)(316002)(66446008)(4326008)(6436002)(6512007)(64756008)(66556008)(1076003)(66946007)(2616005)(66476007)(52116002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6445;H:VE1PR04MB6367.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CEnAQ2M5BG+3EYl8upvrndDQ/PPiwfLqBwf9sevF2OM/4zdDK4JgMq2+7TUCSlsoF+bamwpiDVZefseQQwx9uPFSUGwroW7imdKNc9/1HR7uo/YIa4l+rAv2NJL7d0Tg2JOcl8EM1uAMSFmaiXPHIOL6BYPfKL+cMzBQzOB1bw/9DkNlraaNaD3xd2Mb8fKCaX1PUdGRaZlnj0dkk3sQxY0gcUtkuXw3cBAT8Ogcdgd7af+FwgSafY+f17WXV+SpJyZC76yT47z+9RLctVIFF4RuWIndBHCXojMBt7l1XjeRKWW2aYV3NmnLzEcVadVNateJX2UZqN1SJHJ4Hcmjfh8K/X9ffmIampIm55HsowZBadlnUqPIrQEXcQ4vHs+hDJwYgVJL54YrhYrR9CAc2HP4oLuIZ+J2q730WqySTD6Nh5Rl+NAaEL6GUoujrKPT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91a4620-0554-442f-54f2-08d7743bf24d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 19:48:31.6719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ssUk10W39dGB6JM5VH+oXdtMbBniH7Pc15g3R10pdEbrxvcQYrNhSOckL0MEDWfEXhTMcr+fDtnx0e6uiOjLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Google Coral Edge TPU, named as imx8mq-phanbell, to the
imx8mq supported devices.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v3:
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

