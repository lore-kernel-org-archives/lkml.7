Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A7C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCCA21E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lvb67UqQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nrADeVNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389146AbfHGRbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:31:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6213 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbfHGRbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565199115; x=1596735115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cSRbF3vx7WsTqTkzDSX0FtgF2dR9I+cdi+BWPiPCbJo=;
  b=Lvb67UqQ1XWh0XS+NnoA9Mp3t6x8rG8q7swUUqzYYFoJU82zIo6uqgXu
   urs8zSC8OHAY1uSSqg/KoHInJxGrZGQCIxYepX695isY/OFjJvCpm/Qxr
   wqmcw+fOqkmZaeRYzskntO9i46nNr5RD6jmVBkrUeu0qJNHptCEjzLhbp
   vmUtY8fnTPKOutEcIYCquIu4Jith2CLxmsAVgkI4k0hSFCZnDdhCLm3W+
   Ipsfh/j/NjDiJCFbSb/9xz5OvdxiPNEC72UANGhIt62tXjRXlptoGLWmu
   tUm4fuVH0MZn/hUYGyHV37dRBYwYvhPV7iMosIheIffQ5MWdh4X3ZM97K
   g==;
IronPort-SDR: 3RFuEkIpreQxFRLyu2TcVlN3fNdZyFsFFs6CIaGQ4cTXbFpszeuKzvROZFc6bhyacY+YwpZBcA
 JPsP9OiMMSgvjYxRFoLS9y5L2iFCiKWLACVDmWH0pEdvEBy3rNkn+UfYamBCC4eg2uX5ffA6U2
 EEAD7nXvULLVGXZvcTlT5IBNCO1LQMfatbx6mi8ZhhD4PG2l3wWVuq53Dzrxl5+FAV/CI3ALEF
 djjSFJ3CIk2NGPtY27de/S1I1mKt00ou5IZN27qBmHQ3n02wf/McDs0guJSAqTspO1hjmqq+LK
 I0I=
X-IronPort-AV: E=Sophos;i="5.64,358,1559491200"; 
   d="scan'208";a="119892714"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 01:31:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD557bCRt1Eaum0RtNKIRYOYLCd8po6czAAyHxxeG7jjJYgTWKEUXfotEktRtdZM7YbAxMKMWYmsUuCgRj+R44b0N/w9REFdeofsP4AryXANg5STUOVx0isBAYm1ei6PcEZ374OYtcS0d+2UIZytP77GZFIP75HNZX2bWlJRhXjaHZgMLZUsi+Wz//aCiiEVdd5is6GXz8T5QmDB1AaJctAJjev6cFgNvT9GzSW4bwvbvzhPDLlrCKohnJtD1ztev9BUeCtJ/ZDzduAbgwHGHbwryvzSvGNz/svJ8IEz4XjuoGT37ZWug0OHEOmw8m5RyODZFZNFfg8YLhk2Iids/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSRbF3vx7WsTqTkzDSX0FtgF2dR9I+cdi+BWPiPCbJo=;
 b=BOSJw2WmZq/ftJBbT0fQEijgrckd7TRW1dbJpkimX6SRI2q/Hx1J4Vh0N+MVys31n73t5xcMeSJfc1o3FpdJFiYikvbnfJmGIHYod33Eqi5ULkbGAWrCwG+p2acGOW0zJ+YptfJA9w4i6dr6poe3g/vx9dGlGyTmhIarKIMK0VMX6jBuk2U0keIz2x6OQK5vCWeCcW1hgir+jBzvgUqbXyxjzTrjvGeASYmQhWTsJKgJQXVLCmxJ4ZtupfqJ7P8NpOY+Z0ZEGrPmfiXN3YbROx6udaAUGXNeQkxE7DoHG3ZfTgA9Fg4GH84LGxjV+vNbsJSZnqFcExQxkiRnb66/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSRbF3vx7WsTqTkzDSX0FtgF2dR9I+cdi+BWPiPCbJo=;
 b=nrADeVNer+lI68xvVjq6fow7gJEVJH7TOXNUCT4lsVXNbf+CoIlGVPQhaFZWDEIdwG1Muxt4gJCCjBvPreSC+bZd4BiMWU1aojiaa2zQYfDteCVDieJh2nlFwADRedHTZdN4Yn3xTTIpNwnMy87fJRpf4Fm3BAKaQQaMsnF9MUM=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB4055.namprd04.prod.outlook.com (52.135.215.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Wed, 7 Aug 2019 17:31:51 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005; Wed, 7 Aug 2019
 17:31:51 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "info@metux.net" <info@metux.net>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 3/5] RISC-V: Fix unsupported isa string info.
