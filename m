Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8913CC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6188724314
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="FS9kfrOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfEaUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:04:23 -0400
Received: from mail-eopbgr710080.outbound.protection.outlook.com ([40.107.71.80]:23044
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbfEaUEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1u3cvrM+bp9Jx8KsAm/tulzwKsb5KjQfTyXUMbFK4A=;
 b=FS9kfrOmqbXMuUf0peOkqrr8KREXh+a4nR4KiRaREgRbG/tPuGGcmgWpzG7DUya4WTClVlmOpcMdHn8wAJ4wzBAtBoh7yXz380zDMmzXzel+LkrDPszRqAwyykc5wTSNDE+8tvmktpW4tyHOUwVejeLAacZAsjj902zL9Konux8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4166.namprd05.prod.outlook.com (52.135.200.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.15; Fri, 31 May 2019 20:04:19 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 20:04:19 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Jann Horn <jannh@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Topic: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Index: AQHVF3tKnfrC/xKd0kyiVp6wMVDUEqaFEHMAgAB+LICAAA4xgIAADEgA
Date:   Fri, 31 May 2019 20:04:19 +0000
Message-ID: <6331796E-8925-4426-A0A6-5CB342178202@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-12-namit@vmware.com>
 <20190531105758.GO2623@hirez.programming.kicks-ass.net>
 <82791CFA-3748-4881-9F01-53F677108FC3@vmware.com>
 <CAG48ez1LxU_swf30Ndj=vjZLeSKg83Oi4f2Kd+wSUygPXA0cGg@mail.gmail.com>
In-Reply-To: <CAG48ez1LxU_swf30Ndj=vjZLeSKg83Oi4f2Kd+wSUygPXA0cGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30c596e5-44b6-4060-034f-08d6e6032a9c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB4166;
x-ms-traffictypediagnostic: BYAPR05MB4166:
x-microsoft-antispam-prvs: <BYAPR05MB4166FAFE6FF990B3F5129D8CD0190@BYAPR05MB4166.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(376002)(39860400002)(199004)(189003)(4326008)(2906002)(76116006)(7736002)(53546011)(86362001)(6512007)(33656002)(66946007)(6436002)(6246003)(2616005)(73956011)(66556008)(305945005)(82746002)(14444005)(76176011)(99286004)(25786009)(6116002)(3846002)(478600001)(53936002)(66446008)(81156014)(8936002)(26005)(64756008)(7416002)(256004)(81166006)(6486002)(14454004)(229853002)(102836004)(6506007)(66476007)(6916009)(186003)(476003)(446003)(71200400001)(66066001)(71190400001)(8676002)(5660300002)(36756003)(68736007)(486006)(54906003)(11346002)(316002)(83716004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4166;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mJMcSWqVTQwPOurOJlPkvp8Vd0IzSx6sWL9iqukWCE6L/eqP4JS4zMWTj9d8u9WrQC+EqFVANNmgOTQD7CqM1b3Az4xob09SM0ObIa7hyiZH2UX0SIlIjRUwrLqAWJChwg9pKrovsWJ5+CeL9TqOMiDbE8cLM5eeSBZm1ObjtMTGAoTqE3FhotHfazykCr5mOg+lLjq2pnxdZ5rZmtgFvpF/hJx0VVy15Ud9/KkVRBGs3vvfNDqkJStGAjfNDpcc9/mzmTob+w1R8lIea6Gfz8X/bnloBCKoFwpl3lXPSpBxscMoziuDqH2YOAv5iYx7u/FCDkCUS5ZQbopE4seKVKGlCQSqyWOHn75xTlWJ+XQTumn9xXoYvWAtJ2fj9zcXzZAKUZce1NS4fQVji0VVl+7g4KlQV8qDRFw5z70Y6Fc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DAE826C7207C041AAE35556749C842E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c596e5-44b6-4060-034f-08d6e6032a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 20:04:19.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMzEsIDIwMTksIGF0IDEyOjIwIFBNLCBKYW5uIEhvcm4gPGphbm5oQGdvb2dsZS5j
b20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBNYXkgMzEsIDIwMTkgYXQgODoyOSBQTSBOYWRhdiBB
bWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+IFsgK0phbm4gSG9ybiBdDQo+PiANCj4+
PiBPbiBNYXkgMzEsIDIwMTksIGF0IDM6NTcgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gVGh1LCBNYXkgMzAsIDIwMTkgYXQgMTE6
MzY6NDRQTSAtMDcwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+Pj4gV2hlbiB3ZSBmbHVzaCB1c2Vy
c3BhY2UgbWFwcGluZ3MsIHdlIGNhbiBkZWZlciB0aGUgVExCIGZsdXNoZXMsIGFzIGxvbmcNCj4+
Pj4gdGhlIGZvbGxvd2luZyBjb25kaXRpb25zIGFyZSBtZXQ6DQo+Pj4+IA0KPj4+PiAxLiBObyB0
YWJsZXMgYXJlIGZyZWVkLCBzaW5jZSBvdGhlcndpc2Ugc3BlY3VsYXRpdmUgcGFnZSB3YWxrcyBt
aWdodA0KPj4+PiAgY2F1c2UgbWFjaGluZS1jaGVja3MuDQo+Pj4+IA0KPj4+PiAyLiBObyBvbmUg
d291bGQgYWNjZXNzIHVzZXJzcGFjZSBiZWZvcmUgZmx1c2ggdGFrZXMgcGxhY2UuIFNwZWNpZmlj
YWxseSwNCj4+Pj4gIE5NSSBoYW5kbGVycyBhbmQga3Byb2JlcyB3b3VsZCBhdm9pZCBhY2Nlc3Np
bmcgdXNlcnNwYWNlLg0KPiBbLi4uXQ0KPj4gQSAjTUMgbWlnaHQgYmUgY2F1c2VkLiBJIHRyaWVk
IHRvIGF2b2lkIGl0IGJ5IG5vdCBhbGxvd2luZyBmcmVlaW5nIG9mDQo+PiBwYWdlLXRhYmxlcyBp
biBzdWNoIHdheS4gRGlkIEkgbWlzcyBzb21ldGhpbmcgZWxzZT8gU29tZSBpbnRlcmFjdGlvbiB3
aXRoDQo+PiBNVFJSIGNoYW5nZXM/IEnigJlsbCB0aGluayBhYm91dCBpdCBzb21lIG1vcmUsIGJ1
dCBJIGRvbuKAmXQgc2VlIGhvdy4NCj4gDQo+IEkgZG9uJ3QgcmVhbGx5IGtub3cgbXVjaCBhYm91
dCB0aGlzIHRvcGljLCBidXQgaGVyZSdzIGEgcmFuZG9tIGNvbW1lbnQNCj4gc2luY2UgeW91IGNj
J2VkIG1lOiBJZiB0aGUgcGh5c2ljYWwgbWVtb3J5IHJhbmdlIHdhcyBmcmVlZCBhbmQNCj4gcmVh
bGxvY2F0ZWQsIGNvdWxkIHlvdSBlbmQgdXAgd2l0aCBzcGVjdWxhdGl2ZWx5IGV4ZWN1dGVkIGNh
Y2hlZA0KPiBtZW1vcnkgcmVhZHMgZnJvbSBJL08gbWVtb3J5PyAoQW5kIGlmIHNvLCB3b3VsZCB0
aGF0IGJlIGJhZD8pDQoNClRoYW5rcy4gSSB0aG91Z2h0IHRoYXQgeW91ciBleHBlcmllbmNlIHdp
dGggVExCIHBhZ2UtZnJlZWluZyBidWdzIG1heQ0KYmUgdmFsdWFibGUsIGFuZCB5b3UgZnJlcXVl
bnRseSBmaW5kIG15IG1pc3Rha2VzLiA7LSkNCg0KWWVzLCBzcGVjdWxhdGl2ZWx5IGV4ZWN1dGVk
IGNhY2hlZCByZWFkcyBmcm9tIHRoZSBJL08gbWVtb3J5IGFyZSBhIGNvbmNlcm4uDQpJSVJDIHRo
ZXkgY2F1c2VkICNNQyBvbiBBTUQuIElmIHBhZ2UtdGFibGVzIGFyZSBub3QgY2hhbmdlcywgYnV0
IG9ubHkgUFRFcw0KYXJlIGNoYW5nZWQsIEkgZG9u4oCZdCBzZWUgaG93IGl0IGNhbiBiZSBhIHBy
b2JsZW0uIEkgYWxzbyBsb29rZWQgYXQgdGhlIE1UUlINCnNldHRpbmcgY29kZSwgYnV0IEkgZG9u
4oCZdCBzZWUgYSBjb25jcmV0ZSBwcm9ibGVtLg0KDQo=
