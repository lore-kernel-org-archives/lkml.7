Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFABC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B09F2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ae7z37RK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfFFWqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:46:08 -0400
Received: from mail-eopbgr800045.outbound.protection.outlook.com ([40.107.80.45]:26064
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbfFFWqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hb2o6DI3N5Dpf7tzFqoqfokGKNOSCbgRYpNXXqjnnQ=;
 b=ae7z37RK8F0YHcGX9oepZFiwuqsYDdr2ODZdouV2IhLxuHDkFteGqMKv2GXTGCey5gMiAoLsYKEl15l/JqVPrVTAjSdVlDQwyF1BKbr3jJ9Jw8OlfonXkoXMYXirqkRgKkkV2COlQoJJwXaknptkKlk4wvLIvsty286t/lB4n14=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4550.namprd05.prod.outlook.com (52.135.203.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 22:44:23 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 22:44:23 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 10/15] static_call: Add basic static call infrastructure
Thread-Topic: [PATCH 10/15] static_call: Add basic static call infrastructure
Thread-Index: AQHVG6Hind15VmKQ/km2cDlqpRtMGKaPO4AA
Date:   Thu, 6 Jun 2019 22:44:23 +0000
Message-ID: <DD54886F-77C6-4230-A711-BF10DD44C52C@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.125037517@infradead.org>
In-Reply-To: <20190605131945.125037517@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee6401ad-fefc-4a0a-4bdf-08d6ead085d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4550;
x-ms-traffictypediagnostic: BYAPR05MB4550:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR05MB4550232837C412BA0E2544D6D0170@BYAPR05MB4550.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(51444003)(189003)(199004)(8936002)(3846002)(66446008)(7416002)(54906003)(81166006)(5660300002)(86362001)(2616005)(64756008)(73956011)(81156014)(478600001)(25786009)(66946007)(82746002)(76176011)(2906002)(256004)(14454004)(45080400002)(486006)(476003)(76116006)(66556008)(14444005)(11346002)(8676002)(71200400001)(316002)(83716004)(446003)(7736002)(91956017)(6246003)(71190400001)(305945005)(6512007)(4326008)(186003)(6116002)(33656002)(36756003)(53936002)(102836004)(229853002)(66066001)(6916009)(66476007)(6506007)(6306002)(6486002)(26005)(53546011)(6436002)(966005)(99286004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4550;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NSAAUG8Dxp6da6oivfKssfifN7W9YfXwYPykbDOLuRbjFQ9DYWeCrJVTzL8JZtUhdbpXmyLIrgbXmIL9MkCDGtg+lNEgCIYeQmCD66V31/aR2swf5DDoVYdLjUuGZCawFLUvdYEBSU7JkFLYOLSSn24fu6tpquWUL1P0n/71y8uaWOPfdnFUb5QptKlQEOM+F5hVN2SUiHauHPdnMSxlzY0fK3oOqGA11h8suqKZK7jG4hCDDyU3Beh7mOE91sb96K7a3aczvBC+6aGpf+WjZKZyPFW8/kXM9w4C8qw6xxK72ohmIZrH/4hf899Eed5r/5B7DkSRdpvD7NL0gPjnl+BxTkrtO9cBxENZ650NsUZY/g3BDXo7t5/KAxH/i7oeXJK/QNlP8yCg2gaegoEENtyt9kHW0y+4BEUw3y/1UZ4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8237A42BA9ED304A9198129878587FF0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6401ad-fefc-4a0a-4bdf-08d6ead085d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 22:44:23.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gNSwgMjAxOSwgYXQgNjowOCBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IEZyb206IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPg0KPiANCj4gU3RhdGljIGNhbGxzIGFyZSBhIHJlcGxhY2VtZW50IGZvciBnbG9i
YWwgZnVuY3Rpb24gcG9pbnRlcnMuICBUaGV5IHVzZQ0KPiBjb2RlIHBhdGNoaW5nIHRvIGFsbG93
IGRpcmVjdCBjYWxscyB0byBiZSB1c2VkIGluc3RlYWQgb2YgaW5kaXJlY3QNCj4gY2FsbHMuICBU
aGV5IGdpdmUgdGhlIGZsZXhpYmlsaXR5IG9mIGZ1bmN0aW9uIHBvaW50ZXJzLCBidXQgd2l0aA0K
PiBpbXByb3ZlZCBwZXJmb3JtYW5jZS4gIFRoaXMgaXMgZXNwZWNpYWxseSBpbXBvcnRhbnQgZm9y
IGNhc2VzIHdoZXJlDQo+IHJldHBvbGluZXMgd291bGQgb3RoZXJ3aXNlIGJlIHVzZWQsIGFzIHJl
dHBvbGluZXMgY2FuIHNpZ25pZmljYW50bHkNCj4gaW1wYWN0IHBlcmZvcm1hbmNlLg0KPiANCj4g
VGhlIGNvbmNlcHQgYW5kIGNvZGUgYXJlIGFuIGV4dGVuc2lvbiBvZiBwcmV2aW91cyB3b3JrIGRv
bmUgYnkgQXJkDQo+IEJpZXNoZXV2ZWwgYW5kIFN0ZXZlbiBSb3N0ZWR0Og0KPiANCj4gIGh0dHBz
Oi8vbmFtMDQuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxrbWwua2VybmVsLm9yZyUyRnIlMkYyMDE4MTAwNTA4MTMzMy4xNTAxOC0xLWFyZC5iaWVz
aGV1dmVsJTQwbGluYXJvLm9yZyZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2bXdhcmUuY29t
JTdDM2YyZWJiZWZmMTVlNDQ0ZDJmYTAwOGQ2ZTliOTAyM2YlN0NiMzkxMzhjYTNjZWU0YjRhYTRk
NmNkODNkOWRkNjJmMCU3QzAlN0MwJTdDNjM2OTUzMzc4MTgyNzY1MjI5JmFtcDtzZGF0YT1XSGNl
VFdWdCUyQk51MVJGQnY4akhwMlR3N1ZadUk1SHh2SHQlMkZyV25qQW1tNCUzRCZhbXA7cmVzZXJ2
ZWQ9MA0KPiAgaHR0cHM6Ly9uYW0wNC5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGbGttbC5rZXJuZWwub3JnJTJGciUyRjIwMTgxMDA2MDE1MTEwLjY1
Mzk0NjMwMCU0MGdvb2RtaXMub3JnJmFtcDtkYXRhPTAyJTdDMDElN0NuYW1pdCU0MHZtd2FyZS5j
b20lN0MzZjJlYmJlZmYxNWU0NDRkMmZhMDA4ZDZlOWI5MDIzZiU3Q2IzOTEzOGNhM2NlZTRiNGFh
NGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMCU3QzAlN0M2MzY5NTMzNzgxODI3NjUyMjkmYW1wO3NkYXRhPTEy
SmNyVXNPaDclMkZqUndFVjlBTkh3NVNBMkE2RDRxTko2ejNoNWFNSHBuRSUzRCZhbXA7cmVzZXJ2
ZWQ9MA0KPiANCj4gVGhlcmUgYXJlIHR3byBpbXBsZW1lbnRhdGlvbnMsIGRlcGVuZGluZyBvbiBh
cmNoIHN1cHBvcnQ6DQo+IA0KPiAxKSBvdXQtb2YtbGluZTogcGF0Y2hlZCB0cmFtcG9saW5lcyAo
Q09ORklHX0hBVkVfU1RBVElDX0NBTEwpDQo+IDIpIGJhc2ljIGZ1bmN0aW9uIHBvaW50ZXJzDQo+
IA0KPiBGb3IgbW9yZSBkZXRhaWxzLCBzZWUgdGhlIGNvbW1lbnRzIGluIGluY2x1ZGUvbGludXgv
c3RhdGljX2NhbGwuaC4NCj4gDQo+IENjOiB4ODZAa2VybmVsLm9yZw0KPiBDYzogU3RldmVuIFJv
c3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+IENjOiBKdWxpYSBDYXJ0d3JpZ2h0IDxqdWxp
YUBuaS5jb20+DQo+IENjOiBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz4NCj4gQ2M6IEFy
ZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPg0KPiBDYzogSmFzb24gQmFy
b24gPGpiYXJvbkBha2FtYWkuY29tPg0KPiBDYzogUmFzbXVzIFZpbGxlbW9lcyA8bGludXhAcmFz
bXVzdmlsbGVtb2VzLmRrPg0KPiBDYzogRGFuaWVsIEJyaXN0b3QgZGUgT2xpdmVpcmEgPGJyaXN0
b3RAcmVkaGF0LmNvbT4NCj4gQ2M6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3Vu
ZGF0aW9uLm9yZz4NCj4gQ2M6IEppcmkgS29zaW5hIDxqa29zaW5hQHN1c2UuY3o+DQo+IENjOiBF
ZHdhcmQgQ3JlZSA8ZWNyZWVAc29sYXJmbGFyZS5jb20+DQo+IENjOiBUaG9tYXMgR2xlaXhuZXIg
PHRnbHhAbGludXRyb25peC5kZT4NCj4gQ2M6IE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtl
cm5lbC5vcmc+DQo+IENjOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gQ2M6IERh
dmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QEFDVUxBQi5DT00+DQo+IENjOiBKZXNzaWNhIFl1IDxq
ZXl1QGtlcm5lbC5vcmc+DQo+IENjOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPiBD
YzogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQo+IENjOiAiSC4gUGV0ZXIgQW52
aW4iIDxocGFAenl0b3IuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb3NoIFBvaW1ib2V1ZiA8anBv
aW1ib2VAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVs
KSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IExpbms6IGh0dHBzOi8vbmFtMDQuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxrbWwua2VybmVsLm9y
ZyUyRnIlMkZhMDFmNzMzODg5ZWJmNGJjNDQ3NTA3YWI4MDQxYTYwMzc4ZWFhODlmLjE1NDcwNzM4
NDMuZ2l0Lmpwb2ltYm9lJTQwcmVkaGF0LmNvbSZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2
bXdhcmUuY29tJTdDM2YyZWJiZWZmMTVlNDQ0ZDJmYTAwOGQ2ZTliOTAyM2YlN0NiMzkxMzhjYTNj
ZWU0YjRhYTRkNmNkODNkOWRkNjJmMCU3QzAlN0MwJTdDNjM2OTUzMzc4MTgyNzY1MjI5JmFtcDtz
ZGF0YT1uNXdndSUyRnhOWmlHNzdFeEJjb1Qyd283YWs5eHF5ZkpIM0g4U015eFpqMzglM0QmYW1w
O3Jlc2VydmVkPTANCj4gLS0tDQo+IGFyY2gvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8
ICAgIDMgDQo+IGluY2x1ZGUvbGludXgvc3RhdGljX2NhbGwuaCAgICAgICB8ICAxMzUgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gaW5jbHVkZS9saW51eC9zdGF0aWNf
Y2FsbF90eXBlcy5oIHwgICAxMyArKysNCj4gMyBmaWxlcyBjaGFuZ2VkLCAxNTEgaW5zZXJ0aW9u
cygrKQ0KPiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9zdGF0aWNfY2FsbC5oDQo+
IGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3N0YXRpY19jYWxsX3R5cGVzLmgNCj4g
DQo+IC0tLSBhL2FyY2gvS2NvbmZpZw0KPiArKysgYi9hcmNoL0tjb25maWcNCj4gQEAgLTkyNyw2
ICs5MjcsOSBAQCBjb25maWcgTE9DS19FVkVOVF9DT1VOVFMNCj4gCSAgdGhlIGNoYW5jZSBvZiBh
cHBsaWNhdGlvbiBiZWhhdmlvciBjaGFuZ2UgYmVjYXVzZSBvZiB0aW1pbmcNCj4gCSAgZGlmZmVy
ZW5jZXMuIFRoZSBjb3VudHMgYXJlIHJlcG9ydGVkIHZpYSBkZWJ1Z2ZzLg0KPiANCj4gK2NvbmZp
ZyBIQVZFX1NUQVRJQ19DQUxMDQo+ICsJYm9vbA0KPiArDQo+IHNvdXJjZSAia2VybmVsL2djb3Yv
S2NvbmZpZyINCj4gDQo+IHNvdXJjZSAic2NyaXB0cy9nY2MtcGx1Z2lucy9LY29uZmlnIg0KPiAt
LS0gL2Rldi9udWxsDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc3RhdGljX2NhbGwuaA0KPiBAQCAt
MCwwICsxLDEzNSBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8N
Cj4gKyNpZm5kZWYgX0xJTlVYX1NUQVRJQ19DQUxMX0gNCj4gKyNkZWZpbmUgX0xJTlVYX1NUQVRJ
Q19DQUxMX0gNCj4gKw0KPiArLyoNCj4gKyAqIFN0YXRpYyBjYWxsIHN1cHBvcnQNCj4gKyAqDQo+
ICsgKiBTdGF0aWMgY2FsbHMgdXNlIGNvZGUgcGF0Y2hpbmcgdG8gaGFyZC1jb2RlIGZ1bmN0aW9u
IHBvaW50ZXJzIGludG8gZGlyZWN0DQo+ICsgKiBicmFuY2ggaW5zdHJ1Y3Rpb25zLiAgVGhleSBn
aXZlIHRoZSBmbGV4aWJpbGl0eSBvZiBmdW5jdGlvbiBwb2ludGVycywgYnV0DQo+ICsgKiB3aXRo
IGltcHJvdmVkIHBlcmZvcm1hbmNlLiAgVGhpcyBpcyBlc3BlY2lhbGx5IGltcG9ydGFudCBmb3Ig
Y2FzZXMgd2hlcmUNCj4gKyAqIHJldHBvbGluZXMgd291bGQgb3RoZXJ3aXNlIGJlIHVzZWQsIGFz
IHJldHBvbGluZXMgY2FuIHNpZ25pZmljYW50bHkgaW1wYWN0DQo+ICsgKiBwZXJmb3JtYW5jZS4N
Cj4gKyAqDQo+ICsgKg0KPiArICogQVBJIG92ZXJ2aWV3Og0KPiArICoNCj4gKyAqICAgREVDTEFS
RV9TVEFUSUNfQ0FMTChrZXksIGZ1bmMpOw0KPiArICogICBERUZJTkVfU1RBVElDX0NBTEwoa2V5
LCBmdW5jKTsNCj4gKyAqICAgc3RhdGljX2NhbGwoa2V5LCBhcmdzLi4uKTsNCj4gKyAqICAgc3Rh
dGljX2NhbGxfdXBkYXRlKGtleSwgZnVuYyk7DQo+ICsgKg0KPiArICoNCj4gKyAqIFVzYWdlIGV4
YW1wbGU6DQo+ICsgKg0KPiArICogICAjIFN0YXJ0IHdpdGggdGhlIGZvbGxvd2luZyBmdW5jdGlv
bnMgKHdpdGggaWRlbnRpY2FsIHByb3RvdHlwZXMpOg0KPiArICogICBpbnQgZnVuY19hKGludCBh
cmcxLCBpbnQgYXJnMik7DQo+ICsgKiAgIGludCBmdW5jX2IoaW50IGFyZzEsIGludCBhcmcyKTsN
Cj4gKyAqDQo+ICsgKiAgICMgRGVmaW5lIGEgJ215X2tleScgcmVmZXJlbmNlLCBhc3NvY2lhdGVk
IHdpdGggZnVuY19hKCkgYnkgZGVmYXVsdA0KPiArICogICBERUZJTkVfU1RBVElDX0NBTEwobXlf
a2V5LCBmdW5jX2EpOw0KPiArICoNCj4gKyAqICAgIyBDYWxsIGZ1bmNfYSgpDQo+ICsgKiAgIHN0
YXRpY19jYWxsKG15X2tleSwgYXJnMSwgYXJnMik7DQo+ICsgKg0KPiArICogICAjIFVwZGF0ZSAn
bXlfa2V5JyB0byBwb2ludCB0byBmdW5jX2IoKQ0KPiArICogICBzdGF0aWNfY2FsbF91cGRhdGUo
bXlfa2V5LCBmdW5jX2IpOw0KPiArICoNCj4gKyAqICAgIyBDYWxsIGZ1bmNfYigpDQo+ICsgKiAg
IHN0YXRpY19jYWxsKG15X2tleSwgYXJnMSwgYXJnMik7DQoNCkkgdGhpbmsgdGhhdCB0aGlzIGNh
bGxpbmcgaW50ZXJmYWNlIGlzIG5vdCB2ZXJ5IGludHVpdGl2ZS4gSSB1bmRlcnN0YW5kIHRoYXQN
CnRoZSBtYWNyb3Mvb2JqdG9vbCBjYW5ub3QgYWxsb3cgdGhlIGNhbGxpbmcgaW50ZXJmYWNlIHRv
IGJlIGNvbXBsZXRlbHkNCnRyYW5zcGFyZW50IChhcyBjb21waWxlciBwbHVnaW4gY291bGQpLiBC
dXQsIGNhbiB0aGUgbWFjcm9zIGJlIHVzZWQgdG8NCnBhc3RlIHRoZSBrZXkgd2l0aCB0aGUg4oCc
c3RhdGljX2NhbGzigJ0/IEkgdGhpbmsgdGhhdCBoYXZpbmcgc29tZXRoaW5nIGxpa2U6DQoNCiAg
c3RhdGljX2NhbGxfX2Z1bmMoYXJnMSwgYXJnMikNCg0KSXMgbW9yZSByZWFkYWJsZSB0aGFuDQoN
CiAgc3RhdGljX2NhbGwoZnVuYywgYXJnMSwgYXJnMikNCg0KPiArfQ0KPiArDQo+ICsjZGVmaW5l
IHN0YXRpY19jYWxsX3VwZGF0ZShrZXksIGZ1bmMpCQkJCQlcDQo+ICsoewkJCQkJCQkJCVwNCj4g
KwlCVUlMRF9CVUdfT04oIV9fc2FtZV90eXBlKGZ1bmMsIFNUQVRJQ19DQUxMX1RSQU1QKGtleSkp
KTsJXA0KPiArCV9fc3RhdGljX2NhbGxfdXBkYXRlKCZrZXksIGZ1bmMpOwkJCQlcDQo+ICt9KQ0K
DQpJcyB0aGlzIHNhZmUgYWdhaW5zdCBjb25jdXJyZW50IG1vZHVsZSByZW1vdmFsPw0KDQo=
