Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D1AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04504206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ChQMkiwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfJIHZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:25:03 -0400
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:12864
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfJIHZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:25:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr9KWL263gj1td/HAvG7DfIFlvNZKL7of/9qzmMNDqQzQupAHcaFe8zvqaIN/VvFfiNVqXCR/cduemPoywLdYgiUn4U0yBhD2vXslOosL1gH8jc6pBMAQJEAVIg7KHpZ91wsI5kIPUMRnHbjoKtvBn/lKSRT692ZaIKseK1NOFAo6dTPEVxczSEe7sUa/GGVMmiOREQpdyGSYWHZDlrq62qODM1AiWaA0Z8yZXb/v7E0tckMwf0KFpKN63XFho58AU16iD0981TRxbnJREbgu6RgYcYFajTHiKw32RS2oFEzlbLjwgkb+Cr9FkVZNuz9807wmzdDb2lkHayZLvnmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D4VemOl8zbTrxjn5xxqR6F9Y/HxysiEFcNy7JlWvm0=;
 b=jYqUoHdYgHOclzGtD1KqwxBcZk/RTiBneoSKt4Xlhsv2eB8MA8qO4Zr2j5R2rYivlFZhDMUy+KhdSLuC3KTr+slDu5scumoCn9j9ptIzLLOehrWtc32YChOMUG1CKqioZvMD01jNyaECQyIxPBc9Wx5fMGQVOi51rYuGCtPtXCMKgVages1HaA5PHkYY8Vzta7LDEE2byFSHPE4cAdypF269GvvQ7VB14UAfXN8Q85PzdGgqcwQef7YZp0xHPXisACJd2eBCk3qJwvoT5RzizyFIe/kUQsURruaaM10V6r426C8PGFv73Ua7MIfXenzDpxuWr7yl3myWD7Axw1Zz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D4VemOl8zbTrxjn5xxqR6F9Y/HxysiEFcNy7JlWvm0=;
 b=ChQMkiwK7mQaxQeSvy6bs5leTW2ELdolHp7Ix47q5G9a0HsXcE+fK77hrPPhB1oK0rxW0BsthsEoVnBqZdoH2CWQCP3Pa2moZzaDzR9g8h1xfYSm+MjlvCg3HtFlsN7pOCl7n8xcoiIpL/4aq3yuipBmrwR4yZjeHuS9Fh6IuMs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 07:24:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 07:24:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH] tty: serial: imx: Only get second/third IRQ when there is
 more than one IRQ
Thread-Topic: [PATCH] tty: serial: imx: Only get second/third IRQ when there
 is more than one IRQ
Thread-Index: AQHVfmm1cibywjMA5UifVvn4HL9DWadR35+AgAAA6hCAAATlgIAAAf4g
Date:   Wed, 9 Oct 2019 07:24:57 +0000
Message-ID: <DB3PR0402MB39161E02A9D042948B71FDCDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
 <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
 <DB3PR0402MB39165F9CE876772F8F94F187F5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191009071403.ugd2wuac6ue5zsd6@pengutronix.de>
