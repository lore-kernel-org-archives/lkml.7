Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ECBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B72520883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Hzf5+RpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDIIfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:35:42 -0400
Received: from mail-eopbgr710062.outbound.protection.outlook.com ([40.107.71.62]:61184
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbfDIIfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4KLFxGPQeUPmUiF89zlZYVM9nYxO8IRL4dFwRKwp+Y=;
 b=Hzf5+RpWPL6vCYQp++1eKkB9veumquSMItiA4Wyi7zJ4xMPn/IAbqhuffUvvDIwVxmT1fDgO+FRaOAEVgEA0cvZITdj4Uov4WPb/wF40xRvXz4XDX5iRRDzwJGRzOEJqav/R+72iSjjS+Yfbh4PGNsiQh6opnjBCaN1aJRhWPek=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB3635.namprd02.prod.outlook.com (52.132.8.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Tue, 9 Apr 2019 08:35:36 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::9872:12d3:6703:84cd]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::9872:12d3:6703:84cd%2]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 08:35:36 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     gregkh <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Topic: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Index: AQHU3kvx8x3F3XN98kC51fP21to83qYS76+AgAAPpVCAABcFAIAAKM5QgAAdDACAIESy4A==
Date:   Tue, 9 Apr 2019 08:35:36 +0000
Message-ID: <BL0PR02MB56816342F4C32A14D64A83D7CB2D0@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
 <1552997064-432700-5-git-send-email-dragan.cvetic@xilinx.com>
 <CAK8P3a3uKOVW5HcQD9LLKfoeOkTnhE8M2rHsZuwjNUQv18=J_g@mail.gmail.com>
 <BL0PR02MB5681AEB47A24279266831D1BCB400@BL0PR02MB5681.namprd02.prod.outlook.com>
 <CAK8P3a115AM-iuGPgqEYfR7p9HMQL3fm9eL7370ogf3-DBrjbA@mail.gmail.com>
 <BL0PR02MB5681C0D1D5DB5F57E3640D9ACB400@BL0PR02MB5681.namprd02.prod.outlook.com>
 <CAK8P3a01ufKsJxWNG09qeyLvVH12jiLpLchOxdKie0wzU2=WWQ@mail.gmail.com>
