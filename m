Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA2EC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC69A2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ZkOGVbKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfFGQ6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:58:38 -0400
Received: from mail-eopbgr800052.outbound.protection.outlook.com ([40.107.80.52]:33205
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729241AbfFGQ6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFl/Dp9a5yWD/duS1CcrWJs1biltT9nd+fYDc69hdSs=;
 b=ZkOGVbKzdBvwesNxKcUIymnk6tO6iyHKIvvymvL9d+aQVRlvKBiZbZGApyPqn+8C1IV95BphMnPiTa109XHh6Qlbm6+6szsM6bfxxZSiETPN/FcoPKf8mfq7SIlftQHtr0XgMYiNzrHf2GR13Lq8YJchegv0YgimHbziNptV9Xs=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4882.namprd05.prod.outlook.com (52.132.15.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 16:58:33 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 16:58:33 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 10/15] static_call: Add basic static call infrastructure
Thread-Topic: [PATCH 10/15] static_call: Add basic static call infrastructure
Thread-Index: AQHVG6Hind15VmKQ/km2cDlqpRtMGKaPO4AAgACjToCAAAW2AIAAiLCA
Date:   Fri, 7 Jun 2019 16:58:33 +0000
Message-ID: <9DE75F18-72FE-4FAF-AD98-5E81DBD9E27F@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.125037517@infradead.org>
 <DD54886F-77C6-4230-A711-BF10DD44C52C@vmware.com>
 <20190607082851.GV3419@hirez.programming.kicks-ass.net>
 <CAKv+Gu-rsZ2UsyEHbsZcSv9VVnFBqG70q+vk6thgMGFBi+vLSA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-rsZ2UsyEHbsZcSv9VVnFBqG70q+vk6thgMGFBi+vLSA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55ca0bbd-baad-4914-52e1-08d6eb696005
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR05MB4882;
x-ms-traffictypediagnostic: BL0PR05MB4882:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BL0PR05MB48824AA67EA3AD9A89F11DA5D0100@BL0PR05MB4882.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(51444003)(189003)(199004)(4326008)(53936002)(446003)(305945005)(14444005)(83716004)(316002)(71200400001)(71190400001)(99286004)(256004)(478600001)(66946007)(25786009)(73956011)(33656002)(14454004)(8936002)(66556008)(66476007)(91956017)(6246003)(76116006)(6506007)(53546011)(102836004)(76176011)(68736007)(6436002)(64756008)(36756003)(66446008)(2906002)(966005)(82746002)(6512007)(86362001)(8676002)(7416002)(486006)(81166006)(45080400002)(81156014)(66066001)(7736002)(186003)(6916009)(6116002)(3846002)(5660300002)(6486002)(6306002)(2616005)(229853002)(476003)(11346002)(26005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4882;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vL88kSNK8U6v+6ulXs6n0ZfygpvXkc98Xhh58lbEdF8yhb4nbRFdUtkkOxjecH46HPLeitDDY+BWQ4ZuLgjbGRCEfgDzb5j8NlDKXQHigB8X8aXBJ/GUk+OYwEHn7NF4LL5VPJFMtzrXvs2vZNOm8IUWVM5kudyMl48sU9qZVI2UlBtitzBw3RRSIgr1si3nkrV3yK8VEDuiUpQVafjJPPpI/AH7oduPTWYyQTNCVQ0hyKKaDZ4VAHqB67z4JJyj0BKxDM86pC1/bOSpnQ4xv+c0azGJQiMfGnfISDUkFdVw/R5hmEbL0wjnf8Z6+ra9ASs6uy0OlIcBEXxfIAyN5DVYEzyEi2OMHJtk/OtJFXWfUwu2ynly4N1RJqjGv+vK3ds+sJC3UGvg6sEj59k5N/2Kd4SJphlY8PnHQUdZ4iQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C84494AB8B4DD0469AB046A6502A4642@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ca0bbd-baad-4914-52e1-08d6eb696005
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 16:58:33.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gNywgMjAxOSwgYXQgMTo0OSBBTSwgQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1
dmVsQGxpbmFyby5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCA3IEp1biAyMDE5IGF0IDEwOjI5
LCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPj4gT24gVGh1
LCBKdW4gMDYsIDIwMTkgYXQgMTA6NDQ6MjNQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+
Pj4gKyAqIFVzYWdlIGV4YW1wbGU6DQo+Pj4+ICsgKg0KPj4+PiArICogICAjIFN0YXJ0IHdpdGgg
dGhlIGZvbGxvd2luZyBmdW5jdGlvbnMgKHdpdGggaWRlbnRpY2FsIHByb3RvdHlwZXMpOg0KPj4+
PiArICogICBpbnQgZnVuY19hKGludCBhcmcxLCBpbnQgYXJnMik7DQo+Pj4+ICsgKiAgIGludCBm
dW5jX2IoaW50IGFyZzEsIGludCBhcmcyKTsNCj4+Pj4gKyAqDQo+Pj4+ICsgKiAgICMgRGVmaW5l
IGEgJ215X2tleScgcmVmZXJlbmNlLCBhc3NvY2lhdGVkIHdpdGggZnVuY19hKCkgYnkgZGVmYXVs
dA0KPj4+PiArICogICBERUZJTkVfU1RBVElDX0NBTEwobXlfa2V5LCBmdW5jX2EpOw0KPj4+PiAr
ICoNCj4+Pj4gKyAqICAgIyBDYWxsIGZ1bmNfYSgpDQo+Pj4+ICsgKiAgIHN0YXRpY19jYWxsKG15
X2tleSwgYXJnMSwgYXJnMik7DQo+Pj4+ICsgKg0KPj4+PiArICogICAjIFVwZGF0ZSAnbXlfa2V5
JyB0byBwb2ludCB0byBmdW5jX2IoKQ0KPj4+PiArICogICBzdGF0aWNfY2FsbF91cGRhdGUobXlf
a2V5LCBmdW5jX2IpOw0KPj4+PiArICoNCj4+Pj4gKyAqICAgIyBDYWxsIGZ1bmNfYigpDQo+Pj4+
ICsgKiAgIHN0YXRpY19jYWxsKG15X2tleSwgYXJnMSwgYXJnMik7DQo+Pj4gDQo+Pj4gSSB0aGlu
ayB0aGF0IHRoaXMgY2FsbGluZyBpbnRlcmZhY2UgaXMgbm90IHZlcnkgaW50dWl0aXZlLg0KPj4g
DQo+PiBZZWFoLCBpdCBpcyBzb21ld2hhdCB1bmZvcnR1bmF0ZS4uDQo+IA0KPiBBbm90aGVyIHRo
aW5nIEkgYnJvdWdodCB1cCBhdCB0aGUgdGltZSBpcyB0aGF0IGl0IHdvdWxkIGJlIHVzZWZ1bCB0
bw0KPiBoYXZlIHRoZSBhYmlsaXR5IHRvICdyZXNldCcgYSBzdGF0aWMgY2FsbCB0byBpdHMgZGVm
YXVsdCB0YXJnZXQuIEUuZy4sDQo+IGZvciBjcnlwdG8gbW9kdWxlcyB0aGF0IGltcGxlbWVudCBh
biBhY2NlbGVyYXRlZCB2ZXJzaW9uIG9mIGEgbGlicmFyeQ0KPiBpbnRlcmZhY2UsIHJlbW92aW5n
IHRoZSBtb2R1bGUgc2hvdWxkIHJldmVydCB0aG9zZSBjYWxsIHNpdGVzIGJhY2sgdG8NCj4gdGhl
IG9yaWdpbmFsIHRhcmdldCwgd2l0aG91dCBwdXR0aW5nIGEgZGlzcHJvcG9ydGlvbmF0ZSBidXJk
ZW4gb24gdGhlDQo+IG1vZHVsZSBpdHNlbGYgdG8gaW1wbGVtZW50IHRoZSBsb2dpYyB0byBzdXBw
b3J0IHRoaXMuDQo+IA0KPiANCj4+PiBJIHVuZGVyc3RhbmQgdGhhdA0KPj4+IHRoZSBtYWNyb3Mv
b2JqdG9vbCBjYW5ub3QgYWxsb3cgdGhlIGNhbGxpbmcgaW50ZXJmYWNlIHRvIGJlIGNvbXBsZXRl
bHkNCj4+PiB0cmFuc3BhcmVudCAoYXMgY29tcGlsZXIgcGx1Z2luIGNvdWxkKS4gQnV0LCBjYW4g
dGhlIG1hY3JvcyBiZSB1c2VkIHRvDQo+Pj4gcGFzdGUgdGhlIGtleSB3aXRoIHRoZSDigJxzdGF0
aWNfY2FsbOKAnT8gSSB0aGluayB0aGF0IGhhdmluZyBzb21ldGhpbmcgbGlrZToNCj4+PiANCj4+
PiAgc3RhdGljX2NhbGxfX2Z1bmMoYXJnMSwgYXJnMikNCj4+PiANCj4+PiBJcyBtb3JlIHJlYWRh
YmxlIHRoYW4NCj4+PiANCj4+PiAgc3RhdGljX2NhbGwoZnVuYywgYXJnMSwgYXJnMikNCj4+IA0K
Pj4gRG9lc24ndCByZWFsbHkgbWFrZSBpdCBtdWNoIGJldHRlciBmb3IgbWU7IEkgdGhpbmsgSSdk
IHByZWZlciB0byBzd2l0Y2gNCj4+IHRvIHRoZSBHQ0MgcGx1Z2luIHNjaGVtZSBvdmVyIHRoaXMu
ICBJU1RSIHRoZXJlIGJlaW5nIHNvbWUgcHJvcG90eXBlcw0KPj4gdGhlcmUsIGJ1dCBJIGNvdWxk
bid0IHF1aWNrbHkgbG9jYXRlIHRoZW0uDQo+IA0KPiBJIGltcGxlbWVudGVkIHRoZSBHQ0MgcGx1
Z2luIGhlcmUNCj4gDQo+IGh0dHBzOi8vbmFtMDQuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXJuZWwub3JnJTJGcHViJTJGc2NtJTJGbGlu
dXglMkZrZXJuZWwlMkZnaXQlMkZhcmRiJTJGbGludXguZ2l0JTJGbG9nJTJGJTNGaCUzRHN0YXRp
Yy1jYWxscyZhbXA7ZGF0YT0wMiU3QzAxJTdDbmFtaXQlNDB2bXdhcmUuY29tJTdDZDMxYzQ3MTM2
NDBjNDRhNjUxYmYwOGQ2ZWIyNTBmYWElN0NiMzkxMzhjYTNjZWU0YjRhYTRkNmNkODNkOWRkNjJm
MCU3QzAlN0MwJTdDNjM2OTU0OTQxNzcxOTY0NzU4JmFtcDtzZGF0YT1oN1J0VDMzRTlGTWFwTFpi
QXU5YVRmalJFUDVrWHJNMG8yUVExV3BiRENNJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBidXQg
SUlSQywgYWxsIGl0IGRvZXMgaXMgYW5ub3RhdGUgY2FsbCBzaXRlcyBleGFjdGx5IGhvdyBvYmp0
b29sIGRvZXMgaXQuDQoNCkkgZGlkIG5vdCBzZWUgeW91ciB2ZXJzaW9uIGJlZm9yZSBJIG1hZGUg
bWluZSBmb3IgYSBzaW1pbGFyIChidXQgc2xpZ2h0bHkNCmRpZmZlcmVudCkgcHVycG9zZToNCg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE4MTIzMTA3MjExMi4yMTA1MS00LW5hbWl0
QHZtd2FyZS5jb20vDQoNCk15IHZlcnNpb24sIEkgdGhpbmssIGlzIG1vcmUgZ2VuZXJpYyAoSSBk
b27igJl0IHRoaW5rIHlvdXJzIGNvbnNpZGVyIGNhbGxzDQp0aGF0IGhhdmUgYSByZXR1cm4gdmFs
dWUpLiBBbnlob3csIEkgYW0gc3VyZSB5b3Uga25vdyBtb3JlIGFib3V0IEdDQyBwbHVnaW5zDQp0
aGFuIEkgZG8uDQoNCkkgZG8gaGF2ZSBhIHZlcnNpb24gdGhhdCBjYW4gdGFrZSBhbm5vdGF0aW9u
cyB0byBzYXkgd2hpY2ggY2FsbCBzaG91bGQgYmUNCnN0YXRpYyBhbmQgdG8gZ2V0IHRoZSBzeW1i
b2wgaXQgdXNlcy4NCg0KSSBhbHNvIHRoaW5rIHRoYXQgdGhpcyBpbXBsZW1lbnRhdGlvbiB3b3Vs
ZCBkaXNhbGxvdyBrZXlzIHRoYXQgcmVzaWRlIHdpdGhpbg0Kc3RydWN0cy4gVGhpcyB3b3VsZCBt
ZWFuIHRoYXQgcGFyYXZpcnQsIGZvciBpbnN0YW5jZSwgd291bGQgbmVlZCB0byBnbw0KdGhyb3Vn
aCBtYW55IGNoYW5nZXMgdG8gdXNlIHRoaXMgaW5mcmFzdHJ1Y3R1cmUuDQoNCg==