In-Reply-To: <20191009071403.ugd2wuac6ue5zsd6@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3bbfc24-c19a-419e-16dd-08d74c89c9ac
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3692:|DB3PR0402MB3692:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB36929626F0D091ADB3D10C54F5950@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(99286004)(5660300002)(14454004)(66066001)(2906002)(66946007)(186003)(66476007)(66556008)(64756008)(478600001)(66446008)(6506007)(71200400001)(76176011)(7696005)(102836004)(6116002)(3846002)(76116006)(54906003)(71190400001)(33656002)(52536014)(316002)(26005)(6916009)(256004)(8676002)(8936002)(81166006)(44832011)(11346002)(476003)(86362001)(81156014)(446003)(6246003)(7736002)(25786009)(229853002)(4326008)(486006)(74316002)(7416002)(9686003)(6436002)(305945005)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3692;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKLWHkE5vK+2V3eeOWj+Y9I6Q9zwY3oDHZou1rh/y6mAf7w6u49y6frOCRL/FLKUDegrnHlE1qauRnZJR5ZF1oPH93sNDH0zgEv4LqFIOEBDA5sj8F2lvNoFIvv1jzLQa0NW8whuIquM03zuY5OMWPcf+80S3KCjP/IGVcN/qbFqY4ZxLajJHi05t8hllR878V/nVs1Erl+GBbyTOqUVT9njouf9VJi/k8NGz1k2iHAe952/xZvc9DhclpRg1MH03gRbmMRI/UrcG80MmI0lzjZCwkzF8q0FAw5DJSEAxrPL0kmts6XeJljxRsPDdFWv4ANCDeL8DOtGSAqfSV+e3MMZEizSNqkOlauLuqB6sPA1lGA5996VZggiXP2f/JlQmutK+w7K4Cq1SzR7+aX288E1gQeZzzfg2zQyK54RH8M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bbfc24-c19a-419e-16dd-08d74c89c9ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 07:24:57.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ja/5rKDe0atfYpuIYXBh+yS/n/PIkDVtd6T7hTRDDW2/Tc8MOYvRPH3W4udiYFIri2S77k31kHr7FxmyYXstw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFV3ZQ0KDQo+IE9uIFdlZCwgT2N0IDA5LCAyMDE5IGF0IDA2OjU4OjI0QU0gKzAwMDAsIEFu
c29uIEh1YW5nIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBPY3QgMDksIDIwMTkgYXQgMDI6MTg6MzFQ
TSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+IEFsbCBpLk1YIFNvQ3MgZXhjZXB0
IGkuTVgxIGhhdmUgT05MWSAxIElSUSwgc28gaXQgaXMgYmV0dGVyIHRvDQo+ID4gPiA+IGNoZWNr
IHRoZSBJUlEgY291bnQgYmVmb3JlIGdldHRpbmcgc2Vjb25kL3RoaXJkIElSUSB0byBhdm9pZCBi
ZWxvdw0KPiA+ID4gPiBlcnJvciBtZXNzYWdlIGR1cmluZyBwcm9iZToNCj4gPiA+ID4NCj4gPiA+
ID4gWyAgICAwLjcyNjIxOV0gaW14LXVhcnQgMzA4NjAwMDAuc2VyaWFsOiBJUlEgaW5kZXggMSBu
b3QgZm91bmQNCj4gPiA+ID4gWyAgICAwLjczMTMyOV0gaW14LXVhcnQgMzA4NjAwMDAuc2VyaWFs
OiBJUlEgaW5kZXggMiBub3QgZm91bmQNCj4gPiA+DQo+ID4gPiBUaGlzIG1lc3NhZ2Ugd2FzIGlu
dHJvZHVjZWQgaW4gY29tbWl0DQo+ID4gPiA3NzIzZjRjNWVjZGI4ZDgzMmYwNDlmODQ4M2JlYjBk
MTA4MWNlZGY2IGZvciA1LjQtcmMxLiBJIGFkZGVkIHRoZQ0KPiA+ID4gaW52b2x2ZWQgcGVvcGxl
IHRvIHRoZSByZWNpcGVudHMgb2YgdGhpcyBtYWlsLg0KPiA+DQo+ID4gWWVzLCBJIG5vdGljZWQg
dGhpcywgdGhhbmtzLg0KPiA+DQo+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJz
L3R0eS9zZXJpYWwvaW14LmMgfCAxMyArKysrKysrKysrKy0tDQo+ID4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC9pbXguYw0KPiA+ID4gPiBpbmRleA0KPiA+ID4gPiA1MDRkODFjLi4wODFmYTgyIDEwMDY0NA0K
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gPiA+ID4gKysrIGIvZHJp
dmVycy90dHkvc2VyaWFsL2lteC5jDQo+ID4gPiA+IEBAIC0yMTk4LDYgKzIxOTgsNyBAQCBzdGF0
aWMgaW50IGlteF91YXJ0X3Byb2JlKHN0cnVjdA0KPiA+ID4gPiBwbGF0Zm9ybV9kZXZpY2UNCj4g
PiA+ICpwZGV2KQ0KPiA+ID4gPiAgCXUzMiB1Y3IxOw0KPiA+ID4gPiAgCXN0cnVjdCByZXNvdXJj
ZSAqcmVzOw0KPiA+ID4gPiAgCWludCB0eGlycSwgcnhpcnEsIHJ0c2lycTsNCj4gPiA+ID4gKwlp
bnQgaXJxX2NvdW50Ow0KPiA+ID4gPg0KPiA+ID4gPiAgCXNwb3J0ID0gZGV2bV9remFsbG9jKCZw
ZGV2LT5kZXYsIHNpemVvZigqc3BvcnQpLCBHRlBfS0VSTkVMKTsNCj4gPiA+ID4gIAlpZiAoIXNw
b3J0KQ0KPiA+ID4gPiBAQCAtMjIyMCw5ICsyMjIxLDE3IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRf
cHJvYmUoc3RydWN0DQo+ID4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiA+ICAJaWYg
KElTX0VSUihiYXNlKSkNCj4gPiA+ID4gIAkJcmV0dXJuIFBUUl9FUlIoYmFzZSk7DQo+ID4gPiA+
DQo+ID4gPiA+ICsJaXJxX2NvdW50ID0gcGxhdGZvcm1faXJxX2NvdW50KHBkZXYpOw0KPiA+ID4g
PiArCWlmIChpcnFfY291bnQgPCAwKQ0KPiA+ID4gPiArCQlyZXR1cm4gaXJxX2NvdW50Ow0KPiA+
ID4gPiArDQo+ID4gPiA+ICAJcnhpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+
ID4gPiAtCXR4aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAxKTsNCj4gPiA+ID4gLQlydHNp
cnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDIpOw0KPiA+ID4gPiArCWlmIChpcnFfY291bnQg
PiAxKSB7DQo+ID4gPiA+ICsJCXR4aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAxKTsNCj4g
PiA+ID4gKwkJcnRzaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAyKTsNCj4gPiA+ID4gKwl9
IGVsc2Ugew0KPiA+ID4gPiArCQl0eGlycSA9IHJ0c2lycSA9IC1FTlhJTzsNCj4gPiA+ID4gKwl9
DQo+ID4gPg0KPiA+ID4gVGhlIHBhdGNoIGlzIGZpbmUgZ2l2ZW4gdGhlIGNoYW5nZWQgYmVoYXZp
b3VyIG9mIHBsYXRmb3JtX2dldF9pcnEuIEkNCj4gPiA+IHdvbmRlciBpZiBpdCBpcyBzZW5zaWJs
ZSB0byBpbnRyb2R1Y2UgYSB2YXJpYW50IG9mIHBsYXRmb3JtX2dldF9pcnENCj4gPiA+IChzYXkN
Cj4gPiA+IHBsYXRmb3JtX2dldF9pcnFfbm93YXJuKSB0aGF0IGJlaGF2ZXMgbGlrZSBfX3BsYXRm
b3JtX2dldF9pcnEgZG9lcyB0DQo+ID4gPiBUaGVuIHRoZSBpbXggZHJpdmVyIHdvdWxkIGp1c3Qg
Y2FsbCBwbGF0Zm9ybV9nZXRfaXJxX25vd2FybiB3aXRob3V0DQo+ID4gPiBoYXZpbmcgdG8gY2hl
Y2sgdGhlIG51bWJlciBvZiBhdmFpbGFibGUgaXJxcyBmaXJzdC4NCj4gPg0KPiA+IEFncmVlZCwg
aXQgd291bGQgYmUgbmljZSBpZiB3ZSBjYW4gZml4IHRoaXMgZnJvbSB0aGUgQVBJIGxldmVsLCB0
aGlzDQo+ID4gaXMgdG8gc2F2ZSBtYW55IHBhdGNoZXMgZnJvbSB2YXJpb3VzIGRyaXZlcnMgc2lk
ZSwgbGV0IG1lIGtub3cgaWYNCj4gPiBhZ3JlZW1lbnQgaXMgcmVhY2hlZCBhbmQgSSB3aWxsIGRv
IHRoZSBwYXRjaC4NCj4gDQo+IEkgd291bGRuJ3QgZXhwZWN0IHRoYXQgbW9zdCBjYWxsZXJzIGFj
dHVhbGx5IHdhbnQgYW4gZXJyb3IgbWVzc2FnZSBhbmQgc28NCj4gdGhlc2UgbmVlZCBhIGRpZmZl
cmVudCBwYXRjaCAoaS5lLiBkcm9wcGluZyB0aGUgZXJyb3IgbWVzc2FnZSBieSB0aGUgY2FsbGVy
KS4NCj4gVGhpcyB0eXBlIG9mIHBhdGNoIGlzIGZpbmUgYW5kIHRoZSBub3JtYWwgbG9hZCB3aGVu
IHNvbWV0aGluZyBpcw0KPiBjb25zb2xpZGF0ZWQuDQo+IA0KPiBXaGljaCBvdGhlciBkcml2ZXJz
IGRvIHlvdSBoYXZlIG9uIHlvdXIgcmFkYXIgdGhhdCBkb24ndCB3YW50IGFuIGVycm9yDQo+IG1l
c3NhZ2UgaWYgcGxhdGZvcm1fZ2V0X2lycSgpIGZhaWxzPw0KDQpJIGRpZCBOT1QgbWVhbiBkcml2
ZXJzIGRvbid0IHdhbnQgYW4gZXJyb3Igd2hlbiBnZXR0aW5nIGlycSBmYWlsZWQsIGJ1dCBJIGp1
c3QNCmFncmVlIHRoYXQgaW50cm9kdWNpbmcgYW5vdGhlciBBUEkgd2l0aCBub3dhcm4gYXMgeW91
IG1lbnRpb25lZCB1cHBlciwgdGhlbg0KaS5NWCBkcml2ZXIgY2FuIGNhbGwgaXQuIEZvciBub3cs
IHRoZSBGRUMgZHJpdmVyIGFsc28gaGF2ZSBtYW55IHN1Y2ggZXJyb3IgbWVzc2FnZSwNCndlIHdp
bGwgZml4IGxhdGVyLg0KDQpTbyBpZiB0aGUgQVBJIHdpdGggbm93YXJuIGlzIGFkZGVkLCB0aGVu
IEkgY2FuIGNoYW5nZSB0aGUgQVBJIGNhbGwgaW4gc29tZSBpLk1YIGRyaXZlcg0KaW5zdGVhZCBv
ZiBnZXR0aW5nIGlycV9jb3VudCBmaXJzdC4gRG8geW91IHRoaW5rIEkgc2hvdWxkIGFkZCB0aGUg
bm93YXJuIEFQSSBhbmQgcmVkbw0KdGhpcyBwYXRjaCB0byBjYWxsIGl0PyANCg0KQW5zb24NCg==
