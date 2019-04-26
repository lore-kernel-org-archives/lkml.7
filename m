Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE53CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6038220652
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mhNkv1Mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfDZIhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:37:45 -0400
Received: from mail-eopbgr780088.outbound.protection.outlook.com ([40.107.78.88]:59648
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbfDZIho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pREw/qRGU8OymSUArWBGM974htOcp5cybfvKQYe9Hkk=;
 b=mhNkv1MoYbDI5zW2hwmPhYGIxueFpB7p3GY64HvwnJx3sME/Jyhtq9U9JkPnxR/got8bvPZoGaC7VdB4n67i7wSYaJlt0WrTEnpMYpWt1Ug0yuHvUD1Hhy3fQ66Eoo9kcsN7khNXS9KZs7vR9mToqUoPAbXpQssyp9W2pk0TOfM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5080.namprd05.prod.outlook.com (20.177.231.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 08:37:37 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094%3]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:37:37 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Topic: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Index: AQHU+5HncRUmcKTEhES/sxCi8aqoJ6ZNQ0QAgAADhICAAAHTgIAAGaSAgACw+oCAAAw8AA==
Date:   Fri, 26 Apr 2019 08:37:37 +0000
Message-ID: <14D4B64B-3684-4090-9881-C4A605CF5A19@vmware.com>
References: <20190425180828.24959-1-namit@vmware.com>
 <20190425192930.GA91578@gmail.com>
 <82E44F4A-E52D-4666-95B5-C6248A14A442@vmware.com>
 <20190425194837.GB58719@gmail.com>
 <FA82D7BD-5657-4681-B76E-3452A71171B6@vmware.com>
 <20190426075349.GA4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190426075349.GA4038@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [24.23.137.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61f3a2a8-c8ff-4623-1988-08d6ca227014
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5080;
x-ms-traffictypediagnostic: BYAPR05MB5080:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB508074FF3485F8D8306F5435D03E0@BYAPR05MB5080.namprd05.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(51444003)(51914003)(189003)(199004)(83716004)(68736007)(5660300002)(33656002)(316002)(45080400002)(54906003)(478600001)(91956017)(66066001)(966005)(6486002)(99286004)(76176011)(305945005)(7736002)(66446008)(64756008)(66476007)(66556008)(73956011)(66946007)(6436002)(76116006)(446003)(3846002)(229853002)(2906002)(82746002)(6116002)(476003)(2616005)(71190400001)(11346002)(53546011)(102836004)(6916009)(6512007)(6306002)(186003)(6506007)(71200400001)(26005)(93886005)(4326008)(36756003)(6246003)(8936002)(256004)(8676002)(81166006)(97736004)(81156014)(53936002)(14454004)(86362001)(25786009)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5080;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ArSodplVfTbP5MwhqLjGYt5U7jl9hNo5wDfE2qArt7cGFleP6ygbn2KbwXtsMKoaRX4zhLTBk2wBR1A4PrzB4Qr5o7mJK5NkNIPpmaPK2D7duoieRaHYFKTO9ALWTZM6QD/RF0WpXZMLUPn/PXv1i56fxk2A14Jyt+CGeLo/mCyr/YnKIn1PG2UNb6aZp7f8/4EIht2tlJbttN07+22h55hW5/OluVGBB2WLppwkrzUvPC3QEM8e94eUD/ZuQFIBFQqAL8zPCRzyZwBFob9ki9wuOthEcu6zs+2uwveo5PpYamtrUNmJmQplbXuXUlG1PZVVK9wCc5iT/o2ztVyS7nZ4K8dkfNvJKoQqIclD2XcjPW/0Zm5Bwxi0K4F6tDOLOMbht8CZin6y9gQnkGnWa0Jxe+VU44Et7zPzawdycSY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51AA4B0914AFCB48821E41E3B41B44F8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f3a2a8-c8ff-4623-1988-08d6ca227014
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:37:37.5729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBcHIgMjYsIDIwMTksIGF0IDEyOjUzIEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBBcHIgMjUsIDIwMTkgYXQgMDk6MjA6
MjRQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4gDQo+Pj4gSSB0aGluayB0aGF0J3MgYSBi
dWcgYW5kIFBldGVyWiBpcyBmaXhpbmcgdGhvc2UuDQo+PiANCj4+IFRoaXMgd291bGQgYmUgcXVp
dGUgc3VycHJpc2luZy4NCj4gDQo+IEkgbmVlZCB0byBnZXQgYmFjayB0byB0aGF0IHBlcmNwdSBz
ZXJpZXMgLi4uLiA6Lw0KPiANCj4+IEV2ZW4gYXRvbWljX2RlYygpIGRvZXMgbm90IGltcGx5IGEg
Y29tcGlsZXJzDQo+PiBiYXJyaWVyLiBJIHRoaW5rIEkgc2hvdWxkIGxlYXZlIGl0IGFzIGlzIGZv
ciBub3csIGFuZCBsZXQgUGV0ZXIgY2hhbmdlIGl0DQo+PiBsYXRlciBpZiBoZSBkZWNpZGVzIHRv
IGRvIHNvLiBMZXQgbWUga25vdyBpZiB5b3UgZGlzYWdyZWUuDQo+IA0KPiBodHRwczovL25hbTA0
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21s
Lmtlcm5lbC5vcmclMkZyJTJGMjAxOTA0MjQxMjQ0MjEuODA4NDcxNDUxJTQwaW5mcmFkZWFkLm9y
ZyZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2bXdhcmUuY29tJTdDYzU4MTgyNTE5MDU5NDY2
YjIxZTcwOGQ2Y2ExYzU5NjQlN0NiMzkxMzhjYTNjZWU0YjRhYTRkNmNkODNkOWRkNjJmMCU3QzAl
N0MwJTdDNjM2OTE4NjIwNDcwODM1MDQ0JmFtcDtzZGF0YT1QcGlqcWNDREJtV2RWY29QTnR4Nm9p
TkpzWGolMkZFRDF6NWslMkJkVWVDaWZKTSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpJbnRlcmVzdGlu
ZyEgKGFuZCB0aGFua3MgZm9yIHRoZSByZWZlcmVuY2UpLiBXZWxsLCBJIHNhaWQgaXQgd291bGQg
YmUgcXVpdGUNCnN1cnByaXNpbmcsIGFuZCBJIHNlZSB5b3Ugd3JvdGUgdGhlIHNhbWUgdGhpbmcg
aW4gdGhlIHBhdGNoIDstKQ0KDQpCdXQgY29ycmVjdCBtZSBpZiBJ4oCZbSB3cm9uZyAtIGl0IGRv
ZXMgc291bmQgYXMgaWYgeW91IOKAnHNjcmV34oCdIGFsbCB0aGUgdXNlcw0Kb2YgYXRvbWljX2lu
YygpIGFuZCBhdG9taWNfZGVjKCkgKH40MDAwIGluc3RhbmNlcykgZm9yIHRoZSBmZXdlciB1c2Vz
IG9mDQpzbXBfbWJfX2FmdGVyX2F0b21pYygpIGFuZCBzbXBfbWJfX2JlZm9yZV9hdG9taWMoKSAo
fjQwMCBpbnN0YW5jZXMpLg0KDQpEbyB5b3UgaW50ZW5kIHRvIGF0IGxlYXN0IGludHJvZHVjZSBh
IHZhcmlhbnQgb2YgYXRvbWljX2luYygpIHdpdGhvdXQgYQ0KbWVtb3J5IGJhcnJpZXI/
