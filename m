Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8990CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BB12084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BRJig3s9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDII4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:56:20 -0400
Received: from mail-eopbgr720051.outbound.protection.outlook.com ([40.107.72.51]:44416
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfDII4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqiZnpK5V9WbRst/VA7HljpI6+m3D5LGfkK7qneYjaY=;
 b=BRJig3s9KKW/9uYwDA2aBwLgDi9eSHE+WzPS1wIUCPkbzDkV+i5foR/Bpn1u1o8vSCYCvAIOqm+YdGlgOtIf7XIsFz6o73aTmcq+X9hEl0gynmMeXmIBNFIurWLRX0cpplF+VicQYWWWO0GPn/YP/Zrurkqrit+dvgK5HOD2Jws=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4679.namprd02.prod.outlook.com (52.135.232.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 9 Apr 2019 08:54:34 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::55ca:e7d8:c514:8276]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::55ca:e7d8:c514:8276%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 08:54:34 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Michal Simek <michals@xilinx.com>, Moritz Fischer <mdf@kernel.org>
CC:     "atull@kernel.org" <atull@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH v4 1/3] firmware: xilinx: Add fpga API's
Thread-Topic: [PATCH v4 1/3] firmware: xilinx: Add fpga API's
Thread-Index: AQHU6VAZ4tFbEHss4EWp4uYyaudcSqYyiowAgADfKgCAAAfKsA==
Date:   Tue, 9 Apr 2019 08:54:34 +0000
Message-ID: <BYAPR02MB471005801CE9F16523516611C22D0@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-2-nava.manne@xilinx.com> <20190408171456.GA4293@archbook>
 <9ab8f7fb-0936-3635-60fe-164402780429@xilinx.com>
