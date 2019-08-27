Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F267C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C1A206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ocP8g0Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfH0Xwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:52:54 -0400
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:18656
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfH0Xwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:52:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkvLGyuMojiL9/F0c8UKXOnXokD//iSMUMZUgkGuOz40hEF2vj4HnYwBkNUDBQPJY1jJFxNjXCiHp7cLJR1mx48bn6fuFe4GuN60i864W6QFBGNHh6C0vZqEtn2st/szPfUsZ2UasSaU4gtHlBKMUfECKtZA6EXWT1m0txDk0CP52FFtUD7KsW0CEZrY8R3Z+D12zbvRtQrhWHxD7JjRwig6FQHTB3SzBQBTmLHygoHU7o5iflT/Ch3EHu+XORFu63RLs0nU0ayzKz796bKMJqIsh5Hp2Ad5oFenXSMho/I2jiIquCyg0vEioAYMCCMy0/BTHA+/TZXJEjWVDT7fXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4dTI4Tn2Xk+b3RtDa97h65KQbbBvWw8GtL9ZpBt4Lg=;
 b=AOhfSDLczKuB7BR3fZqRdRMlZb9Lx0xh1oHjHhjGzaljo0VM5adIJNo7XRTz4BIgWS69x7U1a0msq+/M6mRmtXAS3Ixkf3MRBCgBWvuH18FFgWZlwFbLpOhnOe3F+Gq1B8rlI4Y7xcOpT8jpO7GpF6Baeux8a2L5JRkYBR38PdoTUbLzE+EFVmGg+2SQev6baO59WC4+XXXsj+UIIZ/U3Vow1VEd00PqiXkicp5MFam3489mdM4ETsHfsILcu0dE/BrtKaI0DLPJq0TFrR6eg3DLqj0IaJE+hy1fjmYXvGx5mlAURL9Y003zqNdKYseddShg+T18tY/E5H7w7ef44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4dTI4Tn2Xk+b3RtDa97h65KQbbBvWw8GtL9ZpBt4Lg=;
 b=ocP8g0Jm6xTAYAW8zy/uuJHiAb3wbrgl2K54/tfGCdDFxRMfzh6Z0ySPDP7/+EntTVbyr+RtatcwXXRaiSofXi8qT/wzOF9gedAzCXqfngYN6v/T4arfQoPGNJtmz5SsoYi265ZsZlgMscFXGufi+w7OrBO6pXpQ64bFtOo1Jl0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4454.namprd05.prod.outlook.com (52.135.203.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.14; Tue, 27 Aug 2019 23:52:48 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d%3]) with mapi id 15.20.2220.013; Tue, 27 Aug 2019
 23:52:48 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH 0/3] x86/mm/tlb: Defer TLB flushes with PTI
Thread-Topic: [RFC PATCH 0/3] x86/mm/tlb: Defer TLB flushes with PTI
Thread-Index: AQHVWkIzB+rt1FAQ7UGGXVX7777Ek6cPpvuAgAAJjwA=
Date:   Tue, 27 Aug 2019 23:52:48 +0000
Message-ID: <3989CBFF-F1C1-4F64-B8C4-DBFF80997857@vmware.com>
References: <20190823224635.15387-1-namit@vmware.com>
 <CALCETrX+h7FeyY290kvYRHAjMVDrmHivc55g+o0hnXrmm-wZRw@mail.gmail.com>
