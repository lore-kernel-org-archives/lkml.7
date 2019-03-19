Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A310C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248DF2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HF3VD85l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfCSSKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:10:39 -0400
Received: from mail-eopbgr710088.outbound.protection.outlook.com ([40.107.71.88]:9184
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfCSSKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmWHCJItBVZiWeJLxX1vjN+noS2bcvA/f2m7lhCg9LU=;
 b=HF3VD85lU8C2pxIUEBDojA5HNgfKMyc74qr6in6fax46sHUORjQf5y7g1lG8qt+WjE882rRuF78S0H2/4xq0yLzWOCkjRzmbqyr3Qtb/kliQJPLiPkKiNh0wxyol9oy5YidkpIPI5U15DSLovDI/s39XDpciybGLDwTklZHR9zM=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB4564.namprd02.prod.outlook.com (10.167.181.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 18:10:35 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::dc07:4b0:4a82:392a]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::dc07:4b0:4a82:392a%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 18:10:35 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     gregkh <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Topic: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Index: AQHU3kvx8x3F3XN98kC51fP21to83qYS76+AgAAPpVCAABcFAIAAKM5Q
Date:   Tue, 19 Mar 2019 18:10:35 +0000
Message-ID: <BL0PR02MB5681C0D1D5DB5F57E3640D9ACB400@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
 <1552997064-432700-5-git-send-email-dragan.cvetic@xilinx.com>
 <CAK8P3a3uKOVW5HcQD9LLKfoeOkTnhE8M2rHsZuwjNUQv18=J_g@mail.gmail.com>
 <BL0PR02MB5681AEB47A24279266831D1BCB400@BL0PR02MB5681.namprd02.prod.outlook.com>
 <CAK8P3a115AM-iuGPgqEYfR7p9HMQL3fm9eL7370ogf3-DBrjbA@mail.gmail.com>
In-Reply-To: <CAK8P3a115AM-iuGPgqEYfR7p9HMQL3fm9eL7370ogf3-DBrjbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 670dfeba-c851-4019-bd6d-08d6ac962ef6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4564;
x-ms-traffictypediagnostic: BL0PR02MB4564:
x-microsoft-antispam-prvs: <BL0PR02MB45648FC87C1EE79EEB84E59DCB400@BL0PR02MB4564.namprd02.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(13464003)(186003)(446003)(5660300002)(486006)(11346002)(52536014)(6346003)(7736002)(7696005)(476003)(76176011)(99286004)(256004)(4326008)(86362001)(5024004)(14444005)(55016002)(6246003)(3846002)(6116002)(53936002)(71200400001)(9686003)(97736004)(71190400001)(229853002)(316002)(106356001)(6436002)(66066001)(68736007)(2906002)(6916009)(478600001)(93886005)(14454004)(54906003)(25786009)(105586002)(26005)(305945005)(74316002)(53546011)(102836004)(6506007)(8936002)(33656002)(81166006)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4564;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PqkvcirALUdEma+svbdvF1tuRgN+33P6iBuRf3daxaEtXXcyOjL6SPUEjlfVmyuhxt2k/XxmWKovX7Sb4Z6COQT1IOuLFYXtrPfVr9SvqlM5dchofeaQylbJL9D6rai3GeOHHbReseNQuSt9Vp3UqCIKEk3v+yW7PsVerCTYtvLuSerma+ncRTbR5OjCROO5sEnmA/PP/FS9kMAVzdfkXC0HJLxPYSQUmF+bEGwDnEfvrDPq+AoPACdrFQC8ifSs1vtY13adQ9uLuIP/yGuMpbk7VV7xaSioftWEe1uEekLrwPopXBSqokkIDClK1voUmty2AYcivXmGiZi+BQEtHnPtOkQ5toiEgdt/RkZE0IZC5tRG0lnmP5kvdTDRm9TaNzDQVAw0cGqay65kmfhbA7S2o2+agPv/21APmX8bxBM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670dfeba-c851-4019-bd6d-08d6ac962ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 18:10:35.0426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiBb
bWFpbHRvOmFybmRAYXJuZGIuZGVdDQo+IFNlbnQ6IFR1ZXNkYXkgMTkgTWFyY2ggMjAxOSAxNToz
Ng0KPiBUbzogRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuY0B4aWxpbnguY29tPg0KPiBDYzogZ3JlZ2to
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxp
bnguY29tPjsgTGludXggQVJNIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+
Ow0KPiBEZXJlayBLaWVybmFuIDxka2llcm5hbkB4aWxpbnguY29tPjsgTGludXggS2VybmVsIE1h
aWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwNC8xMl0gbWlzYzogeGlsaW54X3NkZmVjOiBBZGQgb3BlbiwgY2xvc2UgYW5kIGlv
Y3RsDQo+IA0KPiBPbiBUdWUsIE1hciAxOSwgMjAxOSBhdCAzOjU5IFBNIERyYWdhbiBDdmV0aWMg
PGRyYWdhbmNAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiArICAgICAgIC8qIE9u
bHkgb25lIG9wZW4gcGVyIGRldmljZSBhdCBhIHRpbWUgKi8NCj4gPiA+ID4gKyAgICAgICBpZiAo
IWF0b21pY19kZWNfYW5kX3Rlc3QoJnhzZGZlYy0+b3Blbl9jb3VudCkpIHsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIGF0b21pY19pbmMoJnhzZGZlYy0+b3Blbl9jb3VudCk7DQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+ID4gPiArICAgICAgIH0NCj4gPiA+DQo+
ID4gPiBXaGF0IGlzIHRoYXQgbGltaXRhdGlvbiBmb3I/IElzIGl0IHdvcnNlIHRvIG9wZW4gaXQg
dHdpY2UgdGhhbg0KPiA+ID4gdG8gZHVwKCkgb3IgZm9yaygpPw0KPiA+ID4NCj4gPiBUaGUgZGV2
aWNlIGNhbiBiZSBvcGVuZWQgb25seSBvbmNlLg0KPiANCj4gV2hhdCBJIG1lYW4gaGVyZSBpcyB0
aGF0IHByZXZlbnRpbmcgdGhlIGRvdWJsZSBvcGVuKCkgaXMNCj4gYSBmYWlybHkgd2VhayBwcm90
ZWN0aW9uOiBpdCBtZWFucyB5b3UgY2Fubm90IGhhdmUgbXVsdGlwbGUNCj4gJ3N0cnVjdCBmaWxl
JyBwb2ludGVycyBhdHRhY2hlZCB0byB0aGUgc2FtZSBpbm9kZSwgYnV0IHlvdQ0KPiBjYW4gc3Rp
bGwgaGF2ZSB0aGUgc2FtZSAnc3RydWN0IGZpbGUnIGJlaW5nIGF2YWlsYWJsZSB0bw0KPiBtdWx0
aXBsZSBwcm9jZXNzZXMuDQo+IA0KQ291bGQgeW91IHBsZWFzZSBzdWdnZXN0IHRoZSBzb2x1dGlv
bj8NCk15IGludGVudGlvbiB3YXMgdG8gcHJldmVudCBtb3JlIHRoYW4gb25lIHByb2Nlc3MgYWNj
ZXNzIHRoZSBzYW1lIGRldmljZS4NCg0KPiAgICAgICAgICBBcm5kDQoNCg0KVGhhbmtzDQpEcmFn
YW4NCg==
