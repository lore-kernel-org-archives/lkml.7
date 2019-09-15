Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE0EC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 20:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680802067D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 20:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="ELJqTX//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfIOUmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 16:42:02 -0400
Received: from mail-eopbgr770134.outbound.protection.outlook.com ([40.107.77.134]:25571
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725270AbfIOUmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 16:42:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVdoNZu7THVUDQjR+1K6KibHFWNwvqVfSRTOpxRXV0VwJaEEMDdLUK2cEnFpe1zfmiqv3htlVjH0u613Oz+9V1/p5ryz6ZdDlSetMmyZzL8o5Iib2qg6ro13OlgztFxLkr0PwugqneRGOI6kvqomDCXO3Xy2AJQj20AkhYmBU0EriVwSSnabe1uv0zwULAotATeKNS/lJqglaGzm+5qoXTRUpjItFSzSq0DiiqQmFA+vfNJ1uNYWiySorao+Oawc9zfpZ3zUO/ZnajtfZeXu7SBtgLAgeKTX+/+MFB6iX0dGYptMkL+ifADkUOjcWfuAoYs532CsWWoEb0kn6dCyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tG+ifsCHzLRBvbHxjq5uQWC8tRm8GJgkwrsKJusbeE=;
 b=gL1ogpYKB6Rrbba+j6hGgVtbRB89iAcLkKjLW3FSvFvV9W1765deIuXeWxnpAmCERxlRrRSOtHEhxD8yPnHTigUHUPNQKWHrv7eByZ21Dq/8FIfmjZ49gVkXXSvyUIWRd8lp5yyJmELY8bl+AT65CrLd6z4Y4NLdfknLvmcfqnDm1ej+1QgCYl0a3Zvl6CNHHr7bVhrvp4ADiRNpFsp6zZT//7K9JmtB2sXoxhLWpzwmzQrtsISCfuo3Uc/YRhPxY39/ZIB2BH1XAJM9iR9vK1pe137dHn0uE8T8MU0rxWpoCOyLa3i4OadREJ9+S4MTeXVxDHL0I4dEXrYqVj0fzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tG+ifsCHzLRBvbHxjq5uQWC8tRm8GJgkwrsKJusbeE=;
 b=ELJqTX//uKVT9ZRHjGwco/nMdvZlKwurHMp0awcaBwjiCQ0l8RE0r8TUaD4WLSbf165+O/dThj7DJxtUQenXNcPy6rKEkbNzh0dyhSI3KNWCwEzTu+aco4/jxfeDPf8FYqjwI8yK+fgNzHx3tma6Dk25Oy4sBm7mZvIN+kK+WgU=
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com (10.173.174.144) by
 DM5PR1101MB2172.namprd11.prod.outlook.com (10.174.104.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Sun, 15 Sep 2019 20:41:55 +0000
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::798a:dabe:a59f:bb42]) by DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::798a:dabe:a59f:bb42%6]) with mapi id 15.20.2263.023; Sun, 15 Sep 2019
 20:41:55 +0000
