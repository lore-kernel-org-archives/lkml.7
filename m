Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2645820818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Mmb2kgCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDIGuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:50:10 -0400
Received: from mail-eopbgr800051.outbound.protection.outlook.com ([40.107.80.51]:51776
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfDIGuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kni1vulNNc6XSS9imYZ/y/vU+EWQINSbrjouqMLw90=;
 b=Mmb2kgCB221TLfZD6mKpKwMhRYoqt7vMCNfTKx+go4pnBLT29mBc30l4+Ap6hXiAFdcRsCX1B5gFFsOBB3RvuOZbKFjVZtyqjFjD8O3xAKbP9smykw15L3eX87IT286FP89PMhzAA/Kcbnl92DrIg3Sh9MUWgfYZLRNhZHXxBQ0=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4469.namprd02.prod.outlook.com (52.135.239.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 9 Apr 2019 06:50:04 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::55ca:e7d8:c514:8276]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::55ca:e7d8:c514:8276%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 06:50:04 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
CC:     Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Subject: RE: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Thread-Topic: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Thread-Index: AQHU6VAa3juPwWr490+9QB3ZXSwb5qYpMM2AgAkMFiCAABwvgIAABSSAgAAlsYCAADxRAIAArJ6w
Date:   Tue, 9 Apr 2019 06:50:04 +0000
Message-ID: <BYAPR02MB4710E78DF9B6AD580CEA963EC22D0@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-4-nava.manne@xilinx.com>
 <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
 <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
 <d425bd61-238b-f085-f450-d052349878a8@xilinx.com>
 <20190408165109.GA6459@archbook>
 <CANk1AXQ5mHr0ZTuRoby3GomKbbQxv8z-O=o83VV=mXTh1aUZZA@mail.gmail.com>
In-Reply-To: <CANk1AXQ5mHr0ZTuRoby3GomKbbQxv8z-O=o83VV=mXTh1aUZZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71e1da6d-ad40-4ddc-a135-08d6bcb79899
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR02MB4469;
x-ms-traffictypediagnostic: BYAPR02MB4469:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB4469E3C1C1E5CCCD358C50D4C22D0@BYAPR02MB4469.namprd02.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(136003)(376002)(51914003)(199004)(189003)(13464003)(476003)(106356001)(105586002)(316002)(99286004)(14454004)(11346002)(486006)(76176011)(53936002)(66066001)(86362001)(6506007)(446003)(53546011)(4326008)(478600001)(54906003)(7696005)(93886005)(97736004)(186003)(110136005)(26005)(102836004)(81156014)(81166006)(305945005)(7736002)(9686003)(71200400001)(256004)(74316002)(71190400001)(8676002)(8936002)(2906002)(25786009)(52536014)(6116002)(68736007)(3846002)(229853002)(5660300002)(6436002)(33656002)(6246003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4469;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /QrVCwsKmvGHZZlQgwAYgjg3eD69Tksqa+oChFYaAvBIfNSkRk/iLsxlbkyWrGxgQ9uIZIt6BF0WFGzLuYhObKzOlgHD77XUsDIF2/uene7MxBsrNcBKW30SPTXC9ps2IxA34kyoKCiVwXFoKvgT9d/G4uMHRJ8NBSswXmXraqWBLaTr5b12WVnkBigfq/ROkHh7hPOOw3JaQOXsK6tRI19LASnEHxA+HMRpUl20ZAM9FSZZTkpE3B7MXQnNWsR/ktBL51Lff4dJaHeLAaP4Xn1MM9s6UDd6ZaV/dkRaG/Hn6iSgTI53f5nfmsZPMpvnGGy1Ltl7V6whwbZVXImz5WiYHMayyOAn37bt3qvE7GB4p2mdYWm2oH9YWZZQU3WH8+glgdzJ9mkHlOae54f8Quta3/m4RV4rWRVNA/8lBSk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e1da6d-ad40-4ddc-a135-08d6bcb79899
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 06:50:04.3665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KVGhhbmtzIGZvciB0aGUgcmVzcG9uc2UuDQpQbGVhc2UgZmluZCBteSByZXNw
b25zZSBpbmxpbmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxh
biBUdWxsIFttYWlsdG86YXR1bGxAa2VybmVsLm9yZ10NCj4gU2VudDogVHVlc2RheSwgQXByaWwg
OSwgMjAxOSAxOjU3IEFNDQo+IFRvOiBNb3JpdHogRmlzY2hlciA8bWRmQGtlcm5lbC5vcmc+DQo+
IENjOiBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IE5hdmEga2lzaG9yZSBNYW5u
ZQ0KPiA8bmF2YW1AeGlsaW54LmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+
OyBNYXJrIFJ1dGxhbmQNCj4gPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgUmFqYW4gVmFqYSA8UkFK
QU5WQHhpbGlueC5jb20+OyBKb2xseSBTaGFoDQo+IDxKT0xMWVNAeGlsaW54LmNvbT47IGxpbnV4
LWZwZ2FAdmdlci5rZXJuZWwub3JnOyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRQ0KPiBBTkQgRkxB
VFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47
DQo+IG1vZGVyYXRlZCBsaXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFSTSBBUkNISVRFQ1RV
UkUgPGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBsaW51eC1rZXJu
ZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBraXNob3JlIG0gPGNoaW5uaWtp
c2hvcmUzNjlAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDMvM10gZnBnYSBt
YW5hZ2VyOiBBZGRpbmcgRlBHQSBNYW5hZ2VyIHN1cHBvcnQgZm9yDQo+IFhpbGlueCB6eW5xbXAN
Cj4gDQo+IE9uIE1vbiwgQXByIDgsIDIwMTkgYXQgMTE6NTEgQU0gTW9yaXR6IEZpc2NoZXIgPG1k
ZkBrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IEhpIE1pY2hhbCwNCj4gPg0KPiA+IE9uIE1v
biwgQXByIDA4LCAyMDE5IGF0IDA0OjM2OjE1UE0gKzAyMDAsIE1pY2hhbCBTaW1layB3cm90ZToN
Cj4gPiA+IE9uIDA4LiAwNC4gMTkgMTY6MTcsIEFsYW4gVHVsbCB3cm90ZToNCj4gPiA+ID4gT24g
TW9uLCBBcHIgOCwgMjAxOSBhdCA3OjM5IEFNIE5hdmEga2lzaG9yZSBNYW5uZQ0KPiA8bmF2YW1A
eGlsaW54LmNvbT4gd3JvdGU6DQo+ID4gPiA+Pg0KPiA+ID4gPj4gSGkgQWxhbiwNCj4gPiA+ID4+
DQo+ID4gPiA+PiBUaGFua3MgZm9yIGxvb2sgaW50byBpdCBhbmQgcHJvdmlkaW5nIHRoZSBBQ0su
DQo+ID4gPiA+PiBJIGdvdCBvbmUgbWlub3IgY29tbWVudHMgZnJvbSBNb3JpdHogRmlzY2hlciBk
byB5b3Ugd2FudCBtZSBmaXggdGhhdA0KPiBpc3N1ZSBub3cgb3IgSSBjYW4gZml4IGl0IGxhdGVy
IGFzIGl04oCZcyBhIG1pbm9yIGNvbW1lbnQ/DQo+ID4gPiA+DQo+ID4gPiA+IFBsZWFzZSBmaXgg
Zm9yIE1vcml0eiBjb21tZW50Lg0KV2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KUmVn
YXJkcywNCk5hdmFraXNob3JlLg0K
