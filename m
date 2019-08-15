Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B26CC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86DA21744
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="N57flLr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfHOLCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:02:09 -0400
Received: from mail-eopbgr30108.outbound.protection.outlook.com ([40.107.3.108]:44097
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728128AbfHOLCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:02:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH23335en534joJgoLcR238VNbGUbgxKPVNe4qdebrPywzKDh1qn7aMGBujnRE8xkG1Trym2b2LokDjLe+GKVLJXHGXNeJtkJClM6Zc+ySKdKX7Q5AbkCzCqubNiKs+3wf3xSaxFmJ8Sz++Q+Dqf3JnWWuc1E/7V+gUdFKlBq5ZbrI6vbLPW8QTu4IQy1pA8jAvUJAa0uHhoTl61hpv7ESEmfh0tMJy8Cbj5DqsCeYBdmgI8mAPIR2KS8WcutV7rYFvTskb8ULt8fG6X9Nw4CQ6F2lR8dPVvJL3AmSS7tDeqZ/IOy7hLx6U8LtDXwfBVFTDsh+Td47uQT9djuCuZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AXL2RaCjxFmW1S/GZh72Q6VEayvvcv89X9ptXDSwlQ=;
 b=UL46E0j/4uNxtt5VOU0kDFhuDtbKvMMHXQWcAbI98CB6QJcV1R4/afdIHEyOoYCX8fS1mn/N8QYUNvo2WFpTnurqsPV8C2ybtjedhmbRr+GVjt/+fZczhsWcGGxX1ehwBPODe0jVZNG7iEJYw89KT0OH6Mag0PvkNGqXu7qZwn7BTQEukcbZTFlWHFfdX7+C5d9HXLw3jVKDgmc+TSls4i0icjZFQwCqolxDAyNe/rmGl+BzrPgGLyQBATXjKL7crLSoJx/3Qri+FjQZ56QXSRbd9r7xLLpeSXUDOI8AiREj4pIVQrK7DyPIjpKX1TiOjB4Av6CXEYvIp9HZ3cAHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AXL2RaCjxFmW1S/GZh72Q6VEayvvcv89X9ptXDSwlQ=;
 b=N57flLr0GlEpOvU8L+9I0YUTPUako3Z8eqfnaiw++4noEKgBjhK0HgGev8hG6WNkqoE6UHHW08LVeYwAiIqTPuelYZAebWK8IYjU5RkInW6dezFFecjKRu1RzvBYI5RAE715NvHc+rTTzfDsLlIR8Ft2IO6H9Rf0KXAfKSQqbKk=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB5808.eurprd05.prod.outlook.com (20.178.122.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Thu, 15 Aug 2019 11:02:03 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9%4]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 11:02:04 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 19/21] ARM: dts: imx6ull-colibri: Add touchscreen used
 with Eval Board
Thread-Topic: [PATCH v4 19/21] ARM: dts: imx6ull-colibri: Add touchscreen used
 with Eval Board
Thread-Index: AQHVU1fw0kTsCjnFk0OpCJf7XHMhlQ==
Date:   Thu, 15 Aug 2019 11:02:04 +0000
Message-ID: <CAGgjyvGggWwOy91gdhqrZ6TRaeQCox8_bCfMK7GCrPywUzqRJQ@mail.gmail.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-20-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-20-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::23) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAXn8shu9GH+B5AWfRDB1nMyPmBpULMVZMxfo1B+w+7lvgT/CN1+
        f1JX+TyirzP2vLEe+Nj722oWL/OuNNKkZvozHyM=
x-google-smtp-source: APXvYqzELeiC2yM1ChST4cQmx4mNodLqpWyErz3h2qQ3fH2VDnmJ4SWBdByKZkN1OlJpVGVxOimBJJNuMvTK9PFfbPM=
x-received: by 2002:a17:906:12d7:: with SMTP id
 l23mr3751588ejb.282.1565866535893; Thu, 15 Aug 2019 03:55:35 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvGggWwOy91gdhqrZ6TRaeQCox8_bCfMK7GCrPywUzqRJQ@mail.gmail.com>
