Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7C9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4B92085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HBa6XwaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfCABlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:41:25 -0500
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:19076
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfCABlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 20:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBmD9zzQNwYiBeWWN7ISjvib1//LotRs/mePPQTrwLU=;
 b=HBa6XwaFVHR6QIeT8tBtLf7QAVpCgVkjfv6KFYf2iHyAkNd30y64K4wTOHuF1c4SYRuPinaS3tmAcdwW2SKk3P9uBf18FPnKsybp4rodtQXVnRcSjlM3H5scJuAczi/CV1lJCCEKeaACsafz/xgkHufKgIYpzfkznVgokZxPKzQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Fri, 1 Mar 2019 01:41:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 01:41:12 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "edubezval@gmail.com" <edubezval@gmail.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUznjp1VM2Vv0vQ0qLNAgNlgUeAaX0UrqAgAALZRCAAO51AIAAsZeg
Date:   Fri, 1 Mar 2019 01:41:12 +0000
Message-ID: <DB3PR0402MB3916D67D2CA6C33D27371F58F5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
 <20190227235455.GA15211@bogus>
 <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJct4BztHEak+=iNK3G7dwYR-pQPeUqb4kBnEdRQMLr6A@mail.gmail.com>
In-Reply-To: <CAL_JsqJct4BztHEak+=iNK3G7dwYR-pQPeUqb4kBnEdRQMLr6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fa5f650-d8b2-4032-3365-08d69de6fcc2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM3NTQ7MjM6SzRHNk1UZlVzTVlFbFM0NmdIdTB1MFA5?=
 =?utf-8?B?THc4cFVya3FYdXczKzMyVytpbVpYNTNONy9vSG5GUmJ6ZWN5dHlDcGtneVdh?=
 =?utf-8?B?QXBtKy8wdmFOMU1qVWZ2NXdlaG03bmF2SGQ0ajZJdGdEdkY3QjI3eDFaQUdG?=
 =?utf-8?B?aTNUZy9TQkFKYUo1QnVyLzdBZERJN0l4UXZ4MWhRME1MeGdxcDZRbnVDSWRk?=
 =?utf-8?B?cE40VXREalZvNVRNZCswZmFHZ3RjVmdrcnZlbzB5S3FiRGxRaDdTdFRNM0tz?=
 =?utf-8?B?VTRoUVlwU243S2ZYQXBpZlV3SDVFelduRThTdXcySlNveWM2WU4rYldNdTlK?=
 =?utf-8?B?TldQUUliZjU4VWZRb255UUNZMnJJaXB5TXQzeWhmWXdQWFYwWjhOdER2WnRH?=
 =?utf-8?B?S241OHJyTUV6OFpXZ094NHFSL3VkektkcFAvVjdINGs1cjlPSkUyYmlJMkpJ?=
 =?utf-8?B?blFHZE15N0g2MXZ3QVQ5ZlF0NDAwV1pCOGhTcDN3b3BXR3dsMWZVMG1pRGhY?=
 =?utf-8?B?dklyckhMVnZIM1JZczBNeDZScHZNZjlXWFF1WVBUL2IwQko1aDk3aVJpbEFi?=
 =?utf-8?B?TUtqYzRhY1ZqNjV0ditvRFRTR3RlMFJHMytPdldvaWRwWTMwWjlTNm5sSWJL?=
 =?utf-8?B?KzBYTUs1M2hPcWVRaFJ6YVBoWGRDOGdFc0xuWWIvWXM5RVdNcVhteVRxN0VX?=
 =?utf-8?B?SGxvU1hKWmU2MUFTcENmYm9URXdweXBNOUxZbkJtSFhMdGlzWnFDY25KVkRM?=
 =?utf-8?B?ekJYSXhkMXAxUWNRYTJSRTJmaHAxeUV2NjhlLy91TGNzTFZMTzhBbGtDbTNn?=
 =?utf-8?B?OU01aVloTTRreEF3VlhXcXY5cENJRURURGkzcytTcDg0eXVuNGVUMFV6MVlv?=
 =?utf-8?B?SDkraWhBck9neG4vc01oTExkYzVlYTdxOUdDYXplVUQrOHY1UFVoTC9HaDZj?=
 =?utf-8?B?RTdCeVl4c1NIc0dlbjV2VjN5dGJUekFFcWZiQzVPRkZOVGR1Z3lhZ2dxNElY?=
 =?utf-8?B?T2lnejFIYStFL3o1RDY4Z1hCQW5OM1ZpY2FnMEtwQWxrdjNkWUR1NUlVZWJi?=
 =?utf-8?B?Rm8zcXljM2l1eDdyZ0VKNDk0amllRTdNSXRQbXU4VkRzZ3RBTXJyTStSaWhU?=
 =?utf-8?B?MFZmaHlUb1h3MVpOdHFlNUhXd1NYODYxZ0JJMG5iaUVmb0c3UUNtRVYzc3J4?=
 =?utf-8?B?NndlNU5TRzREVEFSTUZyaTh3aFEvaVlGSWJPZmx6My9ENURxYWg1N3dwcTJF?=
 =?utf-8?B?d2FkdE0xQ01KKzFTbU1GTmhCdGhTV1dXa0FEd3lHY0htdVc1dXp4YThOUExq?=
 =?utf-8?B?L1VvSm9nU3RqVmdaRmFvNjFscE1zc2xnL1VyUU5aU2VqRkcrWXZCK2J0TzNU?=
 =?utf-8?B?UG4yYnc4WnJXZXZPOVZyUS9GV21yOUg0ditPOFMrZkVESjZJQ3ZoWk9rSHdo?=
 =?utf-8?B?UnN6eDdCVis1Z1E0TVh6RmszVysxTlQweTBjZVR0cXpudFlnbnlSUWxiVlZy?=
 =?utf-8?B?a2JySUFSc255c3VIOUZQck9uMVR6VzNnV1lRMyswSTBzTjBzSXhZU2pyL0xG?=
 =?utf-8?B?MUtZNGVtanB1enc3cHpYVzZnWDR1cVFZcHlDS0xUVm92ZXhlZC80cVYrWlcz?=
 =?utf-8?B?V1diZHBsbjZCcWdaWmpMclpEb0tnQjJWcDlUN0tTbGpTdXRYK0xITlRORGJI?=
 =?utf-8?B?ZU9nM2IyYWRlZ3RsUEtDbnQ0aXE3eXJ6dFJJK3orOWpvWmJYc0JjcXlwdUQz?=
 =?utf-8?B?aXM3TTdjZU9PL28yRXNOTSttWDdtcnUwak0wemdETTdIc0QvNVRnY0xSeExQ?=
 =?utf-8?B?c1ZmbGpMK0pqbXN4SnlhOW43WGltbFlVSm0zWVZxQUNaWjdnZ0xBaG01bklk?=
 =?utf-8?B?c2ZrMDdDYXduZ1M1akYraWdNTjNkZEJ4bGs1MWxoeXRMblFmUXJ6Z1VnUDBQ?=
 =?utf-8?B?RVY1VFgyeWYyUGc9PQ==?=
