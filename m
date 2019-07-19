Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27D8C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FD521882
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="RDblrAbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbfGSSnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:43:33 -0400
Received: from mail-eopbgr710088.outbound.protection.outlook.com ([40.107.71.88]:25838
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728356AbfGSSnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbZqHGPc8a4QGgSL6RzitIDtf0G9TrlBhEtWAUGESaPkq119rOKbL/yXTLUZxQj915UDTxQkNlVz5ijvrROf8LYA8MyzXFI3xiNFB3DGED8H/PLNQhxLVeNfNupQBbhv6bRkh6Awe0+6ZUL1FslUWWc2DCfIfaNZUPYi7KP6YubZFr7YWkcGQ26plLTLzwAlylPrxeXcsxbwKJvHAnKzk2O6PgGm1/jT0/Fon10mZiVkffekynr5fe46F5vla9y3bBBnvgc7jcBjjeKhMP2/sCUSzR9CexenzdXD7lAQxr2fNcN3up4kXI6jKaN619AaqJMOhvrSz9E42G3LUkoMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WE8YmAnuYvJdHUL9COIkmwR3U43K624i9ay5iytK7A=;
 b=mR/ORZp/lQKRUiJ0xcpmIsT0It9yMQ+KjBBc/INLCWbku3c3wna6HCjPoRIH2y6VvzWacJVWP/c0kcL7tuGZekZDUwBOO6UlsivvphON4VG0SdXwgc4Q9j9q2ltsihHtpL4ylvOPocMPJSGYnPmFmMaEvK+xre+XO4sfn93v8DvuQgOmfGo5FikA4T2pNqRrfNqbhQTFgh+rp4TR0kmkhwXTSX57nKv871obKCe+93vYOCWS9x1Jy3HdgxRaT/a/Rf217GC39Jarmv0e3z4mizz15oeFc6haYn+vzKrd1jxEzOR2ohFsAOeYcQE+MVQYOV8oLWZRREjX3EtiVkwJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WE8YmAnuYvJdHUL9COIkmwR3U43K624i9ay5iytK7A=;
 b=RDblrAbbN6/KzsNwUU3ZEKd+y+9ICjl4xDCytsiSxnOBFCO9A5N/WYLta4KKB2aFZCa7uOK2+bRqsw2aLTzdA2yVFa40VSbu1gf2jRT3p5qlVI+NNhu/pRUoCFdQspiAY4Evd7wAaLyKC2dKGVC/w6IZ58SysPt7h9n5sI5/PuI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4679.namprd05.prod.outlook.com (52.135.233.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.7; Fri, 19 Jul 2019 18:43:30 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2094.009; Fri, 19 Jul 2019
 18:43:30 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 5/9] x86/mm/tlb: Privatize cpu_tlbstate
Thread-Topic: [PATCH v3 5/9] x86/mm/tlb: Privatize cpu_tlbstate
Thread-Index: AQHVPc0sdRp3u9Eq6kyTg9bchPzdrKbSRpyAgAABgIA=
Date:   Fri, 19 Jul 2019 18:43:30 +0000
Message-ID: <FCEC2890-40B8-4114-913E-7C05B021C4EA@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-6-namit@vmware.com>
 <052e9e57-8f72-d005-f0f7-4060bc665ba4@intel.com>
In-Reply-To: <052e9e57-8f72-d005-f0f7-4060bc665ba4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a562fd4-91fa-4346-03a8-08d70c78feb3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4679;
x-ms-traffictypediagnostic: BYAPR05MB4679:
x-microsoft-antispam-prvs: <BYAPR05MB46795E5D33DD10C1C1ADD1EAD0CB0@BYAPR05MB4679.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(7736002)(6436002)(25786009)(316002)(6246003)(186003)(3846002)(6486002)(6116002)(6916009)(53546011)(6506007)(486006)(76176011)(5660300002)(476003)(66946007)(446003)(71190400001)(54906003)(2616005)(11346002)(478600001)(33656002)(66446008)(8676002)(66066001)(66476007)(66556008)(64756008)(256004)(102836004)(14454004)(68736007)(81156014)(2906002)(229853002)(81166006)(86362001)(4326008)(99286004)(8936002)(305945005)(36756003)(6512007)(53936002)(26005)(76116006)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4679;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RLY1n9TdSPy0deGFvmL6E42F6wwyG5BysTliBJdMTrFnCeYVyL96q4JHiCXSaBHSskkXbgI/6g+YJf9DHyGcG7t5b8NR7pn5oDga2Wm3cebgJlQxxf1D82HwrmqRrCrjdCn70RyQ6K4koehwvT4GNg3+UheGd7SNqYTst2FvGFJeiCasO3qxkMNXIDqNe+Iv0O2tKZIGSWJNgl+9DaGYKNJQQGHp/V9o+vqTKiFDUmE6VoWdtE7SO9aloFqzsdFh08j1K/DKxLV4q8tWSpfAy4aE7e30w0wefs3bgx/2HQAfompQduSXmQ2sFhygC9Q3EZHwdhykG/N7Ef6N1MOJlxW+ZibrQPW6wARC/MK5cOToYGeGvWWIUFHLrzyKvp0+JKf9dMBURYsBDqGb6KdRyXidKsw7h0uSccwPKHw4B2I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45FFC43C61265C46824A6AC534C404BD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a562fd4-91fa-4346-03a8-08d70c78feb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 18:43:30.3379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMTksIDIwMTksIGF0IDExOjM4IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5A
aW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDcvMTgvMTkgNTo1OCBQTSwgTmFkYXYgQW1pdCB3
cm90ZToNCj4+ICtzdHJ1Y3QgdGxiX3N0YXRlX3NoYXJlZCB7DQo+PiArCS8qDQo+PiArCSAqIFdl
IGNhbiBiZSBpbiBvbmUgb2Ygc2V2ZXJhbCBzdGF0ZXM6DQo+PiArCSAqDQo+PiArCSAqICAtIEFj
dGl2ZWx5IHVzaW5nIGFuIG1tLiAgT3VyIENQVSdzIGJpdCB3aWxsIGJlIHNldCBpbg0KPj4gKwkg
KiAgICBtbV9jcHVtYXNrKGxvYWRlZF9tbSkgYW5kIGlzX2xhenkgPT0gZmFsc2U7DQo+PiArCSAq
DQo+PiArCSAqICAtIE5vdCB1c2luZyBhIHJlYWwgbW0uICBsb2FkZWRfbW0gPT0gJmluaXRfbW0u
ICBPdXIgQ1BVJ3MgYml0DQo+PiArCSAqICAgIHdpbGwgbm90IGJlIHNldCBpbiBtbV9jcHVtYXNr
KCZpbml0X21tKSBhbmQgaXNfbGF6eSA9PSBmYWxzZS4NCj4+ICsJICoNCj4+ICsJICogIC0gTGF6
aWx5IHVzaW5nIGEgcmVhbCBtbS4gIGxvYWRlZF9tbSAhPSAmaW5pdF9tbSwgb3VyIGJpdA0KPj4g
KwkgKiAgICBpcyBzZXQgaW4gbW1fY3B1bWFzayhsb2FkZWRfbW0pLCBidXQgaXNfbGF6eSA9PSB0
cnVlLg0KPj4gKwkgKiAgICBXZSdyZSBoZXVyaXN0aWNhbGx5IGd1ZXNzaW5nIHRoYXQgdGhlIENS
MyBsb2FkIHdlDQo+PiArCSAqICAgIHNraXBwZWQgbW9yZSB0aGFuIG1ha2VzIHVwIGZvciB0aGUg
b3ZlcmhlYWQgYWRkZWQgYnkNCj4+ICsJICogICAgbGF6eSBtb2RlLg0KPj4gKwkgKi8NCj4+ICsJ
Ym9vbCBpc19sYXp5Ow0KPj4gK307DQo+PiArREVDTEFSRV9QRVJfQ1BVX1NIQVJFRF9BTElHTkVE
KHN0cnVjdCB0bGJfc3RhdGVfc2hhcmVkLCBjcHVfdGxic3RhdGVfc2hhcmVkKTsNCj4gDQo+IENv
dWxkIHdlIGdldCBhIGNvbW1lbnQgYWJvdXQgd2hhdCAic2hhcmVkIiBtZWFucyBhbmQgd2h5IHdl
IG5lZWQgc2hhcmVkDQo+IHN0YXRlPw0KPiANCj4gU2hvdWxkIHdlIGNoYW5nZSAndGxiX3N0YXRl
JyB0byAndGxiX3N0YXRlX3ByaXZhdGXigJk/DQoNCkFuZHkgc2FpZCB0aGF0IGZvciB0aGUgbGF6
eSB0bGIgb3B0aW1pemF0aW9ucyB0aGVyZSBtaWdodCBzb29uIGJlIG1vcmUNCnNoYXJlZCBzdGF0
ZS4gSWYgeW91IHByZWZlciwgSSBjYW4gbW92ZSBpc19sYXp5IG91dHNpZGUgb2YgdGxiX3N0YXRl
LCBhbmQNCm5vdCBzZXQgaXQgaW4gYW55IGFsdGVybmF0aXZlIHN0cnVjdC4NCg0K
