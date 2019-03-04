Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC103C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C6E206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ux/Lt4rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCDQp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:45:26 -0500
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:65252
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbfCDQpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPVKDzotxnau5cMVRYzM6ZayjH/n68NxrfEobssVCWI=;
 b=Ux/Lt4rgYvpj16FYEBZgE/oQzvIeKgxshKKDTGCYWbASgDNcUnbGXVPt40fWAccepN79wqVscJqmGDwSz24P5/3+/fYf5F1ycJD9jQh8nc+ZlCEzPwUJXp8Jz955/ixM7kByO9JovwWLlTcwOkC/XMCn8GiLcOdPOG9p+/BCjro=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2176.eurprd05.prod.outlook.com (10.169.134.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Mon, 4 Mar 2019 16:45:15 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 16:45:15 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>
Subject: RE: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to subdev
 devices
Thread-Topic: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to subdev
 devices
Thread-Index: AQHUz/EC2njdeQVegE6Mw8pbS3FanaX3V7gAgARaAXA=
Date:   Mon, 4 Mar 2019 16:45:15 +0000
Message-ID: <VI1PR0501MB2271C2252F577D77D9E7D2D3D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
         <1551418672-12822-9-git-send-email-parav@mellanox.com>
 <b4d8f1f9b53f589e2e60c9aa8bc677ac38144987.camel@mellanox.com>
In-Reply-To: <b4d8f1f9b53f589e2e60c9aa8bc677ac38144987.camel@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70d7d89e-d28d-4652-1648-08d6a0c0c71a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2176;
x-ms-traffictypediagnostic: VI1PR0501MB2176:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA1MDFNQjIxNzY7MjM6WnpOWGRyYmJrbWsvU3NONFd0a2l6WDdY?=
 =?utf-8?B?OGZZYUwrRHF6NThXUmo5LzBFRTRPYVlUcVd0OUVJWTlicC91MjRCL3JCdUxy?=
 =?utf-8?B?WHhQSG9lSUJHMitQcnJRbS9xR3AwTXM5SCsyNVN3eVkyK2JRRGZoN1NCY0hL?=
 =?utf-8?B?dytyZXZ6dEg4aXQvTnlXbWc4azE4YVZobHZrYmlVb0poZTc3ODZ3VWQ4cjdD?=
 =?utf-8?B?L05pR2VOMHJvM1pzdE5paFh0NWVyeDAwNFJvcng5SWtWMjlnNDEvbUZsOC9i?=
 =?utf-8?B?c1VJM1dlQU50NFZQUzJObC9zTmg1c3NDZjQrLy82R21TK0k5Y3hYUFZrcFlN?=
 =?utf-8?B?N1NhY2h6dlFMbERwaUtleDBVcU1EdjhSd2FxRFVMdGdwanlXSlgxMEwzWVJ1?=
 =?utf-8?B?ZWtLRTA0NnM5U0QwYjlMWlBob2lWVUNNdzB3QkRmOGhBalh6RkpoZzRvZHNN?=
 =?utf-8?B?Um1RWEl1VGRYTlh6T3BKZGRYOGxvaU1xSzdMUWlPNHF0eHhSeTJwMFhxMkk5?=
 =?utf-8?B?N2c5bUZ3VWFpNUs4R0xVYkN3SGVRSmd6eXRueDZwRmd3UmRHdkJBRCs5RmNt?=
 =?utf-8?B?cklHVmJEQXlmT25EVFdrRWxjS2dwNFZ2dDBqb054WDJ3RzUzRUI4ajZ2eVZk?=
 =?utf-8?B?bytGeFd2aGhBNG9IT2UySzR3a1B1eWRMUEJzVTd5cUdpbFBDK2tyUTVtSy8v?=
 =?utf-8?B?NHdUeksyNUlFZnNuSEF2ODFYZTNwUWhnQlVNK3hRaTA0b2tLN3dWc3lsdTFB?=
 =?utf-8?B?NEZsaDRQeHhnNW5WWkxSZTBpdzN5Vk5QZGYyWEp0TzNPL1BuaExJVnRuTUxm?=
 =?utf-8?B?czFRcS9BbmxNRVFYaDNqYTFXT3E1alB6ZGxPcHFqc0NEcUN2cWkzSys2LzY2?=
 =?utf-8?B?NjlVNkRUdFh0ME44aUZEL1FLNmZURk1Md0JEdUpYNEFiWkRzdVlwNWIvUm5T?=
 =?utf-8?B?QW5XVmNia1kyRWI4RWwyNE1PVVl1aGk2clZ1M3I4d2NiOVY4NWhlSnNLOWtN?=
 =?utf-8?B?Tk1MbjBDV2I4dnp0L3hnMXFUeWphTmpEVkh4bHlzU1FmMnlLbU1OZm5lNkZR?=
 =?utf-8?B?d3dacVkwMlZva0hGZnZtVXdiSFFvOXd5MEZNSEJGT0RrTmt5bmJ1UGVXU3dk?=
 =?utf-8?B?SitxanZhNXFGMnd3eFZBZVpjajh0V2xqaFFUNVJ6ZlkxcVZwN2lkR3dyU0dy?=
 =?utf-8?B?L280SDZSVDRPTWpNSUhucncyOERZaTdBWHpwTE1MUjFETXA2c0lYVVpFYWh6?=
 =?utf-8?B?aFZSRmJRVHIvUkZMM09QY3hWaTdPZ1pHcVVLbVJnL2hEZ2R0eWhxMHd6cWVP?=
 =?utf-8?B?VGRQSno2M3MrTmlteFZaMVZrMmZNMGQ3MDJydTNoQ1BSYzhvckMvZGVuWWJI?=
 =?utf-8?B?Q1BCZmwxSisxOUM2OUpBZW1tR0hmbHA1QkJqMDBnZjRYOStFT29JUmQrTUVB?=
 =?utf-8?B?bDZ0MDF4YWZvWXhmY1MxNTlTekpxOUdlWWs2bEhVeUZFNzhzTmlkTTdLME10?=
 =?utf-8?B?bk9NNVBqZ2NpMmJDcm1LWkE2QU9JQkVGNGVFdEtrcVRHZGRBWWRqSTFKUWM0?=
 =?utf-8?B?YzJDTmhEWnhVamtpSjZiNEppek9nSk5NbnBQbkxkb09BQ0hoQnIvOTRRQ2VL?=
 =?utf-8?B?OVZZNHVrTncxTVVyL0g1dVljN081QkNQWEptVVdiMWxSakQ5Zlc5eG5XdWp6?=
 =?utf-8?Q?78u/9YRiL8+tbZMc+ebp3jw2hmj0EsFWc1qgI63vw?=
x-microsoft-antispam-prvs: <VI1PR0501MB21769AAE010A4E245F3F4CB2D1710@VI1PR0501MB2176.eurprd05.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(376002)(136003)(199004)(189003)(13464003)(99286004)(106356001)(5660300002)(2201001)(2501003)(6436002)(8936002)(26005)(105586002)(229853002)(52536013)(6246003)(97736004)(7736002)(14454004)(476003)(316002)(102836004)(2906002)(305945005)(9686003)(55016002)(68736007)(86362001)(486006)(478600001)(256004)(8676002)(53546011)(6506007)(71200400001)(71190400001)(110136005)(76176011)(11346002)(446003)(66066001)(186003)(74316002)(25786009)(6116002)(14444005)(7696005)(53936002)(33656002)(81156014)(81166006)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2176;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oE6yqLlSvyyke1HQ4Jli2VXXJtPvZYkBtaI9HI//eAwYltefxFB7bGcoS6fjf/tD3UiqVMePI73LDYrppPDc3NUrZoXzNYFQpnmjUGi+7Aaqv/GHjJlPXcHoDckVFZVEB75IKGda/A7TPi8DRpsA59CytLBQdq9cIuKBbPLqzWbBq2Lm+YXue7Hohp3s7Yz59bJuhRI0J1IUPrCMxUdXJlvJDGWUYTMCzfSnQp0yDXr1aTu3Avf5gZ2fFXD6e/vvPyOmssYQ2m0Lk0NhBciSPJd+l/IWHKlK2CwOnr+myOfEmsPl6wpB81vs9jsHdt2oj999jYmHKGyGcaOxmVyYpPoHIhmtA7/dpyFmkuOmuBzsgNiZr/GyaSCmbIyzkWt0kNrGfTmaQChuJcogc/yqIBbOVMjyCCT7mCBjLXB5V4o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d7d89e-d28d-4652-1648-08d6a0c0c71a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 16:45:15.3453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2FlZWQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FlZWQg
TWFoYW1lZWQNCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxLCAyMDE5IDQ6MTIgUE0NCj4gVG86IEpp
cmkgUGlya28gPGppcmlAbWVsbGFub3guY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBhcmF2IFBhbmRpdCA8cGFyYXZAbWVsbGFu
b3guY29tPjsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc7DQo+IG1pY2hhbC5sa21sQG1hcmtvdmkubmV0DQo+IFN1YmplY3Q6IFJlOiBbUkZDIG5ldC1u
ZXh0IDgvOF0gbmV0L21seDU6IEFkZCBzdWJkZXYgZHJpdmVyIHRvIGJpbmQgdG8NCj4gc3ViZGV2
IGRldmljZXMNCj4gDQo+IE9uIFRodSwgMjAxOS0wMi0yOCBhdCAyMzozNyAtMDYwMCwgUGFyYXYg
UGFuZGl0IHdyb3RlOg0KPiA+IEFkZCBhIHN1YmRldiBkcml2ZXIgdG8gcHJvYmUgdGhlIHN1YmRl
diBkZXZpY2VzIGFuZCBjcmVhdGUgZmFrZQ0KPiA+IG5ldGRldmljZSBmb3IgaXQuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL01ha2VmaWxl
ICAgfCAgMiArLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUv
bWFpbi5jICAgICB8ICA4ICstDQo+ID4gIC4uLi9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9j
b3JlL21seDVfY29yZS5oICAgIHwgIDMgKw0KPiA+ICAuLi4vZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL3N1YmRldl9kcml2ZXIuYyAgICB8IDkzDQo+ID4gKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KSAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gv
bWx4NS9jb3JlL3N1YmRldl9kcml2ZXIuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9NYWtlZmlsZQ0KPiA+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL01ha2VmaWxlDQo+ID4gaW5kZXggZjIxODc4
OS4uYzhhZWFmMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5v
eC9tbHg1L2NvcmUvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxs
YW5veC9tbHg1L2NvcmUvTWFrZWZpbGUNCj4gPiBAQCAtMTYsNyArMTYsNyBAQCBtbHg1X2NvcmUt
eSA6PQltYWluLm8gY21kLm8gZGVidWdmcy5vIGZ3Lm8NCj4gPiBlcS5vIHVhci5vIHBhZ2VhbGxv
Yy5vIFwNCj4gPiAgCQl0cmFuc29iai5vIHZwb3J0Lm8gc3Jpb3YubyBmc19jbWQubyBmc19jb3Jl
Lm8gXA0KPiA+ICAJCWZzX2NvdW50ZXJzLm8gcmwubyBsYWcubyBkZXYubyBldmVudHMubyB3cS5v
IGxpYi9naWQubyBcDQo+ID4gIAkJbGliL2RldmNvbS5vIGRpYWcvZnNfdHJhY2Vwb2ludC5vIGRp
YWcvZndfdHJhY2VyLm8NCj4gPiAtbWx4NV9jb3JlLSQoQ09ORklHX1NVQkRFVikgKz0gc3ViZGV2
Lm8NCj4gPiArbWx4NV9jb3JlLSQoQ09ORklHX1NVQkRFVikgKz0gc3ViZGV2Lm8gc3ViZGV2X2Ry
aXZlci5vDQo+ID4NCj4gPiAgIw0KPiA+ICAjIE5ldGRldiBiYXNpYw0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbWFpbi5jDQo+ID4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbWFpbi5jDQo+ID4gaW5kZXgg
NWY4Y2YwZC4uN2RmYThjNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
ZWxsYW5veC9tbHg1L2NvcmUvbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NS9jb3JlL21haW4uYw0KPiA+IEBAIC0xNTQ4LDcgKzE1NDgsMTEgQEAgc3Rh
dGljIGludCBfX2luaXQgaW5pdCh2b2lkKQ0KPiA+ICAJbWx4NWVfaW5pdCgpOw0KPiA+ICAjZW5k
aWYNCj4gPg0KPiA+IC0JcmV0dXJuIDA7DQo+ID4gKwllcnIgPSBzdWJkZXZfcmVnaXN0ZXJfZHJp
dmVyKCZtbHg1X3N1YmRldl9kcml2ZXIpOw0KPiA+ICsJaWYgKGVycikNCj4gPiArCQlwY2lfdW5y
ZWdpc3Rlcl9kcml2ZXIoJm1seDVfY29yZV9kcml2ZXIpOw0KPiA+ICsNCj4gPiArCXJldHVybiBl
cnI7DQo+ID4NCj4gPiAgZXJyX2RlYnVnOg0KPiA+ICAJbWx4NV91bnJlZ2lzdGVyX2RlYnVnZnMo
KTsNCj4gPiBAQCAtMTU1Nyw2ICsxNTYxLDggQEAgc3RhdGljIGludCBfX2luaXQgaW5pdCh2b2lk
KQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIF9fZXhpdCBjbGVhbnVwKHZvaWQpDQo+ID4gIHsNCj4g
PiArCXN1YmRldl91bnJlZ2lzdGVyX2RyaXZlcigmbWx4NV9zdWJkZXZfZHJpdmVyKTsNCj4gPiAr
DQo+ID4gICNpZmRlZiBDT05GSUdfTUxYNV9DT1JFX0VODQo+ID4gIAltbHg1ZV9jbGVhbnVwKCk7
DQo+ID4gICNlbmRpZg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxs
YW5veC9tbHg1L2NvcmUvbWx4NV9jb3JlLmgNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21l
bGxhbm94L21seDUvY29yZS9tbHg1X2NvcmUuaA0KPiA+IGluZGV4IDJhNTQxNDguLjFiNzMzYzcg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3Jl
L21seDVfY29yZS5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL21seDVfY29yZS5oDQo+ID4gQEAgLTQxLDEyICs0MSwxNSBAQA0KPiA+ICAjaW5jbHVk
ZSA8bGludXgvcHRwX2Nsb2NrX2tlcm5lbC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbWx4NS9j
cS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbWx4NS9mcy5oPg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvc3ViZGV2X2J1cy5oPg0KPiA+DQo+ID4gICNkZWZpbmUgRFJJVkVSX05BTUUgIm1seDVfY29y
ZSINCj4gPiAgI2RlZmluZSBEUklWRVJfVkVSU0lPTiAiNS4wLTAiDQo+ID4NCj4gPiAgZXh0ZXJu
IHVpbnQgbWx4NV9jb3JlX2RlYnVnX21hc2s7DQo+ID4NCj4gPiArZXh0ZXJuIHN0cnVjdCBzdWJk
ZXZfZHJpdmVyIG1seDVfc3ViZGV2X2RyaXZlcjsNCj4gPiArDQo+ID4gICNkZWZpbmUgbWx4NV9j
b3JlX2RiZyhfX2RldiwgZm9ybWF0LCAuLi4pDQo+ID4gXA0KPiA+ICAJZGV2X2RiZygmKF9fZGV2
KS0+cGRldi0+ZGV2LCAiJXM6JWQ6KHBpZCAlZCk6ICIgZm9ybWF0LA0KPiANCj4gPiBcDQo+ID4g
IAkJIF9fZnVuY19fLCBfX0xJTkVfXywgY3VycmVudC0+cGlkLA0KPiA+IFwNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL3N1YmRldl9kcml2
ZXIuYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL3N1YmRl
dl9kcml2ZXIuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4u
ODgwYWE0Zg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tZWxsYW5veC9tbHg1L2NvcmUvc3ViZGV2X2RyaXZlci5jDQo+ID4gQEAgLTAsMCArMSw5MyBA
QA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsvLyBDb3B5
cmlnaHQgKGMpIDIwMTgtMTkgTWVsbGFub3ggVGVjaG5vbG9naWVzDQo+ID4gKw0KPiA+ICsjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5o
Pg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc3ViZGV2X2J1cy5oPg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvc3ViZGV2X2lkcy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZXRoZXJkZXZpY2UuaD4NCj4g
PiArDQo+ID4gK3N0cnVjdCBtbHg1X3N1YmRldl9uZGV2IHsNCj4gPiArCXN0cnVjdCBuZXRfZGV2
aWNlIG5kZXY7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBtbHg1X2RtYV90ZXN0
KHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+ICsJZG1hX2FkZHJfdCBwYTsNCj4gPiArCXZvaWQg
KnZhOw0KPiA+ICsNCj4gPiArCXZhID0gZG1hX2FsbG9jX2NvaGVyZW50KGRldiwgNDA5NiwgJnBh
LCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICh2YSkNCj4gPiArCQlkbWFfZnJlZV9jb2hlcmVudChk
ZXYsIDQwOTYsIHZhLCBwYSk7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgbmV0X2Rldmlj
ZSAqbmRldjsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbWx4NWVfc3ViZGV2X29wZW4oc3RydWN0
IG5ldF9kZXZpY2UgKm5ldGRldikgew0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyBpbnQgbWx4NWVfc3ViZGV2X2Nsb3NlKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRk
ZXYpIHsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgbmV0ZGV2
X3R4X3QNCj4gPiArbWx4NWVfc3ViZGV2X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0
IG5ldF9kZXZpY2UgKm5ldGRldikgew0KPiA+ICsJcmV0dXJuIE5FVERFVl9UWF9CVVNZOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtjb25zdCBzdHJ1Y3QgbmV0X2RldmljZV9vcHMgbWx4NWVfc3ViZGV2
X25ldGRldl9vcHMgPSB7DQo+ID4gKwkubmRvX29wZW4gICAgICAgICAgICAgICAgPSBtbHg1ZV9z
dWJkZXZfb3BlbiwNCj4gPiArCS5uZG9fc3RvcCAgICAgICAgICAgICAgICA9IG1seDVlX3N1YmRl
dl9jbG9zZSwNCj4gPiArCS5uZG9fc3RhcnRfeG1pdCAgICAgICAgICA9IG1seDVlX3N1YmRldl94
bWl0LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtbHg1X3N1YmRldl9wcm9iZShz
dHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPiArCWludCBlcnI7DQo+ID4gKw0KPiA+ICsJbWx4NV9k
bWFfdGVzdChkZXYpOw0KPiANCj4gSGkgUGFyYXYsIGNhbiB5b3UgcGxlYXNlIHNoZWQgc29tZSBs
aWdodCBvbiBob3cgZG8geW91IHBsYW4gdG8NCj4gY29tbXVuaWNhdGUgd2l0aCB0aGUgcGFyZW50
IGRldmljZSA/IChwY2lfZGV2IGFuZCBpdHMgcnVubmluZyBkcml2ZXINCj4gaW5zdGFuY2UpLCBX
ZSB3aWxsIG5lZWQgdG8gc2hhcmUgc29tZSByZXNvdXJjZXMsIHN1Y2ggYXMgSVJRcy9CQVJzL2V0
YyAuLiwNCj4gYW5kIG1heWJlIHNvbWUgSFcgb2JqZWN0cyB3aGljaCBhcmUgZ29pbmcgdG8gYmUg
bWFuYWdlZCBieSB0aGUgcGFyZW50DQo+IHBjaSBkZXZpY2UgZHJpdmVyLg0KPiANClNpbmNlIG1s
eDUgZHJpdmVyIHdvcmtzIG9uIGl0cyBwY2kgZGV2aWNlLCBpbiBtbHg1X3N1YmRldl9wcm9iZShz
dHJ1Y3QgZGV2aWNlICpkZXZpY2UpDQpkZXZpY2UtPnBhcmVudCBpcyBhIFBDSSBkZXZpY2UgZm9y
IGRyaXZlciB0byB1c2UuDQoNCj4gSnVzdCBhbGxvY2F0aW5nIGEgZG1hIGJ1ZmZlciBkb2Vzbid0
IG1lYW4gYW55dGhpbmcsIHRoZSBkbWEgYnVmZmVyIGlzIGp1c3QNCj4gYm91bmQgdG8gdGhlIGdl
bmVyaWMgZGV2aWNlLg0KPg0KDQpkbWEgYnVmZmVyIGFsbG9jYXRpb24gaXMganVzdCB0byBtYWtl
IHN1cmUgdGhhdCBzdGFjayBhbmQgY29yZSBhbmQgcmRtYSBVTFBzIGRtYSBhbGxvY2F0aW9ucyBp
biBzYW1lIHdheSBhcyBQQ0kgZGV2aWNlLg0KDQogPiA+ICsJLyogT25seSBvbmUgZGV2aWNlIHN1
cHBvcnRlZCBpbiByZmMgKi8NCj4gPiArCWlmIChuZGV2KQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+
ICsNCj4gPiArCW5kZXYgPSBhbGxvY19ldGhlcmRldl9tcXMoc2l6ZW9mKHN0cnVjdCBtbHg1X3N1
YmRldl9uZGV2KSwgMSwNCj4gPiAxKTsNCj4gPiArCWlmICghbmRldikNCj4gPiArCQlyZXR1cm4g
LUVOT01FTTsNCj4gPiArDQo+ID4gKwlTRVRfTkVUREVWX0RFVihuZGV2LCBkZXYpOw0KPiA+ICsJ
bmRldi0+bmV0ZGV2X29wcyA9ICZtbHg1ZV9zdWJkZXZfbmV0ZGV2X29wczsNCj4gPiArCWVyciA9
IHJlZ2lzdGVyX25ldGRldihuZGV2KTsNCj4gPiArCWlmIChlcnIpIHsNCj4gPiArCQlmcmVlX25l
dGRldihuZGV2KTsNCj4gPiArCQluZGV2ID0gTlVMTDsNCj4gPiArCX0NCj4gPiArCXJldHVybiBl
cnI7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbWx4NV9zdWJkZXZfcmVtb3ZlKHN0
cnVjdCBkZXZpY2UgKmRldikgew0KPiA+ICsJaWYgKG5kZXYpIHsNCj4gPiArCQl1bnJlZ2lzdGVy
X25ldGRldihuZGV2KTsNCj4gPiArCQlmcmVlX25ldGRldihuZGV2KTsNCj4gPiArCQluZGV2ID0g
TlVMTDsNCj4gPiArCX0NCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IHN1YmRldl9pZCBtbHg1X3N1YmRldl9pZF90YWJsZVtdID0gew0KPiA+
ICsJeyAudmVuZG9yX2lkID0gU1VCREVWX1ZFTkRPUl9JRF9NRUxMQU5PWCwNCj4gPiArCSAgLmRl
dmljZV9pZCA9IFNVQkRFVl9ERVZJQ0VfSURfTUVMTEFOT1hfU0YgfSwNCj4gPiArCXsgMCwgfQ0K
PiA+ICt9Ow0KPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKHN1YmRldiwgbWx4NV9zdWJkZXZfaWRf
dGFibGUpOw0KPiA+ICsNCj4gPiArc3RydWN0IHN1YmRldl9kcml2ZXIgbWx4NV9zdWJkZXZfZHJp
dmVyID0gew0KPiA+ICsJLmlkX3RhYmxlID0gbWx4NV9zdWJkZXZfaWRfdGFibGUsDQo+ID4gKwku
ZHJpdmVyLm5hbWUgPSAibWx4NV9zdWJkZXZfZHJpdmVyIiwNCj4gPiArCS5kcml2ZXIucHJvYmUg
PSBtbHg1X3N1YmRldl9wcm9iZSwNCj4gPiArCS5kcml2ZXIucmVtb3ZlID0gbWx4NV9zdWJkZXZf
cmVtb3ZlLCB9Ow0K
