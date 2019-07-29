Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604ECC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE0020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jzp11b/O";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="smN9E/nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbfG2Sbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:31:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21167 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbfG2Sbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564425110; x=1595961110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I3u0eN3jpLSX6MmkWRj2yR6KaE3ivdfHq4UfTECioWU=;
  b=Jzp11b/O77gNX8JiHANA/vIGV/zoa9G/9t6jt5LiZFCCkGuEjuBdpTIU
   hv45Rhti0jWTUkhpASiIEbplGwCacOuFfRkXX0Op/Q/rBq1tAh61OdhK4
   N6LfM6uXJ3OV7OBeMV3S1pQ9zEJh1R/76Ph8jvJcWKjN4Up0lHeBBy0lb
   ImAqr9p0HhpuRsHNqoT2vvaYz3q9TXNx4GP2u2mnS+vcO8PdKEVtreewU
   tgzltHkdtpWMIc5dy7a9oQDnsJOCjrvRpFUZ9830tWsrkeydH+grCbN3j
   59Jct67CqKtELjTIa7V/v+YTmb3rsfUbOCVhY18NkWeWg25MRczqu6LSi
   g==;
IronPort-SDR: 2kz2EdLmGhD5Bycq7f8LVyOTrwUgOSz9XnfIILsghGzyO0pAfex2TzL6WjQdGDngWBSBZbmZHN
 p/muyVBmtcT7ZH+sdFNn4qwE1L/IJvX4eFYI28QKonU+HJQLWWFr2CSufLj96k/evu1e7zY0ow
 LWNdGzv/pgY7zRil862tFTu9JpFbRk9JCk2BPyJRq2M2DcLXwI2YXd80RUkgzaETx3FJngrA2U
 DyVy0IyTq7NqBSvd3Da1HYy231YNEEj6Z0UOTwjalYBlYelNGVOh8+1mI5IS9dEorAVIPjfsaY
 2Tk=
