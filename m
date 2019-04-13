Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1406C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D17C20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="s3FoCBy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfDMIkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:40:11 -0400
Received: from mail-eopbgr700072.outbound.protection.outlook.com ([40.107.70.72]:14868
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfDMIkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmhteVKy4qExihugM1NQlD5/ymVyLDejepySQ1qKCvc=;
 b=s3FoCBy0Txrm1AH0wdaA98bXiLhTtYM7Cv5g5BISKPtuECwfLaoamuyStV3qVK8o6DBO7LIFs/MnTKYHaZT8/jIk61BmiMNlhvAXE5vwBY8BRj3kNipii3YyK1AZAJZgROfPgRaRDL8HIE+GuCCsqMrrwIEgUWIFHdjKMI4LX18=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB5967.namprd05.prod.outlook.com (20.178.241.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.8; Sat, 13 Apr 2019 08:40:05 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1813.009; Sat, 13 Apr 2019
 08:40:05 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "riel@surriel.com" <riel@surriel.com>
Subject: Re: [PATCH 3/9] mm: Add write-protect and clean utilities for address
 space ranges
Thread-Topic: [PATCH 3/9] mm: Add write-protect and clean utilities for
 address space ranges
Thread-Index: AQHU8UlkX7sd+TdVL0uJIJH8smlP/KY43zcAgADnMQA=
Date:   Sat, 13 Apr 2019 08:40:05 +0000
Message-ID: <6382866ad219f4fcac3507f5fd3e22d5113a82ba.camel@vmware.com>
References: <20190412160338.64994-1-thellstrom@vmware.com>
         <20190412160338.64994-4-thellstrom@vmware.com>
         <e6d86a3a-eae6-5e35-895e-ef944b4fd108@nvidia.com>
In-Reply-To: <e6d86a3a-eae6-5e35-895e-ef944b4fd108@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9669320e-7467-4c40-c8f2-08d6bfeba0f1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB5967;
x-ms-traffictypediagnostic: MN2PR05MB5967:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB5967E2E2B2A5DCF4F208C1DBA1290@MN2PR05MB5967.namprd05.prod.outlook.com>
x-forefront-prvs: 00064751B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(39860400002)(346002)(199004)(189003)(5660300002)(6246003)(478600001)(71190400001)(8936002)(105586002)(6486002)(106356001)(118296001)(229853002)(36756003)(6506007)(7736002)(53546011)(68736007)(186003)(2501003)(2616005)(102836004)(486006)(446003)(476003)(71200400001)(66574012)(14454004)(26005)(11346002)(2906002)(86362001)(7416002)(99286004)(53936002)(8676002)(6116002)(81156014)(76176011)(81166006)(4326008)(316002)(6436002)(66066001)(110136005)(256004)(25786009)(6512007)(54906003)(14444005)(3846002)(97736004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB5967;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xY4MWP2ukKuixJPWXv4d4CMyZ0ll8wJ6hwLN39UIRVF8T6mquQphv1tQPNyKOJtm0Ic5OstutCXZmBu/1HphG7wRZblLY5rGplbhmA4gjnjDbwpxqVfX1qx2FENmaXc8YiQTHSP0G2keryQbd2cSS9bqItASlcMi5gtUMa4OUtgJrrUXI3WvdNckjoHJxMuZZWDhti3uVDiBqkyUVnYESooqRHTIrmmtxAGuBI2jQ2l5zKO+RQ3I2NGyRuCO6cah5B1semw4Jy5Bn7jQ5BsVQJbNbG0ITCDh8+hdjMTBOsV8crpcqYvv0yhUKaIqqLOHSDjfpRMdXSUpF01htR9X40K18ILjw7uGtEtptSivJH25s1Y1Yq2HeILnYBI/KSjeivs2lzr09FGVvHTUtYVyvMJw39VWJWzQ/jS/j/MaiSE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1797BD57798CB4BBF4691E614DD0968@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9669320e-7467-4c40-c8f2-08d6bfeba0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2019 08:40:05.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB5967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJhbHBoLA0KDQpPbiBGcmksIDIwMTktMDQtMTIgYXQgMTE6NTIgLTA3MDAsIFJhbHBoIENh
bXBiZWxsIHdyb3RlOg0KPiBPbiA0LzEyLzE5IDk6MDQgQU0sIFRob21hcyBIZWxsc3Ryb20gd3Jv
dGU6DQo+ID4gQWRkIHR3byB1dGlsaXRpZXMgdG8gYSkgd3JpdGUtcHJvdGVjdCBhbmQgYikgY2xl
YW4gYWxsIHB0ZXMNCj4gPiBwb2ludGluZyBpbnRvDQo+ID4gYSByYW5nZSBvZiBhbiBhZGRyZXNz
IHNwYWNlDQo+IA0KPiBBIHBlcmlvZCBhdCB0aGUgZW5kLCBwbGVhc2UuDQo+IA0KPiA+IFRoZSB1
dGlsaXRpZXMgYXJlIGludGVuZGVkIHRvIGFpZCBpbiB0cmFja2luZyBkaXJ0eSBwYWdlcyAoZWl0
aGVyDQo+ID4gZHJpdmVyLWFsbG9jYXRlZCBzeXN0ZW0gbWVtb3J5IG9yIHBjaSBkZXZpY2UgbWVt
b3J5KS4NCj4gPiBUaGUgd3JpdGUtcHJvdGVjdCB1dGlsaXR5IHNob3VsZCBiZSB1c2VkIGluIGNv
bmp1bmN0aW9uIHdpdGgNCj4gPiBwYWdlX21rd3JpdGUoKSBhbmQgcGZuX21rd3JpdGUoKSB0byB0
cmlnZ2VyIHdyaXRlIHBhZ2UtZmF1bHRzIG9uDQo+ID4gcGFnZQ0KPiA+IGFjY2Vzc2VzLiBUeXBp
Y2FsbHkgb25lIHdvdWxkIHdhbnQgdG8gdXNlIHRoaXMgb24gc3BhcnNlIGFjY2Vzc2VzDQo+ID4g
aW50bw0KPiA+IGxhcmdlIG1lbW9yeSByZWdpb25zLiBUaGUgY2xlYW4gdXRpbGl0eSBzaG91bGQg
YmUgdXNlZCB0byB1dGlsaXplDQo+ID4gaGFyZHdhcmUgZGlydHlpbmcgZnVuY3Rpb25hbGl0eSBh
bmQgYXZvaWQgdGhlIG92ZXJoZWFkIG9mIHBhZ2UtDQo+ID4gZmF1bHRzLA0KPiA+IHR5cGljYWxs
eSBvbiBsYXJnZSBhY2Nlc3NlcyBpbnRvIHNtYWxsIG1lbW9yeSByZWdpb25zLg0KPiA+IA0KPiA+
IFRoZSBhZGRlZCBmaWxlICJhcHBseV9hc19yYW5nZS5jIiBpcyBpbml0aWFsbHkgbGlzdGVkIGFz
IG1haW50YWluZWQNCj4gPiBieQ0KPiA+IFZNd2FyZSB1bmRlciBvdXIgRFJNIGRyaXZlci4gSWYg
c29tZWJvZHkgd291bGQgbGlrZSBpdCBlbHNld2hlcmUsDQo+ID4gdGhhdCdzIG9mIGNvdXJzZSBu
byBwcm9ibGVtLg0KPiA+IA0KPiA+IE5vdGFibGUgY2hhbmdlcyBzaW5jZSBSRkM6DQo+ID4gLSBB
ZGRlZCBjb21tZW50cyB0byBoZWxwIGF2b2lkIHRoZSB1c2FnZSBvZiB0aGVzZSBmdW5jdGlvbiBm
b3IgVk1Bcw0KPiA+ICAgIGl0J3Mgbm90IGludGVuZGVkIGZvci4gV2UgYWxzbyBkbyBhZHZpc29y
eSBjaGVja3Mgb24gdGhlDQo+ID4gdm1fZmxhZ3MgYW5kDQo+ID4gICAgd2FybiBvbiBpbGxlZ2Fs
IHVzYWdlLg0KPiA+IC0gUGVyZm9ybSB0aGUgcHRlIG1vZGlmaWNhdGlvbnMgdGhlIHNhbWUgd2F5
IHNvZnRkaXJ0eSBkb2VzLg0KPiA+IC0gQWRkIG1tdV9ub3RpZmllciByYW5nZSBpbnZhbGlkYXRp
b24gY2FsbHMuDQo+ID4gLSBBZGQgYSBjb25maWcgb3B0aW9uIHNvIHRoYXQgdGhpcyBjb2RlIGlz
IG5vdCB1bmNvbmRpdGlvbmFsbHkNCj4gPiBpbmNsdWRlZC4NCj4gPiAtIFRlbGwgdGhlIG1tdV9n
YXRoZXIgY29kZSBhYm91dCBwZW5kaW5nIHRsYiBmbHVzaGVzLg0KPiA+IA0KPiA+IENjOiBBbmRy
ZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+IENjOiBNYXR0aGV3IFdp
bGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gPiBDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVh
Y29uQGFybS5jb20+DQo+ID4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9y
Zz4NCj4gPiBDYzogUmlrIHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwuY29tPg0KPiA+IENjOiBNaW5j
aGFuIEtpbSA8bWluY2hhbkBrZXJuZWwub3JnPg0KPiA+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nr
b0BzdXNlLmNvbT4NCj4gPiBDYzogSHVhbmcgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+DQo+
ID4gQ2M6IFNvdXB0aWNrIEpvYXJkZXIgPGpyZHIubGludXhAZ21haWwuY29tPg0KPiA+IENjOiAi
SsOpcsO0bWUgR2xpc3NlIiA8amdsaXNzZUByZWRoYXQuY29tPg0KPiA+IENjOiBsaW51eC1tbUBr
dmFjay5vcmcNCj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFRob21hcyBIZWxsc3Ryb20gPHRoZWxsc3Ryb21Adm13YXJlLmNvbT4NCj4gDQo+
IFJldmlld2VkLWJ5OiBSYWxwaCBDYW1wYmVsbCA8cmNhbXBiZWxsQG52aWRpYS5jb20+DQoNClRo
YW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLiBJJ2xsIGluY29ycG9yYXRlIHlvdXIgc3Vn
Z2VzdGlvbnMgaW4NCnYyLg0KDQo=
