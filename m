Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A85C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892772087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="e40r7I0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfCYR0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:26:02 -0400
Received: from mail-eopbgr810081.outbound.protection.outlook.com ([40.107.81.81]:39088
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbfCYR0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwK9A6pWFc95JBi1OzCAWySTPc+capGORn+bijMRHBU=;
 b=e40r7I0CT+ZHDHaHJYiXMOU6o5XfVNbbm2o58ikfTpLOc11fMd0HUZh4pZIrv9imspQbo8L26bt0eNpYzxAvM5MKhhg4rzHgxKuCA3xOjznlXpUVZSi3RWE7CzNaINJBjvVVGjWqHPalGezw2KOa5fr0p557+CFQCM4w3QKue/c=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3731.namprd10.prod.outlook.com (20.179.97.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 17:24:16 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 17:24:16 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "nsekhar@ti.com" <nsekhar@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "masonccyang@mxic.com.tw" <masonccyang@mxic.com.tw>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [RFC PATCH v2 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
Thread-Topic: [RFC PATCH v2 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
Thread-Index: AQHU4A390EDhLD8/jkyjBXiay9/acKYWYsWAgAXxyICAAA8cAIAANnGAgAAE64A=
Date:   Mon, 25 Mar 2019 17:24:16 +0000
Message-ID: <f0be796d3662f5b0016edfe73e8665b466b16d20.camel@infinera.com>
References: <20190321174548.9288-1-vigneshr@ti.com>
         <20190321174548.9288-2-vigneshr@ti.com>
         <f92362a0678b07d22ccc0f271fe3483dc77364a9.camel@infinera.com>
         <b1961c49-6795-89e7-e154-6270bf43d49c@ti.com>
         <107cd92703919f97f4cf2d9cd279b091bc90518e.camel@infinera.com>
         <08f5424f-3ce3-492a-d2b3-4798993d35b9@ti.com>
In-Reply-To: <08f5424f-3ce3-492a-d2b3-4798993d35b9@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30bd28cd-b1e4-461f-8d96-08d6b146b548
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BN8PR10MB3731;
x-ms-traffictypediagnostic: BN8PR10MB3731:
x-microsoft-antispam-prvs: <BN8PR10MB3731BA47570B5F4017256F43F45E0@BN8PR10MB3731.namprd10.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(136003)(346002)(43544003)(189003)(199004)(305945005)(486006)(3846002)(446003)(2501003)(5660300002)(14444005)(316002)(256004)(5024004)(476003)(8936002)(6116002)(2616005)(11346002)(2906002)(4326008)(6246003)(93886005)(25786009)(105586002)(7416002)(106356001)(97736004)(110136005)(54906003)(71200400001)(71190400001)(36756003)(81156014)(76176011)(26005)(7736002)(2201001)(6436002)(186003)(8676002)(81166006)(53936002)(6506007)(53546011)(102836004)(118296001)(14454004)(99286004)(66066001)(478600001)(72206003)(86362001)(229853002)(68736007)(6512007)(6486002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR10MB3731;H:BN8PR10MB3540.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RZ8SzpXgnyZ0Iu4Xgy+auuZOu0f1Bro2tX0Hebp2D/rX94iPJVl88O/lk66sh8kUXrx2GxOCMOY9H87wCZ6YdCY2+AQssSBP9jx4ynaM9n0+rNnA7XGBLRlGglQFwW+Nub46OjicGrPXsshomZNWdeZfC4KnKNuyTQbL/gb/D1rY3wOurUWaReP3DxQff8RbAR5xjQ5/S34xFuWlh1PIVXsvf3Yx3Dt4ncMFmos0AIh2dPXFDO3nVF0hWUS0/aFfTczCay8j4fEhmgJf+2L51ayCnDjaVYPHUReP52HgtaPVhU8CgfrirfBfRZ2/dl1KNO4DsJde9nmKplDLq0kxkNIxrSmcfKwujiZpC5mehKuZX6VRpOuimfEcUkrik127v3e0aSn1HE/DFYpaJgfV4wD1AYdPxmul2b89Z/M+QyE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27BEA64DFC81754EA89E13D7400AFCC3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bd28cd-b1e4-461f-8d96-08d6b146b548
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 17:24:16.4520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTI1IGF0IDIyOjM2ICswNTMwLCBWaWduZXNoIFJhZ2hhdmVuZHJhIHdy
b3RlOg0KPiANCj4gT24gMjUvMDMvMTkgNzoyMSBQTSwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToN
Cj4gPiBPbiBNb24sIDIwMTktMDMtMjUgYXQgMTg6MjcgKzA1MzAsIFZpZ25lc2ggUmFnaGF2ZW5k
cmEgd3JvdGU6DQo+ID4gPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRz
aWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZS4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gT24g
MjEvMDMvMTkgMTE6NDEgUE0sIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gPiA+IE9uIFRo
dSwgMjAxOS0wMy0yMSBhdCAyMzoxNSArMDUzMCwgVmlnbmVzaCBSYWdoYXZlbmRyYSB3cm90ZToN
Cj4gPiA+ID4gPiBIeXBlckZsYXNoIGRldmljZXMgYXJlIGNvbXBsaWFudCB3aXRoIENGSSBBTUQv
RnVqaXRzdSBFeHRlbmRlZCBDb21tYW5kDQo+ID4gPiA+ID4gU2V0KDB4MDAwMikgZm9yIGZsYXNo
IG9wZXJhdGlvbnMsIHRoZXJlZm9yZSBkcml2ZXJzL210ZC9jaGlwcy9jZmlfY21kc2V0XzAwMDIu
Yw0KPiA+ID4gPiA+IGNhbiBiZSB1c2UgYXMgaXMuIEJ1dCB0aGVzZSBkZXZpY2VzIGRvIG5vdCBz
dXBwb3J0IERRIHBvbGxpbmcgbWV0aG9kIG9mDQo+ID4gPiA+ID4gZGV0ZXJtaW5pbmcgY2hpcCBy
ZWFkeS9nb29kIHN0YXR1cy4gVGhlc2UgZmxhc2hlcyBwcm92aWRlIFN0YXR1cw0KPiA+ID4gPiA+
IFJlZ2lzdGVyIHdob3NlIGJpdHMgY2FuIGJlIHBvbGxlZCB0byBrbm93IHN0YXR1cyBvZiBmbGFz
aCBvcGVyYXRpb24uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ3lwcmVzcyBIeXBlckZsYXNoIGRh
dGFzaGVldCBoZXJlWzFdLCB0YWxrcyBhYm91dCBDRkkgQW1kL0Z1aml0c3UNCj4gPiA+ID4gPiBF
eHRlbmRlZCBRdWVyeSB2ZXJzaW9uIDEuNS4gQml0IDAgb2YgIlNvZnR3YXJlIEZlYXR1cmVzIHN1
cHBvcnRlZCIgZmllbGQNCj4gPiA+ID4gPiBvZiBDRkkgUHJpbWFyeSBWZW5kb3ItU3BlY2lmaWMg
RXh0ZW5kZWQgUXVlcnkgdGFibGUgaW5kaWNhdGVzDQo+ID4gPiA+ID4gcHJlc2VuY2UvYWJzZW5j
ZSBvZiBzdGF0dXMgcmVnaXN0ZXIgYW5kIEJpdCAxIGluZGljYXRlcyB3aGV0aGVyIG9yIG5vdA0K
PiA+ID4gPiA+IERRIHBvbGxpbmcgaXMgc3VwcG9ydGVkLiBVc2luZyB0aGVzZSBiaXRzLCBpdHMg
cG9zc2libGUgdG8gZGV0ZXJtaW5lDQo+ID4gPiA+ID4gd2hldGhlciBmbGFzaCBzdXBwb3J0cyBE
USBwb2xsaW5nIG9yIG5lZWQgdG8gdXNlIFN0YXR1cyBSZWdpc3Rlci4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBBZGQgc3VwcG9ydCBmb3IgcG9sbGluZyBzdGF0dXMgcmVnaXN0ZXIgdG8ga25vdyBk
ZXZpY2UgcmVhZHkvc3RhdHVzIG9mDQo+ID4gPiA+ID4gZXJhc2Uvd3JpdGUgb3BlcmF0aW9ucyB3
aGVuIERRIHBvbGxpbmcgaXMgbm90IHN1cHBvcnRlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IElzbid0
IHRoaXMgbmV3IFN0YXR1cyBzY2hlbWUganVzdCBhIGNvcHkgb2YgSW50ZWxzKGNtZHNldF8wMDAx
KT8NCj4gPiA+IA0KPiA+ID4gWWVzLCBidXQgd2l0aCBvbmUgZGlmZmVyZW5jZTogQXQgdGhlIGVu
ZCBvZiBwcm9ncmFtL2VyYXNlIG9wZXJhdGlvbiwNCj4gPiA+IGRldmljZSBkaXJlY3RseSBlbnRl
cnMgc3RhdHVzIHJlZ2lzdGVyIG1vZGUgYW5kICBzdGFydHMgcmVmbGVjdGluZw0KPiA+ID4gc3Rh
dHVzIHJlZ2lzdGVyIGNvbnRlbnQgYXQgYW55IGFkZHJlc3MuDQo+ID4gPiBUaGUgZGV2aWNlIHJl
bWFpbnMgaW4gdGhlIHJlYWQgc3RhdHVzIHJlZ2lzdGVyIHN0YXRlIHVudGlsIGFub3RoZXINCj4g
PiA+IGNvbW1hbmQgaXMgd3JpdHRlbiB0byB0aGUgZGV2aWNlLiBUaGVyZWZvcmUgdGhlcmUgaXMg
bm90aW9uIG9mIGRldmljZSBpcw0KPiA+ID4gaW4gInN0YXR1cyByZWdpc3RlciByZWFkIG1vZGUi
IChGTF9TVEFUVVMpIHN0YXRlDQo+ID4gDQo+ID4gVGhhdCBzZWVtcyB0byB2YXJ5IGFuZCBsb25n
IHRpbWUgYWdvIFJNSyBhZGRlZCB0aGlzOg0KPiA+IAkJLyogSWYgdGhlIGZsYXNoIGhhcyBmaW5p
c2hlZCBlcmFzaW5nLCB0aGVuICdlcmFzZSBzdXNwZW5kJw0KPiA+IAkJICogYXBwZWFycyB0byBt
YWtlIHNvbWUgKDI4RjMyMCkgZmxhc2ggZGV2aWNlcyBzd2l0Y2ggdG8NCj4gPiAJCSAqICdyZWFk
JyBtb2RlLiAgTWFrZSBzdXJlIHRoYXQgd2Ugc3dpdGNoIHRvICdyZWFkIHN0YXR1cycNCj4gPiAJ
CSAqIG1vZGUgc28gd2UgZ2V0IHRoZSByaWdodCBkYXRhLiAtLXJtaw0KPiA+IAkJICovDQo+ID4g
CQltYXBfd3JpdGUobWFwLCBDTUQoMHg3MCksIGNoaXAtPmluX3Byb2dyZXNzX2Jsb2NrX2FkZHIp
Ow0KPiA+IA0KPiANCj4gVGhpcyBiZWhhdmlvciBpcyBleHBlY3RlZCB3aXRoIGNtZHNldF8wMDAx
LiBCZWNhdXNlICJUaGUgZGV2aWNlIHJlbWFpbnMNCj4gaW4gdGhlIHJlYWQgc3RhdHVzIHJlZ2lz
dGVyIHN0YXRlIHVudGlsIGFub3RoZXIgY29tbWFuZCBpcyB3cml0dGVuIiwNCj4gdGhlcmVmb3Jl
ICJlcmFzZSBzdXNwZW5kJyBjb21tYW5kIGFmdGVyIGVyYXNlIGNvbXBsZXRpb24gd2lsbCBzd2l0
Y2gNCj4gZGV2aWNlIHRvIHJlYWQgbW9kZS4gQW5kIHRoZXJlZm9yZSByZWFkIHN0YXR1cyBpcyBz
YWZlIHRoaW5nIHRvIGRvIGZvcg0KPiBjbWRzZXRfMDAwMS4NCj4gDQo+IEJ1dCBpbiBjYXNlIG9m
IGNtZHNldF8wMDAyIGVyYXNlIGNvbXBsZXRpb24gd2lsbCBub3QgcHV0IGRldmljZSB0byByZWFk
DQo+IHN0YXR1cyBtb2RlIGFuZCB0aGVyZWZvcmUgbm8gc3BlY2lhbCBzdGF0dXMgdHJhY2tpbmcg
aXMgcmVxdWlyZWQuDQo+IA0KPiA+ID4gQnV0IGluIGNhc2Ugb2YgY2ZpX2NtZHNldF8wMDAyLCBv
bmNlIHByb2dyYW0vZXJhc2Ugb3BlcmF0aW9uIGlzDQo+ID4gPiBjb21wbGV0ZSwgZGV2aWNlIHJl
dHVybnMgdG8gcHJldmlvdXMgYWRkcmVzcyBzcGFjZSBvdmVybGF5IGZyb20gd2hpY2gNCj4gPiA+
IG9wZXJhdGlvbiB3YXMgc3RhcnRlZCBmcm9tIChtb3N0bHkgcmVhZCBtb2RlKQ0KPiA+IA0KPiA+
IEkgaG9wZSB5b3UgY2FuIGRvIHRoZSBzYW1lIGFzIEludGVsIGhlcmUsIGlzc3VlIGFuIGV4cGxp
Y2l0IFN0YXR1cyBDTUQgb3IgeW91IHdpbGwgYmUgaW4gdHJvdWJsZS4NCj4gDQo+IEV2ZW4gaWYg
d2UgaXNzdWUgUmVhZCBTdGF0dXMgY29tbWFuZCB0byBlbnRlciByZWFkIHN0YXR1cyBtb2RlLCBh
bnkNCj4gc2luZ2xlIHN1YnNlcXVlbnQgcmVhZCB3aWxsIHB1dCBkZXZpY2UgYmFjayB0byByZWFk
IG1vZGUuIFNvLCBzZW5kaW5nDQo+IGV4cGxpY2l0IFN0YXR1cyBDTUQgaXMgb2Ygbm90IG11Y2gg
dXNlLg0KPiANCj4gQXMgbG9uZyBhcyBjbWRzZXRfMDAwMiBkcml2ZXIgZW5zdXJlcyBzZW5kaW5n
IFJlYWQgU3RhdHVzIGNtZCBhbmQgbmV4dA0KPiBzaW5nbGUgcmVhZCBjYW4gYmUgZG9uZSBpbiBv
bmUgZ28gKGllLiBtdXRleCBoZWxkKSwgSSBkb24ndCBzZWUgYW55DQo+IHRyb3VibGUgaGVyZS4g
VGhpcyBpcyBhbHJlYWR5IHRha2UgY2FyZSBvZmYuDQoNCk91Y2gsIGEgbm9uIHN0aWNreSBTdGF0
dXMgc291bmRzIGJvcmtlbi4gQXJlIHlvdSBzdXJlIHRoYXQgbm90aGluZyBjYW4gY2hhbmdlIHRo
ZQ0KY2hpcCBiZXR3ZWVuIHlvdSBpc3N1ZSB0aGUgU3RhdHVzIENNRCBhbmQgcmVhZCBvdXQgb2Yg
c3RhdHVzIGJpdHM/DQpMaWtlIGlmIGFuIGVyYXNlL3N1c3BlbmQvcmVzdW1lIGNvbXBsZXRlcyBq
dXN0IGFmdGVyIFN0YXR1cyBDTUQgYnV0IGJlZm9yZSBTdGF0dXMgcmVhZG91dD8NCg0KIEpvY2tl
DQoNCj4gDQo+ID4gQWxzbywgSSB0aGluayB5b3UgbmVlZCB0byB1c2UgdGhlIHZhcmlvdXMgbWFw
X3dvcmRfeHh4IGFzIGluOg0KPiA+IHN0YXR1cyA9IG1hcF9yZWFkKG1hcCwgY2hpcC0+aW5fcHJv
Z3Jlc3NfYmxvY2tfYWRkcik7DQo+ID4gaWYgKG1hcF93b3JkX2FuZGVxdWFsKG1hcCwgc3RhdHVz
LCBzdGF0dXNfT0ssIHN0YXR1c19PSykpDQo+ID4gCWJyZWFrOw0KPiANCj4gWWVzLCBJIHdpbGwg
Zml4dXAgdGhpcyBwYXRjaCB0byB1c2UgbWFwX3dvcmRfKiB3aGVyZXZlciBuZWNlc3NhcnkgaW4g
dGhlDQo+IG5leHQgcmV2aXNpb24uDQo+IA0KPiANCj4gPiBvdGhlcndpc2UgeW91IHdpbGwgYnJl
YWsgaW50ZXJsZWF2ZWQgc2V0dXBzKGxpa2UgdHdvIDgtYml0IGZsYXNoZXMgaW4gcGFyYWxsZWwg
dG8NCj4gPiBmb3JtIG9uZSAxNiBiaXQgYnVzKS4gTWF5YmUgdGhpcyBpcyBub3Qgc3VwcG9ydGVk
IGZvciBDTURTRVQgMDAwMiA/DQo+ID4gDQo+IA0KPiBJbnRlcmxlYXZlZCBpcyBpbmRlZWQgc3Vw
cG9ydGVkIGJ5IGNtZHNldF8wMDAyLiBUaGFua3MgZm9yIHBvaW50aW5nIHRoYXQNCj4gb3V0IQ0K
PiANCj4gPiAgSm9ja2UNCj4gPiANCj4gPiA+IEluIG9yZGVyIHRvIGVudGVyIHN0YXR1cyByZWdp
c3RlciBvdmVybGF5IG1vZGUsIFJlYWQgU3RhdHVzIGNvbW1hbmQgaXMNCj4gPiA+IHRvIGJlIHdy
aXR0ZW4gdG8gYWRkcl91bmxvY2sxKDB4NTU1KSBhZGRyZXNzLiBUaGUgb3ZlcmxheSBpcyBpbiBl
ZmZlY3QNCj4gPiA+IGZvciBvbmUgcmVhZCBhY2Nlc3MsIHNwZWNpZmljYWxseSB0aGUgbmV4dCBy
ZWFkIGFjY2VzcyB0aGF0IGZvbGxvd3MgdGhlDQo+ID4gPiBTdGF0dXMgUmVnaXN0ZXIgUmVhZCBj
b21tYW5kDQo+ID4gPiBUaGVyZWZvcmUgY29kZSBhcm91bmQgRkxfU1RBVFVTIHN0YXRlIGluIGNm
aV9jbWRzZXRfMDAwMSBpcyBub3QNCj4gPiA+IGFwcGxpY2FibGUgdG8gY2ZpX2NtZHNldF8wMDAy
IGFzIGlzLg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+ID4gSWYgc28gSSB0aGluayB0aGUgbmV3IHN0
YXR1cyBpbXBsLiBpbiAwMDAyIHNob3VsZCBib3Jyb3cgZnJvbSAwMDAxIGFzIHRoaXMgaXMgYQ0K
PiA+ID4gPiBoYXJkZW5lZCBhbmQgYmF0dGxlIHRlc3RlZCBpbXBsLg0KPiA+ID4gPiANCj4gPiA+
IA0KPiA+ID4gSW4gY2FzZSBvZiBjZmlfY21kc2V0XzAwMDEuYywgcHJvZ3JhbS9lcmFzZSBpcyBm
b2xsb3dlZCBieQ0KPiA+ID4gaW52YWxfY2FjaGVfYW5kX3dhaXRfZm9yX29wZXJhdGlvbigpIHRv
IHBvbGwgcmVhZHkgYml0IGFuZCBiYXNlZCBvbg0KPiA+ID4gc3RhdHVzIHJlZ2lzdGVyIHZhbHVl
LCBzdWNjZXNzIG9yIHRoZSBlcnJvciBoYW5kbGluZyBpcyBkb25lLg0KPiA+ID4gDQo+ID4gPiBN
b3N0IG9mIHRoZSBjb2RlIGNvcnJlc3BvbmRpbmcgdG8gaW52YWxfY2FjaGVfYW5kX3dhaXRfZm9y
X29wZXJhdGlvbigpDQo+ID4gPiBpcyBhbHJlYWR5IGluIGNmaV9jbWRzZXRfMDAwMi5jLiBTbywg
d2hhdHMgbWlzc2luZyBpbiB0aGlzIHBhdGNoIGlzDQo+ID4gPiBoYW5kbGluZyBhbmQgcmVwb3J0
aW5nIG9mIGVycm9ycyBhcyByZWZsZWN0ZWQgaW4gc3RhdHVzIHJlZ2lzdGVyIGFmdGVyDQo+ID4g
PiB3cml0ZS9lcmFzZSBmYWlsdXJlcy4gSSB3aWxsIGFkZCB0aGF0IGluIHRoZSBuZXh0IHZlcnNp
b24uDQo+ID4gPiANCj4gPiA+IEJ1dCwgSSBkb24ndCBzZWUgbXVjaCB0byBib3Jyb3cgYXBhcnQg
ZnJvbSBlcnJvciBoYW5kbGluZyBzZXF1ZW5jZS4NCj4gPiA+IFBsZWFzZSwgbGV0IG1lIGtub3cg
aWYgSSBtaXNzZWQgc29tZXRoaW5nLg0KPiA+ID4gDQo+ID4gPiA+IEkga25vdyBvdGhlciBtb2Rl
cm4gMDAwMiBjaGlwcyBzdXBwb3J0cyBib3RoIG9sZCBhbmQgbmV3IGltcGwuIG9mIFN0YXR1cyBh
bmQgSSB3b3JsZA0KPiA+ID4gPiBndWVzcyB0aGF0IHdlIHdpbGwgc2VlIG1vcmUgY2hpcHMgd2l0
aCBuZXcgU3RhdHVzIG9ubHkuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBBZ3JlZWQuIE5ld2Vy
IGRldmljZXMgd291bGQgbW9zdGx5IGJlIENGSSAxLjUuDQo+ID4gPiANCj4gPiA+IC0tDQo+ID4g
PiBSZWdhcmRzDQo+ID4gPiBWaWduZXNoDQoNCg==
