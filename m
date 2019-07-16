Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A4C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830752173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rcqFLQJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbfGPNn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:43:29 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:54665
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728608AbfGPNn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:43:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgL0a6Y0g9g1UqJelUEOysHZ6PLQPvlr4TztL96Qi2rv8GpXK0XFykaDoe6rJyDgqu+bQLahMGfE6l7otvFCZV0zxAB1E5HCnrtdsbSJNWbGyRhaJ1ZtwznXIqmgmCXVGb/eJ+3ILU5vZ1+nhNZfcGYL81QQh8hdS+5jdwyJ3joNDmXeCZzSGicqeSes4o7RBoZ//KuZfA1LC/VfLUf85jftkczVy6Wk0hL+gk6KFpXqVMvZT+YTTjcluKdhyDkCSqPffGn6nLy1umsEXYdMYTskYpd1t5+FosXyAKvp2fFB6FiLX/Etg5ytu7PhuoUUh2pmQ/y7nudO/iKJiIwRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqY8Js25oHv3o7brTQjn5AriI17XQeXjRxYJYZMS9HA=;
 b=ID+aM0mp2X1jYRXtIv4emXPo1qi17VHr3Xd5O2y/hmXDVaezaowK6AJcam5R5MpeikowB4LhaFXz1/zrsz2ENni5K5FqtOjk3q348wWnopNPUg6Tf4FSJlt3k6hvbEtNbVX812wtME6dpgWbuqwBt0r7M4AAK0XvpFmYXCfyCz4bMxHKIYwh/qo5V9A68uBSsDht5ZyXA5cSz/iCmnNe187m4k01Opa7gBiMtx1y/8Xl7MRy+NuvkKrg2+WpZjv36bxzBH7WQNOVxXhUtM6KwoUIuI6YCUWX9LQ8XqcUCSw+VuKd2CTYf2+0iBGnqSIU4j6V+OlCr/CIstiumnYVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqY8Js25oHv3o7brTQjn5AriI17XQeXjRxYJYZMS9HA=;
 b=rcqFLQJng9fnneDl84rH2owCvPqOB0epFTY0vynJZxIWPkpGWp281zDMAAVpVeL1y8XKXTzceZzpQDlda5pkYrSFyn1vqjPlgnVWOe41uogUvxQ1g7tfA4ep7Ckwaxj5xeptX9x6vtOKNwEkDVFZExEV99H56Fn2rK/9SfxXbDw=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB4503.eurprd04.prod.outlook.com (20.177.37.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 13:43:24 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::5563:4416:c0a2:f511]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::5563:4416:c0a2:f511%6]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 13:43:24 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pramod Kumar <pramod.kumar_1@nxp.com>
Subject: [PATCH v4 0/2] arm64: dts: nxp: add ls1046a frwy board support
Thread-Topic: [PATCH v4 0/2]    arm64: dts: nxp: add ls1046a frwy board support
Thread-Index: AQHVO9xwquX3nK7pckOrEOPd6jFhfQ==
Date:   Tue, 16 Jul 2019 13:43:23 +0000
Message-ID: <1563284586-29928-1-git-send-email-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SG2PR04CA0133.apcprd04.prod.outlook.com
 (2603:1096:3:16::17) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.142.151.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8448a090-c4fc-49f0-ce21-08d709f39259
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4503;
x-ms-traffictypediagnostic: AM6PR04MB4503:
x-microsoft-antispam-prvs: <AM6PR04MB4503514A582B06BCD1368EEEF6CE0@AM6PR04MB4503.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(199004)(189003)(2616005)(81156014)(66946007)(476003)(66476007)(64756008)(66556008)(86362001)(66446008)(2501003)(55236004)(71190400001)(102836004)(71200400001)(78486014)(26005)(316002)(50226002)(81166006)(54906003)(110136005)(8936002)(6506007)(386003)(5660300002)(186003)(14454004)(52116002)(256004)(6636002)(4744005)(99286004)(4326008)(25786009)(7736002)(478600001)(305945005)(6486002)(3846002)(6512007)(6116002)(53936002)(36756003)(2201001)(486006)(2906002)(68736007)(66066001)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4503;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IM6p9VCka8Yrj6PmejRwFzjjiDpdmwqP7OOi07s+mRBxHhe0eX+0stS7aueEMopOYEe9B5ror8CJJOygE0/nvZNwd+IQKDImdBf56BS6uM+PYjPo2TsLqrgsToosELlsjw1pfZ706reb5Yg+d6gxyMIOUg8V9gPN4er7XOpr5fos8ah33zWt/hymtZCnZzIrZmgPx+lB26Iuw4omfiLZzeVicGJlobQlrE7wHrwAwnhtBXFPFsujWQr7c+rKjJxwzJCBW0lQ+tW1rJyfegWQZ3nbcJKnva5UMNGiydXq2aR/RCbbVcnZjBswIO1d2/KrkEo5U8NcM+yQvr3alou0LI4IiQP2h95t1zgrF89JFc9WXjgQMzsKUf6jKWpA1HSH9ue1xILWT0cHZkb3wwFM6OvRkHQYOrMDsT57UfgkS/o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8448a090-c4fc-49f0-ce21-08d709f39259
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 13:43:24.1281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pramod.kumar_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes for v4:
incorporated shawn review comment

Pramod Kumar (2):
  dt-bindings: arm: nxp: Add device tree binding for ls1046a-frwy board
  arm64: dts: nxp: add ls1046a-frwy board support

 Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts | 156 +++++++++++++++++=
++++
 3 files changed, 158 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts

--=20
2.7.4

