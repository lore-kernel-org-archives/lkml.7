Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F064BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28F420830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="kWYCqOf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfCYNv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:51:56 -0400
Received: from mail-eopbgr770042.outbound.protection.outlook.com ([40.107.77.42]:31774
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfCYNvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8FU2S7YYltHz9HsPo84oGk4cXe4V/5/+ZVDotP0voI=;
 b=kWYCqOf0ZxYWJ0M14HFEwxksNcSDtZjKyF7S8w3uT/sA0sT+q5KXXWbWiNW0ulTrEUrHZrQiAGFGLkMwdSP18oL43WLDL98EiRbeZ5EFSUc7ZudHmVc6par+JyUQrzHxZXRB2tuadtNKJsu7tc2tb5HIut/tRzIBZSm/972hadE=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3651.namprd10.prod.outlook.com (20.179.96.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 13:51:49 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 13:51:48 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "richard@nod.at" <richard@nod.at>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
CC:     "nsekhar@ti.com" <nsekhar@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "masonccyang@mxic.com.tw" <masonccyang@mxic.com.tw>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [RFC PATCH v2 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
Thread-Topic: [RFC PATCH v2 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
Thread-Index: AQHU4A390EDhLD8/jkyjBXiay9/acKYWYsWAgAXxyICAAA8cAA==
Date:   Mon, 25 Mar 2019 13:51:48 +0000
Message-ID: <107cd92703919f97f4cf2d9cd279b091bc90518e.camel@infinera.com>
References: <20190321174548.9288-1-vigneshr@ti.com>
         <20190321174548.9288-2-vigneshr@ti.com>
         <f92362a0678b07d22ccc0f271fe3483dc77364a9.camel@infinera.com>
         <b1961c49-6795-89e7-e154-6270bf43d49c@ti.com>
In-Reply-To: <b1961c49-6795-89e7-e154-6270bf43d49c@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2c53933-9980-48bb-5bc1-08d6b1290707
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BN8PR10MB3651;
x-ms-traffictypediagnostic: BN8PR10MB3651:
x-microsoft-antispam-prvs: <BN8PR10MB365154BC0F48FF0C067D97A8F45E0@BN8PR10MB3651.namprd10.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(7416002)(6116002)(81156014)(2201001)(3846002)(72206003)(105586002)(81166006)(446003)(11346002)(229853002)(8676002)(6436002)(53936002)(2616005)(476003)(68736007)(86362001)(478600001)(316002)(6486002)(6512007)(7736002)(305945005)(93886005)(110136005)(6246003)(54906003)(118296001)(2906002)(6506007)(5660300002)(26005)(2501003)(102836004)(14454004)(53546011)(186003)(97736004)(8936002)(71190400001)(4326008)(99286004)(486006)(25786009)(66066001)(106356001)(36756003)(256004)(71200400001)(5024004)(14444005)(76176011)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR10MB3651;H:BN8PR10MB3540.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ENUq5H3XmT/P845IrZLZzKX601g3OeglZ1e6uqwUjQ1/dvHlgGbSFyvoMHvcsDLSuyTuuCpa4thEzIiOA2iSHr9/o/W2bx2bey6u5PssfURWSaCLwWSNEION6CQm3QgBVZo/sCzjFVmcpSwD6cT/Jtdl7LT2PtpSGBGHBN3Hk5MLxonHaANk5HdcdRwd6Xn0ep98EFB5EeFyOF8ifaRlzfEWbS700BggkbU9voVPj40IQkplOIofNdFRkZK7Po3k/p8tg2cugre2MRLFD9lx5rYQvHT1cWZej0D8+ekWEVp/nL/wgMbkGDQtxEykTPA3JjMiHmTElDRBIjZqxWzeTOlID2zlcoyNKOOchS8CCpZQ939Tn+IM+X56R9Q1LnxX7POFe9KBIojIo4b4Sxml3XOmk9DuayIFnWfr37gsWtQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64F643BA9BD1D64099EF7B7EE1AC61D6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c53933-9980-48bb-5bc1-08d6b1290707
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 13:51:48.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3651
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTI1IGF0IDE4OjI3ICswNTMwLCBWaWduZXNoIFJhZ2hhdmVuZHJhIHdy
b3RlOg0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRo
ZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4gDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDIxLzAzLzE5IDExOjQxIFBNLCBKb2FraW0gVGpl
cm5sdW5kIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAxOS0wMy0yMSBhdCAyMzoxNSArMDUzMCwgVmln
bmVzaCBSYWdoYXZlbmRyYSB3cm90ZToNCj4gPiA+IEh5cGVyRmxhc2ggZGV2aWNlcyBhcmUgY29t
cGxpYW50IHdpdGggQ0ZJIEFNRC9GdWppdHN1IEV4dGVuZGVkIENvbW1hbmQNCj4gPiA+IFNldCgw
eDAwMDIpIGZvciBmbGFzaCBvcGVyYXRpb25zLCB0aGVyZWZvcmUgZHJpdmVycy9tdGQvY2hpcHMv
Y2ZpX2NtZHNldF8wMDAyLmMNCj4gPiA+IGNhbiBiZSB1c2UgYXMgaXMuIEJ1dCB0aGVzZSBkZXZp
Y2VzIGRvIG5vdCBzdXBwb3J0IERRIHBvbGxpbmcgbWV0aG9kIG9mDQo+ID4gPiBkZXRlcm1pbmlu
ZyBjaGlwIHJlYWR5L2dvb2Qgc3RhdHVzLiBUaGVzZSBmbGFzaGVzIHByb3ZpZGUgU3RhdHVzDQo+
ID4gPiBSZWdpc3RlciB3aG9zZSBiaXRzIGNhbiBiZSBwb2xsZWQgdG8ga25vdyBzdGF0dXMgb2Yg
Zmxhc2ggb3BlcmF0aW9uLg0KPiA+ID4gDQo+ID4gPiBDeXByZXNzIEh5cGVyRmxhc2ggZGF0YXNo
ZWV0IGhlcmVbMV0sIHRhbGtzIGFib3V0IENGSSBBbWQvRnVqaXRzdQ0KPiA+ID4gRXh0ZW5kZWQg
UXVlcnkgdmVyc2lvbiAxLjUuIEJpdCAwIG9mICJTb2Z0d2FyZSBGZWF0dXJlcyBzdXBwb3J0ZWQi
IGZpZWxkDQo+ID4gPiBvZiBDRkkgUHJpbWFyeSBWZW5kb3ItU3BlY2lmaWMgRXh0ZW5kZWQgUXVl
cnkgdGFibGUgaW5kaWNhdGVzDQo+ID4gPiBwcmVzZW5jZS9hYnNlbmNlIG9mIHN0YXR1cyByZWdp
c3RlciBhbmQgQml0IDEgaW5kaWNhdGVzIHdoZXRoZXIgb3Igbm90DQo+ID4gPiBEUSBwb2xsaW5n
IGlzIHN1cHBvcnRlZC4gVXNpbmcgdGhlc2UgYml0cywgaXRzIHBvc3NpYmxlIHRvIGRldGVybWlu
ZQ0KPiA+ID4gd2hldGhlciBmbGFzaCBzdXBwb3J0cyBEUSBwb2xsaW5nIG9yIG5lZWQgdG8gdXNl
IFN0YXR1cyBSZWdpc3Rlci4NCj4gPiA+IA0KPiA+ID4gQWRkIHN1cHBvcnQgZm9yIHBvbGxpbmcg
c3RhdHVzIHJlZ2lzdGVyIHRvIGtub3cgZGV2aWNlIHJlYWR5L3N0YXR1cyBvZg0KPiA+ID4gZXJh
c2Uvd3JpdGUgb3BlcmF0aW9ucyB3aGVuIERRIHBvbGxpbmcgaXMgbm90IHN1cHBvcnRlZC4NCj4g
PiANCj4gPiBJc24ndCB0aGlzIG5ldyBTdGF0dXMgc2NoZW1lIGp1c3QgYSBjb3B5IG9mIEludGVs
cyhjbWRzZXRfMDAwMSk/DQo+IA0KPiBZZXMsIGJ1dCB3aXRoIG9uZSBkaWZmZXJlbmNlOiBBdCB0
aGUgZW5kIG9mIHByb2dyYW0vZXJhc2Ugb3BlcmF0aW9uLA0KPiBkZXZpY2UgZGlyZWN0bHkgZW50
ZXJzIHN0YXR1cyByZWdpc3RlciBtb2RlIGFuZCAgc3RhcnRzIHJlZmxlY3RpbmcNCj4gc3RhdHVz
IHJlZ2lzdGVyIGNvbnRlbnQgYXQgYW55IGFkZHJlc3MuDQo+IFRoZSBkZXZpY2UgcmVtYWlucyBp
biB0aGUgcmVhZCBzdGF0dXMgcmVnaXN0ZXIgc3RhdGUgdW50aWwgYW5vdGhlcg0KPiBjb21tYW5k
IGlzIHdyaXR0ZW4gdG8gdGhlIGRldmljZS4gVGhlcmVmb3JlIHRoZXJlIGlzIG5vdGlvbiBvZiBk
ZXZpY2UgaXMNCj4gaW4gInN0YXR1cyByZWdpc3RlciByZWFkIG1vZGUiIChGTF9TVEFUVVMpIHN0
YXRlDQoNClRoYXQgc2VlbXMgdG8gdmFyeSBhbmQgbG9uZyB0aW1lIGFnbyBSTUsgYWRkZWQgdGhp
czoNCgkJLyogSWYgdGhlIGZsYXNoIGhhcyBmaW5pc2hlZCBlcmFzaW5nLCB0aGVuICdlcmFzZSBz
dXNwZW5kJw0KCQkgKiBhcHBlYXJzIHRvIG1ha2Ugc29tZSAoMjhGMzIwKSBmbGFzaCBkZXZpY2Vz
IHN3aXRjaCB0bw0KCQkgKiAncmVhZCcgbW9kZS4gIE1ha2Ugc3VyZSB0aGF0IHdlIHN3aXRjaCB0
byAncmVhZCBzdGF0dXMnDQoJCSAqIG1vZGUgc28gd2UgZ2V0IHRoZSByaWdodCBkYXRhLiAtLXJt
aw0KCQkgKi8NCgkJbWFwX3dyaXRlKG1hcCwgQ01EKDB4NzApLCBjaGlwLT5pbl9wcm9ncmVzc19i
bG9ja19hZGRyKTsNCg0KPiANCj4gQnV0IGluIGNhc2Ugb2YgY2ZpX2NtZHNldF8wMDAyLCBvbmNl
IHByb2dyYW0vZXJhc2Ugb3BlcmF0aW9uIGlzDQo+IGNvbXBsZXRlLCBkZXZpY2UgcmV0dXJucyB0
byBwcmV2aW91cyBhZGRyZXNzIHNwYWNlIG92ZXJsYXkgZnJvbSB3aGljaA0KPiBvcGVyYXRpb24g
d2FzIHN0YXJ0ZWQgZnJvbSAobW9zdGx5IHJlYWQgbW9kZSkNCg0KSSBob3BlIHlvdSBjYW4gZG8g
dGhlIHNhbWUgYXMgSW50ZWwgaGVyZSwgaXNzdWUgYW4gZXhwbGljaXQgU3RhdHVzIENNRCBvciB5
b3Ugd2lsbCBiZSBpbiB0cm91YmxlLg0KDQpBbHNvLCBJIHRoaW5rIHlvdSBuZWVkIHRvIHVzZSB0
aGUgdmFyaW91cyBtYXBfd29yZF94eHggYXMgaW46DQpzdGF0dXMgPSBtYXBfcmVhZChtYXAsIGNo
aXAtPmluX3Byb2dyZXNzX2Jsb2NrX2FkZHIpOw0KaWYgKG1hcF93b3JkX2FuZGVxdWFsKG1hcCwg
c3RhdHVzLCBzdGF0dXNfT0ssIHN0YXR1c19PSykpDQoJYnJlYWs7DQpvdGhlcndpc2UgeW91IHdp
bGwgYnJlYWsgaW50ZXJsZWF2ZWQgc2V0dXBzKGxpa2UgdHdvIDgtYml0IGZsYXNoZXMgaW4gcGFy
YWxsZWwgdG8NCmZvcm0gb25lIDE2IGJpdCBidXMpLiBNYXliZSB0aGlzIGlzIG5vdCBzdXBwb3J0
ZWQgZm9yIENNRFNFVCAwMDAyID8NCg0KIEpvY2tlDQoNCj4gDQo+IEluIG9yZGVyIHRvIGVudGVy
IHN0YXR1cyByZWdpc3RlciBvdmVybGF5IG1vZGUsIFJlYWQgU3RhdHVzIGNvbW1hbmQgaXMNCj4g
dG8gYmUgd3JpdHRlbiB0byBhZGRyX3VubG9jazEoMHg1NTUpIGFkZHJlc3MuIFRoZSBvdmVybGF5
IGlzIGluIGVmZmVjdA0KPiBmb3Igb25lIHJlYWQgYWNjZXNzLCBzcGVjaWZpY2FsbHkgdGhlIG5l
eHQgcmVhZCBhY2Nlc3MgdGhhdCBmb2xsb3dzIHRoZQ0KPiBTdGF0dXMgUmVnaXN0ZXIgUmVhZCBj
b21tYW5kDQo+IFRoZXJlZm9yZSBjb2RlIGFyb3VuZCBGTF9TVEFUVVMgc3RhdGUgaW4gY2ZpX2Nt
ZHNldF8wMDAxIGlzIG5vdA0KPiBhcHBsaWNhYmxlIHRvIGNmaV9jbWRzZXRfMDAwMiBhcyBpcy4N
Cj4gDQo+IA0KPiA+IElmIHNvIEkgdGhpbmsgdGhlIG5ldyBzdGF0dXMgaW1wbC4gaW4gMDAwMiBz
aG91bGQgYm9ycm93IGZyb20gMDAwMSBhcyB0aGlzIGlzIGENCj4gPiBoYXJkZW5lZCBhbmQgYmF0
dGxlIHRlc3RlZCBpbXBsLg0KPiA+IA0KPiANCj4gSW4gY2FzZSBvZiBjZmlfY21kc2V0XzAwMDEu
YywgcHJvZ3JhbS9lcmFzZSBpcyBmb2xsb3dlZCBieQ0KPiBpbnZhbF9jYWNoZV9hbmRfd2FpdF9m
b3Jfb3BlcmF0aW9uKCkgdG8gcG9sbCByZWFkeSBiaXQgYW5kIGJhc2VkIG9uDQo+IHN0YXR1cyBy
ZWdpc3RlciB2YWx1ZSwgc3VjY2VzcyBvciB0aGUgZXJyb3IgaGFuZGxpbmcgaXMgZG9uZS4NCj4g
DQo+IE1vc3Qgb2YgdGhlIGNvZGUgY29ycmVzcG9uZGluZyB0byBpbnZhbF9jYWNoZV9hbmRfd2Fp
dF9mb3Jfb3BlcmF0aW9uKCkNCj4gaXMgYWxyZWFkeSBpbiBjZmlfY21kc2V0XzAwMDIuYy4gU28s
IHdoYXRzIG1pc3NpbmcgaW4gdGhpcyBwYXRjaCBpcw0KPiBoYW5kbGluZyBhbmQgcmVwb3J0aW5n
IG9mIGVycm9ycyBhcyByZWZsZWN0ZWQgaW4gc3RhdHVzIHJlZ2lzdGVyIGFmdGVyDQo+IHdyaXRl
L2VyYXNlIGZhaWx1cmVzLiBJIHdpbGwgYWRkIHRoYXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4g
DQo+IEJ1dCwgSSBkb24ndCBzZWUgbXVjaCB0byBib3Jyb3cgYXBhcnQgZnJvbSBlcnJvciBoYW5k
bGluZyBzZXF1ZW5jZS4NCj4gUGxlYXNlLCBsZXQgbWUga25vdyBpZiBJIG1pc3NlZCBzb21ldGhp
bmcuDQo+IA0KPiA+IEkga25vdyBvdGhlciBtb2Rlcm4gMDAwMiBjaGlwcyBzdXBwb3J0cyBib3Ro
IG9sZCBhbmQgbmV3IGltcGwuIG9mIFN0YXR1cyBhbmQgSSB3b3JsZA0KPiA+IGd1ZXNzIHRoYXQg
d2Ugd2lsbCBzZWUgbW9yZSBjaGlwcyB3aXRoIG5ldyBTdGF0dXMgb25seS4NCj4gPiANCj4gDQo+
IEFncmVlZC4gTmV3ZXIgZGV2aWNlcyB3b3VsZCBtb3N0bHkgYmUgQ0ZJIDEuNS4NCj4gDQo+IC0t
DQo+IFJlZ2FyZHMNCj4gVmlnbmVzaA0KDQo=
