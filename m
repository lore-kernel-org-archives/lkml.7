Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016EEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C20208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="lLP9DZrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDHIDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:03:31 -0400
Received: from mail-eopbgr50093.outbound.protection.outlook.com ([40.107.5.93]:1349
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfDHIDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrswyXxbZB5BGyn8HvQz64CGKwyXKaoof0kt7s2TE0M=;
 b=lLP9DZrz1nFQhju/VO14L/jrwTEIUAsWiILuZ1G4xFrPD+Zwn6G63H6hTWVwhUxkCR+58bC3R7np+wVTdJeNKOeIiOQDJ2/jnuWpLUY+bMS7g1zL9MyA0qnClVJtVI40bd4FkBcX/ob9atxvgreZ2knrexf0Xux9bs7RCmbd28U=
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com (10.168.188.7) by
 HE1PR0701MB2842.eurprd07.prod.outlook.com (10.168.91.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.8; Mon, 8 Apr 2019 08:02:46 +0000
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3]) by HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3%6]) with mapi id 15.20.1792.009; Mon, 8 Apr 2019
 08:02:46 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
Thread-Topic: [PATCH] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
Thread-Index: AdTjuez0lIeTgqS2RiGNuzvA7YdwJAJZwhOAADAfPAA=
Date:   Mon, 8 Apr 2019 08:02:46 +0000
Message-ID: <77e11884-f520-d983-3d33-ccc3043ba604@nokia.com>
References: <HE1PR0701MB2652FC3F5D8E46EA93AF033AFA5F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
 <CAK7LNAQEQyEyj_ozkARj8xjDf7EncHeBv0GY8xoP8e_Fn-qaag@mail.gmail.com>
