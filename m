Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F51C49ED6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E2220717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f7Rd9QwO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GcXaMv9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfINEH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 00:07:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27467 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfINEH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 00:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568434078; x=1599970078;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h0u3s2DC5aWn/hXFlXG+/dfIbIhFBKc9lGVZll/3uEs=;
  b=f7Rd9QwO8esjp2QblvanKJz1yljv7dTu05yTq6BgBred6dJpE1MgXJIG
   +rRvZ7GLYykPZXSdvqiOIuWJHS/302+Pc+HKFrVFpv9eOCIK860oxYV6K
   gRGfdhuo9SN+s17DkB79+06uWTf7YS/UVMugPy+amZpTVSdVES0b3T7cM
   OipWghBBwpfOV9B4to5gvUK+zccMBkBANk/Bfj/8LsBvJoucmZOpmq9LY
   51uSepRse0JGNHRhTwK0w0gQbw98IUgOjN0S/9IPBPQNJcM00jSwiM6fD
   5qC+GqtuBE5jMpaoZs6eKuSLUj8HOa1wgjcN6L4wTMK/0DMN1vC0T01rW
   w==;
IronPort-SDR: di+viPlwd99f/29uVNb0uXIqF+s54QIlAzJTqycp53vMCIm3gwTuEZpjXQ4mV2EmqrU7CJDC0M
 9Nozr+fckPZYsw/3pHe9cvnXFwGjABapa4sIam5yekUQtChL3P1v5L8KYH6QefIBylEcG/o3R7
 I/jKCh0r38dhRW/oeHADP4dWamaBpgVPXhdoUZ21LZAJEj1hA+SyEYdqCpPiz3jgSNw9T4m84d
 kykI6umkJsqw7WofiMwZO7AoliuP6PEq8y4fK2yTpfHS/c8sImw6xXE+saPIGkeo9RwyDYhO3b
 /co=
X-IronPort-AV: E=Sophos;i="5.64,503,1559491200"; 
   d="scan'208";a="119804557"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 12:07:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlRIfsbwtzBp17bEwEyLAcp8OaMfr4WQh53QMX5orzZt8SWHaVuYNftMyd/ml7i/+io+s7smvd14LqjN5BcyZfGMShy4XqbYBsd+xyNN/7ss0khIk2blSDBUYqoFGJnuLbQhAKQKqeVH5tSP7u800lmqFIRJbBDsxFqTKlB0MBKVsPJtASNJfPgtg6e3lLSVA6xChSQzDZSMkOj4D3zBlfWo9esU9tza7jQzlW4sRYiT3yphAfeJfHeaAEuyB4++SPAl6P9PwEfYvv9lZndjGhdfn6l9PHZzKP8uh7FaeV32MshqBrJ+ZLfPzZmQ6kf82ELtv2/q5bZDo0elj1jtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0u3s2DC5aWn/hXFlXG+/dfIbIhFBKc9lGVZll/3uEs=;
 b=G5XrdVdSRsFvNiTqsM16rUHeL+MxP90ng/MJ1ApkYETvnFP1/5Onemw+ljoE1OXGwzTsP1Qw6G72h45LD+Fu3PJBATLh2Su7oxDNPCRCERREUA8pqWB2QiaadRCyZow7IvVLs5RzdTRR2lCuRikCmytyjakSns/dNe0AoILjHKcOHIQGBSz3m/i3S9svK1MlsGRUaXjwPVconyahdpqP49ZXBNRTTr6Xni9mHVUz3holhj7Ei/AdrpAc37cHyQtLKohc0akdhOrfkkgrhXWY05gLQmlWyQcpIauqHBaD94SfcuT+GQSOqZFSqMrEt2dIhh9Kh70s8Jwnv6hXLjeC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0u3s2DC5aWn/hXFlXG+/dfIbIhFBKc9lGVZll/3uEs=;
 b=GcXaMv9ZRAiyG4LTVORVv/FGXQOzwu2EF7ptURMilvn8CO16ultltsDrSg8cMJNUycDwub0ly80AdLxSuHLyzRYZqKb8vMdTQZIoFRAlf4Ttt0M3hM4HiF2ix+nz35etFzItbynfzJeVxJhnCU4yAuAJrzP7g+k6/wq6wFPZKhw=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4357.namprd04.prod.outlook.com (20.176.252.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Sat, 14 Sep 2019 04:07:55 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc%5]) with mapi id 15.20.2263.021; Sat, 14 Sep 2019
 04:07:55 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "palmer@sifive.com" <palmer@sifive.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "johan@kernel.org" <johan@kernel.org>
