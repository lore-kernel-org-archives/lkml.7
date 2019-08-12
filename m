Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E5C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CAF20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="WxbJZkFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfHLNOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:14:48 -0400
Received: from mail-eopbgr30114.outbound.protection.outlook.com ([40.107.3.114]:27878
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728822AbfHLNOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:14:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoSnVf4zHTxFi6NVkSzq9+UoD0RlQziK9Wx1ueTav13q2sPm8yhpDm0Iu1u5Qf47XSgTZ9NgL7XcxkUkx7YIw+Gvjc5SXA71XLzitOewkY9Z7HvVQ7XM3pCly/M0P2E70Wy5o+DLGGRdOsMdAZu7/krFKdGayeAI30VN1LqsdIsDSiPgA+kYyydYlOH3fWOBCuAN9IwhGPpW1TC0xK55LGDgMeHc4c4+AhIL+LlxXGURPDnn7O8CQtcsWv9w4vI5o6J5dktzjDaNRgIEBxVQK9MeG96xu+FZqGnwpGCLptcp5WNNqmTuA6Z56r6dRnBC1oOo/1EIOMOitDnS30kSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXYvDWOUBBurYfUaHXWfX3cT7sFctYyYETofwq26nKQ=;
 b=D1fG0EaHeuhAGohLmxXwvi03lDgY6p3uNhNbbSxeJt1O6tvGLL5xZnB++55FuIHZi/laQU6Egv1ZNKMpUzjp24Ec+GAxRNgfovxCOSpEzqloiTr+4pF08hgasDuDvvzS9V9MyM6IILS9XwPPjS6wtnLZ/t3KRB1ULt6RZhnwVtd0GH1r72bZEKxCQPkSQYHXpoWBXng8WCPZW2Dun6UQJ0OwZ/S29sOTkSuI6d4NMsnYHn6uISXX3qI0j6Hu7lOgH9sLyAuq5q6FAsOTt+fyE891ZWmOnSYgh5cQPfgMIyQpuNAbNpPjxkwpuOosZgYKgP25JFwBImqumlyG7jKzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXYvDWOUBBurYfUaHXWfX3cT7sFctYyYETofwq26nKQ=;
 b=WxbJZkFM7IMHixypKpPakTNABSvStXDR7jo7IhyWw1JCl5fbEyiX2mQYcZOCQXGmv+2O8/rC0qKh0n7J87ve5NRCO5SZMJ+2LhtEL/9Z/4fp+bGqjC1Yty2V56pCogeUJr7+DdiUzsZ2C3KaAriKGwtpwDqpsJzIOtNglZpMIfU=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Mon, 12 Aug 2019 13:14:42 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 13:14:42 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 20/21] ARM: dts: imx6ull-colibri: Add touchscreen used
 with Eval Board
Thread-Topic: [PATCH v3 20/21] ARM: dts: imx6ull-colibri: Add touchscreen used
 with Eval Board
Thread-Index: AQHVTPnauiw8XawvRE+YnPE86awA46by+52AgASKPIA=
Date:   Mon, 12 Aug 2019 13:14:42 +0000
Message-ID: <f9bd4e174830600baadd4ad296bf48ba2561958f.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-21-philippe.schenker@toradex.com>
         <c3eb930aa727067e3d5bbc62523feb6b032244c0.camel@toradex.com>
