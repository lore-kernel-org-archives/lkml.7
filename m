Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7E8C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CEF20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZBGugCJy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CsEsluVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfLDSi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:38:59 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22323 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfLDSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575484807; x=1607020807;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AQFo6fmOFFup9ahB6ZR0BfGF3zU3mPSpsvGEXZ5XvLE=;
  b=ZBGugCJyt11peB26MBank3KvBFwUxUZl+3IcG6y0VCvUEaXu/GJxiYYz
   hUxcgE+BzECcMRrdPv9ZGtQjJhDllbUagOCn2zQ6Ekw8lrsPedrs3Q6nr
   5RPc2xvB4Nqd3mD2U0BkD6Au+HrUPNNUVDt+TNU5/exkkoQXgVQTAs83K
   WWtsrG6QeWahvGY/Kti562tk+LrRPy+96F2p+qELrKjCwY2aSjlNkUrGp
   hcmL4brvSPbJ4Tgaeuo7MEzVoE1ugXt5YVt21Edg5o6jJ80Pf0W6nywIS
   QlKhqXFdg3HAl4uRlGF/dlZELWatGrLsJyA7LGjFfl3k008LyMGoKbf6j
   A==;
IronPort-SDR: 7gttZcY5SdoKVaJ8L7JUiu+YffhQwdwsT+MOtkSMmUrY6d/5K6Ps+CmeMULh369qdz39huHcQE
 DWd1J65PZ7H4DEV62wfYz08sOOdGzUEhxEUVOAi+fyW8yyXDczknG1BjiB2HZYEgj+kuhGyIZr
 a5yh+e688y8A++p8GvxL2uYBXdH7Z2GmA7c7NiRdVlOOTCNgwnPqjK3L98TOuP9F1Jzsdzxf8Q
 8/Bov1se9h9g6ObZjvmDfSqYp2tMx700qQfwleC9/UepgOST9szIZXSex+w2Oh6a+hqmpxWbpb
 j14=
X-IronPort-AV: E=Sophos;i="5.69,278,1571673600"; 
   d="scan'208";a="226072530"
Received: from mail-co1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.58])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2019 02:40:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbPenlD6LbbjCOA6CgFW4ziMWeK3tjSF+eodmd8i1Vivf7FEToRWN5QKmpaiwMhSmNDGwneshSkyK4XDAcQyMVql4If14aD6kqGvWP7aaSXrODFH9/CW6f4gJsD9rH0CDOMn6FyiFDoLVmxm+niXh4Kg7L52I9GzxLnglG6ud+kFrV3Xb+bcs2LuPTsbz1IcEMjea95SlvwmuwqQn68GZsfrqEb02sn/GRFNc4kPkA4JSPu2RlWL2FZhIsjSEf/YJRwwbPINlVEyKZopzWMiZ14xqWY/vq11CsUBb5zc4Oggod1nMm7Se2zdsiYHcfh1w0yFw3X9haD+4Dx0LSHaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQFo6fmOFFup9ahB6ZR0BfGF3zU3mPSpsvGEXZ5XvLE=;
 b=mPq0UsVk0dRqTfM4z8mgxNc3xSrg3qMcZMPIZKfNCfocT4N80BQ3bF6w9bHAI8vf7V6NuecMtYEVtTlchIMhoF4HOH6z69JfDLinOrlwasUfg9wukDm62J4/nH8WzPNVVdXWLyey+GplNGBZIU6lKmd/Bz28/A4cORlf3ctThHAg/Am6ZwJlgsrNULYznilMHY8HtkoHBLOw5AVRJipueT10aTQaiEQ9zBKX08mwO8iTHiAU51o1UYcfioqriy2HNlV2owerc1hGWUw/NNJUUhV3+XYvICTqFU7c8lo/gwwJn0iTG/ph+AUMIeuSBGVNkObfk7u4XkAPAhR3zrglpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQFo6fmOFFup9ahB6ZR0BfGF3zU3mPSpsvGEXZ5XvLE=;
 b=CsEsluVQgcvY5bF2K3dEj0L0+R6WYmk1YnWe2yr68UX5/skhveXc2j/zuk5+lreugG/tLLr+ltqjDA4UNcMd/J7zgzlBBKypjeu6tTWLLCcEuqTk90ysWELFBnONQULojQzCR+X3itOg91AIwM9ygz6uubvFQWnfoTxMIGtKFGY=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB5143.namprd04.prod.outlook.com (52.135.234.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 18:38:56 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::545f:1547:d48a:7fbc]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::545f:1547:d48a:7fbc%7]) with mapi id 15.20.2516.014; Wed, 4 Dec 2019
 18:38:56 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
