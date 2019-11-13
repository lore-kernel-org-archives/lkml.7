Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B01C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BD52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eP8L/6sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKMMgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:36:02 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:56801
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfKMMgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:36:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDbZeR8hbtdRkKql6oMwiwgqWXvDd8xkoh5f9gHqYOJJmgrdUBKbpEmCqEGgod/bpFmA18teYkwIVtc8s+SBTVxUuYddy5ulvBkFOhC2YzWk1URQ7SpphU3u6hnRz1Ww90fKCRmPA/LJEvkmf0zlckBp9bK0nRRi/Td1Xa61TYXbbxETzeX/V2lw66bwd2Pu5j2/uO3EGXHmoRA9L2tmZqOJL1IauqLCtH2YBatVB2qtqTCT5dAbow7g3f/JOkB9vbUV2anBp/81xCeHmTX+Aga6RfiUKJJ7UOmats4DOcyNs4fhvxas+2HCNaTnXTRlTOodES4BkunS6+TSKDQc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzyCOArGt4A0Ph0m6l4ceE7jupZQRscXXOAjKBbgJ+U=;
 b=HMSzjm7ZCcpo3HG6ul1INqwJ9+onv/ZEGVHFGY9TCTR36bOT1TffgED0XR7iaLGmXMGz83McQpiKsXogi+cZeGV1LApgPPBg+NdGkf+CXx9U5F1G1hnFPIPTK+Hrudpwj7JillpWo7vjA5+RztG2CBk4I5UX1jGp2edDw5L/PumjI8ybVwC1Uy3viZuX3aYBAz8gboBCKFHCflQxI+SIXBfeybbjExADqoNhnLarnOdU+Js2zXMSSWm7El6Ij3uOK44xHyuqdLzEB1+tpw/9FuTrepj7xQlSgrDMNtajtOpwo8itViR2I7/a1M2OAEKBabAVsLpKlr3v2w/t+OBKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzyCOArGt4A0Ph0m6l4ceE7jupZQRscXXOAjKBbgJ+U=;
 b=eP8L/6sjmKOxXT6i4lxJfBaUn6AUu6NF7e5hRW7QjPTEXVFBwADqciKapNemKmmiWMn2EpRXd5/LsaoiwH7N8z2XX8GiwbTamghjMmRjwU9W0SDLDAliuJxTut/iaTJcan54hBhElQ5NdgNmKQG2bixz0zDhtnkTiyQYQ0N7jV0=
