Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5730AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0313720644
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JtjF7MBn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lSsLj8z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfHLRNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:13:46 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8138 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHLRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565630024; x=1597166024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vFJo+tHqL3RWOHoeVehBd13jVdVJPaazqoJj8dIzbJk=;
  b=JtjF7MBnz5+ZXjH5RK3nG1pLUA+XASuC0cytaeNKBq3WDVSvbhEo4jxe
   TLQ5xd5zyyQROom3ifaIZx9e2dPtsK4mW5t8cJhtwUG/wTyssCIo1l4mu
   zzhRpzq3lmdHtJvm3O8kwUp0QZLDEp78IRZTtG2HIaCRdqeTu74s46l78
   esECS6NZnSujI+53kKgXhKorf3W7DRnwBaGW8rrvqOXzFSSfOBMxgR3+Q
   w9ENj798tWrxpIGvO6uURdYMoKR6xvhzyswx7rDmWAr9zGcNTQr1pSLms
   GAtnDBZQ0pmkTYXDJeTLYQkeM5fpcaKc+b/BKYCGlsykdovLIxoRe1m/I
   w==;
IronPort-SDR: txI8ceQ0qmmu21SOQGT2RPr43oYeBd7IrpPdW+f8WFODchNU4HxXip1eHnKHgkk9vKeAv4D5De
 krmVufoIJXo7gvSDDfregI5FGt6viHgRAk/8ofZdXOvJiMAO3niZaT8cPUjepiER/pWrNPFNp+
 5pzp7swsUMM8HL9Imu9MLcYQFsITi1T8HskgZM/1LHiTjs6XCVfK5W9HDentIer0UbPWiCI5bF
 wpE5TNzsUW74dceW59UV5ESh4aj6ainEqZWRQsN3ug4fQtodoy7+4AAnfW+XhUdTSSWKyERI+o
 hms=
