Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE3C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC0421530
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YoU4Dd3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfE1NVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:21:04 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:40791
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfE1NVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxQkmAR3/nC4h/iM+VsfJ2M4qbq6Dn4Xax/aaZ3e42Y=;
 b=YoU4Dd3aLu1OJFqS08Vr+noccKz98wxSDY+SMa6RLBIoCeHFWQ4Hv/O78kGlHT20HWfaJZaHA4sMG8Rqsgsxfodt4NAMMhPrXUpriQGZ0os7UphgfhPfnhupbKZctB7CHwFIOLCxp/Wr+SlujZJs7U8c8djrdLpyDTdTeQC4RNU=
Received: from AM6PR04MB5207.eurprd04.prod.outlook.com (20.177.35.159) by
 AM6PR04MB4261.eurprd04.prod.outlook.com (52.135.168.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 13:20:59 +0000
Received: from AM6PR04MB5207.eurprd04.prod.outlook.com
 ([fe80::fd2a:e078:f9d7:cb6b]) by AM6PR04MB5207.eurprd04.prod.outlook.com
 ([fe80::fd2a:e078:f9d7:cb6b%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 13:20:46 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/3] Add mclk0 clock source for SAI
Thread-Topic: [PATCH 0/3] Add mclk0 clock source for SAI
Thread-Index: AQHVFVgpjX4j9HD02UiVNkRH/YGV5Q==
Date:   Tue, 28 May 2019 13:20:46 +0000
Message-ID: <20190528132034.3908-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0114.eurprd09.prod.outlook.com
 (2603:10a6:803:78::37) To AM6PR04MB5207.eurprd04.prod.outlook.com
 (2603:10a6:20b:e::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bf85019-402e-42f0-49c1-08d6e36f4b4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4261;
x-ms-traffictypediagnostic: AM6PR04MB4261:
x-microsoft-antispam-prvs: <AM6PR04MB4261B611E6F38679AC25DE78F91E0@AM6PR04MB4261.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(66066001)(71190400001)(305945005)(71200400001)(8676002)(81156014)(102836004)(2906002)(386003)(2501003)(6116002)(3846002)(7416002)(478600001)(53936002)(68736007)(50226002)(5660300002)(81166006)(7736002)(1076003)(14454004)(8936002)(86362001)(256004)(186003)(26005)(6512007)(486006)(476003)(2616005)(54906003)(110136005)(44832011)(73956011)(64756008)(66946007)(66556008)(66476007)(66446008)(316002)(52116002)(25786009)(36756003)(6506007)(99286004)(6486002)(14444005)(6436002)(4326008)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4261;H:AM6PR04MB5207.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KyJZdGjWJHl4Fn5nlwMq+O4xb85yLkxz9PifqhrC42FFMqkYsJNsxmTLLNfsglGCwBjU/9KcVtJF3FuCZma+hYRSfEluO0rs3X5jJ4NqIgKDyBJEWlJDvGHl7/l3ZZ5d5QSVBpjFuOEqF3oW2V94porIMrMRtK7YaGPnZ0TnvZqqeaE7klh/IhdBA5UTWdi/XqI1afrUXaujMFgVuimIGzqXvsmnYF43+j3M9dPafa5fbd01PT4FzjISA6U3Ffisy7Fp2CEwRMYPHUKugYdPOnko34uBp5YPtPT0ZmG1da16LwX6TO7A3C3UMsCSHOulp2pVo3QApfvhqqXv4W3OY2KsSpc/ONMZSlEF3+5YAzXHVyN2cujOLk4Zr7WoxwTHp9nzQalqrtk49R1CDzqM35eEDaVV9ebqj2WsvLbI9yE=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <27ECECFB133A6741B1718F4D42309625@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf85019-402e-42f0-49c1-08d6e36f4b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 13:20:46.8556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daniel.baluta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series brings together patches [1] and [2] which
introduce mclk0 clock source via DT.

mclk0..3 are the four clock sources options
of SAI's clock MUX.=20

mclk0 option selects:
 - Bus Clock on i.MX8
 - MCLK1 on i.MX6/7

Finally we also update the DT binding information for SAI clocks.

In [1] and [2] Nicolin had a very good point on the fact that
mclk0 might not be needed in the DT. Anyhow, there are two reasons
for which I think mlck0 should be added to DT:

1) SAI clock source select MUX is really part of the hardware
2) flexibility! We let DT tell us which is the option for MUX
option 0.


[1] lkml.org/lkml/2019/4/20/141
[2] lkml.org/lkml/2019/4/20/56

Daniel Baluta (2):
  dt-bindings: sound: Clarify the usage of clocks in SAI
  ASoC: fsl_sai: Read SAI clock source 0 from DT

Shengjiu Wang (1):
  ARM: dts: imx: Add mclk0 clock for SAI

 Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++--
 arch/arm/boot/dts/imx6sx.dtsi                       | 6 ++++--
 arch/arm/boot/dts/imx6ul.dtsi                       | 9 ++++++---
 arch/arm/boot/dts/imx7s.dtsi                        | 9 ++++++---
 sound/soc/fsl/fsl_sai.c                             | 3 +--
 5 files changed, 20 insertions(+), 12 deletions(-)

--=20
2.17.1

