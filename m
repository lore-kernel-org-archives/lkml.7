Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E63C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CC62075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X1/D3Drl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dWWNoX0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKZWCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:02:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10853 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfKZWCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574805756; x=1606341756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8wt1pdNoYu14OWF5hXcuzrfHSj80P1Zy09AUuFDqlO8=;
  b=X1/D3Drl3x6hD7+t8xbLnn9ThqYjhf9ZwZf9Ii+KHRpHQ7WYpdhmVbd6
   lpViCR6wS9aaouJWGGkIYTV2RTAca2QZFMaZNkWCybt04/A9DqwlnAHh9
   65sh3C+KflHJStiG/1mJyalkPI/tdm2Upirwdrak//JzfkrzvSONGokrb
   pzeBP8w4KwwRnRk5MCB/jmsSD6fmrTEAhLGLeFzQY7EapVhdCB52qhvBd
   bla3gPY7iPfdDnoP9gyWAbcYZxECzi/GR5HUeytWIgjWLHb0QBIe2PLdx
   QRzfMK7SYrZyN409uv9/mTeaFANuKktF7rRm/9mXLJzX5/rUeYNi30Xzm
   Q==;
IronPort-SDR: UopeLc8NmMy80mhgKoajvmEspQpQUz8vp2BV6nw2utc6tVAEWiNEtldzIbb+cD/mcDlds9QdOM
 X+AOn6abCTyFjLW0m0De1y5rSPvzSQUB1tepqhF5+dTbbGbnlqk+7w8naCxS1Q27Z1PXSDci1X
 9OKOXnkV8p8HfU2UMsYF5X2UnapK54Xv/v9jmTjGfmppwIp5eMfIc3N7rcGBOQyawi+8Ve3oZA
 e7gZilwSsdqe9jjKv7poA7t2CZvXBivS+dM9BTfZ9mK8TSc6avojGBX1WweCX39bCmX+EQqwiD
 GHI=
X-IronPort-AV: E=Sophos;i="5.69,247,1571673600"; 
   d="scan'208";a="231510487"
Received: from mail-co1nam05lp2056.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.56])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2019 06:02:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSP7bYK+IJ0vkfXyqleBcLu7iBWkio7nYVFVGq+OFhXV3T7CMY8yvpDvUB3G2/XATNKXUCPm5FWtzbSDIPhYJiUR3DemUTSdyaG+ZLBssLVqUaUUYgCQQNrjS1f0i9/dqimVILYNAD10Q5VqZFG0skimnDRldnv6K+Jx9tnsUZVBtQsq3P3U+oq/LmpF05+/mLk7ryGlQXMlB0kIP3GQylUS3M2fiM52KzOgXhgA3whf1DHR64uraoVAXL8anq8Njz9HGToN2WUW7sEYcyGoZDiPAhg9t4IZj8gZdoiupHFEf/LSDu/1EhWRzqFKr/IPifI9Am27ScUpRoBYdOuAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wt1pdNoYu14OWF5hXcuzrfHSj80P1Zy09AUuFDqlO8=;
 b=S1e7L4ggULsY0SzgtHUReMvB58ldkQdQKU7uzAeeiG5LQwhfFpQyk+xFpKkeyqxMdoip/f6BVIuQUbYRf/XrV2LPX9pFtIvzg6tCNRcDdsiUeTbPTRdsCAHAMIaoZIvvajFkxgHU77LPQrmEgS6Toca2Du0E9LgZydt4G+yN9msQdiKlR0jkBLm9c8boER+bgwG37XvlbTZ9opV7u/uI51w0JdibxlVYvpFdvM+e5bEzefaJx6gg8rF35831H4cbMTAj5IFA/HjPUoB/zJWBrw5GtsU8hM+QwnRN1WMcOSxCZJg7goo6hTyKHMqjCoJ03wANb0QUzUHWK7jZRGwqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wt1pdNoYu14OWF5hXcuzrfHSj80P1Zy09AUuFDqlO8=;
 b=dWWNoX0Ml8h6LRGPTCWutPnD4PpKI1P3wl15qxWaJMTVDE0fJ6n7Y8DZ5XtXl0kqiYXEFWPrJEYMeLZMocpPnrK+lWFMunMlApwo2jpMoIo7a8vSc1+jWws8BMOCbhTvTrK//EIr6RTNCUxQsPGQ8RWZ0jL5q+91R8cKkYrHshA=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4853.namprd04.prod.outlook.com (52.135.235.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 22:02:20 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::1d22:29b6:df03:86f7]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::1d22:29b6:df03:86f7%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 22:02:20 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "merker@debian.org" <merker@debian.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] RISC-V: Typo fixes in image header and documentation.
