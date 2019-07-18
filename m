Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADA3C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA0D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PJDCofpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391036AbfGRDMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:12:01 -0400
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:3214
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390201AbfGRDLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8tL5IbbLeN2qYjHtDYkT/7CWpLak68kq2s+Ac9V+Cfrns6dNP7vlXz12H+69T4MRT7X0V51cL43fPvcWoSwQ3nlyaj489hOLWBrMIBdN1pTIn1RZ2xOeupdHoEWhp5AzyxVxdOhwtEikuHfxNTRAxbNlAl4m4nimD17SnD0Yp5+n/qHSkT0Af8OX/0xObeAPXOGeDO+1ZjTRKAmfajXMq/EpK+aUibIPYCE00QBJjfwc8LgMAyt42HC6eKAdVCwoFjx4eNnWMVFOZ2o3oHrJrqNlQUWq+Gj7iB3JMZBK711ISnRNEuVwPLNy1icnT5cDQpQcJtSN31+EhxY1UD7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF5wM9BaVnnUInEdaLt++JwvuA9BIlwmSC+Wmwa9F0c=;
 b=afpd+pY1rw9jqfP89maWR2VQICdEC2kWQ5+NuIR31T2sCAJ8dX6gm9W4gxZJHfWaySNcW19uA6qMIaOGMAginHmOo7oWHgAWbWZknbM75KYow7XJ/aUjxE7XU9VvHzpeW9i5JW951FTJPtfd/sQO3cyw07eJ3M3sVVhUsRNkgaWK9gX8VySslQWL9jSVH+wQyfCAL5apIenuXRNBhNnn8+j8R/gU05ARuIZV5O9DJOv44PZtCEIOjMZUELGJuCXeZ1x7EixAbBJeB1dWjoT/U4PaCbYjpu71uA0BdVNZPBoTjYdItL7N20NGOSZbTMxv0+z4tHFyeGxKHL/jRVt0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF5wM9BaVnnUInEdaLt++JwvuA9BIlwmSC+Wmwa9F0c=;
 b=PJDCofpmcMXBZvZhQUGb2D/jqKeR6sjV0Fex79pX8+370qzPicUaluPwni1a5nAGvVcu+npC25C0W3BNnetQ+o/gDl13MJrnk/mSiYeTrcyRK1vhqJ/DE9wJAMk9oOdL017siy3aMB9+avVQFYdmb2gGqKrUvVMkTBAj1g2EdCI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5619.eurprd04.prod.outlook.com (20.178.119.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 03:11:33 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431%7]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 03:11:33 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH] clk: imx8: Add DSP related clocks
Thread-Topic: [PATCH] clk: imx8: Add DSP related clocks
Thread-Index: AQHVMOmjjQ4zLh0oI0SdOjI+DVS1VabPysGA
Date:   Thu, 18 Jul 2019 03:11:33 +0000
Message-ID: <AM0PR04MB4211AA9543908F6302C49B1C80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190702152007.12190-1-daniel.baluta@nxp.com>
In-Reply-To: <20190702152007.12190-1-daniel.baluta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6346b8e4-2b39-4d4c-1291-08d70b2da35d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB5619;
x-ms-traffictypediagnostic: AM0PR04MB5619:
x-microsoft-antispam-prvs: <AM0PR04MB5619734D7FD127435FDF7A5080C80@AM0PR04MB5619.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:224;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(189003)(199004)(53936002)(66066001)(86362001)(71190400001)(71200400001)(6436002)(52536014)(6246003)(7736002)(6506007)(4326008)(66446008)(25786009)(256004)(76116006)(478600001)(486006)(64756008)(7696005)(102836004)(66556008)(66476007)(5660300002)(9686003)(55016002)(44832011)(229853002)(68736007)(66946007)(54906003)(316002)(305945005)(74316002)(11346002)(476003)(558084003)(8676002)(446003)(8936002)(81156014)(81166006)(7416002)(110136005)(6116002)(99286004)(26005)(2906002)(76176011)(3846002)(33656002)(14454004)(2501003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5619;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 57mZidokdy0qtMq6Ufihv1EsqDhtBO+BefK4HGzHdrovKi6WYwTKW+a2rfXxuNKiz38CGPUizH4NnAhdc+vWfzLl2AXJBVmq0UBJg5fxznqkgBvuJ6W13Vx2dBCh9k9z9MkEUzKahHZrzSCHHhq/8SzgkZsF1esqQLAh46NMUKoL4w9aN4TbXi/al09BdlXkWWNb3rszfs6lKKyuC6HTnXBAL7j4MoI0WlqlelCUoC/00+UUGFOHzCoFf3C1rTX+0JXwZ2IHAym2NGpg3M5XxcDEKYoXnbIXYwO3Zntus8Pe7mbSMysIyR+Zntrbl5rZLf5PIYfGFfyorIo4xwYeEul4nBer3BM9mE+x5LzM/PHdh3wxfDQmI7zdwkAHyaP8FaLaxRApWDDXEfwZGivYvmxZUFhjSMUht7owY0nCpXo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6346b8e4-2b39-4d4c-1291-08d70b2da35d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 03:11:33.7904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIEp1bHkgMiwgMjAxOSAxMToyMCBQTQ0KPiANCj4gaS5NWDhRWFAgY29udGFpbnMgSGlm
aTQgRFNQLiBUaGVyZSBhcmUgZm91ciBjbG9ja3MgYXNzb2NpYXRlZCB3aXRoIERTUDoNCj4gICAq
IGRzcF9scGNnX2NvcmVfY2xrDQo+ICAgKiBkc3BfbHBjZ19pcGdfY2xrDQo+ICAgKiBkc3BfbHBj
Z19hZGJfYWNsaw0KPiAgICogb2NyYW1fbHBjZ19pcGdfY2xrDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBE
b25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
