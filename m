Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F009C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA0922DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GWcXBGGE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XQgOCv+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfHTU3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:29:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41000 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTU3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566332990; x=1597868990;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O1SvXr94+aBuhezicF2UtLS/6BWYlUxtYT7VCJG9jno=;
  b=GWcXBGGEMyO75ATZZa7U3knDSZgv9knIDEom+1mN3Dm5SqMgjPOokCrf
   bYRPWNWUuprjFB9KzhOjHT+5PpZfNwFcxxkbyBMLLrfV54G/CyZCGe/9Q
   ycBVBtOiiDaVVjrzzCxEi55U5LFnZnOY+GyKVDppppgjwI9FlPcvT1NfI
   ybyESUcDoPiG/wx29F5EeMRQr+3u77g+uquJ99V80OAIsblGsTOwYw2Xu
   pPPdHbIy8UOsulV+DNeEhGzhtvtrL3MUAICqGHu6GkmWHU6CHwFLtsfu1
   QtvmqyM07DWzR7aAPgLDxru7viUZoRh4Cm7enkHG+MS4biRjHqrUTA/zi
   Q==;
IronPort-SDR: 5J5wtKN6vNz1ZdSOztd2htI3GqdsmUw62JzR/CLbE7BeI6AYKjNOMDnWy/r5iGyXePOic3CykW
 eOpxziXi551Ba0GdmAWvz/vWdHVwo9DSkOWSgO0bYBdFPuMhQgbzcBKQFaHGHDU38T+Avih/aJ
 IO1R/3bJGYyoUG/nXubghW1B5vbgcNSUjTSc9TPdjQlaGjU1uKc2t5ZzOdPxeoLFPwYnM/SQFU
 L7Ncl1Chpz5ERl7JHz4yjqzYqxalTFa2A6zrRFGUlqccD+8uDImqeR008rJhTa+9GuZLTv+aHq
 NZs=
