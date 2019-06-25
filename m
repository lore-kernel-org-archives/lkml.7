Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673C9C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366992054F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AvhlBUnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfFYHHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:07:03 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:64993
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfFYHHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSaUhYJVgnfZeiXyUus4rXj5vvkqAzAGvjZw+VugLas=;
 b=AvhlBUnrjkn7mbS4GcrlJbpXDuwSZsuw9aSZ1/NUzClnY+KNrv1a5SLHghxrYfPqlB5tOcQnAGhgsQmP3AxnK6Ej15b+KBrPrSCFFo/Dvi4bDw4EPO8gwRyOLJnSPC6kqbD/iZM+/Msm3EidXa/HOg3+q0sZPTQxPGG6eoRt0sw=
Received: from DB7PR04MB5178.eurprd04.prod.outlook.com (20.176.236.22) by
 DB7PR04MB5145.eurprd04.prod.outlook.com (20.176.235.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 07:06:56 +0000
Received: from DB7PR04MB5178.eurprd04.prod.outlook.com
 ([fe80::2c71:9f2f:8db1:a290]) by DB7PR04MB5178.eurprd04.prod.outlook.com
 ([fe80::2c71:9f2f:8db1:a290%4]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 07:06:56 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] clk: imx8mm: GPT1 clock mux option #5 should be
 sys_pll1_80m
Thread-Topic: [PATCH 2/2] clk: imx8mm: GPT1 clock mux option #5 should be
 sys_pll1_80m
Thread-Index: AQHVKyQzJN5BE3akGkGXuEng8rXJJ6ar8rfA
Date:   Tue, 25 Jun 2019 07:06:55 +0000
Message-ID: <DB7PR04MB51783F81729B64AA16705BF587E30@DB7PR04MB5178.eurprd04.prod.outlook.com>
References: <20190625070602.37670-1-Anson.Huang@nxp.com>
 <20190625070602.37670-2-Anson.Huang@nxp.com>
In-Reply-To: <20190625070602.37670-2-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a41b646d-8d3a-4c1a-ae5d-08d6f93bb578
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5145;
x-ms-traffictypediagnostic: DB7PR04MB5145:
x-microsoft-antispam-prvs: <DB7PR04MB51458C39F3B362F3EA30207687E30@DB7PR04MB5145.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(13464003)(199004)(66476007)(316002)(55016002)(446003)(9686003)(102836004)(2906002)(486006)(476003)(478600001)(305945005)(66066001)(11346002)(86362001)(2201001)(6116002)(25786009)(68736007)(3846002)(71190400001)(71200400001)(7736002)(6436002)(74316002)(52536014)(256004)(6246003)(14454004)(229853002)(33656002)(14444005)(7696005)(53936002)(99286004)(53546011)(81156014)(81166006)(186003)(6506007)(5660300002)(66946007)(73956011)(76176011)(76116006)(8676002)(8936002)(66556008)(64756008)(66446008)(2501003)(26005)(110136005)(4326008)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5145;H:DB7PR04MB5178.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nZn2e4pw2sw2vgiyGdthugprB1fWCIPLagiTQahvOXtv+UTKPLiJ+hTHtICsqiSK75jEP9hP6Ps4iXN3b7Y5oISTEtiPuc0Kn/wlK/I9TCw1qcLquOEcQ4C897hpmnGMWTC69M51EM3kKv+bervLF5tLp3uO7ZWaVnPE/YThTkBh51yged8U0L2JAseiqEOUgQVP5ubSr7juZwISd6l4aW3ydnULgbQRUD4TPTb4gDWVjkJ/lznUFJqqzh/l66ElUN5mK/5eG8ZpTdSIa8oadcb3TitRoIULzbQ56hLlv1dtjq/UVqDgy3tC9p0B9EFMSX5FM+iWNxHjdbwlq/c4XiN9dBkWCthcd3quZDSV9jYE2UtErm9wqf/H+EtdWYHRL4d0sW97QmInLCN8BZ2AzoOe7o1bSCm13qys7MdXXgw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41b646d-8d3a-4c1a-ae5d-08d6f93bb578
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:06:56.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ping.bai@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T0sgZm9yIG1lLg0KDQpCUg0KSmFja3kgQmFpDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEFuc29uLkh1YW5nQG54cC5jb20gW21haWx0bzpBbnNvbi5IdWFuZ0BueHAuY29t
XQ0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDI1LCAyMDE5IDM6MDYgUE0NCj4gVG86IG10dXJxdWV0
dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0K
PiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFt
QGdtYWlsLmNvbTsNCj4gTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47
IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT47DQo+IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPjsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1s
aW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBjbGs6
IGlteDhtbTogR1BUMSBjbG9jayBtdXggb3B0aW9uICM1IHNob3VsZCBiZQ0KPiBzeXNfcGxsMV84
MG0NCj4gDQo+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4g
aS5NWDhNTSdzIEdQVDEgY2xvY2sgbXV4IG9wdGlvbiAjNSBzaG91bGQgYmUgc3lzX3BsbDFfODBt
LCBOT1QNCj4gc3lzX3BsbDFfODAwbSwgY29ycmVjdCBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xr
L2lteC9jbGstaW14OG1tLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xr
LWlteDhtbS5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYw0KPiBpbmRleCA1MTZlNjhk
Li5kMWE4NGY3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbS5jDQo+
ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMNCj4gQEAgLTI5Myw3ICsyOTMsNyBA
QCBzdGF0aWMgY29uc3QgY2hhciAqaW14OG1tX3B3bTRfc2Vsc1tdID0NCj4geyJvc2NfMjRtIiwg
InN5c19wbGwyXzEwMG0iLCAic3lzX3BsbDFfMQ0KPiAgCQkJCQkgInN5c19wbGwzX291dCIsICJj
bGtfZXh0MiIsICJzeXNfcGxsMV84MG0iLA0KPiAidmlkZW9fcGxsMV9vdXQiLCB9Ow0KPiANCj4g
IHN0YXRpYyBjb25zdCBjaGFyICppbXg4bW1fZ3B0MV9zZWxzW10gPSB7Im9zY18yNG0iLCAic3lz
X3BsbDJfMTAwbSIsDQo+ICJzeXNfcGxsMV80MDBtIiwgInN5c19wbGwxXzQwbSIsDQo+IC0JCQkJ
CSAidmlkZW9fcGxsMV9vdXQiLCAic3lzX3BsbDFfODAwbSIsDQo+ICJhdWRpb19wbGwxX291dCIs
ICJjbGtfZXh0MSIgfTsNCj4gKwkJCQkJICJ2aWRlb19wbGwxX291dCIsICJzeXNfcGxsMV84MG0i
LCAiYXVkaW9fcGxsMV9vdXQiLA0KPiAiY2xrX2V4dDEiIH07DQo+IA0KPiAgc3RhdGljIGNvbnN0
IGNoYXIgKmlteDhtbV93ZG9nX3NlbHNbXSA9IHsib3NjXzI0bSIsICJzeXNfcGxsMV8xMzNtIiwN
Cj4gInN5c19wbGwxXzE2MG0iLCAidnB1X3BsbF9vdXQiLA0KPiAgCQkJCQkgInN5c19wbGwyXzEy
NW0iLCAic3lzX3BsbDNfb3V0IiwgInN5c19wbGwxXzgwbSIsDQo+ICJzeXNfcGxsMl8xNjZtIiwg
fTsNCj4gLS0NCj4gMi43LjQNCg0K
