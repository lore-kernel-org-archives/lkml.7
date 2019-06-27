Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F7C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B90620665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iatkcrjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfF0Asb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:48:31 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:19936
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbfF0As2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwmSDdNmX4wepY6JoJZmubKfzNFEHYtW6KdWw5XpZ6g=;
 b=iatkcrjvttC+FJ/lHgHFOKaNyuXtSMoAJtaR8eD8REcUld2TVa8xmnf1Ss4BcKPExQZMBKaKi4Odo3DbyIAwBX5KwSmTTtk3XamNChO2mLBoSDSGiuG92IOtAfJBG05fbqa/X1Jl8P9qGDf/5IGvRLRfd6DdVOvo/XFXptdCGDU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3914.eurprd04.prod.outlook.com (52.134.71.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 00:48:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 00:48:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH] soc: imx-scu: Add SoC UID(unique identifier) support
Thread-Topic: [PATCH] soc: imx-scu: Add SoC UID(unique identifier) support
Thread-Index: AQHVK+2BIBe0XayoFkyLTDr8gJYgQqat4TYAgADJtNA=
Date:   Thu, 27 Jun 2019 00:48:22 +0000
Message-ID: <DB3PR0402MB3916A4093CFB363B51523AA7F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190626070706.24930-1-Anson.Huang@nxp.com>
 <CAEnQRZBsT=KY3-Gk8p1byJOqx1_y_EX-KqiBs6WnroWkT5oe_Q@mail.gmail.com>