In-Reply-To: <c3eb930aa727067e3d5bbc62523feb6b032244c0.camel@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 114aeca8-e8ca-457d-8107-08d71f2709bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3006;
x-ms-traffictypediagnostic: VI1PR0502MB3006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3006D0D30E54C80B884C51B5F4D30@VI1PR0502MB3006.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(39850400004)(346002)(199004)(189003)(7736002)(256004)(305945005)(14454004)(14444005)(4326008)(478600001)(102836004)(26005)(186003)(486006)(44832011)(476003)(446003)(11346002)(2616005)(66066001)(8676002)(25786009)(6116002)(3846002)(76176011)(6506007)(2501003)(6512007)(99286004)(316002)(71190400001)(71200400001)(110136005)(53936002)(81156014)(2201001)(6486002)(81166006)(118296001)(7416002)(6436002)(8936002)(6246003)(36756003)(86362001)(2906002)(76116006)(91956017)(66446008)(54906003)(66476007)(66946007)(66556008)(5660300002)(229853002)(64756008)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3006;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wx9cAbgquTSNJXKb+5uKhr7sNbSj2VH9NxlBoGDEO76bc6Py6Q45ZbqRLwx9TZWEfo4Cp/1YyrVm2xzpSqi6U9ezG77RnOENX0+w54UlaowmkcFaS/Xr55WLqSC/AfLCsN522srCOEmc1kpGBWEJwDB7DzlP+F/3M4qcXs4aycpFQ/TH3coBRWpo/MyHbg/EjfH0nzET0QaUhfAASbObwWkIBC6NYZgxzSv7Ii7aKvQUSHG4vnnqMqPjRo9BvbMoN8le+iW7YjyoKas4E0Qih2xxJpIBv/PIcA4tC1HK4PEn8yq0dJyg/7lyA/QgB4gsD6C4u9uBGk5xdFg8+sCRsktsfqJ6RXK/CRibhOTAZw4yHpehGOxo/B+exGEfkz+6a8Jc6O0wc6LeA0JIgt6e6Pd/MNP3sRNp45NjtSxNRiw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCE1A75064B45A4EB792F2CE8FF81C0E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114aeca8-e8ca-457d-8107-08d71f2709bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 13:14:42.2456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3kHqs+B7Lcphvb84X5PB8ex792QtyaH1oH9sCn1B+FccMT3vR9NT73jbh+E/8G2DLETHezM2CDLc7tA5myXXwDLABvPi0DdHAjK8rHhAPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTA5IGF0IDE1OjU0ICswMDAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
DQo+IEhpIFBoaWxpcHBlDQo+IA0KPiBPbiBXZWQsIDIwMTktMDgtMDcgYXQgMDg6MjYgKzAwMDAs
IFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+IFRoaXMgYWRkcyB0aGUgY29tbW9uIHRvdWNo
c2NyZWVuIHRoYXQgaXMgdXNlZCB3aXRoIFRvcmFkZXgncw0KPiA+IEV2YWwgQm9hcmRzLg0KPiAN
Cj4gSXMgdGhhdCByZWFsbHkgRXZhbCBCb2FyZCBzcGVjaWZpYz8NCg0KU2luY2Ugd2UgcHJvdmlk
ZSB0aGUgbmVlZGVkIHNpZ25hbHMgYXMgc3RhbmRhcmQgb24gZXZlcnkgRXZhbCBCb2FyZCwNCnRo
aXMgaXMgbm90IHNwZWNpZmljIHRvIHRoZSBFdmFsIEJvYXJkLg0KDQo+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4N
Cj4gPiANCj4gPiAtLS0NCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYzOiBOb25lDQo+ID4gQ2hhbmdl
cyBpbiB2MjoNCj4gPiAtIFJlbW92ZWQgZjA3MTBhLCB0aGF0IGlzIGRvd25zdHJlYW0gb25seQ0K
PiA+IC0gQ2hhbmdlZCB0byBnZW5lcmljIG5vZGUgbmFtZQ0KPiA+IC0gQmV0dGVyIGNvbW1lbnQN
Cj4gPiANCj4gPiAgLi4uL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktZXZhbC12My5kdHNp
IHwgMjQNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZ1bGwtY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1
bGwtY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gPiBpbmRleCBkM2M0ODA5ZjE0MGUuLjc4ZTc0YmZl
Y2ExYiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmkt
ZXZhbC12My5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJp
LWV2YWwtdjMuZHRzaQ0KPiA+IEBAIC0xMTIsNiArMTEyLDIxIEBADQo+ID4gICZpMmMxIHsNCj4g
PiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgDQo+ID4gKwkvKg0KPiA+ICsJICogVG91Y2hzY3Jl
ZW4gaXMgdXNpbmcgU09ESU1NIDI4LzMwLCBhbHNvIHVzZWQgZm9yIFBXTTxCPiwNCj4gPiBQV008
Qz4sDQo+ID4gKwkgKiBha2EgcHdtMiwgcHdtMy4gc28gaWYgeW91IGVuYWJsZSB0b3VjaHNjcmVl
biwgZGlzYWJsZSB0aGUNCj4gPiBwd21zDQo+ID4gKwkgKi8NCj4gPiArCXRvdWNoc2NyZWVuQDRh
IHsNCj4gPiArCQljb21wYXRpYmxlID0gImF0bWVsLG1heHRvdWNoIjsNCj4gPiArCQlwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9ncGlvdG91
Y2g+Ow0KPiA+ICsJCXJlZyA9IDwweDRhPjsNCj4gPiArCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZn
cGlvND47DQo+ID4gKwkJaW50ZXJydXB0cyA9IDwxNiBJUlFfVFlQRV9FREdFX0ZBTExJTkc+Owkv
KiBTT0RJTU0gMjgNCj4gPiAqLw0KPiA+ICsJCXJlc2V0LWdwaW9zID0gPCZncGlvMiA1IEdQSU9f
QUNUSVZFX0hJR0g+OwkvKg0KPiA+IFNPRElNTSAzMCAqLw0KPiA+ICsJCXN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiAgCS8qIE00MVQwTTYgcmVhbCB0aW1lIGNsb2Nr
IG9uIGNhcnJpZXIgYm9hcmQgKi8NCj4gPiAgCW00MXQwbTY6IHJ0Y0A2OCB7DQo+ID4gIAkJY29t
cGF0aWJsZSA9ICJzdCxtNDF0MCI7DQo+ID4gQEAgLTE4OCwzICsyMDMsMTIgQEANCj4gPiAgCXNk
LXVocy1zZHIxMDQ7DQo+ID4gIAlzdGF0dXMgPSAib2theSI7DQo+ID4gIH07DQo+ID4gKw0KPiA+
ICsmaW9tdXhjIHsNCj4gPiArCXBpbmN0cmxfZ3Bpb3RvdWNoOiB0b3VjaGdwaW9zIHsNCj4gPiAr
CQlmc2wscGlucyA9IDwNCj4gPiArCQkJTVg2VUxfUEFEX05BTkRfRFFTX19HUElPNF9JTzE2CQkw
eDc0DQo+ID4gKwkJCU1YNlVMX1BBRF9FTkVUMV9UWF9FTl9fR1BJTzJfSU8wNQkweDE0DQo+ID4g
KwkJPjsNCj4gPiArCX07DQo+ID4gK307DQo+IA0KPiBJIGd1ZXNzIHRoYXQgY291bGQgYWxzbyBi
ZSBtb3ZlZCB0byB0aGUgbW9kdWxlJ3MgZHRzaSBmb3IgYW55IGNhcnJpZXINCj4gYm9hcmQgdG8g
cG90ZW50aWFsbHkgcHJvZml0IGZyb20uDQoNCkkgdGhpbmsgdGhpcyBjbGVhcmx5IGlzIHBoeXNp
Y2FsbHkgbm90IHByZXNlbnQgb24gb3VyIG1vZHVsZSBzbyBJIHdvdWxkDQpub3QgZG8gdGhhdC4g
SSBsaWtlIHRvIGxlYXZlIHRoYXQgaW4gaGVyZSBhcyBpcywgc28gaXQgb2ZmZXJzIGFuIGV4YW1w
bGUNCm9mIGhvdyB0byBob29rIHRoaXMgdG91Y2hzY3JlZW4gdXAgaW4gRFQuDQoNClBoaWxpcHBl
DQo+IA0KPiBDaGVlcnMNCj4gDQo+IE1hcmNlbA0K