In-Reply-To: <CAK8P3a01ufKsJxWNG09qeyLvVH12jiLpLchOxdKie0wzU2=WWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1604aef-261c-481d-cd74-08d6bcc656d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB3635;
x-ms-traffictypediagnostic: BL0PR02MB3635:
x-microsoft-antispam-prvs: <BL0PR02MB3635743005E2D18A0F1E9A77CB2D0@BL0PR02MB3635.namprd02.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(13464003)(8676002)(68736007)(97736004)(478600001)(7696005)(71190400001)(6916009)(86362001)(229853002)(6436002)(99286004)(9686003)(7736002)(2906002)(71200400001)(14454004)(53936002)(33656002)(76176011)(5024004)(446003)(3846002)(106356001)(316002)(6116002)(11346002)(256004)(25786009)(74316002)(81166006)(6506007)(93886005)(6246003)(5660300002)(53546011)(186003)(305945005)(8936002)(54906003)(102836004)(476003)(66066001)(55016002)(14444005)(52536014)(486006)(4326008)(105586002)(26005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3635;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: opou2VPDVYzSpUPgjC+Ji008DSOg9mchZmmkKwHtJekRrIRH/GBujqKopFP6YvU9As9iE7t3GVSxXDCDEzY48m70xHqIXm7SvUTAPdFor4s0O9cFg7HArYBFC3Unix0/JCjhCxZDOACmryqNHa8OiU4q5wVVnctDcBItVi+OUsDMYjKMhrHKqlvz27d/2LaFBSAcatxCZeTTHRaJDU3qmWSBDxMCu/49GtMpJJ/eacruSjD6ybh8PklHPOzEcYfBFLaMSS4q8SsxfEPSegZNuyHy17+srQa45DI/QEKiRQBOH+5YSJvGTeOHLFYF8KMgrIE0IxArGwHxb9MDGrJhkMGWMhIWlAaEx7hDONW2I0LQqvAQD1VACxvIUD0qhlQwjP8c4to28TdWOQZkuujZRX8W9+utffWj6wvubFTVxwE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1604aef-261c-481d-cd74-08d6bcc656d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 08:35:36.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiBb
bWFpbHRvOmFybmRAYXJuZGIuZGVdDQo+IFNlbnQ6IFR1ZXNkYXkgMTkgTWFyY2ggMjAxOSAxOTo0
Ng0KPiBUbzogRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuY0B4aWxpbnguY29tPg0KPiBDYzogZ3JlZ2to
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxp
bnguY29tPjsgRGVyZWsgS2llcm5hbiA8ZGtpZXJuYW5AeGlsaW54LmNvbT47IExpbnV4IEFSTQ0K
PiA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgTGludXggS2VybmVsIE1h
aWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwNC8xMl0gbWlzYzogeGlsaW54X3NkZmVjOiBBZGQgb3BlbiwgY2xvc2UgYW5kIGlv
Y3RsDQo+IA0KPiBPbiBUdWUsIE1hciAxOSwgMjAxOSBhdCA3OjEwIFBNIERyYWdhbiBDdmV0aWMg
PGRyYWdhbmNAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogQXJuZCBCZXJnbWFubiBbbWFpbHRvOmFybmRAYXJuZGIuZGVdDQo+
ID4gPiBTZW50OiBUdWVzZGF5IDE5IE1hcmNoIDIwMTkgMTU6MzYNCj4gPiA+IFRvOiBEcmFnYW4g
Q3ZldGljIDxkcmFnYW5jQHhpbGlueC5jb20+DQo+ID4gPiBDYzogZ3JlZ2toIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz47IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgTGlu
dXggQVJNIDxsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsNCj4gPiA+
IERlcmVrIEtpZXJuYW4gPGRraWVybmFuQHhpbGlueC5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGlu
ZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCAwNC8xMl0gbWlzYzogeGlsaW54X3NkZmVjOiBBZGQgb3BlbiwgY2xvc2UgYW5kIGlv
Y3RsDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBNYXIgMTksIDIwMTkgYXQgMzo1OSBQTSBEcmFnYW4g
Q3ZldGljIDxkcmFnYW5jQHhpbGlueC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiArICAgICAgIC8qIE9ubHkgb25lIG9wZW4gcGVyIGRldmljZSBhdCBhIHRpbWUgKi8NCj4gPiA+
ID4gPiA+ICsgICAgICAgaWYgKCFhdG9taWNfZGVjX2FuZF90ZXN0KCZ4c2RmZWMtPm9wZW5fY291
bnQpKSB7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgYXRvbWljX2luYygmeHNkZmVjLT5v
cGVuX2NvdW50KTsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0K
PiA+ID4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaGF0IGlzIHRoYXQg
bGltaXRhdGlvbiBmb3I/IElzIGl0IHdvcnNlIHRvIG9wZW4gaXQgdHdpY2UgdGhhbg0KPiA+ID4g
PiA+IHRvIGR1cCgpIG9yIGZvcmsoKT8NCj4gPiA+ID4gPg0KPiA+ID4gPiBUaGUgZGV2aWNlIGNh
biBiZSBvcGVuZWQgb25seSBvbmNlLg0KPiA+ID4NCj4gPiA+IFdoYXQgSSBtZWFuIGhlcmUgaXMg
dGhhdCBwcmV2ZW50aW5nIHRoZSBkb3VibGUgb3BlbigpIGlzDQo+ID4gPiBhIGZhaXJseSB3ZWFr
IHByb3RlY3Rpb246IGl0IG1lYW5zIHlvdSBjYW5ub3QgaGF2ZSBtdWx0aXBsZQ0KPiA+ID4gJ3N0
cnVjdCBmaWxlJyBwb2ludGVycyBhdHRhY2hlZCB0byB0aGUgc2FtZSBpbm9kZSwgYnV0IHlvdQ0K
PiA+ID4gY2FuIHN0aWxsIGhhdmUgdGhlIHNhbWUgJ3N0cnVjdCBmaWxlJyBiZWluZyBhdmFpbGFi
bGUgdG8NCj4gPiA+IG11bHRpcGxlIHByb2Nlc3Nlcy4NCj4gPiA+DQo+ID4gQ291bGQgeW91IHBs
ZWFzZSBzdWdnZXN0IHRoZSBzb2x1dGlvbj8NCj4gPiBNeSBpbnRlbnRpb24gd2FzIHRvIHByZXZl
bnQgbW9yZSB0aGFuIG9uZSBwcm9jZXNzIGFjY2VzcyB0aGUgc2FtZSBkZXZpY2UuDQo+IA0KPiBH
ZW5lcmFsbHkgc3BlYWtpbmcsIHlvdSBjYW4ndCBwcmV2ZW50IGl0LCBidXQgeW91IHNob3VsZCBt
YWtlIHN1cmUgdGhhdA0KPiBpZiB0d28gcHJvY2Vzc2VzIGF0dGVtcHQgdG8gdXNlIHRoZSBzYW1l
IGRldmljZSwgbm90aGluZyBiYWQgaGFwcGVucy4NCj4gVXN1YWxseSBpdCdzIGVub3VnaCB0byBo
YXZlIGFwcHJvcHJpYXRlIGxvY2tpbmcuDQo+IA0KVGhlcmUgaXMgYSBuZWVkIHRvIGluY3JlYXNl
IHRoZSBkcml2ZXIgc2VjdXJpdHksIGV2ZW4gdGhlIHByb3Bvc2VkIGlzIG5vdCBwZXJmZWN0LA0K
aXQgaXMgYWNjZXB0YWJsZSBmb3IgdXMgZm9yIG5vdy4NCg0KPiAgICAgICAgIEFybmQNCg==
