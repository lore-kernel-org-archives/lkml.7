Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6BAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69B3205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="RHbunMof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbfDDJGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:06:49 -0400
Received: from mail-eopbgr20126.outbound.protection.outlook.com ([40.107.2.126]:33182
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731576AbfDDJGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr8ETtbBWuVFYeMuHz3LxNyfHomAlNkJrkm5fgGW1fU=;
 b=RHbunMofU9ZBM5FFl2nfW3d1zcKVX1GmlmcjJ4UeZiZYFoxBxgbNFxcv4kah+EwOnvuJuUmDjiQ1jnDYVkHGLf10MIPBgPpWojI5pGfOB1288jq+5cBiqtRRXdRNni+Pg7fsL8vGwVQR791cTFWE42aruVyh39kMpfwMubdoeuY=
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com (10.175.243.15) by
 VI1PR07MB6046.eurprd07.prod.outlook.com (20.178.124.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.6; Thu, 4 Apr 2019 09:06:44 +0000
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::9d9d:5fe1:aba2:d483]) by VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::9d9d:5fe1:aba2:d483%4]) with mapi id 15.20.1771.006; Thu, 4 Apr 2019
 09:06:44 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH] axxia-i2c: use auto cmd for last message
Thread-Topic: [PATCH] axxia-i2c: use auto cmd for last message
Thread-Index: AQHU6l9gChLQtTMbxk6AM/TxLPktWqYrtqgA
Date:   Thu, 4 Apr 2019 09:06:43 +0000
Message-ID: <75b57678-2c55-102a-31ba-2f33bdf5f90b@nokia.com>
References: <20190328111858.GA17086@localhost.localdomain>
 <20190403205402.dr2uolmpew45xoxd@ninjato>
