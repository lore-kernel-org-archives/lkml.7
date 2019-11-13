Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535EEC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8C7222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z4DISI/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKMMPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:15:51 -0500
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:40259
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbfKMMPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:15:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd171bM4riR8OIGgDY/yNaxl2VLeypbJuirQSPq3mjSlxqj2hKGej8X1vqSeICCcQ2jJswwl4xdlJfp2zI8RPxcj0vt2vRaCQ6bN3aQ0Zw9XP6GzdwgNNjGKMRx00K/+damaX1Bx/NDh33IJC0P53+2sQ0tjnrXT/Vws6qSrnM4mtqvFq6nEPE5lQW3AHO8XDJw3aq4VCNtQpkjko6BkPVNgbAYNn560YrBT4f6PGUheCV53F+Mi85+IgN8Q/UeVsZwoUukz9mGjAGsmGaRJFtDSFr2YOMwC3CA4SP0ePq9qD65YyegI1n6aqX2UO/WYZ3hLLeyZ7ws8P1uwIBks5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riEDNXnMuo8hNvzflIh6uV2CaAM4u53S4rfwKMOi6rs=;
 b=dPQH41NPz4mfngIUBHDeFnXpeHI1nYc+yGA4UPN4hsyCm8Cfhb6fWmXCkq0FOiZZdUWgMINnkj/xPYp2PGovgSc/S4Qq/uYlMGaa8MuFKY8cv/Da6dZfwdL8cjZnunwHbdhvliksU9qpANueJUuSv2OkpNKgjKU6I3OpjbsOX5oDABAmV52uFXK6jrkrJFrYPA9smTWAIZL/d+YNKH0/lBLO7soLbQGMM68BH/mcb3vXroSC75YQvPZ0SmGd6ckwL1l24N5jGZgyQYqER4L8Gr8FWabBTfv7RYvcrNdxf/Plee6eq9gGpnH4uvDipVlsVsYR5Pmw4hc9gpj/PP4WiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riEDNXnMuo8hNvzflIh6uV2CaAM4u53S4rfwKMOi6rs=;
 b=Z4DISI/QYree0Yfeq9qDbJvNFT+zSOMdFfarYczZi/+li5W8eQwg0RjH7xVUcnGziw1ZXZp0iwMrhOywne+JIcwKDOjuZkhRJhfNBpP04V3QGMQrMHdL37E8bu5SLx3Oxa1uBh8VCqNnKd0mz0yQ2oKZV3j6oaJaqYZ3abU+zqc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6340.eurprd04.prod.outlook.com (10.255.182.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 12:15:45 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 12:15:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Alice Guo <alice.guo@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 1/2] clk: imx: pll14xx: use writel_relaxed
Thread-Topic: [PATCH 1/2] clk: imx: pll14xx: use writel_relaxed
Thread-Index: AQHVmfNuHTJgCIWBG0W9BBzI6iT6UqeI8eAAgAARuqA=
Date:   Wed, 13 Nov 2019 12:15:45 +0000
Message-ID: <AM0PR04MB44817EBFF8CF1BB6E2CE369D88760@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1573629763-18389-1-git-send-email-peng.fan@nxp.com>
         <1573629763-18389-2-git-send-email-peng.fan@nxp.com>
 <83bed3382379b465494af6b55881e8d05e21c634.camel@nxp.com>
In-Reply-To: <83bed3382379b465494af6b55881e8d05e21c634.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [49.72.5.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df422caf-e2ce-4a4b-129c-08d76833361f
x-ms-traffictypediagnostic: AM0PR04MB6340:|AM0PR04MB6340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB63408881CB0F62B844EAC63088760@AM0PR04MB6340.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(189003)(199004)(4326008)(66946007)(66476007)(66556008)(64756008)(66446008)(66066001)(86362001)(5660300002)(2201001)(52536014)(316002)(9686003)(55016002)(4001150100001)(8936002)(81156014)(8676002)(2501003)(81166006)(54906003)(110136005)(4744005)(229853002)(6246003)(99286004)(6116002)(3846002)(2906002)(74316002)(7736002)(305945005)(33656002)(478600001)(14454004)(102836004)(14444005)(256004)(6506007)(26005)(186003)(7696005)(76176011)(44832011)(476003)(486006)(446003)(11346002)(76116006)(71190400001)(71200400001)(25786009)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6340;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VPZEn4Q3DOgi9ZqJ+8epzL2RmSH4bHvR13k+Twe6Uz+Jgt6pbXpBoyx6R78jH2k0jPkhmMdOqShN6JyqXs/HDhZnfGWI8T9RzyQ6Hfu3h8fNMm5EMyiwUuCkf2+CkKRHEWt1xmXbwPN96311ID0HIHBVmtGka4FDLBHOQ8Syab6lMhXvYuu92rkwavvX1w7viRzsK6ajcPIpCqdAVrKilOrFuLTFy5rvg7jRlDp5Im7W7EoZfRJRtro9uYvxY0Cfjmp9mXQIzFcUHko849f8fD+bISt9n/ZabRcKz9FQiKxXfyrL7l3hFnfIDCVrUKOvWwmvCpombXaGPJSgDQrgLZ/hf+IH4IrromMyQhF0PFq+I+X8Q+yxPqadkKpPWxUDVGqdTOBzV+t1uP4RX3ijiEV57prk8kFXDgzlI1kG9PsUV2ZyTx9sTqNzfVWBtJdQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df422caf-e2ce-4a4b-129c-08d76833361f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:15:45.5102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCx5Quhli4z8JhsmeTNngR2j+88b+f4lMPHGDJcSUwoEuD/m/AEwkrl5B+k9jF2eFO0bbIsMx49ArW6XyTGfIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBjbGs6IGlteDogcGxsMTR4
eDogdXNlIHdyaXRlbF9yZWxheGVkDQo+IA0KPiANCj4gT24gV2VkLCAyMDE5LTExLTEzIGF0IDA3
OjI0ICswMDAwLCBQZW5nIEZhbiB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gPg0KPiA+IEl0IG5vdCBtYWtlIHNlbnNlIHRvIHVzZSB3cml0ZWwsIHVzZSBy
ZWxheGVkIHZhcmlhbnQuDQo+ID4NCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBQbGVhc2UgZXhwbGFp
biB3aHkgdGhpcyBjaGFuZ2UgaXMgbmVlZGVkLg0KDQp3cml0ZWwgaGFzIGEgYmFycmllciwgaG93
ZXZlciB0aGF0IGJhcnJpZXIgaXMgbm90IG5lZWRlZCwNCmJlY2F1c2UgZGV2aWNlIG1lbW9yeSBh
Y2Nlc3MgaXMgaW4gb3JkZXIgYW5kIGNsayBkcml2ZXINCmhhcyBzcGluX2xvY2sgb3Igb3RoZXIg
bG9jayB0byBtYWtlIHN1cmUgd3JpdGUgZmluaXNoZWQuDQoNCkkgd291bGQgaGVhciBtb3JlIGNv
bW1lbnRzIGJlZm9yZSBJIHBvc3QgVjIgYWJvdXQNCnRoZSBjaGFuZ2UgYW5kIG90aGVyIHNpbWls
YXIgcGF0Y2hlcyB0byBzd2l0Y2ggdG8NCnVzZSByZWxheGVkIEFQSS4NCg0KVGhhbmtzLA0KUGVu
Zy4NCg==