Received: from DB3PR0402MB3835.eurprd04.prod.outlook.com (52.134.65.158) by
 DB3PR0402MB3769.eurprd04.prod.outlook.com (52.134.71.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 12:35:58 +0000
Received: from DB3PR0402MB3835.eurprd04.prod.outlook.com
 ([fe80::3846:d70b:d3ae:8e8]) by DB3PR0402MB3835.eurprd04.prod.outlook.com
 ([fe80::3846:d70b:d3ae:8e8%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 12:35:57 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
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
Subject: Re: [PATCH 1/2] clk: imx: pll14xx: use writel_relaxed
Thread-Topic: [PATCH 1/2] clk: imx: pll14xx: use writel_relaxed
Thread-Index: AQHVmfNueqAnKxSTgEmcfZ1/aON4uqeI8eAAgAASX4CAAAWlgA==
Date:   Wed, 13 Nov 2019 12:35:57 +0000
Message-ID: <e4fb1c1506c5a5566ed20b564970a97eb6b6c94d.camel@nxp.com>
References: <1573629763-18389-1-git-send-email-peng.fan@nxp.com>
         <1573629763-18389-2-git-send-email-peng.fan@nxp.com>
         <83bed3382379b465494af6b55881e8d05e21c634.camel@nxp.com>
         <AM0PR04MB44817EBFF8CF1BB6E2CE369D88760@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44817EBFF8CF1BB6E2CE369D88760@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78ba2a28-ada9-4957-e76f-08d7683608b1
x-ms-traffictypediagnostic: DB3PR0402MB3769:|DB3PR0402MB3769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB37692A93F52E79174D920BB9F9760@DB3PR0402MB3769.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(189003)(199004)(66066001)(44832011)(486006)(2501003)(102836004)(99286004)(11346002)(7736002)(26005)(76176011)(446003)(3846002)(71200400001)(2616005)(476003)(2201001)(25786009)(36756003)(4326008)(2906002)(4001150100001)(305945005)(86362001)(6436002)(6116002)(66476007)(66556008)(64756008)(6506007)(71190400001)(229853002)(66446008)(186003)(478600001)(8936002)(8676002)(316002)(118296001)(6246003)(14454004)(256004)(81156014)(5660300002)(66946007)(6486002)(91956017)(76116006)(110136005)(6512007)(50226002)(54906003)(4744005)(14444005)(81166006)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3769;H:DB3PR0402MB3835.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xaqmwdu+LAmJPkGTSLuQIhyTYoOteaWOCwEYKrlaWRYdxGXzD3Ed73mxw6wNNqq36Vv65Z7Ekui14tXawumaZ6GlH1mZaLNqBgTtiKiHW81JESs/RDsAvZFiId04yriHVP25zVvecUj9cQ5cV9+4+QMBn5aONAIdjFLzcWmZXXLopwJX4y/Pp39zBZB3LffXQFU8KWaZSMl0bMb0d/QcYA/HFUhljYI7q0toaLGgaQeqbttSl9gW16r7RNFaJKJ2vO2WOhx6nvEGbxVXxTxwTQVt+Hw+cqzXvQzEtf3huoTPZ4rDQitvA+ubjOHz4Stpei2smwCW0FdM8XRQEUarbStdiDVyb+/UmQFRl6dW7DqqRKSGIx64bLeXzUftKRuEHh9VjSlXVRUERx96q2sLI6LUtzq9HLFDWw4OTgg7VaDc95pwp7hwNwwxK+vM1DGS
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEF3A002E7DE124AB9ED3C0AF6B3C38B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ba2a28-ada9-4957-e76f-08d7683608b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:35:57.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRczFzCVCPrvEPrgW766ENOlHdYB2NE7ARjxYlJr6jy0gq4RMPsgwoavODNgQ5oiYQRpvo1S9Xem3e+vU+FTzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTExLTEzIGF0IDEyOjE1ICswMDAwLCBQZW5nIEZhbiB3cm90ZToNCj4gSGkg
RGFuaWVsLA0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gY2xrOiBpbXg6IHBsbDE0
eHg6IHVzZSB3cml0ZWxfcmVsYXhlZA0KPiA+IA0KPiA+IA0KPiA+IE9uIFdlZCwgMjAxOS0xMS0x
MyBhdCAwNzoyNCArMDAwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+IA0KPiA+ID4gSXQgbm90IG1ha2Ugc2Vuc2UgdG8gdXNl
IHdyaXRlbCwgdXNlIHJlbGF4ZWQgdmFyaWFudC4NCj4gPiA+IA0KPiA+IA0KPiA+IEhpIFBlbmcs
DQo+ID4gDQo+ID4gUGxlYXNlIGV4cGxhaW4gd2h5IHRoaXMgY2hhbmdlIGlzIG5lZWRlZC4NCj4g
DQo+IHdyaXRlbCBoYXMgYSBiYXJyaWVyLCBob3dldmVyIHRoYXQgYmFycmllciBpcyBub3QgbmVl
ZGVkLA0KPiBiZWNhdXNlIGRldmljZSBtZW1vcnkgYWNjZXNzIGlzIGluIG9yZGVyIGFuZCBjbGsg
ZHJpdmVyDQo+IGhhcyBzcGluX2xvY2sgb3Igb3RoZXIgbG9jayB0byBtYWtlIHN1cmUgd3JpdGUg
ZmluaXNoZWQuDQo+IA0KDQpNYWtlIHN1cmUgeW91IGFkZCB0aGlzIGluIHRoZSBjb21taXQgbWVz
c2FnZSBmb3IgdjIgOikuDQo=