In-Reply-To: <20190403205402.dr2uolmpew45xoxd@ninjato>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.166]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
x-clientproxiedby: HE1PR05CA0220.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::20) To VI1PR07MB3165.eurprd07.prod.outlook.com
 (2603:10a6:802:21::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 676aae90-d2b7-4cf1-340a-08d6b8dcdba2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR07MB6046;
x-ms-traffictypediagnostic: VI1PR07MB6046:
x-microsoft-antispam-prvs: <VI1PR07MB6046C186BB2338431C0ECD2088500@VI1PR07MB6046.eurprd07.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(446003)(31686004)(2616005)(229853002)(52116002)(64126003)(6486002)(6436002)(7736002)(316002)(305945005)(4326008)(14454004)(31696002)(54906003)(97736004)(486006)(53936002)(6512007)(5660300002)(65826007)(11346002)(86362001)(66066001)(58126008)(81156014)(8936002)(36756003)(81166006)(6916009)(65956001)(105586002)(99286004)(476003)(478600001)(71200400001)(106356001)(25786009)(6116002)(6246003)(3846002)(8676002)(14444005)(6506007)(386003)(53546011)(256004)(26005)(76176011)(68736007)(2906002)(102836004)(71190400001)(65806001)(15650500001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB6046;H:VI1PR07MB3165.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FVA/bT1IkFovoOa18FJwCkYAdRtRSfkb/Q5aasHzZ1+gIqjbfcf9K0B9KO8TxqKMY81YRiaiu5gLcRPO/E3qCerYyhM0AWyrwNAyAUHKMpsVEEP6/CvQ9ja242eEKxkmY/X8xs1vTI50OdTi/Y6uEZxj96fpZKlW9fomLGWDAU/wgmkXSQ8MWGnqbFvaesjmKgHLhRsClSqZc6lP0OEZxHLHQ+OMmxV/e5nB8Quudvf7+MljBlRUJceWR2l8d8AVKtIUKRIKcOJGfnnICWNjpktGYxT0g47RWVk8E/ZQD8NKFiaUBbBsnfaz93i9ydxNpDg+z4poCtiPVeGdP5IyJnitM5mIkn0jIY5PjymhNszxIsQT3sd9XE9/pngVNRM39Bzl+5MWrSGSRVNdIpu0i8zwB+F1IADI/3lDf0t+feE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBA23CB037C0CB40ADAA1C73BDF84E97@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676aae90-d2b7-4cf1-340a-08d6b8dcdba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 09:06:43.8841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gV29sZnJhbSwNCg0KT24gMDMvMDQvMjAxOSAyMjo1NCwgV29sZnJhbSBTYW5nIHdyb3Rl
Og0KPj4gU29tZSByZWNlbnQgY29tbWl0cyB0byB0aGlzIGRyaXZlciB3ZXJlIHRyeWluZyB0byBt
YWtlIHN1cmUgdGhlIFRTUw0KPj4gaW50ZXJydXB0IGlzIG5vdCBnZW5lcmF0ZWQgb24gYnVzeSBz
eXN0ZW0gZHVlIHRvIDI1bXMgdGltZXIgZXhwaXJpbmcNCj4+IGJldHdlZW4gY29tbWFuZHMuIEl0
IGNhbiBzdGlsbCBoYXBwZW4sIGhvd2V2ZXIgaWYgU1RPUCBjb21tYW5kIGlzIG5vdA0KPj4gaXNz
dWVkIG9uIHRpbWUgYXQgdGhlIGVuZCBvZiB0aGUgdHJhbnNtaXNzaW9uLiBJZiB3YWl0X2Zvcl9j
b21wbGV0aW9uIGluDQo+PiBheHhpYV9pMmNfeGZlcl9tc2coKSB3b3VsZCBub3QgcmV0dXJuIGFm
dGVyIDI1bXMgb2YgZ2V0dGluZyBhbg0KPj4gaW50ZXJydXB0LCBUU1Mgd2lsbCBiZSBnZW5lcmF0
ZWQgYW5kIGlkZXYtPmVycl9tc2cgd2lsbCBiZSBzZXQgdG8NCj4+IC1FVElNRURPVVQgd2hpY2gg
d2lsbCBiZSByZXR1cm5lZCBmcm9tIHRoZSBheHhpYV9pMmNfeGZlcl9tc2coKSwgZXZlbg0KPj4g
dGhvdWdoIHRoZSB0cmFuc2ZlciBkaWQgYWN0dWFsbHkgc3VjY2VlZCAoU1RPUCBpcyBhdXRvbWF0
aWNhbGx5IGlzc3VlZA0KPj4gd2hlbiBUU1MgdHJpZ2dlcnMpLg0KPj4NCj4+IEZvcnR1bmF0ZWx5
LCBhcGFydCBmcm9tIGFscmVhZHkgdXNlZCBtYW51YWwgYW5kIHNlcXVlbmNlIGNvbW1hbmRzLCB0
aGUNCj4+IGNvbnRyb2xsZXIgYWxzbyBoYXMgc28gY2FsbGVkIGF1dG8gY29tbWFuZC4gSXQgd29y
a3MganVzdCBsaWtlIG1hbnVhbA0KPj4gbW9kZSBidXQgaXQgYnV0IGFuIGF1dG9tYXRpYyBTVE9Q
IGlzIGlzc3VlZCB3aGVuIGVpdGhlciB0cmFuc2ZlciBsZW5ndGgNCj4+IGlzIG1ldCBvciBOQUsg
aXMgcmVjZWl2ZWQgZnJvbSBzbGF2ZSBkZXZpY2UuDQo+Pg0KPj4gVGhpcyBwYXRjaCBjaGFuZ2Vz
IHRoZSBheHhpYV9pMmNfeGZlcl9tc2coKSBmdW5jdGlvbiBzbyB0aGF0IGF1dG8NCj4+IGNvbW1h
bmQgaXMgdXNlZCBmb3IgbGFzdCBtZXNzYWdlIGluIHRyYW5zYWN0aW9uIGxldHRpbmcgaGFyZHdh
cmUgbWFuYWdlDQo+PiBpc3N1aW5nIFNUT1AuIFRTUyBpcyBkaXNhYmxlZCBqdXN0IGFmdGVyIGNv
bW1hbmQgdHJhbnNmZXJyaW5nIGxhc3QNCj4+IG1lc3NhZ2UgZmluaXNoZXMuIEF1dG8gY29tbWFu
ZCwganVzdCBsaWtlIHNlcXVlbmNlLCBlbmRzIHdpdGggU1MNCj4+IGludGVycnVwdCBpbnN0ZWFk
IG9mIFNOUyBzbyBoYW5kbGluZyBvZiBib3RoIGhhZCB0byBiZSB1bmlmaWVkLg0KPj4NCj4+IFRo
ZSBheHhpYV9pMmNfc3RvcCgpIGlzIG5vIGxvbmdlciBuZWVkZWQgYXMgdGhlIHRyYW5zZmVyIGNh
biBvbmx5IGVuZA0KPj4gd2l0aCBmb2xsb3dpbmcgY29uZGl0aW9uczoNCj4+IC0gZnVsbHkgc3Vj
Y2Vzc2Z1bCAtIHRoZW4gbGFzdCBtZXNzYWdlIHdhcyBzZW5kIGJ5IEFVVE8gY29tbWFuZCBhbmQg
U1RPUA0KPj4gICB3YXMgaXNzdWVkIGF1dG9tYXRpY2FsbHkNCj4+IC0gTkFLIHJlY2VpdmVkIC0g
U1RPUCBpcyBpc3N1ZWQgYXV0b21hdGljYWxseSBieSBjb250cm9sbGVyDQo+PiAtIGFyYml0cmF0
aW9uIGxvc3QgLSBTVE9QIHNob3VsZCBub3QgYmUgaXNzdWVkIGFzIHdlIGRvbid0IGNvbnRyb2wg
dGhlDQo+PiAgIGJ1cw0KPj4gLSBJUCBpbnRlcnJ1cHQgcmVjZWl2ZWQgLSB0aGlzIGlzIHNlbnQg
d2hlbiB0cmFuc2ZlciBsZW5ndGggaXMgc2V0IHRvIDANCj4+ICAgZm9yIGF1dG8vc2VxdWVuY2Ug
Y29tbWFuZC4gVGhlIGNoZWNrIGZvciB0aGF0IGlzIGRvbmUgYmVmb3JlIFNUQVJUIGlzDQo+PiAg
IHNlbmQgc28gbm8gU1RPUCBpcyByZXF1aXJlZA0KPj4gLSBUU1MgcmVjZWl2ZWQgYmV0d2VlbiBj
b21tYW5kcyAtIFNUT1AgaXMgaXNzdWVkIGJ5IHRoZSBjb250cm9sbGVyDQo+IEkgYW0gbm90IHN1
cmUuIElzIHRoaXMgYSBidWdmaXggKD0gZm9yLWN1cnJlbnQpIG9yIG1vcmUgYSBuZXcgZmVhdHVy
ZSAoPQ0KPiBmb3ItbmV4dCk/DQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEFkYW1z
a2kgPGtyenlzenRvZi5hZGFtc2tpQG5va2lhLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBbGV4YW5k
ZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBub2tpYS5jb20+DQo+IEkgdHJ1c3QgeW91
IHRoYXQgQWxleGFuZGVyIGdhdmUgdGhlIHJldmlldywgYnV0IGl0IHdvdWxkIGJlIGEgdGFkIG1v
cmUNCj4gJ29wZW4gZGV2ZWxvcG1lbnQnIGlmIGhlIGNvdWxkIGdpdmUgaXQgYXMgYSByZXBseSB0
byB5b3VyIHBhdGNoIG9uIHRoZQ0KPiBtYWlsaW5nIGxpc3QuDQoNCnN1cmUsIGhlcmUgaXQgaXM6
DQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Abm9r
aWEuY29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywNCkFsZXhhbmRlciBTdmVyZGxpbi4NCg==
