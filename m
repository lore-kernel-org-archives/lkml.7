Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20418C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77F3217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="caswlHtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbfKEKXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:23:40 -0500
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:39447
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388138AbfKEKXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:23:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjHMoB6uoRtCmYsZeF3TQJPDlDHpwYTPuNaMyRTB1kdd52DrD3d2wouf3bfnptIOhOhKSurcBwRvP1ND+Es/SfxH3myOZ+hqmE3q9y54hOrYG86OQnwYjlbYvihfvlciYry1rHSbQeviaDkJ7mXm6fFRKCpnMnk9F+kXLX5POoAuq9e4NkvN8QsmHjnf+d1v+XDK2YUQpP7uBp2/fV/Ce7nxdNxSshwB+hpHloiflz1e1bsQcMmeVb/2HxXfUDKtlyuB1U/kzNpZU+e8FXhJDnqnV6XkRIfUpgkI1RPliI613HTfKGubTm3AHadcOoTtzBmlYoIOqjdIXf4uTvXAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZKIcln25d+r+PAFMfHEYo9cEeXc2/sDpbZL1wT90Nk=;
 b=B81aLgC2HtVG8+P599f57TkbDAP6dkUDwpnUG6qi59TevGUqBfixSiXMziPmrQE4eTI/3c7XxGtIphE4XLneF4SbRj3nvrph+iJRg0ZP3Wtjocpht/9/JKml5sqXee5+TBsh/1024OVfyscwDvZfZ3QPYjFyTwe6shKPxBwo5QXtl3Uk8insB8OXPsuSM6rxjpu1TktRGyKDg9TWVS7QMZTnc9V+h6FQOKyNDyyG8MGHVfm/0n627Dvl9bQNpUHv44P8N3IDlEfDW4N/24fYbZhbgm8bwnTJL6eMv6FRXUx/N+hXkq6hB1xYHvAMqJEEVTzUmHtCBouEAoH5LX5fQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZKIcln25d+r+PAFMfHEYo9cEeXc2/sDpbZL1wT90Nk=;
 b=caswlHtgWPE8aaLVGRq969zSZB+ZIh6VIzHY8XEg+phjvV8w/cn3NjLtEUFJoY0l8y4QiunLuUESgn8cnp2JaRGtQEK4zPyPBWI68AVDLLnOH1UWcPUSSmR2HBHPy723dS+UAUE2pZL5NCYMO4UFR2wFBsnCse4yRHKeWt4ZEvU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0SPR01MB0033.eurprd04.prod.outlook.com (52.135.152.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 5 Nov 2019 10:23:36 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 10:23:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add imx8m compatible string
Thread-Topic: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add imx8m compatible
 string
Thread-Index: AQHVk8MVLLROxqVDtE+NBToMG73BkQ==
Date:   Tue, 5 Nov 2019 10:23:36 +0000
Message-ID: <1572949321-8193-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:203:2f::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 351b4f56-4a47-46be-62d1-08d761da3783
x-ms-traffictypediagnostic: AM0SPR01MB0033:|AM0SPR01MB0033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0SPR01MB00333ED29C279F56C312482A887E0@AM0SPR01MB0033.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(2501003)(6436002)(44832011)(66556008)(486006)(6636002)(4744005)(4326008)(2616005)(476003)(478600001)(7416002)(6116002)(3846002)(6512007)(86362001)(36756003)(66446008)(186003)(26005)(64756008)(102836004)(386003)(6506007)(52116002)(50226002)(5660300002)(71200400001)(316002)(2201001)(8936002)(71190400001)(66066001)(99286004)(25786009)(66946007)(66476007)(110136005)(54906003)(8676002)(6486002)(81166006)(81156014)(2906002)(7736002)(305945005)(14454004)(256004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0033;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYaCU5hGDZrGEWTsv5yTPZA9hNyaWjv0VLu9APE+PXZyJFPWBxP1LuPRYEH1PLV67lGHUhT/vaVv5HZGi73rCJorx4Do2aIQPEYj78ONEWVlOtVX98j+au+So/3Kaz/dgjiRnLrdQ8w9uuKka+qz16woQnjdHdexyD/JqLAQpW3xqJDXjrgohdKWjcfV1fqKz6HNpYStZz6nEpSb8emLxiJSnnXnlTZ610kKN+goWqyzngvLEAQNv/1N+N4zvOgHYlwUxt5+PyqOwcd5G/jIKGTnsSwhXWChtOaIuN9ovcYmTxq1ZqHSmb1rsH7WWWSEZsKosDkBHm6+KTFltx9K1CxkweTzfipcdBqt2MuBbWP6MRp9dzxRKfktwquWZkk9PqZVYhi9Ec7KGt1j9uX21KHiNiKDCiP4WOWDOKfyc5zjEti2yn5eB9tNSt6j5ivI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351b4f56-4a47-46be-62d1-08d761da3783
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 10:23:36.2714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tko5uDVdoM1nNcl6Y1i451v+Ug1i3fDVen1cAyD49HCVH9XaWFY7MgGcqGsT39cGrq2nwmtnckrZDq1GhR5NBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add imx8mq/m/n compatible string

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 imx8mq/m/n.dtsi already use this compatible string,
 but not listed in binding doc, so add it.

 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Docu=
mentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index f707b8bee304..2fb466ca2a9d 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -18,6 +18,9 @@ Required properties:
 	       "fsl,imx6ull-usdhc"
 	       "fsl,imx7d-usdhc"
 	       "fsl,imx7ulp-usdhc"
+	       "fsl,imx8mq-usdhc"
+	       "fsl,imx8mm-usdhc"
+	       "fsl,imx8mn-usdhc"
 	       "fsl,imx8qxp-usdhc"
=20
 Optional properties:
--=20
2.16.4