x-microsoft-antispam-prvs: <DB3PR0402MB3754EBBC096DBCCE9A514FB6F5760@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(13464003)(189003)(199004)(186003)(102836004)(76176011)(53546011)(6506007)(86362001)(7416002)(478600001)(68736007)(26005)(256004)(6346003)(2906002)(5660300002)(6246003)(7696005)(44832011)(99286004)(74316002)(3846002)(6116002)(316002)(2501003)(52536013)(305945005)(966005)(53936002)(8676002)(7736002)(81156014)(71200400001)(55016002)(97736004)(486006)(8936002)(25786009)(71190400001)(81166006)(4326008)(106356001)(11346002)(476003)(93886005)(105586002)(9686003)(33656002)(6436002)(6306002)(229853002)(66066001)(446003)(54906003)(14454004)(110136005)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P2SZNmB9RpIbUBVUk5LAxU5z6Nvin+Hq14A00UyCW9cJT8DxNazBojTM10sky4s2/R8oxrsHVDTAKzK/8sKe6WP+dVlY3uB8sWl2AoFHS3+auTecHJmue1ljPm0YxEjAmuMeqyNaVdqpYzOmxEO/y9+9qJW35qVaFkvcW8VdOMq/uG9vdX5QknohHbwGpPAgoPlzskEbtaQQo0KIjCeOMdpNEJQJ6r79SpgDuXtmRTspTjGKOZzDJkiRt3DfHRGWdBbIC3mYOJKin/9ALd8D4NPreU+Kw8FMfXfCY1CFfETvLVb41IG4ODJFEh2SyNZYTNuYtiuZ/BqUYXUoeL1CCQ+XjZW7R3nsjGvTlC9UWDniw9lulIgqQh7iA/N59HrdpoNgiKhdksJvqdyumADdDIj+Qgw16f8Dt6DLwDuBaF4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa5f650-d8b2-4032-3365-08d69de6fcc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 01:41:12.6006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYi9FZHVhcmRvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2JoQGtl
cm5lbC5vcmddDQo+IFNlbnQ6IDIwMTnlubQy5pyIMjjml6UgMjI6NDkNCj4gVG86IEFuc29uIEh1
YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IHNo
YXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNv
bTsgd2lsbC5kZWFjb25AYXJtLmNvbTsgcnVpLnpoYW5nQGludGVsLmNvbTsNCj4gZWR1YmV6dmFs
QGdtYWlsLmNvbTsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVuZyBEb25nDQo+IDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IHNib3lkQGtlcm5l
bC5vcmc7DQo+IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IEFuZHkgR3Jv
c3MNCj4gPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1
OyBoZWlrb0BzbnRlY2guZGU7DQo+IGFybmRAYXJuZGIuZGU7IG1heGltZS5yaXBhcmRAYm9vdGxp
bi5jb207IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOw0KPiBqYWdhbkBhbWFydWxhc29sdXRp
b25zLmNvbTsgZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsNCj4gbWFyYy53LmdvbnphbGV6
QGZyZWUuZnI7IG9sb2ZAbGl4b20ubmV0OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYxMCAxLzRdIGR0LWJpbmRp
bmdzOiBmc2w6IHNjdTogYWRkIHRoZXJtYWwgYmluZGluZw0KPiANCj4gT24gV2VkLCBGZWIgMjcs
IDIwMTkgYXQgNjo0OCBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3Jv
dGU6DQo+ID4NCj4gPiBIaSwgUm9iDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMhDQo+ID4gQW5zb24g
SHVhbmcNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206
IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3JnXQ0KPiA+ID4gU2VudDogMjAxOeW5
tDLmnIgyOOaXpSA3OjU1DQo+ID4gPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5j
b20+DQo+ID4gPiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7
DQo+ID4gPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRl
YWNvbkBhcm0uY29tOyBydWkuemhhbmdAaW50ZWwuY29tOw0KPiA+ID4gZWR1YmV6dmFsQGdtYWls
LmNvbTsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVuZyBEb25nDQo+ID4gPiA8YWlz
aGVuZy5kb25nQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBzYm95ZEBrZXJuZWwu
b3JnOw0KPiA+ID4gRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsgQW5keSBH
cm9zcw0KPiA+ID4gPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47IGhvcm1zK3JlbmVzYXNAdmVyZ2Uu
bmV0LmF1Ow0KPiA+ID4gaGVpa29Ac250ZWNoLmRlOyBhcm5kQGFybmRiLmRlOyBtYXhpbWUucmlw
YXJkQGJvb3RsaW4uY29tOw0KPiA+ID4gYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGphZ2Fu
QGFtYXJ1bGFzb2x1dGlvbnMuY29tOw0KPiA+ID4gZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNv
bTsgbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7DQo+ID4gPiBvbG9mQGxpeG9tLm5ldDsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBsaW51eC0gcG1A
dmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCBWMTAgMS80XSBkdC1iaW5kaW5nczogZnNsOiBzY3U6IGFkZCB0
aGVybWFsDQo+ID4gPiBiaW5kaW5nDQo+ID4gPg0KPiA+ID4gT24gV2VkLCBGZWIgMjcsIDIwMTkg
YXQgMDg6NDY6MjFBTSArMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+IE5YUCBpLk1Y
OFFYUCBpcyBhbiBBUk12OCBTb0Mgd2l0aCBhIENvcnRleC1NNCBjb3JlIGluc2lkZSBhcw0KPiA+
ID4gPiBzeXN0ZW0gY29udHJvbGxlciwgdGhlIHN5c3RlbSBjb250cm9sbGVyIGlzIGluIGNoYXJn
ZSBvZiBzeXN0ZW0NCj4gPiA+ID4gcG93ZXIsIGNsb2NrIGFuZCB0aGVybWFsIHNlbnNvcnMgZXRj
LiBtYW5hZ2VtZW50LCBMaW51eCBrZXJuZWwgaGFzDQo+ID4gPiA+IHRvIGNvbW11bmljYXRlIHdp
dGggc3lzdGVtIGNvbnRyb2xsZXIgdmlhIE1VIChtZXNzYWdlIHVuaXQpIElQQyB0bw0KPiA+ID4g
PiBnZXQgdGVtcGVyYXR1cmUgZnJvbSB0aGVybWFsIHNlbnNvcnMsIHRoaXMgcGF0Y2ggYWRkcyBi
aW5kaW5nIGRvYw0KPiA+ID4gPiBmb3IgaS5NWCBzeXN0ZW0gY29udHJvbGxlciB0aGVybWFsIGRy
aXZlci4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBDaGFuZ2VzIHNpbmNlIFY5Og0K
PiA+ID4gPiAgICAgLSBjaGFuZ2UgI3RoZXJtYWwtc2Vuc29yLWNlbGxzIHZhbHVlIGluIGV4YW1w
bGUgdG8gMSwgc2luY2UNCj4gPiA+ID4gdGhlcmUgYXJlDQo+ID4gPiBvdGhlcg0KPiA+ID4gPiAg
ICAgICB0aGVybWFsIHNlbnNvcnMgaW5zaWRlIHN5c3RlbSBjb250cm9sbGVyLCBpdCBpcyBqdXN0
IGJlY2F1c2UNCj4gPiA+ID4gdGhlcmUgYXJlDQo+ID4gPiBzdGlsbA0KPiA+ID4gPiAgICAgICBz
b21lIGlzc3VlLCBzbyBzeXN0ZW0gY29udHJvbGxlciBkb2VzIE5PVCBleHBvc2UgdGhlbSBmb3IN
Cj4gPiA+ID4gbm93LA0KPiA+ID4gdGhleSBjb3VsZA0KPiA+ID4gPiAgICAgICBiZSBleHBvc2Vk
IGxhdGVyLCBzbyBpdCBzaG91bGQgYmUgMSBmcm9tIEhXIHBlcnNwZWN0aXZlLg0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNj
dS50eHQgICB8IDIxDQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQN
Cj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2Fs
ZS9mc2wsc2N1LnR4dA0KPiA+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gPiA+IGluZGV4IDcyZDQ4MWMuLjg1NTI3
MGIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gPiA+IEBA
IC0xMjIsNiArMTIyLDIxIEBAIFJUQyBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVzc2FnZSBQcm90
b2NvbA0KPiA+ID4gPiBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiAgLSBjb21wYXRpYmxl
OiBzaG91bGQgYmUgImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQo+ID4gPiA+DQo+ID4gPiA+ICtUaGVy
bWFsIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQo+ID4gPiA+ICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gPiA+ID4gKw0KPiA+ID4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiA+ID4gKy0gY29t
cGF0aWJsZTogICAgICAgICAgICAgICAgICAgICAgU2hvdWxkIGJlIDoNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgImZzbCxpbXg4cXhwLXNjLXRoZXJtYWwiDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBmb2xsb3dlZCBieSAiZnNsLGlteC1zYy10aGVy
bWFsIjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArLSAjdGhlcm1hbC1zZW5zb3ItY2VsbHM6ICAgU2Vl
DQo+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC90aGVybWFs
LnR4dA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9yIGEgZGVzY3JpcHRp
b24uDQo+ID4gPiA+ICsNCj4gPiA+ID4gKy0gaW14LHNlbnNvci1yZXNvdXJjZS1pZDogIEEgc2lu
Z2xlIGludGVnZXIgZm9yIHNpbmdsZSB0aGVybWFsDQo+ID4gPiA+ICt6b25lJ3MNCj4gPiA+IHJl
c291cmNlIElEIG9yDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBhbiBhcnJh
eSBvZiBpbnRlZ2VycyB0byBzcGVjaWZ5IGVhY2gNCj4gPiA+ID4gKyB0aGVybWFsDQo+ID4gPiB6
b25lJ3Mgc2Vuc29yDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICByZXNvdXJj
ZSBJRC4NCj4gPiA+DQo+ID4gPiBDYW4ndCB5b3UgcHV0IHRoZSByZXNvdXJjZSBpZHMgaW4gdGhl
IHRoZXJtYWwtc2Vuc29yIGNlbGxzPyBXaHkgZG8NCj4gPiA+IHlvdSBuZWVkIHRvIGxpc3QgdGhl
bSBoZXJlPw0KPiA+DQo+ID4gRm9yIHRoZSB0aGVybWFsLXNlbnNvciBjZWxscywgaWYgeW91IG1l
YW50IHRoZSBhcmd1bWVudCBvZiB0c2Vucw0KPiA+IHBoYW5kbGUsIHRoZW4gdGhlIHJlYXNvbiBp
cyB0aGF0IGFyZ3VtZW50IGlzIGZvciBzZW5zb3IgaW5kZXggc3RhcnRpbmcNCj4gPiBmcm9tIDAs
IHByZXZpb3VzIEkgdXNlIGl0IGZvciBvdXIgcmVzb3VyY2UgSUQsIGJ1dCBpdCBsb29rcyBjb25m
dXNlZCwNCj4gPiBzaW5jZSB1c2VyIHdpbGwgdGhpbmsgdGhlcmUgYXJlIG1hbnkgc2Vuc29ycyB0
aGVyZSBwZXIgRWR1YXJkbydzIGNvbW1lbnQuDQo+ID4NCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICB0aGVybWFsLXNlbnNvcnMgPSA8JnRzZW5zIDA+Ow0KPiA+DQo+ID4gSWYgeW91IG1lYW50
IHB1dHRpbmcgaXQgaW4gZWFjaCB0aGVybWFsIHNlbnNvciBub2RlIGluc3RlYWQgb2YgInRzZW5z
Ig0KPiA+IG5vZGUsIHRoZW4gaW4gcHJldmlvdXMgcGF0Y2ggc2VyaWVzLCBJIHB1dCB0aGlzICIN
Cj4gPiBpbXgsc2Vuc29yLXJlc291cmNlLWlkICIgcHJvcGVydHkgaW4gZWFjaCB0aGVybWFsIHNl
bnNvciBub2RlLCBidXQgdGhlDQo+ID4gdGhlcm1hbCBzZW5zb3Igbm9kZXMgYXJlIHBhcnNlZCBi
eSBjb21tb24gdGhlcm1hbCBmcmFtZXdvcmssIHRoZXJtYWwNCj4gPiBkcml2ZXIgd2lsbCBuZWVk
IHRvIGZpbmQgdGhlIHRoZXJtYWwgem9uZSBub2RlIGFuZCBnbyB0aHJvdWdoIGV2ZXJ5DQo+ID4g
Y2hpbGQgbm9kZSB0byBnZXQgdGhlIHJlc291cmNlIGlkIGFnYWluLCBzbyBFZHVhcmRvIHN1Z2dl
c3RlZCB0byBwdXQgaXQgaW4NCj4gb3VyIHBsYXRmb3JtIHRzZW5zIG5vZGUsIHRoYXQgbWFrZXMg
b3VyIHRoZXJtYWwgZHJpdmVyIGNvZGUgbXVjaCBtb3JlDQo+IHNpbXBsZS4NCj4gDQo+IFRoZSBw
aGFuZGxlIGFyZ3MgYXJlIG1lYW50IHRvIGJlIGFuIGlkIHR5cGljYWxseS4gVGhlcmUncyBhYnNv
bHV0ZWx5IG5vDQo+IHJlcXVpcmVtZW50IHRoZXkgYXJlIDAtTiBiYXNlZC4gVGhleSBvZnRlbiBh
cmUgYmVjYXVzZSB0aGluZ3MgbGlrZQ0KPiBpbnRlcnJ1cHRzIGFyZSAwLU4gb3IgY2xvY2tzIGhh
dmUgbm8gaC93IGlkLiBJZiB5b3UgYWxyZWFkeSBoYXZlIGFuIGlkLCB1c2UgaXQuDQo+IERvbid0
IGludmVudCB5b3VyIG93bi4NCg0KQXQgdGhlIGJlZ2lubmluZywgSSBwdXQgdGhlIEhXIHJlc291
cmNlIElEIGluIHRoZSAidHNlbnMiIHBoYW5kbGUgYXJndW1lbnQgb2YgInRoZXJtYWwtc2Vuc29y
cyIgbm9kZSwNCnNlZSAgYmVsb3cgcGF0Y2ggSSBzZW50IGJlZm9yZSwgdGhlIGJlbmVmaXQgaXMg
SSBkbyBOT1QgbmVlZCB0byBhZGQgbmV3IHByb3BlcnR5IGZvciBwYXNzaW5nDQpIVyByZXNvdXJj
ZSBJRCB0byBkcml2ZXIsIHRoZSBkaXNhZHZhbnRhZ2UgaXMsIEkgaGF2ZSB0byBwYXJzZSB0aGUg
dGhlcm1hbF96b25lcycgZWFjaCBjaGlsZCBub2RlDQphbmQgZ2V0IHRoZSBIVyByZXNvdXJjZSBJ
RCBmcm9tIHBoYW5kbGUgYXJndW1lbnQoc2VhcmluZyB0aGVybWFsX3pvbmVzIG5vZGUgYW5kIGdv
IHRocm91Z2ggYWxsIGl0cw0KY2hpbGQgbm9kZSwgYW5kIGdldCB0aGUgcGhhbmRsZSBhcmd1bWVu
dCksIHRoZXkgYXJlIGJ5IGRlZmF1bHQgT05MWSBwYXJzZWQgYnkgdGhlcm1hbCBjb3JlDQpkcml2
ZXIuIFdoZW4gd2UgcmVnaXN0ZXIgdGhlcm1hbCB6b25lLCB3ZSBoYXZlIHRvIHBhc3MgdGhlIEhX
IHJlc291cmNlIElEIHdoZW4gY2FsbGluZw0KZGV2bV90aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3Jl
Z2lzdGVyKCksIGlmIHdlIGFkZCBvdXIgb3duIHByb3BlcnR5IHRvIHBhc3MgdGhlIEhXIHJlc291
cmNlIElELA0KdGhlbiBubyBuZWVkIHRvIGRvIHNvLCB3ZSBqdXN0IHBhc3MgdGhlIGluZGV4IDAt
TiBmb3IgZWFjaCB0aGVybWFsIHNlbnNvcnMgaW4gZGV2aWNldHJlZSB3aGljaA0KYWxzbyB3aXRo
IHBoYW5kbGUgYXJndW1lbnQgMC1OLiBTbyB1c2luZyBvdXIgb3duIHByb3BlcnR5IG1ha2VzIHRo
ZSBkcml2ZXIgbXVjaCBtb3JlIHNpbXBsZS4NCg0KU28sIEBFZHVhcmRvLCB3aGljaCBkaXJlY3Rp
b24gSSBzaG91bGQgZ28/IExvb2tzIGxpa2UgUm9iIHN1Z2dlc3RzIGp1c3QgcHV0IHRoZSBIVyBy
ZXNvdXJjZSBJRA0KaW4gdGhlIHBoYW5kbGUgYXJndW1lbnQgbGlrZSB3aGF0IEkgZGlkIGF0IHRo
ZSBiZWdpbm5pbmcsIGNhbiB5b3UgYWR2aXNlPw0KDQpUaGFua3MsDQpBbnNvbi4NCg0KaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDcwMzg0OS8NCj4gKwl0aGVybWFsX3pvbmVz
OiB0aGVybWFsLXpvbmVzIHsNCj4gKwkJY3B1LXRoZXJtYWwwIHsNCj4gKwkJCXBvbGxpbmctZGVs
YXktcGFzc2l2ZSA9IDwyNTA+Ow0KPiArCQkJcG9sbGluZy1kZWxheSA9IDwyMDAwPjsNCj4gKwkJ
CXRoZXJtYWwtc2Vuc29ycyA9IDwmdHNlbnMgMzU1PjsNCj4gKwkJCXRyaXBzIHsNCj4gKwkJCQlj
cHVfYWxlcnQwOiB0cmlwMCB7DQo+ICsJCQkJCXRlbXBlcmF0dXJlID0gPDEwNzAwMD47DQo+ICsJ
CQkJCWh5c3RlcmVzaXMgPSA8MjAwMD47DQo+ICsJCQkJCXR5cGUgPSAicGFzc2l2ZSI7DQo+ICsJ
CQkJfTsNCg0KPiANCj4gUm9iDQo=
