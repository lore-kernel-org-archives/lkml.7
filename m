Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A7DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3F720850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="eR/r2lfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDKJ2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:28:52 -0400
Received: from mail-eopbgr50114.outbound.protection.outlook.com ([40.107.5.114]:43790
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbfDKJ2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g/out8KOMyPeXuf+Fyj+KRdZXwWtmffM8pubPkmq8s=;
 b=eR/r2lfYxQotKXpvrcka4dSLby/STD/8Jtw5cOVmeddTKtSwHd6x9XLPVUW05sKYxPNZhJ/TX1PmOAjkpZPWWRQ3EVQBqsiFxV8ek0WW5QpVoJKuqWc6gQ+iwPuc9US7q4kqZ6TysFoDTnrgNVrvPJUProdq2hFLt2f0j55bzqg=
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com (10.168.188.7) by
 HE1PR0701MB2203.eurprd07.prod.outlook.com (10.168.33.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.8; Thu, 11 Apr 2019 09:28:47 +0000
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3]) by HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3%6]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 09:28:47 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] modpost: make KBUILD_MODPOST_WARN also configurable
 for
Thread-Topic: [PATCH v2] modpost: make KBUILD_MODPOST_WARN also configurable
 for
Thread-Index: AdTvfB/gjVQwJ0l9SOGmgdISIvt+nwAzMgMA
Date:   Thu, 11 Apr 2019 09:28:47 +0000
Message-ID: <fe53aa37-7570-8f5f-2114-337fd1d1eedc@nokia.com>
References: <HE1PR0701MB2652D08633C7322BDEABDACBFA2E0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
In-Reply-To: <HE1PR0701MB2652D08633C7322BDEABDACBFA2E0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-clientproxiedby: HE1P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::33)
 To HE1PR0701MB2652.eurprd07.prod.outlook.com (2603:10a6:3:98::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8cec40f-e6ca-459d-e0bc-08d6be60197a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR0701MB2203;
x-ms-traffictypediagnostic: HE1PR0701MB2203:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <HE1PR0701MB220332C066139C67295802BCFA2F0@HE1PR0701MB2203.eurprd07.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(6436002)(31686004)(305945005)(446003)(6246003)(110136005)(11346002)(4326008)(966005)(7736002)(316002)(65806001)(3846002)(5660300002)(53936002)(2906002)(478600001)(2616005)(99286004)(65956001)(186003)(6512007)(6306002)(14454004)(476003)(6116002)(486006)(53546011)(65826007)(76176011)(68736007)(6506007)(256004)(102836004)(106356001)(52116002)(229853002)(66066001)(105586002)(81166006)(25786009)(31696002)(2201001)(36756003)(14444005)(71200400001)(58126008)(81156014)(26005)(64126003)(97736004)(71190400001)(8936002)(386003)(86362001)(2501003)(6486002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2203;H:HE1PR0701MB2652.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cBbe41Y7ulkqYeaCKX3raIR0ArPy6BddGMqTLQHCcKg2xFnxK0I8iogs50SUSmwWTdCoTPdaGLYjV8QuXb99bO8cK5YgWWeQzU5c5u3pDwr93ZuceJWlVC6i+xN4dxGcuyBBDF7aNxAMAFkLYOwbbmP0kf2horSyvgLWXxE1alZAcPQU6lAVsmj4yXG3Qnhjs5KCdT2+b0kBZmFE1C1bLcHHi/sbbytkPWkDpHPt/6MZrjOb3OfkRQzTlUR4orIwOBLNuDM7pRLOff630mKq+jh9JDpI++PTA4pcC3cswKuCmPEBVRyQBi/xdhWJbmcs4iAUzPKWw6iCl+XgG4Y+dyt11JEcLbI5eXsL4sQdcAfnLEFodVIMvLF7QmauUehBFPqvtoBLi2kGHrTv4P1DAN+3Y9GpA9cSIS26clGZY+4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EF6FB3AB6FC264597264F565FCCFF4C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cec40f-e6ca-459d-e0bc-08d6be60197a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 09:28:47.6267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c2VlbXMgc3ViamVjdCBpcyBpbmNvbXBsZXRlIGluIHYyLCB2MyBwb3N0ZWQ6DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTA2MDUwNS8NCg0KVGhhbmtzIQ0KDQotIFds
YWRpc2xhdg0KDQpPbiAxMC4wNC4yMDE5IDExOjIzLCBXaWViZSwgV2xhZGlzbGF2IChOb2tpYSAt
IERFL1VsbSkgd3JvdGU6DQo+IENvbW1pdCBlYTgzN2YxYzA1MDMgKCJrYnVpbGQ6IG1ha2UgbW9k
cG9zdCBwcm9jZXNzaW5nIGNvbmZpZ3VyYWJsZSIpDQo+IHdhcyBpbnRlbmRlZCB0byBnaXZlIEtC
VUlMRF9NT0RQT1NUX1dBUk4gZmxleGliaWxpdHkgdG8gYmUgY29uZmlndXJhYmxlLg0KPiBSaWdo
dCBub3cgS0JVSUxEX01PRFBPU1RfV0FSTiBnZXRzIGp1c3QgaWdub3JlZCB3aGVuIEtCVUlMRF9F
WFRNT0QgaXMNCj4gc2V0IHdoaWNoIGhhcHBlbnMgcGVyIGRlZmF1bHQgd2hlbiBidWlsZGluZyBt
b2R1bGVzIG91dCBvZiB0aGUgdHJlZS4NCj4gDQo+IFRoaXMgY2hhbmdlIGdpdmVzIHRoZSBvcHBv
cnR1bml0eSB0byBkZWZpbmUgbW9kdWxlIGJ1aWxkIGJlaGF2aW5nIGFsc28NCj4gaW4gY2FzZSBv
ZiBvdXQgb2YgdHJlZSBidWlsZHMgYW5kIGRlZmF1bHQgd2lsbCBiZWNvbWUgZXhpdCBvbiBlcnJv
ci4NCj4gRXJyb3JzIHdoaWNoIGNhbiBiZSBkZXRlY3RlZCBieSB0aGUgYnVpbGQgc2hvdWxkIGJl
IHRyYXBwZWQgb3V0IG9mIHRoZSBib3gNCj4gdGhlcmUsIHVubGVzcyBzb21lYm9keSB3YW50cyB0
byBub3RpY2UgYnJva2VuIHN0dWZmIGxhdGVyIGF0IHJ1bnRpbWUuDQo+IA0KPiBBcyB0aGlzIHBh
dGNoIGNoYW5nZXMgdGhlIGRlZmF1bHQgYmVoYXZpbmcgZnJvbSB3YXJuaW5nIHRvIGVycm9yLA0K
PiB1c2VycyBjYW4gY29uc2lkZXIgdG8gZml4IGl0IGZvciBleHRlcm5hbCBtb2R1bGUgYnVpbGRz
IGJ5Og0KPiAtIHByb3ZpZGluZyBtb2R1bGUgc3ltYm9sIHRhYmxlIHZpYSBLQlVJTERfRVhUUkFf
U1lNQk9MUyBmb3INCj4gICAgbW9kdWxlcyB3aGljaCBhcmUgZGVwZW5kZW50DQo+IC0gT1IgZ2V0
dGluZyBvbGQgYmVoYXZpbmcgYmFjayBieSBwYXNzaW5nIEtCVUlMRF9NT0RQT1NUX1dBUk4gdG8g
dGhlIGJ1aWxkDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXbGFkaXNsYXYgV2llYmUgPHdsYWRpc2xh
di53aWViZUBub2tpYS5jb20+DQo+IC0tLQ0KPiAgIHNjcmlwdHMvTWFrZWZpbGUubW9kcG9zdCB8
IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9zY3JpcHRzL01ha2VmaWxlLm1vZHBvc3QgYi9zY3JpcHRzL01h
a2VmaWxlLm1vZHBvc3QNCj4gaW5kZXggNmI3ZjM1NGYxODlhLi5mZWM2ZWMyZmZhNDcgMTAwNjQ0
DQo+IC0tLSBhL3NjcmlwdHMvTWFrZWZpbGUubW9kcG9zdA0KPiArKysgYi9zY3JpcHRzL01ha2Vm
aWxlLm1vZHBvc3QNCj4gQEAgLTc4LDcgKzc4LDcgQEAgbW9kcG9zdCA9IHNjcmlwdHMvbW9kL21v
ZHBvc3QgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgJChpZiAkKEtCVUlMRF9FWFRSQV9TWU1C
T0xTKSwgJChwYXRzdWJzdCAlLCAtZSAlLCQoS0JVSUxEX0VYVFJBX1NZTUJPTFMpKSkgXA0KPiAg
ICAkKGlmICQoS0JVSUxEX0VYVE1PRCksLW8gJChtb2R1bGVzeW1maWxlKSkgICAgICBcDQo+ICAg
ICQoaWYgJChDT05GSUdfU0VDVElPTl9NSVNNQVRDSF9XQVJOX09OTFkpLCwtRSkgIFwNCj4gLSAk
KGlmICQoS0JVSUxEX0VYVE1PRCkkKEtCVUlMRF9NT0RQT1NUX1dBUk4pLC13KQ0KPiArICQoaWYg
JChLQlVJTERfTU9EUE9TVF9XQVJOKSwtdykNCj4gICANCj4gICBNT0RQT1NUX09QVD0kKHN1YnN0
IC1pLC1uLCQoZmlsdGVyIC1pLCQoTUFLRUZMQUdTKSkpDQo+ICAgDQo+IA0K