Thread-Topic: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
Thread-Index: AQHVqoAixayXodMShUatl8RuOOpeiKep7kMAgABfWIA=
Date:   Wed, 4 Dec 2019 18:38:56 +0000
Message-ID: <9044bad02aa6553cdb2523294500b50fccf3fd2a.camel@wdc.com>
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
         <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com>
In-Reply-To: <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b28ac3bf-8da6-4f92-b0af-08d778e9385a
x-ms-traffictypediagnostic: BYAPR04MB5143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5143C6D2993FFACC8260E238905D0@BYAPR04MB5143.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(199004)(189003)(36756003)(66476007)(26005)(2501003)(102836004)(71200400001)(478600001)(14454004)(4001150100001)(76116006)(76176011)(64756008)(66556008)(71190400001)(86362001)(6506007)(53546011)(118296001)(8676002)(6116002)(186003)(8936002)(25786009)(66946007)(81156014)(305945005)(2616005)(3846002)(110136005)(6246003)(6486002)(81166006)(11346002)(5660300002)(66446008)(15650500001)(229853002)(6436002)(2906002)(54906003)(7736002)(4326008)(316002)(6512007)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5143;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nfg/Im7ngfVd+jtT8PtYVbXsvvcO5+JBsK3UQrclLGiiTHD3yDQ9iO5KmemavnlqOozy0SyTbED0s5lhuHoAXOizPqjhV3gXm3tJgHJNk9ZG2GX04jF5+BCU7x9Ba+1VAJaOjBW1YayW3o/RWMjjaiTISmN2UkixtTfywczWmqKEAisEHZ+r5+my68VZbvgY2Er1knWQsGnblF4N/awvMHrdQd9EPNvF2x3YEELJlQFz8JYA2R9xJfNRC0sa3hNwhhr3NoTX6pz59S6vqma2bI77WCW/mi8rbuCTk7mVKqy786meGmsTETURz6srQ3993BX7hLVDR8HSY8ryrhYvl2Z8LqVDU7mwOHOcCQzuQOK/NMp+OI2zUdP4fbgfj7eLAijnWQx+ReWUm80/qpzUGqfptiH7uwWOWYhvReswQQ8Su08Wh/c3c4X19F6RN0Gy
Content-Type: text/plain; charset="utf-8"
Content-ID: <94D2DB335E81E44A982CAD148423A872@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28ac3bf-8da6-4f92-b0af-08d778e9385a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 18:38:56.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6sJydiVKQ4T7JzSAXTNeocWfuSPmVpjOOwgDZu2hNpSej7PTPVtu7sx2orIzmFnjsO7aV0/hXhB+Fem/z3V4851LpPvJNxzer5JWkv6yWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTA0IGF0IDE4OjIyICswNTMwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBP
biBXZWQsIERlYyA0LCAyMDE5IGF0IDI6MjIgUE0gUGF1bCBXYWxtc2xleSA8DQo+IHBhdWwud2Fs
bXNsZXlAc2lmaXZlLmNvbT4gd3JvdGU6DQo+ID4gTGludXMsDQo+ID4gDQo+ID4gVGhlIGZvbGxv
d2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdA0KPiA+IDViYTlhYTU2ZTZkM2U4ZmRkYjk1NGMyZjgx
OGQxY2UwNTI1MjM1YmI6DQo+ID4gDQo+ID4gICBNZXJnZSBicmFuY2ggJ25leHQvbm9tbXUnIGlu
dG8gZm9yLW5leHQgKDIwMTktMTEtMjIgMTg6NTk6MDkNCj4gPiAtMDgwMCkNCj4gPiANCj4gPiBh
cmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCj4gPiANCj4gPiAgIGdpdDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9yaXNjdi9saW51eC5naXQN
Cj4gPiB0YWdzL3Jpc2N2L2Zvci12NS41LXJjMS0yDQo+ID4gDQo+ID4gZm9yIHlvdSB0byBmZXRj
aCBjaGFuZ2VzIHVwIHRvDQo+ID4gMTY0NjIyMGE2ZDRiMjcxNTNkZGI1ZmZiMTE3YWExZjRjMzll
M2QxZjoNCj4gPiANCj4gPiAgIE1lcmdlIGJyYW5jaCAnbmV4dC9kZWZjb25maWctYWRkLWRlYnVn
JyBpbnRvIGZvci1uZXh0ICgyMDE5LTExLTIyIA0KPiA+IDE4OjU5OjIzIC0wODAwKQ0KPiA+IA0K
PiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gPiBTZWNvbmQgc2V0IG9mIFJJU0MtViB1cGRhdGVzIGZvciB2NS41LXJj
MQ0KPiA+IA0KPiA+IEEgZmV3IG1pbm9yIFJJU0MtViB1cGRhdGVzIGZvciB2NS41LXJjMSB0aGF0
IGFycml2ZWQgbGF0ZS4NCj4gPiANCj4gPiBOZXcgZmVhdHVyZXM6DQo+ID4gDQo+ID4gLSBEdW1w
IHNvbWUga2VybmVsIHZpcnR1YWwgbWVtb3J5IG1hcCBkZXRhaWxzIHRvIHRoZSBjb25zb2xlIGlm
DQo+ID4gICBDT05GSUdfREVCVUdfVk0gaXMgZW5hYmxlZA0KPiA+IA0KPiA+IE90aGVyIGltcHJv
dmVtZW50czoNCj4gPiANCj4gPiAtIEVuYWJsZSBtb3JlIGRlYnVnZ2luZyBvcHRpb25zIGluIHRo
ZSBwcmltYXJ5IGRlZmNvbmZpZ3MNCj4gPiANCj4gPiBDbGVhbnVwczoNCj4gPiANCj4gPiAtIENs
ZWFuIHVwIEtjb25maWcgaW5kZW50YXRpb24NCj4gPiANCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gS3J6eXN6
dG9mIEtvemxvd3NraSAoMSk6DQo+ID4gICAgICAgcmlzY3Y6IEZpeCBLY29uZmlnIGluZGVudGF0
aW9uDQo+ID4gDQo+ID4gUGF1bCBXYWxtc2xleSAoNCk6DQo+ID4gICAgICAgcmlzY3Y6IGRlZmNv
bmZpZ3M6IGVuYWJsZSBkZWJ1Z2ZzDQo+ID4gICAgICAgcmlzY3Y6IGRlZmNvbmZpZ3M6IGVuYWJs
ZSBtb3JlIGRlYnVnZ2luZyBvcHRpb25zDQo+IA0KPiBJIGhhZCBjb21tZW50ZWQgb24geW91ciBw
YXRjaCBidXQgbXkgY29tbWVudHMgYXJlIHN0aWxsDQo+IG5vdCBhZGRyZXNzZWQuDQo+IA0KPiBW
YXJpb3VzIGRlYnVnIG9wdGlvbnMgZW5hYmxlZCBieSB0aGlzIHBhdGNoIGhhdmUgcGVyZm9ybWFu
Y2UNCj4gaW1wYWN0LiBJbnN0ZWFkIG9mIGVuYWJsaW5nIHRoZXNlIGRlYnVnIG9wdGlvbnMgaW4g
cHJpbWFyeQ0KPiBkZWZjb25maWdzLCBJIHN1Z2dlc3QgdG8gaGF2ZSBzZXBhcmF0ZSBkZWJ1ZyBk
ZWZjb25maWdzIHdpdGgNCj4gdGhlc2Ugb3B0aW9ucyBlbmFibGVkLg0KDQorMQ0KDQpPRSB1c2Vz
IHRoZSBkZWZjb25maWcgKGFzIEknbSBzdXJlIG90aGVyIGRpc3Ryb3MgZG8pIGFuZCBzbG93aW5n
IGRvd24NCnVzZXJzIHNlZW1zIGxpa2UgYSBiYWQgaWRlYS4NCg0KQWxpc3RhaXINCg0KPiANCj4g
UGxlYXNlIGFkZHJlc3MgbXkgY29tbWVudHMgYW5kIHNlbmQgdGhpcyBwYXRjaCBpbg0KPiBzZXBh
cmF0ZSBQUi4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFudXANCj4gDQo+ID4gICAgICAgTWVyZ2UgYnJh
bmNoICduZXh0L21pc2MyJyBpbnRvIGZvci1uZXh0DQo+ID4gICAgICAgTWVyZ2UgYnJhbmNoICdu
ZXh0L2RlZmNvbmZpZy1hZGQtZGVidWcnIGludG8gZm9yLW5leHQNCj4gPiANCj4gPiBZYXNoIFNo
YWggKDEpOg0KPiA+ICAgICAgIFJJU0MtVjogQWRkIGFkZHJlc3MgbWFwIGR1bXBlcg0KPiA+IA0K
PiA+ICBhcmNoL3Jpc2N2L0tjb25maWcuc29jcyAgICAgICAgICAgfCAxNiArKysrKysrKy0tLS0t
LS0tDQo+ID4gIGFyY2gvcmlzY3YvY29uZmlncy9kZWZjb25maWcgICAgICB8IDI0ICsrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICBhcmNoL3Jpc2N2L2NvbmZpZ3MvcnYzMl9kZWZjb25maWcg
fCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgYXJjaC9yaXNjdi9tbS9pbml0LmMg
ICAgICAgICAgICAgIHwgMzINCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICA0IGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo=