x-originating-ip: [209.85.208.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ff3d2b4-4072-4a1e-c034-08d7217001a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5808;
x-ms-traffictypediagnostic: VI1PR05MB5808:
x-microsoft-antispam-prvs: <VI1PR05MB5808B8E7095EDDF574FDE56EF9AC0@VI1PR05MB5808.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(346002)(136003)(39840400004)(189003)(199004)(2906002)(6862004)(81166006)(81156014)(71190400001)(8676002)(11346002)(3846002)(8936002)(6512007)(498394004)(71200400001)(86362001)(9686003)(6116002)(55446002)(6436002)(229853002)(6506007)(53546011)(66556008)(66476007)(386003)(486006)(6636002)(476003)(186003)(14454004)(256004)(478600001)(66446008)(5660300002)(53936002)(14444005)(25786009)(6486002)(26005)(66946007)(450100002)(4326008)(44832011)(66066001)(305945005)(61266001)(316002)(95326003)(446003)(107886003)(6246003)(99286004)(102836004)(76176011)(52116002)(7736002)(54906003)(61726006)(64756008)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5808;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 19r2YMK+tXHKnbSweCY7AutBqdO29TRiane5IyQXtz0OpcwdQ/v6YO/c3DYXAGniubVg/caiPnrW0kTBMnvpLDtkGu1XW3hGeYrpAUYdWyuiEIM64Lqn/sTtrn8Fbk7XHr/2unCJN9BM22JTP37XFRxwNjhGa3Uo1sHhNb4EQH4jMxebLcKZCbfh9b7xoXiyvUtuXxO65FaHag0o57xufNERLUlbT3X4Yo05KyLRqQHBj7bjKIFUiIO50bjIekA4fGL7yDXSs5LpEmgjIkmgC6AKFo7mILAl1medYuLtlRPxvVa8NkaWBbBfJiMjb+KOatFGa62muxY/OHF4yStRWYPRFY8Nf4FdWU6kRfhcF3Z2v9YqpQ3H09itrB2VIgn8BNWcDWUWStPOVMunPHSd87NRKmIA8h35X5P89pB47GM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED25DB2E9079BE4E9011E29772628155@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff3d2b4-4072-4a1e-c034-08d7217001a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 11:02:04.5797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qA7xtmqwdqrrufOT8n485OHtwrs6sg6oW1cWtQHLuR0MbF/LY2IDfCERXr1h0hWkx50CgnP5nJA8KptmqpXF36ykXHkVz3SsS19Ahlsk+gQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgNToyMyBQTSBQaGlsaXBwZSBTY2hlbmtlcg0KPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPiB3cm90ZToNCj4NCj4gVGhpcyBhZGRzIHRoZSBjb21t
b24gdG91Y2hzY3JlZW4gdGhhdCBpcyB1c2VkIHdpdGggVG9yYWRleCdzDQo+IEV2YWwgQm9hcmRz
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5r
ZXJAdG9yYWRleC5jb20+DQoNClJldmlld2VkLWJ5OiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xla3Nh
bmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQoNCj4NCj4gLS0tDQo+DQo+IENoYW5nZXMgaW4gdjQ6
IE5vbmUNCj4gQ2hhbmdlcyBpbiB2MzogTm9uZQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFJlbW92
ZWQgZjA3MTBhLCB0aGF0IGlzIGRvd25zdHJlYW0gb25seQ0KPiAtIENoYW5nZWQgdG8gZ2VuZXJp
YyBub2RlIG5hbWUNCj4gLSBCZXR0ZXIgY29tbWVudA0KPg0KPiAgLi4uL2FybS9ib290L2R0cy9p
bXg2dWxsLWNvbGlicmktZXZhbC12My5kdHNpIHwgMjQgKysrKysrKysrKysrKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ldmFsLXYzLmR0c2kgYi9hcmNoL2FybS9ib290
L2R0cy9pbXg2dWxsLWNvbGlicmktZXZhbC12My5kdHNpDQo+IGluZGV4IGE3ODg0OWZkMmFmYS4u
NDU4YTQwODRlNTNjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNv
bGlicmktZXZhbC12My5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29s
aWJyaS1ldmFsLXYzLmR0c2kNCj4gQEAgLTEwMCw2ICsxMDAsMjEgQEANCj4gICZpMmMxIHsNCj4g
ICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+DQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBU
b3VjaHNjcmVlbiBpcyB1c2luZyBTT0RJTU0gMjgvMzAsIGFsc28gdXNlZCBmb3IgUFdNPEI+LCBQ
V008Qz4sDQo+ICsgICAgICAgICogYWthIHB3bTIsIHB3bTMuIHNvIGlmIHlvdSBlbmFibGUgdG91
Y2hzY3JlZW4sIGRpc2FibGUgdGhlIHB3bXMNCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICB0b3Vj
aHNjcmVlbkA0YSB7DQo+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLG1heHRv
dWNoIjsNCj4gKyAgICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsg
ICAgICAgICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZ3Bpb3RvdWNoPjsNCj4gKyAgICAg
ICAgICAgICAgIHJlZyA9IDwweDRhPjsNCj4gKyAgICAgICAgICAgICAgIGludGVycnVwdC1wYXJl
bnQgPSA8JmdwaW80PjsNCj4gKyAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MTYgSVJRX1RZ
UEVfRURHRV9GQUxMSU5HPjsgICAgICAgIC8qIFNPRElNTSAyOCAqLw0KPiArICAgICAgICAgICAg
ICAgcmVzZXQtZ3Bpb3MgPSA8JmdwaW8yIDUgR1BJT19BQ1RJVkVfSElHSD47ICAgICAgLyogU09E
SU1NIDMwICovDQo+ICsgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArICAg
ICAgIH07DQo+ICsNCj4gICAgICAgICAvKiBNNDFUME02IHJlYWwgdGltZSBjbG9jayBvbiBjYXJy
aWVyIGJvYXJkICovDQo+ICAgICAgICAgbTQxdDBtNjogcnRjQDY4IHsNCj4gICAgICAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAic3QsbTQxdDAiOw0KPiBAQCAtMTc2LDMgKzE5MSwxMiBAQA0KPiAg
ICAgICAgIHNkLXVocy1zZHIxMDQ7DQo+ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiAgfTsN
Cj4gKw0KPiArJmlvbXV4YyB7DQo+ICsgICAgICAgcGluY3RybF9ncGlvdG91Y2g6IHRvdWNoZ3Bp
b3Mgew0KPiArICAgICAgICAgICAgICAgZnNsLHBpbnMgPSA8DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIE1YNlVMX1BBRF9OQU5EX0RRU19fR1BJTzRfSU8xNiAgICAgICAgICAweDc0DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIE1YNlVMX1BBRF9FTkVUMV9UWF9FTl9fR1BJTzJfSU8wNSAg
ICAgICAweDE0DQo+ICsgICAgICAgICAgICAgICA+Ow0KPiArICAgICAgIH07DQo+ICt9Ow0KPiAt
LQ0KPiAyLjIyLjANCj4NCg0KDQotLSANCkJlc3QgcmVnYXJkcw0KT2xla3NhbmRyIFN1dm9yb3YN
Cg0KVG9yYWRleCBBRw0KQWx0c2FnZW5zdHJhc3NlIDUgfCA2MDQ4IEhvcncvTHV6ZXJuIHwgU3dp
dHplcmxhbmQgfCBUOiArNDEgNDEgNTAwDQo0ODAwIChtYWluIGxpbmUpDQo=
