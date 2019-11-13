Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6F7C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6F2207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nA/5i5+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfKMHYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:24:48 -0500
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:62033
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfKMHYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:24:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+O256r6jvLNiLQERd6oPH3MWy98Vve+hIItwUU81XBO93qiEjU14F7O/c3o6FQTqzAM4+fIFN3xqhuz/UXYGRcmALTrUaV3rkaepKQtNadlEQnbn6mtAx/eLZH2eFNrB20UPW4pwH33Savv+MrTfukkQZzJcNXlU/V2aRpHDpHuPk9YpRVt6xfr+LwsOPCbOZBiR6KnsF4HVBrq4zWy5iYENH2NAKH5hJaylmO8SRFl2QOr0a/R3XeulI6dtmY/thk7j6i86bVkqxLikNHwjIy1M3OhOCO3fSR9iqpon1/bPMvd/tTwnaOXxlJM+EGlwnxTcQIZhO8oj63aUljG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df8qoSTm6Yxz5RdMiYoqAqGjfmaDv+qoblnoInHn9qY=;
 b=MpnrG/EGfWRoSM0wBwb5ot8rRr5jrHllambC6Qijz4uBWURFaUdw+/GVhxOqlHB0YqGQm76WYlsyobZjPbWgI/ErJHmT6Fq0MXfeBGtuPNQYwENidWSBaZ6/cryF0TdFmkj+pziObZ4ZpK7FPVLaBCcejd5rnpXJKShA8MDhlr6FZlAD8Mep4UuBoGyKPHB0sBr56BnHM7BoYgAkcbraUL4Yon5ZOnLwWr7CYf0q7e61WNo2UPvPC6NRBxOiR+4K3BaSS3QJdtFIoWUfnS6gTm/U2/hRCnd0ez1tzb/BMUpqU8Et3Q4/X/MUwhz4lrKFQWj5Uem1O+4Futii0SDRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df8qoSTm6Yxz5RdMiYoqAqGjfmaDv+qoblnoInHn9qY=;
 b=nA/5i5+CdbEi6k6XINEWlfKIdEnAjsIWzPGTuLgS4VNtlqE/thADOOHch+riEv7hqW37pQKRktKid8qzGpkD5QBfOoO3wnBCytPHsm1Kg6O3agCrFBWbN8D/pnhliu+8xNmGK06ol8DjotbSidR6DZISp6PnkV9jsKt1mXI2oJo=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4651.eurprd04.prod.outlook.com (52.135.138.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 13 Nov 2019 07:24:43 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c%7]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 07:24:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] clk: imx: pll14xx: io relaxed fix
Thread-Topic: [PATCH 0/2] clk: imx: pll14xx: io relaxed fix
Thread-Index: AQHVmfNrs+So0yeRFkOsHVVUwKE7Ow==
Date:   Wed, 13 Nov 2019 07:24:42 +0000
Message-ID: <1573629763-18389-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0169.apcprd02.prod.outlook.com
 (2603:1096:201:1f::29) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60a0233e-a66e-46b7-494e-08d7680a8d40
x-ms-traffictypediagnostic: DB7PR04MB4651:|DB7PR04MB4651:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB465111118375B8ED12F28FE488760@DB7PR04MB4651.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(54906003)(81156014)(81166006)(44832011)(8676002)(966005)(50226002)(14444005)(256004)(186003)(52116002)(6636002)(6486002)(66066001)(486006)(110136005)(2906002)(6306002)(8936002)(36756003)(6436002)(316002)(478600001)(6512007)(7736002)(305945005)(71200400001)(2616005)(386003)(102836004)(71190400001)(2501003)(6506007)(26005)(14454004)(476003)(4744005)(5660300002)(66476007)(66556008)(64756008)(66446008)(86362001)(25786009)(6116002)(66946007)(3846002)(99286004)(2201001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4651;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85QN5tMcgT7eU8K9Fw+il4vr5usyHBPQkNQ5F9aqIw6TUtJspOL73UbMDy2XE0yFjWdsuEzYQUyDM7hDTx8CbmTCnrYe+7btnqAvvnPo8k5YVAgUqEFIiatrM6Gu8aT2H/VmxLWixBbKgFqwlOyPCr8Bl3L+NusvH4AR/xwDQZ2xdeJiA9zNpX6k5wiRErM67Awqr71HmA+/Z8veFEoeN4PSH+oWyp2qtR+a09O/8+PR17KMvL8Poo8LwnEYFqTATS3/cQ4HDGv3cWfhBxl6UJoA+Z7YExJiE8hySb/p3zDDQfZJZQWSVHGF9iGMztrrm0XOfAQlDsxs3F43z9UIHk1kbA0wknaORyuExyFpEqjHfOxirlleKfjHvS6etRIwQ1H+cOt5+tzaNEvXqzE8c0gaI+IZCWJ71kXCnVmNgzz9Rc9nGEn8e82v96Ys/XvtIhMVIJNVkOdq/aDKm5GoHtlnZViTUg0LcOTuZHgUVWc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a0233e-a66e-46b7-494e-08d7680a8d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:24:42.9573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9c8hykDixRsaQks2gbEiVXdqRLxcHpZ7Yt4L8McSyiQzcFHyYviyo9NABKhAd6jWAJBkt+BeurvSoYw8f72nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4651
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is insipred from Will Deacon's slide/video:
https://elinux.org/images/a/a8/Uh-oh-Its-IO-Ordering-Will-Deacon-Arm.pdf
https://www.youtube.com/watch?v=3Di6DayghhA8Q

Peng Fan (2):
  clk: imx: pll14xx: use writel_relaxed
  clk: imx: pll14xx: use readl to force write completed

 drivers/clk/imx/clk-pll14xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--=20
2.16.4

