Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B5FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAF420883
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="BhW5T3Na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFZBeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:34:21 -0400
Received: from mail-eopbgr800040.outbound.protection.outlook.com ([40.107.80.40]:35072
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfFZBeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EU0UVe0S7cIJsDSb3WzmnA2IkrVJMhog7HoA+DMujo=;
 b=BhW5T3Na8sL+IexqX95S+67DyQGPgq7rp5FyHcdGZ9dAQl2f5nDCMcRuGQ3w2BeHpUFV59FDU7uI1AhRdTDzTrJ/q2+0OUZMAHGYhRJYG76G5brAPRA3V7a54RKOO0la3943mygZkPqpEXrQ5ttnyjPRzpRRsCTs45eYX05akW4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4438.namprd05.prod.outlook.com (52.135.203.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.12; Wed, 26 Jun 2019 01:34:18 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2008.007; Wed, 26 Jun 2019
 01:34:17 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/9] x86: Concurrent TLB flushes and other improvements
Thread-Topic: [PATCH 0/9] x86: Concurrent TLB flushes and other improvements
Thread-Index: AQHVIbQWisO9bAfBY0SyLHddW0AlP6atAA8AgAA7EQA=
Date:   Wed, 26 Jun 2019 01:34:17 +0000
Message-ID: <8F197BEF-E32D-4309-A70C-F19EE7EEC994@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
 <fcfeac95-b38c-5ec6-4fd9-9d7931d5ae2e@intel.com>
In-Reply-To: <fcfeac95-b38c-5ec6-4fd9-9d7931d5ae2e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [204.134.128.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e54a673-c02f-4778-b474-08d6f9d667d1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4438;
x-ms-traffictypediagnostic: BYAPR05MB4438:
x-microsoft-antispam-prvs: <BYAPR05MB443830AEB759BCAFEA6E805CD0E20@BYAPR05MB4438.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6916009)(54906003)(476003)(7416002)(316002)(4326008)(3846002)(36756003)(6116002)(99286004)(53936002)(68736007)(76176011)(478600001)(486006)(6486002)(2616005)(102836004)(446003)(2906002)(6246003)(6506007)(53546011)(11346002)(305945005)(66476007)(186003)(66556008)(6512007)(25786009)(64756008)(76116006)(66946007)(6436002)(66446008)(14454004)(256004)(91956017)(66066001)(7736002)(14444005)(26005)(81156014)(5660300002)(81166006)(86362001)(229853002)(8936002)(8676002)(73956011)(71190400001)(33656002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4438;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oh9HiG4Du3ImRth6oXzSGP9g2/7EdaDEnJPHuZXZPO7pxdPdaCbpbgD/4SJKBkyo9hDKfbuIlIaNnrKtxoiHQOsU55gMEGwiH3jROp0iLVc/rlWzgWj6KvpnW7a4RWtJGh2tBLX+pUcsM71Jo0lhpdZIF52qvpDI+SyFugESnXJP+91n9uRpZX3I7316cVmxanMUI9a5RDBoYW0R96KqrfwPkFmaFvUKBxTHt19NFdexAF4YlwwbMYCQu5ZUWVtdgEnpm0SHRKIIechOj6pVOIYa9lPnTqvxqy3zthFn3KaqN9sUOySF2QoKw7Qv4bmvwrc/CLK2WmyU5YOuSd+UkV7WMZr4phqgJuy+eybs5sFF5VUrj5PZDI1SGGJjVj3olhrTNRseW4+rE/L4n/MjiBdGwcKVAujW5pjDQ/HyYFA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3595B261F3D2664D8EF554FAC42BD6BA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e54a673-c02f-4778-b474-08d6f9d667d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 01:34:17.7818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4438
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMjUsIDIwMTksIGF0IDM6MDIgUE0sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBp
bnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gNi8xMi8xOSAxMTo0OCBQTSwgTmFkYXYgQW1pdCB3
cm90ZToNCj4+IFJ1bm5pbmcgc3lzYmVuY2ggb24gZGF4IHcvZW11bGF0ZWQtcG1lbSwgd3JpdGUt
Y2FjaGUgZGlzYWJsZWQsIGFuZA0KPj4gdmFyaW91cyBtaXRpZ2F0aW9ucyAoUFRJLCBTcGVjdHJl
LCBNRFMpIGRpc2FibGVkIG9uIEhhc3dlbGw6DQo+PiANCj4+IHN5c2JlbmNoIGZpbGVpbyAtLWZp
bGUtdG90YWwtc2l6ZT0zRyAtLWZpbGUtdGVzdC1tb2RlPXJuZHdyIFwNCj4+ICAtLWZpbGUtaW8t
bW9kZT1tbWFwIC0tdGhyZWFkcz00IC0tZmlsZS1mc3luYy1tb2RlPWZkYXRhc3luYyBydW4NCj4+
IA0KPj4gCQkJZXZlbnRzIChhdmcvc3RkZGV2KQ0KPj4gCQkJLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4gIDUuMi1yYzM6CQkxMjQ3NjY5LjAwMDAvMTYwNzUuMzkNCj4+ICArcGF0Y2hzZXQ6CQkxMjkw
NjA3LjAwMDAvMTM2MTcuNTYgKCszLjQlKQ0KPiANCj4gV2h5IGRpZCB5b3UgZGVjaWRlIG9uIGRp
c2FibGluZyB0aGUgc2lkZS1jaGFubmVsIG1pdGlnYXRpb25zPyAgV2hpbGUNCj4gdGhleSBtYWtl
IHRoaW5ncyBzbG93ZXIsIHRoZXkncmUgYWxzbyBnb2luZyB0byBiZSB3aXRoIHVzIGZvciBhIHdo
aWxlLA0KPiBzbyB0aGV5IHJlYWxseSBhcmUgcGFydCBvZiByZWFsLXdvcmxkIHRlc3RpbmcgSU1O
SE8uICBJJ2QgYmUgY3VyaW91cw0KPiB3aGV0aGVyIHRoaXMgc2V0IGhhcyBtb3JlIG9yIGxlc3Mg
b2YgYW4gYWR2YW50YWdlIHdoZW4gYWxsIHRoZQ0KPiBtaXRpZ2F0aW9ucyBhcmUgb24uDQoNCkl0
IHNlZW1lZCByZWFzb25hYmxlIHNpbmNlIEkgd2FudGVkIHRvIGF2b2lkIGFsbCBraW5kIG9mIOKA
nG5vaXNl4oCdLiBJIHByZXN1bWUNCnRoZSByZWxhdGl2ZSBzcGVlZHVwIHdvdWxkIGJlIHNtYWxs
ZXIsIGR1ZSB0byB0aGUgb3ZlcmhlYWQgb2YgdGhlDQptaXRpZ2F0aW9ucywgd291bGQgYmUgc21h
bGxlci4gTm90ZSB0aGF0IGluIHRoaXMgYmVuY2htYXJrIGV2ZXJ5IFRMQg0KaW52YWxpZGF0aW9u
IGlzIG9mIGEgc2luZ2xlIGVudHJ5LiBUaGUgYmVuZWZpdCAoaW4gdGhlIHRlcm1zIG9mIGFic29s
dXRlDQp0aW1lIHNhdmVkKSB3b3VsZCBoYXZlIGJlZW4gZ3JlYXRlciBpZiBhIGZsdXNoIHdhcyBv
ZiBtdWx0aXBsZSBlbnRyaWVzLg0KDQo+IEFsc28sIHdoeSBvbmx5IDQgdGhyZWFkcz8gIERvZXMg
dGhpcyBzZXQgaGVscCBtb3N0IHdoZW4gdXNpbmcgYSBtb2RlcmF0ZQ0KPiBudW1iZXIgb2YgdGhy
ZWFkcyBzaW5jZSB0aGUgbG9jYWwgYW5kIHJlbW90ZSBjb3N0IGFyZSAocmVsYXRpdmVseSkgY2xv
c2UNCj4gdnMuIGEgbGFyZ2Ugc3lzdGVtIHdoZXJlIGRvaW5nIGxvdHMgb2YgcmVtb3RlIGZsdXNo
ZXMgaXMgKndheSogbW9yZQ0KPiB0aW1lLWNvbnN1bWluZyB0aGFuIGEgbG9jYWwgZmx1c2g/DQoN
CkRvbuKAmXQgb3ZlcnRoaW5rIGl0LiBNeSBzZXJ2ZXIgd2FzIGJ1c3kgZG9pbmcgc29tZXRoaW5n
IGVsc2UsIHNvIEkgd2FzDQpydW5uaW5nIHRoZSB0ZXN0cyBvbiBhIGxhbWUgZGVza3RvcCBJIGhh
dmUuIEkgd2lsbCByZXJ1biBpdCBvbiBhIGJpZ2dlcg0KbWFjaGluZS4NCg0KSSBwcmVzdW1lIHRo
ZSBwZXJmb3JtYW5jZSBiZW5lZml0IHdpbGwgYmUgc21hbGxlciB3aGVuIG1vcmUgY29yZXMgYXJl
DQppbnZvbHZlZCwgc2luY2UgdGhlIFRMQiBzaG9vdGRvd24gdGltZSB3aWxsIGJlIGRvbWluYXRl
ZCBieSB0aGUgaW50ZXItY29yZQ0KY29tbXVuaWNhdGlvbiB0aW1lIChJUEkrY2FjaGUgY29oZXJl
bmN5KSBhbmQgdGhlIHRhaWwgbGF0ZW5jeSBvZiB0aGUgSVBJDQpkZWxpdmVyeSAoaWYgaW50ZXJy
dXB0cyBhcmUgZGlzYWJsZWQgb24gdGhlIHRhcmdldCkuDQoNCkkgYW0gd29ya2luZyBvbiBzb21l
IHBhdGNoZXMgdG8gcmVkdWNlIHRoZXNlIG92ZXJoZWFkcyBhcyB3ZWxsLg0KDQo=
