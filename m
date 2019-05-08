Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A9821479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SxyHb3Hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEHIK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:10:56 -0400
Received: from mail-eopbgr740089.outbound.protection.outlook.com ([40.107.74.89]:28576
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbfEHIKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ3gxpjtpvAfC6f9c+Hwhla3AbSRGUq+dWyEU5aht8s=;
 b=SxyHb3Hitt6I8UzqizjzNqLX8xLp6cwYTf3LT18uZvu34nMzmfovm2u2YrEhMrEQQm+IyCiKHae57D/svprL+VnZJzaPJOR8VVJ0ifhpL4odAaWJKyORwQpp4BFJuzphiVc9nO3+SWGdiR38NC1DNeBQU0Qrjr2IsiEFtcA6fc8=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB4182.namprd02.prod.outlook.com (20.176.249.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Wed, 8 May 2019 08:10:50 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::4158:f3a1:5e61:54a2]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::4158:f3a1:5e61:54a2%2]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 08:10:50 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     "Claus H. Stovgaard" <cst@phaseone.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: configfs: Add lpm_Ux_disable
Thread-Topic: [PATCH] usb: gadget: configfs: Add lpm_Ux_disable
Thread-Index: AQHVBLh1NKHuOM5cT0ypNd70f8FPqaZgLlKAgACxpSA=
Date:   Wed, 8 May 2019 08:10:50 +0000
Message-ID: <BYAPR02MB559103E5E6C77B476A4B52F1A7320@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1557220655-123090-1-git-send-email-cst@phaseone.com>
         <1557221830.114189.8.camel@phaseone.com>
         <30102591E157244384E984126FC3CB4F639E9057@us01wembx1.internal.synopsys.com>
 <1557264537.26527.14.camel@phaseone.com>
