Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B5C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24672083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hdl4w3Gg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YDYl/kql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbfHOUhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:37:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54330 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730988AbfHOUhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565901428; x=1597437428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O+MzaVa3dUEUP3AwnyiPb55qAsw5XchBeqI8a9bshRg=;
  b=Hdl4w3GgHgxzrgvCXm5Rbh+SbKwAM1LwTU3czoNV/tJRKIhnkP5Ayxgc
   BewM4noFy9kgbSLKz3dlBhTCHaFpwjY3DT+1nXeyCEggrKXdIAPCHKRRk
   B1i4wKM+SiM3pWuGSwn/n8QFqD1oJwY+zNcMXnq3SPZuu+drIu8a8uPgL
   h0wlEcSjtkKaMHDCA4C1MYHImew5IaAVs/gQDpDM6rUMxfX2aEV7nLgaS
   sWMx/hlMsxyuwb1c10TlbYidFyr0SMecVs3Yqtk84BsCxQXuwVWfCpwCo
   JKVHI9I9xNmxpY8rCnKVQpWXBruv5xVW/v98jRkDqJnXnv1ZaJ8i7Q6Bc
   g==;
IronPort-SDR: gkxHrAO5dYNII5CtAkwSGc2X9ax57zqSuJvXzJ0A+8u0ST/AH9jsoJtW7hwYP2A68Ou/B75Ggd
 muTfxremkifNk712UjhMhaIcNuMIF5v1XQlar4VWpCVwm+O2pY8E92sQVrduI1mKwAvNHCIlvN
 UKVit8L+A7T1rAD/0gJy9xFykv8w757vOVyybvkKdIsDX4CYuWhD6CNi5S9iGFawdCK+thMiGY
 OXyPl1pfP2RJa3sNM6mhzdrEl3X13erM9J/VncYE8DKMyGjk6GHYr4UEeI9niJtKAF8lFoakHC
 xIE=
X-IronPort-AV: E=Sophos;i="5.64,389,1559491200"; 
   d="scan'208";a="120536498"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 04:37:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjh0iNvGkDjTFbFecyvOij8rd6YgQgxXJMnDOfHvCpOg7rP1iFL4NCnPIQq+CgBzirm4UmkbystWefxm9eB7VPgQVoUfclkXHuhi/IWFAS9jRH7ZrIIDuUPvrOlgMCaZnHXDEu/XOyO9BfPTacsjC6TiEqswNrKdu+4Iat3rUEQgX9YbPO8rT2zzxWeOG+I4YxxiGwx0yyHqPsvK2okMKONHPbrS9AkLpiB4pIQcTmTss0nNt8w6Ny/SdVJHW5ADNm9iX8/s0w+usYCl/z8E59lrSlgpkq3hrnuQQvUvxEuU3bW6VQm5fyS3IHVqSL34pDi/JJa1at7FYHEPaNOYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+MzaVa3dUEUP3AwnyiPb55qAsw5XchBeqI8a9bshRg=;
 b=XuB5beYfsNjzG4XQpCq2Chiy2OFaMZCzppNhM8fTZhfZ6qHgiPaVY7zjWvBMWzXBbU+HTiA9Ajvi62kcghiTVCdodyPDuL0wCz91hXYjfQo8pXxFnV1MnzymB4Iln/BxRGF06lSy9Mqi25N0ccbxijrX26mBElrDRnfy5+RaFxlKU8OAB6oiPno4QMciSp5DSjUbhnONlU/eINzulV8hhTywt6F2U1Yb2Shw0gUJJcFt0sR2oPfLI10XaobwVTz4tBs7cWUOay8CtKdnHoxhdRVUfjtkBhD02ALG72rbdbh4KbVZzurvImuuT425Q35AH0hFbaAZY54IRkeI0DkVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+MzaVa3dUEUP3AwnyiPb55qAsw5XchBeqI8a9bshRg=;
 b=YDYl/kqljC1PQGdCfN2FPJdPaAxj0mUe2CSminWXlKCvOKr72HhN8xKCMjuIHdKSK/VYuGrwAilSnL6Jx6I/w4jeGSXaME+w5NlFP+2LUYGWi+BZrhYZ8NH2NXuUe7uHO0EqIQot7Du0zH3akFea2/lN129w0/AOB2hvlp/kUHY=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5478.namprd04.prod.outlook.com (20.178.197.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Thu, 15 Aug 2019 20:37:05 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::d89b:cb55:d563:79e9]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::d89b:cb55:d563:79e9%6]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 20:37:04 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Topic: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Index: AQHVTxz5XkoGRRVrekixM0/zCIcSeKb3ngaAgACcGwCAAO7ygIADixaA
