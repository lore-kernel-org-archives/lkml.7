Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC80C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CD7205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iKah0Zbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfC2LI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:08:59 -0400
Received: from mail-eopbgr790077.outbound.protection.outlook.com ([40.107.79.77]:35301
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728683AbfC2LI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4Vh+/WNk68BZzHxjsdD2yDd0fRnNLJ+H0k1/ZNZ4qg=;
 b=iKah0Zbq3yrm1VxYnECl0r3NB/tzLBUDldZAv72kSELWGYZ/uNGdPow/RcVKhYLYWhyF+dxMhMLM2QZL/jsbZuCY1rm/rlUpIrGXsOTMfRzdkE/xyXiiuM3NM70Ma1oOo18z6/3oE0iLVvOvhLeRBd0U/0Sm4Ls1Dbigd9a2x5I=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2430.namprd02.prod.outlook.com (10.168.204.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Fri, 29 Mar 2019 11:08:52 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c89d:e485:cb5e:89cf]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c89d:e485:cb5e:89cf%5]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 11:08:52 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: RE: [LINUX PATCH 2/3] spi: spi-mem: call
 spi_mem_default_supports_op() first
Thread-Topic: [LINUX PATCH 2/3] spi: spi-mem: call
 spi_mem_default_supports_op() first
Thread-Index: AQHU5Ve+/XGEIGmXmEig+1VwCkqidaYhdasAgAD9PwCAAAHSQA==
Date:   Fri, 29 Mar 2019 11:08:52 +0000
Message-ID: <MWHPR02MB2623F73BEA721D64EE2C3BF9AF5A0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1553771784-3364-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190328205522.272e1da6@collabora.com>
 <cf7c971c-4b58-e965-3ca7-b72239772737@ti.com>
