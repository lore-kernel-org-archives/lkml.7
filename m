Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5804CC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB4320656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=p1hq.onmicrosoft.com header.i=@p1hq.onmicrosoft.com header.b="jxwFK5oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfEGV3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:29:05 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:34023
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726650AbfEGV3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=p1hq.onmicrosoft.com;
 s=selector1-phaseone-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtCyHlAiOyN2Ma6ZABI2NLZIZKEn6jnAdNz1Yzufof8=;
 b=jxwFK5oz5J7HqQBMiWkSuLt7146rpyCxJ5L0/cyNT4ZHngeofAmLMvLn++vVs81I0B90THBrGqN5YtkRzHQG3itfC2Ye+pQrSYUSDnSr+AroXmHXm6G3dv+zWg0J3WRhWFtK81ApDX6rypnpeekpNzFRnwTOl2qC8izSLmnwVAE=
Received: from AM0PR01MB6019.eurprd01.prod.exchangelabs.com (10.255.30.76) by
 AM0PR01MB4371.eurprd01.prod.exchangelabs.com (52.135.146.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 21:28:59 +0000
Received: from AM0PR01MB6019.eurprd01.prod.exchangelabs.com
 ([fe80::f817:7fb7:3744:632e]) by AM0PR01MB6019.eurprd01.prod.exchangelabs.com
 ([fe80::f817:7fb7:3744:632e%2]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 21:28:59 +0000
From:   "Claus H. Stovgaard" <cst@phaseone.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: Re: [PATCH] usb: gadget: configfs: Add lpm_Ux_disable
Thread-Topic: [PATCH] usb: gadget: configfs: Add lpm_Ux_disable
Thread-Index: AQHVBLXEtmccm2+6b0C9UsHMCwwNFKZgLlWA
Date:   Tue, 7 May 2019 21:28:59 +0000
Message-ID: <1557264537.26527.14.camel@phaseone.com>
References: <1557220655-123090-1-git-send-email-cst@phaseone.com>
         <1557221830.114189.8.camel@phaseone.com>
         <30102591E157244384E984126FC3CB4F639E9057@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F639E9057@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2.110.44.75]
x-mailer: Evolution 3.24.6 
x-clientproxiedby: HE1PR09CA0076.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::20) To AM0PR01MB6019.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:160::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cst@phaseone.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0baa6ca-2367-44b8-eef7-08d6d33304a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR01MB4371;
x-ms-traffictypediagnostic: AM0PR01MB4371:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR01MB437107DD6749D6531F11E3E6DA310@AM0PR01MB4371.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39850400004)(396003)(199004)(189003)(71200400001)(6512007)(6306002)(54906003)(53936002)(73956011)(66476007)(305945005)(66946007)(6486002)(316002)(103116003)(229853002)(64756008)(68736007)(26005)(66556008)(6436002)(7736002)(66446008)(99286004)(2906002)(186003)(6246003)(55236004)(66066001)(19627235002)(102836004)(4326008)(76176011)(52116002)(50226002)(386003)(2501003)(8936002)(36756003)(81166006)(81156014)(86362001)(8676002)(71190400001)(6506007)(110136005)(6116002)(14454004)(2616005)(486006)(3846002)(446003)(11346002)(256004)(5660300002)(478600001)(476003)(966005)(25786009)(99106002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR01MB4371;H:AM0PR01MB6019.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: phaseone.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8qUVu3b4qevJZAWZ59AuSxDgAyrUeQ3O4zcqMs+U7n8zRRIamXwlVCMNhviJI8sZIEu+s9EAuqJHVMyVSRwfjzvIGdEjheQIDQ2IFqRPGpOXtgn1AJaEISufgWpOPlM6+BPL+LxTaAaAuCJVOPd8Irn5oWbkjtHcCXZDtBQaB5OTQAxijz3bPqsybZ03rqrR04kkm2f4XYZO4rUI0s/3L58fl57jUgEsDjrEDGQXzv1EYo6JrZNDPldc4EPVlArOMIsgzJkhT5gJAv2OvvmmUwF/nBLSH/p5OwnGyh+df2VEADR9OtQdnKhDTHwR/DtVRu9HNuG9OR2tDOtRjwETmQj47ptyAKojY2PP/IMeeoi0HrRyQ3XXsAAUa3v8oF8gL/Z+P3t4cFVaLMZhasdh+aYscyPu/IxSha+fHMToBwE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B66DF6DC137248429519E075D6AE925C@eurprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phaseone.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0baa6ca-2367-44b8-eef7-08d6d33304a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 21:28:59.7270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbe5b4c6-877a-4fe4-be65-3be424dd0574
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB4371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgNCg0KT24gdGlyLCAyMDE5LTA1LTA3IGF0IDE4OjUzICswMDAwLCBUaGluaCBOZ3V5
ZW4gd3JvdGU6DQo+IENsYXVzIEguIFN0b3ZnYWFyZCB3cm90ZToNCj4gPiANCj4gPiBXaGVyZSBB
bnVyYWdzIHBhdGNoIGZvY3VzIG9uIHNldHRpbmcgVTEvVTIgbGF0ZW5jeSBpbiB0aGUgQk9TDQo+
ID4gZGVzY3JpcHRvciBmcm9tIHRoZSBkZXZpY2V0cmVlLCB0aGlzIHBhdGNoIGZvY3VzZXMgb24g
aGF2aW5nIGENCj4gPiBjb25maWdmcw0KPiA+IGludGVyZmFjZSBmb3IgZm9yY2luZyB0aGUgVURD
IChoZXJlIHRoZSBkd2MzKSB0byBub3QgZW5hYmxlIFUxL1UyDQo+ID4gYW5kDQo+ID4gcmVqZWN0
IHRoZSBTRVRfU0VMKFUxL1UyKS4NCj4gPiANCj4gPiBMb29raW5nIGZvcndhcmQgdG8gaW5wdXQu
DQo+ID4gDQo+ID4gWzFdIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/
dT1odHRwcy0zQV9fd3d3LnNwaW5pYw0KPiA+IHMubmV0X2xpc3RzX2xpbnV4LQ0KPiA+IDJEdXNi
X21zZzE3OTczMi5odG1sJmQ9RHdJRGFRJmM9RFBMNl9YXzZKa1hGeDdBWFdxQjB0ZyZyPXU5Rllv
eEt0eWgNCj4gPiBqckdGY3lpeEZZcVRqdzFaWDBWc0cyZDhGQ216a1RZLQ0KPiA+IHcmbT13S2R5
V21ZcGJXNzkxTEFtN3JZd3ZGWXg1RTBiakVOeVhaekh2SzR2eUZvJnM9ZXM3a2tpNml1TEpVcDJy
Sm4NCj4gPiB6UDlhbFhLeWZKUE5TZnl4VFZDS0tEZF9yUSZlPQ0KPiA+IFsyXSBodHRwczovL3Vy
bGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3d3dy5zcGluaWMNCj4g
PiBzLm5ldF9saXN0c19saW51eC0NCj4gPiAyRHVzYl9tc2cxNzkzOTMuaHRtbCZkPUR3SURhUSZj
PURQTDZfWF82SmtYRng3QVhXcUIwdGcmcj11OUZZb3hLdHloDQo+ID4ganJHRmN5aXhGWXFUancx
WlgwVnNHMmQ4RkNtemtUWS0NCj4gPiB3Jm09d0tkeVdtWXBiVzc5MUxBbTdyWXd2Rll4NUUwYmpF
TnlYWnpIdks0dnlGbyZzPWNGVG1POXdQZjdiNlRaeEZVDQo+ID4gQUFJSk0wWl93TTF0dE5JYzFy
Y3QwdVI2Y28mZT0NCj4gPiANCj4gPiANCj4gDQo+IEknbSBub3Qgc3VyZSB3aG8gd2lsbCBzdWJt
aXQgdGhlIHBhdGNoIHRvIG1ha2UgY2hhbmdlIHRvIERXQzMgZm9yDQo+IGRpc2FibGluZyBVMS9V
MiAoQW51cmFnIG9yIHlvdSksIGJ1dCBjYW4geW91IHNwbGl0IHlvdXIgcGF0Y2ggYmV0d2Vlbg0K
PiBkd2MzIGFuZCBjb25maWdmcy4NCg0KSGF2ZSBqdXN0IHdyaXR0ZW4gd2l0aCBBbnVyYWcsIGFu
ZCBoZSB3aWxsIHN1Ym1pdCBhIG5ldyBwYXRjaCBzZXQsDQp3aGVyZSBoZSBoYXMgdGFrZW4gdGhl
IGNvbnRyb2wgaW4gZXAwLmMgZnJvbSBteSBwYXRjaCwgYW5kIGNvbWJpbmVkDQp3aXRoIGhpcyBk
ZXZpY2V0cmVlIGJpbmRpbmdzLiBTbyB0aGUgcGxhbiBpcyB0byBkcm9wIHRoZSBjb25maWdmcw0K
aW50ZXJmYWNlIGNvbXBsZXRlbHksIGtlZXAgdGhlIGRldmljZXRyZWUgYmluZGluZyBuYW1lcyAo
ZGlzLXUxLWVudHJ5LQ0KcXVpcmspIGFuZCBsZXQgaXQgZG8gMyB0aGluZ3MuDQoqU2V0cyB0aGUg
bGF0ZW5jeSB0byAwIGluIHRoZSBCT1MNCipEaXNhYmxlIFUxL1UyIGFjY2VwdGVuY2UNCipEaXNh
YmxlIFUxL1UyIGluaXRpYXRpbmcNClRoaXMgYWxzbyBpbmNsdWRlIHJlamVjdGluZyBTRVRfU0VM
Lg0KDQpXZSB0aGluayB0aGlzIGlzIHRoZSBiZXN0IG9wdGlvbiwgYW5kIHRoZW4gZHJvcHBpbmcg
dGhpcyBwYXRjaCBhcyBpdA0KaXMuDQoNCkkgd2lsbCBqdXN0IHNlbmQgYW5kIGVtYWlsIGxhdGVy
IG9uIHRoaXMgdGhyZWFkLCB3aGVuIHRoZSBwYXRjaCBpcw0KYXZhaWxhYmxlIG9uIG1hcmMuaW5m
byBhcyBhIGxpbmsgZm9yIHJlZmVyZW5jZSB0byB0aGUgZnV0dXJlLg0KDQpUaGFua3MNCkNsYXVz
DQo=