In-Reply-To: <CAEnQRZBsT=KY3-Gk8p1byJOqx1_y_EX-KqiBs6WnroWkT5oe_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a8cc862-0c94-4c60-f182-08d6fa992817
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3914;
x-ms-traffictypediagnostic: DB3PR0402MB3914:
x-microsoft-antispam-prvs: <DB3PR0402MB3914CFCD446B0A6BBCD7E3C4F5FD0@DB3PR0402MB3914.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(13464003)(199004)(189003)(52536014)(7696005)(71200400001)(5660300002)(66556008)(4326008)(76176011)(64756008)(53546011)(53936002)(73956011)(66446008)(55016002)(6436002)(14454004)(68736007)(229853002)(26005)(6506007)(66946007)(25786009)(7736002)(6246003)(66476007)(9686003)(74316002)(305945005)(99286004)(102836004)(478600001)(76116006)(66066001)(2906002)(6116002)(54906003)(8936002)(6916009)(86362001)(11346002)(8676002)(186003)(33656002)(486006)(316002)(44832011)(81166006)(446003)(71190400001)(476003)(81156014)(3846002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3914;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 04gtP1sBHQqE6AzyJYO0unrSzbtefpGomM9Sb6JbNE7hd8r/xHMbDfipF8L7yfaNT1DnwRwVigU0o076xYGUOw529QXlZjrfZxUIrAIW1GwQJKfG0SI4hZlwqh3tQ6itohk8ZnprfuvrttPDWuieW9R+nRZ7nHrTgr5fbntNiQdYVCnWFIfa2oSD/mCmiDyh87e33Jqhx3L6Bloo1POBWeB6eHijz/ElDZBY+UD20F/NtIjn8OqQ/Dz5+Cm2qrKPmh8AxDOedT5fWyBHSMXx/lxsxdrQn5BbCsVU+nhbjdDBNNLpdJGhEMub+HUhGajDmcKCQaSXaa6DOUrbzH/MQBk3Uqi2W11HYcu70kOax1BuGBDtnLMB5tCYfQFBMsuy+939iz6Miok5bRFhUZZsBBzQbCeJz+9HTszhOrLw0Sg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8cc862-0c94-4c60-f182-08d6fa992817
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 00:48:22.7742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3914
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1
bmUgMjYsIDIwMTkgODo0MiBQTQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5j
b20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIN
Cj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8
a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29t
PjsgQWlzaGVuZw0KPiBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEFiZWwgVmVzYSA8YWJl
bC52ZXNhQG54cC5jb20+OyBsaW51eC0NCj4gYXJtLWtlcm5lbCA8bGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz47IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+
OyBEYW5pZWwNCj4gQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIHNvYzogaW14LXNjdTogQWRkIFNvQyBVSUQodW5pcXVlIGlkZW50aWZpZXIpIHN1
cHBvcnQNCj4gDQo+IE9uIFdlZCwgSnVuIDI2LCAyMDE5IGF0IDEwOjA2IEFNIDxBbnNvbi5IdWFu
Z0BueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KPiA+DQo+ID4gQWRkIGkuTVggU0NVIFNvQydzIFVJRCh1bmlxdWUgaWRlbnRp
Zmllcikgc3VwcG9ydCwgdXNlciBjYW4gcmVhZCBpdA0KPiA+IGZyb20gc3lzZnM6DQo+ID4NCj4g
PiByb290QGlteDhxeHBtZWs6fiMgY2F0IC9zeXMvZGV2aWNlcy9zb2MwL3NvY191aWQNCj4gPiA3
QjY0MjgwQjU3QUMxODk4DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvaW14L3NvYy1pbXgt
c2N1LmMgfCAzNQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1LmMNCj4gPiBiL2RyaXZlcnMvc29jL2lteC9zb2Mt
aW14LXNjdS5jIGluZGV4IDY3NmY2MTIuLjhkMzIyYTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9zb2MvaW14L3NvYy1pbXgtc2N1LmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9pbXgvc29jLWlt
eC1zY3UuYw0KPiA+IEBAIC0yNyw2ICsyNywzNiBAQCBzdHJ1Y3QgaW14X3NjX21zZ19taXNjX2dl
dF9zb2NfaWQgew0KPiA+ICAgICAgICAgfSBkYXRhOw0KPiA+ICB9IF9fcGFja2VkOw0KPiA+DQo+
ID4gK3N0cnVjdCBpbXhfc2NfbXNnX21pc2NfZ2V0X3NvY191aWQgew0KPiA+ICsgICAgICAgc3Ry
dWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCj4gPiArICAgICAgIHUzMiB1aWRfbG93Ow0KPiA+ICsg
ICAgICAgdTMyIHVpZF9oaWdoOw0KPiA+ICt9IF9fcGFja2VkOw0KPiA+ICsNCj4gPiArc3RhdGlj
IHNzaXplX3Qgc29jX3VpZF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1
ZikNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IGlteF9zY19tc2dfbWlzY19nZXRfc29jX3Vp
ZCBtc2c7DQo+ID4gKyAgICAgICBzdHJ1Y3QgaW14X3NjX3JwY19tc2cgKmhkciA9ICZtc2cuaGRy
Ow0KPiA+ICsgICAgICAgdTY0IHNvY191aWQ7DQo+ID4gKw0KPiA+ICsgICAgICAgaGRyLT52ZXIg
PSBJTVhfU0NfUlBDX1ZFUlNJT047DQo+ID4gKyAgICAgICBoZHItPnN2YyA9IElNWF9TQ19SUENf
U1ZDX01JU0M7DQo+ID4gKyAgICAgICBoZHItPmZ1bmMgPSBJTVhfU0NfTUlTQ19GVU5DX1VOSVFV
RV9JRDsNCj4gPiArICAgICAgIGhkci0+c2l6ZSA9IDE7DQo+ID4gKw0KPiA+ICsgICAgICAgLyog
dGhlIHJldHVybiB2YWx1ZSBvZiBTQ1UgRlcgaXMgaW4gY29ycmVjdCwgc2tpcCByZXR1cm4gdmFs
dWUNCj4gPiArIGNoZWNrICovDQo+IA0KPiBXaHkgZG8geW91IG1lYW4gYnkgImluIGNvcnJlY3Qi
Pw0KDQpJIG1hZGUgYSBtaXN0YWtlLCBpdCBzaG91bGQgYmUgImluY29ycmVjdCIsIHRoZSBleGlz
dGluZyBTQ0ZXIG9mIHRoaXMgQVBJIHJldHVybnMNCmFuIGVycm9yIHZhbHVlIGV2ZW4gdGhpcyBB
UEkgaXMgc3VjY2Vzc2Z1bGx5IGNhbGxlZCwgdG8gbWFrZSBpdCB3b3JrIHdpdGggY3VycmVudA0K
U0NGVywgSSBoYXZlIHRvIHNraXAgdGhlIHJldHVybiB2YWx1ZSBjaGVjayBmb3IgdGhpcyBBUEkg
Zm9yIG5vdy4gV2lsbCBzZW5kIFYyIHBhdGNoDQp0byBmaXggdGhpcyB0eXBvLg0KDQo+ID4gKyAg
ICAgICBpbXhfc2N1X2NhbGxfcnBjKHNvY19pcGNfaGFuZGxlLCAmbXNnLCB0cnVlKTsNCj4gPiAr
DQo+ID4gKyAgICAgICBzb2NfdWlkID0gbXNnLnVpZF9oaWdoOw0KPiA+ICsgICAgICAgc29jX3Vp
ZCA8PD0gMzI7DQo+ID4gKyAgICAgICBzb2NfdWlkIHw9IG1zZy51aWRfbG93Ow0KPiA+ICsNCj4g
PiArICAgICAgIHJldHVybiBzcHJpbnRmKGJ1ZiwgIiUwMTZsbFhcbiIsIHNvY191aWQpOw0KPiAN
Cj4gc25wcmludGY/DQoNClRoZSBzbnByaW50ZiBpcyB0byBhdm9pZCBidWZmZXIgb3ZlcmZsb3cs
IHdoaWNoIGluIHRoaXMgY2FzZSwgSSBkb24ndCBrbm93IHRoZSBzaXplDQpvZiAiYnVmIiwgYW5k
IHRoZSB2YWx1ZSh1NjQpIHRvIGJlIHByaW50ZWQgaXMgd2l0aCBmaXhlZCBsZW5ndGggb2YgNjQs
IHNvIEkgdGhpbmsNCnNwcmludCBpcyBqdXN0IE9LLg0KDQpBbnNvbi4NCj4gDQo+ID4gK30NCj4g
PiArDQo+ID4gK3N0YXRpYyBERVZJQ0VfQVRUUl9STyhzb2NfdWlkKTsNCj4gPiArDQo+ID4gIHN0
YXRpYyBpbnQgaW14X3NjdV9zb2NfaWQodm9pZCkNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0
IGlteF9zY19tc2dfbWlzY19nZXRfc29jX2lkIG1zZzsgQEAgLTEwMiw2ICsxMzIsMTEgQEANCj4g
PiBzdGF0aWMgaW50IGlteF9zY3Vfc29jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9yZXZpc2lvbjsNCj4gPiAgICAgICAg
IH0NCj4gPg0KPiA+ICsgICAgICAgcmV0ID0gZGV2aWNlX2NyZWF0ZV9maWxlKHNvY19kZXZpY2Vf
dG9fZGV2aWNlKHNvY19kZXYpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZkZXZfYXR0cl9zb2NfdWlkKTsNCj4gPiArICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAg
ICAgICAgIGdvdG8gZnJlZV9yZXZpc2lvbjsNCj4gPiArDQo+ID4gICAgICAgICByZXR1cm4gMDsN
Cj4gPg0KPiA+ICBmcmVlX3JldmlzaW9uOg0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0K
