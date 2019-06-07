Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C67FC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC07208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NdPqDdy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfFGF2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:28:51 -0400
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:40966
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfFGF2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkGkIH0nE3kg8WZvLfzXQkLzPw2GNHYdtLortfs08zY=;
 b=NdPqDdy9cu8GjYwUBX15wv1wpxQscmaqCYUQKEOUS2ZLJpF6EzM6pnrf5gdkY/YTSKBT/n4IriQPHkFA9+DSZhZzt+iA7krcTaJCli8F9KZbB1oQMAL3oUC9Pu8UmUzO7p5Vh50YRybOkw1iyFL733DsYuZiZPGbl1q4iz2Qkaw=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB6740.namprd05.prod.outlook.com (10.167.240.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 05:28:44 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 05:28:44 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Topic: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Index: AQHVF3tKnfrC/xKd0kyiVp6wMVDUEqaFvMuAgAAFIICAAAPtAIAABb2AgAnpMoA=
Date:   Fri, 7 Jun 2019 05:28:44 +0000
Message-ID: <B41673A7-6CA3-440D-87AA-59E07BE8B656@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-12-namit@vmware.com>
 <CALCETrU0=BpGy5OQezQ7or33n-EFgBVDNe5g8prSUjL2SoRAwA@mail.gmail.com>
 <5F153080-D7A7-4054-AB4A-AEDD5F82E0B9@vmware.com>
 <48CECB5C-CA5B-4AD0-9DA5-6759E8FEDED7@amacapital.net>
 <67BFA611-F69E-4AE4-A03F-2EF546DC291A@vmware.com>
In-Reply-To: <67BFA611-F69E-4AE4-A03F-2EF546DC291A@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04b14815-0a51-4876-b9d7-08d6eb09026f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR05MB6740;
x-ms-traffictypediagnostic: BL0PR05MB6740:
x-microsoft-antispam-prvs: <BL0PR05MB6740438F559EB7CA2D42DE30D0100@BL0PR05MB6740.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(346002)(396003)(189003)(199004)(91956017)(66556008)(54906003)(6116002)(6436002)(6486002)(66476007)(6246003)(99286004)(66446008)(86362001)(316002)(76116006)(5660300002)(186003)(102836004)(4326008)(486006)(110136005)(36756003)(6512007)(8676002)(71200400001)(68736007)(66066001)(446003)(8936002)(14444005)(26005)(64756008)(73956011)(14454004)(305945005)(66946007)(53936002)(478600001)(83716004)(71190400001)(81166006)(53546011)(6506007)(2616005)(11346002)(33656002)(7736002)(82746002)(2906002)(25786009)(229853002)(76176011)(7416002)(256004)(3846002)(81156014)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB6740;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L9T511YbHupd06IcD2NiXsdSeh+/IKMFwQRV/pM+HXWNeak6EuL83ssnLFjHL5QHf2BnTGjeDNoN0PjlLqM0l1RQA5rpBJOMfWmUNdY6pcBV5xslaLUE/wNN8BOmPFEjioqCjbi5EccAI62GTwfJq2PbEF7tD1RA8l9RyZtU9aQ0dweF5nOLnZxi1jjSXXWyKFOq2iPU7mjy6dn+CqriKU82zQ05x/jXYmqKlp4ADvwF0NNzHKVvyAFg+Xy0MgsdPgERrGf7ywetjexSVeUd9Il8EIEBrQTpsPav87zgpKdhJbDhUGgQ0KVRLO9oW33SRb8xTjrmefzRuEqcGXCgck/mEXW5ReUpcsuXpfWsQdDqxR840Koz0zFO3yxXxf6TqVjKGTvNuQa3eM+TfE2u9PHTEwEBgxOoHe3lqYfhIc4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FBD7BBAD0C33A4489575752E35052F3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b14815-0a51-4876-b9d7-08d6eb09026f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 05:28:44.5904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB6740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMzEsIDIwMTksIGF0IDM6MDcgUE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5j
b20+IHdyb3RlOg0KPiANCj4+IE9uIE1heSAzMSwgMjAxOSwgYXQgMjo0NyBQTSwgQW5keSBMdXRv
bWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cm90ZToNCj4+IA0KPj4gDQo+PiBPbiBNYXkg
MzEsIDIwMTksIGF0IDI6MzMgUE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3Rl
Og0KPj4gDQo+Pj4+IE9uIE1heSAzMSwgMjAxOSwgYXQgMjoxNCBQTSwgQW5keSBMdXRvbWlyc2tp
IDxsdXRvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+PiANCj4+Pj4+IE9uIFRodSwgTWF5IDMwLCAy
MDE5IGF0IDExOjM3IFBNIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+
Pj4gV2hlbiB3ZSBmbHVzaCB1c2Vyc3BhY2UgbWFwcGluZ3MsIHdlIGNhbiBkZWZlciB0aGUgVExC
IGZsdXNoZXMsIGFzIGxvbmcNCj4+Pj4+IHRoZSBmb2xsb3dpbmcgY29uZGl0aW9ucyBhcmUgbWV0
Og0KPj4+Pj4gDQo+Pj4+PiAxLiBObyB0YWJsZXMgYXJlIGZyZWVkLCBzaW5jZSBvdGhlcndpc2Ug
c3BlY3VsYXRpdmUgcGFnZSB3YWxrcyBtaWdodA0KPj4+Pj4gY2F1c2UgbWFjaGluZS1jaGVja3Mu
DQo+Pj4+PiANCj4+Pj4+IDIuIE5vIG9uZSB3b3VsZCBhY2Nlc3MgdXNlcnNwYWNlIGJlZm9yZSBm
bHVzaCB0YWtlcyBwbGFjZS4gU3BlY2lmaWNhbGx5LA0KPj4+Pj4gTk1JIGhhbmRsZXJzIGFuZCBr
cHJvYmVzIHdvdWxkIGF2b2lkIGFjY2Vzc2luZyB1c2Vyc3BhY2UuDQo+Pj4+IA0KPj4+PiBJIHRo
aW5rIEkgbmVlZCB0byBhc2sgdGhlIGJpZyBwaWN0dXJlIHF1ZXN0aW9uLiAgV2hlbiBzb21lb25l
IGNhbGxzDQo+Pj4+IGZsdXNoX3RsYl9tbV9yYW5nZSgpIChvciB0aGUgb3RoZXIgZW50cnkgcG9p
bnRzKSwgaWYgbm8gcGFnZSB0YWJsZXMNCj4+Pj4gd2VyZSBmcmVlZCwgdGhleSB3YW50IHRoZSBn
dWFyYW50ZWUgdGhhdCBmdXR1cmUgYWNjZXNzZXMgKGluaXRpYXRlZA0KPj4+PiBvYnNlcnZhYmx5
IGFmdGVyIHRoZSBmbHVzaCByZXR1cm5zKSB3aWxsIG5vdCB1c2UgcGFnaW5nIGVudHJpZXMgdGhh
dA0KPj4+PiB3ZXJlIHJlcGxhY2VkIGJ5IHN0b3JlcyBvcmRlcmVkIGJlZm9yZSBmbHVzaF90bGJf
bW1fcmFuZ2UoKS4gIFdlIGFsc28NCj4+Pj4gbmVlZCB0aGUgZ3VhcmFudGVlIHRoYXQgYW55IGVm
ZmVjdHMgZnJvbSBhbnkgbWVtb3J5IGFjY2VzcyB1c2luZyB0aGUNCj4+Pj4gb2xkIHBhZ2luZyBl
bnRyaWVzIHdpbGwgYmVjb21lIGdsb2JhbGx5IHZpc2libGUgYmVmb3JlDQo+Pj4+IGZsdXNoX3Rs
Yl9tbV9yYW5nZSgpLg0KPj4+PiANCj4+Pj4gSSdtIHdvbmRlcmluZyBpZiByZWNlaXB0IG9mIGFu
IElQSSBpcyBlbm91Z2ggdG8gZ3VhcmFudGVlIGFueSBvZiB0aGlzLg0KPj4+PiBJZiBDUFUgMSBz
ZXRzIGEgZGlydHkgYml0IGFuZCBDUFUgMiB3cml0ZXMgdG8gdGhlIEFQSUMgdG8gc2VuZCBhbiBJ
UEkNCj4+Pj4gdG8gQ1BVIDEsIGF0IHdoYXQgcG9pbnQgaXMgQ1BVIDIgZ3VhcmFudGVlZCB0byBi
ZSBhYmxlIHRvIG9ic2VydmUgdGhlDQo+Pj4+IGRpcnR5IGJpdD8gIEFuIGludGVycnVwdCBlbnRy
eSB0b2RheSBpcyBmdWxseSBzZXJpYWxpemluZyBieSB0aGUgdGltZQ0KPj4+PiBpdCBmaW5pc2hl
cywgYnV0IGludGVycnVwdCBlbnRyaWVzIGFyZSBlcGljbHkgc2xvdywgYW5kIEkgZG9uJ3Qga25v
dw0KPj4+PiBpZiB0aGUgQVBJQyB3YWl0cyBsb25nIGVub3VnaC4gIEhlY2ssIHdoYXQgaWYgSVJR
cyBhcmUgb2ZmIG9uIHRoZQ0KPj4+PiByZW1vdGUgQ1BVPyAgVGhlcmUgYXJlIGEgaGFuZGZ1bCBv
ZiBwbGFjZXMgd2hlcmUgd2UgdG91Y2ggdXNlciBtZW1vcnkNCj4+Pj4gd2l0aCBJUlFzIG9mZiwg
YW5kIGl0J3MgKHNhZGx5KSBwb3NzaWJsZSBmb3IgdXNlciBjb2RlIHRvIHR1cm4gb2ZmDQo+Pj4+
IElSUXMgd2l0aCBpb3BsKCkuDQo+Pj4+IA0KPj4+PiBJICp0aGluayogdGhhdCBJbnRlbCBoYXMg
c3RhdGVkIHJlY2VudGx5IHRoYXQgU01UIHNpYmxpbmdzIGFyZQ0KPj4+PiBndWFyYW50ZWVkIHRv
IHN0b3Agc3BlY3VsYXRpbmcgd2hlbiB5b3Ugd3JpdGUgdG8gdGhlIEFQSUMgSUNSIHRvIHBva2UN
Cj4+Pj4gdGhlbSwgYnV0IFNNVCBpcyB2ZXJ5IHNwZWNpYWwuDQo+Pj4+IA0KPj4+PiBNeSBnZW5l
cmFsIGNvbmNsdXNpb24gaXMgdGhhdCBJIHRoaW5rIHRoZSBjb2RlIG5lZWRzIHRvIGRvY3VtZW50
IHdoYXQNCj4+Pj4gaXMgZ3VhcmFudGVlZCBhbmQgd2h5Lg0KPj4+IA0KPj4+IEkgdGhpbmsgSSBt
aWdodCBoYXZlIG1hbmFnZWQgdG8gY29uZnVzZSB5b3Ugd2l0aCBhIGJ1ZyBJIG1hZGUgKGxhc3Qg
bWludXRlDQo+Pj4gYnVnIHdoZW4gSSB3YXMgZG9pbmcgc29tZSBjbGVhbnVwKS4gVGhpcyBidWcg
ZG9lcyBub3QgYWZmZWN0IHRoZSBwZXJmb3JtYW5jZQ0KPj4+IG11Y2gsIGJ1dCBpdCBtaWdodCBs
ZWQgeW91IHRvIHRoaW5rIHRoYXQgSSB1c2UgdGhlIEFQSUMgc2VuZGluZyBhcw0KPj4+IHN5bmNo
cm9uaXphdGlvbi4NCj4+PiANCj4+PiBUaGUgaWRlYSBpcyBub3QgZm9yIHVzIHRvIHJlbHkgb24g
d3JpdGUgdG8gSUNSIGFzIHNvbWV0aGluZyBzZXJpYWxpemluZy4gVGhlDQo+Pj4gZmxvdyBzaG91
bGQgYmUgYXMgZm9sbG93czoNCj4+PiANCj4+PiANCj4+PiAgQ1BVMCAgICAgICAgICAgICAgICAg
ICAgQ1BVMQ0KPj4+IA0KPj4+IGZsdXNoX3RsYl9tbV9yYW5nZSgpDQo+Pj4gX19zbXBfY2FsbF9m
dW5jdGlvbl9tYW55KCkNCj4+PiBbIHByZXBhcmUgY2FsbF9zaW5nbGVfZGF0YSAoY3NkKSBdDQo+
Pj4gWyBsb2NrIGNzZCBdIA0KPj4+IFsgc2VuZCBJUEkgXQ0KPj4+ICAoKikNCj4+PiBbIHdhaXQg
Zm9yIGNzZCB0byBiZSB1bmxvY2tlZCBdDQo+Pj4gICAgICAgICAgICAgICAgICBbIGludGVycnVw
dCBdDQo+Pj4gICAgICAgICAgICAgICAgICBbIGNvcHkgY3NkIGluZm8gdG8gc3RhY2sgXQ0KPj4+
ICAgICAgICAgICAgICAgICAgWyBjc2QgdW5sb2NrIF0NCj4+PiBbIGZpbmQgY3NkIGlzIHVubG9j
a2VkIF0NCj4+PiBbIGNvbnRpbnVlICgqKikgXQ0KPj4+ICAgICAgICAgICAgICAgICAgWyBmbHVz
aCBUTEIgXQ0KPj4+IA0KPj4+IA0KPj4+IEF0ICgqKikgdGhlIHBhZ2VzIG1pZ2h0IGJlIHJlY3lj
bGVkLCB3cml0dGVuLWJhY2sgdG8gZGlzaywgZXRjLiBOb3RlIHRoYXQNCj4+PiBkdXJpbmcgKCop
LCBDUFUwIG1pZ2h0IGRvIHNvbWUgbG9jYWwgVExCIGZsdXNoZXMsIG1ha2luZyBpdCB2ZXJ5IGxp
a2VseSB0aGF0DQo+Pj4gQ1NEIHdpbGwgYmUgdW5sb2NrZWQgYnkgdGhlIHRpbWUgaXQgZ2V0cyB0
aGVyZS4NCj4+PiANCj4+PiBBcyB5b3UgY2FuIHNlZSwgSSBkb27igJl0IHJlbHkgb24gYW55IHNw
ZWNpYWwgbWljcm8tYXJjaGl0ZWN0dXJhbCBiZWhhdmlvci4NCj4+PiBUaGUgc3luY2hyb25pemF0
aW9uIGlzIGRvbmUgcHVyZWx5IGluIHNvZnR3YXJlLg0KPj4+IA0KPj4+IERvZXMgaXQgbWFrZSBt
b3JlIHNlbnNlIG5vdz8NCj4+IA0KPj4gWWVzLiAgSGF2ZSB5b3UgYmVuY2htYXJrZWQgdGhpcz8N
Cj4gDQo+IFBhcnRpYWxseS4gTnVtYmVycyBhcmUgaW5kZWVkIHdvcnNlLiBIZXJlIGFyZSBwcmVs
aW1pbmFyeSByZXN1bHRzLCBjb21wYXJpbmcNCj4gdG8gdjEgKGNvbmN1cnJlbnQpOg0KPiANCj4g
CW5fdGhyZWFkcwliZWZvcmUJCWNvbmN1cnJlbnQJK2FzeW5jDQo+IAktLS0tLS0tLS0JLS0tLS0t
CQktLS0tLS0tLS0tIAktLS0tLS0NCj4gCTEJCTY2MQkJNjYzCQk2NjMNCj4gCTIJCTE0MzYJCTEy
MjUgKC0xNCUpCTExMTUgKC0yMiUpDQo+IAk0CQkxNTcxCQkxNDIxICgtMTAlKQkxMjg5ICgtMTgl
KQ0KPiANCj4gTm90ZSB0aGF0IHRoZSBiZW5lZml0IG9mIOKAnGFzeW5jIiB3b3VsZCBiZSBncmVh
dGVyIGlmIHRoZSBpbml0aWF0b3IgZG9lcyBub3QNCj4gZmx1c2ggdGhlIFRMQiBhdCBhbGwuIFRo
aXMgbWlnaHQgaGFwcGVuIGluIHRoZSBjYXNlIG9mIGtzd2FwZCwgZm9yIGV4YW1wbGUuDQo+IExl
dCBtZSB0cnkgc29tZSBtaWNyby1vcHRpbWl6YXRpb25zIGZpcnN0LCBydW4gbW9yZSBiZW5jaG1h
cmtzIGFuZCBnZXQgYmFjaw0KPiB0byB5b3UuDQoNClNvIEkgcmFuIHNvbWUgbW9yZSBiZW5jaG1h
cmtpbmcgKG15IGJlbmNobWFyayBpcyBub3QgdmVyeSBzdWl0YWJsZSksIGFuZCB0cmllZA0KbW9y
ZSBzdHVmZiB0aGF0IGRpZCBub3QgaGVscCAoY2hlY2tpbmcgZm9yIG1vcmUgd29yayBiZWZvcmUg
cmV0dXJuaW5nIGZyb20gdGhlDQpJUEkgaGFuZGxlciwgYW5kIGF2b2lkIHJlZHVuZGFudCBJUElz
IGluIHN1Y2ggY2FzZSkuDQoNCkFueWhvdywgd2l0aCBhIGZpeGVkIHZlcnNpb24sIEkgcmFuIGEg
bW9yZSBzdGFuZGFyZCBiZW5jaG1hcmsgb24gREFYOg0KDQokIG1rZnMuZXh0NCAvZGV2L3BtZW0w
DQokIG1vdW50IC1vIGRheCAvZGV2L3BtZW0wIC9tbnQvbWVtDQokIGNkIC9tbnQvbWVtDQokIGJh
c2ggLWMgJ2VjaG8gMCA+IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9lODIwX3BtZW0vbmRidXMwL3Jl
Z2lvbjAvbmFtZXNwYWNlMC4wL2Jsb2NrL3BtZW0wL2RheC93cml0ZV9jYWNoZeKAmQ0KJCBzeXNi
ZW5jaCBmaWxlaW8gLS1maWxlLXRvdGFsLXNpemU9M0cgLS1maWxlLXRlc3QtbW9kZT1ybmR3ciAJ
XA0KCS0tZmlsZS1pby1tb2RlPW1tYXAgLS10aHJlYWRzPTQgLS1maWxlLWZzeW5jLW1vZGU9ZmRh
dGFzeW5jIHByZXBhcmUNCiQgc3lzYmVuY2ggZmlsZWlvIC0tZmlsZS10b3RhbC1zaXplPTNHIC0t
ZmlsZS10ZXN0LW1vZGU9cm5kd3IgCVwNCgktLWZpbGUtaW8tbW9kZT1tbWFwIC0tdGhyZWFkcz00
IC0tZmlsZS1mc3luYy1tb2RlPWZkYXRhc3luYyBydW4NCg0KKCBhcyB5b3UgY2FuIHNlZSwgSSBk
aXNhYmxlZCB0aGUgd3JpdGUtY2FjaGUsIHNpbmNlIG15IG1hY2hpbmUgZG9lcyBub3QgaGF2ZQ0K
ICBjbHdiL2NsZmx1c2hvcHQgYW5kIGNsZmx1c2ggYXBwZWFycyB0byBiZWNvbWUgYSBib3R0bGVu
ZWNrIG90aGVyd2lzZSApDQoNCg0KVGhlIHJlc3VsdHMgYXJlOg0KCQkJCWV2ZW50cyAoYXZnL3N0
ZGRldikNCgkJCQktLS0tLS0tLS0tLS0tLS0tLS0tDQpiYXNlCQkJCTEyNjM2ODkuMDAwMC8xMTQ4
MS4xMA0KY29uY3VycmVudAkJCTEzMTAxMjMuNTAwMC8xOTIwNS43OQkoKzMuNiUpDQpjb25jdXJy
ZW50ICsgYXN5bmMJCTEzMjY3NTAuMjUwMC8yNDU2My42MQkoKzQuOSUpDQoNClNvIHdoaWNoIHZl
cnNpb24gZG8geW91IHdhbnQgbWUgdG8gc3VibWl0PyBXaXRoIG9yIHdpdGhvdXQgdGhlIGFzeW5j
IHBhcnQ/DQoNCg==
