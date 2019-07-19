Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ACCC76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303C02084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CJK4CkMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfGSI3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:29:17 -0400
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:31974
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfGSI3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHY3K///pjGcovOZWf9ZWZsTQxz6ljxUntuHd56fkQLmO12KMrSeuWpR1Y6ov8Je8P2XArtq9wv+7Ogl8ESmH0uxN5ejY6u21d4cn7UQys99R2Iq7Snp/89J5psf5ORlmNa9hvWQ7QfZLWG9PRpagtgcsui0EIbUK10O21QFPolmoSIcksUW5GB4TB4X6KDhRXoO24hVQ5By6BV7V4E3ep9JybXMCWFygJ3e6kJ6sZXO+ZbCRmHxB/8ZTYw6M/IE3iAoR3AWbr8Us2QQDcgu277jrw6+KwU2m04VgXnfz6ZFQXx2T4LYaZSpUddGv/8F0LismKrVG7kVsH/jD1P9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t8zsQYVYLc7h12Wr3Uv8AP1AAPMrNLT1UDpGGAHKOA=;
 b=cSjxTdK2nfYbY/j/voPu1QZWMjgq6juWpIdRrq/Z98wpami/0+iQMXETpKs2mW5iUZ8O9Ek0pEZKraQ+XCHwDdAhvKmd7dbVrZ7jRtBxmpR4E+kyiADtk+Ug2p6+XetashGuZbxKheaGRTC+nzk/OMO63nfPj6eKHu1a4eC0aCWuheDvJUiQw3/8T9y84Fo6tXQnlE+y/bbj7Zj/kWTWSGTsql7pu7Tak8PDNqebInaWeM20H9lzx1ToJxuSp077BzV+xyPioVwVPqEIQZ9W9QXnpnChIub0jz0t9gu3ZH3MLr9wGvFOk/ZmOcxU/jp8N/irVUHNEgLbvAYT6B3kow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t8zsQYVYLc7h12Wr3Uv8AP1AAPMrNLT1UDpGGAHKOA=;
 b=CJK4CkMYTd/6wI5+FpzgGs9DpTRFQ6T5t2vA6cJ2Vi9CieH9GeQjuX/3DZsjVBHOzG1i7K1iM3MziLNnEkrsBmoikNCS3uBv1fTiAhIMOAb3Vl2zQr6yUnPCulOgqB4+m+O/0VrBb07Ym909Tq9JaHAAYpzIBv0YJS5EYjGGkW8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 19 Jul 2019 08:29:12 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::6553:8d04:295c:774b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::6553:8d04:295c:774b%5]) with mapi id 15.20.2094.011; Fri, 19 Jul 2019
 08:29:12 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Will Deacon <will@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        Frank Li <frank.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: RE: [PATCH] perf tool: arch: arm64: change the way for
 get_cpuid_str() function
Thread-Topic: [PATCH] perf tool: arch: arm64: change the way for
 get_cpuid_str() function
Thread-Index: AQHVPTEJbljaEfwA1kmeHm0+nYaIVKbRlBkAgAABS4A=
Date:   Fri, 19 Jul 2019 08:29:12 +0000
Message-ID: <DB7PR04MB4618EE69C2D8A664660C19C4E6CB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190718061853.10403-1-qiangqing.zhang@nxp.com>
 <20190719075450.xcm4i4a5sfaxlfap@willie-the-truck>