In-Reply-To: <CALCETrX+h7FeyY290kvYRHAjMVDrmHivc55g+o0hnXrmm-wZRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:6d44:2c40:29b9:7215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa95a5f7-e7db-4989-680f-08d72b49aa7e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4454;
x-ms-traffictypediagnostic: BYAPR05MB4454:
x-microsoft-antispam-prvs: <BYAPR05MB4454D7A612C25EAD5140BA32D0A00@BYAPR05MB4454.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(81156014)(8936002)(71200400001)(256004)(14444005)(81166006)(478600001)(33656002)(2906002)(86362001)(66946007)(76116006)(7736002)(66476007)(66556008)(64756008)(66446008)(99286004)(305945005)(229853002)(36756003)(4326008)(53936002)(6246003)(25786009)(71190400001)(186003)(5660300002)(6512007)(8676002)(6436002)(102836004)(6486002)(53546011)(6116002)(2616005)(11346002)(6916009)(316002)(54906003)(76176011)(6506007)(14454004)(486006)(446003)(46003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4454;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sGVDQKTXP/R0UE1H1RAan0xI1KQbweB+iupVY3u5FtTgc+Zk+m4O1hvUgxcPV2YmmkeMZE5/8BdNqlVn27oIlsbca5JPV64i3BMio2hqVNVvjcSr5zoHlc1GBj7VdbNv9f1ETJSgzxiPYhCqloLEm16MW98wRYLWKGnXhbq/v/TNfW6F6FMCnoSOAID8GX1842xae1AxIfiho2ORIV1rD/GwhZx1PfHJQgcvGmeZF/VMso7SrGmhanRuqSmrMRvi7Os98Mo3EGmDqEHVU3RF6ckr0JoU9jxuOrychr2OX+RWwSQWtBN+D/CF3BPb2uwOqyEfJd5rjyCbW8sRPIkQBa6749qzr9Ct10y2DEF2An2GNOScq940N2FcwMR+8M4b3v7rZXMamIIc4pt161mtjuFl7mtMBLsndnHykEcpmxE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <25A8717BEC63954F9190D999F44BFC37@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa95a5f7-e7db-4989-680f-08d72b49aa7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 23:52:48.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3owbFtqXcXV1mX1i1MQ4/XtceAPlpH5+vl57/eSaxwS7hrnMvvFgsSb8GVMYQMc5KhHcXgXj2aISekkD6DPxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBdWcgMjcsIDIwMTksIGF0IDQ6MTggUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgQXVnIDIzLCAyMDE5IGF0IDExOjA3IFBNIE5h
ZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gSU5WUENJRCBpcyBjb25zaWRl
cmFibHkgc2xvd2VyIHRoYW4gSU5WTFBHIG9mIGEgc2luZ2xlIFBURSwgYnV0IGl0IGlzDQo+PiBj
dXJyZW50bHkgdXNlZCB0byBmbHVzaCBQVEVzIGluIHRoZSB1c2VyIHBhZ2UtdGFibGUgd2hlbiBQ
VEkgaXMgdXNlZC4NCj4+IA0KPj4gSW5zdGVhZCwgaXQgaXMgcG9zc2libGUgdG8gZGVmZXIgVExC
IGZsdXNoZXMgdW50aWwgYWZ0ZXIgdGhlIHVzZXINCj4+IHBhZ2UtdGFibGVzIGFyZSBsb2FkZWQu
IFByZXZlbnRpbmcgc3BlY3VsYXRpb24gb3ZlciB0aGUgVExCIGZsdXNoZXMNCj4+IHNob3VsZCBr
ZWVwIHRoZSB3aG9sZSB0aGluZyBzYWZlLiBJbiBzb21lIGNhc2VzLCBkZWZlcnJpbmcgVExCIGZs
dXNoZXMNCj4+IGluIHN1Y2ggYSB3YXkgY2FuIHJlc3VsdCBpbiBtb3JlIGZ1bGwgVExCIGZsdXNo
ZXMsIGJ1dCBhcmd1YWJseSB0aGlzDQo+PiBiZWhhdmlvciBpcyBvZnRlbnRpbWVzIGJlbmVmaWNp
YWwuDQo+IA0KPiBJIGhhdmUgYSBzb21ld2hhdCBob3JyaWJsZSBzdWdnZXN0aW9uLg0KPiANCj4g
V291bGQgaXQgbWFrZSBzZW5zZSB0byByZWZhY3RvciB0aGlzIHNvIHRoYXQgaXQgd29ya3MgZm9y
IHVzZXIgKmFuZCoNCj4ga2VybmVsIHRhYmxlcz8gIEluIHBhcnRpY3VsYXIsIGlmIHdlIGZsdXNo
IGEgKmtlcm5lbCogbWFwcGluZyAodmZyZWUsDQo+IHZ1bm1hcCwgc2V0X21lbW9yeV9ybywgZXRj
KSwgd2Ugc2hvdWxkbid0IG5lZWQgdG8gc2VuZCBhbiBJUEkgdG8gYQ0KPiB0YXNrIHRoYXQgaXMg
cnVubmluZyB1c2VyIGNvZGUgdG8gZmx1c2ggbW9zdCBrZXJuZWwgbWFwcGluZ3Mgb3IgZXZlbg0K
PiB0byBmcmVlIGtlcm5lbCBwYWdldGFibGVzLiAgVGhlIHNhbWUgdHJpY2sgY291bGQgYmUgZG9u
ZSBpZiB3ZSB0cmVhdA0KPiBpZGxlIGxpa2UgdXNlciBtb2RlIGZvciB0aGlzIHB1cnBvc2UuDQo+
IA0KPiBJbiBjb2RlLCB0aGlzIGNvdWxkIG1vc3RseSBjb25zaXN0IG9mIGNoYW5naW5nIGFsbCB0
aGUgInVzZXIiIGRhdGENCj4gc3RydWN0dXJlcyBpbnZvbHZlZCB0byBzb21ldGhpbmcgbGlrZSBz
dHJ1Y3QgZGVmZXJyZWRfZmx1c2hfaW5mbyBhbmQNCj4gaGF2aW5nIG9uZSBmb3IgdXNlciBhbmQg
b25lIGZvciBrZXJuZWwuDQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMgaG9ycmlibGUgYmVjYXVzZSBp
dCB3aWxsIGVuYWJsZSBjZXJ0YWluIHdvcmtsb2FkcyB0bw0KPiB3b3JrIGNvbnNpZGVyYWJseSBm
YXN0ZXIgd2l0aCBQVEkgb24gdGhhbiB3aXRoIFBUSSBvZmYsIGFuZCB0aGF0IHdvdWxkDQo+IGJl
IGEgYmFyZWx5IGV4Y3VzYWJsZSBtb3JhbCBmYWlsaW5nLiA6LXANCj4gDQo+IEZvciB3aGF0IGl0
J3Mgd29ydGgsIG90aGVyIHRoYW4gcmVnaXN0ZXIgY2xvYmJlciBpc3N1ZXMsIHRoZSB3aG9sZQ0K
PiAic3dpdGNoIENSMyBmb3IgUFRJIiBsb2dpYyBvdWdodCB0byBiZSBkb2FibGUgaW4gQy4gIEkg
ZG9uJ3Qga25vdyBhDQo+IHByaW9yaSB3aGV0aGVyIHRoYXQgd291bGQgZW5kIHVwIGJlaW5nIGFu
IGltcHJvdmVtZW50Lg0KDQpJIGltcGxlbWVudGVkIChhbmQgaGF2ZSBub3QgeWV0IHNlbnQpIGFu
b3RoZXIgVExCIGRlZmVycmluZyBtZWNoYW5pc20uIEl0IGlzDQppbnRlbmRlZCBmb3IgdXNlciBt
YXBwaW5ncyBhbmQgbm90IGtlcm5lbCBvbmUsIGJ1dCBJIHRoaW5rIHlvdXIgc3VnZ2VzdGlvbg0K
c2hhcmVzIHNvbWUgc2ltaWxhciB1bmRlcmx5aW5nIHJhdGlvbmFsZSwgYW5kIHRoZXJlZm9yZSBj
aGFsbGVuZ2VzIGFuZA0Kc29sdXRpb25zLiBMZXQgbWUgcmVwaHJhc2Ugd2hhdCB5b3Ugc2F5IHRv
IGVuc3VyZSB3ZSBhcmUgb24gdGhlIHNhbWUgcGFnZS4NCg0KVGhlIGJhc2ljIGlkZWEgaXMgY29u
dGV4dC10cmFja2luZyB0byBjaGVjayB3aGV0aGVyIGVhY2ggQ1BVIGlzIGluIGtlcm5lbCBvcg0K
dXNlciBtb2RlLiBBY2NvcmRpbmdseSwgVExCIGZsdXNoZXMgY2FuIGJlIGRlZmVycmVkLCBidXQg
SSBkb27igJl0IHNlZSB0aGF0DQp0aGlzIHNvbHV0aW9uIGlzIGxpbWl0ZWQgdG8gUFRJLiBUaGVy
ZSBhcmUgMiBwb3NzaWJsZSByZWFzb25zLCBhY2NvcmRpbmcgdG8NCm15IHVuZGVyc3RhbmRpbmcs
IHRoYXQgeW91IGxpbWl0IHRoZSBkaXNjdXNzaW9uIHRvIFBUSToNCg0KMS4gUFRJIHByb3ZpZGVz
IGNsZWFyIGJvdW5kYXJpZXMgd2hlbiB1c2VyIGFuZCBrZXJuZWwgbWFwcGluZ3MgYXJlIHVzZWQu
IEkNCmFtIG5vdCBzdXJlIHRoYXQgcHJpdmlsZWdlLWxldmVscyAoYW5kIFNNQVApIGRvIG5vdCBk
byB0aGUgc2FtZS4NCg0KMi4gQ1IzIHN3aXRjaGluZyBhbHJlYWR5IGltcG9zZXMgYSBtZW1vcnkg
YmFycmllciwgd2hpY2ggZWxpbWluYXRlcyBtb3N0IG9mDQp0aGUgY29zdCBvZiBpbXBsZW1lbnRp
bmcgc3VjaCBzY2hlbWUgd2hpY2ggcmVxdWlyZXMgc29tZXRoaW5nIHdoaWNoIGlzDQpzaW1pbGFy
IHRvOg0KDQoJd3JpdGUgbmV3IGNvbnRleHQgKGtlcm5lbC91c2VyKQ0KCW1iKCk7DQoJaWYgKG5l
ZWRfZmx1c2gpIGZsdXNoOw0KDQpJIGRvIGFncmVlIHRoYXQgUFRJIGFkZHJlc3NlcyAoMiksIGJ1
dCB0aGVyZSBpcyBhbm90aGVyIHByb2JsZW0uIEENCnJlYXNvbmFibGUgaW1wbGVtZW50YXRpb24g
d291bGQgc3RvcmUgaW4gYSBwZXItY3B1IHN0YXRlIHdoZXRoZXIgZWFjaCBDUFUgaXMNCmluIHVz
ZXIva2VybmVsLCBhbmQgdGhlIFRMQiBzaG9vdGRvd24gaW5pdGlhdG9yIENQVSB3b3VsZCBjaGVj
ayB0aGUgc3RhdGUgdG8NCmRlY2lkZSB3aGV0aGVyIGFuIElQSSBpcyBuZWVkZWQuIFRoaXMgbWVh
bnMgdGhhdCBwcmV0dHkgbXVjaCBldmVyeSBUTEINCnNodXRkb3duIHdvdWxkIGluY3VyIGEgY2Fj
aGUtbWlzcyBwZXItdGFyZ2V0IENQVS4gVGhpcyBtaWdodCBjYXVzZQ0KcGVyZm9ybWFuY2UgcmVn
cmVzc2lvbnMsIGF0IGxlYXN0IGluIHNvbWUgY2FzZXMuDQoNCkFkbWl0dGVkbHksIEkgZGlkIGlt
cGxlbWVudCBzb21ldGhpbmcgc2ltaWxhciAobm90IHNlbnQpIGZvciB1c2VyIG1hcHBpbmdzOg0K
ZGVmZXIgYWxsIFRMQiBmbHVzaGVzIGFuZCBzaG9vdGRvd25zIGlmIHRoZSBDUFVzIGFyZSBrbm93
biB0byBiZSBpbiBrZXJuZWwNCm1vZGUuIEJ1dCBJIGxpbWl0ZWQgbXlzZWxmIGZvciBjZXJ0YWlu
IGNhc2VzLCBzcGVjaWZpY2FsbHkg4oCcbG9uZ+KAnSBzeXNjYWxscw0KdGhhdCBhcmUgYWxyZWFk
eSBsaWtlbHkgdG8gY2F1c2UgYSBUTEIgZmx1c2ggKGUuZy4sIG1zeW5jKCkpLiBJIGFtIG5vdCBz
dXJlDQp0aGF0IHRyYWNraW5nIGVhY2ggQ1BVIGVudHJ5L2V4aXQgd291bGQgYmUgYSBnb29kIGlk
ZWEuDQoNCkkgd2lsbCBnaXZlIHNvbWUgbW9yZSB0aG91Z2h0IGFib3V0IGtlcm5lbCBtYXBwaW5n
IGludmFsaWRhdGlvbnMsIHdoaWNoIEkNCmRpZCBub3QgdGhpbmsgYWJvdXQgZW5vdWdoLiBJIHRy
aWVkIHRvIHNlbmQgd2hhdCBJIGNvbnNpZGVyZWQg4oCcc2FuZXLigJ0gYW5kDQpjbGVhbmVyIHBh
dGNoZXMgZmlyc3QuIEkgc3RpbGwgaGF2ZSBwYXRjaGVzIEkgbWVudGlvbmVkIGhlcmUsIHRoZQ0K
YXN5bmMtZmx1c2hlcywgYW5kIGFub3RoZXIgcGF0Y2ggdG8gYXZvaWQgbG9jYWwgVExCIGZsdXNo
IG9uIENvVyBhbmQgaW5zdGVhZA0KYWNjZXNzaW5nIHRoZSBkYXRhLg==
