Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E723C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B61720733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p6+HhIGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfLQNgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:36:19 -0500
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:61190
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbfLQNgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:36:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9Gon2hrtrlptndyMyeNWJ059M1HJLusBJDnZN1aftZ2N7J03QJ7XNhzv1urVES5PKE7UEK28lz8ObCMIamgFy2ptOKvL1PeMqMS4A7T33AerS9vDKoFFbPUWIfTuAA+IRTO7ldUWSEKcurG9tnK5bX8jAk0i3jVPwEE7+bktEW7IALycnzMr86CuY66b/y61B7tBJLFqIgOUo36Hzn4RUvHCR+5SEht4ujAtfoS7A4HhFcvo8uuy9RN7FuGvDrQplKdMbaY3X57uZOLHAziGNJTDWwydDSEpySr8dHLnNKhTR6rNKJjevFP6qT3O5Z3wtGVX6DBzCG4j0c4QYMBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Adlb4ujzA5vPu0uD/xNCBLCI9mBY08e8rmyGlw7IEb4=;
 b=CUp8p75V51bZwKpLbwnOJ6KAmfEaHdrbRYYhgzrs+Mm40Pc7MFzdt7hmJvmhIifRvw/lB1NeFW8fvwdgHf0lWFCI8Dg/iSmhbMimQqwdrOoMuiKnIydwwEDiKmsk7CgnZEqLA0tECOEaUlnImr9QIR0sRbANpYuU0dki/G2QkBFXwFBX+EM9kfZPt3kgYPkJaV65NgIZDcn2ALg9tFyFskel6JY8J4uwBWy3VwDfiC8Y4LlX18/H973FQNZ+nMGo+hDN/pNPgBmzL5mGi09zDtBg0d5KQ5ErWrmDwqSK7hqnEIqSBhH38GrUakoaUURZlOnz/ilVT+D48IVJ8rYEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Adlb4ujzA5vPu0uD/xNCBLCI9mBY08e8rmyGlw7IEb4=;
 b=p6+HhIGvJeLUeDCNSLq4kusX6V5wBkIXo4Fv7VfZaRcZUa/oQLSjVnPzjfmy+EyqEOkeXAwL03zRz82zC/YTda6Z4/dkql3joTRantMFlPVqKI3DWPPcHNgj/ZuqI57F8HRq2GAXX7XI1jpBTBZMWpNK8Ly/iBGjQjqhVeBDQOk=
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com (20.179.232.85) by
 VE1PR04MB6733.eurprd04.prod.outlook.com (20.179.233.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 13:36:14 +0000
Received: from VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::84f0:21ba:2d32:4283]) by VE1PR04MB6367.eurprd04.prod.outlook.com
 ([fe80::84f0:21ba:2d32:4283%4]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 13:36:14 +0000
From:   Marco Antonio Franchi <marco.franchi@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "atv@google.com" <atv@google.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>
Subject: [PATCH v5 1/2] dt-bindings: arm: Add Google Coral Edge TPU entry
Thread-Topic: [PATCH v5 1/2] dt-bindings: arm: Add Google Coral Edge TPU entry
Thread-Index: AQHVtN7zl4Nd3NuOGkSHsjlyxcOh9g==
Date:   Tue, 17 Dec 2019 13:36:14 +0000
Message-ID: <20191217133607.8892-1-marco.franchi@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0058.namprd12.prod.outlook.com
 (2603:10b6:802:20::29) To VE1PR04MB6367.eurprd04.prod.outlook.com
 (2603:10a6:803:11a::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marco.franchi@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [177.221.114.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe58f70f-2735-4bff-41be-08d782f6160c
x-ms-traffictypediagnostic: VE1PR04MB6733:|VE1PR04MB6733:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB673366B17D8DBC497EE1F85FF6500@VE1PR04MB6733.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(6512007)(52116002)(6486002)(316002)(6506007)(36756003)(478600001)(26005)(64756008)(66946007)(8936002)(8676002)(66446008)(81166006)(81156014)(66476007)(66556008)(71200400001)(54906003)(86362001)(2616005)(2906002)(1076003)(110136005)(4744005)(186003)(4326008)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6733;H:VE1PR04MB6367.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rCXyiiwe/E6G+ZDzI8zMXWcqwKv9gEySgPlPaZ5dQOEbIIJgY3ZpFc/zcv0ljSz9rcDqG9Z2xFuYmUqHYLWsDVkZwadktGeOttQUvSZFL3E68pHtI9vpALEFvewwoouD/TctfIK14GMQ55ElHapCL2HH+CTNK3SXZA+S+kiajHf6WlogIGdxVkETAnWTMK7Tnm+VnYTkEqnPWwmE8T57txVAu13WGIHV0Sfw2+hlFWjf5zGWnBR8Ri2F7Inuj6i8+UjQeLTz4nGygQS1v5QGnNYh+XjDClEUi5yCMG/KHjc6/DtPAdbDmkCNbFO3kTwdqIM7JQ3M9M+Rd/Qv1jFNO5o4u+R54RhhB45jMZdkTgJBk4XYQCdhGHoCryFACJtjvl1/QA16s7LhFUwXuXK1xmUXE37qWwY5OAckWkTJ6LI4JcsNag0uawxYoSJIC05K
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe58f70f-2735-4bff-41be-08d782f6160c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 13:36:14.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBmWh8FqHvFlPDL5fZN25bsDtVXEXv5ejeb0unW2VyykcYglxfoGgK2dTryckLfVHFbcF2CF2uhZ27wueGQhSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Google Coral Edge TPU, named as imx8mq-phanbell, to the
imx8mq supported devices.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v4:
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

