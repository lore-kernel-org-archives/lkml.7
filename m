Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CEEC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D68D20693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Til441M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfDOG47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:56:59 -0400
Received: from mail-eopbgr60115.outbound.protection.outlook.com ([40.107.6.115]:39040
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbfDOG46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvuoyNR9Fi5VWWNO6/3CLIj9l1RgYCTujyMTPuRuHUw=;
 b=Til441M9H4j7WxpE9Z+XJvxthTq/fFxpqZ0Gu2oWg7ubCkTmLjEG+s54+r4XlguS4+9RSpMrYAKagA7uLcLzLsHYiB8b+voQjPsn+V0rXFTibMQ6BbptWMJKunqkdd/EFdphv9f41QpwmXAxn6vkgAfiXP1PaisLwlRffrFj4Ns=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4302.eurprd02.prod.outlook.com (20.177.60.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.16; Mon, 15 Apr 2019 06:56:13 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 06:56:13 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Ray Jui <ray.jui@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Thread-Topic: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Thread-Index: AQHU6mEE3VBQWFg3OEO4UFCMK2X3RqY5U5QAgAOIRgA=
Date:   Mon, 15 Apr 2019 06:56:13 +0000
Message-ID: <c47c6ec2-6d6f-8885-932c-35390783f55b@axentia.se>
References: <20190403210535.32236-1-ray.jui@broadcom.com>
 <f28f604a-55a4-7542-0e13-a92a83ab2144@axentia.se>
In-Reply-To: <f28f604a-55a4-7542-0e13-a92a83ab2144@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::15)
 To VI1PR02MB4542.eurprd02.prod.outlook.com (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdd3efba-a1f9-4dda-b94d-08d6c16f72f4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600140)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:VI1PR02MB4302;
x-ms-traffictypediagnostic: VI1PR02MB4302:
x-microsoft-antispam-prvs: <VI1PR02MB4302A0158F99BCD0F62E6911BC2B0@VI1PR02MB4302.eurprd02.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(39830400003)(346002)(396003)(52314003)(51444003)(189003)(199004)(65956001)(65806001)(66066001)(6116002)(508600001)(6486002)(14454004)(26005)(3846002)(11346002)(446003)(6506007)(386003)(476003)(2616005)(2906002)(102836004)(486006)(52116002)(229853002)(6436002)(53546011)(186003)(14444005)(256004)(4326008)(76176011)(65826007)(25786009)(97736004)(31686004)(6512007)(305945005)(6246003)(53936002)(7736002)(74482002)(99286004)(58126008)(316002)(81166006)(71190400001)(71200400001)(110136005)(54906003)(5660300002)(81156014)(31696002)(86362001)(68736007)(8936002)(64126003)(36756003)(105586002)(8676002)(106356001)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4302;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZpAGzbHj6BcG17Nzd+ZxYvoTGXrla/WpheNMeFsyifG4g7dGy3DHVyVCRScRBTOz3pg78mDkw48yb/qaL3AqNd0qc1xV9PLDb+TEoUjx1p4iuNDxf6UL09CIFvljVeO1L+OA+L9MGUsU09T4bVStXIsLhU2WLDenFzBmdvnsz1Gv1EeUA+jvTwN4hz/+WuxfxMIAq91xUwzp5dvDjDNjWkX6iPSUMSRWVELAErrTGA/Po5PuqoaxBDVwIag+eyBdd405uZoFdQPq3H3yds26Sq5usVvFR+LDsLNVz9o7oJjsjaE3ystwW/eiS5sYSyYopB2Ht26JYwryLF4q39EftxzIonP3SGW3Wpqhkec/lUyS35iGO/NAn+a5vx2FAhHoWR4RDZ0CCuk3CZpJyuL1soCTVFsVxqHnvez+Gzy0Ebc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9361E4A128769543AFC221925C9353DE@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd3efba-a1f9-4dda-b94d-08d6c16f72f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 06:56:13.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0xMyAwMDo1OSwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IE9uIDIwMTktMDQtMDMg
MjM6MDUsIFJheSBKdWkgd3JvdGU6DQo+PiBDaGFuZ2UgdGhlIGlQcm9jIEkyQyBkcml2ZXIgdG8g
dXNlIHRoZSAnQklUJyBtYWNybyBmcm9tIGFsbCAnMSA8PCBYWFgnDQo+PiBiaXQgb3BlcmF0aW9u
cyB0byBnZXQgcmlkIG9mIGNvbXBpbGVyIHdhcm5pbmcgYW5kIGltcHJvdmUgcmVhZGFiaWxpdHkg
b2YNCj4+IHRoZSBjb2RlDQo+IA0KPiBBbGw/IEkgc2VlIGxvdHMgbW9yZSAnMSA8PCBYWFhfU0hJ
RlQnIG1hdGNoZXMuIEkgbWlnaHQgYmUgYmVoaW5kIHRob3VnaD8NCg0KSSB2ZXJpZmllZCB0aGF0
LCBhbmQgeWVzIGluZGVlZCwgSSB3YXMgYmVoaW5kLiBUaGF0IHNhaWQsIHNlZSBiZWxvdy4uLg0K
DQo+IEFueXdheSwgaWYgeW91IGFyZSBjbGVhbmluZyB1cCwgSSdtIGp1c3QgZmxhZ2dpbmcgdGhh
dCBCSVQoWFhYX1NISUZUKSBsb29rcw0KPiBhIGJpdCBjbHVua3kgdG8gbWUuIFlvdSBtaWdodCBj
b25zaWRlciByZW5hbWluZyBhbGwgdGhvc2Ugc2luZ2xlLWJpdA0KPiBYWFhfU0hJRlQgbWFjcm9z
IHRvIHNpbXBsZSBiZQ0KPiANCj4gI2RlZmluZSBYWFggQklUKDx4eHg+KQ0KPiANCj4gaW5zdGVh
ZCBvZg0KPiANCj4gI2RlZmluZSBYWFhfU0hJRlQgPHh4eD4NCj4gDQo+IGJ1dCB0aGF0IHRyaWdn
ZXJzIG1vcmUgY2h1cm4sIHNvIGlzIG9idmlvdXNseSBtb3JlIGVycm9yIHByb25lLiBZb3UgbWln
aHQNCj4gbm90IGRhcmUgaXQ/DQo+IA0KPiBDaGVlcnMsDQo+IFBldGVyDQo+IA0KPj4gU2lnbmVk
LW9mZi1ieTogUmF5IEp1aSA8cmF5Lmp1aUBicm9hZGNvbS5jb20+DQo+PiAtLS0NCj4+ICBkcml2
ZXJzL2kyYy9idXNzZXMvaTJjLWJjbS1pcHJvYy5jIHwgNiArKystLS0NCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWJjbS1pcHJvYy5jIGIvZHJpdmVycy9pMmMvYnVzc2Vz
L2kyYy1iY20taXByb2MuYw0KPj4gaW5kZXggNTYyOTQyZDBjMDVjLi5hODQ1YjhkZWNhYzggMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWJjbS1pcHJvYy5jDQo+PiArKysg
Yi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWJjbS1pcHJvYy5jDQo+PiBAQCAtNzE3LDcgKzcxNyw3
IEBAIHN0YXRpYyBpbnQgYmNtX2lwcm9jX2kyY194ZmVyX3NpbmdsZV9tc2coc3RydWN0IGJjbV9p
cHJvY19pMmNfZGV2ICppcHJvY19pMmMsDQo+PiAgDQo+PiAgCQkJLyogbWFyayB0aGUgbGFzdCBi
eXRlICovDQo+PiAgCQkJaWYgKGkgPT0gbXNnLT5sZW4gLSAxKQ0KPj4gLQkJCQl2YWwgfD0gMSA8
PCBNX1RYX1dSX1NUQVRVU19TSElGVDsNCj4+ICsJCQkJdmFsIHw9IEJJVChNX1RYX1dSX1NUQVRV
U19TSElGVCk7DQo+PiAgDQo+PiAgCQkJaXByb2NfaTJjX3dyX3JlZyhpcHJvY19pMmMsIE1fVFhf
T0ZGU0VULCB2YWwpOw0KPj4gIAkJfQ0KPj4gQEAgLTg0NCw3ICs4NDQsNyBAQCBzdGF0aWMgaW50
IGJjbV9pcHJvY19pMmNfY2ZnX3NwZWVkKHN0cnVjdCBiY21faXByb2NfaTJjX2RldiAqaXByb2Nf
aTJjKQ0KPj4gIA0KPj4gIAlpcHJvY19pMmMtPmJ1c19zcGVlZCA9IGJ1c19zcGVlZDsNCj4+ICAJ
dmFsID0gaXByb2NfaTJjX3JkX3JlZyhpcHJvY19pMmMsIFRJTV9DRkdfT0ZGU0VUKTsNCj4+IC0J
dmFsICY9IH4oMSA8PCBUSU1fQ0ZHX01PREVfNDAwX1NISUZUKTsNCj4+ICsJdmFsICY9IH5CSVQo
VElNX0NGR19NT0RFXzQwMF9TSElGVCk7DQo+PiAgCXZhbCB8PSAoYnVzX3NwZWVkID09IDQwMDAw
MCkgPDwgVElNX0NGR19NT0RFXzQwMF9TSElGVDsNCg0KVGhlc2UgdHdvIHN0YXRlbWVudHMgbm93
IG5vIGxvbmdlciAibWF0Y2giLiBPbmUgdXNlcyBCSVQgYW5kIHRoZSBvdGhlciBvcGVuDQpjb2Rl
cyB0aGUgc2hpZnQuIEkgdGhpbmsgdGhhdCdzIGJhZC4gTG9zaW5nIHRoZSBfU0hJRlQgc3VmZml4
IGFuZCBpbmNsdWRpbmcNCkJJVCBpbiB0aGUgbWFjcm8gZXhwYW5zaW9uLCBhcyBzdWdnZXN0ZWQg
YWJvdmUsIHlpZWxkczoNCg0KCXZhbCAmPSB+VElNX0NGR19NT0RFXzQwMDsNCglpZiAoYnVzX3Nw
ZWVkID09IDQwMDAwMCkNCgkJdmFsIHw9IFRJTV9DRkdfTU9ERV80MDA7DQoNCndoaWNoIGlzIHBl
cmhhcHMgb25lIG1vcmUgbGluZSwgYnV0IGFsc28gbW9yZSByZWFkYWJsZSBJTU8uDQoNCkJ1dCBh
bGwgdGhpcyBpcyBvZiBjb3Vyc2UgaW4gZGVlcCBuaXQtcGljay10ZXJyaXRvcnkuLi4NCg0KQ2hl
ZXJzLA0KUGV0ZXINCg0KPj4gIAlpcHJvY19pMmNfd3JfcmVnKGlwcm9jX2kyYywgVElNX0NGR19P
RkZTRVQsIHZhbCk7DQo+PiAgDQo+PiBAQCAtOTk1LDcgKzk5NSw3IEBAIHN0YXRpYyBpbnQgYmNt
X2lwcm9jX2kyY19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPj4gIA0KPj4gIAkvKiBjb25m
aWd1cmUgdG8gdGhlIGRlc2lyZWQgYnVzIHNwZWVkICovDQo+PiAgCXZhbCA9IGlwcm9jX2kyY19y
ZF9yZWcoaXByb2NfaTJjLCBUSU1fQ0ZHX09GRlNFVCk7DQo+PiAtCXZhbCAmPSB+KDEgPDwgVElN
X0NGR19NT0RFXzQwMF9TSElGVCk7DQo+PiArCXZhbCAmPSB+QklUKFRJTV9DRkdfTU9ERV80MDBf
U0hJRlQpOw0KPj4gIAl2YWwgfD0gKGlwcm9jX2kyYy0+YnVzX3NwZWVkID09IDQwMDAwMCkgPDwg
VElNX0NGR19NT0RFXzQwMF9TSElGVDsNCj4+ICAJaXByb2NfaTJjX3dyX3JlZyhpcHJvY19pMmMs
IFRJTV9DRkdfT0ZGU0VULCB2YWwpOw0KPj4gIA0KPj4NCj4gDQoNCg==