In-Reply-To: <1557264537.26527.14.camel@phaseone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bee7229-906b-4716-6447-08d6d38caf1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB4182;
x-ms-traffictypediagnostic: BYAPR02MB4182:
x-ms-exchange-purlcount: 2
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB4182ABD14031EE85D45332CEA7320@BYAPR02MB4182.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(13464003)(7696005)(76176011)(11346002)(476003)(446003)(6436002)(6506007)(71200400001)(71190400001)(486006)(102836004)(110136005)(54906003)(5660300002)(186003)(99286004)(26005)(55016002)(2501003)(478600001)(33656002)(14454004)(229853002)(966005)(86362001)(74316002)(7736002)(305945005)(53936002)(9686003)(6306002)(2906002)(6116002)(4326008)(25786009)(6246003)(66066001)(3846002)(256004)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(81166006)(8936002)(81156014)(8676002)(76116006)(52536014)(19627235002)(68736007)(73956011)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4182;H:BYAPR02MB5591.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PyCjWnQBacnMbPU1XjyBOXEVY2/WWDqfubb2sYaSm2Eg/8yC6MK0nOExAaDvSRqZg349ZKWXa8TS2coaYpW5q2AjSwpO6SCpQSAqT7IZ68PVzMC3LSjM9I0m3r9SBlRWR5sqjJcczdy3QCCpWh5so//re8vy60mDDy8ybKE3CVQmqFsdcezfFuvPSUWHDBQwgLmHLILg9JkCtBTcZjtlzwVkda+Q4xsE9LxKDPGz8sqrPjAMyTTFdafLSqU+Ufzu59kEamjXGquNu6VJMZ0NDhWPWA1SJw/ob1N0q9vYDLKf6A7thS/mykhV9uJHnxpZ4sGU05CK3Lk0a+ii4r0n1f4O+JOU6K93f+1llclpJS4RaKXGVlmE8a5JGdOK7ghm4fRJujXpdfMO7g+Ccf6lMGb8LhIL2vuQlfXp2JkXtNA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bee7229-906b-4716-6447-08d6d38caf1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 08:10:50.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2xhdXMgJiBUaGluaCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTog
Q2xhdXMgSC4gU3RvdmdhYXJkIFttYWlsdG86Y3N0QHBoYXNlb25lLmNvbV0NCj5TZW50OiBXZWRu
ZXNkYXksIE1heSAwOCwgMjAxOSAyOjU5IEFNDQo+VG86IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1
eWVuQHN5bm9wc3lzLmNvbT47IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj5DYzogRmVsaXBl
IEJhbGJpIDxiYWxiaUBrZXJuZWwub3JnPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+PGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW51cmFn
IEt1bWFyIFZ1bGlzaGENCj48YW51cmFna3VAeGlsaW54LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIXSB1c2I6IGdhZGdldDogY29uZmlnZnM6IEFkZCBscG1fVXhfZGlzYWJsZQ0KPg0KPkhpIFRo
aW5oDQo+DQo+T24gdGlyLCAyMDE5LTA1LTA3IGF0IDE4OjUzICswMDAwLCBUaGluaCBOZ3V5ZW4g
d3JvdGU6DQo+PiBDbGF1cyBILiBTdG92Z2FhcmQgd3JvdGU6DQo+PiA+DQo+PiA+IFdoZXJlIEFu
dXJhZ3MgcGF0Y2ggZm9jdXMgb24gc2V0dGluZyBVMS9VMiBsYXRlbmN5IGluIHRoZSBCT1MNCj4+
ID4gZGVzY3JpcHRvciBmcm9tIHRoZSBkZXZpY2V0cmVlLCB0aGlzIHBhdGNoIGZvY3VzZXMgb24g
aGF2aW5nIGENCj4+ID4gY29uZmlnZnMNCj4+ID4gaW50ZXJmYWNlIGZvciBmb3JjaW5nIHRoZSBV
REMgKGhlcmUgdGhlIGR3YzMpIHRvIG5vdCBlbmFibGUgVTEvVTINCj4+ID4gYW5kDQo+PiA+IHJl
amVjdCB0aGUgU0VUX1NFTChVMS9VMikuDQo+PiA+DQo+PiA+IExvb2tpbmcgZm9yd2FyZCB0byBp
bnB1dC4NCj4+ID4NCj4+ID4gWzFdIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92
Mi91cmw/dT1odHRwcy0zQV9fd3d3LnNwaW5pYw0KPj4gPiBzLm5ldF9saXN0c19saW51eC0NCj4+
ID4NCj4yRHVzYl9tc2cxNzk3MzIuaHRtbCZkPUR3SURhUSZjPURQTDZfWF82SmtYRng3QVhXcUIw
dGcmcj11OUZZb3hLdHloDQo+PiA+IGpyR0ZjeWl4RllxVGp3MVpYMFZzRzJkOEZDbXprVFktDQo+
PiA+DQo+dyZtPXdLZHlXbVlwYlc3OTFMQW03cll3dkZZeDVFMGJqRU55WFp6SHZLNHZ5Rm8mcz1l
czdra2k2aXVMSlVwMnJKbg0KPj4gPiB6UDlhbFhLeWZKUE5TZnl4VFZDS0tEZF9yUSZlPQ0KPj4g
PiBbMl0gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNB
X193d3cuc3BpbmljDQo+PiA+IHMubmV0X2xpc3RzX2xpbnV4LQ0KPj4gPg0KPjJEdXNiX21zZzE3
OTM5My5odG1sJmQ9RHdJRGFRJmM9RFBMNl9YXzZKa1hGeDdBWFdxQjB0ZyZyPXU5RllveEt0eWgN
Cj4+ID4ganJHRmN5aXhGWXFUancxWlgwVnNHMmQ4RkNtemtUWS0NCj4+ID4NCj53Jm09d0tkeVdt
WXBiVzc5MUxBbTdyWXd2Rll4NUUwYmpFTnlYWnpIdks0dnlGbyZzPWNGVG1POXdQZjdiNlRaeA0K
PkZVDQo+PiA+IEFBSUpNMFpfd00xdHROSWMxcmN0MHVSNmNvJmU9DQo+PiA+DQo+PiA+DQo+Pg0K
Pj4gSSdtIG5vdCBzdXJlIHdobyB3aWxsIHN1Ym1pdCB0aGUgcGF0Y2ggdG8gbWFrZSBjaGFuZ2Ug
dG8gRFdDMyBmb3INCj4+IGRpc2FibGluZyBVMS9VMiAoQW51cmFnIG9yIHlvdSksIGJ1dCBjYW4g
eW91IHNwbGl0IHlvdXIgcGF0Y2ggYmV0d2Vlbg0KPj4gZHdjMyBhbmQgY29uZmlnZnMuDQo+DQo+
SGF2ZSBqdXN0IHdyaXR0ZW4gd2l0aCBBbnVyYWcsIGFuZCBoZSB3aWxsIHN1Ym1pdCBhIG5ldyBw
YXRjaCBzZXQsDQo+d2hlcmUgaGUgaGFzIHRha2VuIHRoZSBjb250cm9sIGluIGVwMC5jIGZyb20g
bXkgcGF0Y2gsIGFuZCBjb21iaW5lZA0KPndpdGggaGlzIGRldmljZXRyZWUgYmluZGluZ3MuIFNv
IHRoZSBwbGFuIGlzIHRvIGRyb3AgdGhlIGNvbmZpZ2ZzDQo+aW50ZXJmYWNlIGNvbXBsZXRlbHks
IGtlZXAgdGhlIGRldmljZXRyZWUgYmluZGluZyBuYW1lcyAoZGlzLXUxLWVudHJ5LQ0KPnF1aXJr
KSBhbmQgbGV0IGl0IGRvIDMgdGhpbmdzLg0KPipTZXRzIHRoZSBsYXRlbmN5IHRvIDAgaW4gdGhl
IEJPUw0KPipEaXNhYmxlIFUxL1UyIGFjY2VwdGVuY2UNCj4qRGlzYWJsZSBVMS9VMiBpbml0aWF0
aW5nDQo+VGhpcyBhbHNvIGluY2x1ZGUgcmVqZWN0aW5nIFNFVF9TRUwuDQo+DQo+V2UgdGhpbmsg
dGhpcyBpcyB0aGUgYmVzdCBvcHRpb24sIGFuZCB0aGVuIGRyb3BwaW5nIHRoaXMgcGF0Y2ggYXMg
aXQNCj5pcy4NCj4NCj5JIHdpbGwganVzdCBzZW5kIGFuZCBlbWFpbCBsYXRlciBvbiB0aGlzIHRo
cmVhZCwgd2hlbiB0aGUgcGF0Y2ggaXMNCj5hdmFpbGFibGUgb24gbWFyYy5pbmZvIGFzIGEgbGlu
ayBmb3IgcmVmZXJlbmNlIHRvIHRoZSBmdXR1cmUuDQo+DQoNCkkgaGF2ZSBzZW50IHRoZSB2MiBw
YXRjaCBzZXJpZXMgd2l0aCB0aGUgY2hhbmdlcyB0aGF0IENsYXVzIG1lbnRpb25lZCBhYm92ZS4N
ClRoZSBwYXRjaCBjYW4gYmUgZm91bmQgaGVyZSBodHRwczovL21hcmMuaW5mby8/bD1saW51eC1r
ZXJuZWwmbT0xNTU3MzAyMTI2MTgzODgmdz0yDQoNClRoYW5rcywNCkFudXJhZyBLdW1hciBWdWxp
c2hhDQo=
