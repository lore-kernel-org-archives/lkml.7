Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E55C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBB1218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="D/RgBmA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGCVOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:14:52 -0400
Received: from mail-eopbgr760052.outbound.protection.outlook.com ([40.107.76.52]:6307
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbfGCVOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 17:14:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWVm6aI7YH7vUSytRsPBzMQdJ6E7LB3qrr9l0SJM+3kVLpdu+pO9I/GT23y/75HbksgSAagrPHWd1tQgy5RbYax5pWkoTg0Ba+25Uo2dpxWehL4tViNbTTdYHaHaQBBouEyyaNWxYDvCHm+xj4f5RDh87X6YYtUj4Vn5lLIFIJxwJWh2zwHhGDG1rbj3TVY9QT8BxiS5/g1f3UgAZDxeT6IGQhIogO8iIUcBUU+zIb+C1dH0DfUVOj3t+RzC1FC8WU3hSGT0Bk3T7cPLRWq0E41AWg60U2ze6+6/Es41sjN/RQrdnEwCmX3w/vXdAhOCRIFSE8sH6+4LCw0CJbgGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b3NcF5ylYk86h3KwfDgjUitseDXPuZGCO6mPB5GdHs=;
 b=MG5Hbau/cFKVaeGig2k/tBSzj/Kj8Hpkk+QZOn5V5sE0f5cMZhALfOV/C1AEDt9bTmceCTt6TDomWe/OXol0dAVzkhXSDmXXH16sXnEo7UlU9EmZzbVa3b/Y1dikjSX9qsw5Nb5bsQUEc4G9F34f2ZCSTz1nnmNn39QrN2vbitzx1v9VJSpTqyW/LGA1QoamonZu8QPVf1RRk0+pq68OR3suhgnLQn7U5TVJs3Z5CchcbXuHG/ckcRCdiHCnAwp65sWGSGf0FZU+FHzOKnpttJLz5UMxTl4c7SzRYmFQ8pjDTR+1iEhDlIvWvxAnIVGmsEcC3T4Ul2MWeeJpZicwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b3NcF5ylYk86h3KwfDgjUitseDXPuZGCO6mPB5GdHs=;
 b=D/RgBmA4BrqDqRCwmwEadwtlrcIRI0CSQPAcSmJ9zLTBjL8FOndzaTfHjA7ILlRKbRnUnizYwPyTvYwEkDWBmVjF7tja5ZqBJ3pCZYocRn4k2CQh+pj5kfUaRSJ9Ide7hPwDC/2v/3LehJASxuFw/XY3YHIJMyms8rHIRnZK6yQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5863.namprd05.prod.outlook.com (20.178.50.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.4; Wed, 3 Jul 2019 21:14:48 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2052.010; Wed, 3 Jul 2019
 21:14:48 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [patch 16/18] x86/apic: Convert 32bit to IPI shorthand static key
Thread-Topic: [patch 16/18] x86/apic: Convert 32bit to IPI shorthand static
 key
Thread-Index: AQHVMY8QgIx5pjJdE0yOed/UKt0/5qa5MQyAgAApR4CAAAs+gA==
Date:   Wed, 3 Jul 2019 21:14:48 +0000
Message-ID: <F521E659-4F8A-44FC-994B-5B9E2B229184@vmware.com>
References: <20190703105431.096822793@linutronix.de>
 <20190703105917.044463061@linutronix.de>
 <1DC35A28-DEBC-4A46-AC35-3AADD23AA40D@vmware.com>
 <alpine.DEB.2.21.1907032213250.1802@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907032213250.1802@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e118dc55-33ee-4687-2d18-08d6fffb7b1c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5863;
x-ms-traffictypediagnostic: BYAPR05MB5863:
x-microsoft-antispam-prvs: <BYAPR05MB5863F225FE76FE3F40CA59B0D0FB0@BYAPR05MB5863.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(102836004)(6486002)(53546011)(476003)(2616005)(4326008)(486006)(6436002)(25786009)(11346002)(6916009)(446003)(6506007)(33656002)(14454004)(26005)(64756008)(7736002)(229853002)(305945005)(186003)(99286004)(66446008)(66556008)(36756003)(66476007)(8936002)(8676002)(53936002)(81166006)(81156014)(2906002)(73956011)(66946007)(76116006)(6246003)(256004)(5660300002)(76176011)(3846002)(6116002)(54906003)(6512007)(86362001)(66066001)(68736007)(316002)(478600001)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5863;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5uV9DBoETEWMWATI8DRTuhDPClkQuR9CMYtrjwfQfXrJIjMVbVpwup+n9MDu6VJ8BC6Hq7N2qCgnJ2MQtkHfUAAg7wzIb3GOOGkx3arw4c2U5yNDXGgoD6RSgTuxniVUj3eDEFfvb9I7SkAjLHb+cqYNOab3tjAAfLNN/pPA16TNicV2ZzUkAZ5YCvOE8NWqYF0+xr5ZEjRWiRJgIQDqtcOy7fzLK4oVxSuvnbocWMZxXBV7q4OAJi6qaMFffUsNkOeEAZnMrizhkFPtONuOTsQUV3chsewSnrFFjGYVKRTkiTPEn0kv7MnWUOqX2cjQLBBMsxxsLqc77mijR+dP1bowXQ6LXbJYAuJXeqmq49KFSg0FvcnFII+cai7k/gpAw+AIUZrht5uQrVhkCcOCVqDLF2Wvx0J353v5eUOVia4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CB4C944BE79454CA6BAC2FE0295471F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e118dc55-33ee-4687-2d18-08d6fffb7b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 21:14:48.4323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMywgMjAxOSwgYXQgMTozNCBQTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0
cm9uaXguZGU+IHdyb3RlOg0KPiANCj4gTmFkYXYsDQo+IA0KPiBPbiBXZWQsIDMgSnVsIDIwMTks
IE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gT24gSnVsIDMsIDIwMTksIGF0IDM6NTQgQU0sIFRob21h
cyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4+PiB2b2lkIGRlZmF1bHRf
c2VuZF9JUElfYWxsKGludCB2ZWN0b3IpDQo+Pj4gew0KPj4+IC0JaWYgKGFwaWNfaXBpX3Nob3J0
aGFuZF9vZmYgfHwgdmVjdG9yID09IE5NSV9WRUNUT1IpIHsNCj4+PiArCWlmIChzdGF0aWNfYnJh
bmNoX2xpa2VseSgmYXBpY191c2VfaXBpX3Nob3J0aGFuZCkpIHsNCj4+PiAJCWFwaWMtPnNlbmRf
SVBJX21hc2soY3B1X29ubGluZV9tYXNrLCB2ZWN0b3IpOw0KPj4+IAl9IGVsc2Ugew0KPj4+IAkJ
X19kZWZhdWx0X3NlbmRfSVBJX3Nob3J0Y3V0KEFQSUNfREVTVF9BTExJTkMsIHZlY3Rvcik7DQo+
PiANCj4+IEl0IG1heSBiZSBiZXR0ZXIgdG8gY2hlY2sgdGhlIHN0YXRpYy1rZXkgaW4gbmF0aXZl
X3NlbmRfY2FsbF9mdW5jX2lwaSgpIChhbmQNCj4+IG90aGVyIGNhbGxlcnMgaWYgdGhlcmUgYXJl
IGFueSksIGFuZCByZW1vdmUgYWxsIHRoZSBvdGhlciBjaGVja3MgaW4NCj4+IGRlZmF1bHRfc2Vu
ZF9JUElfYWxsKCksIHgyYXBpY19zZW5kX0lQSV9tYXNrX2FsbGJ1dHNlbGYoKSwgZXRjLg0KPiAN
Cj4gVGhhdCBtYWtlcyBzZW5zZS4gU2hvdWxkIGhhdmUgdGhvdWdodCBhYm91dCB0aGF0IG15c2Vs
ZiwgYnV0IGh1bnRpbmcgdGhhdA0KPiBBUElDIGVtdWxhdGlvbiBpc3N1ZSB3YXMgYWZmZWN0aW5n
IG15IGJyYWluIG9idmlvdXNseSA6KQ0KDQpXZWxsLCBpZiB5b3UgdXNlZCBWTXdhcmUgYW5kIG5v
dCBLVk0uLi4gOy0pDQoNCihhbGxvdyBtZSB0byByZWVtcGhhc2l6ZSB0aGF0IEkgYW0gam9raW5n
IGFuZCBzYXZlIG15c2VsZiBmcm9tIHNwYW0pDQoNCj4+IHZvaWQgbmF0aXZlX3NlbmRfY2FsbF9m
dW5jX2lwaShjb25zdCBzdHJ1Y3QgY3B1bWFzayAqbWFzaykNCj4+IHsNCj4+IC0JY3B1bWFza192
YXJfdCBhbGxidXRzZWxmOw0KPj4gLQ0KPj4gLQlpZiAoIWFsbG9jX2NwdW1hc2tfdmFyKCZhbGxi
dXRzZWxmLCBHRlBfQVRPTUlDKSkgew0KPj4gLQkJYXBpYy0+c2VuZF9JUElfbWFzayhtYXNrLCBD
QUxMX0ZVTkNUSU9OX1ZFQ1RPUik7DQo+PiAtCQlyZXR1cm47DQo+PiArCWludCBjcHUsIHRoaXNf
Y3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOw0KPj4gKwlib29sIGFsbGJ1dHNlbGYgPSB0cnVlOw0K
Pj4gKwlib29sIHNlbGYgPSBmYWxzZTsNCj4+ICsNCj4+ICsJZm9yX2VhY2hfY3B1X2FuZF9ub3Qo
Y3B1LCBjcHVfb25saW5lX21hc2ssIG1hc2spIHsNCj4+ICsNCj4+ICsJCWlmIChjcHUgIT0gdGhp
c19jcHUpIHsNCj4+ICsJCQlhbGxidXRzZWxmID0gZmFsc2U7DQo+PiArCQkJYnJlYWs7DQo+PiAr
CQl9DQo+PiArCQlzZWxmID0gdHJ1ZTsNCj4gDQo+IFRoYXQgYWNjdW11bGF0ZXMgdG8gYSBsYXJn
ZSBpdGVyYXRpb24gaW4gdGhlIHdvcnN0IGNhc2UuIA0KDQpJIGRvbuKAmXQgdW5kZXJzdGFuZCB3
aHkuIFRoZXJlIHNob3VsZCBiZSBhdCBtb3N0IHR3byBpdGVyYXRpb25zIC0gb25lIGZvcg0Kc2Vs
ZiBhbmQgb25lIGZvciBhbm90aGVyIGNvcmUuIFNvIF9maW5kX25leHRfYml0KCkgd2lsbCBiZSBj
YWxsZWQgYXQgbW9zdA0KdHdpY2UuIF9maW5kX25leHRfYml0KCkgaGFzIGl0cyBvd24gbG9vcCwg
YnV0IEkgZG9u4oCZdCB0aGluayBvdmVyYWxsIGl0IGlzIGFzDQpiYWQgYXMgY2FsbGluZyBhbGxv
Y19jcHVtYXNrX3ZhcigpLCBjcHVtYXNrX2NvcHkoKSBhbmQgY3B1bWFza19lcXVhbCgpLA0Kd2hp
Y2ggYWxzbyBoYXZlIGxvb3BzLg0KDQpJIGRvbuKAmXQgaGF2ZSBudW1iZXJzIChhbmQgSSBkb3Vi
dCB0aGV5IGFyZSB2ZXJ5IHNpZ25pZmljYW50KSwgYnV0IHRoZSBjcHVtYXNrDQphbGxvY2F0aW9u
IHNob3dlZCB3aGVuIEkgd2FzIHByb2ZpbGluZyBteSBtaWNyb2JlbmNobWFyay4NCg0K
