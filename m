Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E7CC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5A4214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kV1PQwjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfE1NVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:21:12 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:40791
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfE1NVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8HZyeQUmEnnZoWkR+RFUxGAioO30YMQTQ4qC0+mvSQ=;
 b=kV1PQwjbpALH8JZu0FGDByMfYMvmYQJTsXi9UmhQqPtddcYXRRVZwv4rsiNVVOh5KrLA8T2PC1GnSubQvdlzNMM1tsCFK1kJLWDVKFZQUQUNKJQU1MuJCiBu6m8ebrtwBs9ilN7kp3VWr+Q2VnSLJ+4mIeTeqQuZEwUjNadOA1Y=
Received: from AM6PR04MB5207.eurprd04.prod.outlook.com (20.177.35.159) by
 AM6PR04MB4261.eurprd04.prod.outlook.com (52.135.168.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 13:21:02 +0000
Received: from AM6PR04MB5207.eurprd04.prod.outlook.com
 ([fe80::fd2a:e078:f9d7:cb6b]) by AM6PR04MB5207.eurprd04.prod.outlook.com
 ([fe80::fd2a:e078:f9d7:cb6b%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 13:21:02 +0000
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
Subject: [PATCH 2/3] dt-bindings: sound: Clarify the usage of clocks in SAI
Thread-Topic: [PATCH 2/3] dt-bindings: sound: Clarify the usage of clocks in
 SAI
Thread-Index: AQHVFVgyY86a0UnI1EGu57KmugJ41Q==
Date:   Tue, 28 May 2019 13:21:01 +0000
Message-ID: <20190528132034.3908-3-daniel.baluta@nxp.com>
References: <20190528132034.3908-1-daniel.baluta@nxp.com>
In-Reply-To: <20190528132034.3908-1-daniel.baluta@nxp.com>
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
x-ms-office365-filtering-correlation-id: 9f21236b-89c4-458d-d7a8-08d6e36f5420
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4261;
x-ms-traffictypediagnostic: AM6PR04MB4261:
x-microsoft-antispam-prvs: <AM6PR04MB426181B0FF46E9DCDDCC834DF91E0@AM6PR04MB4261.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(66066001)(71190400001)(305945005)(71200400001)(8676002)(81156014)(102836004)(2906002)(386003)(2501003)(6116002)(3846002)(7416002)(478600001)(53936002)(68736007)(50226002)(5660300002)(81166006)(7736002)(1076003)(14454004)(8936002)(86362001)(256004)(186003)(26005)(6512007)(486006)(446003)(11346002)(476003)(2616005)(54906003)(110136005)(44832011)(73956011)(64756008)(66946007)(66556008)(66476007)(66446008)(316002)(52116002)(25786009)(36756003)(6506007)(99286004)(6486002)(76176011)(14444005)(6436002)(4326008)(2201001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4261;H:AM6PR04MB5207.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DaS2mgdhkrdva4ZWagbUgG7kFcexk0zKnT9gRHpO4by81gkM9CsaDC4RWkaUwZOBiGnrYxgzxzT94W/gJEdm323PKn6h9/hLqSrhdkKh8vjPU575GGqDaxIaWCEqJlrKg/5nCQGijd22UF2T5/lC3caeS6rheb0YrPPXrYrLYHrQmbmcqgZ8uYNKVvRlOcQeFiYvkV8Wm2G0ybibugM1k7p8UXRynDzwMeN4q2gYK0VqFgDFymIncAa6trhHlOpw03Bw89c/0gXeTQ7qLA8O9fOnKyn78ZFRgcLKoNWgOpvZSt42rqw9zHflsUPWeudL1XLfaC/ILHfteU5q2UuN6fV7WZf+/S8BYTo+dBY7mOXy4h1wxASASnUs2hcwTCE3aKs+2KJyn/bgeym37UlksMxW9YGpglutJTfaS9Evie8=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A5AA31DC66CBBF419C05BB1555E2A511@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f21236b-89c4-458d-d7a8-08d6e36f5420
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 13:21:02.0712
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

SAI might have up to 4 clock sources selected by an internal
CLK mux.

On imx6/7 mclk0/mclk1 are the same, while on imx8 mclk0 and
mclk1 are coming from different sources.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Document=
ation/devicetree/bindings/sound/fsl-sai.txt
index 2e726b983845..db0497d1920a 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -15,8 +15,9 @@ Required properties:
   - clocks		: Must contain an entry for each entry in clock-names.
=20
   - clock-names		: Must include the "bus" for register access and
-			  "mclk1", "mclk2", "mclk3" for bit clock and frame
-			  clock providing.
+			  "mclk0", "mclk1", "mclk2", "mclk3" the four clock
+			  sources of the SAI clock MUX selecting a clock
+			  for bit clock and frame clock providing.
   - dmas		: Generic dma devicetree binding as described in
 			  Documentation/devicetree/bindings/dma/dma.txt.
=20
--=20
2.17.1

