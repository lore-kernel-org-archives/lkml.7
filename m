Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C948C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E75F20863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ygf2SpNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCSRsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:48:40 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:40659
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfCSRsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My72lGxSEqZBkPVoDnC1Hjb0EUnuyuF1unkpg+bn0us=;
 b=Ygf2SpNzrY4quCXa1/SQJZvVRAUuuPMkkGaQLIkudTXQ4YO3ZhzsTImPh8D9ym/CPxwiviEheneryDVDpFzhORakvhjYtRQX3fhLv6yA/qkzWeQGH0hmzsoMNGE2QArXAFWvR/3Bb8pcoJRBVj6RYBHgam0AJwnrYdggvbXrC0w=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1SPR01MB025.eurprd04.prod.outlook.com (52.134.2.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 17:48:35 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ddb1:9613:3e6d:eac5]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ddb1:9613:3e6d:eac5%3]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 17:48:35 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v7 0/4] Enable wm8524 on i.MX8MQ-EVK
Thread-Topic: [PATCH v7 0/4] Enable wm8524 on i.MX8MQ-EVK
Thread-Index: AQHU3nv5N1V3CLAcF0WzFz78dteY+A==
Date:   Tue, 19 Mar 2019 17:48:35 +0000
Message-ID: <20190319174823.29467-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22309d1d-0802-4ae2-a3b3-08d6ac931c22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1SPR01MB025;
x-ms-traffictypediagnostic: VI1SPR01MB025:
x-microsoft-antispam-prvs: <VI1SPR01MB025DFDA9869C8B587C1D202F9400@VI1SPR01MB025.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(376002)(39860400002)(199004)(189003)(36756003)(8936002)(6506007)(102836004)(305945005)(52116002)(6116002)(97736004)(26005)(2501003)(7736002)(68736007)(386003)(3846002)(99286004)(25786009)(476003)(486006)(2616005)(186003)(66066001)(44832011)(1076003)(106356001)(86362001)(50226002)(105586002)(2906002)(81166006)(81156014)(6436002)(14454004)(6486002)(478600001)(6512007)(54906003)(53936002)(71190400001)(110136005)(316002)(256004)(8676002)(4326008)(14444005)(5660300002)(71200400001)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB025;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dEdbwHayFlPBYI9SmOEsZGaH4v/nI/b2LWe3W03/3wsxzoiyDbopJ7tA9oUNqNKO5YvW8XsWyQKVFxwu5YyqRa6mXBmr0um4f46tlyzXaPpQo5QY6+9jJ8MhtObXgTUmm7uFKwjy3ggvXipGXJkL3fIm0dslTnM4+cuTU2AppitjYPu8t2x6fZ4FLqE1d53kn7ov+WMIyQZDpBCz61c4JICJ9eneA4q3PU6Acm5PjjbD3j64KGdyA+omTbCjDbGVblSX67JdjOwGCWIttu9Mlp9ylFGqsBF/E6LTGstw3Wi+W6uNLpWjTXgCxK9moj7aYCTNX8xdSaRuCWbwXDXvfCdiqcOP0lSj82oiU1XAobp0Sn3TN1X94x9eGC82AkEjc/ObIQjcsgu45MOMrxyy3iJEEXNS6Rv+qkHucdZp6HQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22309d1d-0802-4ae2-a3b3-08d6ac931c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 17:48:35.4057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8MQ EVK we can start the party using the wm8524 codec
which gets it's data through the SAI2 interface.

In order to make it work this patch series enables the SDMA nodes,
sets the correct pinctrl configuration and uses the simple card
machine driver to put everything together.

Changes since v6: (after Shawn's comments)
	- rebased on latest Shawn's for-next branch
	- added new lines between properties and child nodes
	- added new lines between child nodes
	- keep pinctrl nodes sorted
	- added reviewed by after SoBs in commit message

Changes since v5:
        - remove clocks and clock-names properties from wm8524
        code node as they are not used.

Changes since v4 (after Fabio's review)
        - removed mclk0 from sai2 node because it is not yet supported
          by SAI driver
        - s/audio-codec-0/audio-codec
        - squashed patches 4 and 5

Changes since v3:
        - use "arm64: dts: imx8mq-evk" prefix for patches specific to
          8MQ-EVK
        - squash together patches for setting up SAI (previous 3/5 and
          4/5)
        - add back and document "fsl, imx8mq-sdma" compatbile string

Changes since v2:
        - s/QM/MQ after Chris comments

Changes since v1:
        - added cover letter
        - remove "fsl,imx8mq-sdma" compatible for sdma.

Daniel Baluta (4):
  arm64: dts: imx8mq: Add SDMA nodes
  bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma compatbile string
  arm64: dts: imx8mq: Add SAI2 node
  arm64: dts: imx8mq-evk: Enable audio codec wm8524

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 48 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 37 ++++++++++++++
 3 files changed, 86 insertions(+)

--=20
2.17.1

