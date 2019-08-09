Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF876C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C7F20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="mSFDMEi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436771AbfHIPkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:40:14 -0400
Received: from mail-eopbgr10122.outbound.protection.outlook.com ([40.107.1.122]:5024
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbfHIPkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:40:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUQlXhGZrfSuCTUfAR2MCeePhC5QlarfMN13JyqQ8m8cnxLdukoAidEdtUaxh/5ppWVRaPkqfVHjXMvvAeuIGrdIDNXPBhvYmByP0JWuGsuOa1HPhGwECkfRq/1R293+RFz8V2DXYmRAekJhEVXGNmwn+S6GL8BRk5J7Sky19TYRX1r1BDnxePKGMQM0X56U6YaPFn3bcdi7uAw4JSXVdPTRMN8srnfvltzPr5JFQhXpFPRNzQhSKoJfaVPuVRDlikEhCJXj4ZdxKrBZGpdwklBDsMHrhuXU+s8cpxbxmotLkd5QOXWuB9lg++9WaNfreOvDiUTVnI6hH+DhdX3T5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPUQ8HA6jGSFgKI1iFnaN3afWG286FuCNGftbgFJk9o=;
 b=Cwki9pBlWmXPE7jLh3/tvOpFE7SZLCfbqN6OJTMNsvOCpcohVa3ROAqJNHzMajs5rxd6os94KOVWEWPDX809CXXabIhuM/9CBPjxGNXwHpWMK/dqeufVWiG3XiIa1ieiShDDU3H794QqB/o0PwAAdlmyaaeCjEXG7pynZuE8VFIwqY3UaQwJM5T5ak80WnoRcAGWhZE4Re0aOmU1CkSs618rQfVGfqvciCnstqQx8feQ8O6FXNx3pcQ9eWq4qkgZN+a3MqekTXuWEldYR2IMW61gc52ztd1wSVAoNAxUmDI/o7NjppmuPyWPE6xgNIVY5wFaa0QsgjigX6CdIrMFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPUQ8HA6jGSFgKI1iFnaN3afWG286FuCNGftbgFJk9o=;
 b=mSFDMEi6iznQhmQFzZQKhRyQ6AxE80BXNf0N5Y3yXHpRVN4eGpPaH9bpysIqoelTJvuYmp1IIkb5xf1JNZwEDzX2Ki3hZQEBbOdOz8zfRxZDpz8c91dy9yIcXCLF81hZNf2Lk3yjN9rlNkzGk/uRGMxm1UuuBN16Hg1CEtBwglw=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB4909.eurprd05.prod.outlook.com (20.177.51.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 9 Aug 2019 15:40:10 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:40:10 +0000
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
Subject: Re: [PATCH v3 15/21] ARM: dts: imx6ull-colibri: reduce v_batt current
 in power off
Thread-Topic: [PATCH v3 15/21] ARM: dts: imx6ull-colibri: reduce v_batt
 current in power off
Thread-Index: AQHVTPnUAnr1vxWSd0S4SXGdXkHUnaby93+A
Date:   Fri, 9 Aug 2019 15:40:09 +0000
Message-ID: <b1d05badaf2bfbb09f67be76ccc5a98105222c9f.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-16-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-16-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 684cfe21-de6d-4b13-cd6d-08d71cdfdc92
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB4909;
x-ms-traffictypediagnostic: VI1PR05MB4909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB4909D561B59D4A5B9D55B6A6FBD60@VI1PR05MB4909.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(199004)(189003)(186003)(256004)(6506007)(446003)(11346002)(102836004)(6116002)(46003)(76176011)(2616005)(118296001)(478600001)(476003)(44832011)(71200400001)(71190400001)(66446008)(8936002)(66476007)(66556008)(486006)(66946007)(64756008)(2906002)(91956017)(76116006)(2501003)(25786009)(4326008)(53936002)(6512007)(86362001)(2201001)(305945005)(99286004)(7736002)(14454004)(7416002)(6436002)(36756003)(6486002)(5660300002)(110136005)(316002)(6246003)(54906003)(229853002)(8676002)(81166006)(81156014)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4909;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lf4YF1WdsApaIECShPBqqnErqz1ztq9XCTZU9ylNEmMSgyo/z6BOVal59TQNGS4OwcpI99ATj32SLPpFpyvQ4JZbipBsp8/AhkoH0eUnuKlqAGy5wwNw9v6ftMdNfh41V6YkFqioZn4rgRK8OTsHVTwbnfbsJsU35lWAWE2PcNqrAIVlEf/l7SqiVPG7HRzrA8HuIH1gYkGJYuwWrkDXBO1IPlIjFgciKwH57hTBkZM5BmcsNwQhcW1FdjdHW1BvijYwlAfCQlFCYhsoP4Q7EhlTKp8/540TvdPjA2bVB4EPi8CPFiegDr/YYMzZoRKJCgAf+JmieSAm5BeUiVGMN+pRQdHVv7dcEyZ1axeq6fSWlwBEU1cDiwTDsNhaZqn34OSkXUHkuAliyni0dPTh7rEmyOjWLSKPCPkCbWkSYY4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B0DAF92E0C01F4F8AD2F603DABAA167@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684cfe21-de6d-4b13-cd6d-08d71cdfdc92
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:40:09.8558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p77Tpy0oLmSXZoNOn2N6lzR2rHqhXg90jyisO+xpzMnS6iooUvlxiSCjhrXmeRLMiBOadVZu1A82jNCYIU5Yv4jX9PqJLFbgG6mY1VgAXmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gRnJvbTogTWF4IEtydW1tZW5hY2hlciA8bWF4LmtydW1tZW5hY2hlckB0b3JhZGV4LmNv
bT4NCj4gDQo+IFJlZHVjZSB0aGUgY3VycmVudCBkcmF3biBmcm9tIFZDQ19CQVRUIHdoZW4gdGhl
IG1haW4gcG93ZXIgb24gdGhlIDNWMw0KPiBwaW5zIHRvIHRoZSBtb2R1bGUgYXJlIHN3aXRjaGVk
IG9mZi4NCj4gDQo+IFRoaXMgc3dpdGNoZXMgb2ZmIFNvQyBpbnRlcm5hbCBwdWxsIHJlc2lzdG9y
cyB3aGljaCBhcmUgcHJvdmlkZWQgb24NCj4gdGhlDQo+IG1vZHVsZSBmb3IgVEFNUEVSNyBhbmQg
VEFNUEVSOSBTb0MgcGluIGFuZCBzd2l0Y2hlcyBvbiBhIHB1bGwgZG93bg0KPiBpbnN0ZWFkIG9m
IGEgcHVsbHVwIGZvciB0aGUgVVNCQ19ERVQgbW9kdWxlIHBpbiAoVEFNUEVSMikuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBNYXggS3J1bW1lbmFjaGVyIDxtYXgua3J1bW1lbmFjaGVyQHRvcmFkZXgu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5r
ZXJAdG9yYWRleC5jb20+DQoNCkFja2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3
aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4g
Q2hhbmdlcyBpbiB2MjogTm9uZQ0KPiANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29s
aWJyaS5kdHNpIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
NnVsbC1jb2xpYnJpLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmku
ZHRzaQ0KPiBpbmRleCAxMDE5Y2U2OWEyNDIuLjFmMTEyZWM1NWU1YyAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gQEAgLTUzMywxOSArNTMzLDE5IEBADQo+
ICANCj4gIAlwaW5jdHJsX3NudnNfYWQ3ODc5X2ludDogc252cy1hZDc4NzktaW50LWdycCB7IC8q
IFRPVUNIDQo+IEludGVycnVwdCAqLw0KPiAgCQlmc2wscGlucyA9IDwNCj4gLQkJCU1YNlVMTF9Q
QURfU05WU19UQU1QRVI3X19HUElPNV9JTzA3CTB4MWIwDQo+IGIwDQo+ICsJCQlNWDZVTExfUEFE
X1NOVlNfVEFNUEVSN19fR1BJTzVfSU8wNwkweDEwMA0KPiBiMA0KPiAgCQk+Ow0KPiAgCX07DQo+
ICANCj4gIAlwaW5jdHJsX3NudnNfcmVnX3NkOiBzbnZzLXJlZy1zZC1ncnAgew0KPiAgCQlmc2ws
cGlucyA9IDwNCj4gLQkJCU1YNlVMTF9QQURfU05WU19UQU1QRVI5X19HUElPNV9JTzA5CTB4NDAw
DQo+IDFiOGIwDQo+ICsJCQlNWDZVTExfUEFEX1NOVlNfVEFNUEVSOV9fR1BJTzVfSU8wOQkweDQw
MA0KPiAxMDBiMA0KPiAgCQk+Ow0KPiAgCX07DQo+ICANCj4gIAlwaW5jdHJsX3NudnNfdXNiY19k
ZXQ6IHNudnMtdXNiYy1kZXQtZ3JwIHsNCj4gIAkJZnNsLHBpbnMgPSA8DQo+IC0JCQlNWDZVTExf
UEFEX1NOVlNfVEFNUEVSMl9fR1BJTzVfSU8wMgkweDFiMA0KPiBiMA0KPiArCQkJTVg2VUxMX1BB
RF9TTlZTX1RBTVBFUjJfX0dQSU81X0lPMDIJMHgxMzANCj4gYjANCj4gIAkJPjsNCj4gIAl9Ow0K
