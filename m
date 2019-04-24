Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3519FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CC62183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="buMo/fdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfDXVZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:25:32 -0400
Received: from mail-eopbgr130090.outbound.protection.outlook.com ([40.107.13.90]:54752
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbfDXVZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SigOZdZC0b9wvoGUs8QX6jvmRdKdwoyI/FAX1hBQEsI=;
 b=buMo/fdJ3ErJglvCKFfmnADWVAw02ifdH/JlejYW+C3VoQjUGiOGL3P34CXS5yT0TLyCKbXXaw/f9HiHhTkSvxJgu+7+TVCsymlZZX/2WCA2YrceAvSyngGR5Gx46ok3fCVGZb4VsFzBlZYXT8UnI2Zs4QYx3LLjxhmoewrg328=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB3901.eurprd02.prod.outlook.com (20.177.58.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 21:25:26 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 21:25:25 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>
CC:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] i2c-mux-gpio: Split plat- and dt-specific code up
Thread-Topic: [PATCH 0/5] i2c-mux-gpio: Split plat- and dt-specific code up
Thread-Index: AQHU+poRmIG7i+VM8k2RvIFkUpub7qZL0zQA
Date:   Wed, 24 Apr 2019 21:25:24 +0000
Message-ID: <93214e50-6f69-0e7a-c725-5e95c1bbdb45@axentia.se>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::39)
 To VI1PR02MB4542.eurprd02.prod.outlook.com (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea177cbd-c0be-479f-fe48-08d6c8fb594e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB3901;
x-ms-traffictypediagnostic: VI1PR02MB3901:
x-microsoft-antispam-prvs: <VI1PR02MB3901F5E906F323DC23B7EAB4BC3C0@VI1PR02MB3901.eurprd02.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(366004)(376002)(199004)(189003)(25786009)(68736007)(52116002)(256004)(14444005)(486006)(76176011)(8936002)(110136005)(81156014)(6246003)(81166006)(54906003)(74482002)(64126003)(14454004)(4326008)(8676002)(316002)(6512007)(99286004)(508600001)(5660300002)(66556008)(66446008)(26005)(64756008)(86362001)(6486002)(3846002)(102836004)(2906002)(6116002)(58126008)(66946007)(66476007)(65826007)(36756003)(6436002)(305945005)(31696002)(186003)(73956011)(31686004)(11346002)(476003)(97736004)(2616005)(65956001)(71190400001)(6506007)(65806001)(71200400001)(446003)(53546011)(7736002)(386003)(66066001)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3901;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A3Xt6zmGpFdxoBLKiYu5VFd0yH7QeFbDl9y+RnTkxCGEhyIi6Qivq5JiwLUPkWsNX9BeyHWHCtn96G9jjqBEaKdXnpSUEp0f1CS1ip+jHd3EAxt5X6iFavkghhcECZ3rf/QZLnyd+5O8szC3jVxto8hivJhTR9N1mel+rLLKSojwMLDI5dRNk+S/toW4KrtVe+m+PU1NDqzvVV71ZqfUDf5Idbh861GAr5pg13HjjUtTW5i3LDbfYT/MkRVBdPp8sUxsMnzPdYqIxysjnrBVThy7JU83o7FHfZdfXC0oyWHUvQzf6HeomCXq/2Ed0I2DgHCSK2BFw2PVBGK3rJGvSAMn8xRWACDJPdlQqbTjQ3a77Ju/ioghBH6uQ7KxeM4tnfolDTENS1KKMgVM6UKqClKTSDGn17uQDJ/NQ0U21n0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F0053282C19444F860CB7D90E1FCFC3@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ea177cbd-c0be-479f-fe48-08d6c8fb594e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 21:25:24.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNCAxNDozNCwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IFRoZSBtYWluIGlkZWEg
b2YgdGhpcyBwYXRjaHNldCB3YXMgdG8gYWRkIHRoZSBkdC1iYXNlZCBHUElPcyBzdXBwb3J0DQo+
IGluIGkyYy1tdXgtZ3BpbyBkcml2ZXIuIEluIHBhcnRpY3VsYXIgd2UgbmVlZGVkIHRvIGhhdmUg
dGhlIGZ1bGwgR1BJT3MNCj4gc3BlY2lmaWVyIGJlaW5nIGhhbmRsZWQgaW5jbHVkaW5nIHRoZSBk
dC1mbGFncyBsaWtlIEdQSU9fQUNUSVZFX0hJR0gsDQo+IEdQSU9fQUNUSVZFX0xPVywgZXRjLiBE
dWUgdG8gdXNpbmcgYSBsZWdhY3kgR1BJTyBpbnRlcmZhY2UgdGhlIGZvcm1lcg0KPiBkcml2ZXIg
aW1wbGVtZW50YXRpb24gZGlkbid0IHByb3ZpZGUgdGhpcyBhYmlsaXR5Lg0KDQpJJ20gY3VyaW91
cyB3aHkgYWN0aXZlIGxvdy9oaWdoIGlzIG9mIGFueSBpbXBvcnRhbmNlPyBUaGF0IHdpbGwgb25s
eSBhZmZlY3QNCnRoZSBzdGF0ZSBudW1iZXJpbmcsIGJ1dCBJIGZhaWwgdG8gc2VlIGFueSByZWxl
dmFuY2UgaW4gdGhhdCBudW1iZXJpbmcuIEl0J3MNCmp1c3QgbnVtYmVycywgbm8/DQoNCklmIGFs
bCB0aGUgcGlucyBhcmUgaW52ZXJ0ZWQgKGFueXRoaW5nIGVsc2Ugc2VlbXMgdmVyeSBzdHJhbmdl
KSwganVzdA0KcmV2ZXJzZSB0aGUgb3JkZXIuIEkuZS4gZm9yIGEgNC13YXkgbXV4LCB1c2UgMywg
MiwgMSwgMCBpbnN0ZWFkIG9mDQowLCAxLCAyLCAzLg0KDQpXaHkgbm90Pw0KDQpDaGVlcnMsDQpQ
ZXRlcg0KDQo+IE9uIHRoZSB3YXkgb2YgYWRkaW5nIHRoZSBmdWxsIGR0LUdQSU8gZmxhZ3Mgc3Vw
cG9ydCBhIHNtYWxsIHNldCBvZg0KPiByZWZhY3RvcmluZ3MgaGFzIGJlZW4gZG9uZSBpbiBvcmRl
ciB0byBrZWVwIHRoZSBwbGF0Zm9ybV9kYXRhLWJhc2VkDQo+IHN5c3RlbXMgc3VwcG9ydCwgbWFr
ZSB0aGUgY29kZSBtb3JlIHJlYWRhYmxlIGFuZCB0aGUgYWx0ZXJhdGlvbnMgLSBjbGVhcmVyLg0K
PiBJbiBnZW5lcmFsIHRoZSB3aG9sZSBjaGFuZ2VzIG1pZ2h0IGJlIGNvbnNpZGVyZWQgYXMgdGhl
IHBsYXQtIGFuZCBkdC0NCj4gc3BlY2lmaWMgY29kZSBzcGxpdCB1cC4gSW4gZmlyc3QgcGF0Y2gg
d2UgdW5waW5uZWQgdGhlIHBsYXRmb3JtLXNwZWNpZmljDQo+IG1ldGhvZCBvZiBHUElPLWNoaXAg
cHJvYmluZy4gVGhlIHNlY29uZCBwYXRjaCBtYWtlcyB0aGUgZHJpdmVyIHRvIHJldHVybg0KPiBh
biBlcnJvciBpZiBvZi1iYXNlZCAobGFzdCByZXNvcnQgcGF0aCkgZmFpbGVkIHRvIHJldHJpZXZl
IHRoZSBkcml2ZXINCj4gcHJpdmF0ZSBkYXRhLiBUaGUgbmV4dCB0aHJlZSBwYXRjaGVzIGlzIHRo
ZSBzZXF1ZW5jZSBvZiBpbml0aWFsIGNoYW5uZWwNCj4gaW5mbyByZXRyaWV2YWwsIHBsYXRmb3Jt
X2RhdGEtc3BlY2lmaWMgY29kZSBpc29sYXRpb24gYW5kIGZpbmFsbHkgZnVsbA0KPiBkdC1iYXNl
ZCBHUElPcyByZXF1ZXN0IG1ldGhvZCBpbnRyb2R1Y3Rpb24uIFRoZSBsYXN0IHBhdGNoIGRvZXMg
d2hhdA0KPiB3ZSBpbnRlZGVkIHRoaXMgcGF0Y2hzZXQgZm9yIGluIHRoZSBmaXJzdCBwbGFjZSAt
IGFkZHMgdGhlIGZ1bGwgZHQtR1BJTw0KPiBzcGVjaWZpZXJzIHN1cHBvcnQuDQo+IA0KPiANCj4g
U2VyZ2UgU2VtaW4gKDUpOg0KPiAgIGkyYy1tdXgtZ3BpbzogVW5waW4gYSBwbGF0Zm9ybS1iYXNl
ZCBkZXZpY2UgaW5pdGlhbGl6YXRpb24NCj4gICBpMmMtbXV4LWdwaW86IFJldHVybiBhbiBlcnJv
ciBpZiBubyBjb25maWcgZGF0YSBmb3VuZA0KPiAgIGkyYy1tdXgtZ3BpbzogU2F2ZSBpbml0aWFs
IGNoYW5uZWwgbnVtYmVyIHRvIHRoZSBpZGxlIGRhdGEgZmllbGQNCj4gICBpMmMtbXV4LWdwaW86
IFVucGluIHRoZSBwbGF0Zm9ybS1zcGVjaWZpYyBHUElPcyByZXF1ZXN0IGNvZGUNCj4gICBpMmMt
bXV4LWdwaW86IENyZWF0ZSBvZi1iYXNlZCBHUElPcyByZXF1ZXN0IG1ldGhvZA0KPiANCj4gIGRy
aXZlcnMvaTJjL211eGVzL2kyYy1tdXgtZ3Bpby5jIHwgMjI0ICsrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNDYgaW5zZXJ0aW9ucygrKSwgNzggZGVs
ZXRpb25zKC0pDQo+IA0KDQo=
