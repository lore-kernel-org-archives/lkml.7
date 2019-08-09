Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C6CC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD78A20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="p9+JMbyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436832AbfHIPr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:47:57 -0400
Received: from mail-eopbgr140102.outbound.protection.outlook.com ([40.107.14.102]:40518
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436622AbfHIPr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:47:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMspTTwCntypRUgY555i1zeyCJBjAEGEaDrku1AMEanCPYmjAAeHh9xwWCEYSsq6Ymg/jHDf4ZBTCDOIyMBqwQyvIkR9Lft6S3mFJs3lCdKZvrqpUGag6YgZXxCclBDuhltnvaP6hk0aQi1982vLp8Fgvsldg2jtkeD12+HOls5Ql5cH5XNsXdeillQlf5BeWWmHzkZJcOTuSEyqeo/iwczknsRVVkFp0EbP/ZM+cFbU9XeM5qRfgvqjONh0/353w30EMuEgUeVTCNxechGA9G5Nbkh3CxDNYNkqHxqjzaFqBEq2qyFrC1tXIGsQRMUvx8Jc0NQ6rmsQYYGPSH6Xxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW9+yXCFzCR66mEFBLiwp7Or3pHJpcd4a+kk0lhWeg4=;
 b=akE6N5H+wT0X1gH/bVvD7ZnfsCQCKQUFl1zIzIWdQK1GlcWir7pWWWXMxGHHPCz1qo9BsZiYp7S/4xHPZERRWm5Jwlj31MFYmRxxDlVgwgtMnwgzys6DBooirdvYHybYVq8OJjhu0/pN9rTwPa+JOa7byPWztUMPgao+bbZCUx8++uMJJEH5SYCIpwloiXbqeuJKTtS0FzqV28192Dbj+Z3vlWWRJUhr4cgo1Rq+YywNF+DkX4256ZKUG7FAO5ontPvPysdjGJujPdBDZ59yyFmtVyfXNX8OSCw8SqnS2OzLTqccf1GZZhXN3nx2TnVM9UEw+lXg7/MVobQGY/jsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW9+yXCFzCR66mEFBLiwp7Or3pHJpcd4a+kk0lhWeg4=;
 b=p9+JMbyTxZCiSgf2avABMcNACU6F8iBAzdsTDheeyK0U12TNmmfWhK00ePSrmCvnEY3sFtFZlWElXt4Nej4v5GBDkhthTPa/n5kaNht0z/RA9LKmOnxzRGFahtcSPFnrL9mF08tTSFeRXZv3jNHk6jxIUlnRF5dMzOCyE8wzKMM=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB6752.eurprd05.prod.outlook.com (10.186.160.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 9 Aug 2019 15:47:51 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:47:51 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 17/21] ARM: dts: imx6ull: improve can templates
Thread-Topic: [PATCH v3 17/21] ARM: dts: imx6ull: improve can templates
Thread-Index: AQHVTPnXr0NFcJhs8k2cZd07S2mEX6by+aaA
Date:   Fri, 9 Aug 2019 15:47:51 +0000
Message-ID: <8ae5742f29f17e61fd9fc39a8dbd1b7c3a2f45b0.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-18-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-18-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8df90cb6-eafb-4aae-36b5-08d71ce0efe6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB6752;
x-ms-traffictypediagnostic: VI1PR05MB6752:
x-microsoft-antispam-prvs: <VI1PR05MB675261993567077AE31337B2FBD60@VI1PR05MB6752.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(136003)(366004)(39850400004)(376002)(199004)(189003)(86362001)(4326008)(102836004)(186003)(76176011)(2501003)(6506007)(446003)(486006)(476003)(2616005)(11346002)(44832011)(7416002)(46003)(81156014)(8676002)(8936002)(81166006)(6116002)(25786009)(14454004)(6246003)(118296001)(54906003)(110136005)(7736002)(99286004)(316002)(478600001)(2906002)(2201001)(5660300002)(71190400001)(305945005)(71200400001)(14444005)(256004)(76116006)(91956017)(229853002)(6512007)(66556008)(66946007)(64756008)(66446008)(36756003)(6436002)(6486002)(66476007)(53936002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6752;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: plB94CfGL0tqmBXF4Dpmwlo44AiAWLf5pyJIzt9+Q4uuiouzdaFNeOBpXjnhsLR0qkJeQK5hm9ImWfwD9BWmPH9QkRWy2wLJlHr3rXzhqiG1zskfKQNg3DR7rGp1XXrZlluucpuD4g2pT1H0ShaCDU/nySS6O8/o6tK8Ob5MijMDg20DxiMurESZTH+TqgQkmhOP6ciSlSZJKGUf52DrPPyGRRs1IDe1Ebs9S/w3tcWL5COd4BH8vCkQC+y6YXTYBJ/kY9H0X1VKUjD55W/Y/eMalDd17Xo2smHuVIlhX6Eaay0kUTV2WFJkzJBoCmUgS2j0PqLkvF180XiWz7x/+Md7hGFJiRQvHYGG1Oib1ycA6ZofGavL00yeOZuEQw5ZlY/V5gAsb1iVOa3WB5pPP2nDGzGb7KThDl/f/Y2cnrM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50F337CA203C7E439414CCD76C8798DE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df90cb6-eafb-4aae-36b5-08d71ce0efe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:47:51.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQqLPVaJRldfJJY3yfbzcghMm0WSLr+VzkoOVA1me/8NT84YCBSURuFCBeln/oa1E1YgA3XEjRpVmqsxKMCYM6+kRKlStOaMGRIf22J6Uyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcGUNCg0KT24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBw
ZSBTY2hlbmtlciB3cm90ZToNCj4gRnJvbTogTWF4IEtydW1tZW5hY2hlciA8bWF4LmtydW1tZW5h
Y2hlckB0b3JhZGV4LmNvbT4NCj4gDQo+IEFkZCB0aGUgcGlubXV4aW5nIGFuZCBhIGluYWN0aXZl
IG5vZGUgZm9yIGZsZXhjYW4xIG9uIFNPRElNTSA1NS82Mw0KPiBhbmQgbW92ZSB0aGUgaW5hY3Rp
dmUgZmxleGNhbiBub2RlcyB0byBpbXg2dWxsLWNvbGlicmktZXZhbC12My5kdHNpDQo+IHdoZXJl
IHRoZXkgYmVsb25nLg0KPiANCj4gTm90ZSB0aGF0IHRoaXMgY29tbWl0IGRvZXMgbm90IGVuYWJs
ZSBmbGV4Y2FuIGZ1bmN0aW9uYWxpdHksIGJ1dA0KPiByYXRoZXINCj4gZWFzZXMgdGhlIGVmZm9y
dCBuZWVkZWQgdG8gZG8gc28uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggS3J1bW1lbmFjaGVy
IDxtYXgua3J1bW1lbmFjaGVyQHRvcmFkZXguY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBw
ZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+IC0tLQ0KPiANCj4g
Q2hhbmdlcyBpbiB2MzogTm9uZQ0KPiBDaGFuZ2VzIGluIHYyOiBOb25lDQo+IA0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaSB8IDEyICsrKysrKysrKysr
Kw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLW5vbndpZmkuZHRzaSB8ICAy
ICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktd2lmaS5kdHNpICAgIHwg
IDIgKy0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpICAgICAgICAg
fCAxNiArKysrKysrKysrKysrKy0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1
bGwtY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gaW5kZXggYjYxNDdjNzZkMTU5Li4zYmVlMzdjNzVh
YTYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ldmFs
LXYzLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwt
djMuZHRzaQ0KPiBAQCAtODMsNiArODMsMTggQEANCj4gIAl9Ow0KPiAgfTsNCj4gIA0KPiArJmNh
bjEgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJcGluY3RybC0wID0gPCZw
aW5jdHJsX2ZsZXhjYW4xPjsNCj4gKwlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArfTsNCj4gKw0K
PiArJmNhbjIgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJcGluY3RybC0w
ID0gPCZwaW5jdHJsX2ZsZXhjYW4yPjsNCj4gKwlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArfTsN
Cg0KQXMgdGhvc2UgZG9uJ3QgcmVhbGx5IGhhdmUgYW55dGhpbmcgdG8gZG8gd2l0aCB0aGUgZXZh
bCBib2FyZCBkaXJlY3RseSwNCndvdWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0byByYXRoZXIg
bW92ZSB0aGVtIGludG8gdGhlIG1vZHVsZSdzIGR0c2kNCmp1c3QgbGlrZSB0aGUgcGluIG11eGlu
ZyBmdXJ0aGVyIGJlbG93Pw0KDQo+ICAmaTJjMSB7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAg
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktbm9ud2lm
aS5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLW5vbndpZmkuZHRz
aQ0KPiBpbmRleCBmYjIxM2JlYzQ2NTQuLjk1YTExYjhiY2JkYiAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLW5vbndpZmkuZHRzaQ0KPiArKysgYi9hcmNo
L2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktbm9ud2lmaS5kdHNpDQo+IEBAIC0xNSw3ICsx
NSw3IEBADQo+ICAmaW9tdXhjIHsNCj4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAg
CXBpbmN0cmwtMCA9IDwmcGluY3RybF9ncGlvMSAmcGluY3RybF9ncGlvMiAmcGluY3RybF9ncGlv
Mw0KPiAtCQkmcGluY3RybF9ncGlvNCAmcGluY3RybF9ncGlvNSAmcGluY3RybF9ncGlvNj47DQo+
ICsJCSZwaW5jdHJsX2dwaW80ICZwaW5jdHJsX2dwaW81ICZwaW5jdHJsX2dwaW82DQo+ICZwaW5j
dHJsX2dwaW83PjsNCj4gIH07DQo+ICANCj4gICZpb211eGNfc252cyB7DQo+IGRpZmYgLS1naXQg
YS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktd2lmaS5kdHNpDQo+IGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLXdpZmkuZHRzaQ0KPiBpbmRleCAwMzhkOGM5MGY2
ZGYuLmEwNTQ1NDMxYjNkYyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVs
bC1jb2xpYnJpLXdpZmkuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNv
bGlicmktd2lmaS5kdHNpDQo+IEBAIC0yNiw3ICsyNiw3IEBADQo+ICAmaW9tdXhjIHsNCj4gIAlw
aW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgCXBpbmN0cmwtMCA9IDwmcGluY3RybF9ncGlv
MSAmcGluY3RybF9ncGlvMiAmcGluY3RybF9ncGlvMw0KPiAtCQkmcGluY3RybF9ncGlvNCAmcGlu
Y3RybF9ncGlvNT47DQo+ICsJCSZwaW5jdHJsX2dwaW80ICZwaW5jdHJsX2dwaW81ICZwaW5jdHJs
X2dwaW83PjsNCj4gIA0KPiAgfTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNv
bGlicmkuZHRzaQ0KPiBpbmRleCBlMzIyMDI5OGRkNmYuLjU1M2Q0YzFmODBlOSAxMDA2NDQNCj4g
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gQEAgLTI1Niw2ICsyNTYsMTMg
QEANCj4gIAkJPjsNCj4gIAl9Ow0KPiAgDQo+ICsJcGluY3RybF9mbGV4Y2FuMTogZmxleGNhbjEt
Z3JwIHsNCj4gKwkJZnNsLHBpbnMgPSA8DQo+ICsJCQlNWDZVTF9QQURfRU5FVDFfUlhfREFUQTBf
X0ZMRVhDQU4xX1RYCTB4MWIwDQo+IDIwDQo+ICsJCQlNWDZVTF9QQURfRU5FVDFfUlhfREFUQTFf
X0ZMRVhDQU4xX1JYCTB4MWIwDQo+IDIwDQo+ICsJCT47DQo+ICsJfTsNCj4gKw0KPiAgCXBpbmN0
cmxfZmxleGNhbjI6IGZsZXhjYW4yLWdycCB7DQo+ICAJCWZzbCxwaW5zID0gPA0KPiAgCQkJTVg2
VUxfUEFEX0VORVQxX1RYX0RBVEEwX19GTEVYQ0FOMl9SWAkweDFiMA0KPiAyMA0KPiBAQCAtMjcx
LDggKzI3OCw2IEBADQo+ICANCj4gIAlwaW5jdHJsX2dwaW8xOiBncGlvMS1ncnAgew0KPiAgCQlm
c2wscGlucyA9IDwNCj4gLQkJCU1YNlVMX1BBRF9FTkVUMV9SWF9EQVRBMF9fR1BJTzJfSU8wMAkw
eDc0DQo+IC8qIFNPRElNTSA1NSAqLw0KPiAtCQkJTVg2VUxfUEFEX0VORVQxX1JYX0RBVEExX19H
UElPMl9JTzAxCTB4NzQNCj4gLyogU09ESU1NIDYzICovDQo+ICAJCQlNWDZVTF9QQURfVUFSVDNf
UlhfREFUQV9fR1BJTzFfSU8yNQkwWDE0DQo+IC8qIFNPRElNTSA3NyAqLw0KPiAgCQkJTVg2VUxf
UEFEX0pUQUdfVENLX19HUElPMV9JTzE0CQkweDE0DQo+IC8qIFNPRElNTSA5OSAqLw0KPiAgCQkJ
TVg2VUxfUEFEX05BTkRfQ0UxX0JfX0dQSU80X0lPMTQJMHgxNCAvKg0KPiBTT0RJTU0gMTMzICov
DQo+IEBAIC0zMjUsNiArMzMwLDEzIEBADQo+ICAJCT47DQo+ICAJfTsNCj4gIA0KPiArCXBpbmN0
cmxfZ3Bpbzc6IGdwaW83LWdycCB7IC8qIENBTjEgKi8NCj4gKwkJZnNsLHBpbnMgPSA8DQo+ICsJ
CQlNWDZVTF9QQURfRU5FVDFfUlhfREFUQTBfX0dQSU8yX0lPMDAJMHg3NA0KPiAvKiBTT0RJTU0g
NTUgKi8NCj4gKwkJCU1YNlVMX1BBRF9FTkVUMV9SWF9EQVRBMV9fR1BJTzJfSU8wMQkweDc0DQo+
IC8qIFNPRElNTSA2MyAqLw0KPiArCQk+Ow0KPiArCX07DQo+ICsNCj4gIAlwaW5jdHJsX2dwbWlf
bmFuZDogZ3BtaS1uYW5kLWdycCB7DQo+ICAJCWZzbCxwaW5zID0gPA0KPiAgCQkJTVg2VUxfUEFE
X05BTkRfREFUQTAwX19SQVdOQU5EX0RBVEEwMAkweDEwMA0KPiBhOQ0KDQpDaGVlcnMNCg0KTWFy
Y2VsDQo=