X-IronPort-AV: E=Sophos;i="5.64,410,1559491200"; 
   d="scan'208";a="117212209"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 04:29:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez46ZQKJIbOTbsurGTF737BukyetYHD6Vze8Qjl6J0KSLDWAib4gNLqVxPWw+FbGQKMieL5z6ETsMHeUjY+L9PU1IWeYWcnVVOhwi/FmAxKAfTKmEztJbo05CGQzw0lP645sMOExEhdklvVBgWWYz4sgaFAIX6aScIc3EgIunxso89iQButaWGs63reBhhFQbGuUgX3wqoy+0iyh6uktX8aB1jfbpkXH9KfzhHvpnSe/6VaGlwWtQnDsQSRlRI/aeuPi9ZdEk8NJzU2D8AG95Cv4BLtBiVHFlY+HuOSvKIQXhr9gi0ulAI0RGzzVr1IUBeS3SDypbKBORV1BLgCj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1SvXr94+aBuhezicF2UtLS/6BWYlUxtYT7VCJG9jno=;
 b=oH5tS/DH4EUmzT1NNRvU4Qt3yLM4ZlJM5unzIpWF0yT7QOrqpnIoSlObtATTggENCzlVk2qmBz3HRp2hNg4qHz+AWiWMm0JwjIpH+TKvq1p036swqmZml5GsqCpjheui7fNJ1P11yEFim/FQxc1ERKLMlS/tPPUPqgbpDZRR/Fuf2c6ouChg9xl22boGtTDa3s7co6Vjj5noAgppcIUcx+bVnvXD78SEZ5lqF9eeBNxSE2zd7wB6Ky5DuOWCPLB65GLt4nCK/Qpw0tDCjjoC5AIi7dGGT5AIPVWKTUVL0CPuLDUIfpRV1Tii4xIiiXBwa9YpH4I5I4inP59E2k9NlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1SvXr94+aBuhezicF2UtLS/6BWYlUxtYT7VCJG9jno=;
 b=XQgOCv+telPd67zweL/Kcn6PM7Kp0I7swBPPnEHbCyURoL/D+mRe80Q6hulV+TpAtmY9zFTc/NHrRGaggQmI6PyFUpDYvTxB4Df/C6l552zeTgALzi65oxeINgZhuVXRd/rlK7FHkg8MfOL7+Qa3h9UdVfIUIdThE2Bh9XBqIKw=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5864.namprd04.prod.outlook.com (20.179.59.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 20:29:47 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 20:29:47 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "anup@brainfault.org" <anup@brainfault.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "hch@infradead.org" <hch@infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Thread-Topic: [v2 PATCH] RISC-V: Optimize tlb flush path.
Thread-Index: AQHVVvDfUBJCIAOoL0y7jXfLdcYugacDuw4AgADDFIA=
Date:   Tue, 20 Aug 2019 20:29:47 +0000
Message-ID: <171bb233718ba2897fa5fd48853721108825d22c.camel@wdc.com>
References: <20190820004735.18518-1-atish.patra@wdc.com>
         <CAAhSdy3uQ=CSg4pHb_BYCEOh_MMTyLf8SW2o9SCn0UZDYwgGpg@mail.gmail.com>
In-Reply-To: <CAAhSdy3uQ=CSg4pHb_BYCEOh_MMTyLf8SW2o9SCn0UZDYwgGpg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8229c90f-1b64-4022-3e5d-08d725ad2515
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5864;
x-ms-traffictypediagnostic: BYAPR04MB5864:
x-microsoft-antispam-prvs: <BYAPR04MB586493FCA9815B6EFE38C344FAAB0@BYAPR04MB5864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(25786009)(476003)(2616005)(81166006)(2351001)(6246003)(2501003)(1730700003)(76176011)(6916009)(81156014)(14454004)(4326008)(229853002)(8936002)(99286004)(3846002)(316002)(2906002)(54906003)(305945005)(6116002)(71200400001)(71190400001)(66556008)(66476007)(26005)(86362001)(64756008)(76116006)(486006)(66946007)(6436002)(66066001)(186003)(478600001)(53546011)(446003)(5660300002)(7736002)(11346002)(53936002)(118296001)(6486002)(102836004)(5640700003)(6512007)(6506007)(36756003)(256004)(66446008)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5864;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pJay5Fl+4voQ49Sk0fuH1BtkKtOx+Plf4PTGuIRfL8VG4syRuVb0Vc3s63WWqpYZy35Ib2wjrJ3JbdwbwkQwzrY8aOVEIX9VUDzt93NMOud1eLIPi1UDX11tkJTZCxnZe+cytvr+GtDyQgA4CJCX2LO/xQMYlBsB6wblRAiee/qhVWipS3+T29gb1U/UmR12KXPRpKlrdUo2E0Jx7cHB3VOF41OACAMRckyUGtcBdXpUuqrl/SUvz443lr26J6P9DbtF/dvMx8hmtefszmLFMPKTmaH4TSXi9zPFU3xN6NjXJFNmg6IBkCH/2qMJna7eH8EkHAdoSPTs+iEpRvGbEzzVd9BQdtzoQAguevlDVy7NGOLWAazWfi/+JIdsruLTfpORIIKfVveGleG5JsnjX2MFnUr1gu0MlqjmTVgYuT4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <676BF3AC5FF9F243836EFCF14992B59E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8229c90f-1b64-4022-3e5d-08d725ad2515
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 20:29:47.7014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNDRjTEWxEbUXO+n8lB75bMB5vyeLarGrM1BmnCYTXPlNqGXDpggKzZ78pBAq5iKvjivn+NYhbtYoO9bDEk7Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTIwIGF0IDE0OjIxICswNTMwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBP
biBUdWUsIEF1ZyAyMCwgMjAxOSBhdCA2OjE3IEFNIEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3
ZGMuY29tPg0KPiB3cm90ZToNCj4gPiBJbiBSSVNDLVYsIHRsYiBmbHVzaCBoYXBwZW5zIHZpYSBT
Qkkgd2hpY2ggaXMgZXhwZW5zaXZlLg0KPiA+IElmIHRoZSB0YXJnZXQgY3B1bWFzayBjb250YWlu
cyBhIGxvY2FsIGhhcnRpZCwgc29tZSBjb3N0DQo+ID4gY2FuIGJlIHNhdmVkIGJ5IGlzc3Vpbmcg
YSBsb2NhbCB0bGIgZmx1c2ggYXMgd2UgZG8gdGhhdA0KPiA+IGluIE9wZW5TQkkgYW55d2F5cy4g
VGhlcmUgaXMgYWxzbyBubyBuZWVkIG9mIFNCSSBjYWxsIGlmDQo+ID4gY3B1bWFzayBpcyBlbXB0
eS4NCj4gPiANCj4gPiBEbyBhIGxvY2FsIGZsdXNoIGZpcnN0IGlmIGN1cnJlbnQgY3B1IGlzIHBy
ZXNlbnQgaW4gY3B1bWFzay4NCj4gPiBJbnZva2UgU0JJIGNhbGwgb25seSBpZiB0YXJnZXQgY3B1
bWFzayBjb250YWlucyBhbnkgY3B1cw0KPiA+IG90aGVyIHRoYW4gbG9jYWwgY3B1Lg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPg0KPiA+
IC0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmggfCAzNyArKysrKysr
KysrKysrKysrKysrKysrKysrKy0NCj4gPiAtLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNo
L3Jpc2N2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCj4gPiBiL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vdGxiZmx1c2guaA0KPiA+IGluZGV4IGI1ZTY0ZGMxOWI5ZS4uM2Y5Y2QxN2I1NDAyIDEwMDY0
NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdGxiZmx1c2guaA0KPiA+ICsrKyBi
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdGxiZmx1c2guaA0KPiA+IEBAIC04LDYgKzgsNyBAQA0K
PiA+ICAjZGVmaW5lIF9BU01fUklTQ1ZfVExCRkxVU0hfSA0KPiA+IA0KPiA+ICAjaW5jbHVkZSA8
bGludXgvbW1fdHlwZXMuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQo+ID4gICNp
bmNsdWRlIDxhc20vc21wLmg+DQo+ID4gDQo+ID4gIC8qDQo+ID4gQEAgLTQyLDIwICs0Myw0NCBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgZmx1c2hfdGxiX3JhbmdlKHN0cnVjdA0KPiA+IHZtX2FyZWFf
c3RydWN0ICp2bWEsDQo+ID4gDQo+ID4gICNpbmNsdWRlIDxhc20vc2JpLmg+DQo+ID4gDQo+ID4g
LXN0YXRpYyBpbmxpbmUgdm9pZCByZW1vdGVfc2ZlbmNlX3ZtYShzdHJ1Y3QgY3B1bWFzayAqY21h
c2ssDQo+ID4gdW5zaWduZWQgbG9uZyBzdGFydCwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBzaXplKQ0KPiA+ICtzdGF0aWMgdm9pZCBfX3Jp
c2N2X2ZsdXNoX3RsYihzdHJ1Y3QgY3B1bWFzayAqY21hc2ssIHVuc2lnbmVkIGxvbmcNCj4gPiBz
dGFydCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHNp
emUpDQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVjdCBjcHVtYXNrIGhtYXNrOw0KPiA+ICsgICAg
ICAgdW5zaWduZWQgaW50IGhhcnRpZDsNCj4gPiArICAgICAgIHVuc2lnbmVkIGludCBjcHVpZDsN
Cj4gPiANCj4gPiAgICAgICAgIGNwdW1hc2tfY2xlYXIoJmhtYXNrKTsNCj4gPiArDQo+ID4gKyAg
ICAgICBpZiAoIWNtYXNrKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJpc2N2X2NwdWlkX3RvX2hh
cnRpZF9tYXNrKGNwdV9vbmxpbmVfbWFzaywNCj4gPiAmaG1hc2spOw0KPiA+ICsgICAgICAgICAg
ICAgICBnb3RvIGlzc3VlX3NmZW5jZTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAg
ICBjcHVpZCA9IGdldF9jcHUoKTsNCj4gPiArICAgICAgIGlmIChjcHVtYXNrX3Rlc3RfY3B1KGNw
dWlkLCBjbWFzaykpIHsNCj4gPiArICAgICAgICAgICAgICAgLyogU2F2ZSB0cmFwIGNvc3QgYnkg
aXNzdWluZyBhIGxvY2FsIHRsYiBmbHVzaCBoZXJlDQo+ID4gKi8NCj4gPiArICAgICAgICAgICAg
ICAgaWYgKChzdGFydCA9PSAwICYmIHNpemUgPT0gLTEpIHx8IChzaXplID4NCj4gPiBQQUdFX1NJ
WkUpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGxvY2FsX2ZsdXNoX3RsYl9hbGwoKTsN
Cj4gPiArICAgICAgICAgICAgICAgZWxzZSBpZiAoc2l6ZSA9PSBQQUdFX1NJWkUpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgbG9jYWxfZmx1c2hfdGxiX3BhZ2Uoc3RhcnQpOw0KPiA+ICsg
ICAgICAgfQ0KPiA+ICsgICAgICAgaWYgKGNwdW1hc2tfYW55X2J1dChjbWFzaywgY3B1aWQpID49
IG5yX2NwdV9pZHMpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZG9uZTsNCj4gPiArDQo+ID4g
ICAgICAgICByaXNjdl9jcHVpZF90b19oYXJ0aWRfbWFzayhjbWFzaywgJmhtYXNrKTsNCj4gPiAr
ICAgICAgIGhhcnRpZCA9IGNwdWlkX3RvX2hhcnRpZF9tYXAoY3B1aWQpOw0KPiA+ICsgICAgICAg
Y3B1bWFza19jbGVhcl9jcHUoaGFydGlkLCAmaG1hc2spOw0KPiA+ICsNCj4gPiAraXNzdWVfc2Zl
bmNlOg0KPiA+ICAgICAgICAgc2JpX3JlbW90ZV9zZmVuY2Vfdm1hKGhtYXNrLmJpdHMsIHN0YXJ0
LCBzaXplKTsNCj4gPiArZG9uZToNCj4gPiArICAgICAgIHB1dF9jcHUoKTsNCj4gPiAgfQ0KPiA+
IA0KPiA+IC0jZGVmaW5lIGZsdXNoX3RsYl9hbGwoKSBzYmlfcmVtb3RlX3NmZW5jZV92bWEoTlVM
TCwgMCwgLTEpDQo+ID4gLQ0KPiA+ICsjZGVmaW5lIGZsdXNoX3RsYl9hbGwoKSBfX3Jpc2N2X2Zs
dXNoX3RsYihOVUxMLCAwLCAtMSkNCj4gPiAgI2RlZmluZSBmbHVzaF90bGJfcmFuZ2Uodm1hLCBz
dGFydCwgZW5kKSBcDQo+ID4gLSAgICAgICByZW1vdGVfc2ZlbmNlX3ZtYShtbV9jcHVtYXNrKCh2
bWEpLT52bV9tbSksIHN0YXJ0LCAoZW5kKSAtDQo+ID4gKHN0YXJ0KSkNCj4gPiArICAgICAgIF9f
cmlzY3ZfZmx1c2hfdGxiKG1tX2NwdW1hc2soKHZtYSktPnZtX21tKSwgc3RhcnQsIChlbmQpIC0N
Cj4gPiAoc3RhcnQpKQ0KPiA+IA0KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQgZmx1c2hfdGxiX3Bh
Z2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgYWRkcikgew0KPiA+IEBAIC02Myw3ICs4OCw3IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBmbHVzaF90bGJfcGFnZShzdHJ1Y3QNCj4gPiB2bV9hcmVhX3N0
cnVjdCAqdm1hLA0KPiA+ICB9DQo+ID4gDQo+ID4gICNkZWZpbmUgZmx1c2hfdGxiX21tKG1tKSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gLSAgICAgICByZW1vdGVfc2ZlbmNl
X3ZtYShtbV9jcHVtYXNrKG1tKSwgMCwgLTEpDQo+ID4gKyAgICAgICBfX3Jpc2N2X2ZsdXNoX3Rs
YihtbV9jcHVtYXNrKG1tKSwgMCwgLTEpDQo+ID4gDQo+ID4gICNlbmRpZiAvKiBDT05GSUdfU01Q
ICovDQo+ID4gDQo+ID4gLS0NCj4gPiAyLjIxLjANCj4gPiANCj4gDQo+IEkgdGhpbmsgd2Ugc2hv
dWxkIG1vdmUgX19yaXNjdl9mbHVzaF90bGIoKSB0byBtbS90bGJmbHVzaC5jIGJlY2F1c2UNCj4g
aXQncyBxdWl0ZQ0KPiBiaWcgbm93Lg0KPiANCj4gSW4gZnV0dXJlLCB3ZSB3aWxsIGFsc28gaGF2
ZSBfX3Jpc2N2X2ZsdXNoX3RsYl9hc2lkKCkgd2hpY2ggd2lsbA0KPiBmbHVzaCBUTEIgYmFzZWQN
Cj4gb24gQVNJRC4NCj4gDQoNClNvdW5kcyBnb29kIHRvIG1lLiBDaHJpc3RvcGggaGFzIGFscmVh
ZHkgbW0vdGxiZmx1c2guYyBpbiBoaXMgbW11DQpzZXJpZXMuIEkgd2lsbCByZWJhc2Ugb24gdG9w
IG9mIGl0Lg0KDQo+IFJlZ2FyZHMsDQo+IEFudXANCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
