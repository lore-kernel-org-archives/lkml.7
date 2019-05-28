Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502B6C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E42F2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="LvNJVCVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfE1PqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:46:16 -0400
Received: from mail-eopbgr790085.outbound.protection.outlook.com ([40.107.79.85]:54880
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbfE1PqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y55626EY4VhwAGnHDDZmHBkeD1vpwcDjDoncxn8sEA=;
 b=LvNJVCVS8sbkg7iNdvmRkEc364DdFiSfOge0izGshwLdj1BVanoGJZJcwrHDc8+TQ452YsUX93Ij0crjq3Wr8LCRDNeRTFNi6zPZ7C/jjCnIla7S0U+UjmDGGUumjxXg3pY7t+FbnhAI38ilI0QnCjupxipnbM3WCGaDeicAVuE=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5791.namprd08.prod.outlook.com (20.179.87.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 15:46:10 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 15:46:10 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: RE: [EXT] Re: [PATCH 3/4] mtd: spinand: Enabled support to detect
 parameter page
Thread-Topic: [EXT] Re: [PATCH 3/4] mtd: spinand: Enabled support to detect
 parameter page
Thread-Index: AdTjwSAFDW7WB7gARZuMWrsA2XWYYgbaOd4AAGX3qdAAByiXgAUe47Xg
Date:   Tue, 28 May 2019 15:46:10 +0000
Message-ID: <MN2PR08MB59517D405930FAEF5C09D766B81E0@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951E8D99AA1FBD972131388B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
        <20190430095508.706fa125@xps13>
        <MN2PR08MB5951A622B36705BC26CE36E2B8340@MN2PR08MB5951.namprd08.prod.outlook.com>
 <20190502135945.61bd6ceb@xps13>
In-Reply-To: <20190502135945.61bd6ceb@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1337b9b5-a67c-47ab-f9cb-08d6e3839b61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR08MB5791;
x-ms-traffictypediagnostic: MN2PR08MB5791:|MN2PR08MB5791:
x-microsoft-antispam-prvs: <MN2PR08MB579105FE3ED03686CAD4CE30B81E0@MN2PR08MB5791.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(52536014)(8936002)(476003)(446003)(6506007)(74316002)(14454004)(6246003)(11346002)(53936002)(66946007)(76116006)(102836004)(316002)(486006)(99286004)(66446008)(64756008)(66556008)(66476007)(55236004)(6916009)(73956011)(86362001)(508600001)(68736007)(6116002)(81166006)(26005)(256004)(6436002)(4326008)(14444005)(71190400001)(71200400001)(229853002)(25786009)(3846002)(5660300002)(2906002)(7696005)(8676002)(66066001)(76176011)(9686003)(7736002)(186003)(55016002)(81156014)(305945005)(33656002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5791;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 0
x-microsoft-antispam-message-info: xCdZ+D4J/lKmMLrcnOU+FxOiSMoKAIPkP6kXaSzhElfvqUUzEMUVA4Z5lu/5nBMTOA0Sm46rA7mwJP/YlkL1Zjs+gnfSI22iVbFXM4nNIQRGfy6D9ax/IhZ5D0izKpKv6Na3bOj879/VVY93g/q320mNb20NRw8CkoPzjTVaqlRBTdYvXuqSDk0eh45TQfYdI4lyO8JSD407+yN5k31+J2Ih4OmTArnNQH4iUay3Ub/OsFpiJChe0irl4OC5IrAcFHgAB9Du86oWgHqY0bpw/bHDuZpOk2gIEpt1l5QbE3nRBdP0DGcYjGuzX8WKezhO1+WJ5q5Y9OqQUM2Km81bmgh7CCbs7HjW12CrmtZYTbX3Ghk5IEliLAZHK7DK281ZKMZckl9vZpwJMM60riRIJG2V8zcILWeZjN4x8MZc5cI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1337b9b5-a67c-47ab-f9cb-08d6e3839b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 15:46:10.4985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sshivamurthy@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+ID4gPg0KPiA+ID4gPiBTb21lIG9mIHRoZSBTUEkgTkFORCBkZXZpY2Vz
IGhhcyBwYXJhbWV0ZXIgcGFnZSB3aGljaCBpcyBzaW1pbGFyIHRvDQo+IE9ORkkNCj4gPiA+ID4g
dGFibGUuDQo+ID4gPiA+DQo+ID4gPiA+IEJ1dCwgaXQgbWF5IG5vdCBiZSBzZWxmIHN1ZmZpY2ll
bnQgdG8gcHJvcGFnYXRlIGFsbCB0aGUgcmVxdWlyZWQNCj4gPiA+ID4gcGFyYW1ldGVycy4gRml4
dXAgZnVuY3Rpb24gaGFzIGJlZW4gYWRkZWQgaW4gc3RydWN0IG1hbnVmYWN0dXJlciB0bw0KPiA+
ID4gPiBhY2NvbW1vZGF0ZSB0aGlzLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBT
aGl2YW11cnRoeSBTaGFzdHJpIDxzc2hpdmFtdXJ0aHlAbWljcm9uLmNvbT4NCj4gPiA+ID4gLS0t
DQo+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMgfCAxMTMNCj4gPiA+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiAgaW5jbHVkZS9saW51eC9t
dGQvc3BpbmFuZC5oIHwgICA1ICsrDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDExNyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMgYi9kcml2ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMN
Cj4gPiA+ID4gaW5kZXggOTg1YWQ1MmNkYWE3Li40MDg4MmExZDJiYzEgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJz
L210ZC9uYW5kL3NwaS9jb3JlLmMNCj4gPiA+ID4gQEAgLTU3NCw2ICs1NzQsMTA4IEBAIHN0YXRp
YyBpbnQgc3BpbmFuZF9sb2NrX2Jsb2NrKHN0cnVjdA0KPiA+ID4gc3BpbmFuZF9kZXZpY2UgKnNw
aW5hbmQsIHU4IGxvY2spDQo+ID4gPiA+ICAJcmV0dXJuIHNwaW5hbmRfd3JpdGVfcmVnX29wKHNw
aW5hbmQsIFJFR19CTE9DS19MT0NLLCBsb2NrKTsNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+
ID4gKy8qKg0KPiA+ID4gPiArICogc3BpbmFuZF9yZWFkX3BhcmFtX3BhZ2Vfb3AgLSBSZWFkIHBh
cmFtZXRlciBwYWdlIG9wZXJhdGlvbg0KPiA+ID4gPiArICogQHNwaW5hbmQ6IHRoZSBzcGluYW5k
IGRldmljZQ0KPiA+ID4gPiArICogQHBhZ2U6IHBhZ2UgbnVtYmVyIHdoZXJlIHBhcmFtZXRlciBw
YWdlIHRhYmxlcyBjYW4gYmUgZm91bmQNCj4gPiA+ID4gKyAqIEBwYXJhbWV0ZXJzOiBidWZmZXIg
dXNlZCB0byBzdG9yZSB0aGUgcGFyYW1ldGVyIHBhZ2UNCj4gPiA+DQo+ID4gPiBEb2VzIG5vdCBt
YXRjaCB0aGUgcHJvdG90eXBlDQo+ID4NCj4gPiBJIHdpbGwgZml4IHRoaXMgaW4gbmV4dCB2ZXJz
aW9uLg0KPiA+DQo+ID4gPg0KPiA+ID4gPiArICogQGxlbjogbGVuZ3RoIG9mIHRoZSBidWZmZXIN
Cj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBSZWFkIHBhcmFtZXRlciBwYWdlDQo+ID4gPiA+ICsg
Kg0KPiA+ID4gPiArICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIGEgbmVnYXRpdmUgZXJyb3IgY29k
ZSBvdGhlcndpc2UuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0YXRpYyBpbnQgc3BpbmFuZF9w
YXJhbWV0ZXJfcGFnZV9yZWFkKHN0cnVjdCBuYW5kX2RldmljZSAqYmFzZSwNCj4gPiA+DQo+ID4g
PiBQbGVhc2UgdXNlIGEgc3BpbmFuZCBzdHJ1Y3R1cmUgYXMgcGFyYW1ldGVyLCB5b3UgZG9uJ3Qg
bmVlZCBhDQo+ID4gPiBuYW5kX2RldmljZSBoZXJlIChzYW1lIGZvciBvdGhlciBzcGluYW5kIGZ1
bmN0aW9ucykuDQo+ID4NCj4gPiBUaGlzIGZ1bmN0aW9uIGlzIGhlbHBlciBmdW5jdGlvbiBmb3Ig
Z2VuZXJpYyBPTkZJIGxheWVyLg0KPiA+IEZyb20gZ2VuZXJpYyBPTkZJIGxheWVyLCBJIGNhbiBn
ZXQgb25seSBuYW5kX2RldmljZS4NCj4gDQo+IEhvdyBkbyB5b3UgaGFuZGxlIGlmIHRoZSBTUEkg
TkFORCBjb3JlIGlzIG5vdCBjb21waWxlZC1pbj8NCj4gDQoNCkJvdGggcmF3IE5BTkQgYW5kIFNQ
SSBOQU5EIGRlZmluZSBwYXJhbWV0ZXJfcGFnZV9yZWFkIGZ1bmN0aW9uLA0Kd2hpY2ggd2lsbCBi
ZSBjYWxsZWQgaW4gbmFuZF9vbmZpX2RldGVjdC4NCg0KUmlnaHRseSB5b3UgcG9pbnRlZCwgSSB3
aWxsIGFkZCB0aGUgZm9sbG93aW5nIGxpbmVzIGluIG5hbmRfb25maV9kZXRlY3QNCnRvIHRhY2ts
ZSBpZiB0aG9zZSBmdW5jdGlvbnMgYXJlIG5vdCBjb21waWxlZC1pbi4NCg0KICAgICAgICAvKiBy
ZXR1cm4gMCwgaWYgT05GSSBoZWxwZXIgZnVuY3Rpb25zIGFyZSBub3QgZGVmaW5lZCAqLyAgICAg
ICAgICAgICAgICAgDQogICAgICAgIGlmICghYmFzZS0+aGVscGVyLnBhcmFtZXRlcl9wYWdlX3Jl
YWQgJiYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICFiYXNl
LT5oZWxwZXIuY2hlY2tfcmV2aXNpb24gJiYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KICAgICAgICAgICAgIWJhc2UtPmhlbHBlci5pbml0X2ludGZfZGF0YSkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQoNCkkgaG9wZSB0aGlzIGFuc3dlcnMgeW91ciBwb2ludC4NCg0KVGhhbmtzLA0KU2hpdmEN
Cg==
