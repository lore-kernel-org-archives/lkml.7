Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DBAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AA12177E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OpmYU5Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfC1JXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:23:47 -0400
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:30101
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfC1JXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++FRjzjkYFZsKM4HzAh50wAyzAa+1Twk4SO6nO9zpUk=;
 b=OpmYU5VnI/dJDs4T2V7bLiOjw48CNQ5lQLGIOctMfCEvncwFyb61eo4+Cxg99JJdIXYCyysbqSW+5ATf20AAfW/GILiYpHUu//UVBoasyAhSGJ+t4FBf66dOxOZkLfdVtkkRJU8jWwKgtjc5T/FltYd6Tq7DZFXDfB4kikYOFEA=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3246.eurprd04.prod.outlook.com (10.170.229.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Thu, 28 Mar 2019 09:23:41 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::114f:6d7f:7a68:9b23]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::114f:6d7f:7a68:9b23%2]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 09:23:41 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Igor Plyatov <plyatov@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: Issues with i.MX SPI DMA transfers
Thread-Topic: Issues with i.MX SPI DMA transfers
Thread-Index: AQHU5MQedyysM/Gs0UKoyWKgyiIok6YgnCuAgAADPICAACYCkA==
Date:   Thu, 28 Mar 2019 09:23:41 +0000
Message-ID: <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
In-Reply-To: <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d83d81c-2cbe-46e4-1ec6-08d6b35f1191
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(49563074)(7193020);SRVR:VI1PR04MB3246;
x-ms-traffictypediagnostic: VI1PR04MB3246:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB324646E945A41ADC548E6DBB89590@VI1PR04MB3246.eurprd04.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(136003)(396003)(13464003)(31014005)(199004)(189003)(74316002)(8676002)(105586002)(316002)(99936001)(5024004)(106356001)(256004)(229853002)(486006)(186003)(86362001)(97736004)(52536014)(53546011)(6436002)(6306002)(305945005)(9686003)(71200400001)(14454004)(11346002)(110136005)(476003)(54906003)(8936002)(446003)(478600001)(76176011)(6246003)(102836004)(6506007)(2906002)(99286004)(7696005)(66574012)(3846002)(7416002)(68736007)(966005)(53936002)(6116002)(71190400001)(25786009)(5660300002)(55016002)(4326008)(26005)(33656002)(81156014)(7736002)(81166006)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3246;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f0aQyD9zANsM4JKvNYBCFiwoyYkEC4khE8MFLhFNc1Cix+CH/z5oHjdfrBvlnmjtE4XhrcVGZk0FzSTvVBNZwtwvpiSWMlbAdC9UbrGlJs1BamXVO2WjDo70wQM8kS6egG1fxcVNzFviP1iW1obCpxSaFbXUcfsaE8jgBs2ui2h7X0jHoJuYj0cu9DWP+NmQo5TN/YXtAxU4ipTJThYzDQW+ZME8gsuXdYb1HEdPpSWc3CaUBkxnKn2N+rymMgE/zmYcX9roPqIV96NUtDoLwdAqjBO0y4LsuCdgWg5J5/lk9ljJxIhl4h/Y2w6dnBdvOMHjnx4eetzJ+S52lXptzOjwQ/esTdF84t7FZY7JDrG/hJdzl71worFqz5tMwQzw4a9antWDktHWv8e4k8B7JgHGWQG/0T+8dLdZ9DNR/+g=
Content-Type: multipart/mixed;
        boundary="_003_VI1PR04MB45438E01D91829849A4E0BB289590VI1PR04MB4543eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d83d81c-2cbe-46e4-1ec6-08d6b35f1191
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 09:23:41.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_003_VI1PR04MB45438E01D91829849A4E0BB289590VI1PR04MB4543eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSWdvciwNCglQbGVhc2UgaGF2ZSBhIHRyeSB3aXRoIHRoZSBhdHRhY2hlZCBwYXRjaCwgYXNz
dW1lIHlvdSBoYXZlIGFscmVhZHkgdXNlZCB0aGUgc2RtYSBmaXJtd2FyZQ0KRnJvbSBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9maXJtd2FyZS9saW51eC1m
aXJtd2FyZS5naXQvdHJlZS9pbXgvc2RtYS9zZG1hLWlteDZxLmJpbg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJZ29yIFBseWF0b3YgPHBseWF0b3ZAZ21haWwuY29tPg0K
PiBTZW50OiAyMDE55bm0M+aciDI45pelIDE1OjA0DQo+IFRvOiBVd2UgS2xlaW5lLUvDtm5pZyA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51
eC1zcGlAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsg
RmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgUGVuZ3V0cm9uaXggS2VybmVs
IFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47DQo+IFNhc2NoYSBIYXVlciA8cy5oYXVlckBw
ZW5ndXRyb25peC5kZT47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVsLm9yZz47IE1hcmsg
QnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7
IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+OyBEYW4gV2lsbGlhbXMNCj4gPGRhbi5qLndp
bGxpYW1zQGludGVsLmNvbT47IEFuZHkgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT47IEhhbiBY
dQ0KPiA8aGFuLnh1QG54cC5jb20+OyBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+OyBD
bGFyayBXYW5nDQo+IDx4aWFvbmluZy53YW5nQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBJc3N1
ZXMgd2l0aCBpLk1YIFNQSSBETUEgdHJhbnNmZXJzDQo+IA0KPiBEZWFyIFV3ZSwNCj4gDQo+IA0K
PiA+IEhlbGxvIElnb3IsDQo+ID4NCj4gPiBPbiBXZWQsIE1hciAyNywgMjAxOSBhdCAwODo0MDow
MFBNICswMzAwLCBJZ29yIFBseWF0b3Ygd3JvdGU6DQo+ID4+IHBsZWFzZSwgaGVscCB0byByZXNv
bHZlIHR3byBpc3N1ZXMgd2l0aCBTUEkgRE1BIHRyYW5zZmVycyBhdCBpLk1YNlENCj4gPj4gcGxh
dGZvcm0uDQo+ID4+DQo+ID4+IEZpcnN0IGlzc3VlIGlzDQo+ID4+ICDCoFsgNDQ2NS4wMDgwMDNd
IHNwaV9tYXN0ZXIgc3BpMDogSS9PIEVycm9yIGluIERNQSBSWA0KPiA+Pg0KPiA+PiBTZWNvbmQg
aXNzdWUgaXMgZHVwbGljYXRpb24gZm9yIG9uZSBvZiByZWNlaXZlZCBieXRlcy4NCj4gPj4NCj4g
Pj4gUHJvYmFibHksIHRoZXNlIGlzc3VlcyByZWxhdGVkIHRvIGVhY2ggb25lLg0KPiA+IFRoaXMg
aXMgcHJvYmFibHkgdGhlIHNhbWUgcHJvYmxlbSBJIGhpdCBzb21lIHRpbWUgYWdvLiBDaGVjayBF
UlIwMDkxNjUNCj4gPiBpbiB0aGUgZXJyYXRhLiBZb3UgZWl0aGVyIG5lZWQgdG8gZGlzYWJsZSBE
TUEgb3IgbmVlZCBhIGZpeGVkDQo+ID4gc2RtYS1TY3JpcHQuDQo+IA0KPiBkaXNhYmxpbmcgb2Yg
RE1BIGlzIG5vdCBhbiBvcHRpb24sIGJlY2F1c2UgaGlnaCB0aHJvdWdocHV0IHJlcXVpcmVkIGZv
ciBTUEkgYnVzDQo+IHRvIGNvbW11bmljYXRlIHdpdGggRFNQcy4NCj4gDQo+IEknbSBhd2FyZSBv
ZiBFUlIwMDkxNjUsIGJ1dCBhcyBJIHdyaXRlIHNvbWUgbWludXRlcyBlYXJsaWVyIHRvIGxpc3Qs
DQo+IHNwaTAgKGFsaWFzIGZvciBlY3NwaTEpIGFuZCBzcGkxIChhbGlhcyBmb3IgZWNzcGkyKSB3
b3JrIGZsYXdsZXNzLCB3aGlsZQ0KPiBzcGk0IChhbGlhcyBmb3IgZWNzcGk1KSBmYWlscyB2ZXJ5
IGZhc3QuDQo+IA0KPiBEb2VzIHNhbWUgU0RNQSBzY3JpcHQgdXNlZCBmb3IgYWxsIFNQSSBpbnRl
cmZhY2VzIG9yIHNjcmlwdHMgYXJlIGRpZmZlcmVudD8NCj4gDQo+IEJlc3Qgd2lzaGVzLg0KPiAN
Cj4gLS0NCj4gDQo+IElnb3IgUGx5YXRvdg0KDQo=

