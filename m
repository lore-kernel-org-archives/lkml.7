Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF1C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5507E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U53HaBSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfEOOmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:42:32 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:20292
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbfEOOmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZSxi6PKEX6QkZ1mzRoDXi9tKdelUHX55DqOzj4GltU=;
 b=U53HaBSBl0JUobTb8D12Fft2cCLBXlUZouMPIkisfM7sKHTeJHbMK2T/0AYhA4p33BoYc/YRf/hhlNVD+CzdqaF5zFdyWNhCAS7asyvIJwxX2ZoH6mKGXw974jxJTW7XhRJivJluY0CH8T8XU+oab2GWyDiLbxj4eulA08Omhfk=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 14:42:27 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::888f:9ea:6f65:508f]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::888f:9ea:6f65:508f%6]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 14:42:27 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RESEND PATCH v3 0/2] Enable wm8524 codec on i.MX8MM EVK
Thread-Topic: [RESEND PATCH v3 0/2] Enable wm8524 codec on i.MX8MM EVK
Thread-Index: AQHVCyxqNUZOmlzo4kmYJC/BwBb+ag==
Date:   Wed, 15 May 2019 14:42:27 +0000
Message-ID: <20190515144210.25596-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::23) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 165c3486-26ae-4ac4-ab05-08d6d9438d3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2895;
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-antispam-prvs: <VI1PR0402MB2895C4E1C680060AA451BF72F9090@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(54906003)(5640700003)(6506007)(6916009)(478600001)(6512007)(66446008)(14454004)(99286004)(102836004)(36756003)(52116002)(386003)(73956011)(66946007)(7416002)(3846002)(6116002)(64756008)(66476007)(66556008)(2616005)(476003)(53936002)(316002)(486006)(44832011)(5660300002)(2351001)(71200400001)(71190400001)(1076003)(7736002)(26005)(4744005)(305945005)(186003)(6486002)(86362001)(2501003)(4326008)(66066001)(25786009)(256004)(68736007)(81166006)(8676002)(50226002)(81156014)(1730700003)(6436002)(2906002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2895;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cD2520dLrqFKZXpTQMvflvdnDYyeQLpRgL1sZ2dWDsLuijvU8yj04cyHeM3u2hTbXiQRfUeDTOD6bM2PQ7S0hmCsBFFyp+kkYIwPX8zo86QXpi6tqaCvCOQEupli+wd/9n5QOyzbKWeYcmznOZNCfXkVXCbVwXi0U6wLjiMn/lNpnfIM/fMgyFNNJ+82UG5uFWfTJKQSLasVi225/HhdQvkO/2EUQ8JnZspT5NqDVa4oKN8TL8u8/2GAIs+ml9JhDmXGa1v7CNTXSBvE1jyD1uQxaO31NyNBbS1JReGIXlKri4NJOYod23gOcYtx7KnTQtd9M3QSZoY35gW5N9Jc1d58ymfHoOiXo4ZILH79zPWg/1gSuYuzajAaBr030pyAx4OkcqLWDh7AEfjQubvUY9CC6SFCIUpTQqOb5utScrs=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2C46ACD4F00E9A4DB116E9692A0D211A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165c3486-26ae-4ac4-ab05-08d6d9438d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 14:42:27.7850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces the SAI nodes on i.MX8MM EVK then
creates the wm8524 codec node and finally uses simple card machine
driver to create a sound card.

Changes since v2:
       - place compatible strings one a single lines
       - move GPIO pinctrl in a node of its own
       - remove codec phandle

Changes since v1:
        - use "fsl,imx8mm-sai", "fsl,imx8mq-sai" compatbile strings and
          remove "fsl,imx6sx-sai" because SAI module on i.MX8M is not
          compatbile with SAI modules form i.MX6

RESEND to fix email encoding.

Daniel Baluta (2):
  arm64: dts: imx8mm: Add SAI nodes
  arm64: dts: imx8mm-evk: Enable audio codec wm8524

 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 55 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi    | 66 ++++++++++++++++++++
 2 files changed, 121 insertions(+)

--=20
2.17.1

