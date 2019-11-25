Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44FBC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA612082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WZmb8G4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfKYNLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:11:52 -0500
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:45287
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfKYNLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:11:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB96OF4VZFd7m57uySHRl02D+v8iuT0vYsMuhkeiq5QB9j+6IAw9tqPQHD4iddoRhzr/3lwwvitKfgBtgKnWZz8dN2mdiubDSUAGQhTkoaP3Qi6fTJ8jZhcDNVRwsQTyMqv0NPR0Q8WGt1gkGicLvuhcXCh4VpLdYObm1IVgz6rHxTxsrT0or58ZVyfxS1LLq5tgkYea6M9KWVuSdoC5eiOyVskftKs4gMOeooLowPQoYbhTW6kF34BDY8qFPB4JLOHkz2ypST/aCmO46orIrtOVlcKTikXHG59sRxyrnc2GfBHR5IXu+GjlbS2t4hrxCr3nh49UUeb8BKg1CrfciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLRoQv0NfDSWGw8/C+pKipbMXASbImH4QNfgDfolek0=;
 b=fXfL5UNhOJtTq0O0Agp4petM7PyP9DKuRPBEemlT45sscjJtVlA/X0LsL66JjnFzd4YFE7+xIPtuhiJqFZA0sicZce82nJ8CQQYknUNIMbK9x9ueJgaduvsyZ+AzUxpN2l/YLdIWGMuofNguwo+ODggEpob3FD9vnV7NSvqORc6697HfoC0Pw5J/gEhCdjXtRmRA5C7S54BLHbItLfuezkDOD01ZhXkqNzRPHdBLOEsmZ5PuBVVm8RkyhejmgnajUdA/1T8bXylv9ENNOeJa+oWgjM6ffIK7RpGg+ZjG6JUJjsS7FmM5+AHtLROEOWmbNRUJ8LKJRqc/doCIirzz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLRoQv0NfDSWGw8/C+pKipbMXASbImH4QNfgDfolek0=;
 b=WZmb8G4MHjKppHae9yrgYRajsUPr7mv5XROgQZJua/wA9iFGDdK18sU+dtF/9vtIPgGvLvh0PXGeGXUkkbLKJlaXsz61Un7l+8VXxkdVDlmlhqtjZW9JviDHoE82pPxhCZwq6HhBZu6B1sF3srsWnbT7EWaRLQ2J+0DHjs2L1/Y=
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com (20.179.232.85) by
 VE1PR04MB6752.eurprd04.prod.outlook.com (20.179.234.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Mon, 25 Nov 2019 13:11:48 +0000
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6]) by VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::d1b2:be2c:f082:7ad6%6]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 13:11:48 +0000
From:   Marco Antonio Franchi <marco.franchi@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "atv@google.com" <atv@google.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: Add Google Coral Edge TPU entry
Thread-Topic: [PATCH v3 1/2] dt-bindings: arm: Add Google Coral Edge TPU entry
Thread-Index: AQHVo5HjVLGvDJOGX0yZS2V/Gze7iA==
Date:   Mon, 25 Nov 2019 13:11:46 +0000
Message-ID: <20191125131129.966-1-marco.franchi@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CP2PR80CA0123.lamprd80.prod.outlook.com
 (2603:10d6:102:1b::13) To VE1PR04MB6367.eurprd04.prod.outlook.com
 (2603:10a6:803:11a::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marco.franchi@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [177.27.230.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e83de63-4862-4733-362f-08d771a90627
x-ms-traffictypediagnostic: VE1PR04MB6752:|VE1PR04MB6752:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB67528828CB051B2762327D46F64A0@VE1PR04MB6752.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(6436002)(71200400001)(6486002)(2906002)(8676002)(8936002)(81156014)(7736002)(305945005)(6512007)(386003)(81166006)(6506007)(186003)(2201001)(52116002)(256004)(36756003)(66066001)(6116002)(3846002)(86362001)(66476007)(66556008)(102836004)(4744005)(66446008)(64756008)(26005)(478600001)(2501003)(14454004)(110136005)(54906003)(99286004)(25786009)(4326008)(316002)(50226002)(2616005)(1076003)(66946007)(71190400001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6752;H:VE1PR04MB6367.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQ0xGfy3X9//XI0s1Ax0OpNcRAH/VZfy8mku4kC6nsRWZUTIoYyD1Gxm3kW+7jieCs/a100MPxBcZM6EJ7uZ0wOUHFnyGfHsgJxNmsxG1sQcrp4CWqXP0PvHmgzhut/IGv9G405+GnnsDujViwJuSY71MUWvkfihXA0PWZrmeWt4i3vCpjIaJf7XrXfrtL2mlup7d+GCQYvjqJdc2DDMhV3znfgfuDLt7oOuhtoGLTIxiBYGH1mtpcyWQ3NzdWKknCs+FGxQMfwLMiK3V/fJXFJLJyCTDpAJwDoX0cg+8AawsgA92GeOTvlo/RddLkRLs02VGtwwnD+kV0RK0n7FZbJ+NDxGE60hnYMGvx1F52fjr4vKMReHhwBFFi82A6lO65SVmgnbROfJkWUKN0RnD6DFLUQfnz7htvYAyGL758Y4krzeLFfJtPmkWlYhCVt7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e83de63-4862-4733-362f-08d771a90627
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 13:11:48.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfsSDQfKtry8MuDp/OL5pTD2Z18dEUgf6E7ZxDdr266NGClp654kB9uPJITuqvJiejSc7x8R7eMCv4k/KJEq4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Google Coral Edge TPU, named as imx8mq-phanbell, to the
imx8mq supported devices.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v2:
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