--_003_VI1PR04MB45438E01D91829849A4E0BB289590VI1PR04MB4543eurp_
Content-Type: application/octet-stream;
	name="0001-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch"
Content-Description: 0001-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch
Content-Disposition: attachment;
	filename="0001-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch"; size=1369;
	creation-date="Thu, 28 Mar 2019 09:21:10 GMT";
	modification-date="Thu, 28 Mar 2019 09:21:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjZWRkN2FlY2U2YTM1NjZmNjFlMzljYmVlOWNlZWFlYTNmMzRjZmQxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+CkRhdGU6
IFRodSwgMjggTWFyIDIwMTkgMTY6MzY6MTIgKzA4MDAKU3ViamVjdDogW1BBVENIIDEvMl0gZG1h
OiBlbmdpbmU6IGlteC1zZG1hOiBhZGQgbWN1XzJfZWNzcGkgc2NyaXB0CgpBZGQgbWN1XzJfZWNz
cGkgc2NyaXB0IHRvIGZpeCBlY3NwaSBlcnJhdGEgRVJSMDA5MTY1LgoKU2lnbmVkLW9mZi1ieTog
Um9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPgotLS0KIGRyaXZlcnMvZG1hL2lteC1zZG1h
LmMgICAgICAgICAgICAgICAgICAgICB8IDMgKysrCiBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2Rh
dGEvZG1hLWlteC1zZG1hLmggfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1z
ZG1hLmMKaW5kZXggN2ZhZTRiZi4uMWYxY2U3YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9kbWEvaW14
LXNkbWEuYworKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jCkBAIC05MDgsNiArOTA4LDkgQEAg
c3RhdGljIHZvaWQgc2RtYV9nZXRfcGMoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMsCiAJCWVt
aV8yX3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+bWN1XzJfYXRhX2FkZHI7CiAJCWJyZWFrOwog
CWNhc2UgSU1YX0RNQVRZUEVfQ1NQSToKKwkJcGVyXzJfZW1pID0gc2RtYS0+c2NyaXB0X2FkZHJz
LT5hcHBfMl9tY3VfYWRkcjsKKwkJZW1pXzJfcGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5tY3Vf
Ml9lY3NwaV9hZGRyOworCQlicmVhazsKIAljYXNlIElNWF9ETUFUWVBFX0VYVDoKIAljYXNlIElN
WF9ETUFUWVBFX1NTSToKIAljYXNlIElNWF9ETUFUWVBFX1NBSToKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14LXNkbWEuaCBiL2luY2x1ZGUvbGludXgvcGxh
dGZvcm1fZGF0YS9kbWEtaW14LXNkbWEuaAppbmRleCA2ZWFhNTNjLi5mNzk0ZmVlIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmgKKysrIGIvaW5j
bHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2RtYS1pbXgtc2RtYS5oCkBAIC01MSw2ICs1MSw3IEBA
IHN0cnVjdCBzZG1hX3NjcmlwdF9zdGFydF9hZGRycyB7CiAJLyogRW5kIG9mIHYyIGFycmF5ICov
CiAJczMyIHpjYW5mZF8yX21jdV9hZGRyOwogCXMzMiB6cXNwaV8yX21jdV9hZGRyOworCXMzMiBt
Y3VfMl9lY3NwaV9hZGRyOwogCS8qIEVuZCBvZiB2MyBhcnJheSAqLwogfTsKIAotLSAKMi43LjQK
Cg==