In-Reply-To: <CAK7LNAQEQyEyj_ozkARj8xjDf7EncHeBv0GY8xoP8e_Fn-qaag@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-clientproxiedby: HE1PR0902CA0008.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::18) To HE1PR0701MB2652.eurprd07.prod.outlook.com
 (2603:10a6:3:98::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d7480a0-5fc3-4871-a355-08d6bbf89609
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR0701MB2842;
x-ms-traffictypediagnostic: HE1PR0701MB2842:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <HE1PR0701MB2842E4EC6048D2F4758ED1D8FA2C0@HE1PR0701MB2842.eurprd07.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(396003)(376002)(346002)(189003)(199004)(446003)(11346002)(6246003)(186003)(5660300002)(53936002)(99286004)(6512007)(6306002)(66066001)(65956001)(71190400001)(71200400001)(4326008)(486006)(97736004)(476003)(65806001)(6116002)(2616005)(3846002)(478600001)(36756003)(64126003)(53546011)(6506007)(52116002)(6916009)(386003)(68736007)(229853002)(102836004)(105586002)(966005)(86362001)(76176011)(8936002)(31696002)(14454004)(81166006)(7736002)(8676002)(81156014)(14444005)(256004)(106356001)(305945005)(6436002)(54906003)(316002)(25786009)(58126008)(31686004)(2906002)(6486002)(26005)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2842;H:HE1PR0701MB2652.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IxRm6u2/lbSIAOtCHfDlUw/bEyNR4nMTeVt4GhrfnCV4JUrragE0UHldSd3dmhcLJ/ObJuc/EI/5P0jLfkr6rRqpEAdylbJidkHwgmkxVY/ZP40ocJblG4Du+Dyv/vQwOe+HnDVFjw9QlAaNMEPdp2nHobMixwPWvhNBAMgX7WZ/I04pkeY+xOKGyEy2v4diyaRijNYayMENYQ7RsdxUecx6vn5bvj/DJX7SVHdEFU8paP14EXFi2MP7xdT1QiKa891NpMw9E3BRKaIz38Rgqdf4yubypYKCVV4ocruz7M4u08OKZjnHlr/PdSmu6hXnJiCVE2IIb83h+fPILHacMWAkwHalVPj88/uEN4AcnqFqx8Kyly4AFIgn4VdZ7RDqSECmuiSykgFxWPiF2JYgJny6Gse3wOaIYTWXDjdGoF8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92C5F69149506A40A03022265B94D350@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7480a0-5fc3-4871-a355-08d6bbf89609
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 08:02:46.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCk9uIDA3LjA0LjIwMTkgMTE6MDQsIE1hc2FoaXJvIFlhbWFkYSB3cm90ZToNCj4gKCtD
QyBKb25hcyBHb3Jza2kpDQo+IA0KPiANCj4gT24gVHVlLCBNYXIgMjYsIDIwMTkgYXQgNjo1OCBQ
TSBXaWViZSwgV2xhZGlzbGF2IChOb2tpYSAtIERFL1VsbSkNCj4gPHdsYWRpc2xhdi53aWViZUBu
b2tpYS5jb20+IHdyb3RlOg0KPj4NCj4+IENvbW1pdCBlYTgzN2YxYzA1MDMgKCJrYnVpbGQ6IG1h
a2UgbW9kcG9zdCBwcm9jZXNzaW5nIGNvbmZpZ3VyYWJsZSIpDQo+PiB3YXMgaW50ZW5kZWQgdG8g
Z2l2ZSBLQlVJTERfTU9EUE9TVF9XQVJOIGZsZXhpYmlsaXR5IHRvIGJlIGNvbmZpZ3VyYWJsZS4N
Cj4+IFJpZ2h0IG5vdyBLQlVJTERfTU9EUE9TVF9XQVJOIGdldHMganVzdCBpZ25vcmVkIHdoZW4g
S0JVSUxEX0VYVE1PRCBpcw0KPj4gc2V0IHdoaWNoIGhhcHBlbnMgcGVyIGRlZmF1bHQgd2hlbiBi
dWlsZGluZyBtb2R1bGVzIG91dCBvZiB0aGUgdHJlZS4NCj4+DQo+PiBUaGlzIGNoYW5nZSBnaXZl
cyB0aGUgb3Bwb3J0dW5pdHkgdG8gZGVmaW5lIG1vZHVsZSBidWlsZCBiZWhhdmluZyBhbHNvDQo+
PiBpbiBjYXNlIG9mIG91dCBvZiB0cmVlIGJ1aWxkcyBhbmQgZGVmYXVsdCB3aWxsIGJlY29tZSBl
eGl0IG9uIGVycm9yLg0KPj4gRXJyb3JzIHdoaWNoIGNhbiBiZSBkZXRlY3RlZCBieSB0aGUgYnVp
bGQgc2hvdWxkIGJlIHRyYXBwZWQgb3V0IG9mIHRoZSBib3gNCj4+IHRoZXJlLCB1bmxlc3Mgc29t
ZWJvZHkgd2FudHMgdG8gbm90aWNlIGJyb2tlbiBzdHVmZiBsYXRlciBhdCBydW50aW1lLg0KPiAN
Cj4gSWYgYW4gZXh0ZXJuYWwgbW9kdWxlIHJlZmVycyB0byBhIHN5bWJvbA0KPiBwcm92aWRlZCBi
eSBhbm90aGVyIGV4dGVybmFsIG1vZHVsZSwNCj4gdGhpcyBwYXRjaCB3aWxsIHR1cm4gdGhlIHdh
cm5pbmcgaW50byB0aGUgZXJyb3IgYnkgZGVmYXVsdCwNCj4gd2hpY2ggaXMgcHJvYmFibHkgYSBi
YWQgaWRlYS4NCg0KSW5kZWVkLCBleGFjdGx5IHRoaXMgc2hvdWxkIGhhcHBlbi4gWW91IHNob3Vs
ZCBmaXggeW91ciBleHRlcm5hbCBtb2R1bGUgDQpkZXBlbmRlbmNpZXMgYnkgcHJvdmlkaW5nIHRo
ZWlyIHN5bWJvbHMuIFBsZWFzZSB1c2UgZS5nLiANCktCVUlMRF9FWFRSQV9TWU1CT0xTIGluc3Rl
YWQgb2YgY29udmVydGluZyBlcnJvcnMgdG8gd2FybmluZyBhbmQgaG9waW5nIA0KdGhhdCB0aGlu
Z3Mgd2lsbCB3b3JrLiBPciBob3cgZG8geW91IHdhbnQgdG8gbWFrZSBzdXJlIG1vZHVsZSBBIHN0
aWxsIA0KZGVsaXZlcnMgYWxsIHN5bWJvbHMgbmVlZGVkIGJ5IG1vZHVsZSBCIGFmdGVyIGFuIHVw
ZGF0ZS9jaGFuZ2VzPyANCk1hbnVhbGx5IGNvbXBhcmluZyB0aGUgbG9ncyBhZnRlciBhbiB1cGRh
dGUgb3Igd2FpdGluZyB1bnRpbCBpdCB0dXJucyANCm91dCBicm9rZW4gZHVyaW5nIHJ1bi10aW1l
PyBJIHdvdWxkbid0IHNheSB0aGlzIGlzIGEgZ29vZCBpZGVhIDotKQ0KDQoNCj4gSSBzdWdnZXN0
ZWQgYSBkZXNpcmVkIGNoYW5nZSBpbiB0aGUgZm9sbG93aW5nLg0KPiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3BhdGNoLzk5ODA2OTEvDQo+IA0KPiBJIGFtIHBva2luZyBKb25hcyBHb3Jz
a2kNCj4gaWYgaGUgcGxhbnMgdG8gc2VuZCB2Mi4NCg0KSSB3b3VsZG4ndCB2b3RlIGZvciB2MiBi
YXNlZCBvbiBleHBsYW5hdGlvbiBhYm92ZS4NCg0KLSBXbGFkaXNsYXYNCg0KPiANCj4gDQo+PiBT
aWduZWQtb2ZmLWJ5OiBXbGFkaXNsYXYgV2llYmUgPHdsYWRpc2xhdi53aWViZUBub2tpYS5jb20+
DQo+PiAtLS0NCj4+ICAgc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0IHwgMiArLQ0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0IGIvc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0
DQo+PiBpbmRleCA2YjdmMzU0ZjE4OWEuLmZlYzZlYzJmZmE0NyAxMDA2NDQNCj4+IC0tLSBhL3Nj
cmlwdHMvTWFrZWZpbGUubW9kcG9zdA0KPj4gKysrIGIvc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0
DQo+PiBAQCAtNzgsNyArNzgsNyBAQCBtb2Rwb3N0ID0gc2NyaXB0cy9tb2QvbW9kcG9zdCAgICAg
ICAgICAgICAgICAgICAgXA0KPj4gICAgJChpZiAkKEtCVUlMRF9FWFRSQV9TWU1CT0xTKSwgJChw
YXRzdWJzdCAlLCAtZSAlLCQoS0JVSUxEX0VYVFJBX1NZTUJPTFMpKSkgXA0KPj4gICAgJChpZiAk
KEtCVUlMRF9FWFRNT0QpLC1vICQobW9kdWxlc3ltZmlsZSkpICAgICAgXA0KPj4gICAgJChpZiAk
KENPTkZJR19TRUNUSU9OX01JU01BVENIX1dBUk5fT05MWSksLC1FKSAgXA0KPj4gLSAkKGlmICQo
S0JVSUxEX0VYVE1PRCkkKEtCVUlMRF9NT0RQT1NUX1dBUk4pLC13KQ0KPj4gKyAkKGlmICQoS0JV
SUxEX01PRFBPU1RfV0FSTiksLXcpDQo+Pg0KPj4gICBNT0RQT1NUX09QVD0kKHN1YnN0IC1pLC1u
LCQoZmlsdGVyIC1pLCQoTUFLRUZMQUdTKSkpDQo+Pg0KPj4gLS0NCj4+IDIuMTkuMg0KPiANCj4g
DQo+IA0K
