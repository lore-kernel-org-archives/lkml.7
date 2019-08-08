Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8540BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4DE218BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="nbhdu/W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfHHIDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:03:33 -0400
Received: from mail-eopbgr50128.outbound.protection.outlook.com ([40.107.5.128]:2051
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731281AbfHHIDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:03:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3g0+4aaNilNgb3VHOTZL+7viSQWLJv/yeK8j1CarL77QD/hrlzjVBMgyvftrcg6Rzt6q/Lk9WpKc2rKme/OZ8pmcKiDBVeCPFXhINNTrCqbAKqMIFxvcVzIi3Fs70y7/XOFps7xtRMN4YlkLwD3qz+LNgp8Me40te3Qeu3hfg5Zk3M/a7RBbgRB9042K1sbF7XscNARbn9eURCytMxhZ66MjqViR8Ryc9C2LOKK12ysByB7t8v6MQ95ErDFL+RzrCp4MhhBBe3//b2RFZozV4VAIVO9kB53laiFJNVPtIRIVfQSyL6kRS+8ivn33m86J3jAZT7KlOVVinnNPjKbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnAVFm/UAhmseYR8FKUBhyGM0MpBfE0Koczz7uLHYm8=;
 b=k8WTlx3kEmCAbBsAvdxFck51F/rymzWMff0MUDQtYyuZEaIknxCvesQ9Mk0LijHLMk6E4TSBh8dO/g6P4BBTQwzVmmB8Sgptx2T9nhbVBnNGLJdoxO/a6Nj48o09WUwyoYfkdiBk1sPIBtulUhglNlKUv6VZoR/PZPYAbTmx68Plg4zEixSv13hbM0NZ5H/F87RKOTFYCkkz4BwmM1GM91XDuh3nQSjqveuipv+KHf/BCD700j1gipnTOfGLBWYjkt7Zzv/OqliKOqrWtYMul3iGh+f3TZVbr22fJAt97mfCOoGP5MUlP+puexS6eBkGI983fNwHg6zPYZqR/PN1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnAVFm/UAhmseYR8FKUBhyGM0MpBfE0Koczz7uLHYm8=;
 b=nbhdu/W7qYbvDdEPWjjsPsLscdxIINXMk8hd7vjrf36j8lBlVs1bAPayKler+3dpDRitpWlh/MPtDMekDPH6vbysHxlOiWwEsz/tJZnUjKwEg2Q0IaZalPkdkYFky79CUSBsJM+XqUE6gtzE4VbXqrU+taiQC4VgmRv8KTcttfc=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3631.eurprd05.prod.outlook.com (52.134.7.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Thu, 8 Aug 2019 08:03:23 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 08:03:22 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 09/21] ARM: dts: imx6qdl-colibri: add phy to fec
Thread-Topic: [PATCH v3 09/21] ARM: dts: imx6qdl-colibri: add phy to fec
Thread-Index: AQHVTPnMzs9IdJAHC02xaJ72tyIhqKbvghSAgAFjdYA=
Date:   Thu, 8 Aug 2019 08:03:22 +0000
Message-ID: <9849ffad4a07b4ce90b412ccdada93ee45c5bc5d.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-10-philippe.schenker@toradex.com>
         <20190807105107.nqqltv64tjxprow6@pengutronix.de>
In-Reply-To: <20190807105107.nqqltv64tjxprow6@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3e0140a-c9f4-4101-ff39-08d71bd6e243
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3631;
x-ms-traffictypediagnostic: VI1PR0502MB3631:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB363193A5C3A2F10C9A3E1189F4D70@VI1PR0502MB3631.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(346002)(396003)(366004)(376002)(136003)(199004)(189003)(11346002)(2616005)(6436002)(26005)(478600001)(6506007)(2501003)(99286004)(7416002)(102836004)(3846002)(8676002)(186003)(25786009)(229853002)(6246003)(81166006)(71200400001)(2351001)(256004)(6486002)(53936002)(5640700003)(81156014)(6512007)(76176011)(7736002)(486006)(36756003)(305945005)(4326008)(6116002)(446003)(118296001)(8936002)(71190400001)(6916009)(2906002)(44832011)(14454004)(476003)(66946007)(66066001)(66556008)(91956017)(76116006)(86362001)(66476007)(66446008)(5660300002)(54906003)(316002)(64756008)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3631;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fKsA7H1giFn4WdP0oeHBR18f9tPqaMma4mDXnPpnP1AeWc7suIbBZe/OKVzEiRnX3M8Ya7f9ho+4notem+oSFHxXXnv9JuXlzq6yZl3rQxrGyVYASqwOG9tYX9rfW7GMfhhBKbD1YKAee2mQDbrHaxB+rUxlSw/y27oaAtUj6wZ7rbhdTDj8Ni/c/KSrnDPySgPWad8qCHuTv4XnG2bQNAYWCqP+ZcY006VmcuL5DPiOf+nnPK6ERRcsMb+YqNu2vICFD7aXwo5QUyqol5fBmZmA24JqDOYsa7uKfUsg9/TPA3TsO6ww3SoIgSwwcIcxzF4I72UqEuo7MSlAsvYQdf8BjHNnXy0qRioyo5Te/Eu6OjbiCFXLcRtwOMv5N+5CdGG86p4/VjGn7HDztCbt8RkZAviyX4C3XDMs4cYWokw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8092D70CEC74144BB6A1B117940CE27E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e0140a-c9f4-4101-ff39-08d71bd6e243
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 08:03:22.8223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeLtnfNXwVp0V/pl99L4i9HkKZaAowxKR4gzKLkoBSLXEPM8x0n7MPcjwTRImvUc8Jjuh4iwOrc7BcQLpgQA947uMLYGYu/3wZ/fSq5g9BA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDEyOjUxICswMjAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMDcsIDIwMTkgYXQgMDg6MjY6MjNBTSArMDAwMCwgUGhpbGlwcGUg
U2NoZW5rZXIgd3JvdGU6DQo+ID4gQWRkIHRoZSBwaHktbm9kZSBhbmQgbWRpbyBidXMgdG8gdGhl
IGZlYy1ub2RlLCByZXByZXNlbnRlZCBhcyBpcyBvbg0KPiA+IGhhcmR3YXJlLg0KPiA+IFRoaXMg
Y29tbWl0IGluY2x1ZGVzIG1pY3JlbCxsZWQtbW9kZSB0aGF0IGlzIHNldCB0byB0aGUgZGVmYXVs
dA0KPiA+IHZhbHVlLCBwcmVwYXJlZCBmb3Igc29tZW9uZSB3aG8gd2FudHMgdG8gY2hhbmdlIHRo
aXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBl
LnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjM6
IE5vbmUNCj4gPiBDaGFuZ2VzIGluIHYyOiBOb25lDQo+ID4gDQo+ID4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZxZGwtY29saWJyaS5kdHNpIHwgMTEgKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0c2kNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZxZGwtY29saWJyaS5kdHNpDQo+ID4gaW5kZXggMWJlYWMyMjI2NmVkLi4wMTlkZGE2Yjg4YWQg
MTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0c2kN
Cj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaQ0KPiA+IEBA
IC0xNDAsNyArMTQwLDE4IEBADQo+ID4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+
ICAJcGluY3RybC0wID0gPCZwaW5jdHJsX2VuZXQ+Ow0KPiA+ICAJcGh5LW1vZGUgPSAicm1paSI7
DQo+ID4gKwlwaHktaGFuZGxlID0gPCZldGhwaHk+Ow0KPiA+ICAJc3RhdHVzID0gIm9rYXkiOw0K
PiA+ICsNCj4gPiArCW1kaW8gew0KPiA+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsJ
CSNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsNCj4gPiArCQlldGhwaHk6IGV0aGVybmV0LXBoeUAw
IHsNCj4gPiArCQkJcmVnID0gPDA+Ow0KPiA+ICsJCQltaWNyZWwsbGVkLW1vZGUgPSA8MD47DQo+
IA0KPiBEb2Vzbid0IHRoYXQgbmVlZCBhIGNvbXBhdGlibGUgZW50cnkgdG8gYmUgYWN0dWFsbHkg
dXNlZD8NCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBVd2UNCg0KSGkgVXdlIGFuZCB0aGFua3MgZm9y
IHBvaW50aW5nIHRoaXMgb3V0LiBJIGp1c3QgdHJpZWQgaXQgYW5kIGl0IHdvcmtzDQpmaW5lIHdp
dGhvdXQgdGhlIGNvbXBhdGlibGUuDQoNClBoaWxpcHBlDQoNCj4gPiANCg==
