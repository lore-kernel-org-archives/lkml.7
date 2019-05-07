Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02189C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB965205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bP5c8Jj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEGOJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:09:26 -0400
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:61919
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbfEGOJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFPh2pkIJhWl5H6fSo+zhxnbETuD85a6A3UbOWVLEkw=;
 b=bP5c8Jj43Hz8qHWND17BNa2ks2y78g/XEmT3AbS3fw9qkEPJnb4Fb1mIxBbxTAC2MiIF/f0j94Cndq/savJbDaLYfzE6YopqIUOs0xmYbqzcymZZ5lchnM5i+6hMPUnfLjasVin7DW2QfQwlkpv8CHy0H5sc4yLUj0Uy1WIDMJM=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB4439.namprd02.prod.outlook.com (52.135.237.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 7 May 2019 14:09:07 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::4158:f3a1:5e61:54a2]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::4158:f3a1:5e61:54a2%2]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 14:09:07 +0000
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
Thread-Index: AQHVANDAIuHRsUnR3UyEXTsOibIOSaZem0WAgAC1gnCAAFwHAIAADLBg
Date:   Tue, 7 May 2019 14:09:06 +0000
Message-ID: <BYAPR02MB55915E6F754DC21CE0F6ADAAA7310@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
         <1556792423-4833-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
         <30102591E157244384E984126FC3CB4F639E7BA8@us01wembx1.internal.synopsys.com>
         <1557176302.18203.20.camel@phaseone.com>
         <BYAPR02MB55918A76A1567C3209860748A7310@BYAPR02MB5591.namprd02.prod.outlook.com>
 <1557235048.114189.22.camel@phaseone.com>
