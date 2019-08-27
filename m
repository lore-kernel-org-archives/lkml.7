Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222A6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41CA2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fuowoI4t";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Dy9B5CDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfH0Uen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:34:43 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24800 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfH0Uen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566938083; x=1598474083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=axSkrLbitHNo85MyKLQWeJvuI+K12TsWzJgXu4Otg3E=;
  b=fuowoI4tNY5O4CNmsaEtGjtSmOmCsN/8Km1+cBBhxHaJG9B9MHNYeud8
   1C8ZX30oh+m4BDjiBFaJqPIlEMKJqwniOJtAa4sXEu9Y1a4g2LhIS2qm9
   uRuSP3jagjgGcx7/N3bDwa0exO07lSrGeoA4nzqIGpOB3mRI87jKJDO/E
   cLBLp59B840VL76amdVm0Q73nhPMVWhl0y2jMw4W78l2Sh8LRbneM+/xt
   YPtUHmCuu6ZR79EKNMmy/FiL19G0imubXJyDVJIA+KdbfwhutYXp5Zogu
   DP5hfKVGu796/JwzyIQx6H2DtMyWDv82d582WdwrPPFVT7qZz5Y4mAXlX
   g==;
IronPort-SDR: vpKhE5huQkGO7zrjzCYcQMJ43fDYALg69vQ/fPfNWgvGIawy/2hR6bnZLMgBBN0GMj7gdqc3m7
 JwX7q2kRax3qHFVm2quybAveX5UbmOGpvINOgLGMkIrTMN23++m0o84P7h1ZsjwP6meLKQUwAg
 fvUqVvEa79toNJidhHEosXhw7Cwg1ScXspDh24r37kxQNQno2SdgTSG06DhPs+fhYZF16Zd9FB
 zbOu+8JaCoKgZ2N0USSWyCBobr8VpPPHrcYvsAO8iIMLMXmkUqKfeYMp6HX7IJK7quJTTLczDO
 Iro=
X-IronPort-AV: E=Sophos;i="5.64,438,1559491200"; 
   d="scan'208";a="118394645"