Thread-Topic: [PATCH] RISC-V: Typo fixes in image header and documentation.
Thread-Index: AQHVfj3d560TKs0IR0WrAqV4kt8gy6eeTdyA
Date:   Tue, 26 Nov 2019 22:02:20 +0000
Message-ID: <4912c007ab6c19321c8c988ae2328efbfb3e582d.camel@wdc.com>
References: <20191009010637.9955-1-atish.patra@wdc.com>
In-Reply-To: <20191009010637.9955-1-atish.patra@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7237932-4de7-440e-8367-08d772bc4f34
x-ms-traffictypediagnostic: BYAPR04MB4853:
x-microsoft-antispam-prvs: <BYAPR04MB48535FA0D376CC0D1C6ED6B4FA450@BYAPR04MB4853.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(6246003)(2351001)(14454004)(2616005)(2501003)(71190400001)(71200400001)(478600001)(2906002)(5640700003)(446003)(305945005)(102836004)(6512007)(7736002)(118296001)(36756003)(25786009)(229853002)(66066001)(6436002)(4326008)(6506007)(66556008)(64756008)(66446008)(66476007)(76116006)(66946007)(81166006)(14444005)(81156014)(186003)(256004)(76176011)(3846002)(6916009)(8936002)(6116002)(8676002)(26005)(316002)(11346002)(99286004)(6486002)(54906003)(86362001)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4853;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ql4wVv0Wxo3mhNJ9aHePtoPLgvzBvSL10FkspuTTe6eejgQ1Xvz6Zt82S/MI78K2hAIqvld1ukPWw9D8bSyFbL7e6L7SIKPxtmPfN8Hb21nhVl7NFtZ0XF8deBwBM4kx4pHC6r2qZWrVEEnbO+p+BvWFSK6ZwjdseAGfDcCkoyF/f2bNeMy0XmVoYp4RrNoTR9pnOHvAP9CUK9zTq8/XwlDwSD58LB+Wl9cUUqbX5TBdOwrxcJ4XeaO9NYyv9I5xbVfLic8hhqj+Wz62ljq0l6Re626S2PyybpjPrq0/5MEkvV0brQQhoAe4BWuVml4u6VjsCyM415X6mmPZVtKosINkynidCKqJD0ReTbnUV5xD9AhCBEA02xIiRWJoL4ghYIcyI3oy+do+1hIG373ncu+7PUFz5Pd807LI3I01k5d+AVVq1Z8tM99ewY5xjmXP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A4DEBF2E173ED489A8C80BDBDCEEAA1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7237932-4de7-440e-8367-08d772bc4f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 22:02:20.2775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XqeyGfG1izmQUGe91aBbTqe5FRa0cU/CpyqJsqkZ2/REcptZIitCxSbxsx/0xUheQZn2bMYUj2L2VKxjbScmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTA4IGF0IDE4OjA2IC0wNzAwLCBBdGlzaCBQYXRyYSB3cm90ZToNCj4g
VGhlcmUgYXJlIHNvbWUgdHlwb3MgaW4gYm9vdCBpbWFnZSBoZWFkZXIgYW5kIHJpc2N2IGJvb3QN
Cj4gZG9jdW1lbnRhdGlvbi4NCj4gDQo+IEZpeCB0aGUgdHlwb3MuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVu
dGF0aW9uL3Jpc2N2L2Jvb3QtaW1hZ2UtaGVhZGVyLnJzdCB8IDQgKystLQ0KPiAgYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS9pbWFnZS5oICAgICAgICAgICAgfCA0ICsrLS0NCj4gIDIgZmlsZXMgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vcmlzY3YvYm9vdC1pbWFnZS1oZWFkZXIucnN0DQo+IGIvRG9jdW1lbnRh
dGlvbi9yaXNjdi9ib290LWltYWdlLWhlYWRlci5yc3QNCj4gaW5kZXggN2I0ZDFkNzQ3NTg1Li44
ZWZiMDU5NmEzM2YgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vcmlzY3YvYm9vdC1pbWFn
ZS1oZWFkZXIucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vcmlzY3YvYm9vdC1pbWFnZS1oZWFk
ZXIucnN0DQo+IEBAIC0yMiw3ICsyMiw3IEBAIFRoZSBmb2xsb3dpbmcgNjQtYnl0ZSBoZWFkZXIg
aXMgcHJlc2VudCBpbg0KPiBkZWNvbXByZXNzZWQgTGludXgga2VybmVsIGltYWdlOjoNCj4gIAl1
NjQgcmVzMiA9IDA7CQkgIC8qIFJlc2VydmVkICovDQo+ICAJdTY0IG1hZ2ljID0gMHg1NjQzNTM0
OTUyOyAvKiBNYWdpYyBudW1iZXIsIGxpdHRsZSBlbmRpYW4sDQo+ICJSSVNDViIgKi8NCj4gIAl1
MzIgbWFnaWMyID0gMHg1NjUzNDkwNTsgIC8qIE1hZ2ljIG51bWJlciAyLCBsaXR0bGUgZW5kaWFu
LA0KPiAiUlNDXHgwNSIgKi8NCj4gLQl1MzIgcmVzNDsJCSAgLyogUmVzZXJ2ZWQgZm9yIFBFIENP
RkYgb2Zmc2V0ICovDQo+ICsJdTMyIHJlczM7CQkgIC8qIFJlc2VydmVkIGZvciBQRSBDT0ZGIG9m
ZnNldCAqLw0KPiAgDQo+ICBUaGlzIGhlYWRlciBmb3JtYXQgaXMgY29tcGxpYW50IHdpdGggUEUv
Q09GRiBoZWFkZXIgYW5kIGxhcmdlbHkNCj4gaW5zcGlyZWQgZnJvbQ0KPiAgQVJNNjQgaGVhZGVy
LiBUaHVzLCBib3RoIEFSTTY0ICYgUklTQy1WIGhlYWRlciBjYW4gYmUgY29tYmluZWQgaW50bw0K
PiBvbmUgY29tbW9uDQo+IEBAIC0zNCw3ICszNCw3IEBAIE5vdGVzDQo+ICAtIFRoaXMgaGVhZGVy
IGNhbiBhbHNvIGJlIHJldXNlZCB0byBzdXBwb3J0IEVGSSBzdHViIGZvciBSSVNDLVYgaW4NCj4g
ZnV0dXJlLiBFRkkNCj4gICAgc3BlY2lmaWNhdGlvbiBuZWVkcyBQRS9DT0ZGIGltYWdlIGhlYWRl
ciBpbiB0aGUgYmVnaW5uaW5nIG9mIHRoZQ0KPiBrZXJuZWwgaW1hZ2UNCj4gICAgaW4gb3JkZXIg
dG8gbG9hZCBpdCBhcyBhbiBFRkkgYXBwbGljYXRpb24uIEluIG9yZGVyIHRvIHN1cHBvcnQgRUZJ
DQo+IHN0dWIsDQo+IC0gIGNvZGUwIHNob3VsZCBiZSByZXBsYWNlZCB3aXRoICJNWiIgbWFnaWMg
c3RyaW5nIGFuZCByZXM1KGF0IG9mZnNldA0KPiAweDNjKSBzaG91bGQNCj4gKyAgY29kZTAgc2hv
dWxkIGJlIHJlcGxhY2VkIHdpdGggIk1aIiBtYWdpYyBzdHJpbmcgYW5kIHJlczMoYXQgb2Zmc2V0
DQo+IDB4M2MpIHNob3VsZA0KPiAgICBwb2ludCB0byB0aGUgcmVzdCBvZiB0aGUgUEUvQ09GRiBo
ZWFkZXIuDQo+ICANCj4gIC0gdmVyc2lvbiBmaWVsZCBpbmRpY2F0ZSBoZWFkZXIgdmVyc2lvbiBu
dW1iZXINCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vaW1hZ2UuaA0KPiBi
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vaW1hZ2UuaA0KPiBpbmRleCAzNDRkYjUyNDQ1NDcuLjRm
ODA2MWE1YWM0YSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9pbWFnZS5o
DQo+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vaW1hZ2UuaA0KPiBAQCAtNDIsNyArNDIs
NyBAQA0KPiAgICogQHJlczI6CQlyZXNlcnZlZA0KPiAgICogQG1hZ2ljOgkJTWFnaWMgbnVtYmVy
IChSSVNDLVYgc3BlY2lmaWM7IGRlcHJlY2F0ZWQpDQo+ICAgKiBAbWFnaWMyOgkJTWFnaWMgbnVt
YmVyIDIgKHRvIG1hdGNoIHRoZSBBUk02NCAnbWFnaWMnDQo+IGZpZWxkIHBvcykNCj4gLSAqIEBy
ZXM0OgkJcmVzZXJ2ZWQgKHdpbGwgYmUgdXNlZCBmb3IgUEUgQ09GRiBvZmZzZXQpDQo+ICsgKiBA
cmVzMzoJCXJlc2VydmVkICh3aWxsIGJlIHVzZWQgZm9yIFBFIENPRkYgb2Zmc2V0KQ0KPiAgICoN
Cj4gICAqIFRoZSBpbnRlbnRpb24gaXMgZm9yIHRoaXMgaGVhZGVyIGZvcm1hdCB0byBiZSBzaGFy
ZWQgYmV0d2VlbnJlczQNCj4gbXVsdGlwbGUNCj4gICAqIGFyY2hpdGVjdHVyZXMgdG8gYXZvaWQg
YSBwcm9saWZlcmF0aW9uIG9mIGltYWdlIGhlYWRlciBmb3JtYXRzLg0KPiBAQCAtNTksNyArNTks
NyBAQCBzdHJ1Y3QgcmlzY3ZfaW1hZ2VfaGVhZGVyIHsNCj4gIAl1NjQgcmVzMjsNCj4gIAl1NjQg
bWFnaWM7DQo+ICAJdTMyIG1hZ2ljMjsNCj4gLQl1MzIgcmVzNDsNCj4gKwl1MzIgcmVzMzsNCj4g
IH07DQo+ICAjZW5kaWYgLyogX19BU1NFTUJMWV9fICovDQo+ICAjZW5kaWYgLyogX19BU01fSU1B
R0VfSCAqLw0KDQpwaW5nID8NCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