In-Reply-To: <20190719075450.xcm4i4a5sfaxlfap@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4adcc96f-c1bb-4bbd-5df3-08d70c232dd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4490;
x-ms-traffictypediagnostic: DB7PR04MB4490:
x-microsoft-antispam-prvs: <DB7PR04MB4490112DE1F79E81EF514331E6CB0@DB7PR04MB4490.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(189003)(199004)(13464003)(486006)(14454004)(256004)(86362001)(2906002)(305945005)(476003)(8936002)(53936002)(54906003)(102836004)(11346002)(7696005)(6246003)(81156014)(446003)(316002)(66066001)(25786009)(478600001)(55016002)(6436002)(71200400001)(71190400001)(6506007)(66556008)(5660300002)(4326008)(52536014)(66476007)(26005)(99286004)(66946007)(64756008)(66446008)(229853002)(186003)(6916009)(33656002)(68736007)(9686003)(76176011)(6116002)(3846002)(81166006)(53546011)(8676002)(7736002)(76116006)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4490;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GcyudvL4L1mwE8DhhZPyoLnl+0uBPOF0LbgjKeFiCsWecbhuFNkeg55Y8SUPSSY/jC3mU+zvfmaX5WQiGLJ8HfZC2L812gaxGgmMKNW447EHyZsGcGmZnbS325SxhVginuDqUPBDKhg1cVloAk4Ou0j8gcdw9Huge15zIbcEQbhaX3zJe90TPaEVOixwpa6fyiPhm3GNBPjWCboxMst9D9Axpi+CSfukjSirmyqCYz9DYEHVtR0BCZHkgJ7XBpxUoh/CsmXjDDfWUZGhx9bBa+AzssHNyMXwUxS/sYjUg1399fKBiDGgsPzsuFfj6J4fQR3xKXbbrgzPpJjKMs1snmA86vxSFkxcTZzaodO8INY7bbb7CKKgXPSQKIP3/n+oekvnmd4TRXrpUGz6HhhdNNau55qkdL4KmfFJ8Bqyqu0=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adcc96f-c1bb-4bbd-5df3-08d70c232dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 08:29:12.6833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qiangqing.zhang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdpbGwgRGVhY29uIDx3aWxs
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMTnE6jfUwjE5yNUgMTU6NTUNCj4gVG86IEpvYWtpbSBa
aGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+IENjOiBwZXRlcnpAaW5mcmFkZWFkLm9y
ZzsgbWluZ29AcmVkaGF0LmNvbTsgYWNtZUBrZXJuZWwub3JnOw0KPiBqb2xzYUByZWRoYXQuY29t
OyBuYW1oeXVuZ0BrZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47DQo+IGRs
LWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwZXJm
IHRvb2w6IGFyY2g6IGFybTY0OiBjaGFuZ2UgdGhlIHdheSBmb3IgZ2V0X2NwdWlkX3N0cigpDQo+
IGZ1bmN0aW9uDQo+IA0KPiBPbiBUaHUsIEp1bCAxOCwgMjAxOSBhdCAwNjoyMTozMEFNICswMDAw
LCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4gTm93IHRoZSBnZXRfY3B1aWRfX3N0ciBmdW5jdGlv
biByZXR1cm5zIHRoZSBNSURSIHN0cmluZyBvZiB0aGUgZmlyc3QNCj4gPiBvbmxpbmUgY3B1IGZy
b20gdGhlIHJhbmdlIG9mIGNwdXMgYXNzY29jaWF0ZWQgd2l0aCB0aGUgUE1VIENPUkUgZGV2aWNl
Lg0KPiA+DQo+ID4gSXQgY2FuIHdvcmsgd2hlbiBwYXNzIGEgcGVyZl9wbXUgZW50aXR5IHRvIGdl
dF9jcHVpZF9zdHIuIEhvd2V2ZXIsIGl0DQo+ID4gd2lsbCBwYXNzIE5VTEwgdmlhIHBlcmZfcG11
X19maW5kX21hcCBmcm9tIG1ldHJpY2dyb3VwLmMgaWYgd2Ugd2FudCB0bw0KPiA+IGFkZCBtZXRy
aWMgZ3JvdXAgZm9yIGFybTY0LiBXaGVuIHBhc3MgTlVMTCB0byBnZXRfY3B1aWRfc3RyLCBpdCBj
YW4ndA0KPiA+IHJldHVybiB0aGUgTUlEUiBzdHJpbmcuDQo+IA0KPiBXaHkgaXMgdGhpcyBjb2Rl
IHBhc3NpbmcgYSBOVUxMIFBNVT8gV2hhdCBpbmZvcm1hdGlvbiBkb2VzIGl0IGFjdHVhbGx5IG5l
ZWQ/DQo+IE90aGVyIGZ1bmN0aW9ucywgc3VjaCBhcyBwcmludF9wbXVfZXZlbnRzKCksIGl0ZXJh
dGUgb3ZlciBhbGwgUE1Vcy4NCg0KSGkgV2lsbCwNCg0KdG9vbHMvcGVyZi91dGlscy9tZXRyaWNn
cm91cC5jOg0KbWV0cmljZ3JvdXBfX2FkZF9tZXRyaWMoKS9tZXRyaWNncm91cF9faGFzX21ldHJp
YygpL21ldHJpY2dyb3VwX19wcmludCgpLS0tLT5wZXJmX3BtdV9fZmluZF9tYXAoTlVMTCktLS0t
LS0+cGVyZl9wbXVfX2dldGNwdWlkKE5VTEwpLS0tLS0+Z2V0X2NwdWlkX3N0cihOVUxMKQ0KU28s
IGl0IHdpbGwgZXZlbnR1YWxseSBwYXNzIE5VTEwgdG8gZ2V0X2NwdWlkX3N0cigpIGZ1bmN0aW9u
IGZvciBhcm02NCwgYW5kIG5vdyBnZXRfY3B1aWRfc3RyKCkgZm9yIGFybTY0IG5lZWQgKnN0cnVj
dCBwZXJmX3BtdSogZW50aXR5IHRvIHJldHVybiBNSURSIHN0cmluZy4NCg0KQW5kIHRoZSBkZWNs
YXJhdGlvbiBmb3IgZ2V0X2NwdWlkX3N0cigpIGlzIGNoYXIgKmdldF9jcHVpZF9zdHIoc3RydWN0
IHBlcmZfcG11ICpwbXUgX19tYXliZV91bnVzZWQpIGluIHRvb2xzL3BlcmYvdXRpbHMvaGVhZGVy
LmggZmlsZS4NClNvLCBpdCBjYW4gcmV0dXJuIE1JRFIgc3RyaW5nIHdpdGhvdXQgcGFzc2luZyAq
c3RydWN0IHBlcmZfcG11KiBlbnRpdHkuIEFyY2ggUG93ZXJQQy94ODYvczM5MCB3aGljaCBpbXBs
ZW1lbnQgbWV0cmljZ3JvdXAgYWxsIGFkZCBfX21heWJlX3VudXNlZC4NCg0KPiA+IFRoZXJlIGFy
ZSB0aHJlZSBtZXRob2RzIGZyb20gdXNlcnNwYWNlIGdldHRpbmcgTUlEUiBzdHJpbmcgZm9yIGFy
bTY0Og0KPiA+IDEuIHBhcnNlDQo+ID4gc3lzZnMoL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1
Py9yZWdzL2lkZW50aWZpY2F0aW9uL21pZHJfZWwxKQ0KPiA+IDIuIHBhcnNlIHByb2NmcygvcHJv
Yy9jcHVpbmZvKQ0KPiA+IDMuIHJlYWQgdGhlIGh3Y2FwcyhNSURSIHJlZ2lzdGVyKSB3aXRoIGdl
dGF1eHZhbChBVF9IV0NBUCkNCj4gPg0KPiA+IFBlcmZlciB0byBzZWxlY3QgIzMgYXMgaXQgaXMg
bW9yZSBzaW1wbGUgYW5kIGRpcmVjdC4NCj4gDQo+IFRoYXQncyBwcm9iYWJseSB0ZXJtaW5hbGx5
IGJyb2tlbiBmb3IgaGV0ZXJvZ2VuZW91cyBzeXN0ZW1zLCBzbyBJJ20gbm90IGF0IGFsbA0KPiBo
YXBweSB3aXRoIHRoaXMgcGF0Y2guDQoNClRoZSBpbXBsZW1lbnQgb2YgZ2V0X2NwdWlkX3N0cigp
IGZvciBhcm02NCBub3cgb25seSBjYW4gcmV0dXJuIHRoZSBNSURSIHN0cmluZyBvZiB0aGUgZmly
c3Qgb25saW5lIGNwdS4gSSB0aGluayBpdCBpcyBhbHNvIGJyb2tlbiBmb3IgaGV0ZXJvZ2VuZW91
cyBzeXN0ZW1zLg0KDQpXaWxsLCBkbyB5b3Uga25vdyBob3cgdG8gZml4IHRoaXMgaXNzdWUgbW9y
ZSByZWFzb25hYmxlPw0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gV2lsbA0KPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9hcmNoL2FybTY0L3V0aWwvaGVhZGVyLmMNCj4g
PiBiL3Rvb2xzL3BlcmYvYXJjaC9hcm02NC91dGlsL2hlYWRlci5jDQo+ID4gaW5kZXggNTM0Y2Qy
NTA3ZDgzLi5mNThmMDhhZjBiZTggMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVyZi9hcmNoL2Fy
bTY0L3V0aWwvaGVhZGVyLmMNCj4gPiArKysgYi90b29scy9wZXJmL2FyY2gvYXJtNjQvdXRpbC9o
ZWFkZXIuYw0KPiA+IEBAIC0yLDY0ICsyLDQ2IEBADQo+ID4gICNpbmNsdWRlIDxzdGRsaWIuaD4N
Cj4gPiAgI2luY2x1ZGUgPGFwaS9mcy9mcy5oPg0KPiA+ICAjaW5jbHVkZSAiaGVhZGVyLmgiDQo+
ID4gKyNpbmNsdWRlIDxhc20vaHdjYXAuaD4NCj4gPiArI2luY2x1ZGUgPHN5cy9hdXh2Lmg+DQo+
ID4NCj4gPiAtI2RlZmluZSBNSURSICIvcmVncy9pZGVudGlmaWNhdGlvbi9taWRyX2VsMSINCj4g
PiAgI2RlZmluZSBNSURSX1NJWkUgMTkNCj4gPiAgI2RlZmluZSBNSURSX1JFVklTSU9OX01BU0sg
ICAgICAweGYNCj4gPiAgI2RlZmluZSBNSURSX1ZBUklBTlRfU0hJRlQgICAgICAyMA0KPiA+ICAj
ZGVmaW5lIE1JRFJfVkFSSUFOVF9NQVNLICAgICAgICgweGYgPDwgTUlEUl9WQVJJQU5UX1NISUZU
KQ0KPiA+DQo+ID4gLWNoYXIgKmdldF9jcHVpZF9zdHIoc3RydWN0IHBlcmZfcG11ICpwbXUpDQo+
ID4gKyNkZWZpbmUgZ2V0X2NwdWlkKGlkKSAoewkJCQkJXA0KPiA+ICsJCXVuc2lnbmVkIGxvbmcg
X192YWw7CQkJCVwNCj4gPiArCQlhc20oIm1ycyAlMCwgIiNpZCA6ICI9ciIgKF9fdmFsKSk7CQlc
DQo+ID4gKwkJX192YWw7CQkJCQkJXA0KPiA+ICsJfSkNCj4gPiArDQo+ID4gK2NoYXIgKmdldF9j
cHVpZF9zdHIoc3RydWN0IHBlcmZfcG11ICpwbXUgX19tYXliZV91bnVzZWQpDQo+ID4gIHsNCj4g
PiAgCWNoYXIgKmJ1ZiA9IE5VTEw7DQo+ID4gLQljaGFyIHBhdGhbUEFUSF9NQVhdOw0KPiA+IC0J
Y29uc3QgY2hhciAqc3lzZnMgPSBzeXNmc19fbW91bnRwb2ludCgpOw0KPiA+IC0JaW50IGNwdTsN
Cj4gPiAtCXU2NCBtaWRyID0gMDsNCj4gPiAtCXN0cnVjdCBjcHVfbWFwICpjcHVzOw0KPiA+IC0J
RklMRSAqZmlsZTsNCj4gPiArCXVuc2lnbmVkIGxvbmcgbWlkciA9IDA7DQo+ID4NCj4gPiAtCWlm
ICghc3lzZnMgfHwgIXBtdSB8fCAhcG11LT5jcHVzKQ0KPiA+ICsJaWYgKCEoZ2V0YXV4dmFsKEFU
X0hXQ0FQKSAmIEhXQ0FQX0NQVUlEKSkgew0KPiA+ICsJCWZwdXRzKCJDUFVJRCByZWdpc3RlcnMg
dW5hdmFpbGFibGVcbiIsIHN0ZGVycik7DQo+ID4gIAkJcmV0dXJuIE5VTEw7DQo+ID4gKwl9DQo+
ID4NCj4gPiAtCWJ1ZiA9IG1hbGxvYyhNSURSX1NJWkUpOw0KPiA+IC0JaWYgKCFidWYpDQo+ID4g
KwltaWRyID0gZ2V0X2NwdWlkKE1JRFJfRUwxKTsNCj4gPiArCWlmICghbWlkcikgew0KPiA+ICsJ
CWZwdXRzKCJGYWlsZWQgdG8gZ2V0IGNwdWlkIHN0cmluZ1xuIiwgc3RkZXJyKTsNCj4gPiAgCQly
ZXR1cm4gTlVMTDsNCj4gPiArCX0NCj4gPg0KPiA+IC0JLyogcmVhZCBtaWRyIGZyb20gbGlzdCBv
ZiBjcHVzIG1hcHBlZCB0byB0aGlzIHBtdSAqLw0KPiA+IC0JY3B1cyA9IGNwdV9tYXBfX2dldChw
bXUtPmNwdXMpOw0KPiA+IC0JZm9yIChjcHUgPSAwOyBjcHUgPCBjcHVzLT5ucjsgY3B1KyspIHsN
Cj4gPiAtCQlzY25wcmludGYocGF0aCwgUEFUSF9NQVgsICIlcy9kZXZpY2VzL3N5c3RlbS9jcHUv
Y3B1JWQiTUlEUiwNCj4gPiAtCQkJCXN5c2ZzLCBjcHVzLT5tYXBbY3B1XSk7DQo+ID4gLQ0KPiA+
IC0JCWZpbGUgPSBmb3BlbihwYXRoLCAiciIpOw0KPiA+IC0JCWlmICghZmlsZSkgew0KPiA+IC0J
CQlwcl9kZWJ1ZygiZm9wZW4gZmFpbGVkIGZvciBmaWxlICVzXG4iLCBwYXRoKTsNCj4gPiAtCQkJ
Y29udGludWU7DQo+ID4gLQkJfQ0KPiA+IC0NCj4gPiAtCQlpZiAoIWZnZXRzKGJ1ZiwgTUlEUl9T
SVpFLCBmaWxlKSkgew0KPiA+IC0JCQlmY2xvc2UoZmlsZSk7DQo+ID4gLQkJCWNvbnRpbnVlOw0K
PiA+IC0JCX0NCj4gPiAtCQlmY2xvc2UoZmlsZSk7DQo+ID4gKwkvKiBJZ25vcmUvY2xlYXIgVmFy
aWFudFsyMzoyMF0gYW5kDQo+ID4gKwkgKiBSZXZpc2lvblszOjBdIG9mIE1JRFINCj4gPiArCSAq
Lw0KPiA+ICsJbWlkciAmPSAofihNSURSX1ZBUklBTlRfTUFTSyB8IE1JRFJfUkVWSVNJT05fTUFT
SykpOw0KPiA+DQo+ID4gLQkJLyogSWdub3JlL2NsZWFyIFZhcmlhbnRbMjM6MjBdIGFuZA0KPiA+
IC0JCSAqIFJldmlzaW9uWzM6MF0gb2YgTUlEUg0KPiA+IC0JCSAqLw0KPiA+IC0JCW1pZHIgPSBz
dHJ0b3VsKGJ1ZiwgTlVMTCwgMTYpOw0KPiA+IC0JCW1pZHIgJj0gKH4oTUlEUl9WQVJJQU5UX01B
U0sgfCBNSURSX1JFVklTSU9OX01BU0spKTsNCj4gPiAtCQlzY25wcmludGYoYnVmLCBNSURSX1NJ
WkUsICIweCUwMTZseCIsIG1pZHIpOw0KPiA+IC0JCS8qIGdvdCBtaWRyIGJyZWFrIGxvb3AgKi8N
Cj4gPiAtCQlicmVhazsNCj4gPiAtCX0NCj4gPiArCWJ1ZiA9IG1hbGxvYyhNSURSX1NJWkUpOw0K
PiA+ICsJaWYgKCFidWYpDQo+ID4gKwkJcmV0dXJuIE5VTEw7DQo+ID4NCj4gPiAtCWlmICghbWlk
cikgew0KPiA+IC0JCXByX2VycigiZmFpbGVkIHRvIGdldCBjcHVpZCBzdHJpbmcgZm9yIFBNVSAl
c1xuIiwgcG11LT5uYW1lKTsNCj4gPiAtCQlmcmVlKGJ1Zik7DQo+ID4gLQkJYnVmID0gTlVMTDsN
Cj4gPiAtCX0NCj4gPiArCXNjbnByaW50ZihidWYsIE1JRFJfU0laRSwgIjB4JTAxNmx4IiwgbWlk
cik7DQo+ID4NCj4gPiAtCWNwdV9tYXBfX3B1dChjcHVzKTsNCj4gPiAgCXJldHVybiBidWY7DQo+
ID4gIH0NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