--_003_VI1PR04MB45438E01D91829849A4E0BB289590VI1PR04MB4543eurp_
Content-Type: application/octet-stream;
	name="0002-spi-spi-imx-fix-ERR009165.patch"
Content-Description: 0002-spi-spi-imx-fix-ERR009165.patch
Content-Disposition: attachment;
	filename="0002-spi-spi-imx-fix-ERR009165.patch"; size=1280;
	creation-date="Thu, 28 Mar 2019 09:21:10 GMT";
	modification-date="Thu, 28 Mar 2019 09:21:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkM2ZhMjRiMzdhZGNmYjM4NWE2ZTYwYjQxNGQ3NDg1YTUyOTUxYWNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+CkRhdGU6
IFRodSwgMjggTWFyIDIwMTkgMTY6Mzg6MTMgKzA4MDAKU3ViamVjdDogW1BBVENIIDIvMl0gc3Bp
OiBzcGktaW14OiBmaXggRVJSMDA5MTY1CgpDaGFuZ2UgdG8gWENIICBtb2RlIGV2ZW4gaW4gZG1h
IG1vZGUsIHBsZWFzZSByZWZlciB0byBiZWxvdwplcnJhdGE6Cmh0dHBzOi8vd3d3Lm54cC5jb20v
ZG9jcy9lbi9lcnJhdGEvSU1YNkRRQ0UucGRmCgpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5
aWJpbi5nb25nQG54cC5jb20+Ci0tLQogZHJpdmVycy9zcGkvc3BpLWlteC5jIHwgNyArKy0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1pbXguYyBiL2RyaXZlcnMvc3BpL3NwaS1pbXguYwppbmRl
eCAwOWM5YTFlLi4yNzU3ODE1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3NwaS9zcGktaW14LmMKKysr
IGIvZHJpdmVycy9zcGkvc3BpLWlteC5jCkBAIC01ODUsOCArNTg1LDkgQEAgc3RhdGljIGludCBt
eDUxX2Vjc3BpX3ByZXBhcmVfdHJhbnNmZXIoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwK
IAljdHJsIHw9IG14NTFfZWNzcGlfY2xrZGl2KHNwaV9pbXgsIHQtPnNwZWVkX2h6LCAmY2xrKTsK
IAlzcGlfaW14LT5zcGlfYnVzX2NsayA9IGNsazsKIAorCS8qIEVSUjAwOTE2NTogd29yayBpbiBY
SEMgbW9kZSBhcyBQSU8gKi8KIAlpZiAoc3BpX2lteC0+dXNlZG1hKQotCQljdHJsIHw9IE1YNTFf
RUNTUElfQ1RSTF9TTUM7CisJCWN0cmwgJj0gfk1YNTFfRUNTUElfQ1RSTF9TTUM7CiAKIAl3cml0
ZWwoY3RybCwgc3BpX2lteC0+YmFzZSArIE1YNTFfRUNTUElfQ1RSTCk7CiAKQEAgLTEyNjUsMTAg
KzEyNjYsNiBAQCBzdGF0aWMgaW50IHNwaV9pbXhfc2RtYV9pbml0KHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwKIHsKIAlpbnQgcmV0OwogCi0JLyogdXNl
IHBpbyBtb2RlIGZvciBpLm14NmRsIGNoaXAgVEtUMjM4Mjg1ICovCi0JaWYgKG9mX21hY2hpbmVf
aXNfY29tcGF0aWJsZSgiZnNsLGlteDZkbCIpKQotCQlyZXR1cm4gMDsKLQogCXNwaV9pbXgtPndt
bCA9IHNwaV9pbXgtPmRldnR5cGVfZGF0YS0+Zmlmb19zaXplIC8gMjsKIAogCS8qIFByZXBhcmUg
Zm9yIFRYIERNQTogKi8KLS0gCjIuNy40Cgo=

--_003_VI1PR04MB45438E01D91829849A4E0BB289590VI1PR04MB4543eurp_--
