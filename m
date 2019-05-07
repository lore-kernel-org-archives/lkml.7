Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD79C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2AA204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3x2VySYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfEGJvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:51:03 -0400
Received: from mail-eopbgr770083.outbound.protection.outlook.com ([40.107.77.83]:38382
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfEGJvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faN8ZXQ2mbbmV3iwJOFgbryqDijO89wJvYj87GblJt4=;
 b=3x2VySYEHu+1JDqQiNjImPkvsVIeEtX3e3Y7OKNUKhkVo0WM03HwdOXd0c0Wb5XfSL3sxLlQXbO9GP5/6toYQ6BDaMky7RGFA3gyijpzzQuVchTYW3XNy8jd4I8Ln987SI14JJHTjh4rrC1fAMmXMwA5A9fCaXVITqms1PHX/MU=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB4376.namprd02.prod.outlook.com (52.135.237.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 09:50:53 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::4158:f3a1:5e61:54a2]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::4158:f3a1:5e61:54a2%2]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:50:53 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     "Claus H. Stovgaard" <cst@phaseone.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: RE: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1 and
 U2 entries
Thread-Topic: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1 and
 U2 entries
Thread-Index: AQHVANDAIuHRsUnR3UyEXTsOibIOSaZem0WAgAC1gnA=
Date:   Tue, 7 May 2019 09:50:53 +0000
Message-ID: <BYAPR02MB55918A76A1567C3209860748A7310@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
         <1556792423-4833-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
         <30102591E157244384E984126FC3CB4F639E7BA8@us01wembx1.internal.synopsys.com>
 <1557176302.18203.20.camel@phaseone.com>