In-Reply-To: <9ab8f7fb-0936-3635-60fe-164402780429@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2860dd0-9e37-4273-2cd5-08d6bcc8fd2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB4679;
x-ms-traffictypediagnostic: BYAPR02MB4679:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB4679E75EE9BD2E841752F8B1C22D0@BYAPR02MB4679.namprd02.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(366004)(376002)(13464003)(199004)(189003)(51914003)(106356001)(68736007)(6506007)(14444005)(256004)(71190400001)(53546011)(71200400001)(229853002)(76176011)(19627235002)(33656002)(93886005)(8936002)(81156014)(81166006)(102836004)(110136005)(26005)(8676002)(105586002)(186003)(9686003)(53936002)(54906003)(476003)(316002)(446003)(11346002)(55016002)(6246003)(486006)(2906002)(97736004)(5660300002)(52536014)(6436002)(4326008)(99286004)(6116002)(3846002)(478600001)(74316002)(7696005)(7736002)(305945005)(14454004)(25786009)(86362001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4679;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mTazn5wwH6NXGvPxqXXQpZ4JRYIyqQkiPPaxshDFMm2G5k4DIPfJw5nU1MmuEjSS7KX3os0yzZUy/2p8PX5sx5qSM+UgqaiASqOVtVAzkL9QtZGDcBxQvd2fEIW7o6nge6DtQuA0VrHw562VmLImMtTppzn4tbsUU77LP43jdypgowRx5C+B5reKZACLpHg+8pmE+qEOJ7Vnv6MxRl3s6OTJ3KBs9aNCggb6pvK0+NB/2E6IqFzv/PX28zv2gqPhz97BP5jIWwKSZ6lIMDF6ew32eVp8vpkQWult7lkpQqqx7Mh4MfwD/a308uL6Ps2wSIBMc+9/lOKp53bDLkK4jzidaB37yY+fo7eXjMlbjwLwnOwdwkWuJabIx1AqF5Bp0oVDujL+ky1s2JoPyAe4XaODt081DDkEGBDgtakrUdM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2860dd0-9e37-4273-2cd5-08d6bcc8fd2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 08:54:34.4933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTW9yaXR6LA0KDQpUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZS4NClBsZWFzZSBmaW5k
IG15IHJlc3BvbnNlIGlubGluZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IE1pY2hhbCBTaW1layBbbWFpbHRvOm1pY2hhbC5zaW1la0B4aWxpbnguY29tXQ0KPiBTZW50
OiBUdWVzZGF5LCBBcHJpbCA5LCAyMDE5IDEyOjA0IFBNDQo+IFRvOiBNb3JpdHogRmlzY2hlciA8
bWRmQGtlcm5lbC5vcmc+OyBOYXZhIGtpc2hvcmUgTWFubmUNCj4gPG5hdmFtQHhpbGlueC5jb20+
DQo+IENjOiBhdHVsbEBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFu
ZEBhcm0uY29tOyBNaWNoYWwNCj4gU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IFJhamFuIFZh
amEgPFJBSkFOVkB4aWxpbnguY29tPjsgSm9sbHkgU2hhaA0KPiA8Sk9MTFlTQHhpbGlueC5jb20+
OyBsaW51eC1mcGdhQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gY2hpbm5pa2lzaG9yZTM2OUBnbWFpbC5jb20NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NCAxLzNdIGZpcm13YXJlOiB4aWxpbng6IEFkZCBmcGdhIEFQSSdzDQo+IA0K
PiBPbiAwOC4gMDQuIDE5IDE5OjE0LCBNb3JpdHogRmlzY2hlciB3cm90ZToNCj4gPiBIaSBOYXZh
LA0KPiA+DQo+ID4gT24gVHVlLCBBcHIgMDIsIDIwMTkgYXQgMDY6MDE6MjFQTSArMDUzMCwgTmF2
YSBraXNob3JlIE1hbm5lIHdyb3RlOg0KPiA+PiBUaGlzIFBhdGNoIEFkZHMgZnBnYSBBUEkncyB0
byBzdXBwb3J0IHRoZSBCaXRzdHJlYW0gbG9hZGluZyBieSB1c2luZw0KPiA+PiBmaXJtd2FyZSBp
bnRlcmZhY2UuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE5hdmEga2lzaG9yZSBNYW5uZSA8
bmF2YS5tYW5uZUB4aWxpbnguY29tPg0KPiA+PiAtLS0NCj4gPj4gQ2hhbmdlcyBmb3IgdjQ6DQo+
ID4+IAkJLU5vbmUuDQo+ID4+DQo+ID4+IENobmFnZXMgZm9yIHYzOg0KPiA+PiAJCS1DcmVhdGVk
IHBhdGNoZXMgb24gdG9wIG9mIDUuMC1yYzUuDQo+ID4+IAkJIE5vIGZ1bmN0aW9uYWwgY2hhbmdl
cy4NCj4gPj4NCj4gPj4gQ2hhbmdlcyBmb3IgdjI6DQo+ID4+IAkJLUFkZGVkIEZpcm13YXJlIEZQ
R0EgTWFuYWdlciBmbGFncyBBcyBzdWdnZXN0ZWQgYnkNCj4gPj4gCQkgTW9yaXR6Lg0KPiA+Pg0K
PiA+PiBDaGFuZ2VzIGZvciB2MToNCj4gPj4gCQktTm9uZS4NCj4gPj4NCj4gPj4gQ2hhbmdlcyBm
b3IgUkZDLVYyOg0KPiA+PiAJCS1OZXcgUGF0Y2gNCj4gPj4NCj4gPj4gIGRyaXZlcnMvZmlybXdh
cmUveGlsaW54L3p5bnFtcC5jICAgICB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPj4gIGluY2x1ZGUvbGludXgvZmlybXdhcmUveGxueC16eW5xbXAuaCB8IDEwICsrKysrKw0K
PiA+PiAgMiBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYw0KPiA+PiBiL2RyaXZlcnMv
ZmlybXdhcmUveGlsaW54L3p5bnFtcC5jDQo+ID4+IGluZGV4IDk4ZjkzNjEyNTY0My4uNzE1OWE5
MGFiYzQ0IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAu
Yw0KPiA+PiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYw0KPiA+PiBAQCAt
NTM3LDYgKzUzNyw1MCBAQCBzdGF0aWMgaW50IHp5bnFtcF9wbV9yZXNldF9nZXRfc3RhdHVzKGNv
bnN0IGVudW0NCj4genlucW1wX3BtX3Jlc2V0IHJlc2V0LA0KPiA+PiAgCXJldHVybiByZXQ7DQo+
ID4+ICB9DQo+ID4+DQo+ID4+ICsvKg0KPiA+PiArICogenlucW1wX3BtX2ZwZ2FfbG9hZCAtIFBl
cmZvcm0gdGhlIGZwZ2EgbG9hZA0KPiA+PiArICogQGFkZHJlc3M6CUFkZHJlc3MgdG8gd3JpdGUg
dG8NCj4gPj4gKyAqIEBzaXplOglwbCBiaXRzdHJlYW0gc2l6ZQ0KPiA+PiArICogQGZsYWdzOg0K
PiA+PiArICoJQklUKDApIC0gQml0LXN0cmVhbSB0eXBlLg0KPiA+PiArICoJCSAwIC0gRnVsbCBC
aXRzdHJlYW0uDQo+ID4+ICsgKgkJIDEgLSBQYXJ0aWFsIEJpdHN0cmVhbS4NCj4gPj4gKyAqDQo+
ID4+ICsgKiBUaGlzIGZ1bmN0aW9uIHByb3ZpZGVzIGFjY2VzcyB0byBwbXVmdy4gVG8gdHJhbnNm
ZXINCj4gPj4gKyAqIHRoZSByZXF1aXJlZCBiaXRzdHJlYW0gaW50byBQTC4NCj4gPj4gKyAqDQo+
ID4+ICsgKiBSZXR1cm46IFJldHVybnMgc3RhdHVzLCBlaXRoZXIgc3VjY2VzcyBvciBlcnJvcity
ZWFzb24gICovIHN0YXRpYw0KPiA+PiAraW50IHp5bnFtcF9wbV9mcGdhX2xvYWQoY29uc3QgdTY0
IGFkZHJlc3MsIGNvbnN0IHUzMiBzaXplLA0KPiA+PiArCQkJICAgICAgIGNvbnN0IHUzMiBmbGFn
cykNCj4gPj4gK3sNCj4gPj4gKwlyZXR1cm4genlucW1wX3BtX2ludm9rZV9mbihQTV9GUEdBX0xP
QUQsIGxvd2VyXzMyX2JpdHMoYWRkcmVzcyksDQo+ID4+ICsJCQkJICAgdXBwZXJfMzJfYml0cyhh
ZGRyZXNzKSwgc2l6ZSwgZmxhZ3MsIE5VTEwpOyB9DQo+ID4+ICsNCj4gPj4gKy8qKg0KPiA+PiAr
ICogenlucW1wX3BtX2ZwZ2FfZ2V0X3N0YXR1cyAtIFJlYWQgdmFsdWUgZnJvbSBQQ0FQIHN0YXR1
cyByZWdpc3Rlcg0KPiA+PiArICogQHZhbHVlOiBWYWx1ZSB0byByZWFkDQo+ID4+ICsgKg0KPiA+
PiArICogVGhpcyBmdW5jdGlvbiBwcm92aWRlcyBhY2Nlc3MgdG8gdGhlIHhpbGZwZ2EgbGlicmFy
eSB0byBnZXQNCj4gPg0KPiA+IHhpbGZwZ2E/IElzIHRoYXQgUE1VIGZpcm13YXJlIHlvdSdyZSB0
YWxraW5nIGFib3V0Pw0KDQpYaWxmcGdhIGlzIGEgbGlicmFyeSBhbmQgaXTigJlzIGEgcGFydCBv
ZiBQTVVGVyBCU1AuDQpJdCB3aWxsIGZvbGxvdyB0aGUgYmVsb3cgZmxvdyB0byBjb25maWd1cmUg
dGhlIFBMIGZyb20gTGludXggZW52aXJvbm1lbnQuDQpMaW51eCAtRnBnYSBNYW5hZ2VyIGZyYW1l
d29yayA8LS0+IExpbnV4LUZpcm13YXJlIERyaXZlciA8LSAtc21jIGNhbGwtLT5BVEYgPC0tSVBJ
IGNhbGwtLT4gUE1VRlc8LS0+IFhpbGZwZ2EgbGlicmFyeS4NCg0KPiA+DQo+ID4+ICsgKiB0aGUg
UENBUCBzdGF0dXMNCj4gPj4gKyAqDQo+ID4+ICsgKiBSZXR1cm46IFJldHVybnMgc3RhdHVzLCBl
aXRoZXIgc3VjY2VzcyBvciBlcnJvcityZWFzb24gICovIHN0YXRpYw0KPiA+PiAraW50IHp5bnFt
cF9wbV9mcGdhX2dldF9zdGF0dXModTMyICp2YWx1ZSkgew0KPiA+PiArCXUzMiByZXRfcGF5bG9h
ZFtQQVlMT0FEX0FSR19DTlRdOw0KPiA+PiArCWludCByZXQ7DQo+ID4+ICsNCj4gPj4gKwlpZiAo
IXZhbHVlKQ0KPiA+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPj4gKw0KPiA+PiArCXJldCA9IHp5
bnFtcF9wbV9pbnZva2VfZm4oUE1fRlBHQV9HRVRfU1RBVFVTLCAwLCAwLCAwLCAwLA0KPiByZXRf
cGF5bG9hZCk7DQo+ID4+ICsJKnZhbHVlID0gcmV0X3BheWxvYWRbMV07DQo+ID4+ICsNCj4gPj4g
KwlyZXR1cm4gcmV0Ow0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICAvKioNCj4gPj4gICAqIHp5bnFt
cF9wbV9pbml0X2ZpbmFsaXplKCkgLSBQTSBjYWxsIHRvIGluZm9ybSBmaXJtd2FyZSB0aGF0IHRo
ZSBjYWxsZXINCj4gPj4gICAqCQkJICAgICAgIG1hc3RlciBoYXMgaW5pdGlhbGl6ZWQgaXRzIG93
biBwb3dlciBtYW5hZ2VtZW50DQo+ID4+IEBAIC02NDAsNiArNjg0LDggQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCB6eW5xbXBfZWVtaV9vcHMgZWVtaV9vcHMgPSB7DQo+ID4+ICAJLnJlcXVlc3Rfbm9k
ZSA9IHp5bnFtcF9wbV9yZXF1ZXN0X25vZGUsDQo+ID4+ICAJLnJlbGVhc2Vfbm9kZSA9IHp5bnFt
cF9wbV9yZWxlYXNlX25vZGUsDQo+ID4+ICAJLnNldF9yZXF1aXJlbWVudCA9IHp5bnFtcF9wbV9z
ZXRfcmVxdWlyZW1lbnQsDQo+ID4+ICsJLmZwZ2FfbG9hZCA9IHp5bnFtcF9wbV9mcGdhX2xvYWQs
DQo+ID4+ICsJLmZwZ2FfZ2V0X3N0YXR1cyA9IHp5bnFtcF9wbV9mcGdhX2dldF9zdGF0dXMsDQo+
ID4+ICB9Ow0KPiA+Pg0KPiA+PiAgLyoqDQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2Zpcm13YXJlL3hsbngtenlucW1wLmgNCj4gPj4gYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3hs
bngtenlucW1wLmgNCj4gPj4gaW5kZXggNjQyZGFiMTBmNjVkLi40ZGYyMjZiNmFiMGYgMTAwNjQ0
DQo+ID4+IC0tLSBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUveGxueC16eW5xbXAuaA0KPiA+PiAr
KysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3hsbngtenlucW1wLmgNCj4gPj4gQEAgLTQ4LDYg
KzQ4LDEyIEBADQo+ID4+ICAjZGVmaW5lCVpZTlFNUF9QTV9DQVBBQklMSVRZX1dBS0VVUAkweDRV
DQo+ID4+ICAjZGVmaW5lCVpZTlFNUF9QTV9DQVBBQklMSVRZX1BPV0VSCTB4OFUNCj4gPj4NCj4g
Pj4gKy8qDQo+ID4+ICsgKiBGaXJtd2FyZSBGUEdBIE1hbmFnZXIgZmxhZ3MNCj4gPj4gKyAqIFhJ
TElOWF9aWU5RTVBfUE1fRlBHQV9QQVJUSUFMOiBGUEdBIHBhcnRpYWwgcmVjb25maWd1cmF0aW9u
ICAqLw0KPiA+PiArI2RlZmluZSBYSUxJTlhfWllOUU1QX1BNX0ZQR0FfUEFSVElBTAlCSVQoMCkN
Cj4gPj4gKw0KPiA+PiAgZW51bSBwbV9hcGlfaWQgew0KPiA+PiAgCVBNX0dFVF9BUElfVkVSU0lP
TiA9IDEsDQo+ID4+ICAJUE1fUkVRVUVTVF9OT0RFID0gMTMsDQo+ID4+IEBAIC01Niw2ICs2Miw4
IEBAIGVudW0gcG1fYXBpX2lkIHsNCj4gPj4gIAlQTV9SRVNFVF9BU1NFUlQgPSAxNywNCj4gPj4g
IAlQTV9SRVNFVF9HRVRfU1RBVFVTLA0KPiA+PiAgCVBNX1BNX0lOSVRfRklOQUxJWkUgPSAyMSwN
Cj4gPj4gKwlQTV9GUEdBX0xPQUQgPSAyMiwNCj4gPj4gKwlQTV9GUEdBX0dFVF9TVEFUVVMsDQo+
ID4NCj4gPiBBbnkgcmVhc29uIHlvdSBjYW4ndCBkbyAnUE1fRlBHQV9HRVRfU1RBVFVTID0gMjMn
IGhlcmU/IFRyeWluZyB0bw0KPiA+IHVuZGVyc3RhbmQgeW91ciByZWFzb25pbmcuIEFyZSB5b3Ug
cGxhbm5pbmcgdG8gbW92ZSB0aGVtIGFyb3VuZD8NCj4gDQo+IEl0IGlzIDIzIGJ5IGRlc2lnbi4g
SW4geGlsaW54IHJlcG8gdGhlcmUgd2FzIG9ubHkgdGhlIGZpcnN0IHZhbHVlIHdoaWNoIGlzDQo+
IHJlY29tbWVuZGVkIHByYWN0aWNlLiBCdXQgdXBzdHJlYW1pbmcgaXMgbm90IGRvbmUgaW4gdGhl
IHNhbWUgb3JkZXIgdGhhdCdzDQo+IHdoeSBpZiB0aGVyZSBpcyBhIGdhcCB5b3UgbmVlZCB0byBh
c3NpZ24gdmFsdWVzIHRoZXJlLg0KPiBFdmVuIHRoYXQgMjIgY2FuIGJlIHJlbW92ZWQgaW4gdGhp
cyBjYXNlIGJ1dCBpdCBpcyBqdXN0IG5pdC4NCj4gDQogQXMgTWljaGFsIHNhaWQgaGVyZSBBc3Np
Z25pbmcgdmFsdWUgb2YgMjIgaXMgbm90IG5lZWRlZC4gV2lsbCBmaXggdGhpcyBpc3N1ZSBpbiB0
aGUgbmV4dCB2ZXJzaW9uLg0KDQpSZWdhcmRzLA0KTmF2YWtpc2hvcmUuDQo=
