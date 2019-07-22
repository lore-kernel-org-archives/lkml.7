Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63C6C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67E02199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="jIClnpG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbfGVVUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:20:53 -0400
Received: from mail-eopbgr780045.outbound.protection.outlook.com ([40.107.78.45]:38816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728441AbfGVVUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HE9G/G5HsihVHizAiDEWHLMV7Rxm+zFZCLYM6/XknYg+lV5bMztrjU4moFo/EsMHHIiMRcEKMbAjjclPyoYUEamEQ0IK1n5BTLkcjBFCifBqOt2IGmbOwd7FBmnQc6djKH0QvxZI+QU2JjdRd4yuk2AtSRSsnpS8Vvewq5d37tUzQpiDRzlEY3ubgkSVFBI3wpHe3xJaCtdiRHyxoUtwM0KnL9biw/qhiWSqOqK9CEG3uO7PTiJNY/AbuveMPbEe9EwgfxGXUF55GVRb6Gi4tJI2gixWK4TELhJmJXS5kG6D1PYsfN5WCsx971F7UwEKaybFEIEzcKMfOyM6NByLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mCowyNd03zlCl6BHOR2vZ4QHbPAVX+x8wP5gGxNEYg=;
 b=Hf84zEjpD3chfpCmdi/xywaFwMzxXh1QFI7mcwLeNJc9NTW6sT3U+55DizJFQHGtcYXM1K2xDnsrizge4skSReTO0JvbcR2KArj7NQgFioDkyyN48+K4ipoo+w4tpUjEANT9Hgc7ZfbjSMceVDOoesY5lGcQd9L6Z+9EsIP22Ag/XkG8FqHL5wmIeEj52fG62N4855Nj478lNdBisC1u9KLN/ZpCMNMV3noj2mHt071+xLrYrcIob9NdfmiV3XuX3rO+9vbTa2EnNHoL+1eRH3cDikSyz3zbUFHpQA9uWCTGA4xAkSus1amUyoa+zjM6zM36pdaFXrUEKWffBMbP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mCowyNd03zlCl6BHOR2vZ4QHbPAVX+x8wP5gGxNEYg=;
 b=jIClnpG6g2I9P+RMKacRP9521I81Lmz+6eg9yKIaudZDsJIbbCXYbALAjBDwbPUHU6Q2LWNTWzOfc1jDXVrZs2E5OWfgTqIoqNYhquZl8To4821df651ZBDB5VB0ozzdn8YmvjWcs6/K7URQV3aHoXZyX4NCWerKdPOj74s+9dg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6296.namprd05.prod.outlook.com (20.178.51.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.8; Mon, 22 Jul 2019 21:20:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2115.005; Mon, 22 Jul 2019
 21:20:46 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC 7/7] x86/current: Aggressive caching of current
Thread-Topic: [RFC 7/7] x86/current: Aggressive caching of current
Thread-Index: AQHVPc3icdeutwj3P0Cy0fu3DYyqBqbXJzcAgAAD0oA=
Date:   Mon, 22 Jul 2019 21:20:46 +0000
Message-ID: <9D1835AD-AB52-4B01-B783-67CB27CFEA9D@vmware.com>
References: <20190718174110.4635-1-namit@vmware.com>
 <20190718174110.4635-8-namit@vmware.com>
 <20190722210704.GL6698@worktop.programming.kicks-ass.net>
In-Reply-To: <20190722210704.GL6698@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4c6538a-aece-472e-f50a-08d70eea7667
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6296;
x-ms-traffictypediagnostic: BYAPR05MB6296:
x-microsoft-antispam-prvs: <BYAPR05MB629629620077117B00958B45D0C40@BYAPR05MB6296.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(6116002)(3846002)(7736002)(305945005)(54906003)(66476007)(81166006)(8676002)(36756003)(66556008)(64756008)(66446008)(66946007)(76116006)(256004)(76176011)(71190400001)(8936002)(5660300002)(86362001)(81156014)(26005)(4326008)(71200400001)(66066001)(99286004)(6246003)(102836004)(11346002)(6512007)(2906002)(68736007)(25786009)(6486002)(2616005)(476003)(6916009)(6506007)(478600001)(53546011)(229853002)(14454004)(53936002)(316002)(446003)(33656002)(6436002)(486006)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6296;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NDcUow80DqlFxLhP/1eC6DMMcZpn5XAuafmcYeOrfBp4wzpBUNUhxpjrCONrqEgnBecWMczb8RMyJIFRvDIFKi0fTKrMw4vPm2WLTU4TNoq1LZ2RwRc/34IfowcKxkXm6zu2NUo1Bgle/xI8qDa7LzjcyOcChD1AFL2JyU9rZwadIZQjRpDiflxePsQMGdsM25JOg5rSGcSpgqHCSOCCtGuzL7UfMwJZQU+3WC6ypVK5wIdVHwJkEQJvwUQFn6e0ysjKHxTIhE5JmhVR7szpS1XG+UjkE6EuhBYO+sUq4P+eKrJbwOo1B7GyGg2DzgSr7tmeomV64qcrqdymAysJAE1ETgwoswmqpbDA2KcgSBkNpvopr0KkGY5AsZfe5fctvf+2Ox0yCXhmmmYcbn3m9P4RXu9p3rPMxk003wrqh4A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45819626B6928D4EA0BBC854CB148F12@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c6538a-aece-472e-f50a-08d70eea7667
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 21:20:46.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMjIsIDIwMTksIGF0IDI6MDcgUE0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1bCAxOCwgMjAxOSBhdCAxMDo0MTox
MEFNIC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gVGhlIGN1cnJlbnRfdGFzayBpcyBzdXBw
b3NlZCB0byBiZSBjb25zdGFudCBpbiBlYWNoIHRocmVhZCBhbmQgdGhlcmVmb3JlDQo+PiBkb2Vz
IG5vdCBuZWVkIHRvIGJlIHJlcmVhZC4gVGhlcmUgaXMgYWxyZWFkeSBhbiBhdHRlbXB0IHRvIGNh
Y2hlIGl0DQo+PiB1c2luZyBpbmxpbmUgYXNzZW1ibHksIHVzaW5nIHRoaXNfY3B1X3JlYWRfc3Rh
YmxlKCksIHdoaWNoIGhpZGVzIHRoZQ0KPj4gZGVwZW5kZW5jeSBvbiB0aGUgcmVhZCBtZW1vcnkg
YWRkcmVzcy4NCj4gDQo+IElzIHRoYXQgd2hhdCBpdCBkb2VzPyEsIEkgbmV2ZXIgcXVpdGUgY291
bGQgdW5kZXJzdGFuZA0KPiBwZXJjcHVfc3RhYmxlX29wKCkuDQoNClRoYXTigJlzIG15IHVuZGVy
c3RhbmRpbmcuIEkgYW0gbm90IHRvbyBwbGVhc2VkIHRoYXQgSSBjb3VsZCBub3QgY29tZSB1cCB3
aXRoDQphIGdlbmVyYWwgYWx0ZXJuYXRpdmUgdG8gdGhpc19jcHVfcmVhZF9zdGFibGUoKSwgbWFp
bmx5IGJlY2F1c2UgZ2NjIGRvZXMgbm90DQpwcm92aWRlIGEgd2F5IHRvIGdldCB0aGUgdHlwZSB3
aXRob3V0IHRoZSBzZWdtZW50IHF1YWxpZmllci4gQW55aG93LA0K4oCcY3VycmVudOKAnSBzZWVt
cyB0byBiZSB0aGUgbWFpbiBwYWluLXBvaW50Lg0KDQpJIHRoaW5rIGEgc2ltaWxhciBjb25zdC1h
bGlhcyBhcHByb2FjaCBjYW4gYWxzbyBiZSB1c2VkIGZvciBzdHVmZiBsaWtlDQpib290X2NwdV9o
YXMoKS4gSSBoYXZlIHNvbWUgcGF0Y2hlcyBmb3IgdGhhdCBzb21ld2hlcmUsIGJ1dCB0aGUgaW1w
YWN0IGlzDQpzbWFsbGVyLiBJIGRvIHNlZSBzb21lIHNtYWxsLCBidXQgbWVhc3VyYWJsZSBwZXJm
b3JtYW5jZSBpbXByb3ZlbWVudHMgd2l0aA0KdGhpcyBzZXJpZXMuIEnigJlsbCB0cnkgdG8gaW5j
b3Jwb3JhdGUgdGhlbSBpbiB2MSBvbmNlIEkgaGF2ZSB0aW1lLg==