Date:   Thu, 15 Aug 2019 20:37:04 +0000
Message-ID: <3f55d5878044129a3cbb72b13b712e9a1c218dc7.camel@wdc.com>
References: <20190810014309.20838-1-atish.patra@wdc.com>
         <20190812145631.GC26897@infradead.org>
         <f58814e156b918531f058acfac944abef34f5fb1.camel@wdc.com>
         <20190813143027.GA31668@infradead.org>
In-Reply-To: <20190813143027.GA31668@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4336747-6038-4a49-ea27-08d721c0557d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5478;
x-ms-traffictypediagnostic: BYAPR04MB5478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB54788A8CD828EBA435C0695DFAAC0@BYAPR04MB5478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(189003)(199004)(7736002)(6512007)(71200400001)(476003)(66556008)(66946007)(305945005)(2906002)(316002)(186003)(86362001)(66446008)(76116006)(99286004)(229853002)(446003)(11346002)(53936002)(66476007)(2616005)(71190400001)(5640700003)(2351001)(118296001)(64756008)(6486002)(6436002)(81166006)(66066001)(6506007)(81156014)(14454004)(36756003)(486006)(5660300002)(256004)(478600001)(1730700003)(4326008)(26005)(6246003)(3846002)(8936002)(2501003)(6116002)(54906003)(25786009)(102836004)(6916009)(76176011)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5478;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SAYV6uu07GIc23VnkwZR8otX4ntpFrYKhIoxG7aKGOe0ZWjs/SgoVpJTbeKAHyr3jv6XpxcZpB0JZ9ubVDiPCK3sdorxor2vaUw+x1UhaIzpO03KyV9Upz4QWpA2ge3eE72Z6f0TddmsP0lMMqXCChtbF6KP88RA6yhYCe4O0RKhdOOIc99fYz0zqPwf6Pn/Tst6CstP8md8gTP6vyoxX2xhy0Ck5GzbfhA+e90Sd0myIxwf8SedF+7q2d9Er9I5d/0XqvO5hz2lmBxs3PKDzSTgfZeULTFqMMWUGIUOqe5kkfqnOVs0Oiz5FKhpFn/VvWc/CEigoxYLB3CdE2AWLRwgot+Lg7UsZRTPCBi8b+Ef9kCJ3jles2KrrZnrMl7yprwxFSDl0SVANDfSHKxyEh7AeuH+WTI7srlp3aFBilA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E58DB51E878DB49B49FA5E3D5869C2E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4336747-6038-4a49-ea27-08d721c0557d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 20:37:04.5688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cP9q6IQJA/kKaWi/JbCpjgxVlYJgJkKwW11o/HJeqXfAZ75Fh5hei5It9hg8GD1NFyVWszr+5eOohDwmNbpVqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTEzIGF0IDA3OjMwIC0wNzAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gVHVlLCBBdWcgMTMsIDIwMTkgYXQgMTI6MTU6MTVBTSArMDAwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gSSB0aG91Z2h0IGlmIGl0IHJlY2lldmVzIGFuIGVtcHR5IGNwdW1hc2ss
IHRoZW4gaXQgc2hvdWxkIGF0IGxlYXN0DQo+ID4gZG8gYQ0KPiA+IGxvY2FsIGZsdXNoIGlzIHRo
ZSBleHBlY3RlZCBiZWhhdmlvci4gQXJlIHlvdSBzYXlpbmcgdGhhdCB3ZSBzaG91bGQNCj4gPiBq
dXN0IHNraXAgYWxsIGFuZCByZXR1cm4gPyANCj4gDQo+IEhvdyBjb3VsZCB3ZSBldmVyIHJlY2Vp
dmUgYW4gZW1wdHkgY3B1IG1hc2s/ICBJIHRoaW5rIGl0IGNvdWxkIG9ubHkNCj4gYmUgZW1wdHkg
d2l0aG91dCB0aGUgY3VycmVudCBjcHUuICBBdCBsZWFzdCB0aGF0IGlzIG15IHJlYWRpbmcgb2YN
Cj4gdGhlIGNhbGxlcnMgYW5kIGEgZmV3IG90aGVyIGltcGxlbWVudGF0aW9ucy4NCj4gDQoNCldl
IGdldCB0b24gb2YgdGhlbS4gSGVyZSBpcyB0aGUgc3RhY2sgZHVtcC4NCg0KWyAgIDE2LjczNTgx
NF0gWzxmZmZmZmZlMDAwMDM1NDk4Pl0gd2Fsa19zdGFja2ZyYW1lKzB4MC8weGEwXk0NCjI5ODQz
NiBbICAgMTYuODE5MDM3XSBbPGZmZmZmZmUwMDAwMzU1Zjg+XSBzaG93X3N0YWNrKzB4MmEvMHgz
NF5NDQoyOTg0MzcgWyAgIDE2Ljg5OTY0OF0gWzxmZmZmZmZlMDAwNjdiNTRjPl0gZHVtcF9zdGFj
aysweDYyLzB4N2NeTQ0KMjk4NDM4IFsgICAxNi45Nzc0MDJdIFs8ZmZmZmZmZTAwMDBlZjZmNj5d
IHRsYl9mbHVzaF9tbXUrMHgxNGEvMHgxNTBeTQ0KMjk4NDM5IFsgICAxNy4wNTQxOTddIFs8ZmZm
ZmZmZTAwMDBlZjdhND5dIHRsYl9maW5pc2hfbW11KzB4NDIvMHg3Ml5NDQoyOTg0NDAgWyAgIDE3
LjEyOTk4Nl0gWzxmZmZmZmZlMDAwMGVkZTdjPl0gZXhpdF9tbWFwKzB4OGUvMHhmYV5NDQoyOTg0
NDEgWyAgIDE3LjIwMzY2OV0gWzxmZmZmZmZlMDAwMDM3ZDU0Pl0gbW1wdXQucGFydC4zKzB4MWEv
MHhjNF5NDQoyOTg0NDIgWyAgIDE3LjI3NTk4NV0gWzxmZmZmZmZlMDAwMDM3ZTFlPl0gbW1wdXQr
MHgyMC8weDI4Xk0NCjI5ODQ0MyBbICAgMTcuMzQ1MjQ4XSBbPGZmZmZmZmUwMDAxMTQzYzI+XSBm
bHVzaF9vbGRfZXhlYysweDQxOC8weDVmOF5NDQoyOTg0NDQgWyAgIDE3LjQxNTM3MF0gWzxmZmZm
ZmZlMDAwMTU4NDA4Pl0NCmxvYWRfZWxmX2JpbmFyeSsweDI2Mi8weGM4NF5NDQoyOTg0NDUgWyAg
IDE3LjQ4MzY0MV0gWzxmZmZmZmZlMDAwMTE0NjE0Pl0NCnNlYXJjaF9iaW5hcnlfaGFuZGxlci5w
YXJ0LjcrMHg3Mi8weDE3Ml5NDQoyOTg0NDYgWyAgIDE3LjU1MjA3OF0gWzxmZmZmZmZlMDAwMTE0
YmIyPl0NCl9fZG9fZXhlY3ZlX2ZpbGUrMHg0MGMvMHg1NmFeTQ0KMjk4NDQ3IFsgICAxNy42MTc5
MzJdIFs8ZmZmZmZmZTAwMDExNTAzZT5dIHN5c19leGVjdmUrMHgyNi8weDMyXk0NCjI5ODQ0OCBb
ICAgMTcuNjgyMTY0XSBbPGZmZmZmZmUwMDAwMzQzN2U+XSByZXRfZnJvbV9zeXNjYWxsKzB4MC8w
eGVeTQ0KDQpJdCBsb29rcyBsaWtlIGl0IGlzIGluIHRoZSBwYXRoIG9mIGNsZWFyaW5nIHRoZSBv
bGQgdHJhY2VzIG9mIGFscmVhZHkNCnJ1biBzY3JpcHQgb3IgcHJvZ3JhbS4gIEkgYW0gbm90IHN1
cmUgaWYgdGhlIGNwdW1hc2sgc3VwcG9zZWQgdG8gYmUNCmVtcHR5IGluIHRoaXMgcGF0aC4NCg0K
UHJvYmFibHkgd2Ugc2hvdWxkIGp1c3QgaXNzdWUgdGxiIGZsdXNoIGFsbCBmb3IgYWxsIENQVXMg
aW5zdGVhZCBvZg0KanVzdCB0aGUgbG9jYWwgQ1BVLg0KDQo+ID4gPiAJaWYgKCFjcHVtYXNrIHx8
IGNwdW1hc2tfdGVzdF9jcHUoY3B1LCBjcHVtYXNrKSB7DQo+ID4gPiAJCWlmICgoc3RhcnQgPT0g
MCAmJiBzaXplID09IC0xKSB8fCBzaXplID4gUEFHRV9TSVpFKQ0KPiA+ID4gCQkJbG9jYWxfZmx1
c2hfdGxiX2FsbCgpOw0KPiA+ID4gCQllbHNlIGlmIChzaXplID09IFBBR0VfU0laRSkNCj4gPiA+
IAkJCWxvY2FsX2ZsdXNoX3RsYl9wYWdlKHN0YXJ0KTsNCj4gPiA+IAkJY3B1bWFza19jbGVhcl9j
cHUoY3B1aWQsIGNwdW1hc2spOw0KPiA+IA0KPiA+IFRoaXMgd2lsbCBtb2RpZnkgdGhlIG9yaWdp
bmFsIGNwdW1hc2sgd2hpY2ggaXMgbm90IGNvcnJlY3QuIGNsZWFyDQo+ID4gcGFydA0KPiA+IGhh
cyB0byBiZSBkb25lIG9uIGhtYXNrIHRvIGF2b2lkIGEgY29weS4NCj4gDQo+IEluZGVlZC4gIEJ1
dCBsb29raW5nIGF0IHRoZSB4ODYgdGxiZmx1c2ggaW1wbGVtZW50YXRpb24gaXQgc2VlbXMgbGlr
ZQ0KPiB3ZQ0KPiBjb3VsZCB1c2UgY3B1bWFza19hbnlfYnV0KCkgdG8gYXZvaWQgaGF2aW5nIHRv
IG1vZGlmeSB0aGUgcGFzc2VkIGluDQo+IGNwdW1hc2suDQoNCkxvb2tpbmcgYXQgdGhlIHg4NiBj
b2RlLCBpdCB1c2VzIGNwdW1hc2tfYW55X2J1dCB0byBqdXN0IHRlc3QgaWYgdGhlcmUNCmFueSBv
dGhlciBjcHUgcHJlc2VudCBhcGFydCBmcm9tIHRoZSBjdXJyZW50IG9uZS4NCg0KSWYgeWVzLCBp
dCBjYWxscyBzbXBfY2FsbF9mdW5jdGlvbl9tYW55IHdoaWNoIGlnbm9yZXMgdGhlIGN1cnJlbnQg
Y3B1DQphbmQgZXhlY3V0ZSB0bGIgZmx1c2ggY29kZSBvbiBhbGwgb3RoZXIgY3B1cy4NCg0KRm9y
IFJJU0MtViwgaXQgaGFzIHRvIHN0aWxsIHNlbmQgdGhlIGNwdW1hc2sgY29udGFpbmluZyBsb2Nh
bCBjcHUgYW5kDQpNLW1vZGUgc29mdHdhcmUgbWF5IGRvIGEgbG9jYWwgdGxiIGZsdXNoIHRoZSB0
bGJzIGFnYWluIGZvciBubyByZWFzb24uDQoNCg0KUmVnYXJkcywNCkF0aXNoDQo=
