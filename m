Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD745C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7729920830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nNqEkeC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfCZJnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:43:04 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:10787
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfCZJnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+74x6rlV1o4YuyeMhGwEATmN+w/erMU5GTfvKOQHSc=;
 b=nNqEkeC16mtwtYrIy8U+ha0hWkDUzI06jQ2ZdOax6+/WRgrc/sm1CUgOI3nwGdX5V4z8RY82KylL83G0y3Uahoz1eHVcFHgDaGetSO1kfGLaI4g1dYEX7LVsuHz8znzH+2nxd0EZHS1bgzVTJHL3hOyuvLQetiIzSx8V696Kr5U=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3693.eurprd04.prod.outlook.com (52.134.15.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 09:42:59 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ddb1:9613:3e6d:eac5]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ddb1:9613:3e6d:eac5%3]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 09:42:59 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Teo Hall <teo.hall@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/2] Add EDMA0/EDMA1 nodes
Thread-Topic: [PATCH 0/2] Add EDMA0/EDMA1 nodes
Thread-Index: AQHU47hMZVfAHUBRSUmQva9do5QMbQ==
Date:   Tue, 26 Mar 2019 09:42:59 +0000
Message-ID: <20190326094239.5910-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0235.eurprd07.prod.outlook.com
 (2603:10a6:802:58::38) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58feb0f6-0f17-4d8e-1dbe-08d6b1cf6e96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3693;
x-ms-traffictypediagnostic: VI1PR0402MB3693:
x-microsoft-antispam-prvs: <VI1PR0402MB369378FE7D5B66819C1930DCF95F0@VI1PR0402MB3693.eurprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(81166006)(6506007)(4326008)(1730700003)(25786009)(81156014)(66066001)(102836004)(86362001)(5660300002)(2351001)(105586002)(1076003)(478600001)(4744005)(8676002)(6512007)(14454004)(3846002)(99286004)(52116002)(6116002)(68736007)(50226002)(106356001)(8936002)(36756003)(256004)(26005)(53936002)(5640700003)(44832011)(97736004)(7736002)(386003)(6436002)(2501003)(316002)(2616005)(6486002)(54906003)(476003)(6916009)(486006)(71200400001)(305945005)(186003)(71190400001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3693;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I5xpBqSLrEddokqYz8/9po7LTTKdgqGRO5dcZNHu3SbDn35KW00cYxKvrLXCjC+nKwAWxIPWBBnIxK/xvM//cy2x9ddRA0A1Z6cjdBt6WcVZd+GGjZ4FRPkNkgjwaH/YO/ENP87aenYmB0InwDhZvbBjbQJxdav8HYmCq5vqY6CeBsV8r42OwHcZ0drBhWSW3KQxV5ouiSaYAkgyRWQs68raU8A7sO1lcTzLTzjMQYqSgLAPB7ORMD7d6I9RKXmH94C3svyKMw+PgGD8fLwZYyhv6faMJblCWU9y7Aq8udNP0FdddtgDgixL/Ab0uDHSXapCj0CGjVzf5lJKazTAq0/jAki4dQWNMqZHgplAdsQFhGNGNIojh4rWysDmlpKP19jBO8/Wv0Ou2TqORDx4CorMYGGPe0hzLb+KGh4ErKA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58feb0f6-0f17-4d8e-1dbe-08d6b1cf6e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 09:42:59.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch documents the fsl,imx8qm-edma string while the second
adds the two EDMA nodes used by Audio peripherals.

Daniel Baluta (2):
  bindings: fsl-edma: Document fsl,imx8qm-edma compatbile string
  arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes

 .../devicetree/bindings/dma/fsl-edma.txt      |  1 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 72 +++++++++++++++++++
 2 files changed, 73 insertions(+)

--=20
2.17.1

