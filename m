Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A088C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4907D20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NbkFVVmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfHLPii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:38:38 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:17779 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:38:37 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: HVM3Ypcbb0kWK83dM3HZJNGEUcROICj9HAvliyFvddmtdhq0O4P3epGeCOqYCmTQL4tLunYNvh
 lgjXYKqoC0fIRRBVbfa2EwYhrgbU/NTfUTUZicjDVzpQmexqzc0ZmsEaVnatwOjjsKOltjkw4v
 y/s4UTjXyJjr3jgSl432MMDUSASbFQFg0As968HbRCPQ0REZYsoVGMkDeVHEIQIpzRNgcByH+h
 nVnAl3ooZufeigdPplWdRIlx2MQrfPaobZUQWFh6V6ehcigTyv4u0DmS5D3O0Yru2it/7owuy9
 Yo0=
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="44000997"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2019 08:38:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Aug 2019 08:38:34 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 12 Aug 2019 08:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDovpHfHa/eV+0caKiPB3G2/wfhYc0GKsshUxZ7rCbIqcuCKHN43mwvVB/lfa6DL1wIwXEHlegrcpdoOTQxGqDZ0cmgiIs0ENJiLSPx77YqwZahesE1j+QEjZUVEk/b7S62+cN2fhAoA4r+gFR4K8Fo9GoAIgpdzFjAMuRraO83zVgZ/C2PmX6OGC5YR8XIuJwD2dxVVEuXv1rDK2I3agjgg3C9ye6gdWoAKwdBZmQX2XewhcDtc7/yazkwzEJNo/xH7OSy8l5BsQ0Blt0xQuZSPp535hDWHDnxRoZDVz1bbkxfrYGds2bTRGH/ttYo7wEbyWcbGtOcx5EMAy+XccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r76JbPtMf2px6tRkAqyMgwErJRKaGzYabwivHe7HpoE=;
 b=g3V+fPD2huko2N0/dQCrzMyjNuHAACj1zePN5ENQwT7RmBNdfruHzupJzEksMBlGTDlvczH4yunAHvIuwhoaFu+pyi5My/0erSw1dH+jOZS0GJsJlEiok+8Cnxt5ypDIDvmlCPf5SAA6RSPnjyFfrBeD8aSXhQmvm99VswVmx39ODl/9O7NwaLGPI92kcAhTadRzTcFSVWDiWi5hLTXVl/apNW1YkZOSjGkoEMRdsCm/miWU07u1XgAhNrgG6ya3ewp5bFVUCiA6Z/KXLahL3F2XrxPVEHh9GhtKQCUSUB7Iwcb6hEXfHASFdh2NIPU9Wfca036FeeGM3Da6C7yPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r76JbPtMf2px6tRkAqyMgwErJRKaGzYabwivHe7HpoE=;
 b=NbkFVVmON7Q00Z+et9+xsFu2QzC+sHn3ADM+94mjKESVEmpjx5LD/xG2n20wOXSEz4wphMrna/w7hBP64gLQDmlNstIgW3VWXl25h4PEZ+7LhqVqMHw1CMkgBlMPwEqPZ913sarNfJpA7zIaUdnx7BHYUYp4FnaMUraUwvn01ss=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB2009.namprd11.prod.outlook.com (10.168.108.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Mon, 12 Aug 2019 15:38:34 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::c457:dc57:6e6f:f4f3]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::c457:dc57:6e6f:f4f3%10]) with mapi id 15.20.2157.022; Mon, 12 Aug
 2019 15:38:34 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <adrian.hunter@intel.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ulf.hansson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
Thread-Topic: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
Thread-Index: AQHVTcREWHJkbws9ckOkZIu1sPO5NabxMeQAgAAEQACAASQ2AIAFUKOA
Date:   Mon, 12 Aug 2019 15:38:34 +0000
Message-ID: <fa0debbb-b84c-1f74-f8b8-8fdd7812aaee@microchip.com>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
 <20190808124217.wrmcxohw5i6ju2qe@M43218.corp.atmel.com>
 <04fd74c3-a828-1064-b77b-f3de07a26190@intel.com>
 <20190809062322.syuieymdqjs4e7lh@M43218.corp.atmel.com>
