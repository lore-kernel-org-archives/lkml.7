Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016F0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B861A214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WYPw0pRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDDB3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:29:55 -0400
Received: from mail-eopbgr10078.outbound.protection.outlook.com ([40.107.1.78]:56994
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDDB3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmRqRs2Hhmk1hgQ+8vYpd4owEzNWYSUfznr/nTmwtbM=;
 b=WYPw0pRKH1OjbmuEhEd27nrgBGVLmI/eh7j1y0Zh8MShPCFoafT4uRohjHiWfalyQYgJUkvOEGPUGF6X1Gp0a89coZvp3+jmcy1pGkC7lQAsGTI1AZzRST354FFg5eYNJ3Nv4iVLuX6QrV7mQlklut2pBIJX1l283yYkHFnpNpE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Thu, 4 Apr 2019 01:29:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Thu, 4 Apr 2019
 01:29:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] input: keyboard: imx: no need to control interrupt
 status in event check
Thread-Topic: [PATCH 1/2] input: keyboard: imx: no need to control interrupt
 status in event check
Thread-Index: AQHU5f0glAeb6buLqE2+JexOYz88t6YrAgcAgAA8lzA=
Date:   Thu, 4 Apr 2019 01:29:48 +0000
Message-ID: <DB3PR0402MB3916E8CFA62672094C7DC020F5500@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1553842562-8481-1-git-send-email-Anson.Huang@nxp.com>
 <20190403214842.GD53104@dtor-ws>
In-Reply-To: <20190403214842.GD53104@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 177e3c31-c9ec-49ae-4782-08d6b89d076a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB3929873A914944606FE1E8FDF5500@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(13464003)(199004)(189003)(305945005)(8936002)(1361003)(486006)(54906003)(316002)(2906002)(6436002)(99286004)(5640700003)(5660300002)(7736002)(33656002)(52536014)(74316002)(476003)(102836004)(53546011)(106356001)(186003)(229853002)(105586002)(2351001)(25786009)(11346002)(446003)(2501003)(7696005)(26005)(256004)(76176011)(81156014)(6246003)(53936002)(4326008)(9686003)(81166006)(44832011)(6506007)(8676002)(478600001)(97736004)(86362001)(14454004)(3846002)(6116002)(6916009)(55016002)(71190400001)(68736007)(71200400001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EG+tCviKPRXE6ScRMqWAbLV8dgzo6/Fs4oYk9M+8RTguwS3xfFNK2dceN7OKkjgXbTIBAeCeZ9gfvLivELznjS3306dG82h2IiyOhOnJalFsh6HGsf4jivv7lki13scrxzBHffhVZw5LZPG/CuH8jT6Qgxz7bcpTVjQXbF38xhgJrQoKjtyEjPsQZPt0TYQOUr47lCvEtj/tFUiMSukj7m774km7e4eSQFa2dV7oP6Pi1eI7ToU2WY8WjZJl1DdPIlFqBdbawT97ZLcVKlcZvKGPuZW9WGruhMkKs5+oeyWGucYeqR20HTgAobKDk1s7FS6Q4yGemuU4/KmN0r+YKj97dj7ICxuEfV5Nd0XzXVsLjwPGLdL5lmdWF2/IgnUwMVDc7JV73vkhFUWERRLRyNMTK5koPU6Q29Bjl/gWlOA=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177e3c31-c9ec-49ae-4782-08d6b89d076a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 01:29:48.9482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERtaXRyeQ0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20gW21haWx0
bzpkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tXQ0KPiBTZW50OiAyMDE5xOo01MI0yNUgNTo0OQ0K
PiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXgu
ZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGRsLWxpbnV4LQ0KPiBpbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDEvMl0gaW5wdXQ6IGtleWJvYXJkOiBpbXg6IG5vIG5lZWQgdG8gY29udHJv
bCBpbnRlcnJ1cHQNCj4gc3RhdHVzIGluIGV2ZW50IGNoZWNrDQo+IA0KPiBIaSBBbnNvbiwNCj4g
DQo+IE9uIEZyaSwgTWFyIDI5LCAyMDE5IGF0IDA3OjAwOjQzQU0gKzAwMDAsIEFuc29uIEh1YW5n
IHdyb3RlOg0KPiA+IFRoZXJlIGlzIG5vIG5lZWQgdG8gZW5hYmxlIHJlbGVhc2UgaW50ZXJydXB0
IGFuZCBkaXNhYmxlIGRlcHJlc3MNCj4gPiBpbnRlcnJ1cHQgaW4gZXZlbnQgY2hlY2ssIGFzIGEg
dGltZXIgaXMgc2V0dXAgZm9yIGNoZWNraW5nIHRoZXNlDQo+ID4gZXZlbnRzIHJhdGhlciB0aGFu
IGludGVycnVwdHMuDQo+IA0KPiBCdXQgd29uJ3QgdXNpbmcgcmVsZWFzZSBpbnRlcnJ1cHQgYWxs
b3cgc2lnbmFsbGluZyBrZXkgcmVsZWFzZSBlYXJsaWVyPw0KDQpJdCBtYWtlcyBzZW5zZSwgcGF0
Y2ggIzEgY2FuIGJlIGRyb3BwZWQsIEkgd2lsbCByZXNlbmQgdGhlIHBhdGNoICMyIGZvciByZXZp
ZXcuDQoNClRoYW5rcywNCkFuc29uLg0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5z
b24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW5w
dXQva2V5Ym9hcmQvaW14X2tleXBhZC5jIHwgNSAtLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJv
YXJkL2lteF9rZXlwYWQuYw0KPiA+IGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9pbXhfa2V5cGFk
LmMNCj4gPiBpbmRleCA1MzljYjY3Li43ZTMyYzM2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
aW5wdXQva2V5Ym9hcmQvaW14X2tleXBhZC5jDQo+ID4gKysrIGIvZHJpdmVycy9pbnB1dC9rZXli
b2FyZC9pbXhfa2V5cGFkLmMNCj4gPiBAQCAtMjc2LDExICsyNzYsNiBAQCBzdGF0aWMgdm9pZCBp
bXhfa2V5cGFkX2NoZWNrX2Zvcl9ldmVudHMoc3RydWN0DQo+IHRpbWVyX2xpc3QgKnQpDQo+ID4g
IAkJcmVnX3ZhbCA9IHJlYWR3KGtleXBhZC0+bW1pb19iYXNlICsgS1BTUik7DQo+ID4gIAkJcmVn
X3ZhbCB8PSBLQkRfU1RBVF9LUEtSIHwgS0JEX1NUQVRfS1JTUzsNCj4gPiAgCQl3cml0ZXcocmVn
X3ZhbCwga2V5cGFkLT5tbWlvX2Jhc2UgKyBLUFNSKTsNCj4gPiAtDQo+ID4gLQkJcmVnX3ZhbCA9
IHJlYWR3KGtleXBhZC0+bW1pb19iYXNlICsgS1BTUik7DQo+ID4gLQkJcmVnX3ZhbCB8PSBLQkRf
U1RBVF9LUklFOw0KPiA+IC0JCXJlZ192YWwgJj0gfktCRF9TVEFUX0tESUU7DQo+ID4gLQkJd3Jp
dGV3KHJlZ192YWwsIGtleXBhZC0+bW1pb19iYXNlICsgS1BTUik7DQo+ID4gIAl9DQo+ID4gIH0N
Cj4gPg0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0KPiANCj4gVGhhbmtzLg0KPiANCj4gLS0NCj4g
RG1pdHJ5DQo=