In-Reply-To: <cf7c971c-4b58-e965-3ca7-b72239772737@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c52ad7d-cdf3-4c0b-6a16-08d6b436ed67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2430;
x-ms-traffictypediagnostic: MWHPR02MB2430:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR02MB24303046B0BDF5110D7B4C31AF5A0@MWHPR02MB2430.namprd02.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(136003)(13464003)(189003)(199004)(71200400001)(486006)(74316002)(86362001)(2906002)(316002)(8936002)(305945005)(110136005)(25786009)(102836004)(5660300002)(54906003)(9686003)(53546011)(6246003)(6506007)(76176011)(26005)(7416002)(97736004)(99286004)(6436002)(55016002)(105586002)(7696005)(81156014)(7736002)(33656002)(68736007)(106356001)(6306002)(476003)(478600001)(66066001)(966005)(14454004)(11346002)(3846002)(81166006)(71190400001)(53936002)(6116002)(14444005)(186003)(229853002)(256004)(52536014)(4326008)(446003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2430;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YgxiA9nh2mGzWTk0XD/lxQR8d2/CB94/pzlhct3+qHn29laKYbGYsFK5ScfZSiZjBY9jXLyoGCtJjEKRa8P8BxymtlOrHJTb6tzZb72dgrzSgvMKtgkGJVEFnXW+FTsBiK3Q+q4MugGpIU1oOpMeBS2xC+vgYDxuFm7laY7BzkBS2ziJeTdkXZBHeJoSohc8uKHM/ApxAwG0jw5STxEyGr/R4vej6/wXMYMSrF6qjeM1nBXxK5OtIdJaVhS9jnfBRbo0tpPdo3DCihIIPOjKP8zxbH6dCst0ipR8Mu4kiNeWRx6p1c4eVUJ9VINaJCdUPc23xMo1IHWLOYI030k/3YPARVZYUYwpRmctwESQtTFH1ZAbWoR5MGd11MrMaV5FOpK3Y1bX91jnhIhPrBUf9jusJ6/d58nmvJPKps7uHyQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c52ad7d-cdf3-4c0b-6a16-08d6b436ed67
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:08:52.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51
eC1zcGktb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1zcGktb3duZXJAdmdlci5rZXJuZWwu
b3JnPiBPbiBCZWhhbGYgT2YNCj4gVmlnbmVzaCBSYWdoYXZlbmRyYQ0KPiBTZW50OiBGcmlkYXks
IE1hcmNoIDI5LCAyMDE5IDQ6MzIgUE0NCj4gVG86IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJl
emlsbG9uQGNvbGxhYm9yYS5jb20+OyBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpDQo+IDxuYWdhc3Vy
ZUB4aWxpbnguY29tPg0KPiBDYzogYnJvb25pZUBrZXJuZWwub3JnOyBiYnJlemlsbG9uQGtlcm5l
bC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGR3bXcyQGluZnJhZGVhZC5vcmc7
IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgcmljaGFyZEBub2QuYXQ7IGxpbnV4LQ0KPiBtdGRAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTWljaGFsIFNp
bWVrIDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiBuYWdhc3VyZXNoMTJAZ21haWwuY29tDQo+IFN1
YmplY3Q6IFJlOiBbTElOVVggUEFUQ0ggMi8zXSBzcGk6IHNwaS1tZW06IGNhbGwgc3BpX21lbV9k
ZWZhdWx0X3N1cHBvcnRzX29wKCkgZmlyc3QNCj4gDQo+IEhpIE5hZ2EgU3VyZXNoa3VtYXINCj4g
DQo+IE9uIDI5LzAzLzE5IDE6MjUgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gPiBPbiBU
aHUsIDI4IE1hciAyMDE5IDE2OjQ2OjI0ICswNTMwDQo+ID4gTmFnYSBTdXJlc2hrdW1hciBSZWxs
aSA8bmFnYS5zdXJlc2hrdW1hci5yZWxsaUB4aWxpbnguY29tPiB3cm90ZToNCj4gPg0KPiA+PiBD
YWxsIHNwaV9tZW1fZGVmYXVsdF9zdXBwb3J0c19vcCgpIGZpcnN0LCBiZWZvcmUgY2FsbGluZyBj
b250cm9sbGVyDQo+ID4+IHNwZWNpZmljIGN0bHItPnN1cHBvcnRzX29wKCkuDQo+ID4+IFdpdGgg
dGhpcywgY29udHJvbGxlciBkcml2ZXJzIGNhbiBkcm9wIGNoZWNraW5nIHRoZSBidXN3aWR0aHMg
YWdhaW4uDQo+ID4NCj4gPiBObywgdGhpcyB3YXMgZG9uZSBvbiBwdXJwb3NlLCBpbiBjYXNlIHRo
ZSBjb250cm9sbGVyIGRvZXMgbm90IHdhbnQgdGhlDQo+ID4gZGVmYXVsdCBjaGVjayB0byBiZSBh
cHBsaWVkIChzYXkgaXQgZG9lcyBub3QgbmVlZCBidXMtd2lkdGggcHJvcHMgdG8NCj4gPiBiZSBk
ZWZpbmVkIGFuZCBoYXMgYW5vdGhlciB3YXkgdG8gY2hlY2sgaWYgYSBkZXZpY2UgY2FuIGJlIGFj
Y2Vzc2VkIGluDQo+ID4gZHVhbCwgcXVhZCBvciBvY3RhbCBtb2RlKS4NCj4gPiBKdXN0IGNhbGwg
c3BpX21lbV9kZWZhdWx0X3N1cHBvcnRzX29wKCkgZnJvbSB5b3VyIGRyaXZlcg0KPiA+IC0+c3Vw
cG9ydHNfb3AoKSBob29rIGlmIG5lZWRlZC4NCj4gPg0KPiANCj4gQ291bGQgeW91IHJld29yayB0
byBmb2xsb3cgQm9yaXMncyBzdWdnZXN0aW9uIGhlcmU/DQpTdXJlLiBJIHdpbGwgdXBkYXRlLg0K
DQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFyIFJlbGxpDQo+IA0KPiA+Pg0KPiA+PiBTdWdnZXN0
ZWQtYnk6IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiA+PiA8bmFnYS5zdXJlc2hrdW1hci5y
ZWxsaUB4aWxpbnguY29tPg0KPiA+PiAtLS0NCj4gPj4gRGV0YWlscyBjYW4gYmUgZm91bmQgYXQg
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvMy8xLzE4Mw0KPiA+PiAtLS0NCj4gPj4gIGRyaXZl
cnMvc3BpL3NwaS1tZW0uYyB8IDcgKysrKystLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc3BpL3NwaS1tZW0uYyBiL2RyaXZlcnMvc3BpL3NwaS1tZW0uYyBpbmRleA0KPiA+PiA1MjE3
YTU2Li41NmFhMTU4IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbWVtLmMNCj4g
Pj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLW1lbS5jDQo+ID4+IEBAIC0xODksMTEgKzE4OSwxNCBA
QCBzdGF0aWMgYm9vbCBzcGlfbWVtX2ludGVybmFsX3N1cHBvcnRzX29wKHN0cnVjdCBzcGlfbWVt
DQo+ICptZW0sDQo+ID4+ICAJCQkJCSBjb25zdCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+ID4+
ICB7DQo+ID4+ICAJc3RydWN0IHNwaV9jb250cm9sbGVyICpjdGxyID0gbWVtLT5zcGktPmNvbnRy
b2xsZXI7DQo+ID4+ICsJYm9vbCByZXQ7DQo+ID4+ICsNCj4gPj4gKwlyZXQgPSBzcGlfbWVtX2Rl
ZmF1bHRfc3VwcG9ydHNfb3AobWVtLCBvcCk7DQo+ID4+DQo+ID4+ICAJaWYgKGN0bHItPm1lbV9v
cHMgJiYgY3Rsci0+bWVtX29wcy0+c3VwcG9ydHNfb3ApDQo+ID4+IC0JCXJldHVybiBjdGxyLT5t
ZW1fb3BzLT5zdXBwb3J0c19vcChtZW0sIG9wKTsNCj4gPj4gKwkJcmV0ID0gIGN0bHItPm1lbV9v
cHMtPnN1cHBvcnRzX29wKG1lbSwgb3ApOw0KPiA+Pg0KPiA+PiAtCXJldHVybiBzcGlfbWVtX2Rl
ZmF1bHRfc3VwcG9ydHNfb3AobWVtLCBvcCk7DQo+ID4+ICsJcmV0dXJuIHJldDsNCj4gPj4gIH0N
Cj4gPj4NCj4gPj4gIC8qKg0KPiA+DQo+IA0KPiAtLQ0KPiBSZWdhcmRzDQo+IFZpZ25lc2gNCg==