In-Reply-To: <20190809062322.syuieymdqjs4e7lh@M43218.corp.atmel.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0266.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::39) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812183317755
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c052edc5-a8a9-4649-7123-08d71f3b2274
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB2009;
x-ms-traffictypediagnostic: DM5PR11MB2009:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB20099FA6D5D8E2608EAD259EE8D30@DM5PR11MB2009.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(189003)(31686004)(7736002)(5660300002)(6116002)(186003)(305945005)(229853002)(26005)(25786009)(3846002)(36756003)(71190400001)(71200400001)(66066001)(6246003)(99286004)(316002)(8676002)(6512007)(52116002)(53936002)(76176011)(2906002)(81156014)(110136005)(6486002)(102836004)(2201001)(386003)(31696002)(8936002)(86362001)(6506007)(53546011)(81166006)(6436002)(14454004)(486006)(446003)(11346002)(66446008)(476003)(2616005)(64756008)(66556008)(66476007)(66946007)(2501003)(478600001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB2009;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XcgwdcFYRRMfeS3qmmj7blzXGADX5HaWZ2LbCGCyhqbZfcs9U9q3742QZNaleCdFRs7SYLrKeqHx65hqkij0oJaeEwow9cabszLYoq1mC8PetACaEvMmsId3If9zUpde8LpZCt/rVHDCE/mwVy4R8NLXRkjG5TYIOOjiy53/fxySEIUtf6rXm6QMuBUumnbIXzRm+6Z4ayWvGjbszXH4ETW/NS+1dgfC2OpmYPIShwc3tnwDqdB9yVnvkJQViyrtP91M/pj9dS6KCe25w7j0Nvf5z/l/sE+d8GT4GAiz7GUMLMOWSvjUZ6JWy1b+v/DcteJp+Or/SL487XU6skjPGok84DZod3SilX2dijjxdv0A1Ye6UqAe7vjdJri5qtPsJanlrQqDnlLq6P4V3r4JJLcnKs3SiY1UoKNsIy/YBBM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A3BA531877C9C438F08D84BC3EDC250@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c052edc5-a8a9-4649-7123-08d71f3b2274
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 15:38:34.2910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KS5q9lG9iMvyEHChJiElEv8kRDVo1F5A8THFjqCQVnPIYm+6l+33c6Sh0320rxeG+YEF51EpPyaLB6QtgLN+g9qdKBwpzzbNb8NrHqJ7CUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LjA4LjIwMTkgMDk6MjMsIEx1ZG92aWMgRGVzcm9jaGVzIHdyb3RlOg0KPiBPbiBU
aHUsIEF1ZyAwOCwgMjAxOSBhdCAwMzo1NzozMFBNICswMzAwLCBBZHJpYW4gSHVudGVyIHdyb3Rl
Og0KPj4gT24gOC8wOC8xOSAzOjQyIFBNLCBMdWRvdmljIERlc3JvY2hlcyB3cm90ZToNCj4+PiBP
biBUaHUsIEF1ZyAwOCwgMjAxOSBhdCAxMDozNTo0M0FNICswMjAwLCBFdWdlbiBIcmlzdGV2IC0g
TTE4MjgyIHdyb3RlOg0KPj4+PiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1p
Y3JvY2hpcC5jb20+DQo+Pj4+DQo+Pj4+IEFkZCBtbWMgY2FwYWJpbGl0aWVzIGZvciBTRE1NQzAg
Zm9yIHRoaXMgYm9hcmQuDQo+Pj4+IFdpdGggdGhpcyBlbmFibGVkLCBlTU1DIGNvbm5lY3RlZCBj
YXJkIGlzIGRldGVjdGVkIGFzOg0KPj4+Pg0KPj4+PiBtbWMwOiBuZXcgRERSIE1NQyBjYXJkIGF0
IGFkZHJlc3MgMDAwMQ0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxl
dWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+Pj4gQWNrZWQtYnk6IEx1ZG92aWMgRGVzcm9j
aGVzIDxsdWRvdmljLmRlc3JvY2hlc0BtaWNyb2NoaXAuY29tPg0KPj4+DQo+Pj4gSSBhbSBpbnRl
cmVzdGVkIHRvIGhhdmUgdGhlIHNvbWUgaW5zaWdodHMgYWJvdXQgdGhlIHVzZSBvZiBzZC11aHMt
Kg0KPj4+IHByb3BlcnRpZXMuDQo+Pj4NCj4+PiBPdXIgSVAgY2FuJ3QgZGVhbCB3aXRoIDFWOCBi
eSBpdHNlbGYuIEl0IGhhcyBhIDFWOFNFTCBzaWduYWwgd2hpY2ggY2FuDQo+Pj4gYmUgdXNlZCBh
cyB0aGUgbG9naWMgY29udHJvbCBpbnB1dCBvZiBhIG11eC4gU28gZXZlbiBpZiB0aGUgSVAgY2xh
aW1zDQo+Pj4gdG8gc3VwcG9ydCBVSFMgbW9kZXMsIGl0IGRlcGVuZHMgb24gdGhlIGJvYXJkLg0K
Pj4+DQo+Pj4gQXJlIHRoZSBzZC11aHMtKiBwcm9wZXJ0aWVzIGEgd2F5IHRvIGRlYWwgd2l0aCB0
aGlzPyBJIHRlbmQgdG8gdGhpbmsgbm8NCj4+PiBhcyBzZGhjaV9zZXR1cF9ob3N0KCkgd2lsbCBz
ZXQgdGhlIGNhcHMgZGVwZW5kaW5nIG9uIHRoZSBjb250ZW50IG9mIHRoZQ0KPj4+IGNhcGFiaWxp
dGllcyByZWdpc3Rlci4gRG8gd2UgaGF2ZSB0byB1c2UgdGhlIFNESENJX1FVSVJLX01JU1NJTkdf
Q0FQUw0KPj4+IHF1aXJrIG9yIHNkaGNpLWNhcHMvc2RoY2ktY2Fwcy1tYXNrPw0KPj4NCj4+IFRo
ZXJlIGlzICJuby0xLTgtdiIgd2hpY2ggaXQgbG9va3MgbGlrZSBzZGhjaS1vZi1hdDkxLmMgYWxy
ZWFkeSBzdXBwb3J0czoNCj4+DQo+PiAgICBzZGhjaV9hdDkxX3Byb2JlKCkgLT4gc2RoY2lfZ2V0
X29mX3Byb3BlcnR5KCkgLT4gc2RoY2lfZ2V0X3Byb3BlcnR5KCkNCj4+DQo+PiAgICAgIAlpZiAo
ZGV2aWNlX3Byb3BlcnR5X3ByZXNlbnQoZGV2LCAibm8tMS04LXYiKSkNCj4+IAkJaG9zdC0+cXVp
cmtzMiB8PSBTREhDSV9RVUlSSzJfTk9fMV84X1Y7DQo+Pg0KPiANCj4gUmlnaHQsIEkgZm9yZ290
IHRoaXMgcHJvcGVydHkuIFRoYW5rcy4NCj4gDQo+IEV1Z2VuLCBkbyB5b3Ugc2VlIGNhc2VzIHdl
IGNhbid0IGNvdmVyIHdpdGggdGhpcyBwcm9wZXJ0eT8NCg0KSGksDQoNCkZvciBjdXJyZW50IHJl
cXVpcmVtZW50cyBhbmQgZHJpdmVyIHN1cHBvcnQsIHRoaXMgc2hvdWxkIGJlIGVub3VnaC4NCg0K
SSBub3RpY2VkIG9uZSB0aGluZyByZWdhcmRpbmcgU0QtQ2FyZHMsIGlmIEkgYWRkIHByb3BlcnR5
IHNkLXVocy1zZHIxMDQgDQp0aGUgY2xhc3MgMTAgdWhzMSBjYXJkcyBhcmUgZGV0ZWN0ZWQgYXMg
U0RSMTA0IC4gV2l0aG91dCB0aGlzIHByb3BlcnR5IA0KdGhleSBhcmUgZGV0ZWN0ZWQgYXMgRERS
NTAuIEFueSBpZGVhIHdoeSB0aGUgZGlmZmVyZW5jZSA/IFRoZSBjb250cm9sbGVyIA0KZG9lcyBu
b3QgY2xhaW0gdG8gaGF2ZSBTRFIxMDQgc3VwcG9ydCA/ICBXZSBzaG91bGQgYWRkIGl0ID8NCg0K
RXVnZW4NCg0KPiANCj4gUmVnYXJkcw0KPiANCj4gTHVkb3ZpYw0KPiANCj4+DQo+Pj4NCj4+PiBS
ZWdhcmRzDQo+Pj4NCj4+PiBMdWRvdmljDQo+Pj4NCj4+Pj4gLS0tDQo+Pj4+ICAgYXJjaC9hcm0v
Ym9vdC9kdHMvYXQ5MS1zYW1hNWQyN19zb20xX2VrLmR0cyB8IDEgKw0KPj4+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvYXQ5MS1zYW1hNWQyN19zb20xX2VrLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0
OTEtc2FtYTVkMjdfc29tMV9lay5kdHMNCj4+Pj4gaW5kZXggMTQ5ZTUzOS4uMTk0YjNhMyAxMDA2
NDQNCj4+Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyN19zb20xX2VrLmR0
cw0KPj4+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDI3X3NvbTFfZWsuZHRz
DQo+Pj4+IEBAIC01NCw2ICs1NCw3IEBADQo+Pj4+ICAgDQo+Pj4+ICAgCQlzZG1tYzA6IHNkaW8t
aG9zdEBhMDAwMDAwMCB7DQo+Pj4+ICAgCQkJYnVzLXdpZHRoID0gPDg+Ow0KPj4+PiArCQkJbW1j
LWRkci0zXzN2Ow0KPj4+PiAgIAkJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+Pj4+ICAg
CQkJcGluY3RybC0wID0gPCZwaW5jdHJsX3NkbW1jMF9kZWZhdWx0PjsNCj4+Pj4gICAJCQlzdGF0
dXMgPSAib2theSI7DQo+Pj4+IC0tIA0KPj4+PiAyLjcuNA0KPj4+Pg0KPj4+DQo+Pg0KPiANCg==