Thread-Topic: [PATCH v3 3/5] RISC-V: Fix unsupported isa string info.
Thread-Index: AQHVSARDLwisRSZSxEGpcN8B9TVet6buzP8AgAAdjQCAAAOYAIABDdEA
Date:   Wed, 7 Aug 2019 17:31:51 +0000
Message-ID: <a2795337bd86ff22ae9618d7ccae22e7482be332.camel@wdc.com>
References: <20190801005843.10343-1-atish.patra@wdc.com>
         <20190801005843.10343-4-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1908061625190.13971@viisi.sifive.com>
         <1e23ef1face9d323fda4b756811f922caa5f7689.camel@wdc.com>
         <alpine.DEB.2.21.9999.1908061818360.13971@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908061818360.13971@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 704ebc1d-6d9a-4316-0144-08d71b5d2234
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4055;
x-ms-traffictypediagnostic: BYAPR04MB4055:
x-microsoft-antispam-prvs: <BYAPR04MB405580B209D3AD125E2FA110FAD40@BYAPR04MB4055.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(2906002)(76116006)(316002)(66946007)(66556008)(5660300002)(54906003)(86362001)(6246003)(6116002)(11346002)(26005)(186003)(71190400001)(71200400001)(66446008)(64756008)(446003)(478600001)(4326008)(2351001)(66476007)(25786009)(476003)(2616005)(486006)(256004)(3846002)(6486002)(68736007)(102836004)(6916009)(229853002)(6506007)(36756003)(99286004)(8676002)(76176011)(6436002)(6512007)(305945005)(8936002)(66066001)(7736002)(81156014)(118296001)(7416002)(14454004)(81166006)(53936002)(2501003)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4055;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ddgQCjxYTgZxIMRU+JkoIVhnf6e/t/PDpe0PSkB8k8vVRkBsAjqIfiApO4cT2jqX9Tw1d66rwz61AL5WAh5UNgTFDJg3KkTVdCzK0ZhvXGuf+e0m0s0B7KdIRnuA17GOqTCumTDSmmsUNKG5T/gHbu0lly92lpBo7Af+8EwD0LTtT7KOLGSyoMR4CgCY6zYX6CdC/aR80bUhZpbSoX2aKOSra5JiP8gAFNfU++cM5bQi6RLMh1q7TCrsMUEokc2eWYHy0jIw27Mmb9lSv4kgsIiMIqQsdLuEIWefKTq6Qi2aj4Ppj8RUcE6jYJdTlRSu3T4MrHMZ3Ekmw/8jTZWl6y2eT3mqGWKA0bdA7YEBlg+5tI6wetAFIMidQc/hGG/RBBHMkkDXf6Hc3kD+igQzjz6ZHcxJrMhQVlRRdYUanqE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB926A394B57D04583BF73AC1DC978FA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704ebc1d-6d9a-4316-0144-08d71b5d2234
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 17:31:51.4497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTA2IGF0IDE4OjI2IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBXZWQsIDcgQXVnIDIwMTksIEF0aXNoIFBhdHJhIHdyb3RlOg0KPiANCj4gPiBPbiBUdWUs
IDIwMTktMDgtMDYgYXQgMTY6MjcgLTA3MDAsIFBhdWwgV2FsbXNsZXkgd3JvdGU6DQo+ID4gDQo+
ID4gPiBTZWVtcyBsaWtlIHRoZSAic3UiIHNob3VsZCBiZSBkcm9wcGVkIGZyb20gbWFuZGF0b3J5
X2V4dC4gIFdoYXQNCj4gPiA+IGRvIHlvdSANCj4gPiA+IHRoaW5rPw0KPiA+ID4gDQo+ID4gDQo+
ID4gWXVwLiBBcyBEVCBiaW5kaW5nIG9ubHkgbWVudGlvbiBpbWFmZGMsIG1hbmRhdG9yeSBleHRl
bnNpb25zIHNob3VsZA0KPiA+IGNvbnRhaW4gb25seSB0aGF0IGFuZCBqdXN0IGNvbnNpZGVyICJz
dSIgZXh0ZW5zaW9ucyBhcmUgY29uc2lkZXJlZA0KPiA+IGFzDQo+ID4gaW1wbGljaXQgYXMgd2Ug
YXJlIHJ1bm5pbmcgTGludXguIA0KPiANCj4gRGlzY3Vzc2luZyB0aGlzIHdpdGggQW5kcmV3IGFu
ZCBQYWxtZXIsIGl0IGxvb2tzIGxpa2UgInN1IiBpcw0KPiBjdXJyZW50bHkgDQo+IG5vbi1jb21w
bGlhbnQuICBTZWN0aW9uIDIyLjYgb2YgdGhlIHVzZXItbGV2ZWwgc3BlY2lmaWNhdGlvbiBzdGF0
ZXMNCj4gdGhhdCANCj4gdGhlICJzIiBjaGFyYWN0ZXIgaW5kaWNhdGVzIHRoYXQgYSBsb25nZXIg
c3RhbmRhcmQgc3VwZXJ2aXNvcg0KPiBleHRlbnNpb24gDQo+IG5hbWUgd2lsbCBmb2xsb3cuICBT
byBmYXIgSSBkb24ndCB0aGluayBhbnkgb2YgdGhlc2UgaGF2ZSBiZWVuDQo+IGRlZmluZWQuDQo+
IA0KPiA+IERvIHlvdSB0aGluayBRRU1VIERUIHNob3VsZCBiZSB1cGRhdGVkIHRvIHJlZmxlY3Qg
dGhhdCA/DQo+IA0KPiBZZXMuDQo+IA0KPiA+ID4gVGhlcmUncyBubyBLY29uZmlnIG9wdGlvbiBi
eSB0aGlzIG5hbWUsIGFuZCB3ZSdyZSByZXF1aXJpbmcNCj4gPiA+IGNvbXByZXNzZWQgDQo+ID4g
DQo+ID4gU29ycnkuIFRoaXMgd2FzIGEgdHlwby4gSXQgc2hvdWxkIGhhdmUgYmVlbiBDT05GSUdf
UklTQ1ZfSVNBX0MuDQo+ID4gDQo+ID4gPiBpbnN0cnVjdGlvbiBzdXBwb3J0IGFzIHBhcnQgb2Yg
dGhlIFJJU0MtViBMaW51eCBiYXNlbGluZS4gIENvdWxkDQo+ID4gPiB5b3UgDQo+ID4gPiBzaGFy
ZSB0aGUgcmF0aW9uYWxlIGJlaGluZCB0aGlzPw0KPiA+IA0KPiA+IEkgdGhpbmsgSSBhZGRlZCB0
aGlzIGNoZWNrIGF0IHRoZSBjb25maWcgZmlsZS4gTG9va2luZyBhdCB0aGUNCj4gPiBLY29uZmln
LA0KPiA+IFJJU0NWX0lTQV9DIGlzIGFsd2F5cyBlbmFibGVkLiBTbyB3ZSBjYW4gZHJvcCB0aGlz
Lg0KPiANCj4gT0sgZ3JlYXQuICBEbyB5b3Ugd2FudCB0byByZXNlbmQgYW4gdXBkYXRlZCBwYXRj
aCwgb3Igd291bGQgeW91IGxpa2UNCj4gbWUgdG8gDQo+IGZpeCBpdCB1cCBoZXJlPw0KPiANCg0K
SSBhbSBzZW5kaW5nIHRoZSBwYXRjaCByaWdodCBub3cuIFdlIGNhbiByZW1vdmUgdGhlICdTJyBt
b2RlIGNoZWNrIGFzDQpwYWxtZXIgaGF2ZSBhbHJlYWR5IHNlbnQgdGhlIFFFTVUgcGF0Y2ggYXMg
d2VsbCwgLg0KDQpSZWdhcmRzLA0KQXRpc2gNCj4gSSdsbCBhbHNvIHNlbmQgYSBwYXRjaCB0byBk
cm9wIENPTkZJR19SSVNDVl9JU0FfQy4NCj4gDQo+IA0KPiAtIFBhdWwNCg0K
