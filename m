Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA4C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39309218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="eqzGLdSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfDWQ47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:56:59 -0400
Received: from mail-eopbgr730068.outbound.protection.outlook.com ([40.107.73.68]:54609
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728526AbfDWQ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVqL1m9Sa/KVQbK4d4KcR9nl9KEFKbwIMpH1HjfCwqs=;
 b=eqzGLdSwzChsWhQJokDgaZiw9wUgcDFTyDntXNyYZOTbrsIHxh08EKipv1D1TZiNNek1KcB0I8sJTrn5EFqpy9laAr8ungQRA28JXqgknQ/DoCBM/bTxYrAMzmLZcqfmBwm4JNo+O5Mo1E3zEbqsOh7VzzybJrM+DRHkbCbFIhc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6424.namprd05.prod.outlook.com (20.178.232.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 23 Apr 2019 16:56:54 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094%3]) with mapi id 15.20.1835.010; Tue, 23 Apr 2019
 16:56:54 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Topic: [PATCH] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Index: AQHU+aHFH4sDsaCumUS5u9AqMzrCzaZJ9iEAgAABtYA=
Date:   Tue, 23 Apr 2019 16:56:54 +0000
Message-ID: <44A66873-0834-4794-81A5-3B2131314AA4@vmware.com>
References: <20190423065706.15430-1-namit@vmware.com>
 <CALCETrUohp2rMr9EcoAYm2M=Ktu4Bg2sPfUWMy5JqM-GXsDOBQ@mail.gmail.com>