Subject: Re: [v5 PATCH] RISC-V: Fix unsupported isa string info.
Thread-Topic: [v5 PATCH] RISC-V: Fix unsupported isa string info.
Thread-Index: AQHVTU090lWiUiEQM02Uoz9V3NTipqb3o0CAgAaR3ACAAxJmAIACeCUAgBu7KwCABSSVAIAFruOAgAB7EgA=
Date:   Sat, 14 Sep 2019 04:07:55 +0000
Message-ID: <491aa3fb2d08e283ecedb5c02f9555d10f458ecb.camel@wdc.com>
References: <mhng-300d37d6-c3a0-461c-b843-ca9b0e2b4714@palmer-si-x1e>
In-Reply-To: <mhng-300d37d6-c3a0-461c-b843-ca9b0e2b4714@palmer-si-x1e>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [122.171.172.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c17d73aa-b185-4a80-fc50-08d738c91f25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4357;
x-ms-traffictypediagnostic: BYAPR04MB4357:
x-microsoft-antispam-prvs: <BYAPR04MB4357A579D4ABCFCC80BC63E6FAB20@BYAPR04MB4357.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01604FB62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(7736002)(229853002)(305945005)(6436002)(6486002)(6512007)(6246003)(53936002)(71190400001)(71200400001)(118296001)(5660300002)(76116006)(36756003)(91956017)(486006)(86362001)(66476007)(64756008)(66446008)(66946007)(66556008)(476003)(2616005)(11346002)(446003)(6506007)(14454004)(25786009)(76176011)(99286004)(102836004)(26005)(186003)(2501003)(256004)(3846002)(6116002)(316002)(2906002)(54906003)(110136005)(81156014)(81166006)(8676002)(8936002)(66066001)(478600001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4357;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AYqXghNCw0+CI37uRuJUctsl1tw8Q5gyuUp9OpU1oyL37PZx7MOc3Emyge/suvZk72X1IDigMQR+B8HRW8B6lkAgS0kvS/XPjPztxojZ1IPFwDzDKHowvL/Qwv/5obf8XNuh254moPgq4Rx4yHKrnLsA4AuNe3euzHThN6RNKYcr02YX8WPaf6KUb+PnzF18xTtTzOR/hPO+CIcnptW6eWzcYDtYGIYHfrdkhhSvzCW01BdMgJciQjtmT4Vi0LogKe277QmOoNJPQ0ed3CqTFatKDYAFfpYkdeu1oi+hHGH6abgeM2+03SERtQ2LjNP8Vn63tDjyeVGx8Ffwr+sOwRzdlOs7uyKHkPLgrNgvJaLQP9tu+0788xkLQ3JzzSDwjMMsZFnTzr+9Md8uOBDGofXxRalx3YoTkwH3nxkQQlY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2CF992F421BE140B5FB408344B54AFC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17d73aa-b185-4a80-fc50-08d738c91f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2019 04:07:55.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZbHYGn7/T+q9L+Ij3B9InD0rNpLKyZ3t/dC/8+E/NcrWEXOzEmWoRDkotUzJrMESTpvPrJtQbXDLPMcFeNIEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA5LTEzIGF0IDEzOjQ3IC0wNzAwLCBQYWxtZXIgRGFiYmVsdCB3cm90ZToN
Cj4gT24gTW9uLCAwOSBTZXAgMjAxOSAyMzowMDoxMCBQRFQgKC0wNzAwKSwgQ2hyaXN0b3BoIEhl
bGx3aWcgd3JvdGU6DQo+ID4gT24gRnJpLCBTZXAgMDYsIDIwMTkgYXQgMTE6Mjc6NTdQTSArMDAw
MCwgQXRpc2ggUGF0cmEgd3JvdGU6DQo+ID4gPiA+IEFncmVlZC4gTWF5IGJlIHNvbWV0aGluZyBs
aWtlIHRoaXMgPw0KPiA+ID4gPiANCj4gPiA+ID4gTGV0J3Mgc2F5IGYvZCBpcyBlbmFibGVkIGlu
IGtlcm5lbCBidXQgY3B1IGRvZXNuJ3Qgc3VwcG9ydCBpdC4NCj4gPiA+ID4gInVuc3VwcG9ydGVk
IGlzYSIgd2lsbCBvbmx5IGFwcGVhciBpZiB0aGVyZSBhcmUgYW55IHVuc3VwcG9ydGVkDQo+ID4g
PiA+IGlzYS4NCj4gPiA+ID4gDQo+ID4gPiA+IHByb2Nlc3NvciAgICAgICA6IDMNCj4gPiA+ID4g
aGFydCAgICAgICAgICAgIDogNA0KPiA+ID4gPiBpc2EgICAgICAgICAgICAgOiBydjY0aW1hYw0K
PiA+ID4gPiB1bnN1cHBvcnRlZCBpc2EJOiBmZA0KPiA+ID4gPiBtbXUgICAgICAgICAgICAgOiBz
djM5DQo+ID4gPiA+IHVhcmNoICAgICAgICAgICA6IHNpZml2ZSx1NTQtbWMNCj4gPiA+ID4gDQo+
ID4gPiA+IE1heSBiZSBJIGFtIGp1c3QgdHJ5aW5nIG92ZXIgb3B0aW1pemUgb25lIGNvcm5lciBj
YXNlIDopIDopLg0KPiA+ID4gPiAvcHJvYy9jcHVpbmZvIHNob3VsZCBqdXN0IHByaW50IGFsbCB0
aGUgaXNhIHN0cmluZy4gVGhhdCdzIGl0Lg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gUGluZyA/
DQo+ID4gDQo+ID4gWWVzLCBJIGFncmVlIHdpdGggdGhlICJkdW1iIiByZXBvcnRpbmcgb2YgYWxs
IGNhcGFiaWxpdGllcy4NCj4gDQo+IEkgYWdyZWU6IGl0IGxvb2tzIGxpa2Ugb3RoZXIgYXJjaGl0
ZWN0dXJlcyBhcmUgcGFzc2luZyBpbmZvIChpZSwgeDg2DQo+IGZsYWdzKSANCj4gdGhhdCBpc24n
dCBzdXBwb3J0ZWQgYnkgdXNlcnNwYWNlLiAgV2UgaGF2ZSB0aGUgRUxGIGh3Y2FwIHN0dWZmIGZv
cg0KPiB0aG9zZSB3aG8gDQo+IHdhbnQgdG8gdGVsbCB3aGljaCBpbnN0cnVjdGlvbnMgdGhleSBj
YW4gcnVuLCBzbyBpdCdzIHNhbmUgdG8ganVzdA0KPiBrZWVwIHRoaXMgDQo+IHNpbXBsZS4NCg0K
R3JlYXQuIFRoYXQgd2lsbCBzaW1wbGlmeSB0aGUgY29kZSBwYXRoIGFzIHdlbGwuIEkgd2lsbCBz
ZW5kIGEgdjYgd2l0aA0KdGhlIGZpeGVzLg0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
