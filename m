Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB64C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A502184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="p+JT7L0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbfGSXCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 19:02:53 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:54327
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728747AbfGSXCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 19:02:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzlHpwNDM3Xtl7RKlu2BSpppOW2qamxSVDOjg7Si2kuPE69iRw141WMk6INW07H3+yfokw63ZfmR0dEK8gTzMYRtMgqwNNF7xikxzUc8DFBgajKwX2LiVYaurxvUyX0DPVoec1ej0Atv7j7X4hUCUUS+hlQqMil0Lr6eAY67fVmC+mDqSgGZvxbP80wtWVi2CBGVHWK1TIeIIoLqqY86RRsUyOo6bfN/6tWkzpT7AmUQRcYuLdcIsURJaKkmdcb72rVffu2xMS85vqCK51uwoYjSFaH7knF9uhAGB12uszS3Jmf3fPJBhr6wcx8jRqo4qAqdkyGI2D/fQn4+CwC92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kcrv2m54MRahLciDr3DupushtytNe0Jqkv/fWka/ceQ=;
 b=d9BVFxV3BYXjT3tmFGTFhHmjVlz7wcWUnPfr2VvsvKWfWBpVC0P8PGHkDTK9IF49az3ZNzi2wP4z4a+Skbh2RsfWSXA8Vke5ph7zQrkgF5aZOH5GYpyWurjJwyM+OPSxJOgO+1/d+AkcUps7FR7fxuYiRxrFmDdWKyDJcxxUIsRtdn81PKCWVVzWtJ+MOovuHPLtXbeRcgM2wVOF1PHod9fXk/akfMKJfzWu6YeirFXbfx14I+hGZ+8InVvb1Jsu2t+K/F1f8rfLoW7HL8j1gm+FvQwc6bvQrOUEQMGewku+BxYk+U47BXOmnFN0Pr7Xml5Ykd+GVDrf/Z/IiGNJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kcrv2m54MRahLciDr3DupushtytNe0Jqkv/fWka/ceQ=;
 b=p+JT7L0KFe0EHMYpb3QMStjYzN+AMEJVrNj65Fa85UHoRCBElGwjrqDJ3YAyDN4mHy3Wo7p1iGHKQ7dKX2KxcTC/jkKuKMRMmwCjFyAdKHX5di4sh9EmnrDy7dIIAYZRyCuTDYyRiVwRHb8ZvjoS9VEXg2z4KxK6LH2WfbCUSnE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6200.namprd05.prod.outlook.com (20.178.55.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.8; Fri, 19 Jul 2019 23:02:48 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2094.009; Fri, 19 Jul 2019
 23:02:47 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Joe Perches <joe@perches.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Thread-Topic: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Thread-Index: AQHVPc0s+2522G+J006mLkslhMknOKbSRkAAgAABN4CAAEPkAIAABTIA
Date:   Fri, 19 Jul 2019 23:02:47 +0000
Message-ID: <D13BA044-AC02-46A7-9C5C-48FE8B6E8F63@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-4-namit@vmware.com>
 <8bf005e2-7ac7-f1cf-eca1-0e152dd912a7@intel.com>
 <6847D7A3-4618-4BC3-97B6-EC53F6985504@vmware.com>
 <511eb129bc0a6c92e3547c69a6e55695241dfe4a.camel@perches.com>
In-Reply-To: <511eb129bc0a6c92e3547c69a6e55695241dfe4a.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 193e75f7-57dd-4d11-199d-08d70c9d3792
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6200;
x-ms-traffictypediagnostic: BYAPR05MB6200:
x-microsoft-antispam-prvs: <BYAPR05MB620080D38B9BECF4814A677AD0CB0@BYAPR05MB6200.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(33656002)(7416002)(71190400001)(71200400001)(305945005)(14454004)(7736002)(6506007)(256004)(53546011)(14444005)(99286004)(186003)(486006)(26005)(54906003)(102836004)(8676002)(446003)(11346002)(76176011)(316002)(476003)(2616005)(4326008)(68736007)(8936002)(5660300002)(6116002)(6246003)(3846002)(6916009)(66946007)(76116006)(81166006)(81156014)(66066001)(66446008)(64756008)(66556008)(66476007)(229853002)(6512007)(2906002)(6436002)(86362001)(6486002)(53936002)(478600001)(25786009)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6200;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k1i6IjQtADvAdESwi9+ZmAOfPXYz/0eXMa+BxQZab0RUNRjbargccaAxdMzGrjsI9FBJxC+bthS9dRdYyEHFKTiFsh12MOhmekWTLsDCHIqd6Enh2DiDYKSSaatb8vZMApp8KdBXiyrPbHD+3xL2b7Y6nUXocDsSfEOABqZn8iO9xB3Ipf1k2t2/O8UKiFKtk3N09lHvr6Ok8nuWBK79ZV84bfhnpTyizrCWDRBs/meloIwkrELb4qDwba54xjFVCMIp4OhaaJEFCuRE8pDoYcD7JIxHogm9gwANIaQx/PTSTyzxP/xy32p4dG/KEVT4WWPEBpSUjvEA22MK22yfdBMZGR++VKB1upNH3B8sLJyH8m/yvbnUy1xDC3ukVaV6/ViSvALeazqtxu8HcyDsAn6gViKTcZKeBL0SEKrZlew=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCFDDF14852C9A4BA9A4A4AE7610444E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193e75f7-57dd-4d11-199d-08d70c9d3792
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 23:02:47.5576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMTksIDIwMTksIGF0IDM6NDQgUE0sIEpvZSBQZXJjaGVzIDxqb2VAcGVyY2hlcy5j
b20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMDE5LTA3LTE5IGF0IDE4OjQxICswMDAwLCBOYWRh
diBBbWl0IHdyb3RlOg0KPj4+IE9uIEp1bCAxOSwgMjAxOSwgYXQgMTE6MzYgQU0sIERhdmUgSGFu
c2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDcvMTgvMTkg
NTo1OCBQTSwgTmFkYXYgQW1pdCB3cm90ZToNCj4+Pj4gQEAgLTg2NSw3ICs4OTMsNyBAQCB2b2lk
IGFyY2hfdGxiYmF0Y2hfZmx1c2goc3RydWN0IGFyY2hfdGxiZmx1c2hfdW5tYXBfYmF0Y2ggKmJh
dGNoKQ0KPj4+PiAJaWYgKGNwdW1hc2tfdGVzdF9jcHUoY3B1LCAmYmF0Y2gtPmNwdW1hc2spKSB7
DQo+Pj4+IAkJbG9ja2RlcF9hc3NlcnRfaXJxc19lbmFibGVkKCk7DQo+Pj4+IAkJbG9jYWxfaXJx
X2Rpc2FibGUoKTsNCj4+Pj4gLQkJZmx1c2hfdGxiX2Z1bmNfbG9jYWwoJmZ1bGxfZmx1c2hfdGxi
X2luZm8pOw0KPj4+PiArCQlmbHVzaF90bGJfZnVuY19sb2NhbCgodm9pZCAqKSZmdWxsX2ZsdXNo
X3RsYl9pbmZvKTsNCj4+Pj4gCQlsb2NhbF9pcnFfZW5hYmxlKCk7DQo+Pj4+IAl9DQo+Pj4gDQo+
Pj4gVGhpcyBsb29rcyBsaWtlIHN1cGVyZmx1b3VzIGNodXJuLiAgSXMgaXQ/DQo+PiANCj4+IFVu
Zm9ydHVuYXRlbHkgbm90LCBzaW5jZSBmdWxsX2ZsdXNoX3RsYl9pbmZvIGlzIGRlZmluZWQgYXMg
Y29uc3QuIFdpdGhvdXQgaXQNCj4+IHlvdSB3b3VsZCBnZXQ6DQo+PiANCj4+IHdhcm5pbmc6IHBh
c3NpbmcgYXJndW1lbnQgMSBvZiDigJhmbHVzaF90bGJfZnVuY19sb2NhbOKAmSBkaXNjYXJkcyDi
gJhjb25zdOKAmSBxdWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Rpc2NhcmRl
ZC1xdWFsaWZpZXJzXQ0KPj4gDQo+PiBBbmQgZmx1c2hfdGxiX2Z1bmNfbG9jYWwoKSBzaG91bGQg
Z2V0ICh2b2lkICopIGFyZ3VtZW50IHNpbmNlIGl0IGlzIGFsc28NCj4+IHVzZWQgYnkgdGhlIFNN
UCBpbmZyYXN0cnVjdHVyZS4NCj4gDQo+IGh1aD8NCj4gDQo+IGNvbW1pdCAzZGI2ZDVhNWVjYWYw
YTc3OGQ3MjFjY2Y5ODA5MjQ4MzUwZDRiZmFmDQo+IEF1dGhvcjogTmFkYXYgQW1pdCA8bmFtaXRA
dm13YXJlLmNvbT4NCj4gRGF0ZTogICBUaHUgQXByIDI1IDE2OjAxOjQzIDIwMTkgLTA3MDANCj4g
DQo+IFtdDQo+IA0KPiAtc3RhdGljIHZvaWQgZmx1c2hfdGxiX2Z1bmNfbG9jYWwodm9pZCAqaW5m
bywgZW51bSB0bGJfZmx1c2hfcmVhc29uIHJlYXNvbikNCj4gK3N0YXRpYyB2b2lkIGZsdXNoX3Rs
Yl9mdW5jX2xvY2FsKGNvbnN0IHZvaWQgKmluZm8sIGVudW0gdGxiX2ZsdXNoX3JlYXNvbiByZWFz
b24pDQoNCkhvcGVmdWxseSBJIGRlY2lwaGVyIHRoZSDigJxodWg/4oCdIGNvcnJlY3RseS4uLg0K
DQpXaGVuIHdlIG1vdmVkIHRoZSBmbHVzaF90bGJfaW5mbyBvZmYgdGhlIHN0YWNrLCBpbiB0aGUg
cGF0Y2ggdGhhdCB5b3UNCnJlZmVyZW5jZSwgd2UgY3JlYXRlZCBhIGdsb2JhbCBmdWxsX2ZsdXNo
X3RsYl9pbmZvIHZhcmlhYmxlLCB3aGljaCB3YXMgc2V0DQphcyBjb25zdCBhbmQgZGVsaXZlcmVk
IHRvIGZsdXNoX3RsYl9mdW5jX2xvY2FsLiBJIGNoYW5nZWQgdGhlIHNpZ25hdHVyZSBvZg0KdGhl
IGZ1bmN0aW9uIHRvIGF2b2lkIGNhc3RpbmcuIElJUkMsIHNldHRpbmcgdGhlIHZhcmlhYmxlIGFz
IGNvbnN0YW50DQpzbGlnaHRseSBpbXByb3ZlZCB0aGUgZ2VuZXJhdGVkIGFzc2VtYmx5LCBhbmQg
YW55aG93IG1hZGUgc2Vuc2UuDQoNCkluIHRoaXMgcGF0Y2gtc2V0IEkgbmVlZCB0byBjaGFuZ2Ug
dGhlIGZpcnN0IGFyZ3VtZW50IG9mDQpmbHVzaF90bGJfZnVuY19sb2NhbCB0byBiZSBub24tY29u
c3QgdG8gbWF0Y2ggdGhlIFNNUCBmdW5jdGlvbiBzaWduYXR1cmUNCndoaWNoIHRha2VzIGEgc2lu
Z2xlIG5vbi1jb25zdCB2b2lkICogYXJndW1lbnQuIFllcywgdGhlcmUgaXMgd2hhdCBzZWVtcyB0
bw0KYmUgbm9uLXNhZmUgY2FzdGluZywgYnV0IGZsdXNoX3RsYl9mdW5jX2NvbW1vbigpIGNhc3Rz
IGl0IGJhY2sgaW50byBhIGNvbnN0DQp2YXJpYWJsZS4NCg0KSSBrbm93IHRoYXQgSSBhbHNvIGFk
ZGVkIHRoZSBpbmZyYXN0cnVjdHVyZSB0byBydW4gYSBmdW5jdGlvbiBsb2NhbGx5IGluIHRoZQ0K
U01QIGluZnJhc3RydWN0dXJlLCBidXQgaXQgbWFkZSBzZW5zZSB0byBoYXZlIHRoZSBzYW1lIHNp
Z25hdHVyZSBmb3IgbG9jYWwNCmZ1bmN0aW9uIGFuZCByZW1vdGUgb25lcy4NCg0KRG9lcyBpdCBt
YWtlIG1vcmUgc2Vuc2Ugbm93Pw0KDQo=