X-IronPort-AV: E=Sophos;i="5.64,323,1559491200"; 
   d="scan'208";a="119103625"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2019 02:31:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9DM+SPo4oovZDVGqiyUTfFILvY1yb4E1atq5VxKhTw2u7oSSad7xtiJ9yjiv0bVV4VbzWw6WHJ1LCTn7UnvQgRfdueeb++Tsx6U7dvnikWYSCMARwYJ5eIwC4rHkogEjAOIZuzojPYs+0Nbj91g3DZc0nATDjhz+g0a5Y5tPI5RONqtqdSUiNy+PlxQmph7y0720ATI430WKG4c6q30yzW/OnltGt9CZXUQNsJlyMqbhFe6k8JLEX/cjiuGR4QjSbEaqPlrMRc8X1QRFbiRCNmuDg94pnx0cahUXO11E5BwNaD7Nuo/TyvISpcygJxwRTjBi+naxKXsbRm6Kh6ufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3u0eN3jpLSX6MmkWRj2yR6KaE3ivdfHq4UfTECioWU=;
 b=DysTij+efFBEndtgrDrOGh4SmSI38PGPmPNGcgScuUBySSYLTnwCIJ9WAu/PyBDMwQu2ckrSZ8TmJADEVIxtLo1JRaE1mVVXOQinma9jdcTaPF3kmAHHYuTGkroApQLus7Ef2H//qmhipHerWNSgQRKM3L7tXV0pc65/UmATjTQSOpum3rP1Rcc94En4nLN0c73rLlkSCD0GUbuBkQdgK2GBggYQIFz8NjiSHFoDddEaHOh0fLSiuy5yNIVqciqDdvs6VA/Jtp2gUpa/79tNIVVWtpzi8BKBGoC80FDjq+hxOsS+f72o5JCKoswt2v/m/6cAAKDYcnQO85IMTko86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3u0eN3jpLSX6MmkWRj2yR6KaE3ivdfHq4UfTECioWU=;
 b=smN9E/nvy3T6bia4ne/NSVIZmAAki7AVN5axjVqORXHL18vi2SP/bVByapQIZ26WYCtTMtqWQbdz/WPzQm34/H7L1+tK/1xwCn4L23Ocle0RV0fnUpskfymwkWIGgEDMEOJOLREk04FaSiyauVp90sr+65EMqUu5IW22rIcsdJA=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB6072.namprd04.prod.outlook.com (20.178.234.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Mon, 29 Jul 2019 18:31:47 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 18:31:47 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>
CC:     "alankao@andestech.com" <alankao@andestech.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
Thread-Topic: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
Thread-Index: AQHVQ+refROWkRWGQ0GJqrWaHX74e6bdXtyAgAAaDYCAABM8AIAAMKIAgABcAYCAAAOGAIAAAveAgAPQpgA=
Date:   Mon, 29 Jul 2019 18:31:47 +0000
Message-ID: <8ed4d461ffe5ac41b475d22b38019578b29a8d09.camel@wdc.com>
References: <20190726194638.8068-1-atish.patra@wdc.com>
         <20190726194638.8068-3-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com>
         <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com>
         <alpine.DEB.2.21.9999.1907261625220.26670@viisi.sifive.com>
         <MN2PR04MB6061790AFE4E0AAA838678028DC30@MN2PR04MB6061.namprd04.prod.outlook.com>
         <alpine.DEB.2.21.9999.1907270043190.26998@viisi.sifive.com>
         <CAAhSdy0Eycc0ORSnh6LJeC_D_x9yLOkoc7OkPNuN6qOcZEGVWg@mail.gmail.com>
         <alpine.DEB.2.21.9999.1907270108420.26998@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907270108420.26998@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.45.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c9e69bf-7225-45d6-2788-08d7145303bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6072;
x-ms-traffictypediagnostic: BYAPR04MB6072:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB6072E990FCD448A37D418B55FADD0@BYAPR04MB6072.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(68736007)(81166006)(81156014)(6306002)(6116002)(8676002)(71200400001)(3846002)(2501003)(86362001)(6436002)(7416002)(118296001)(71190400001)(2906002)(8936002)(6512007)(966005)(478600001)(25786009)(14454004)(5660300002)(53936002)(6246003)(102836004)(446003)(26005)(186003)(66066001)(66946007)(36756003)(76116006)(64756008)(66476007)(66446008)(66556008)(14444005)(256004)(2616005)(476003)(6486002)(229853002)(110136005)(486006)(54906003)(76176011)(305945005)(99286004)(6506007)(4326008)(316002)(11346002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6072;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8u3F/d4Yw6JTNQe8Lf4xdSLr7KCCaTDeO+NBiOh8xt5pJg4I9/jnbGi7K3dHQnwuZ/0ae65kS5ZpbrCc+jBBshw7MWxLt/0689s7iesOXN2Sd0vwZM+csBXVz7ql00e5c482dM4HnBsFZK23rP4r4KyH46UlT+kSZJWqnE4SBktUu/gESB8y/ZOOybS2ucKsqba5RVJuKbQky5cRqDOk58BZBuPRd18zkS94Hal0ESPrMFAGVafZZiUdFvvC6MqtvdtSpRWaFxoc6bF7maIm2UVt/Jv/IMiLl2CFZ22oJVZWmd914gkw1qjqSS38Yypo5MlY0Q++LoaBHj42Jie7g9NqNb9Jveqdc8w35B8/DVuqBh3wXR5sfuNMRRMYxMqQb5fUX7Gw4aelKjoIK4rDM/2mcQ7fHbs3Fl+pIoFMySs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1174BAB203B9D4C8B8F25B87456C7BD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9e69bf-7225-45d6-2788-08d7145303bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 18:31:47.2864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE5LTA3LTI3IGF0IDAxOjE2IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBTYXQsIDI3IEp1bCAyMDE5LCBBbnVwIFBhdGVsIHdyb3RlOg0KPiANCj4gPiBJZiB5b3Vy
IG9ubHkgb2JqZWN0aW9uIGlzIHVwcGVyY2FzZSBsZXR0ZXIgbm90IGFncmVlaW5nIHdpdGggWU1B
TA0KPiA+IHNjaGVtYQ0KPiA+IHRoZW4gd2h5IG5vdCBmaXggdGhlIFlNQUwgc2NoZW1hIHRvIGhh
dmUgcmVnZXggZm9yIFJJU0MtViBJU0ENCj4gPiBzdHJpbmc/DQo+IA0KPiBJIGRvbid0IGFncmVl
IHdpdGggeW91IHRoYXQgdGhlIHNwZWNpZmljYXRpb24gY29tcGVscyBzb2Z0d2FyZSB0bw0KPiBh
Y2NlcHQgDQo+IGFyYml0cmFyeSBjYXNlIGNvbWJpbmF0aW9ucyBpbiB0aGUgcmlzY3YsaXNhIERU
IHN0cmluZy4NCj4gDQo+ID4gVGhlIFlNQUwgc2NoZW1hIHNob3VsZCBub3QgZW5mb3JjZSBhbnkg
YXJ0aWZpY2lhbCByZXN0cmljdGlvbiB3aGljaA0KPiA+IGlzDQo+ID4gdGhlb3JldGljYWxseSBh
bGxvd2VkIGluIHRoZSBSSVNDLVYgc3BlYy4NCj4gDQo+IFVubGVzcyBzb21lb25lIGNhbiBjb21l
IHVwIHdpdGggYSBjb21wZWxsaW5nIHJlYXNvbiBmb3Igd2h5DQo+IHJlc3RyaWN0aW5nIA0KPiB0
aGUgRFQgSVNBIHN0cmluZ3MgdG8gYWxsIGxvd2VyY2FzZSBsZXR0ZXJzIGFuZCBudW1iZXJzIGlz
DQo+IGluc3VmZmljaWVudCB0byANCj4gZXhwcmVzcyB0aGUgZnVsbCByYW5nZSBvZiBvcHRpb25z
IGluIHRoZSBzcGVjLA0KDQpUaGUgeWFtbCBkb2N1bWVudCBkaWQgbm90IHNwZWNpZnkgYW55dGhp
bmcgYWJvdXQgYWxsIGlzYS1zdHJpbmdzIGhhcyB0bw0KYmUgbG93ZXJjYXNlIHVubGVzcyBJIG1p
c3NlZCBzb21ldGhpbmcuIFRoZSB0d28gZW51bSB2YWx1ZXMgYXJlIGFsbA0KbG93ZXJjYXNlIGJ1
dCB0aGUgZGVzY3JpcHRpb24gc2F5cyBhbGwgSVNBIHN0cmluZ3MgYXJlIGRvY3VtZW50ZWQgaW4N
CklTQSBzcGVjaWZpY2F0aW9uIHdoaWNoIGRlc2NyaWJlcyB0aGUgSVNBIHN0cmluZ3MgdG8gYmUg
Y2FzZQ0KaW5zZW5zaXRpdmUuIElNSE8sIHRoaXMgY3JlYXRlcyBjb25mdXNpb24gcmVzdWx0aW5n
IHRoZSBwYXRjaC4NClRoZSBleGlzdGluZyBlbnVtIHN0cmluZ3MgYXJlIGFscmVhZHkgb3V0ZGF0
ZWQgd2l0aCBrdm0gcGF0Y2hzZXQuDQoNCkkgYW0gZmluZSB3aXRoIGRyb3BwaW5nIHRoaXMgcGF0
Y2ggaWYgeWFtbCBjbGVhcmx5IGRvY3VtZW50IHRoZSBjYXNlDQpzZW5zaXRpdHZlIHRoaW5nLg0K
DQpGb2xsb3dpbmcgYXBwcm9hY2hlcyBjYW4gZG9uZSB0byBhdm9pZCB0aGlzIGNvbmZ1c2lvbiBp
biBmdXR1cmUuDQoNCjEuIFVwZGF0ZSB0aGUgZW51bSBzdHJpbmdzIHdpdGggZXZlcnkgbmV3IGV4
dGVuc2lvbiBhZGRlZC4NCgktIEdvb2QgY2hhbmNlIHRoYXQgc29tZWJvZHkgbWlzcyBzb21ldGhp
bmcgYW5kIHRoaXMgZ2V0cw0Kb3V0ZGF0ZWQgaW4gZnV0dXJlLg0KDQoyLiBKdXN0IGFkZCBvbmUg
bGluZSBpbiBEVCBiaW5kaW5nIGRlc2NyaXB0aW9uIHNheWluZyB0aGF0IA0KDQoiQWxsIGlzYSBz
dHJpbmdzIGhhcyB0byBiZSBsb3dlcmNhc2Ugc3RyaW5ncyIuIFdlIHNob3VsZCBtYW5kYXRlIHRo
aXMNCmluIFVuaXggUGxhdGZvcm0gc3BlY2lmaWNhdGlvbiBhcyB3ZWxsIHRvIGJlIGluIHN5bmMu
DQoNClRob3VnaHRzID8NCg0KPiAgdGhlIGFkZGl0aW9uYWwgY29tcGxleGl0eSANCj4gdG8gYWRk
IG1peGVkLWNhc2UgcGFyc2luZywgYm90aCBpbiB0aGlzIHBhdGNoIGFuZCBpbiB0aGUgb3RoZXIN
Cj4gcGF0Y2hlcyBpbiANCj4gdGhpcyBzZXJpZXMsIHNlZW1zIHBvaW50bGVzcy4NCj4gDQoNCg0K
PiANCj4gLSBQYXVsDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4gbGludXgtcmlzY3ZAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXJpc2N2DQoNCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
