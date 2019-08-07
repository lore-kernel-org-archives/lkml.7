Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03D9C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9817D2089E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p3Vjgl34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfHGDvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 23:51:06 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:9486
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfHGDvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:51:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljKRyQsFeXgWrh0hRPoTimmfYXP52VhyFKXEwoekFABkql08a2xikJx4UKmQbsQ0HPwBacryFvET8FHU3ARPXOQjNzEBrM0f6poPbxsTeZlakfmVex6BinjtDiqM+LbPWNcoCj9TubQI61EbslcajEiO1q/Y9lFejUl5ujPJWweoq25N4koU2BEIyalYuTdnxpdo6JMC6YRJERkp290Sf/GbKWRlq+jDevyDJAvMZEY9goQNMCPcz3e6Wcz63jj/nUaqfObXWMiQwXoUuSlGFTnWbTvb2QQnG8456fR/mekrY88D5QTSolnXOMNNz+sv6IRbmkJgNMz9Az1BtntB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9wrzZI82DzMVTeDchK+ngJ3YHiOkquQl2flpZnEh3Q=;
 b=Qonz/df+KGTtcjGGxsERWK0JgdX2wS8VEOVj8+F7kYZRdBOJuOXfM6sMm5u4gysdwJyEiVFQLjr/f5IGydRdjoYCy8OBn1db+f3fTl4AgGHvoUHHfX/lttClHq89HZPApuzMoyHWxpUAtAbl5vr01kxsenBYhpzbeWwZXqHtmLYQjQF6AwACva3uRx59tcLKXd11vY3H2F+mHrGHspqZcyBnnBhxa+acPNr6CNsW3fr5jbg9rWnXPEbwa2gGxY9FAWdkV/WSk+1WqjugZ6FNtNEFcOZr+GP4CNEFfpPmuxKP0H2IIVDaXv751OsOydgyQ2IqYEimesyyipzS8D3Hvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9wrzZI82DzMVTeDchK+ngJ3YHiOkquQl2flpZnEh3Q=;
 b=p3Vjgl34Ifc/scDibj8GDavRjfamiu+eJ/GLu71UOc7tFnleVph8HDOdmHVbjrUgO5sjyFVT0/fYscbFXVNbORHpeTi+eoorxCRkzdNbRlQ1EhAM8ijYBivbNrZEFvEo85GmbUwjl/41erM9vuHuoWVzM8G8L8ttrgWrfp5lvjY=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB2830.eurprd04.prod.outlook.com (10.175.21.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 03:50:21 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::8026:902c:16d9:699d]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::8026:902c:16d9:699d%7]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 03:50:21 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH nvmem 1/1] nvmem: imx: add i.MX8QM platform
 support
Thread-Topic: [EXT] Re: [PATCH nvmem 1/1] nvmem: imx: add i.MX8QM platform
 support
Thread-Index: AQHVMnTq2F+gGEqIWEi9imTz4TJ3wKbuF3yAgAEphxA=
Date:   Wed, 7 Aug 2019 03:50:21 +0000
Message-ID: <VI1PR0402MB3600F9D3529898EB304579CAFFD40@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190704142032.10745-1-fugang.duan@nxp.com>
 <65afeaaf-f703-02f2-a918-90a8bb8f58b6@linaro.org>