Received: from mail-dm3nam05lp2050.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.50])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2019 04:34:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC4pNOs+8jm9DStZSVr7S2e6UNedUcx7dqCxFyFJkLBoVBvcNd9pjksUkpm594+qV5tM9Sgn7jmxR+j85IQrMzHt9uw+/VxKzMs6YR3fCtwEvgPaBLFjcgGZW6UO3/5t3LmPJDxZ7mVuOlkehwCO2ZJY1HRt6PUnlKiL+nPk6gSdVoL4ShSZQxuhK22/5c679wdYmi8b8eB3f1oiJ9HdemEVOInYHgNXyx0Illok6fN7cm8omUJ43VHnpXdESPvIXKtR3NrOi7ORsf0jjb20+qkDa2ahjQeDrBX9PSpK2MEg6Oz2lV3wF69op2bEiVT4fZq676+acHL/wwG9X5XBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axSkrLbitHNo85MyKLQWeJvuI+K12TsWzJgXu4Otg3E=;
 b=axRw9QrinEd4oAvuuz0bRgh5A20MoY5CHBpzJEGRLk1vhpF8okNZeXFPXjYC1NBHrPsnWDRozs1L5jSD54jGv1PI3JReXTE0yjG6Z2TzjOjbJuFxHpivvp0vx+Iihas8mjazPShx7lIcym6ri85jxL2f5oqwmipqjmXYA3NltbJsp4og+u1RTpNyTmUFT4bcerozSVgRAAHZp0e7Vp12Ae9LhcxfhzvxM2MY8b5f36h9IcCK0vlwTeN+Zt35QW7143hC5t/O700vcJZUwYhBwNg2AA+bR/KbnKRzDIwQd4Jrn20eAplYo58sJWEqTH8bIpGDhVk19TIF1tPo2cpg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axSkrLbitHNo85MyKLQWeJvuI+K12TsWzJgXu4Otg3E=;
 b=Dy9B5CDfPpI0N81TYqDYbWTZppw3BlSvqzYwIhLpwyFSeaAx50S9GuFyQocZJiIK/BEa4zk012z4gjo4S4O/eQYLcwtbXSSQz/MrEdNTuxg2F6mfOQFT0Pc9SN/NwWiW4VofA0LVxmAymDrAHLZgb3U0FHUZmO8Zy40eZdLrI+g=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5079.namprd04.prod.outlook.com (52.135.235.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 27 Aug 2019 20:34:39 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.020; Tue, 27 Aug 2019
 20:34:39 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "rppt@linux.ibm.com" <rppt@linux.ibm.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [RFC PATCH 1/2] RISC-V: Mark existing SBI as legacy SBI.
Thread-Topic: [RFC PATCH 1/2] RISC-V: Mark existing SBI as legacy SBI.
Thread-Index: AQHVXGawW0XtdcDDakm9TmNp3/W3LacOn7MAgADVMAA=
Date:   Tue, 27 Aug 2019 20:34:39 +0000
Message-ID: <79b62541ce3d2b65e2572c52db7fd24d5ff4b898.camel@wdc.com>
References: <20190826233256.32383-1-atish.patra@wdc.com>
         <20190826233256.32383-2-atish.patra@wdc.com>
         <20190827075136.GC682@rapoport-lnx>
In-Reply-To: <20190827075136.GC682@rapoport-lnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0508fabe-5763-4fe1-fa05-08d72b2dfbfc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5079;
x-ms-traffictypediagnostic: BYAPR04MB5079:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB5079B67CFBE44252EBFAF0CAFAA00@BYAPR04MB5079.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(6486002)(966005)(7416002)(86362001)(64756008)(66446008)(2906002)(54906003)(256004)(99286004)(5660300002)(2501003)(4326008)(8936002)(71190400001)(71200400001)(8676002)(81156014)(81166006)(1730700003)(316002)(76176011)(66556008)(66066001)(118296001)(66476007)(229853002)(5640700003)(66946007)(11346002)(3846002)(6116002)(6436002)(446003)(53936002)(2616005)(186003)(476003)(26005)(36756003)(6246003)(486006)(102836004)(7736002)(6306002)(305945005)(478600001)(6512007)(2351001)(6506007)(76116006)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5079;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Yx/uGN2hbNKAHt8ckpHc90ISRREmiE7UJGhNZWK4pBmUoJp6Xzk9U+J5JqqMStUJrbWHfUjohusSegrBRxbHhKCjs7A73V3qwnyhXuS70lT+dKa7sMShBmI6EfkmiPN/AhvXWUTF22R7uARsBDJCmyYd2EO0aS9efEQe05R7j+/KAS/O/woQvQT97I7C7gfV49g9hv2FD/jdW8MEXPBLr7exuU5iVVkU5Zz1op4YF5kcHjlIayxIwBefhJVR6+05S+b5e5EoQWHTcj/UyIviJlzNVLs73WK0sAXTjs3lQBrn6k4lPvFAv7NaghU8FMJdpXglX6KlwSRqLCRdBhNsDOvbNUzNfojOmYPV44tF96PqveNH0mSN6Ub5ozu1vv4UjSEGnw8TAB0+3Y9E2eF5FSJcYO3TK3/xDJqX6u4FDI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAF300CEC5184B458C12DC0EE5BDB322@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0508fabe-5763-4fe1-fa05-08d72b2dfbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 20:34:39.6078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xyGdt+qgFjNSrVJJp0KygMLBPPIzyq1jsalX9UcgzUYesfWsh7vYJwaHRn8Bra3gQk1Y/JIiBb1rBRWbJpZUlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDEwOjUxICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBNb24sIEF1ZyAyNiwgMjAxOSBhdCAwNDozMjo1NVBNIC0wNzAwLCBBdGlzaCBQYXRyYSB3
cm90ZToNCj4gPiBBcyBwZXIgdGhlIG5ldyBTQkkgc3BlY2lmaWNhdGlvbiwgY3VycmVudCBTQkkg
aW1wbGVtZW50YXRpb24gaXMNCj4gPiBkZWZpbmVkIGFzIGxlZ2FjeSBhbmQgd2lsbCBiZSByZW1v
dmVkL3JlcGxhY2VkIGluIGZ1dHVyZS4NCj4gPiANCj4gPiBSZW5hbWUgZXhpc3RpbmcgaW1wbGVt
ZW50YXRpb24gdG8gcmVmbGVjdCB0aGF0LiBUaGlzIHBhdGNoIGlzIGp1c3QNCj4gPiBhIHByZXBh
cmF0b3J5IHBhdGNoIGZvciBTQkkgdjAuMiBhbmQgZG9lc24ndCBpbnRyb2R1Y2UgYW55DQo+ID4g
ZnVuY3Rpb25hbA0KPiA+IGNoYW5nZXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQXRpc2gg
UGF0cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvcmlzY3YvaW5j
bHVkZS9hc20vc2JpLmggfCA2MSArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+
IC0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3NiaS5o
DQo+ID4gYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3NiaS5oDQo+ID4gaW5kZXggMjExMzRiM2Vm
NDA0Li43ZjVlY2FhYWEwZDcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9zYmkuaA0KPiA+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2JpLmgNCj4gPiBAQCAt
OCwxNyArOCwxOCBAQA0KPiA+ICANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4g
IA0KPiA+IC0jZGVmaW5lIFNCSV9TRVRfVElNRVIgMA0KPiA+IC0jZGVmaW5lIFNCSV9DT05TT0xF
X1BVVENIQVIgMQ0KPiA+IC0jZGVmaW5lIFNCSV9DT05TT0xFX0dFVENIQVIgMg0KPiA+IC0jZGVm
aW5lIFNCSV9DTEVBUl9JUEkgMw0KPiA+IC0jZGVmaW5lIFNCSV9TRU5EX0lQSSA0DQo+ID4gLSNk
ZWZpbmUgU0JJX1JFTU9URV9GRU5DRV9JIDUNCj4gPiAtI2RlZmluZSBTQklfUkVNT1RFX1NGRU5D
RV9WTUEgNg0KPiA+IC0jZGVmaW5lIFNCSV9SRU1PVEVfU0ZFTkNFX1ZNQV9BU0lEIDcNCj4gPiAt
I2RlZmluZSBTQklfU0hVVERPV04gOA0KPiA+IC0NCj4gPiAtI2RlZmluZSBTQklfQ0FMTCh3aGlj
aCwgYXJnMCwgYXJnMSwgYXJnMiwgYXJnMykgKHsJCVwNCj4gPiArDQo+ID4gKyNkZWZpbmUgU0JJ
X0VYVF9MRUdBQ1lfU0VUX1RJTUVSIDB4MA0KPiA+ICsjZGVmaW5lIFNCSV9FWFRfTEVHQUNZX0NP
TlNPTEVfUFVUQ0hBUiAweDENCj4gPiArI2RlZmluZSBTQklfRVhUX0xFR0FDWV9DT05TT0xFX0dF
VENIQVIgMHgyDQo+ID4gKyNkZWZpbmUgU0JJX0VYVF9MRUdBQ1lfQ0xFQVJfSVBJIDB4Mw0KPiA+
ICsjZGVmaW5lIFNCSV9FWFRfTEVHQUNZX1NFTkRfSVBJIDB4NA0KPiA+ICsjZGVmaW5lIFNCSV9F
WFRfTEVHQUNZX1JFTU9URV9GRU5DRV9JIDB4NQ0KPiA+ICsjZGVmaW5lIFNCSV9FWFRfTEVHQUNZ
X1JFTU9URV9TRkVOQ0VfVk1BIDB4Ng0KPiA+ICsjZGVmaW5lIFNCSV9FWFRfTEVHQUNZX1JFTU9U
RV9TRkVOQ0VfVk1BX0FTSUQgMHg3DQo+ID4gKyNkZWZpbmUgU0JJX0VYVF9MRUdBQ1lfU0hVVERP
V04gMHg4DQo+IA0KPiBJIGNhbid0IHNheSBJJ20gY2xvc2VseSBmb2xsb3dpbmcgUklTQy1WIGRl
dmVsb3BtZW50LCBidXQgd2hhdCB3aWxsDQo+IGhhcHBlbg0KPiB3aGVuIFNCSSB2MC4zIHdpbGwg
Y29tZSBvdXQgYW5kIHdpbGwgcmVuZGVyIHYwLjIgbGVnYWN5Pw0KPiBXb24ndCB3ZSBuZWVkIGFu
b3RoZXIgc2ltaWxhciByZW5hbWluZyB0aGVuPw0KPiANCg0KTm9vcGUuVGhlIGlkZWEgb2YgcmVu
YW1pbmcgMC4xIGNhbGxzIGFzIGxlZ2FjeSBjb21lcyBmcm9tIHRoZSBmYWN0IHRoYXQNCnRoZXNl
IGNhbGxzIHdpbGwgYmUgZXZlbnR1YWxseSBiZSByZXBsYWNlZCBvciBkZXBjcmVhdGVkIGFmdGVy
IGENCmNlcnRhaW4gdGltZS4NCg0KdjAuMiBkZWZpbmVzIGJhc2Ugc3BlY2lmaWNhdGlvbiB3aGlj
aCB3aWxsIGJlIG1hbmRhdG9yeSBmb3IgYW55IG5ld2VyDQppbXBsZW1lbnRhdGlvbi4gQW55IHZl
cnNpb25zIG5ld2VyIHRoYW4gMC4yIHdpbGwgb25seSBhZGQgbmV3DQpleHRlbnNpb25zIGJ1dCBu
b3QgbmVjZXNzYXJpbHkgcmVwbGFjZSB0aGUgb25lcyBpbiAwLjINCg0KPiA+ICsjZGVmaW5lIFNC
SV9DQUxMX0xFR0FDWSh3aGljaCwgYXJnMCwgYXJnMSwgYXJnMiwgYXJnMykNCj4gPiAoeyAgICAg
ICAgICAgICBcDQo+ID4gIAlyZWdpc3RlciB1aW50cHRyX3QgYTAgYXNtICgiYTAiKSA9ICh1aW50
cHRyX3QpKGFyZzApOwlcDQo+ID4gIAlyZWdpc3RlciB1aW50cHRyX3QgYTEgYXNtICgiYTEiKSA9
ICh1aW50cHRyX3QpKGFyZzEpOwlcDQo+ID4gIAlyZWdpc3RlciB1aW50cHRyX3QgYTIgYXNtICgi
YTIiKSA9ICh1aW50cHRyX3QpKGFyZzIpOwlcDQo+ID4gQEAgLTMyLDU4ICszMyw2MSBAQA0KPiA+
ICB9KQ0KPiA+ICANCj4gPiAgLyogTGF6eSBpbXBsZW1lbnRhdGlvbnMgdW50aWwgU0JJIGlzIGZp
bmFsaXplZCAqLw0KPiA+IC0jZGVmaW5lIFNCSV9DQUxMXzAod2hpY2gpIFNCSV9DQUxMKHdoaWNo
LCAwLCAwLCAwLCAwKQ0KPiA+IC0jZGVmaW5lIFNCSV9DQUxMXzEod2hpY2gsIGFyZzApIFNCSV9D
QUxMKHdoaWNoLCBhcmcwLCAwLCAwLCAwKQ0KPiA+IC0jZGVmaW5lIFNCSV9DQUxMXzIod2hpY2gs
IGFyZzAsIGFyZzEpIFNCSV9DQUxMKHdoaWNoLCBhcmcwLCBhcmcxLA0KPiA+IDAsIDApDQo+ID4g
LSNkZWZpbmUgU0JJX0NBTExfMyh3aGljaCwgYXJnMCwgYXJnMSwgYXJnMikgXA0KPiA+IC0JCVNC
SV9DQUxMKHdoaWNoLCBhcmcwLCBhcmcxLCBhcmcyLCAwKQ0KPiA+IC0jZGVmaW5lIFNCSV9DQUxM
XzQod2hpY2gsIGFyZzAsIGFyZzEsIGFyZzIsIGFyZzMpIFwNCj4gPiAtCQlTQklfQ0FMTCh3aGlj
aCwgYXJnMCwgYXJnMSwgYXJnMiwgYXJnMykNCj4gPiArI2RlZmluZSBTQklfQ0FMTF9MRUdBQ1lf
MCh3aGljaCkgU0JJX0NBTExfTEVHQUNZKHdoaWNoLCAwLCAwLCAwLA0KPiA+IDApDQo+ID4gKyNk
ZWZpbmUgU0JJX0NBTExfTEVHQUNZXzEod2hpY2gsIGFyZzApIFNCSV9DQUxMX0xFR0FDWSh3aGlj
aCwNCj4gPiBhcmcwLCAwLCAwLCAwKQ0KPiA+ICsjZGVmaW5lIFNCSV9DQUxMX0xFR0FDWV8yKHdo
aWNoLCBhcmcwLCBhcmcxKSBcDQo+ID4gKwkJU0JJX0NBTExfTEVHQUNZKHdoaWNoLCBhcmcwLCBh
cmcxLCAwLCAwKQ0KPiA+ICsjZGVmaW5lIFNCSV9DQUxMX0xFR0FDWV8zKHdoaWNoLCBhcmcwLCBh
cmcxLCBhcmcyKSBcDQo+ID4gKwkJU0JJX0NBTExfTEVHQUNZKHdoaWNoLCBhcmcwLCBhcmcxLCBh
cmcyLCAwKQ0KPiA+ICsjZGVmaW5lIFNCSV9DQUxMX0xFR0FDWV80KHdoaWNoLCBhcmcwLCBhcmcx
LCBhcmcyLCBhcmczKSBcDQo+ID4gKwkJU0JJX0NBTExfTEVHQUNZKHdoaWNoLCBhcmcwLCBhcmcx
LCBhcmcyLCBhcmczKQ0KPiA+ICANCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIHNiaV9jb25zb2xl
X3B1dGNoYXIoaW50IGNoKQ0KPiA+ICB7DQo+ID4gLQlTQklfQ0FMTF8xKFNCSV9DT05TT0xFX1BV
VENIQVIsIGNoKTsNCj4gPiArCVNCSV9DQUxMX0xFR0FDWV8xKFNCSV9FWFRfTEVHQUNZX0NPTlNP
TEVfUFVUQ0hBUiwgY2gpOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0aWMgaW5saW5lIGludCBz
YmlfY29uc29sZV9nZXRjaGFyKHZvaWQpDQo+ID4gIHsNCj4gPiAtCXJldHVybiBTQklfQ0FMTF8w
KFNCSV9DT05TT0xFX0dFVENIQVIpOw0KPiA+ICsJcmV0dXJuIFNCSV9DQUxMX0xFR0FDWV8wKFNC
SV9FWFRfTEVHQUNZX0NPTlNPTEVfR0VUQ0hBUik7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRp
YyBpbmxpbmUgdm9pZCBzYmlfc2V0X3RpbWVyKHVpbnQ2NF90IHN0aW1lX3ZhbHVlKQ0KPiA+ICB7
DQo+ID4gICNpZiBfX3Jpc2N2X3hsZW4gPT0gMzINCj4gPiAtCVNCSV9DQUxMXzIoU0JJX1NFVF9U
SU1FUiwgc3RpbWVfdmFsdWUsIHN0aW1lX3ZhbHVlID4+IDMyKTsNCj4gPiArCVNCSV9DQUxMX0xF
R0FDWV8yKFNCSV9FWFRfTEVHQUNZX1NFVF9USU1FUiwgc3RpbWVfdmFsdWUsDQo+ID4gKwkJCSAg
c3RpbWVfdmFsdWUgPj4gMzIpOw0KPiA+ICAjZWxzZQ0KPiA+IC0JU0JJX0NBTExfMShTQklfU0VU
X1RJTUVSLCBzdGltZV92YWx1ZSk7DQo+ID4gKwlTQklfQ0FMTF9MRUdBQ1lfMShTQklfRVhUX0xF
R0FDWV9TRVRfVElNRVIsIHN0aW1lX3ZhbHVlKTsNCj4gPiAgI2VuZGlmDQo+ID4gIH0NCj4gPiAg
DQo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBzYmlfc2h1dGRvd24odm9pZCkNCj4gPiAgew0KPiA+
IC0JU0JJX0NBTExfMChTQklfU0hVVERPV04pOw0KPiA+ICsJU0JJX0NBTExfTEVHQUNZXzAoU0JJ
X0VYVF9MRUdBQ1lfU0hVVERPV04pOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0aWMgaW5saW5l
IHZvaWQgc2JpX2NsZWFyX2lwaSh2b2lkKQ0KPiA+ICB7DQo+ID4gLQlTQklfQ0FMTF8wKFNCSV9D
TEVBUl9JUEkpOw0KPiA+ICsJU0JJX0NBTExfTEVHQUNZXzAoU0JJX0VYVF9MRUdBQ1lfQ0xFQVJf
SVBJKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIHNiaV9zZW5kX2lw
aShjb25zdCB1bnNpZ25lZCBsb25nICpoYXJ0X21hc2spDQo+ID4gIHsNCj4gPiAtCVNCSV9DQUxM
XzEoU0JJX1NFTkRfSVBJLCBoYXJ0X21hc2spOw0KPiA+ICsJU0JJX0NBTExfTEVHQUNZXzEoU0JJ
X0VYVF9MRUdBQ1lfU0VORF9JUEksIGhhcnRfbWFzayk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0
YXRpYyBpbmxpbmUgdm9pZCBzYmlfcmVtb3RlX2ZlbmNlX2koY29uc3QgdW5zaWduZWQgbG9uZw0K
PiA+ICpoYXJ0X21hc2spDQo+ID4gIHsNCj4gPiAtCVNCSV9DQUxMXzEoU0JJX1JFTU9URV9GRU5D
RV9JLCBoYXJ0X21hc2spOw0KPiA+ICsJU0JJX0NBTExfTEVHQUNZXzEoU0JJX0VYVF9MRUdBQ1lf
UkVNT1RFX0ZFTkNFX0ksIGhhcnRfbWFzayk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBp
bmxpbmUgdm9pZCBzYmlfcmVtb3RlX3NmZW5jZV92bWEoY29uc3QgdW5zaWduZWQgbG9uZw0KPiA+
ICpoYXJ0X21hc2ssDQo+ID4gIAkJCQkJIHVuc2lnbmVkIGxvbmcgc3RhcnQsDQo+ID4gIAkJCQkJ
IHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gPiAgew0KPiA+IC0JU0JJX0NBTExfMyhTQklfUkVNT1RF
X1NGRU5DRV9WTUEsIGhhcnRfbWFzaywgc3RhcnQsIHNpemUpOw0KPiA+ICsJU0JJX0NBTExfTEVH
QUNZXzMoU0JJX0VYVF9MRUdBQ1lfUkVNT1RFX1NGRU5DRV9WTUEsIGhhcnRfbWFzaywNCj4gPiAr
CQkJICBzdGFydCwgc2l6ZSk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBpbmxpbmUgdm9p
ZCBzYmlfcmVtb3RlX3Nmc2ltaWxhcmVuY2Vfdm1hX2FzaWQoY29uc3QNCj4gPiB1bnNpZ25lZCBs
b25nICpoYXJ0X21hc2ssDQo+ID4gQEAgLTkxLDcgKzk1LDggQEAgc3RhdGljIGlubGluZSB2b2lk
DQo+ID4gc2JpX3JlbW90ZV9zZmVuY2Vfdm1hX2FzaWQoY29uc3QgdW5zaWduZWQgbG9uZyAqaGFy
dF9tYXNrLA0KPiA+ICAJCQkJCSAgICAgIHVuc2lnbmVkIGxvbmcgc2l6ZSwNCj4gPiAgCQkJCQkg
ICAgICB1bnNpZ25lZCBsb25nIGFzaWQpDQo+ID4gIHsNCj4gPiAtCVNCSV9DQUxMXzQoU0JJX1JF
TU9URV9TRkVOQ0VfVk1BX0FTSUQsIGhhcnRfbWFzaywgc3RhcnQsIHNpemUsDQo+ID4gYXNpZCk7
DQo+ID4gKwlTQklfQ0FMTF9MRUdBQ1lfNChTQklfRVhUX0xFR0FDWV9SRU1PVEVfU0ZFTkNFX1ZN
QV9BU0lELA0KPiA+IGhhcnRfbWFzaywNCj4gPiArCQkJICBzdGFydCwgc2l6ZSwgYXNpZCk7DQo+
ID4gIH0NCj4gPiAgDQo+ID4gICNlbmRpZg0KPiA+IC0tIA0KPiA+IDIuMjEuMA0KPiA+IA0KPiA+
IA0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
ID4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtcmlzY3YNCj4gPiANCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
