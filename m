Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAE4C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DF121655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="YWbCcmmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfG2ULI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:11:08 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:49308
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730144AbfG2ULF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:11:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCeNBNmCjC49os7LvsXKpfinTshpUvEKKLdIzJpBYRUs/ONI9oZbjMdB0ePXAi29akpaRHm1e+OVrhFNXyWvt4Go9nXOmFuBu70Gm2ZH/MansPNWys6dCvBsS/c0GoGHVaHZPcSTcaB1aSSYYVBsQjsaEj20EridGR2S0dTvsazCkp356MCgKrOd34+YXnluzxkXYfCiABzWp0vFoIIBUDFvU5K3uyXFI9BmmBv2PaPZ/VDesihwC+x0mJn8QNK2FBl4vwSPwdFnLG9K1ffKdWRrg/sN4UrKFjh9Toz/h1HrqJSdq20v7NyZ2gzV5NSpIZVRrWY7sCLzps+jC5F6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXVn8wV4RVC+z2KdELcSE9VVmmeSXCmEkyNuBNRfzU4=;
 b=kLYFlM4zhHzEg+F/ZnBrBZe9jziT+7+QSQV4U1eZMoGnKCGTOcRCnV5A4oPcNoi+d/8A3nuDaOoOx3MnnC2tjCvL4z6YRxlLgyJ1lj6ymH06tJp9R/N1AVbvcFCIH2QxKGa4YwkGBtaw9YKoPkzSdMLYUIWlG/WMzUe8OPAHX6T5qxStUoOQiZzJHUPpCZJc72sJdyXYLk9roe9vIeclIGCLubnjK1ODT12HUstNhVtfy88zJWqooay5CyqSdbkRKd1Z77k6t5cQBe60Q9kWlI41ZM1eyaiL15pHZIPJrTziTu7fV/WnCQPuxyXlA2on77f0gcDIZLKRqoPTol1Pag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXVn8wV4RVC+z2KdELcSE9VVmmeSXCmEkyNuBNRfzU4=;
 b=YWbCcmmOm+zBlx0BuqUDczw+6veSwlG1UNaBEWLadoRGWSEZjCdFE8DBpN3LgX1FGZLYGUZKnIyEsVwEetIF1nfqv6mf0uZGniX/C4ujjZzW9qKb6UKwfnOhSeV18nHkscUyvKOUVNiI2SRiL+MZceIas7tWcmB3DIgenCYO/dQ=
Received: from CY4PR05MB3494.namprd05.prod.outlook.com (10.171.246.163) by
 CY4PR05MB3464.namprd05.prod.outlook.com (10.171.248.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.11; Mon, 29 Jul 2019 20:10:58 +0000
Received: from CY4PR05MB3494.namprd05.prod.outlook.com
 ([fe80::84f3:3266:347a:26bf]) by CY4PR05MB3494.namprd05.prod.outlook.com
 ([fe80::84f3:3266:347a:26bf%4]) with mapi id 15.20.2136.010; Mon, 29 Jul 2019
 20:10:58 +0000
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 09/13] objtool: Prepare to merge recordmcount
Thread-Topic: [PATCH v3 09/13] objtool: Prepare to merge recordmcount
Thread-Index: AQHVQmOO4kt6r/gP8Em15ETleLxC4abgVKCAgAG6D4A=
Importance: high
X-Priority: 1
Date:   Mon, 29 Jul 2019 20:10:57 +0000
Message-ID: <8FC1CDA2-F58F-4D23-BB76-7BDDE56ADB58@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
 <2767f55f4a5fbf30ba0635aed7a9c5ee92ac07dd.1563992889.git.mhelsley@vmware.com>
 <20190728174807.vr7j6t7ebblub6cz@treble>