In-Reply-To: <65afeaaf-f703-02f2-a918-90a8bb8f58b6@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 399be000-7cdf-47e1-5624-08d71aea5f1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2830;
x-ms-traffictypediagnostic: VI1PR0402MB2830:
x-microsoft-antispam-prvs: <VI1PR0402MB2830B571BFA960F486AB7EF8FFD40@VI1PR0402MB2830.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(189003)(199004)(6246003)(486006)(55016002)(9686003)(74316002)(54906003)(6436002)(110136005)(316002)(4326008)(53936002)(2906002)(25786009)(11346002)(33656002)(446003)(186003)(256004)(76116006)(476003)(26005)(6116002)(66446008)(64756008)(76176011)(229853002)(102836004)(53546011)(6506007)(7736002)(99286004)(71200400001)(305945005)(7696005)(71190400001)(66946007)(8676002)(81156014)(81166006)(8936002)(86362001)(3846002)(52536014)(2201001)(2501003)(68736007)(66066001)(478600001)(5660300002)(14454004)(66476007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2830;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YVpOFqtCwm7mI1GU9dO1w3ygN8vlox+Eci6YHlgmiXD6co9xgeqoNRC+xfixjqMKtD9Kk/sJnwaBuVX4iW28fFzAX+BFwm3J7ToD3km4Kkv8jqUAJBto9puctVjDKRnaMiVP+Ouu139xU8Y7LZlJtDPfb0QHmee+C6i90mWVPH2dBuD0b6czcvR5MmzvafPuMb5Wxpwv6uJ9/7TQyfvgnJIVjUSQRBI7A+t0Tz21GxZgNO0IycV88CcQHqqtKz6NoPjv5kmwGr8oWxs/nbHsXXlP+wtMT2WlB9BrhjpDQtHSvJbPf6yqT8YZVxNdlUpDoJuwofKIrixHdgip5Ef9CBB/qcoFfMReClWqLk0tlq9eyo8ypzw0MQkMkfUogt7fft63jBvCSWkX0AWJowUgLnuh9no9O3cCm8EQDAFcWUk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399be000-7cdf-47e1-5624-08d71aea5f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 03:50:21.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3Jpbml2YXMgS2FuZGFnYXRsYSA8c3Jpbml2YXMua2FuZGFnYXRsYUBsaW5hcm8ub3Jn
PiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgNiwgMjAxOSA2OjA0IFBNDQo+IE9uIDA0LzA3LzIwMTkg
MTU6MjAsIGZ1Z2FuZy5kdWFuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogRnVnYW5nIER1YW4g
PGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOFFNIGVmdXNlIHRhYmxlIGhhcyBz
b21lIGRpZmZlcmVuY2Ugd2l0aCBpLk1YOFFYUCBwbGF0Zm9ybSwgc28gYWRkDQo+ID4gaS5NWDhR
TSBwbGF0Zm9ybSBzdXBwb3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRnVnYW5nIER1YW4g
PGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL252bWVtL2lteC1v
Y290cC1zY3UuYyB8IDcgKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5j
DQo+ID4gYi9kcml2ZXJzL252bWVtL2lteC1vY290cC1zY3UuYyBpbmRleCBiZTJmNWYwLi4wZDc4
YWI0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5jDQo+ID4g
KysrIGIvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAtc2N1LmMNCj4gPiBAQCAtMTYsNiArMTYsNyBA
QA0KPiA+DQo+ID4gICBlbnVtIG9jb3RwX2RldnR5cGUgew0KPiA+ICAgICAgIElNWDhRWFAsDQo+
ID4gKyAgICAgSU1YOFFNLA0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3RydWN0IG9jb3RwX2RldnR5
cGVfZGF0YSB7DQo+ID4gQEAgLTM5LDYgKzQwLDExIEBAIHN0YXRpYyBzdHJ1Y3Qgb2NvdHBfZGV2
dHlwZV9kYXRhIGlteDhxeHBfZGF0YSA9IHsNCj4gPiAgICAgICAubnJlZ3MgPSA4MDAsDQo+ID4g
ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgb2NvdHBfZGV2dHlwZV9kYXRhIGlteDhxbV9k
YXRhID0gew0KPiA+ICsgICAgIC5kZXZ0eXBlID0gSU1YOFFNLA0KPiA+ICsgICAgIC5ucmVncyA9
IDgwMCwNCj4gPiArfTsNCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IGlteF9zY19taXNjX290cF9m
dXNlX3JlYWQoc3RydWN0IGlteF9zY19pcGMgKmlwYywgdTMyIHdvcmQsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgKnZhbCkNCj4gPiAgIHsNCj4gPiBAQCAtMTE4
LDYgKzEyNCw3IEBAIHN0YXRpYyBzdHJ1Y3QgbnZtZW1fY29uZmlnDQo+ID4gaW14X3NjdV9vY290
cF9udm1lbV9jb25maWcgPSB7DQo+ID4NCj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIGlteF9zY3Vfb2NvdHBfZHRfaWRzW10gPSB7DQo+ID4gICAgICAgeyAuY29tcGF0aWJs
ZSA9ICJmc2wsaW14OHF4cC1zY3Utb2NvdHAiLCAodm9pZCAqKSZpbXg4cXhwX2RhdGENCj4gPiB9
LA0KPiA+ICsgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhxbS1zY3Utb2NvdHAiLCAodm9p
ZCAqKSZpbXg4cW1fZGF0YSB9LA0KPiA+ICAgICAgIHsgfSwNCj4gDQo+IExvb2tzIGxpa2UgeW91
IGZvcmdvdCB0byBhZGQgdGhpcyBuZXcgY29tcGF0aWJsZSB0byBkZXZpY2UgdHJlZSBiaW5kaW5n
cw0KPiBhdCAuL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9pbXgtb2Nv
dHAudHh0IG9yIGZvcmdvdCB0bw0KPiBhZGQgbWUgdG8gQ0MuDQo+IA0KPiBQbGVhc2UgcmVzZW5k
IHRoZSBwYXRjaCB3aXRoIGl0LCBJIGNhbiBub3QgYXBwbHkgdGhpcyBhcyBpdCBpcy4NCj4gDQo+
IFRoYW5rcywNCj4gc3JpbmkNCg0KVGhlcmUgaGF2ZSBubyBzZXBhcmF0ZWQgYmluZGluZyBkb2N1
bWVudGF0aW9uIGZvciBpbXgtb2NvdHAtc2N1LmMgZHJpdmVyLg0KSXQgaXMgcmVhc29uYWJsZSB0
byBhZGQgdGhlIG5ldyBjb21wYXRpYmxlIHN0cmluZyBvbiBiZWxvdyBiaW5kaW5nIGZpbGUgImZz
bCxzY3UudHh0IjoNCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNj
YWxlL2ZzbCxzY3UudHh0DQoNCj4gDQo+ID4gICB9Ow0KPiA+ICAgTU9EVUxFX0RFVklDRV9UQUJM
RShvZiwgaW14X3NjdV9vY290cF9kdF9pZHMpOw0KPiA+DQo=