In-Reply-To: <1557235048.114189.22.camel@phaseone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e20e7e05-3980-4559-a109-08d6d2f5918a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB4439;
x-ms-traffictypediagnostic: BYAPR02MB4439:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB443964CF0C2512F8D6916755A7310@BYAPR02MB4439.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(189003)(13464003)(478600001)(66556008)(66476007)(76116006)(2906002)(66946007)(73956011)(486006)(74316002)(6436002)(5660300002)(71200400001)(71190400001)(229853002)(66446008)(14454004)(9686003)(3846002)(6116002)(53936002)(55016002)(66066001)(86362001)(256004)(14444005)(316002)(99286004)(4326008)(81156014)(81166006)(8676002)(33656002)(7736002)(54906003)(110136005)(64756008)(11346002)(8936002)(76176011)(476003)(7696005)(7416002)(52536014)(102836004)(26005)(305945005)(446003)(25786009)(68736007)(6506007)(6246003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4439;H:BYAPR02MB5591.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pOg0uP7bFXtRtARupG82cf3LdlKaTx1zyMzXL8kxzBqT458kYF2wNk/NUhb04yuq/jO4NxKjT8h2PBoaAXGABY+vQeI8uqc76YbUoJpWoUue+lYw3OyfVMrIun1LGiazmRDqttrt0Spdtb6gTVMOUsjk0qDHnEFRx9kQRfiKMapieX45r5Dral5VCPXWUWXpmvPJHsYxgQlzQ5ziNrWY8urwTC6A3Jm6BrrvuFUILdqsn+CFi112SLs2m12q1fWgAILWeapTqEyv+CXpnR7rZ3jLEl/+pUNRB4zoWQg6C3xmHY37h+fuBajOEdCwp0U2d8cYoM6blBiAotEjwZJbrtemL0madHSK38wkFOBcQeOfVlUMxDBLXokQkH0GFOldxImnDrWRor+IOO3/jWN2JvQe7oP4n7HpbXAS8ZVC8BM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20e7e05-3980-4559-a109-08d6d2f5918a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 14:09:06.8634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4439
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2xhdXMsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsYXVzIEgu
IFN0b3ZnYWFyZCBbbWFpbHRvOmNzdEBwaGFzZW9uZS5jb21dDQo+U2VudDogVHVlc2RheSwgTWF5
IDA3LCAyMDE5IDY6NDcgUE0NCj5UbzogQW51cmFnIEt1bWFyIFZ1bGlzaGEgPGFudXJhZ2t1QHhp
bGlueC5jb20+OyBUaGluaCBOZ3V5ZW4NCj48VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT47IEdy
ZWcgS3JvYWgtSGFydG1hbg0KPjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IFJvYiBIZXJy
aW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQNCj48bWFyay5ydXRsYW5kQGFy
bS5jb20+OyBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+DQo+Q2M6IGxpbnV4LXVzYkB2
Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyB2LmFudXJhZ2t1bWFyQGdtYWlsLmNvbQ0KPlN1YmplY3Q6IFJl
OiBbUEFUQ0ggMy8zXSB1c2I6IGR3YzM6IGdhZGdldDogQWRkIHN1cHBvcnQgZm9yIGRpc2FibGlu
ZyBVMSBhbmQgVTINCj5lbnRyaWVzDQo+DQo+SGkgQW51cmFnDQo+DQo+PiA+ID4gUGxlYXNlIHVz
ZSAiLSIgcmF0aGVyIHRoYW4gIl8iIGluIHRoZSBwcm9wZXJ0eSBuYW1lcy4NCj4+ID4gSSBoYXZl
IHRob3VnaHQgYWJvdXQgdGhpcyBmZWF0dXJlIG92ZXIgdGhlIHdlZWtlbmQsIGFuZCB0aGluayB0
aGUNCj4+ID4gbmFtaW5nIHNob3VsZCBiZQ0KPj4gPiBjaGFuZ2VkIHRvIHNvbWV0aGluZyBsaWtl
ICJzbnBzLGJvcy11MS1leGl0LWxhdC1pbi11cyINCj4+ID4gYW5kIG5hbWVkIHRoZSBzYW1lIGlu
IHRoZSBjb2RlLiBBbmQgdGhlbiBiZSB0aGUgdmFsdWUgdXNlZCBieSB0aGUNCj4+ID4gZ2V0X2Nv
bmZpZ19wYXJhbXMuIEUuZy4gdGhlIGRldmljZS10cmVlIGlzIHVzZWQgdG8gc2V0IHRoZSB2YWx1
ZXMNCj4+ID4gZGlyZWN0bHkgdXNlZCBmb3INCj4+ID4gYlV4ZGV2RXhpdExhdCBpbnN0ZWFkIG9m
IG5hbWVkIHNvbWV0aGluZyBub3QgcmVsYXRlZCB0byBleGl0DQo+PiA+IGxhdGVuY3kuDQo+PiA+
DQo+PiA+IFdpdGggdGhpcyB0aGUgbmFtZSBhbmQgZnVuY3Rpb24gaXMgYSAxIHRvIDEgbWF0Y2gs
IGFuZCB5b3UgY2FuDQo+PiA+IGFtb25nIG90aGVycyBzZXQgaXQgdG8NCj4+ID4gMCBmb3Igb3B0
YWluaW5nIHdoYXQgQW51cmFnIHdhbnRzLg0KPj4gPg0KPj4gWW91ciBzdWdnZXN0aW9uIGxvb2tz
IGdvb2QgYnV0IHRoZSBwcm9ibGVtIGlzIHRoZSBVMSBhbmQgVTIgZXhpdA0KPj4gbGF0ZW5jaWVz
IGFyZQ0KPj4gZml4ZWQgdmFsdWVzIGluIGR3YzMgY29udHJvbGxlcihjYW4gYmUgZm91bmQgaW4g
SENTUEFSQU1TMykuIEFkZGluZw0KPj4gZGlmZmVyZW50DQo+PiBleGl0IGxhdGVuY2llcyBtYXkg
bW9kaWZ5IHRoZSBVMVNFTC9VMlNFTCB2YWx1ZXMgc2VudCBmcm9tIHRoZSBob3N0DQo+PiBidXQg
dGhlIHJlYWwNCj4+IGR3YzMgY29udHJvbGxlciBleGl0IGxhdGVuY2llcyBhcmUgbm90IGdldHRp
bmcgY2hhbmdlZC4gQmVjYXVzZSBvZg0KPj4gdGhpcyByZWFzb24gSQ0KPj4gaGFkIG9wdGVkICJz
bnBzLGRpc191MV9lbnRyeV9xdWlyayIsIHNvIHRoYXQgdGhlIFUxL1UyIGV4aXQgbGF0ZW5jeQ0K
Pj4gdmFsdWVzDQo+PiByZXBvcnRlZCBpbiBCT1MgZGVzY3JpcHRvciBjYW4gYmUgZWl0aGVyIGJl
IHplcm8gKHdoZW4gVTEvVTIgZW50cmllcw0KPj4gbmVlZHMgdG8gYmUNCj4+IGRpc2FibGVkKSBv
ciBub24temVybyB2YWx1ZSAocmVwb3J0ZWQgaW4gSENTUEFSQU1TMykgd2hlbiBVMS9VMg0KPj4g
c3RhdGVzIGFsbG93ZWQuDQo+PiBCYXNlZCBvbiB0aGlzIEkgdGhpbmsgaXQgaXMgYmV0dGVyIGlm
IHdlIGNhbiBjb250aW51ZSB3aXRoICJzbnBzLGRpcy0NCj4+IHUxLWVudHJ5LXF1aXJrIg0KPj4g
aW5zdGVhZCBvZiB0aGUgInNucHMsYm9zLXUxLWV4aXQtbGF0LWluLXVzIi4gUGxlYXNlwqDCoHBy
b3ZpZGUgeW91cg0KPj4gb3BpbmlvbiBvbiB0aGlzLg0KPg0KPldpdGggdGhpcyBpbiBtaW5kIEkg
Y2FuIHNlZSB3aHkgaGF2aW5nIGRpcmVjdCBjb250cm9sIG92ZXIgdGhlIGV4aXQNCj5sYXRlbmN5
IHZhbHVlIG1pZ2h0IG5vdCBiZSBvcHRpbXVtIGluIG1hbnkgc2l0dWF0aW9ucy4NCj5SZWdhcmRp
bmcgdGhlIG5hbWUsIEkgdGhpbmsgdGhlIHNucHMsZGlzX3UxX2VudHJ5X3F1aXJrIHdpbGwgYmUg
YSBnb29kDQo+bmFtZSwgaWYgaXQgaXMgY29tYmluZWQgd2l0aCB0aGUgRENUTCBjb250cm9sLiBF
LmcuIHJlbW92ZSB0aGUgY29uZmlnZnMNCj5wYXJ0IG9mIG15IHBhdGNoLCBhbmQgbWVyZ2UgdGhl
IERDVEwgY29udHJvbCB3aXRoIHlvdXIgcGF0Y2hlcy4NCj5JZiB0aGUgZHQtYmluZGluZyBzdGls
bCBvbmx5IGNvbnRyb2wgdGhlIGJvcyBkZXNjcmlwdG9yIEkgdGhpbmsgYQ0KPmJldHRlciBuYW1l
IGlzIHNvbWV0aGluZyB3aXRoIHUxX2ZvcmNlX2V4aXN0X2xhdF8wIG9yIHNpbWlsYXIuDQo+DQo+
SSBkb24ndCB0aGluayBzZXR0aW5nIGJvcyB0byAwIG9yIGNvbnRyb2xsaW5nIERDVEwgd2lsbCBi
ZSB1c2VkDQo+aW5kaXZpZHVhbCwgc28gdG8ga2VlcCB0aGluZ3Mgc2ltcGxlIEkgd2lsbCB2b3Rl
IGZvcg0KPnNucHMsZGlzX3UxX2VudHJ5X3F1aXJrLCBhbmQgdGhlbiBqdXN0IGNvbnRyb2wgYWxs
IGVsZW1lbnRzIHJlZ2FyZGluZw0KPmRpc2FibGluZyBVMS9VMiBmcm9tIHRoaXMgZHQtYmluZGlu
Zy4NCj4NCj5QbGVhc2UgY3V0IHdoYXQgeW91ciBuZWVkIGZyb20gbXkgcGF0Y2guDQo+DQoNClRo
YW5rcyBmb3IgcHJvdmlkaW5nIHlvdXIgaW5wdXQuIE1lcmdpbmcgeW91ciBzb2x1dGlvbiBhbmQg
bWluZSAgd291bGQgYmUNCmdvb2QuIEkgd2lsbCBtb2RpZnkgdGhlIHBhdGNoIHRvIGluY2x1ZGUg
eW91ciBjaGFuZ2VzIGFzIHdlbGwgYW5kIHNlbmQgaXQgdG8geW91Lg0KT25jZSB5b3UgYXJlIG9r
YXkgd2l0aCB0aGUgY2hhbmdlcywgd2UgY2FuIHBvc3QgdGhlIHBhdGNoIHRvIG1haW5saW5lLg0K
DQpUaGFua3MsDQpBbnVyYWcgS3VtYXIgVnVsaXNoYSANCg==
