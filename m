Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C02C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC0A2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="cG0SPqnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389875AbfDRV1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:27:22 -0400
Received: from mail-eopbgr60118.outbound.protection.outlook.com ([40.107.6.118]:61157
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728264AbfDRV1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwuLpNE8RRgnZ64eARbGVNqOB1mtrhcFufKysA7dlkE=;
 b=cG0SPqnkHxc00u6L/sxeqaSVxoYRBStBy/bj5gOJLxxBC/JnywGqj+F6lqwTYoOAu8fwNh56wWDmB5jiqH0/zdC3wsouYz3VoirNka4INIF7kCDrvUFcfP+Ef4FhNMLeah+GvfZxQlTgVNi9wStqx9f3QYG8KOCqVL5/sfIZHaI=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4718.eurprd02.prod.outlook.com (20.177.200.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 21:27:15 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019
 21:27:15 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Ray Jui <ray.jui@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Thread-Topic: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Thread-Index: AQHU6mEE3VBQWFg3OEO4UFCMK2X3RqY5U5QAgAOpzgCABB38AIAAj1cAgACYBQCAAEN6AA==
Date:   Thu, 18 Apr 2019 21:27:14 +0000
Message-ID: <0d88af3b-e877-cd80-9537-ecde2d2d0e94@axentia.se>
References: <20190403210535.32236-1-ray.jui@broadcom.com>
 <f28f604a-55a4-7542-0e13-a92a83ab2144@axentia.se>
 <c47c6ec2-6d6f-8885-932c-35390783f55b@axentia.se>
 <bd0c7b0f-1936-dd1e-b8f3-ebafebdea252@broadcom.com>
 <497d0668-3065-a357-72ca-a7e79fc9cfb0@axentia.se>
 <477ebe18-68e0-f5c8-e7a0-5476b6a886db@broadcom.com>
In-Reply-To: <477ebe18-68e0-f5c8-e7a0-5476b6a886db@broadcom.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::11) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ef19ffe-20f0-46cd-8185-08d6c4449fc0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB4718;
x-ms-traffictypediagnostic: VI1PR02MB4718:
x-microsoft-antispam-prvs: <VI1PR02MB4718380282B64BD3883DE336BC260@VI1PR02MB4718.eurprd02.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39830400003)(366004)(136003)(199004)(189003)(51444003)(52314003)(3846002)(6116002)(36756003)(65826007)(25786009)(446003)(4326008)(2906002)(71190400001)(71200400001)(6246003)(53936002)(65956001)(8936002)(6486002)(8676002)(81156014)(64756008)(73956011)(66946007)(486006)(229853002)(81166006)(52116002)(66446008)(53546011)(66066001)(2616005)(26005)(186003)(68736007)(476003)(102836004)(76176011)(386003)(65806001)(6506007)(11346002)(54906003)(316002)(58126008)(99286004)(93886005)(31696002)(97736004)(14454004)(6512007)(74482002)(6436002)(86362001)(31686004)(256004)(14444005)(508600001)(110136005)(7736002)(5660300002)(305945005)(64126003)(66476007)(66556008)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4718;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RKytPqeKTVtaY5ybNCM6hJBiqcQqhgVrmRxFHbErV3BNGWuwkiXP73vYxWHXyzl9ZMDSrAj59r+iLYDArgNmY/rR+OfwbceU0v2PXot5/dQgi9ATKSTnPzr0nkwth67MUxKuTzZgosToSKZp/ej9cwy9Se43H8880EID+KSJamywI5FagY8Ggw/Nne8RNnVWVtpfsNgXBCfYSv592L2vTDVn/BSOTdDltzgZ6I4JZUxJwXxEhVMPNqVeMx0MR0S2Lo8C7Q06t1dp5mRvl/Vprl8qu8IwrkuEcLiAEzhSL1SEqqBBlaOn/2OKzblC06I9uZ125fulVeHhamP/5v9eaGnJrD6Y68jpe2YG8bKvnVZAeq4QAENFA9W2EGmwrfRfDbskyOI6lwRiSqqSPob6gS1Yq6UTkl4CAEhOm2o7EK4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAE936D2C7FE2943B403A59873C9356C@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef19ffe-20f0-46cd-8185-08d6c4449fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 21:27:14.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0xOCAxOToyNSwgUmF5IEp1aSB3cm90ZToNCj4gDQo+IA0KPiBPbiA0LzE3LzIw
MTkgMTE6MjEgUE0sIFBldGVyIFJvc2luIHdyb3RlOg0KPj4gT24gMjAxOS0wNC0xOCAwMTo0OCwg
UmF5IEp1aSB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gT24gNC8xNC8yMDE5IDExOjU2IFBNLCBQZXRl
ciBSb3NpbiB3cm90ZToNCj4+Pj4gT24gMjAxOS0wNC0xMyAwMDo1OSwgUGV0ZXIgUm9zaW4gd3Jv
dGU6DQo+Pj4+PiBPbiAyMDE5LTA0LTAzIDIzOjA1LCBSYXkgSnVpIHdyb3RlOg0KPj4+Pj4+IENo
YW5nZSB0aGUgaVByb2MgSTJDIGRyaXZlciB0byB1c2UgdGhlICdCSVQnIG1hY3JvIGZyb20gYWxs
ICcxIDw8IFhYWCcNCj4+Pj4+PiBiaXQgb3BlcmF0aW9ucyB0byBnZXQgcmlkIG9mIGNvbXBpbGVy
IHdhcm5pbmcgYW5kIGltcHJvdmUgcmVhZGFiaWxpdHkgb2YNCj4+Pj4+PiB0aGUgY29kZQ0KPj4+
Pj4NCj4+Pj4+IEFsbD8gSSBzZWUgbG90cyBtb3JlICcxIDw8IFhYWF9TSElGVCcgbWF0Y2hlcy4g
SSBtaWdodCBiZSBiZWhpbmQgdGhvdWdoPw0KPj4+Pg0KPj4+PiBJIHZlcmlmaWVkIHRoYXQsIGFu
ZCB5ZXMgaW5kZWVkLCBJIHdhcyBiZWhpbmQuIFRoYXQgc2FpZCwgc2VlIGJlbG93Li4uDQo+Pj4+
DQo+Pj4NCj4+PiBSaWdodC4gUHJldmlvdXMgY2hhbmdlIHRoYXQgdGhpcyBjaGFuZ2UgZGVwZW5k
cyBvbiBpcyBhbHJlYWR5IHF1ZXVlZCBpbg0KPj4+IGkyYy9mb3ItbmV4dC4NCj4+Pg0KPj4+Pj4g
QW55d2F5LCBpZiB5b3UgYXJlIGNsZWFuaW5nIHVwLCBJJ20ganVzdCBmbGFnZ2luZyB0aGF0IEJJ
VChYWFhfU0hJRlQpIGxvb2tzDQo+Pj4+PiBhIGJpdCBjbHVua3kgdG8gbWUuIFlvdSBtaWdodCBj
b25zaWRlciByZW5hbWluZyBhbGwgdGhvc2Ugc2luZ2xlLWJpdA0KPj4+Pj4gWFhYX1NISUZUIG1h
Y3JvcyB0byBzaW1wbGUgYmUNCj4+Pj4+DQo+Pj4+PiAjZGVmaW5lIFhYWCBCSVQoPHh4eD4pDQo+
Pj4+Pg0KPj4+Pj4gaW5zdGVhZCBvZg0KPj4+Pj4NCj4+Pj4+ICNkZWZpbmUgWFhYX1NISUZUIDx4
eHg+DQo+Pj4+Pg0KPj4+Pj4gYnV0IHRoYXQgdHJpZ2dlcnMgbW9yZSBjaHVybiwgc28gaXMgb2J2
aW91c2x5IG1vcmUgZXJyb3IgcHJvbmUuIFlvdSBtaWdodA0KPj4+Pj4gbm90IGRhcmUgaXQ/DQo+
Pj4+Pg0KPj4+DQo+Pj4gV2l0aCB0aGUgY3VycmVudCBjb2RlLCBJIGRvbid0IHNlZSBob3cgdGhh
dCBpcyBjbGVhbmVyLiBXaXRoIFhYWF9TSElGVA0KPj4+IHNwZWNpZmllZCwgaXQgbWFrZXMgaXQg
dmVyeSBjbGVhciB0byB0aGUgdXNlciB0aGF0IHRoZSBkZWZpbmUgYSBmb3IgYQ0KPj4+IGJpdCBs
b2NhdGlvbiB3aXRoaW4gYSByZWdpc3Rlci4gWW91IGNhbiBhcmd1ZSBhbmQgc2F5IGl0IG1ha2Vz
IHRoZQ0KPj4+IGRlZmluZSBsb25nZXIsIGJ1dCBub3QgbGVzcyBjbGVhci4NCj4+Pg0KPj4+Pj4g
Q2hlZXJzLA0KPj4+Pj4gUGV0ZXINCj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUmF5IEp1
aSA8cmF5Lmp1aUBicm9hZGNvbS5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gIGRyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtYmNtLWlwcm9jLmMgfCA2ICsrKy0tLQ0KPj4+Pj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYmNtLWlwcm9jLmMgYi9kcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLWJjbS1pcHJvYy5jDQo+Pj4+Pj4gaW5kZXggNTYyOTQyZDBjMDVjLi5hODQ1Yjhk
ZWNhYzggMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1iY20taXBy
b2MuYw0KPj4+Pj4+ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYmNtLWlwcm9jLmMNCj4+
Pj4+PiBAQCAtNzE3LDcgKzcxNyw3IEBAIHN0YXRpYyBpbnQgYmNtX2lwcm9jX2kyY194ZmVyX3Np
bmdsZV9tc2coc3RydWN0IGJjbV9pcHJvY19pMmNfZGV2ICppcHJvY19pMmMsDQo+Pj4+Pj4gIA0K
Pj4+Pj4+ICAJCQkvKiBtYXJrIHRoZSBsYXN0IGJ5dGUgKi8NCj4+Pj4+PiAgCQkJaWYgKGkgPT0g
bXNnLT5sZW4gLSAxKQ0KPj4+Pj4+IC0JCQkJdmFsIHw9IDEgPDwgTV9UWF9XUl9TVEFUVVNfU0hJ
RlQ7DQo+Pj4+Pj4gKwkJCQl2YWwgfD0gQklUKE1fVFhfV1JfU1RBVFVTX1NISUZUKTsNCj4+Pj4+
PiAgDQo+Pj4+Pj4gIAkJCWlwcm9jX2kyY193cl9yZWcoaXByb2NfaTJjLCBNX1RYX09GRlNFVCwg
dmFsKTsNCj4+Pj4+PiAgCQl9DQo+Pj4+Pj4gQEAgLTg0NCw3ICs4NDQsNyBAQCBzdGF0aWMgaW50
IGJjbV9pcHJvY19pMmNfY2ZnX3NwZWVkKHN0cnVjdCBiY21faXByb2NfaTJjX2RldiAqaXByb2Nf
aTJjKQ0KPj4+Pj4+ICANCj4+Pj4+PiAgCWlwcm9jX2kyYy0+YnVzX3NwZWVkID0gYnVzX3NwZWVk
Ow0KPj4+Pj4+ICAJdmFsID0gaXByb2NfaTJjX3JkX3JlZyhpcHJvY19pMmMsIFRJTV9DRkdfT0ZG
U0VUKTsNCj4+Pj4+PiAtCXZhbCAmPSB+KDEgPDwgVElNX0NGR19NT0RFXzQwMF9TSElGVCk7DQo+
Pj4+Pj4gKwl2YWwgJj0gfkJJVChUSU1fQ0ZHX01PREVfNDAwX1NISUZUKTsNCj4+Pj4+PiAgCXZh
bCB8PSAoYnVzX3NwZWVkID09IDQwMDAwMCkgPDwgVElNX0NGR19NT0RFXzQwMF9TSElGVDsNCj4+
Pj4NCj4+Pj4gVGhlc2UgdHdvIHN0YXRlbWVudHMgbm93IG5vIGxvbmdlciAibWF0Y2giLiBPbmUg
dXNlcyBCSVQgYW5kIHRoZSBvdGhlciBvcGVuDQo+Pj4+IGNvZGVzIHRoZSBzaGlmdC4gSSB0aGlu
ayB0aGF0J3MgYmFkLiBMb3NpbmcgdGhlIF9TSElGVCBzdWZmaXggYW5kIGluY2x1ZGluZw0KPj4+
PiBCSVQgaW4gdGhlIG1hY3JvIGV4cGFuc2lvbiwgYXMgc3VnZ2VzdGVkIGFib3ZlLCB5aWVsZHM6
DQo+Pj4+DQo+Pj4+IAl2YWwgJj0gflRJTV9DRkdfTU9ERV80MDA7DQo+Pj4+IAlpZiAoYnVzX3Nw
ZWVkID09IDQwMDAwMCkNCj4+Pj4gCQl2YWwgfD0gVElNX0NGR19NT0RFXzQwMDsNCj4+Pj4NCj4+
Pj4gd2hpY2ggaXMgcGVyaGFwcyBvbmUgbW9yZSBsaW5lLCBidXQgYWxzbyBtb3JlIHJlYWRhYmxl
IElNTy4NCj4+Pj4NCj4+Pg0KPj4+IEEgc2luZ2xlIGxpbmUgd2l0aCBldmFsdWF0aW9uIGVtYmVk
ZGVkIGlzIG5pY2UgYW5kIGNsZWFuIHRvIG1lLiBJIGd1ZXNzDQo+Pj4gdGhpcyBpcyBzdWJqZWN0
aXZlLg0KPj4NCj4+IFRoZSAicHJvYmxlbSIgSSBoYWQgd2hlbiBJIGxvb2tlZCBhdCB0aGUgZHJp
dmVyIHdhcyBub3QgYW55IG9uZSBzcGVjaWZpYw0KPj4gaW5zdGFuY2UuIEl0IHdhcyBqdXN0IHRo
YXQsIGZvciBteSB0YXN0ZSwgdGhlIGNvZGUgaGFkIHRvbyBtYW55IHNoaWZ0cw0KPj4gZXRjIGlu
bGluZSB3aXRoIHRoZSByZWFsIGNvZGUuIFJlcGxhY2luZyAxIDw8IHh5el9TSElGVCB3aXRoIEJJ
VCh4eXpfU0hJRlQpDQo+PiBpcyBub3QgYSByZWFsIGltcHJvdmVtZW50LCB0aGV5IGFyZSBqdXN0
IGFib3V0IGVxdWFsIHRvIG1lLCBpdCdzIGp1c3QgdGhhdA0KPj4gdGhlcmUgYXJlIHN0aWxsIHRv
byBtYW55IG1lY2hhbmljYWwgdGhpbmdzIGhhcHBlbmluZyB0aGF0IGNvdWxkIGVhc2lseSBiZQ0K
Pj4gdHVja2VkIGF3YXkgd2l0aCB0aGUgc3VnZ2VzdGVkIGFwcHJvYWNoLg0KPj4NCj4gDQo+IFJp
Z2h0LCBmb3IgeW91ciB0YXN0ZS4gTGlrZSBJIHNhaWQsIEkgZmVlbCB0aGlzIGlzIHZlcnkgc3Vi
amVjdGl2ZS4gVG8NCj4gbWUsIGFuZCBtYW55IG90aGVyIEkyQyBkcml2ZXIgb3duZXJzIChJIGp1
c3QgY2hlY2tlZCBob3cgbWFueSBvdGhlciBJMkMNCj4gZHJpdmVycyBhbHNvIGFwcGVhciB0byBw
cmVmZXIgdG8gdXNlIFhYWF9TSElGVCBhbmQgdGhlcmUgYXJlIGEgbG90IG9mDQo+IHRoZW0pLCB1
c2luZyBYWFhfU0hJRlQgbWFrZXMgaXQgbW9yZSBjbGVhciB0aGF0IHRoZSBkZWZpbmUgaXMgaW50
ZW5kZWQNCj4gdG8gYmUgdXNlZCBmb3IgYml0IHNoaWZ0IG9wZXJhdGlvbi4NCg0KV2hpY2ggaXMg
YSB2ZXJ5IHN0cmFuZ2UgdGhpbmcgdG8gc2F5IGFib3V0IG15IHN1Z2dlc3Rpb24uIFRoZXJlIGlz
IG5vIG5lZWQNCmZvciBhIF9TSElGVCBzdWZmaXggZm9yIHRoZSBtYWNybyBuYW1lcyBpZiB0aGV5
IGFyZSBub3QgZ29pbmcgdG8gdXNlZCBpbg0Kc2hpZnRzISBUaGF0J3MgdGhlIHdob2xlIGZyaWdn
aW4gcG9pbnQuDQoNClJlZ2FyZGluZyBvdGhlciBJMkMgZHJpdmVycywgSSBqdXN0IGhhZCBhIGJy
aWVmIGxvb2sgYXQgYWJvdXQgMTAgb3Igc28NCnBpY2tlZCBhdCByYW5kb20sIGFuZCBOT05FIG9m
IHRoZW0gdXNlIHRoZSBYWFhfU0hJRlQgcGFyYWRpZ20gdGhhdCB0aGlzDQpkcml2ZXIgaXMgdXNp
bmcuIFRoZSBvbmVzIEkgcGlja2VkIHdlcmU6DQoNCmkyYy1hY29ybi5jDQppMmMtYWxpNTYzLmMN
CmkyYy1hbHRlcmEuYw0KaTJjLWF0OTEuYw0KaTJjLWNtcC5jDQppMmMtZGF2aW5jaS5jDQppMmMt
ZGlnaWNvbG9yLmMNCmkyYy1lbGVrdG9yLmMNCmkyYy1zdC5jDQoNClRoZSBvbmx5IG9uZSBJIGxv
b2tlZCBhdCBub3QgZG9pbmcgaXQgdGhlIHdheSBJIHN1Z2dlc3RlZCBpcyBpMmMtZGxuMi5jDQp3
aGljaCBkb2VzIG5vdCBhcHBlYXIgdG8gbmVlZCBhbnkgcmVnaXN0ZXIgZmllbGQgYWNjZXNzZXMg
YXQgYWxsLg0KDQpTbywgcGVyaGFwcyB5b3Ugc2hvdWxkIHJlYWQgdGhlIHN1Z2dlc3Rpb24gYWdh
aW4gd2l0aCBtb3JlIGNhcmU/IE9yIG5vdC4NCkFueXdheSwgSSdtIG5vdCBnb2luZyB0byB3YXN0
ZSBhbnkgbW9yZSB0aW1lIGhlcmUuDQoNCkNoZWVycywNClBldGVyDQoNCj4gDQo+Pj4gSSdsbCBs
ZWF2ZSB0aGUgZGVjaXNpb24gdG8gV29sZnJhbS4gSWYgaGUgYWxzbyBwcmVmZXJzIHRoZSBhYm92
ZSBjaGFuZ2UNCj4+PiB0byBiZSBtYWRlLCBzdXJlLiBPdGhlcndpc2UsIEknbGwgbGVhdmUgaXQg
YXMgaXQgaXMuDQo+Pg0KPj4gQnV0IGlmIHlvdSBzZWUgbm8gdmFsdWUgaW4gbXkgc3VnZ2VzdGlv
biBhbmQvb3IgZG9uJ3Qgd2hhdCB0byB0YWtlIHRoZQ0KPj4gY2xlYW51cCBvbmUgc3RlcCBmdXJ0
aGVyLCB0aGVuIGp1c3QgbGVhdmUgaXQgYXMtaXMuDQo+Pg0KPiANCj4gQWdhaW4sIHRoaXMgaXMg
c3ViamVjdGl2ZS4gUGVyc29uYWxseSBJIGRvIG5vdCBmZWVsIHRoaXMgaXMgImNsZWFudXAgb25l
DQo+IHN0ZXAgZnVydGhlciIuIFRvIG1lLCB0aGlzIGNoYW5nZSB3aWxsIG1ha2UgdGhlIGNvZGUg
bGVzcyBjbGVhciBvbiB0aGUNCj4gaW50ZW5kZWQgb3BlcmF0aW9uLg0KPiANCj4+Pj4gQnV0IGFs
bCB0aGlzIGlzIG9mIGNvdXJzZSBpbiBkZWVwIG5pdC1waWNrLXRlcnJpdG9yeS4uLg0KPj4+Pg0K
Pj4+PiBDaGVlcnMsDQo+Pj4+IFBldGVyDQo+Pj4+DQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4NCj4+
PiBSYXkNCj4+Pg0KPj4NCg0K
