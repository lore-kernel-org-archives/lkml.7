Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B67C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBC620684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YeHqf1KP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfCHMCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:02:40 -0500
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:15337
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfCHMCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEZq2TR3bJk00a3rJY2c3mwKVvWrjzYGswVhXCtpW7Y=;
 b=YeHqf1KP9R/6/0kXptWqjJ8mHZ5O/YzjZRVSrp9QH3x0C0xnTMG5duqFH2jHRN+K6VqDNRIGcTwug7HziKcu/w5ATZzD7RsmSmmlK8rb7cTUUmPSiwcqMy8rTMatnORaXQgju8etWffYrALGGQ89oz101wCdAa0U5hZd5kk300w=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3776.eurprd04.prod.outlook.com (52.134.15.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 12:02:21 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1686.019; Fri, 8 Mar 2019
 12:02:21 +0000
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
Subject: [PATCH v6 0/4] Enable wm8524 on i.MX8MQ-EVK
Thread-Topic: [PATCH v6 0/4] Enable wm8524 on i.MX8MQ-EVK
Thread-Index: AQHU1abIRppiqmtEjUatHwfHKpgWzg==
Date:   Fri, 8 Mar 2019 12:02:21 +0000
Message-ID: <20190308120141.3698-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0074.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::15) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e1c347a-2d18-4b18-c720-08d6a3bdeb14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3776;
x-ms-traffictypediagnostic: VI1PR0402MB3776:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3776;23:kDxdaAKsOFpQ+ZEjx4fZ/4YIWgNCt6fHgDiYz?=
 =?iso-8859-1?Q?wx8x6mD8KsvLbDZ9/Uax2qPCA51jcqV3/l6FR0HnrJz2U5SXvUuOt4hjtd?=
 =?iso-8859-1?Q?M2fwKJYO6xjzxbL7zR+u/1ShaQTBW1nMKeAvaFAvUqbm+22qONUONc9/tK?=
 =?iso-8859-1?Q?obCWrfvehJgcEoVyN1vqBtvXTf8ipwb/zDa+F49epGfGw3NNixFey+00jL?=
 =?iso-8859-1?Q?+avj1Zzbnm/2VW4/DQ+wej9i2jiCmZPgr9ANj9CFZfOsB6dZJn/BXHmgzH?=
 =?iso-8859-1?Q?qJROgfHEtx0euT6C8Dq9ZhEmRKyFxbJCd67xQq7NsYY8YX4ZTi0AkGYeHe?=
 =?iso-8859-1?Q?0zLOVip/j9m+HQE2Q+8bIRODG4Hc4519TH8gtwZyAQYlAiNUVftWnyjyZI?=
 =?iso-8859-1?Q?9tQHf4KA1zN5LXmuHaXpV50WTtYmxWfEd/L+LEoDC5SzUo4+GHk5lQVyl7?=
 =?iso-8859-1?Q?x5uWWlhwp9mSGbPhSC1k2qs5mnoe8gxv+YsUGctsKW07awPeAxifQSxB1t?=
 =?iso-8859-1?Q?Xsz6RAGG3aq6AHTSr323H+FE909RDuMUUTDmFLt8YKcUpu/Ok4b58hsaWI?=
 =?iso-8859-1?Q?5izXAixRXBB8+JqaYPTCC/HsFcpvl/dIZDF/EF+h6TScXu6vHC9X38o9W8?=
 =?iso-8859-1?Q?yizwPI9bhkWsTCrO4SAfNO7p71xNOz7RCA4FniHlzv7qtNc2Ojpcc6D3Ap?=
 =?iso-8859-1?Q?fTHu9aWUXeJx3A3eV29ZS9Xg2Na50SluXsJEaUoVBK7UGAGc4XHP6o33eg?=
 =?iso-8859-1?Q?GlsdxFifYNZAPXdJuSzeE29xTqeJpreGCTHowCfzh2Y3cqezehG9ol/ECH?=
 =?iso-8859-1?Q?S9pahOBMDeAkw4hVRjTXh30/NZMTnqtMD21ZC036sHi/0b5+PDx89OjH3w?=
 =?iso-8859-1?Q?XytWDo6IjEmxEDVe7eEgtzLxQ1i233oKgh8CUswjTkaFKes4RjwSZakhiK?=
 =?iso-8859-1?Q?Npb4R9WcKGS7FHYGH1iH6J+odbyufJsIqjJvELRbMUYUKj2LAubsfHQoHe?=
 =?iso-8859-1?Q?yt6W3mmRVzcMIJvbTFQeUuToXaZiCvaVkkzw9JBk9kYQEqbWhQWqEFZ5bU?=
 =?iso-8859-1?Q?swbSXiZbkKzpf4GP5Veosy1N+bYDIPMCrjE0sqIRpvW3/fjMFUNgchunkr?=
 =?iso-8859-1?Q?3J6jK7J+n6mGiRhSn4fQ6L+5F9uOSypwflnVFLpr9ObpzSzJOWXm+VHGdV?=
 =?iso-8859-1?Q?vFKBKoO7mF2uyWmRwXYcpN5FdqS/xg/thgKm8rh7d5CdNSNOvUYfrzlkPi?=
 =?iso-8859-1?Q?G/5LUIWhmxW86tTZHrZ+286c3Q1mpG6WbBJ2E60aufgHJTtV6xQFuN+6cI?=
 =?iso-8859-1?Q?jnUs4jme1zN/9/m2tyAdBI5irw/pn141puUU+x2SYF1HIbg=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB37768D4907BC8E45080DE0CAF94D0@VI1PR0402MB3776.eurprd04.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(36756003)(52116002)(2906002)(68736007)(6436002)(25786009)(7736002)(478600001)(305945005)(105586002)(1076003)(14454004)(2351001)(81166006)(106356001)(256004)(14444005)(6486002)(8676002)(8936002)(50226002)(6916009)(4326008)(102836004)(54906003)(3846002)(6506007)(26005)(66066001)(386003)(6116002)(316002)(486006)(1730700003)(81156014)(97736004)(44832011)(6512007)(476003)(186003)(7416002)(86362001)(5640700003)(71200400001)(71190400001)(99286004)(2616005)(53936002)(2501003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3776;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RKfkElPOi18ATPNhRf2ygESJzwnx4zOIN9Ns1JewOEzDk70vQ+BjXKqkx1I2M7+iw/q7NQbvXILkpKr+fm3Pzia45NgglSqIQMJx7DxfvUt/GYkz04fJJzI8OtPs2tvkgtl+O7f6/TGERkbhTWhWxDSsxevST3mSTK9LerPxhc2ZjdRcW0O9xHYUW0xgrDII3Wsk/WIJw3qAQQuGO5CUcvo6nIZPbi8kxKjwhZZq4s0uWIlh6YXY2lLexn+zQ/jR6+VRMu4+9dO07YxSSJT2ou4c3mwVwJgWUI45Mw5erFd5v8wul/kuYdv1GYjJedIdeE1cawXF8fA8BqNXc5tn/RaLszbUFuhgwfo6dAR9pestR+YZB3SjUxTnE61e5+twsKv0Ut9JW13UkPQzLhkndTfLELuVWBXHLOPZPTZv+BQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1c347a-2d18-4b18-c720-08d6a3bdeb14
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 12:02:21.1360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8MQ EVK we can start the party using the wm8524 codec
which gets it's data through the SAI2 interface.

In order to make it work this patch series enables the SDMA nodes,
sets the correct pinctrl configuration and uses the simple card
machine driver to put everything together.

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
  arm64: dts: imx8mq-evk: Enable audio codec wm8952

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 46 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 37 +++++++++++++++
 3 files changed, 84 insertions(+)

--=20
2.17.1