In-Reply-To: <1557176302.18203.20.camel@phaseone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 633ccc20-c568-40a6-8390-08d6d2d17eda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB4376;
x-ms-traffictypediagnostic: BYAPR02MB4376:
x-ms-exchange-purlcount: 1
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB437600CDA491A81859A1BC6CA7310@BYAPR02MB4376.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(13464003)(76176011)(229853002)(256004)(14454004)(14444005)(102836004)(476003)(25786009)(2906002)(3846002)(6436002)(7696005)(4326008)(478600001)(7736002)(6246003)(8936002)(6116002)(7416002)(6506007)(8676002)(81156014)(99286004)(305945005)(81166006)(66066001)(5660300002)(486006)(186003)(66446008)(66476007)(64756008)(66556008)(73956011)(76116006)(66946007)(33656002)(86362001)(6306002)(55016002)(110136005)(446003)(54906003)(53936002)(11346002)(26005)(68736007)(9686003)(74316002)(316002)(52536014)(71200400001)(71190400001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4376;H:BYAPR02MB5591.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VwRvTL11URmImeJbfkPJyYOcFIWqdkLQ1aYvf6+qWyBkC6obx3IQL+Ywlz8SqRq3ml17+F3y4onus3LJ72zBkvPS8yyP9v2G9Z/VsFMHOo7mVLxolk3rAmwJ7nxYJd4aO+A1nurmGvaBu3vlLj99jpEkLsDLBeL4x3cqDchpiVN+j9xJUD/7x5uvTqTRU32BrR9b2c4cndCEGkW+25xxuJR8ZTk9rwD4WyDORUvhitL9A4x1tvMgGvUrJx+iAlSFBneiAZWnS9XXCeGJcxI4wCP0Pq5aLkag/7nah2yh3/DB95YhPGjKH8nzCPv/PYfBIUdHnWYzV7BVU1gmkHx8K0gJypfIPg00ZiDmnMW82ZnEvKrc8vsb4kRnimYG6j/Q1XWUcI39s5Hm3C6k4XqSiqDoXxHvzxdjuEuJhTau9fs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633ccc20-c568-40a6-8390-08d6d2d17eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:50:53.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2xhdXMsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsYXVzIEgu
IFN0b3ZnYWFyZCBbbWFpbHRvOmNzdEBwaGFzZW9uZS5jb21dDQo+U2VudDogVHVlc2RheSwgTWF5
IDA3LCAyMDE5IDI6MjggQU0NCj5UbzogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3Bz
eXMuY29tPjsgQW51cmFnIEt1bWFyIFZ1bGlzaGENCj48YW51cmFna3VAeGlsaW54LmNvbT47IEdy
ZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBSb2INCj5IZXJy
aW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0u
Y29tPjsgRmVsaXBlIEJhbGJpDQo+PGJhbGJpQGtlcm5lbC5vcmc+DQo+Q2M6IGxpbnV4LXVzYkB2
Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyB2LmFudXJhZ2t1bWFyQGdtYWlsLmNvbQ0KPlN1YmplY3Q6IFJl
OiBbUEFUQ0ggMy8zXSB1c2I6IGR3YzM6IGdhZGdldDogQWRkIHN1cHBvcnQgZm9yIGRpc2FibGlu
ZyBVMSBhbmQgVTINCj5lbnRyaWVzDQo+DQo+SGkgVGhpbmggYW5kIEFudXJhZw0KPg0KPk9uIG1h
biwgMjAxOS0wNS0wNiBhdCAxOToyMSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPg0KPj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyBpbmRleA0KPj4gPiBhMWIxMjZmLi40ZjA5MTJjIDEwMDY0NA0KPj4gPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPj4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPj4gPiBAQCAtMTI4NSw2ICsxMjg1LDEwIEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3Bl
cnRpZXMoc3RydWN0IGR3YzMNCj4+ID4gKmR3YykNCj4+ID4gIAkJCQkic25wcyxkaXNfdTJfc3Vz
cGh5X3F1aXJrIik7DQo+PiA+ICAJZHdjLT5kaXNfZW5ibHNscG1fcXVpcmsgPSBkZXZpY2VfcHJv
cGVydHlfcmVhZF9ib29sKGRldiwNCj4+ID4gIAkJCQkic25wcyxkaXNfZW5ibHNscG1fcXVpcmsi
KTsNCj4+ID4gKwlkd2MtPmRpc191MV9lbnRyeV9xdWlyayA9IGRldmljZV9wcm9wZXJ0eV9yZWFk
X2Jvb2woZGV2LA0KPj4gPiArCQkJCSJzbnBzLGRpc191MV9lbnRyeV9xdWlyayIpOw0KPj4gPiAr
CWR3Yy0+ZGlzX3UyX2VudHJ5X3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYs
DQo+PiA+ICsJCQkJInNucHMsZGlzX3UyX2VudHJ5X3F1aXJrIik7DQo+Pg0KPj4gUGxlYXNlIHVz
ZSAiLSIgcmF0aGVyIHRoYW4gIl8iIGluIHRoZSBwcm9wZXJ0eSBuYW1lcy4NCj4NCj5JIGhhdmUg
dGhvdWdodCBhYm91dCB0aGlzIGZlYXR1cmUgb3ZlciB0aGUgd2Vla2VuZCwgYW5kIHRoaW5rIHRo
ZSBuYW1pbmcgc2hvdWxkIGJlDQo+Y2hhbmdlZCB0byBzb21ldGhpbmcgbGlrZSAic25wcyxib3Mt
dTEtZXhpdC1sYXQtaW4tdXMiDQo+YW5kIG5hbWVkIHRoZSBzYW1lIGluIHRoZSBjb2RlLiBBbmQg
dGhlbiBiZSB0aGUgdmFsdWUgdXNlZCBieSB0aGUNCj5nZXRfY29uZmlnX3BhcmFtcy4gRS5nLiB0
aGUgZGV2aWNlLXRyZWUgaXMgdXNlZCB0byBzZXQgdGhlIHZhbHVlcyBkaXJlY3RseSB1c2VkIGZv
cg0KPmJVeGRldkV4aXRMYXQgaW5zdGVhZCBvZiBuYW1lZCBzb21ldGhpbmcgbm90IHJlbGF0ZWQg
dG8gZXhpdCBsYXRlbmN5Lg0KPg0KPldpdGggdGhpcyB0aGUgbmFtZSBhbmQgZnVuY3Rpb24gaXMg
YSAxIHRvIDEgbWF0Y2gsIGFuZCB5b3UgY2FuIGFtb25nIG90aGVycyBzZXQgaXQgdG8NCj4wIGZv
ciBvcHRhaW5pbmcgd2hhdCBBbnVyYWcgd2FudHMuDQo+DQoNCllvdXIgc3VnZ2VzdGlvbiBsb29r
cyBnb29kIGJ1dCB0aGUgcHJvYmxlbSBpcyB0aGUgVTEgYW5kIFUyIGV4aXQgbGF0ZW5jaWVzIGFy
ZQ0KZml4ZWQgdmFsdWVzIGluIGR3YzMgY29udHJvbGxlcihjYW4gYmUgZm91bmQgaW4gSENTUEFS
QU1TMykuIEFkZGluZyBkaWZmZXJlbnQNCmV4aXQgbGF0ZW5jaWVzIG1heSBtb2RpZnkgdGhlIFUx
U0VML1UyU0VMIHZhbHVlcyBzZW50IGZyb20gdGhlIGhvc3QgYnV0IHRoZSByZWFsDQpkd2MzIGNv
bnRyb2xsZXIgZXhpdCBsYXRlbmNpZXMgYXJlIG5vdCBnZXR0aW5nIGNoYW5nZWQuIEJlY2F1c2Ug
b2YgdGhpcyByZWFzb24gSQ0KaGFkIG9wdGVkICJzbnBzLGRpc191MV9lbnRyeV9xdWlyayIsIHNv
IHRoYXQgdGhlIFUxL1UyIGV4aXQgbGF0ZW5jeSB2YWx1ZXMNCnJlcG9ydGVkIGluIEJPUyBkZXNj
cmlwdG9yIGNhbiBiZSBlaXRoZXIgYmUgemVybyAod2hlbiBVMS9VMiBlbnRyaWVzIG5lZWRzIHRv
IGJlDQpkaXNhYmxlZCkgb3Igbm9uLXplcm8gdmFsdWUgKHJlcG9ydGVkIGluIEhDU1BBUkFNUzMp
IHdoZW4gVTEvVTIgc3RhdGVzIGFsbG93ZWQuDQpCYXNlZCBvbiB0aGlzIEkgdGhpbmsgaXQgaXMg
YmV0dGVyIGlmIHdlIGNhbiBjb250aW51ZSB3aXRoICJzbnBzLGRpcy11MS1lbnRyeS1xdWlyayIN
Cmluc3RlYWQgb2YgdGhlICJzbnBzLGJvcy11MS1leGl0LWxhdC1pbi11cyIuIFBsZWFzZSAgcHJv
dmlkZSB5b3VyIG9waW5pb24gb24gdGhpcy4NCiANCj5SZWdhcmRpbmcgdGhlIGRpc2FibGluZyBv
ZiBVMSAvIFUyLiBJIHNlbmQgdGhpcyB0byBBbnVyYWcNCj5odHRwczovL21hcmMuaW5mby8/bD1s
aW51eC11c2ImbT0xNTU2ODMyOTkzMTE5NTQmdz0yDQo+SGVyZSBpIGNyZWF0ZWQgYSBjb25maWdm
cyBpbnRlcmZhY2Ugd2l0aCB0aGUgbmFtZXMgImxwbV9VMV9kaXNhYmxlIiBhbmQNCj4ibHBtX1Uy
X2Rpc2FibGUiIGZvciBjb250cm9sbGluZyB0aGUgRFRDTCBvZiBkd2MzLCBhbmQgcmVqZWN0DQo+
U0VUX0ZFQVRVUkUoVTEvVTIpDQo+DQo+V2lsbCBzZW5kIHRoaXMgaW4gc2VwZXJhdGUgcGF0Y2gg
dG9tb3Jyb3csIGluIHRoZSBob3BlIHRoYXQgQW51cmFncyBmZWF0dXJlIGNhbg0KPmJlY29tZSBh
IHdheSBmb3IgY29udHJvbGxpbmcgZXhpdCBsYXRlbmN5LCBhbmQgbXkgcGF0Y2ggYmVjb21lIGEg
d2F5IGZvciBkaXNhYmxpbmcNCj5VMS9VMg0KPg0KDQpJIGFncmVlIHdpdGggeW91ciBzdWdnZXN0
aW9uLiBXaGVuIFUxIGFuZCBVMiBlbnRyaWVzIGFyZSBub3QgYWxsb3dlZCAgaXQgaXMgYWx3YXlz
DQpiZXR0ZXIgdG8gcmVwb3J0IHplcm8gdmFsdWUgZm9yIFUxL1UyIGV4aXQgbGF0ZW5jaWVzIGlu
IEJPUyBkZXNjcmlwdG9yIChubyBwb2ludCBpbg0KcmVwb3J0aW5nIG5vbi16ZXJvIGV4aXQgbGF0
ZW5jeSB2YWx1ZXMgd2hlbiBVMS9VMiBzdGF0ZXMgYXJlIG5vdCBhbGxvd2VkKS4gIEFsb25nDQp3
aXRoIHRoYXQgY2hhbmdlcyBmb3IgcHJldmVudGluZyB0aGUgZHdjMyBjb250cm9sbGVyIGZyb20g
aW5pdGlhdGluZyBvciBhY2NlcHRpbmcNClUxL1UyIHJlcXVlc3RzIGFyZSBhbHNvIHJlcXVpcmVk
IChzaW5jZSB0aGVyZSBhcmUgc29tZSBob3N0IHBsYXRmb3JtcyB3aGVyZSBzZW5kaW5nDQowIGV4
aXQgbGF0ZW5jeSBkb2Vzbid0IHdvcmspLiBCYXNlZCBvbiB0aGVzZSBvYnNlcnZhdGlvbnMgSSBi
ZWxpZXZlIGJvdGggeW91ciBwYXRjaA0KY2hhbmdlcyBhbmQgbXkgcGF0Y2ggY2hhbmdlcyBuZWVk
cyB0byBiZSBhZGRlZC4NCg0KQFRoaW5oIE5ndXllbg0KUGxlYXNlIHByb3ZpZGUgeW91ciBvcGlu
aW9uIG9uIHRoaXMNCg0KVGhhbmtzLA0KQW51cmFnIEt1bWFyIFZ1bGlzaGENCg0KPkJSDQo+Q2xh
dXMNCg==