In-Reply-To: <CALCETrUohp2rMr9EcoAYm2M=Ktu4Bg2sPfUWMy5JqM-GXsDOBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09959bde-08cc-40ce-762b-08d6c80cb091
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB6424;
x-ms-traffictypediagnostic: BYAPR05MB6424:
x-microsoft-antispam-prvs: <BYAPR05MB64240C4D599064681441C4D0D0230@BYAPR05MB6424.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(6436002)(6512007)(71200400001)(53546011)(66066001)(83716004)(71190400001)(6916009)(6246003)(82746002)(6486002)(6506007)(2616005)(476003)(446003)(11346002)(486006)(102836004)(81166006)(8676002)(8936002)(86362001)(81156014)(4326008)(229853002)(186003)(25786009)(36756003)(26005)(5660300002)(14454004)(3846002)(68736007)(33656002)(256004)(54906003)(97736004)(478600001)(6116002)(76176011)(316002)(99286004)(66946007)(66446008)(305945005)(64756008)(76116006)(73956011)(66556008)(7736002)(53936002)(2906002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6424;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SIpXvZz4qlo3cKxeRfjo2YaWkuNEhqq1tHcsSgP6w+wy9861w0IXb+940T0Fl/4XAAOwgfDRdRpDqOHzG09lyy7iehHomoxUjGv6AxgMiWKMYHuAK62MsR14EeQnnXFKfT0tRvZVgv6x97aJ53//iVLQxoHySe5rzX1pGVJayTN6qXhTj7RyAGMAYvJpFKkq8VimNY9U4OERvQnRgt8tJfLmatRSgdxPJvlCT+kGh3/09zi5/C+NTgDR/ZsQj8nK0wRDIge/bszuUBni9vI42kc5dlqYvgR9xcIWs5chs+s4ShHHa+9GHPmFJgfXQulEfyoy/QXV2GWnitmniegZl52lWjzMgoqB4SDkK25NDEYV4Wdtqzu2of7pZ6SEygjHvEQrze72rsmsCOsspmjlEunkqW/nmSRTqmEDYIlvxYw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF24569030E02148B3A4608F7B693661@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09959bde-08cc-40ce-762b-08d6c80cb091
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 16:56:54.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6424
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBcHIgMjMsIDIwMTksIGF0IDk6NTAgQU0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgQXByIDIzLCAyMDE5IGF0IDEyOjEyIEFNIE5h
ZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gUmVtb3ZlIGZsdXNoX3RsYl9p
bmZvIHZhcmlhYmxlcyBmcm9tIHRoZSBzdGFjay4gVGhpcyBhbGxvd3MgdG8gYWxpZ24NCj4+IGZs
dXNoX3RsYl9pbmZvIHRvIGNhY2hlLWxpbmUgYW5kIGF2b2lkIHBvdGVudGlhbGx5IHVubmVjZXNz
YXJ5IGNhY2hlDQo+PiBsaW5lIG1vdmVtZW50cy4gSXQgYWxzbyBhbGxvd3MgdG8gaGF2ZSBhIGZp
eGVkIHZpcnR1YWwtdG8tcGh5c2ljYWwNCj4+IHRyYW5zbGF0aW9uIG9mIHRoZSB2YXJpYWJsZXMs
IHdoaWNoIHJlZHVjZXMgVExCIG1pc3Nlcy4NCj4+IA0KPj4gVXNlIHBlci1DUFUgc3RydWN0IGZv
ciBmbHVzaF90bGJfbW1fcmFuZ2UoKSBhbmQNCj4+IGZsdXNoX3RsYl9rZXJuZWxfcmFuZ2UoKS4g
QWRkIGRlYnVnIGFzc2VydGlvbnMgdG8gZW5zdXJlIHRoZXJlIGFyZQ0KPj4gbm8gbmVzdGVkIFRM
QiBmbHVzaGVzIHRoYXQgbWlnaHQgb3ZlcndyaXRlIHRoZSBwZXItQ1BVIGRhdGEuIEZvcg0KPj4g
YXJjaF90bGJiYXRjaF9mbHVzaCgpLCB1c2UgYSBjb25zdCBzdHJ1Y3QuDQo+PiANCj4+IFJlc3Vs
dHMgd2hlbiBydW5uaW5nIGEgbWljcm9iZW5jaG1hcmtzIHRoYXQgcGVyZm9ybXMgMTBeNiBNQURW
X0RPTlRFRUQNCj4+IG9wZXJhdGlvbnMgYW5kIHRvdWNoaW5nIGEgcGFnZSwgaW4gd2hpY2ggMyBh
ZGRpdGlvbmFsIHRocmVhZHMgcnVuIGENCj4+IGJ1c3ktd2FpdCBsb29wICg1IHJ1bnMpOg0KPiAN
Cj4gQ2FuIHlvdSBhZGQgYSBtZW1zZXQoLCwsLiAwLCBzaXplb2Yoc3RydWN0IGZsdXNoX3RsYl9p
bmZvKSkgZXZlcnl3aGVyZQ0KPiB5b3UgZ3JhYiBpdD8gIE9yLCBldmVuIGJldHRlciwgcGVyaGFw
cyBkbyBzb21ldGhpbmcgbGlrZToNCj4gDQo+IHN0YXRpYyBpbmxpbmUgc3RydWN0IGZsdXNoX3Rs
Yl9pbmZvICpnZXRfZmx1c2hfdGxiX2luZm8odm9pZCkNCj4gew0KPiAgLyogY2hlY2sgcmVlbnRy
YW5jeSwgbWFrZSBzdXJlIHRoYXQgd2UgdXNlIHNtcF9wcm9jZXNzb3JfaWQoKSBvcg0KPiBvdGhl
cndpc2UgYXNzZXJ0IHRoYXQgd2UncmUgYm91bmQgdG8gYSBzaW5nbGUgQ1BVLiAqLw0KPiAgc3Ry
dWN0IGZsdXNoX3RsYl9pbmZvICpwdHIgPSB0aGlzX2NwdV9wdHIoLi4uKTsNCj4gIG1lbXNldChw
dHIsIDAsIHNpemVvZigqcHRyKSk7DQo+ICByZXR1cm4gcHRyOw0KPiB9DQo+IA0KPiBzdGF0aWMg
aW5saW5lIHZvaWQgcHV0X2ZsdXNoX3RsYl9pbmZvKHZvaWQpDQo+IHsNCj4gLyogZmluaXNoIGNo
ZWNraW5nIHJlZW50cmFuY3kuICovDQo+IH0NCg0KSeKAmWxsIGNoZWNrIGlmIHRoZSBjb21waWxl
ciBpcyBzbWFydCBlbm91Z2ggdG8gYXZvaWQgcmVkdW5kYW50IGFzc2lnbm1lbnRzLA0KYW5kIGlm
IGl0IGlzIG5vdCwgSeKAmWxsIGp1c3QgZ2l2ZSBhbGwgdGhlIHN0cnVjdCBhcmd1bWVudHMgdG8N
CmdldF9mbHVzaF90bGJfaW5mbygpIGluc3RlYWQgb2YgbWVtc2V0KCkgaWYgeW91IGRvbuKAmXQg
bWluZC4NCg0KSSBhbHNvIHdhbnQgdG8gZ2l2ZSBhIHRyeSBmb3IgcGFyYWxsZWxpemluZyB0aGUg
cmVtb3RlIGFuZCBsb2NhbA0KaW52b2NhdGlvbnMsIHdoaWNoIHJlYWxseSBhbm5veXMgbWUgZXZl
cnkgdGltZSBJIGxvb2sgYXQgdGhlIGNvZGUuIFBsZWFzZQ0KbGV0IG1lIGtub3cgaWYgdGhlcmUg
aXMgYW55IOKAnGJpZyByZWFzb27igJ0gdGhhdCBJIGFtIG1pc3NpbmcgZm9yIGl0IG5vdCB0byBi
ZQ0KZG9uZSBiZWZvcmUuIEkganVzdCBob3BlIGFsbCB0aGUgcGFyYXZpcnQgc3R1ZmYgd2lsbCBu
b3QgbWFrZSBpdCB0b28gdWdseS4NCg0K