X-IronPort-AV: E=Sophos;i="5.64,378,1559491200"; 
   d="scan'208";a="120262497"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2019 01:13:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOo6N6CQcdXIH8/2nMLk62A1NCd7N2w+6YsFdLkZ6z1IVlgTJuaOEeHnWaPcEcHMwSCZexDKUnQqpJNdKCxe2Wn3Ys7prNdkQ636r2pBPnXskA2nuYpDMOsUp7bf69wsDP04Y/04pd5/k/ICjk+dduhTeJzN99k6qawu+Y5gPd4jMySImuIlv3+K6E5PUPescoL+sYETFf0ZYFC+l3grnjDeAw5RFpozy411Hp8HVfqgGC3Y42Vd2lm7Q3XuCB9tsNXZvRdlOAS4TbE/lBpoGc1HhqKXlXSWtArGWLvhFUw6wMeOjme8GO/3C+wIC1wxkRqU1HPHSwqusNdSnxkBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFJo+tHqL3RWOHoeVehBd13jVdVJPaazqoJj8dIzbJk=;
 b=NpbVO2IM3ZPP2IMi0ngLg96foGK7oTW8eVfwiWftW7C1yDpBfUSzONW89uqDqPUOFOODW45y8Ku156SGGfpHWBeuEPM1UIKmOWZRZGqftDz9HIM5Niz7E9hfTVHcBHT/CiV9m/UsDiMwqyefOqugavsAJMyy+ksKg886lQqdAAn0vsI9bkax062SocQPA5AsxKXRbXUE9JWBQsfHlOJC+q/O3qfQ08EhJAzQUOcZRWeefzei/FZipWE6hy1xleNgshYR6slRhMvIwfb1TkLmR9praTRpMhAzCPE6bPzvt1dnh1+C0bIuR4T8cK4bHAl1vVA9RotbjsCUO6m34PWH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFJo+tHqL3RWOHoeVehBd13jVdVJPaazqoJj8dIzbJk=;
 b=lSsLj8z51cCmz2A0q2SFj9WKZiCai1dr3oml5TxGjwLk8mLxTRCIw9SLGr00eWt1e+MUMCikUdNdaTJ/qhNEGBKtfsOeqgqKvWatXvdqNhx8WNnfAgOjfqFEy7a7lY8FLtKHccqC0ic7Gzim1fQAgwj0CVVYLOh0AsW3bs2USt8=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB4966.namprd04.prod.outlook.com (52.135.232.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 17:13:37 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005; Mon, 12 Aug 2019
 17:13:37 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "troy.benjegerdes@sifive.com" <troy.benjegerdes@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rminnich@gmail.com" <rminnich@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Topic: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Index: AQHVTxz5XkoGRRVrekixM0/zCIcSeKb3qSyAgAAbJwA=
Date:   Mon, 12 Aug 2019 17:13:36 +0000
Message-ID: <17a6582c28ff3a008d3ef960c3e36c0bc7013e33.camel@wdc.com>
References: <20190810014309.20838-1-atish.patra@wdc.com>
         <118B0DE7-EDCC-4947-88E5-7FF133A757D8@sifive.com>
In-Reply-To: <118B0DE7-EDCC-4947-88E5-7FF133A757D8@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26319d05-97b8-424c-1996-08d71f4869dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4966;
x-ms-traffictypediagnostic: BYAPR04MB4966:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB49661DB11F013687E4915B52FAD30@BYAPR04MB4966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(6436002)(81156014)(81166006)(8676002)(71190400001)(4326008)(6916009)(53936002)(5640700003)(102836004)(64756008)(66446008)(7736002)(66556008)(66476007)(305945005)(66946007)(86362001)(316002)(6506007)(26005)(118296001)(76116006)(6486002)(8936002)(186003)(53546011)(36756003)(76176011)(6246003)(229853002)(2616005)(446003)(11346002)(486006)(5660300002)(476003)(54906003)(2501003)(71200400001)(14454004)(2351001)(6306002)(2906002)(7416002)(66066001)(966005)(256004)(25786009)(99286004)(14444005)(3846002)(6116002)(478600001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4966;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zm6ua4J7ghCBPhCScn6fHbvNGNx7Gio3RjBdzC6ux2mE61HLJHF8zgey+BPxqFvT0ka3ouTlkD99Ptu4JVZwAMWKHnaAqRbjnLF97VJv1lsWSG+IRAV3DeM4MlImxlFOe6yBNgGN/vgCeLedk3VhAO8IjTsQ8My7NVVJDFsZPHPuMZaiMxnnRCgf9043dyIX8FVXNLhBeRLXGZ5RcFcexk6i5awspKxeJfLQws3PBvAoqn15Fji6G2DoOxQSMaH8MaCcP90iTMeSr+MgQE7YNZsPQILQSKV7QivIahhp7Jag/JM7ZaMCizO/h0L38aXhZxz0EVdNPPmEBL4J2wDGCRMlpD48cTSfx+ZQq7u216/BQVVkJxRdl70kdd0mhiLVWplBKUm2yvg9lOi+RDJNtSDNgcEyVPmrQ6h9hSZ+XBs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <814AE27BD0DD2D4CBA2F5FAB20E9F7D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26319d05-97b8-424c-1996-08d71f4869dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 17:13:36.8933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4966
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTEyIGF0IDEwOjM2IC0wNTAwLCBUcm95IEJlbmplZ2VyZGVzIHdyb3Rl
Og0KPiA+IE9uIEF1ZyA5LCAyMDE5LCBhdCA4OjQzIFBNLCBBdGlzaCBQYXRyYSA8YXRpc2gucGF0
cmFAd2RjLmNvbT4NCj4gPiB3cm90ZToNCj4gPiANCj4gPiBJbiBSSVNDLVYsIHRsYiBmbHVzaCBo
YXBwZW5zIHZpYSBTQkkgd2hpY2ggaXMgZXhwZW5zaXZlLg0KPiA+IElmIHRoZSB0YXJnZXQgY3B1
bWFzayBjb250YWlucyBhIGxvY2FsIGhhcnRpZCwgc29tZSBjb3N0DQo+ID4gY2FuIGJlIHNhdmVk
IGJ5IGlzc3VpbmcgYSBsb2NhbCB0bGIgZmx1c2ggYXMgd2UgZG8gdGhhdA0KPiA+IGluIE9wZW5T
QkkgYW55d2F5cy4NCj4gDQo+IElzIHRoZXJlIGFueXRoaW5nIG90aGVyIHRoYW4gY29udmVudGlv
biBhbmQgY3VycmVudCB1c2FnZSB0aGF0DQo+IHByZXZlbnRzDQo+IHRoZSBrZXJuZWwgZnJvbSBu
YXRpdmVseSBoYW5kbGluZyBUTEIgZmx1c2hlcyB3aXRob3V0IGV2ZXIgbWFraW5nIHRoZQ0KPiBT
QkkNCj4gY2FsbD8NCj4gDQo+IFNvbWVvbmUgaXMgZXZlbnR1YWxseSBnb2luZyB0byB3YW50IHRv
IHJ1biB0aGUgbGludXgga2VybmVsIGluDQo+IG1hY2hpbmUgbW9kZSwNCj4gbGlrZWx5IGZvciBw
ZXJmb3JtYW5jZSBhbmQvb3Igc2VjdXJpdHkgcmVhc29ucywgYW5kIHRoaXMgd2lsbCByZXF1aXJl
DQo+IGZsdXNoaW5nIFRMQnMNCj4gbmF0aXZlbHkgYW55d2F5Lg0KPiANCg0KVGhlIHN1cHBvcnQg
aXMgYWxyZWFkeSBhZGRlZCBieSBDaHJpc3RvcGggaW4gbm9tbXUgc2VyaWVzLg0KDQpodHRwczov
L2xrbWwub3JnL2xrbWwvMjAxOS82LzEwLzkzNQ0KDQpUaGUgaWRlYSBpcyB0byBqdXN0IHNlbmQg
SVBJcyBkaXJlY3RseSBpbiBMaW51eC4gVGhlIHNhbWUgYXBwcm9hY2ggaXMNCm5vdCBnb29kIGlu
IFN1cGVydmlzb3IgbW9kZSB1bnRpbCB3ZSBjYW4gZ2V0IHJpZCBvZiBJUElzIHZpYSBTQkkgYWxs
DQp0b2dldGhlci4gT3RoZXJ3aXNlLCBldmVyeSB0bGJmbHVzaCB3aWxsIGJlIGV2ZW4gbW9yZSBl
eHBlbnNpdmUgYXMgaXQNCmhhcyB0byBjb21lYmFjayB0byBTIG1vZGUgYW5kIHRoZW4gZXhlY3V0
ZSBzZmVuY2Uudm1hLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlz
aC5wYXRyYUB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vdGxi
Zmx1c2guaCB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAtLS0NCj4gPiAx
IGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oDQo+ID4gYi9h
cmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCj4gPiBpbmRleCA2ODdkZDE5NzM1YTcu
LmIzMmJhNGZhNTg4OCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3Rs
YmZsdXNoLmgNCj4gPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCj4g
PiBAQCAtOCw2ICs4LDcgQEANCj4gPiAjZGVmaW5lIF9BU01fUklTQ1ZfVExCRkxVU0hfSA0KPiA+
IA0KPiA+ICNpbmNsdWRlIDxsaW51eC9tbV90eXBlcy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
c2NoZWQuaD4NCj4gPiAjaW5jbHVkZSA8YXNtL3NtcC5oPg0KPiA+IA0KPiA+IC8qDQo+ID4gQEAg
LTQ2LDE0ICs0NywzOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcmVtb3RlX3NmZW5jZV92bWEoc3Ry
dWN0DQo+ID4gY3B1bWFzayAqY21hc2ssIHVuc2lnbmVkIGxvbmcgc3RhcnQsDQo+ID4gCQkJCSAg
ICAgdW5zaWduZWQgbG9uZyBzaXplKQ0KPiA+IHsNCj4gPiAJc3RydWN0IGNwdW1hc2sgaG1hc2s7
DQo+ID4gKwlzdHJ1Y3QgY3B1bWFzayB0bWFzazsNCj4gPiArCWludCBjcHVpZCA9IHNtcF9wcm9j
ZXNzb3JfaWQoKTsNCj4gPiANCj4gPiAJY3B1bWFza19jbGVhcigmaG1hc2spOw0KPiA+IC0Jcmlz
Y3ZfY3B1aWRfdG9faGFydGlkX21hc2soY21hc2ssICZobWFzayk7DQo+ID4gLQlzYmlfcmVtb3Rl
X3NmZW5jZV92bWEoaG1hc2suYml0cywgc3RhcnQsIHNpemUpOw0KPiA+ICsJY3B1bWFza19jbGVh
cigmdG1hc2spOw0KPiA+ICsNCj4gPiArCWlmIChjbWFzaykNCj4gPiArCQljcHVtYXNrX2NvcHko
JnRtYXNrLCBjbWFzayk7DQo+ID4gKwllbHNlDQo+ID4gKwkJY3B1bWFza19jb3B5KCZ0bWFzaywg
Y3B1X29ubGluZV9tYXNrKTsNCj4gPiArDQo+ID4gKwlpZiAoY3B1bWFza190ZXN0X2NwdShjcHVp
ZCwgJnRtYXNrKSkgew0KPiA+ICsJCS8qIFNhdmUgdHJhcCBjb3N0IGJ5IGlzc3VpbmcgYSBsb2Nh
bCB0bGIgZmx1c2ggaGVyZSAqLw0KPiA+ICsJCWlmICgoc3RhcnQgPT0gMCAmJiBzaXplID09IC0x
KSB8fCAoc2l6ZSA+IFBBR0VfU0laRSkpDQo+ID4gKwkJCWxvY2FsX2ZsdXNoX3RsYl9hbGwoKTsN
Cj4gPiArCQllbHNlIGlmIChzaXplID09IFBBR0VfU0laRSkNCj4gPiArCQkJbG9jYWxfZmx1c2hf
dGxiX3BhZ2Uoc3RhcnQpOw0KPiA+ICsJCWNwdW1hc2tfY2xlYXJfY3B1KGNwdWlkLCAmdG1hc2sp
Ow0KPiA+ICsJfSBlbHNlIGlmIChjcHVtYXNrX2VtcHR5KCZ0bWFzaykpIHsNCj4gPiArCQkvKiBj
cHVtYXNrIGlzIGVtcHR5LiBTbyBqdXN0IGRvIGEgbG9jYWwgZmx1c2ggKi8NCj4gPiArCQlsb2Nh
bF9mbHVzaF90bGJfYWxsKCk7DQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAr
CWlmICghY3B1bWFza19lbXB0eSgmdG1hc2spKSB7DQo+ID4gKwkJcmlzY3ZfY3B1aWRfdG9faGFy
dGlkX21hc2soJnRtYXNrLCAmaG1hc2spOw0KPiA+ICsJCXNiaV9yZW1vdGVfc2ZlbmNlX3ZtYSho
bWFzay5iaXRzLCBzdGFydCwgc2l6ZSk7DQo+ID4gKwl9DQo+ID4gfQ0KPiA+IA0KPiA+IC0jZGVm
aW5lIGZsdXNoX3RsYl9hbGwoKSBzYmlfcmVtb3RlX3NmZW5jZV92bWEoTlVMTCwgMCwgLTEpDQo+
ID4gLSNkZWZpbmUgZmx1c2hfdGxiX3BhZ2Uodm1hLCBhZGRyKSBmbHVzaF90bGJfcmFuZ2Uodm1h
LCBhZGRyLCAwKQ0KPiA+ICsjZGVmaW5lIGZsdXNoX3RsYl9hbGwoKSByZW1vdGVfc2ZlbmNlX3Zt
YShOVUxMLCAwLCAtMSkNCj4gPiArI2RlZmluZSBmbHVzaF90bGJfcGFnZSh2bWEsIGFkZHIpIGZs
dXNoX3RsYl9yYW5nZSh2bWEsIGFkZHIsDQo+ID4gKGFkZHIpICsgUEFHRV9TSVpFKQ0KPiA+ICNk
ZWZpbmUgZmx1c2hfdGxiX3JhbmdlKHZtYSwgc3RhcnQsIGVuZCkgXA0KPiA+IAlyZW1vdGVfc2Zl
bmNlX3ZtYShtbV9jcHVtYXNrKCh2bWEpLT52bV9tbSksIHN0YXJ0LCAoZW5kKSAtDQo+ID4gKHN0
YXJ0KSkNCj4gPiAjZGVmaW5lIGZsdXNoX3RsYl9tbShtbSkgXA0KPiA+IC0tIA0KPiA+IDIuMjEu
MA0KPiA+IA0KPiA+IA0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQo+ID4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtcmlzY3ZA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