In-Reply-To: <20190728174807.vr7j6t7ebblub6cz@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mhelsley@vmware.com; 
x-originating-ip: [73.25.163.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7490d404-c574-4224-873b-08d71460dea5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR05MB3464;
x-ms-traffictypediagnostic: CY4PR05MB3464:
x-microsoft-antispam-prvs: <CY4PR05MB34649B47A375E2FBF6574238A0DD0@CY4PR05MB3464.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(199004)(189003)(71200400001)(66476007)(6916009)(486006)(64756008)(66946007)(2616005)(11346002)(102836004)(66556008)(478600001)(91956017)(446003)(86362001)(76116006)(476003)(5660300002)(6506007)(54906003)(316002)(76176011)(81686011)(7736002)(53546011)(186003)(99286004)(26005)(66446008)(53936002)(229853002)(68736007)(3846002)(305945005)(6436002)(25786009)(2906002)(6246003)(8936002)(36756003)(33656002)(81166006)(256004)(81156014)(6116002)(8676002)(4326008)(6512007)(66066001)(6486002)(71190400001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR05MB3464;H:CY4PR05MB3494.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bqZpQYDogdYK0EqGGsxzO+zdNl+0lMj/+4+vEuo9eUBR5Pbvmep6jevzV+8pSNLIgwfmZnFW2tEO1vTSsdbRE0RVGr67VbvCn4XMlZZD4tjkdAISPKUyMNhqxrPQ32FBXyTvcaC4Nanj/Sj+3tRvGtZkCZdmQ58NJxwwpZRVOhDa1stwzlF+bO7h7B02N3NLG5tCgbFepFfa5PbRawhcEUtegiJnpx+VgZL5zgAv8UB3eWHeBtu1IajLfgKfbzVdVbtr46rKJVDpc8aasYOzb5qeGlxpCC7L6zOdTbYFW3BRUZZVgh/Qv/wOtDudc9GoteMfj/t/hgkZYeAY1OF+S2kI7vvytnSeGbclIVpHq6GM/b+fu8VJZ17pstN4RPmrFp8ZTRL8/siYvOt80qDS5gDvQCQURWSQvRejsVB7MpM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E67737297CC9CF4EA599A3F99C43E2B2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7490d404-c574-4224-873b-08d71460dea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 20:10:57.9541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhelsley@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEp1bCAyOCwgMjAxOSwgYXQgMTA6NDggQU0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJv
ZUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgSnVsIDI0LCAyMDE5IGF0IDAyOjA1
OjAzUE0gLTA3MDAsIE1hdHQgSGVsc2xleSB3cm90ZToNCj4+IE1vdmUgcmVjb3JkbWNvdW50IGlu
dG8gdGhlIG9ianRvb2wgZGlyZWN0b3J5LiBXZSBrZWVwIHRoaXMgc3RlcCBzZXBhcmF0ZQ0KPj4g
c28gY2hhbmdlcyB3aGljaCB0dXJuIHJlY29yZG1jb3VudCBpbnRvIGEgc3ViY29tbWFuZCBvZiBv
Ymp0b29sIGRvbid0DQo+PiBnZXQgb2JzY3VyZWQuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IE1h
dHQgSGVsc2xleSA8bWhlbHNsZXlAdm13YXJlLmNvbT4NCj4+IC0tLQ0KPj4gc2NyaXB0cy8uZ2l0
aWdub3JlICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgLQ0KPj4gc2NyaXB0cy9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgLQ0KPj4gc2NyaXB0cy9NYWtlZmlsZS5i
dWlsZCAgICAgICAgICAgICAgICAgICAgIHwgMTEgKysrKysrLS0tLS0NCj4+IHRvb2xzL29ianRv
b2wvLmdpdGlnbm9yZSAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4+IHRvb2xzL29ianRvb2wv
QnVpbGQgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICsrDQo+PiB0b29scy9vYmp0b29sL01h
a2VmaWxlICAgICAgICAgICAgICAgICAgICAgfCAxMyArKysrKysrKysrKystDQo+PiB7c2NyaXB0
cyA9PiB0b29scy9vYmp0b29sfS9yZWNvcmRtY291bnQuYyAgfCAgMA0KPj4ge3NjcmlwdHMgPT4g
dG9vbHMvb2JqdG9vbH0vcmVjb3JkbWNvdW50LmggIHwgIDANCj4+IHtzY3JpcHRzID0+IHRvb2xz
L29ianRvb2x9L3JlY29yZG1jb3VudC5wbCB8ICAwDQo+PiA5IGZpbGVzIGNoYW5nZWQsIDIxIGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+PiByZW5hbWUge3NjcmlwdHMgPT4gdG9vbHMv
b2JqdG9vbH0vcmVjb3JkbWNvdW50LmMgKDEwMCUpDQo+PiByZW5hbWUge3NjcmlwdHMgPT4gdG9v
bHMvb2JqdG9vbH0vcmVjb3JkbWNvdW50LmggKDEwMCUpDQo+PiByZW5hbWUge3NjcmlwdHMgPT4g
dG9vbHMvb2JqdG9vbH0vcmVjb3JkbWNvdW50LnBsICgxMDAlKQ0KPiANCj4gQWNjb3JkaW5nIHRv
ICJnaXQgZ3JlcCByZWNvcmRtY291bnQiIHRoZXJlIGFyZSBhIGZldyBkb2N1bWVudGF0aW9uIGZp
bGVzDQo+IHdoaWNoIHJlZmVyZW5jZSByZWNvcmRtY291bnQgYW5kIHJlY29yZG1vdW50LnBsIGlu
IHRoZWlyIG9sZCBsb2NhdGlvbnMuDQo+IA0KPiBBbmQgdGhleSdsbCBwcm9iYWJseSBuZWVkIHVw
ZGF0aW5nIGFnYWluIGZvciB0aGUgbmV4dCBwYXRjaCBhcyB3ZWxsLg0KDQpFeGNlbGxlbnQgcG9p
bnQuIEnigJlsbCBpbnRlZ3JhdGUgdGhvc2UgY2hhbmdlcyBhbmQgcmVzZW5kLg0KDQpDaGVlcnMs
DQoJLU1hdHQ=
