Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E1CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9815520693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="C/NhF8lR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfCUNhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:37:38 -0400
Received: from mail-eopbgr150113.outbound.protection.outlook.com ([40.107.15.113]:63558
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfCUNhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkJQWQx8QK7IXfTmo5v69JqYg38bYlQCrtvmr9Erupw=;
 b=C/NhF8lRUEeENjwEMtPFGvNLp0uqNz7k7MaVXoBKBYWMx0t9usObdKWeBJirRHPB1alAsdNZeYuAsD859iiGCMhj4COBmdin35zUcep5ul6Vm2oC+m/1ypliNefurF3rNjgObP3brLDS9cslnJo2teM1hQ5acSg+5XAUnmaGOrU=
Received: from AM6PR07MB5221.eurprd07.prod.outlook.com (20.177.198.83) by
 AM6PR07MB5688.eurprd07.prod.outlook.com (20.178.86.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Thu, 21 Mar 2019 13:37:32 +0000
Received: from AM6PR07MB5221.eurprd07.prod.outlook.com
 ([fe80::f4d0:bea0:7f8:8996]) by AM6PR07MB5221.eurprd07.prod.outlook.com
 ([fe80::f4d0:bea0:7f8:8996%3]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 13:37:32 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     Mike Crowe <mac@mcrowe.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kay Sievers <kay@vrfy.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Re: kmsg: lseek errors confuse glibc's dprintf
Thread-Topic: Re: kmsg: lseek errors confuse glibc's dprintf
Thread-Index: AQHU3+s8uqsVflInEkiQL9fYkRI9PA==
Date:   Thu, 21 Mar 2019 13:37:32 +0000
Message-ID: <1f2823a1-8e4c-4103-ec02-2db1e9ed4a97@nokia.com>
References: <20150115173132.GA7486@mcrowe.com>
 <20190321104726.3c570c41e5757611a13c23ca@gmail.com>
 <20190321123822.npfxumj2gwlwkxlf@mcrowe.com>
In-Reply-To: <20190321123822.npfxumj2gwlwkxlf@mcrowe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.167]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-clientproxiedby: HE1PR0301CA0021.eurprd03.prod.outlook.com
 (2603:10a6:3:76::31) To AM6PR07MB5221.eurprd07.prod.outlook.com
 (2603:10a6:20b:6a::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4321147-2108-4452-6e72-08d6ae025e74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR07MB5688;
x-ms-traffictypediagnostic: AM6PR07MB5688:
x-microsoft-antispam-prvs: <AM6PR07MB5688B0D1A62735EC4D9223DA88420@AM6PR07MB5688.eurprd07.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(316002)(14444005)(256004)(8936002)(6512007)(186003)(102836004)(4326008)(36756003)(229853002)(81166006)(81156014)(64126003)(8676002)(26005)(53936002)(478600001)(65806001)(66066001)(65956001)(52116002)(97736004)(76176011)(68736007)(6506007)(53546011)(386003)(65826007)(6436002)(86362001)(5660300002)(71190400001)(106356001)(71200400001)(105586002)(31696002)(31686004)(446003)(486006)(11346002)(2616005)(305945005)(99286004)(110136005)(7736002)(58126008)(6486002)(6246003)(14454004)(54906003)(2906002)(6116002)(476003)(25786009)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR07MB5688;H:AM6PR07MB5221.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cL13Y9TBzYT+ijYXfXdng/WBxCvyQpEmBGJcKwDgwEho+tXCO1/WlGGOqr3rgoIz3MvZbw2ClWhHhdt88GtTbnuYwpS9GGdz2OLDtle97r04JbK86NDJ8muTGTPP8OTihhhQhOLFCChsOGJQswFcQ8HfnZnE7gtggtvMhXM/bThR8rWLkhbzeRxLgmkE/A0rxGVC5f3tVT+ribVD55VA59SGl2y6lLZJxqyIF4GmVhL+yuyEwEozCxtTSg3UBfuwfLDdIEfGrF+tY5QtEHRJoOwZECe5hPoyJmNjT//7npyUViZVnUNdGwUJUSiAAgvEl+4xqalur7dqRBAlpMR38NehuftqXTNuAY4/d4g4RALFKd2TZ+oz3UgR5BxddJa4lt3ppoFydS0HZRKmxeGx3CXSYyn3RtWwtcymNGI0UOE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E96B568651DF5448AD2253421F44FD0D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4321147-2108-4452-6e72-08d6ae025e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 13:37:32.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB5688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCk9uIDIxLzAzLzIwMTkgMTM6MzgsIE1pa2UgQ3Jvd2Ugd3JvdGU6DQpbLi4uXQ0KPiBJ
IGRvbid0IG1pbmQgcmViYXNpbmcgbXkgcGF0Y2ggb25jZSBJIGtub3cgd2hpY2ggb2YgbXkgdHdv
IHNvbHV0aW9ucyBpcw0KPiBwcmVmZXJyZWQuIEl0IHNlZW1zIHRoYXQgdGhlIC1FU1BJUEUgb25l
IGlzIHRoZSBjdXJyZW50IGZhdm91cml0ZS4NCg0KSSB0aGluazoNCjEuIFNpbmNlIExpbnV4IHY0
LjggKCF1c2VyKSBjYXNlIGluIG5vdCBwb3NzaWJsZSBhbnkgbW9yZSBpZiB0aGUgZGV2aWNlDQog
ICBmaWxlIHdhcyBvcGVuZWQgaW4gd3JpdGUtb25seSBtb2RlLCBzbyB5b3UgYXJlIHByb2JhYmx5
IHNhZmUgdG8gb21pdCB0aGlzDQogICBjaHVuayBhdCBhbGwuDQoNCjIuIE5vdGhpbmcgY29tZXMg
dG8gbXkgbWluZCwgd2hhdCBvbmUgY291bGQgcmV0dXJuIGFzICJjdXJyZW50IHBvc2l0aW9uIg0K
ICAgZnJvbSB0aGUgbHNlZWsoKSBjYWxsIG9uIC9kZXYva21zZy4gU28gd2l0aG91dCBnb29kIGlk
ZWEgd2hhdCB0byByZXR1cm4sDQogICBzdXBwb3J0aW5nIG9mZnNldCA9PSAwICh0aGUgb25seSB0
aGluZyB3ZSBldmVyIGNhbiBzdXBwb3J0IG9uIFNFRUtfQ1VSKQ0KICAgbWFrZXMgbm8gc2Vuc2Ug
dG8gbWUuDQogICBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL2Rldi1rbXNnIG1ha2VzIG5vIHBy
b21pc2Ugb24gU0VFS19DVVIgZWl0aGVyLA0KICAgdGhlcmVmb3JlIEknZCBzYXksIC1FU1BJUEUg
dW5jb25kaXRpb25hbGx5IGlzIHRoZSByaWdodCBjaG9pY2UuDQoNCj4+Pj4gPkZyb20gd2hhdCBJ
IGNhbiB0ZWxsIHByaW9yIHRvIEtheSBTaWV2ZXJzIHByaW50ayByZWNvcmQgY29tbWl0DQo+Pj4g
ZTExZmVhOTJlMTNmYjkxYzUwYmFjY2E3OTlhNjEzMWM4MTkyOTk4NiwgY2FsbGluZyBsc2Vlayhm
ZCwgMCwgU0VFS19DVVIpDQo+Pj4gd2l0aCBzdWNoIGEgZmlsZSBkZXNjcmlwdG9yIHdvdWxkIG5v
dCByZXR1cm4gYW4gZXJyb3IuDQo+Pj4NCj4+PiBQcmlvciB0byBLYXkncyBjaGFuZ2UsIEFybmQg
QmVyZ21hbm4ncyBjb21taXQNCj4+PiA2MDM4ZjM3M2EzZGMxZjFjMjY0OTZlNjBiNmM0MGIxNjQ3
MTZmMDdlIHNlZW1lZCB0byBnbyB0byBzb21lIGxlbmd0aHMgdG8NCj4+PiBwcmVzZXJ2ZSB0aGUg
c3VjY2Vzc2Z1bCByZXR1cm4gY29kZSByYXRoZXIgdGhhbiByZXR1cm5pbmcgKHRoZSBwZXJoYXBz
IG1vcmUNCj4+PiBsb2dpY2FsKSAtRVNQSVBFLg0KPj4+DQo+Pj4gZ2xpYmMgaXMgaGFwcHkgd2l0
aCBlaXRoZXIgYSBzdWNjZXNzZnVsIHJldHVybiBvciAtRVNQSVBFLg0KPj4+DQo+Pj4gRm9yIG1h
eGltdW0gY29tcGF0aWJpbGl0eSBpdCBzZWVtcyB0aGF0IHN1Y2Nlc3Mgc2hvdWxkIGJlIHJldHVy
bmVkIGJ1dA0KPj4+IGdpdmVuIEtheSdzIG5ldyBzZWVrIGludGVyZmFjZSBwZXJoYXBzIHRoaXMg
aXNuJ3QgaGVscGZ1bC4NCj4+Pg0KPj4+IFRoaXMgcGF0Y2ggZW5zdXJlcyB0aGF0IHN1Y2ggYSBz
ZWVrIHN1Y2NlZWRzOg0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9wcmludGsvcHJpbnRr
LmMgYi9rZXJuZWwvcHJpbnRrL3ByaW50ay5jDQo+Pj4gaW5kZXggMDJkNmI2ZC4uYjNmZjZmMCAx
MDA2NDQNCj4+PiAtLS0gYS9rZXJuZWwvcHJpbnRrL3ByaW50ay5jDQo+Pj4gKysrIGIva2VybmVs
L3ByaW50ay9wcmludGsuYw0KPj4+IEBAIC02OTMsNyArNjkzLDcgQEAgc3RhdGljIGxvZmZfdCBk
ZXZrbXNnX2xsc2VlayhzdHJ1Y3QgZmlsZSAqZmlsZSwgbG9mZl90IG9mZnNldCwgaW50IHdoZW5j
ZSkNCj4+PiAgCWxvZmZfdCByZXQgPSAwOw0KPj4+ICANCj4+PiAgCWlmICghdXNlcikNCj4+PiAt
CQlyZXR1cm4gLUVCQURGOw0KPj4+ICsJCXJldHVybiAod2hlbmNlID09IFNFRUtfQ1VSKSA/IDAg
OiAtRUJBREY7DQo+Pj4gIAlpZiAob2Zmc2V0KQ0KPj4+ICAJCXJldHVybiAtRVNQSVBFOw0KPj4+
ICANCj4+PiBAQCAtNzE4LDYgKzcxOCwxMSBAQCBzdGF0aWMgbG9mZl90IGRldmttc2dfbGxzZWVr
KHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qgb2Zmc2V0LCBpbnQgd2hlbmNlKQ0KPj4+ICAJCXVz
ZXItPmlkeCA9IGxvZ19uZXh0X2lkeDsNCj4+PiAgCQl1c2VyLT5zZXEgPSBsb2dfbmV4dF9zZXE7
DQo+Pj4gIAkJYnJlYWs7DQo+Pj4gKwljYXNlIFNFRUtfQ1VSOg0KPj4+ICsJCS8qIEZvciBjb21w
YXRpYmlsaXR5IHdpdGggdXNlcnNwYWNlIHJlcXVlc3RpbmcgdGhlDQo+Pj4gKwkJICogY3VycmVu
dCBmaWxlIHBvc2l0aW9uLiAqLw0KPj4+ICsJCXJldCA9IDA7DQo+Pj4gKwkJYnJlYWs7DQo+Pj4g
IAlkZWZhdWx0Og0KPj4+ICAJCXJldCA9IC1FSU5WQUw7DQo+Pj4gIAl9DQo+Pj4NCj4+PiAoYWx0
aG91Z2ggaXQgY291bGQgYmUgYXJndWVkIHRoYXQgdGhlICF1c2VyIGNhc2Ugc2hvdWxkIHJldHVy
biAtRVNQSVBFDQo+Pj4gcmF0aGVyIHRoYW4gRUJBREYgc2luY2UgdGhlIGZpbGUgZGVzY3JpcHRv
ciBfaXNfIHZhbGlkLikNCj4+Pg0KPj4+IGFuZCB0aGlzIHBhdGNoIGNhdXNlcyBhIGZhaWx1cmUg
dGhhdCBnbGliYyBpcyBwcmVwYXJlZCB0byBhY2NlcHQ6DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEv
a2VybmVsL3ByaW50ay9wcmludGsuYyBiL2tlcm5lbC9wcmludGsvcHJpbnRrLmMNCj4+PiBpbmRl
eCAwMmQ2YjZkLi5mNmIwYzkzIDEwMDY0NA0KPj4+IC0tLSBhL2tlcm5lbC9wcmludGsvcHJpbnRr
LmMNCj4+PiArKysgYi9rZXJuZWwvcHJpbnRrL3ByaW50ay5jDQo+Pj4gQEAgLTY5Myw3ICs2OTMs
NyBAQCBzdGF0aWMgbG9mZl90IGRldmttc2dfbGxzZWVrKHN0cnVjdCBmaWxlICpmaWxlLCBsb2Zm
X3Qgb2Zmc2V0LCBpbnQgd2hlbmNlKQ0KPj4+ICAJbG9mZl90IHJldCA9IDA7DQo+Pj4gIA0KPj4+
ICAJaWYgKCF1c2VyKQ0KPj4+IC0JCXJldHVybiAtRUJBREY7DQo+Pj4gKwkJcmV0dXJuIC1FU1BJ
UEU7DQo+Pj4gIAlpZiAob2Zmc2V0KQ0KPj4+ICAJCXJldHVybiAtRVNQSVBFOw0KPj4+ICANCj4+
PiBAQCAtNzE4LDYgKzcxOCwxMSBAQCBzdGF0aWMgbG9mZl90IGRldmttc2dfbGxzZWVrKHN0cnVj
dCBmaWxlICpmaWxlLCBsb2ZmX3Qgb2Zmc2V0LCBpbnQgd2hlbmNlKQ0KPj4+ICAJCXVzZXItPmlk
eCA9IGxvZ19uZXh0X2lkeDsNCj4+PiAgCQl1c2VyLT5zZXEgPSBsb2dfbmV4dF9zZXE7DQo+Pj4g
IAkJYnJlYWs7DQo+Pj4gKwljYXNlIFNFRUtfQ1VSOg0KPj4+ICsJCS8qIEZvciBjb21wYXRpYmls
aXR5IHdpdGggdXNlcnNwYWNlIGV4cGVjdGluZyBTRUVLX0NVUg0KPj4+ICsJCSAqIHRvIG5vdCB5
aWVsZCBFSU5WQUwuICovDQo+Pj4gKwkJcmV0ID0gLUVTUElQRTsNCj4+PiArCQlicmVhazsNCj4+
PiAgCWRlZmF1bHQ6DQo+Pj4gIAkJcmV0ID0gLUVJTlZBTDsNCj4+PiAgCX0NCj4+Pg0KPj4+IEVp
dGhlciBtYWtlcyBkcHJpbnRmIHdvcmssIGJ1dCBpcyBlaXRoZXIgdGhlIHJpZ2h0IHNvbHV0aW9u
Pw0KPiANCj4gTWlrZS4NCj4gDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KQWxleGFuZGVyIFN2ZXJk
bGluLg0K