From:   Jethro Beekman <jethro@fortanix.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Thread-Index: AQHVYr406/tKUl7vTUifobCqeM8uGactRn4A
Date:   Sun, 15 Sep 2019 20:41:55 +0000
Message-ID: <32ab6570-c3b7-4eec-7a0b-69bc2f7f76dc@fortanix.com>
References: <69f4a8e8-7889-8b00-0adc-7faaef6b42e4@fortanix.com>
In-Reply-To: <69f4a8e8-7889-8b00-0adc-7faaef6b42e4@fortanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To DM5PR1101MB2348.namprd11.prod.outlook.com
 (2603:10b6:3:a8::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [84.81.201.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 614b18f7-ed99-4d7b-7e47-08d73a1d251f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR1101MB2172;
x-ms-traffictypediagnostic: DM5PR1101MB2172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB217269734CC6BED5375D2605AA8D0@DM5PR1101MB2172.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01613DFDC8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(396003)(39830400003)(199004)(189003)(386003)(6506007)(53546011)(478600001)(102836004)(25786009)(26005)(2501003)(14454004)(66066001)(186003)(4326008)(81166006)(8676002)(81156014)(256004)(14444005)(52116002)(31696002)(76176011)(86362001)(6116002)(8936002)(3846002)(446003)(99286004)(5660300002)(2616005)(476003)(11346002)(6512007)(36756003)(53936002)(6436002)(31686004)(305945005)(2201001)(110136005)(486006)(2906002)(7736002)(6246003)(229853002)(71200400001)(107886003)(6486002)(71190400001)(66946007)(7416002)(66556008)(66476007)(66446008)(64756008)(316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1101MB2172;H:DM5PR1101MB2348.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L8c29mkgJmhEiPcVWV65NbUTLW4oCKBgist7lY6+N0su5elfpUSnP5Y/3PvOs7loHzab5z+/gHDQOpV03mw8t4ZSDMq/5BgQs5wjg5v3zxdoaQ1AjejVaQhOm7rny4fMvTq6lnkKfYFbEc/x5SMLO+R9GS5gfoHYIJeDTuuiuI+EyDza7MJS6ADM268aRVQvwjuCVgC3BinPVNAfoV9ArBWkQ6EQhJGcr+IgmobepUCxjr3/32zmVVISEkbTh4YgrM2ypb/MMaopLxGT55BL9n8tYzs+qCEsyCv8wjdi4XeMOsscutaYfR22j3r3XeMHGfgfHIyREl1eqT7gasozfRyP0BWx+Cj5d5kKKh+nnTBbp74gK0UwPVQCjZ2xy3KZcLpSuzT4JymE+wvwajeHUJQFP430F+NI95UFMuiB6mw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5859958FD3DCB40BA2A4C5F02A326ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614b18f7-ed99-4d7b-7e47-08d73a1d251f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2019 20:41:55.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBFvIgYxF1ZNEpj3fcKQu58sjHwNF4B1/YQb3EMnJmN+7QY3wYxQrQDZrAjaQ4Bhhm4iGGmF4BlYs0BXIq4qYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q291bGQgc29tZW9uZSBwbGVhc2UgcmV2aWV3IHRoaXM/DQoNCk9uIDIwMTktMDktMDQgMDM6MTUs
IEpldGhybyBCZWVrbWFuIHdyb3RlOg0KPiBTb21lIGZsYXNoIGNvbnRyb2xsZXJzIGRvbid0IGhh
dmUgYSBzb2Z0d2FyZSBzZXF1ZW5jZXIuIEF2b2lkDQo+IGNvbmZpZ3VyaW5nIHRoZSByZWdpc3Rl
ciBhZGRyZXNzZXMgZm9yIGl0LCBhbmQgZG91YmxlIGNoZWNrDQo+IGV2ZXJ5d2hlcmUgdGhhdCBp
dHMgbm90IGFjY2lkZW50YWxseSB0cnlpbmcgdG8gYmUgdXNlZC4NCj4gDQo+IEV2ZXJ5IHVzZSBv
ZiBgc3JlZ3NgIGlzIG5vdyBndWFyZGVkIGJ5IGEgY2hlY2sgb2YgYHNyZWdzYCBvcg0KPiBgc3dz
ZXFfcmVnYC4gVGhlIGNoZWNrIG1pZ2h0IGJlIGRvbmUgaW4gdGhlIGNhbGxpbmcgZnVuY3Rpb24u
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKZXRocm8gQmVla21hbiA8amV0aHJvQGZvcnRhbml4LmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS5jIHwgMjMgKysrKysr
KysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvaW50
ZWwtc3BpLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS5jDQo+IGluZGV4IDFjY2Yy
M2YuLjE5NWNkY2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvaW50ZWwtc3Bp
LmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9pbnRlbC1zcGkuYw0KPiBAQCAtMTg3LDEy
ICsxODcsMTYgQEAgc3RhdGljIHZvaWQgaW50ZWxfc3BpX2R1bXBfcmVncyhzdHJ1Y3QgaW50ZWxf
c3BpICppc3BpKQ0KPiAgCQlkZXZfZGJnKGlzcGktPmRldiwgIlBSKCVkKT0weCUwOHhcbiIsIGks
DQo+ICAJCQlyZWFkbChpc3BpLT5wcmVncyArIFBSKGkpKSk7DQo+ICANCj4gLQl2YWx1ZSA9IHJl
YWRsKGlzcGktPnNyZWdzICsgU1NGU1RTX0NUTCk7DQo+IC0JZGV2X2RiZyhpc3BpLT5kZXYsICJT
U0ZTVFNfQ1RMPTB4JTA4eFxuIiwgdmFsdWUpOw0KPiAtCWRldl9kYmcoaXNwaS0+ZGV2LCAiUFJF
T1BfT1BUWVBFPTB4JTA4eFxuIiwNCj4gLQkJcmVhZGwoaXNwaS0+c3JlZ3MgKyBQUkVPUF9PUFRZ
UEUpKTsNCj4gLQlkZXZfZGJnKGlzcGktPmRldiwgIk9QTUVOVTA9MHglMDh4XG4iLCByZWFkbChp
c3BpLT5zcmVncyArIE9QTUVOVTApKTsNCj4gLQlkZXZfZGJnKGlzcGktPmRldiwgIk9QTUVOVTE9
MHglMDh4XG4iLCByZWFkbChpc3BpLT5zcmVncyArIE9QTUVOVTEpKTsNCj4gKwlpZiAoaXNwaS0+
c3JlZ3MpIHsNCj4gKwkJdmFsdWUgPSByZWFkbChpc3BpLT5zcmVncyArIFNTRlNUU19DVEwpOw0K
PiArCQlkZXZfZGJnKGlzcGktPmRldiwgIlNTRlNUU19DVEw9MHglMDh4XG4iLCB2YWx1ZSk7DQo+
ICsJCWRldl9kYmcoaXNwaS0+ZGV2LCAiUFJFT1BfT1BUWVBFPTB4JTA4eFxuIiwNCj4gKwkJCXJl
YWRsKGlzcGktPnNyZWdzICsgUFJFT1BfT1BUWVBFKSk7DQo+ICsJCWRldl9kYmcoaXNwaS0+ZGV2
LCAiT1BNRU5VMD0weCUwOHhcbiIsDQo+ICsJCQlyZWFkbChpc3BpLT5zcmVncyArIE9QTUVOVTAp
KTsNCj4gKwkJZGV2X2RiZyhpc3BpLT5kZXYsICJPUE1FTlUxPTB4JTA4eFxuIiwNCj4gKwkJCXJl
YWRsKGlzcGktPnNyZWdzICsgT1BNRU5VMSkpOw0KPiArCX0NCj4gIA0KPiAgCWlmIChpc3BpLT5p
bmZvLT50eXBlID09IElOVEVMX1NQSV9CWVQpDQo+ICAJCWRldl9kYmcoaXNwaS0+ZGV2LCAiQkNS
PTB4JTA4eFxuIiwgcmVhZGwoaXNwaS0+YmFzZSArIEJZVF9CQ1IpKTsNCj4gQEAgLTM2Nyw2ICsz
NzEsMTEgQEAgc3RhdGljIGludCBpbnRlbF9zcGlfaW5pdChzdHJ1Y3QgaW50ZWxfc3BpICppc3Bp
KQ0KPiAgCQkgICAgISh1dnNjYyAmIEVSQVNFXzY0S19PUENPREVfTUFTSykpDQo+ICAJCQlpc3Bp
LT5lcmFzZV82NGsgPSBmYWxzZTsNCj4gIA0KPiArCWlmIChpc3BpLT5zcmVncyA9PSBOVUxMICYm
IChpc3BpLT5zd3NlcV9yZWcgfHwgaXNwaS0+c3dzZXFfZXJhc2UpKSB7DQo+ICsJCWRldl9lcnIo
aXNwaS0+ZGV2LCAic29mdHdhcmUgc2VxdWVuY2VyIG5vdCBzdXBwb3J0ZWQsIGJ1dCByZXF1aXJl
ZFxuIik7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiAgCS8qDQo+ICAJICog
U29tZSBjb250cm9sbGVycyBjYW4gb25seSBkbyBiYXNpYyBvcGVyYXRpb25zIHVzaW5nIGhhcmR3
YXJlDQo+ICAJICogc2VxdWVuY2VyLiBBbGwgb3RoZXIgb3BlcmF0aW9ucyBhcmUgc3VwcG9zZWQg
dG8gYmUgY2FycmllZCBvdXQNCj4gQEAgLTM4Myw3ICszOTIsNyBAQCBzdGF0aWMgaW50IGludGVs
X3NwaV9pbml0KHN0cnVjdCBpbnRlbF9zcGkgKmlzcGkpDQo+ICAJdmFsID0gcmVhZGwoaXNwaS0+
YmFzZSArIEhTRlNUU19DVEwpOw0KPiAgCWlzcGktPmxvY2tlZCA9ICEhKHZhbCAmIEhTRlNUU19D
VExfRkxPQ0tETik7DQo+ICANCj4gLQlpZiAoaXNwaS0+bG9ja2VkKSB7DQo+ICsJaWYgKGlzcGkt
PmxvY2tlZCAmJiBpc3BpLT5zcmVncykgew0KPiAgCQkvKg0KPiAgCQkgKiBCSU9TIHByb2dyYW1z
IGFsbG93ZWQgb3Bjb2RlcyBhbmQgdGhlbiBsb2NrcyBkb3duIHRoZQ0KPiAgCQkgKiByZWdpc3Rl
ci4gU28gcmVhZCBiYWNrIHdoYXQgb3Bjb2RlcyBpdCBkZWNpZGVkIHRvIHN1cHBvcnQuDQo+IA0K
DQo=
