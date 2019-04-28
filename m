Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB419C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEA121473
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cd6Wjzxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfD1G3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:29:35 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:34724
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfD1G3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ft9kqFhY1Tg9u325Sg406S7Z3IgNDptvO4eCCoJDfmI=;
 b=cd6Wjzxz+Ddz1F1gC9SgIj6GoY3wPGVh1+aqXECzhlUg2OisnwXFPjD6tuiRFX55g69ildFRg1P+2NOBNI9XDnoNS3LRGjG1zMoKqUDD1cdei1vdqWghbZZWBAMzDeJwuUpJsKCeMDGWVgVKlCgqGM7ztNLvba/ZpBIaRBo6myU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sun, 28 Apr 2019 06:29:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.016; Sun, 28 Apr 2019
 06:29:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Mukesh Ojha <mojha@codeaurora.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] pwm: imx27: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] pwm: imx27: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHU6Eses7WpkEQM7UuKKaAl029asaYm8YaAgCpVTRA=
Date:   Sun, 28 Apr 2019 06:29:26 +0000
Message-ID: <DB3PR0402MB391651B480F380A067FC827CF5380@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
 <1fae9beb-1dbc-5e62-a39e-57ae5d8e7671@codeaurora.org>
In-Reply-To: <1fae9beb-1dbc-5e62-a39e-57ae5d8e7671@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f5f4618-db01-4270-2efa-08d6cba2dcc1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-antispam-prvs: <DB3PR0402MB389861C2C7A13A1EAE957624F5380@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(13464003)(199004)(71190400001)(102836004)(6246003)(256004)(110136005)(2201001)(97736004)(2906002)(64756008)(66476007)(66556008)(476003)(5660300002)(71200400001)(478600001)(11346002)(86362001)(446003)(73956011)(76116006)(66066001)(66446008)(66946007)(186003)(7696005)(6436002)(26005)(76176011)(33656002)(55016002)(486006)(7736002)(14454004)(52536014)(8936002)(68736007)(74316002)(99286004)(305945005)(44832011)(6116002)(81156014)(229853002)(3846002)(8676002)(53546011)(53936002)(4326008)(81166006)(2501003)(9686003)(316002)(25786009)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EWfeD8ilykJcLMY1p4GWe8cxwvWKYHl1rpT8ylll0WyBsHvlvHaqd5+TRQ5CkuO77u3006mGVp7u5l3d0uqAH0DQYXPe/rpsoAHBx7SzfEV6qeZyGCruyt8bQ8DS9NK6LSO0mEeR6R+dUnOpKMLnD3KK6R+n4nJtk4lmYklKBVVZuUM+NM1ps0ZsMF01TRTvDLrPsdnHp74TJ8PGr7pD/eWyBfOBqkdMOaAFqE1xlTh7aw2nSsmqVHO3zAofDReWa4ZMCZ28lntUwOu83zPeViFv/VEN+L/Htrtf9O95V5eriVsHFrv1LkRilYS7Kb0pFtmbl/5hFET4GBYq4jKpb7x/qFr4mgnXbfx+QRYwl6/Nhv/uPdQsVYhkPZPS/AWnTzqpdGckdtK/VEUJhnh84sSEc8+Iugl87AFwFlbDxOQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5f4618-db01-4270-2efa-08d6cba2dcc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 06:29:26.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE11a2VzaCBP
amhhIFttYWlsdG86bW9qaGFAY29kZWF1cm9yYS5vcmddDQo+IFNlbnQ6IE1vbmRheSwgQXByaWwg
MSwgMjAxOSA0OjAxIFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47
IHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFp
bC5jb207IGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRs
LWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHB3
bTogaW14Mjc6IHVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKQ0KPiB0byBzaW1w
bGlmeSBjb2RlDQo+IA0KPiANCj4gT24gNC8xLzIwMTkgMTA6NTQgQU0sIEFuc29uIEh1YW5nIHdy
b3RlOg0KPiA+IFVzZSB0aGUgbmV3IGhlbHBlciBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3Vy
Y2UoKSB3aGljaCB3cmFwcyB0aGUNCj4gPiBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UoKSBhbmQgZGV2
bV9pb3JlbWFwX3Jlc291cmNlKCkgdG9nZXRoZXIsIHRvDQo+ID4gc2ltcGxpZnkgdGhlIGNvZGUu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNv
bT4NCj4gDQo+IA0KPiBSZXZpZXdlZC1ieTogTXVrZXNoIE9qaGEgPG1vamhhQGNvZGVhdXJvcmEu
b3JnPg0KPiANCj4gQ2hlZXJzLA0KPiAtTXVrZXNoDQo+IA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9wd20vcHdtLWlteDI3LmMgfCA0ICstLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3
bS9wd20taW14MjcuYyBiL2RyaXZlcnMvcHdtL3B3bS1pbXgyNy5jIGluZGV4DQo+ID4gODA2MTMw
Ni4uNDM0YTM1MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3B3bS9wd20taW14MjcuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvcHdtL3B3bS1pbXgyNy5jDQo+ID4gQEAgLTI5MSw3ICsyOTEsNiBAQCBN
T0RVTEVfREVWSUNFX1RBQkxFKG9mLCBwd21faW14MjdfZHRfaWRzKTsNCj4gPiAgIHN0YXRpYyBp
bnQgcHdtX2lteDI3X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICB7
DQo+ID4gICAJc3RydWN0IHB3bV9pbXgyN19jaGlwICppbXg7DQo+ID4gLQlzdHJ1Y3QgcmVzb3Vy
Y2UgKnI7DQo+ID4NCj4gPiAgIAlpbXggPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9m
KCppbXgpLCBHRlBfS0VSTkVMKTsNCj4gPiAgIAlpZiAoaW14ID09IE5VTEwpDQo+ID4gQEAgLTMy
Niw4ICszMjUsNyBAQCBzdGF0aWMgaW50IHB3bV9pbXgyN19wcm9iZShzdHJ1Y3QNCj4gcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgCWlteC0+Y2hpcC5vZl94bGF0ZSA9IG9mX3B3bV94bGF0
ZV93aXRoX2ZsYWdzOw0KPiA+ICAgCWlteC0+Y2hpcC5vZl9wd21fbl9jZWxscyA9IDM7DQo+ID4N
Cj4gPiAtCXIgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDAp
Ow0KPiA+IC0JaW14LT5tbWlvX2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRl
diwgcik7DQo+ID4gKwlpbXgtPm1taW9fYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNv
dXJjZShwZGV2LCAwKTsNCj4gPiAgIAlpZiAoSVNfRVJSKGlteC0+bW1pb19iYXNlKSkNCj4gPiAg
IAkJcmV0dXJuIFBUUl9FUlIoaW14LT5tbWlvX2Jhc2UpOw0KPiA+DQo=
