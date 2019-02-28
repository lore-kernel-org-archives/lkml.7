Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B92C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5ED2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OcAJnXD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbfB1Vmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:42:49 -0500
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:35150
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfB1Vms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb75TGZBTfcTwbAXq/v5yrL/nN2cfM6fwV7dgBALXKs=;
 b=OcAJnXD6EaP+IQ3nlSO83CWmCPws4OFIs8tmiCKYxDZCWYKMBbCGiwKGDGws2uG5I4ORgutOwlUn4qhwTZxa/oj3V3z1T2vxNlN2dDmGL1dTh7JpdMVfHaiB955Jxx5XrLzJm8LLWNbTnL24JVjnafh2554ItwiMyUc/OOjTzUo=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5795.eurprd04.prod.outlook.com (20.178.118.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 21:42:43 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 21:42:43 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 0/3] arm: dts: imx8mq: Add cpufreq support 
Thread-Topic: [PATCH v3 0/3] arm: dts: imx8mq: Add cpufreq support 
Thread-Index: AQHUz66JcrblPS7T30yYcmpLzVVm8g==
Date:   Thu, 28 Feb 2019 21:42:43 +0000
Message-ID: <1551390149-15443-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P194CA0012.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::22) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a116acc8-c95d-46a4-b98c-08d69dc5ab91
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5795;
x-ms-traffictypediagnostic: AM0PR04MB5795:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5795;23:I3gVUMzJE8k9pFCqv/ISAvlPhDNMIWQyPrHC9a2?=
 =?iso-8859-1?Q?jDLVBt7979gw5KmSSFP2a9OVrEiji7iymeQvYJ1xDbvMKZ6yoWTC5jNha4?=
 =?iso-8859-1?Q?UTQO+SztdYtoxe/89s55mh69gaEbvL5YBDV5MWrzqYn7KM8gf4kBsmKABm?=
 =?iso-8859-1?Q?gUXWXVdjKzUWCrzkkIB2ST+QQt5Z35cgIhG3bv3aLdCRjfPEwFjdFMFHWW?=
 =?iso-8859-1?Q?Wc6lOkF7fNLQBU+GMQP1FqN1WBD9AFCGTNLZQISBzj9EypPMiVYh9M74RU?=
 =?iso-8859-1?Q?U1uB13lWQZ6kK/aVSZ9B07lUspAdkR+ETd0cVDWDLz77JNEJqap2gV8faX?=
 =?iso-8859-1?Q?OgnRNzKuOJE1IPnPUksVK9nupg10zdJpoEn7yf73AeiFpsapCF0wlvCW6U?=
 =?iso-8859-1?Q?+kd2C8Dghggi0NmkZvk9k6AUzvv0AJJK9VYLu6GisfCOitFm7VqZOKsuPZ?=
 =?iso-8859-1?Q?D6fkofm3Aj/4JppnDqiUc0ve1YLv6weD+1VHx1twu8HfnKQZxNwH3/cH7Z?=
 =?iso-8859-1?Q?gSujEpht3gHo+vmdzez60yWlcqOHVsKIU/wzvBK64f7g9nDH5vZt8kk36g?=
 =?iso-8859-1?Q?Vr8hUwM54ryFTSuBRi9KzVlvioCGkhd0LSxiy3aORpwIQWR7/eL5uVXmmj?=
 =?iso-8859-1?Q?Hmk97izeu/fylmRvKHeei9PK/zEvY89fzw7mdLJpcSLJHP2MIPcD13FpiY?=
 =?iso-8859-1?Q?5EgyvSPnyLfPKZIBuOxOUrvD04EqYLVuP6E0PGUrWBxve7uHYlZlETQTCl?=
 =?iso-8859-1?Q?/X0nkq+u9cW0Sy2C+E3H0CmA7KmJmclASMJ1cWWfqJu5GjPIYHoDZJm6mh?=
 =?iso-8859-1?Q?47ndeAFzBErxLAwInJ4+SvJZH7YbNdAVgEq0cd0vEa6fCS8DHjdGTNqaJ0?=
 =?iso-8859-1?Q?G3cleRIjs2RofLa+sA6zokg62qhOfPiI9GAGPDKy52YCWQSfMJ40/Ry19x?=
 =?iso-8859-1?Q?zWen5bB/2M3yezyzQMUA1E5XCnVZcoApZXNTFRlG/Gi1Np6XwyPLXx4lzl?=
 =?iso-8859-1?Q?5ZmmCsIoO08I4/orMTzXMVUpgrcIUCaQn3+ryAEmAZ8nxz/uWn3rkChlPe?=
 =?iso-8859-1?Q?7++cqAKmQw19UHZVAJk6/zoL1bwlZZ0tfumlk2WKoH8HG61WwASgjgBq/N?=
 =?iso-8859-1?Q?CAY1N1M2NP9SZKLV7M9bpZElu0QqoONO0nVc85rfNZh0a9g1po5ck8Eza8?=
 =?iso-8859-1?Q?fxBJ6aM+ZO+5wELRwHpf/IlSqj0feMJDUiYmshQV/EX8xDW6YV8e4jH9bX?=
 =?iso-8859-1?Q?5MBbbfpysDEop39jlJ7rqftrfUBVffNEujg0T3yRq+IaEKQp5tb1+9LHRb?=
 =?iso-8859-1?Q?NM=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB5795ADF1A6B6EE4D2FA63800F6750@AM0PR04MB5795.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(25786009)(316002)(3846002)(2616005)(476003)(6436002)(110136005)(486006)(54906003)(44832011)(106356001)(99286004)(6486002)(105586002)(14454004)(102836004)(8936002)(68736007)(186003)(66066001)(26005)(36756003)(71190400001)(71200400001)(6512007)(4743002)(5660300002)(50226002)(305945005)(53936002)(8676002)(7416002)(81166006)(81156014)(6116002)(2906002)(256004)(478600001)(4744005)(386003)(7736002)(52116002)(86362001)(97736004)(6506007)(6636002)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5795;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RAN298/J19+TkxBe1jVUypjfP3FgBgJEGTB1O0wdmvyA1sTjz1wwhScE8LHRPFoU4aQQalxNDrssYZAgexwuEq6p1oz2uoa4oKHu54GH0bkkl++y+tp2PQMxjPFHN/AZDF9fWwOGbKeBc720jmtg8KYf/kh5c6buwfbgVKOM9zbr9NrZCn8bYUc2TkgNhNuzYMq0q6GYvpt9Z+vyz0nLdHzDMaOzHphj3vymYMToU6n08MG3G2ZyAV0Ob+3GNW/DS2wPQAU7yaRGBurLyVENADVu8rZa4bWiNDkgSWNyiGbeh7Np7Xj4eSUFDMefa+eCuiXrYwkk6rU4+lt6+jFIhGV025HwlqhaLqaER6Sn48xejp4GUCEqhRRttgpoyjTa3NjglRRqgMfzzqFMBj0nyDz5l2Y+3GtYvIfyaiAiCtM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a116acc8-c95d-46a4-b98c-08d69dc5ab91
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 21:42:42.5111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 * renamed the regulator
 * removed the useless enable-active-high from the regulator=20
 * renamed a53_0_opp_table to a53_opp_table

Abel Vesa (3):
  arm64: dts: imx8mq: Add the clocks and the latencies for the A53 cores
  arm64: dts: imx8mq: Add the buck vdd_arm regulator
  arm64: dts: imx8mq: Add the opp table and cores opp properties

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 35 ++++++++++++++++++++++++=
++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 31 ++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

--=20
2.7.4

