Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEC1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A8D20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OzGtKNLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbfCAQgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:36:37 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:61510
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388450AbfCAQgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwBI1/vlYtRT0+PadTv6J4hbCxdIhJZ9YLjIT+9qh6c=;
 b=OzGtKNLvJ76sEHGkkoMzQQ40irskaZMdq0wpPcCDUhwwAEURXxwJAN8KDwxGcUUF/bXUaBYRiyZfCRszIsUPl6esQGQ7XK+sdkfsDxIjjJ3L9rdbIEP09W4KxsHPxL1+vh5YQLgk3sX9T/exisqO0Fo2vR1kVdNRDBB3nK8qbHk=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3504.eurprd04.prod.outlook.com (52.134.4.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Fri, 1 Mar 2019 16:36:31 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 16:36:31 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
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
Subject: [PATCH v5 0/4] Enable wm8524 on i.MX8MQ-EVK
Thread-Topic: [PATCH v5 0/4] Enable wm8524 on i.MX8MQ-EVK
Thread-Index: AQHU0EzsRlqTlUiSy0OM80ksBH0L8A==
Date:   Fri, 1 Mar 2019 16:36:31 +0000
Message-ID: <20190301163604.10618-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e1dbe88-8076-4f46-de9f-08d69e640f43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3504;
x-ms-traffictypediagnostic: VI1PR0402MB3504:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3504;23:wNk/TR8CkTaDDZ4XSk8BBalvKHQNzU3gmnjAf?=
 =?iso-8859-1?Q?14xqa2WSO633fzakakfcxILKh9qTk7ETSBlQizbuGqI2L7eJPFq4jrlfKF?=
 =?iso-8859-1?Q?CQgl938pcWz1sMYeeuhD+LOrU2sWx5AxfR9au7TdSYjNfrC2XPUGF5JoR8?=
 =?iso-8859-1?Q?7r7t3MZYAyssBscrGw2/w9qkxsKrRzUtFUOkl+aFibpOVm2kX+rh7HBpCJ?=
 =?iso-8859-1?Q?zSG5J6gaCAd2YOFW7BuQEgY7toGJ23QH4VR4TJhDSemGDYO1ci3A7xarfj?=
 =?iso-8859-1?Q?g77+ete9TeHRQoIxsvhSJ7kp9R/nmOX++R6eH89yHZRoXFNZqsb7DKv5Pf?=
 =?iso-8859-1?Q?NKfZUy1ju9CPoO2GY16C2xedgvjUmpb1mVN5SXFArcqpVdd0XO10Xpx8GO?=
 =?iso-8859-1?Q?mCY6fu/5x8l8tQiJtyVkFH29L53Mj9UumX8w5c66fxmKIgYcFAB+iHKlJA?=
 =?iso-8859-1?Q?o97kGqXK16elQ2HL9oJDuVsT4TACqbPXQZ4YCXJIZIwnuSzCIfh0bivCnX?=
 =?iso-8859-1?Q?eJf4dEA16CssXTkuCwjg1ItRfb/sXOQhass91I9hGjdYMMka56+gPKxMog?=
 =?iso-8859-1?Q?2i1QvzVllM3JqscWN1X+jfeOfBJSAqtZGqyX7tXXQiODzwtUOb33+iChjN?=
 =?iso-8859-1?Q?VZte30iSJlHsAPacsGIBpSmudpXNkvFkizZzWhDYRQbyhL/88QDA/xXdcb?=
 =?iso-8859-1?Q?4+xpa+23eAJNWgOm/8+K3fRldcxgbaRafBVMp9qzh1M+GHSr6exOpYMj7W?=
 =?iso-8859-1?Q?udDQ3unHsqjxbtNCU49M9GRKkXseQyL5QznkGc3AEwmtF5x0DHoepNfg/z?=
 =?iso-8859-1?Q?Gg6z1N9nJp3HcM6fFiXRS7SCV0S33p+h5JkqRA2T8wO9W0u/Jpsfp4XDxu?=
 =?iso-8859-1?Q?Y60jp4Ag0nSUZe9Z4DYjt99k6Ae484sEttRLMooKHEYy37p+83z4Cu0BLn?=
 =?iso-8859-1?Q?qmAXUGfA3FKiz9IGBEEw06sFgzZocym3QHyHrutU1KRDvWZtDUlSMrHpoG?=
 =?iso-8859-1?Q?k+ziGv/qE0Tpif+tlDefHHKAzOtasbiqXdh4V39zFV3WY6TqjoudUaVEdv?=
 =?iso-8859-1?Q?iNkvtsxUjHUqz66LL8cdyrVPtruPmZxDCUQmatVbObp+PoiphVN3Zqi0HX?=
 =?iso-8859-1?Q?LFx+Yl1kcT5cu3/7dBb3rago7TC6bjtRLaU3xLwNPtSIvB8Ww8KxoWPBkA?=
 =?iso-8859-1?Q?Wd3LC1TD6Ob2fUtfgeAN6GB47DrbROFGqwt/7Iho+nYZ3sJK9SdYz0eUy4?=
 =?iso-8859-1?Q?8mW1fyT6VbgYvJYgb/fpDgTENJa9G6cXIQE6M9xPK7TEgaQp45hF9+jb0r?=
 =?iso-8859-1?Q?wcq8C37sWo8JZgj7wVTQqrEkg4QCOilxfkBbcdpx7QILgzCEDvwUrKPzyd?=
 =?iso-8859-1?Q?V71mWpP0wGnek3vIkv/n8KsgRauOaFyjB65vfpAERKqsDjg/QR+JDu0866?=
 =?iso-8859-1?Q?PvCGpAl4+D6WlTTm847qepIe/VXcBEeHhWAEG?=
x-microsoft-antispam-prvs: <VI1PR0402MB3504A87FC08678B6F6E27609F9760@VI1PR0402MB3504.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(189003)(26005)(66066001)(186003)(7416002)(25786009)(106356001)(4326008)(2616005)(105586002)(6116002)(476003)(2351001)(68736007)(2501003)(50226002)(3846002)(486006)(44832011)(478600001)(256004)(14454004)(36756003)(2906002)(5640700003)(6436002)(305945005)(53936002)(86362001)(54906003)(316002)(1730700003)(81156014)(81166006)(8676002)(52116002)(8936002)(71200400001)(71190400001)(5660300002)(99286004)(102836004)(1076003)(6916009)(4744005)(97736004)(7736002)(6486002)(6512007)(6506007)(386003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3504;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: umXohuP9jOuBqzNpvHeGyVcNS+cUUJE06ciAYHcVEnTjLd+4XzmdMrTF9BZm05/fQCZfPwyy1z+DWAU5ZkiDOdyIr2ye6xDveIVOeZzGypE3cw1nJQ61epnP6TDXUrUXI6h0sAwHm3rJDh0Sqn5X2qVDtH+iBCSEBY6tgRPeGSFWTXfDfU2axv3DA3rjwnznISZf6zYeaf8h3VZ61nCoPi/iyQvg4MPjTtkm+oF/GY2eKwE42EcrhdyMvlz3sxct6H7x/7EEAO6gxtj0IPRlsklThljCx2euDC6aR2i5NqEH2Nk3DtbteWCFD7JmhCbR/9Zo10Z0SmsQ2sYs3xzbf77WCrKEv23bBfP+E5whhLdbd08JV9zV3UFnFS0Fw5fCyYvtaNlm/5PeIqDdC1HtBokekzDF+oG1eZpTj8vAgXU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1dbe88-8076-4f46-de9f-08d69e640f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 16:36:31.3200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4 (after Fabio's review)
	- removed mclk0 from sai2 node because it is not yet supported by SAI driv=
er
	- s/audio-codec-0/audio-codec
	- squashed patches 4 and 5

Changes since v3:
	- use "arm64: dts: imx8mq-evk" prefix for patches specific to 8MQ-EVK
	- squash together patches for setting up SAI (previous 3/5 and 4/5)
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
  arm64: dts: imx8mq-evk: Enable audio codec wm8952

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 48 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 37 ++++++++++++++
 3 files changed, 86 insertions(+)

--=20
2.17.1

