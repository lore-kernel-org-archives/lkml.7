Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3798C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6075D21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Ossg6M3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403788AbfKETiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:38:01 -0500
Received: from mail-eopbgr720133.outbound.protection.outlook.com ([40.107.72.133]:2209
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390873AbfKETiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:38:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4VYHn8p1It7Hk8ES9cIkbQ2hDLv2UM9dpALbesv/HfcV7L8Q3iUUDDfQrbOMAk0kRhWWm2iC8wriQwW82I7XrtjmCTlCIKEkSbVcnEX+yKzTllo1BEGVTJFLTdv1TqsiSRPrDH+aicCoQqQk5B/pT31G87MSILbp5HIZ2/7izyK29KaxnRId7Bu92z0dED+eJ9WqzyKAfVpLTu34KsqqwUPVl56dWiSAVgscRBObKYxQBIEHDhfBnSGGmG+06Pae7uZcUoOA+mtZ4krCGtqY42qpvqyfmoVhZjNkBJnCnJZ7nyQHaxYfGxHbYBde9sGCKBDYz4pXQM+uiv0HRKfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InJeiLUtrrksI7puw3zP8VDwYzSVtFqfSfIR4BOiOKg=;
 b=M9he2Rjd3GE0JOMDJ3lut2XwgnCWjDdYW7toeSLDDPhgs6YCE+LZC03ctNKqqRVxmE5aW501MYFrBS/5XKytHdAApVEu67IR5/Vg4Hm7XH9JhyzQP3ryrdb0n/GFOI0kmVkKuzL/5jtyu0xTZVs01Y3OiAwNcKy1sJy1crJtbtqIKlM8eW+iyhF43tYPSqGu98azMRjO+W8nwfB636CjXwLmyIkmHICGaFTjyy+NjfQrlTaRjLf+BogxANHyBXVUY4O5uxjahacoVH/V628s07ckKBQe19S4nwTALxf5bDRX19tYrm2bWNQbKJZQGfDDuK6r+ysTHEc2cU8qaYZ9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InJeiLUtrrksI7puw3zP8VDwYzSVtFqfSfIR4BOiOKg=;
 b=Ossg6M3KPx/9Ex3YzQqr41qUbjindjpW0vcdmiDrbOq59zNryqEo/EG+nw+mU9VwX/Q0wtoaBJjiofGM6tYDAORzpuYk39er0UiMw/V1PSRwZPpnMwubT8nf/xkXq9fmiWFLIGlcji6VCRfTuIJQbmOOqAHWjylGOpBGgm65HAo=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2075.namprd13.prod.outlook.com (10.174.185.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.13; Tue, 5 Nov 2019 19:37:49 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::4c0b:3977:6b2d:6a8c]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::4c0b:3977:6b2d:6a8c%3]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 19:37:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [REGRESSION v5.3] SUNRPC: Replace the queue timer with a delayed
 work function (7e0a0e38fcfe)
Thread-Topic: [REGRESSION v5.3] SUNRPC: Replace the queue timer with a delayed
 work function (7e0a0e38fcfe)
Thread-Index: AQHViwXgaq3NPyyvUUylBSSg67ZqQKd8jB6AgAB+1oA=
Date:   Tue, 5 Nov 2019 19:37:48 +0000
Message-ID: <6fb130dce8b75c487ed68ec623e1f6a64c78fafb.camel@hammerspace.com>
References: <271ff39f-1f44-b201-6274-85f1085bfc16@nvidia.com>
         <329228f8-e194-a021-9226-69a9b6a403ce@nvidia.com>
In-Reply-To: <329228f8-e194-a021-9226-69a9b6a403ce@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.163.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96e68bc8-5396-4410-0161-08d76227a3ff
x-ms-traffictypediagnostic: DM5PR1301MB2075:
x-microsoft-antispam-prvs: <DM5PR1301MB20754C26DF8A3E68D5A043E9B87E0@DM5PR1301MB2075.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39840400004)(346002)(376002)(396003)(189003)(199004)(81156014)(2906002)(2616005)(110136005)(3846002)(99286004)(186003)(7736002)(316002)(25786009)(53546011)(6506007)(66556008)(14444005)(6246003)(81166006)(102836004)(91956017)(66946007)(76176011)(8936002)(66476007)(66446008)(71200400001)(76116006)(64756008)(71190400001)(305945005)(6116002)(8676002)(11346002)(446003)(86362001)(2501003)(256004)(6436002)(14454004)(486006)(5660300002)(118296001)(229853002)(6486002)(6512007)(36756003)(66066001)(476003)(26005)(478600001)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2075;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3apWC4OD+x6R/DzvteuHuq4R+d5TlM34kgLoBy9zkJhnOvS4T6U+ejwTWhX6G5i9Hb3kjHbqvxdG3dWA2wWOabKnqKXMQUtXG4BfkKVi/lnoaaXgs+6+O4PozsO0IoWl0b5w84dkriXO6WrqIyRvyxfSp8dNZl93X9BlvqZLTg6e7ORzvC7Z77TdBQnnY/6cqnh/ncK91+U/sQpLcWR8Ougs/jVzNATwtgjrlq1mCxysaiAEYG6HGK1M/S2JBxJh1E77l36eYe8z50hsPvvyegdEG+fCUNLkzjfo67SzyjXD7f6f02K3qYIX+C+2bbEkCBCJ0jtpVBTNRGI6atgxm9iy5x4HeEDoa4JwMTpnx/WFFFPh6q9L4qn3eQhjAZDui5MkPmw+pTaQP9WPqbfnZHCskLADWZ+A0v+AvvIjQUbwHe5V3u69rBDIf6N738aw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <27B40EEB8361884EA6D568E60B592EBA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e68bc8-5396-4410-0161-08d76227a3ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 19:37:49.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEhJonRTMyc7SiqMiTfwYCRQcq6tL19GobEFkYmNItLH1XFpkWHVWoJkn3f1YbVLJzLlOrwvzIIJNBgGjv1GbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTA1IGF0IDEyOjAzICswMDAwLCBKb24gSHVudGVyIHdyb3RlOg0KPiBI
aSBUcm9uZCwNCj4gDQo+IEFueSBmZWVkYmFjayBvbiB0aGlzPw0KDQpTZWUgdGhlIHBhdGNoIEkg
c2VudCB0aGlzIG1vcm5pbmcuIEkgYmVsaWV2ZSB0aGF0IG91Z2h0IHRvIGZpeCB0aGUNCnByb2Js
ZW0uDQpTb3JyeSBhYm91dCB0aGUgcmVncmVzc2lvbi4gQXMgeW91IHNhdyBmcm9tIHRoZSBvcmln
aW5hbCBwYXRjaCwgaXQNCnByZWRhdGVzIHlvdXIgZmlyc3QgYnVnIHJlcG9ydCwgYW5kIHdoZW4g
SSBxdWV1ZWQgaXQgdXAgZm9yIHN1Ym1pc3Npb24sDQpJIG1pc3NlZCB0aGF0IGl0IHdhcyBjb3B5
aW5nIHRoZSAiZGVmZXJyYWJsZSIgc3RhdHVzIHRoYXQgY2F1c2VkIHRoYXQNCmZpcnN0IGJ1Zy4N
Cg0KQ2hlZXJzDQogIFRyb25kDQoNCj4gDQo+IEpvbg0KPiANCj4gT24gMjUvMTAvMjAxOSAwODoy
OCwgSm9uIEh1bnRlciB3cm90ZToNCj4gPiBIaSBUcm9uZCwNCj4gPiANCj4gPiBTaW1pbGFyIHRv
IHRoZSBjaGFuZ2UgNDMxMjM1ODE4YmMzICgiU1VOUlBDOiBEZWNsYXJlIFJQQyB0aW1lcnMgYXMN
Cj4gPiBUSU1FUl9ERUZFUlJBQkxFIikgSSBoYXZlIGJlZW4gdHJhY2tpbmcgZG93biBhbm90aGVy
IHN1c3BlbmQvTkZTDQo+ID4gcmVsYXRlZA0KPiA+IGlzc3VlIHdoZXJlIGFnYWluIEkgYW0gc2Vl
aW5nIHJhbmRvbSBkZWxheXMgZXhpdGluZyBzdXNwZW5kLiBUaGUNCj4gPiBkZWxheXMNCj4gPiBj
YW4gYmUgdXAgdG8gYSBjb3VwbGUgbWludXRlcyBpbiB0aGUgd29yc3QgY2FzZSBhbmQgdGhpcyBp
cyBjYXVzaW5nDQo+ID4gYQ0KPiA+IHN1c3BlbmQgdGVzdCB3ZSBoYXZlIHRvIGZhaWwuIEZvciBl
eGFtcGxlLCB3aXRoIHRoaXMgY2hhbmdlIEkgc2VlDQo+ID4gLi4uDQo+ID4gDQo+ID4gWyAgMTMw
LjU5OTUyMF0gUE06IHN1c3BlbmQgZW50cnkgKGRlZXApDQo+ID4gDQo+ID4gWyAgMTMwLjYwNzI2
N10gRmlsZXN5c3RlbXMgc3luYzogMC4wMDAgc2Vjb25kcw0KPiA+IA0KPiA+IFsgIDEzMC42MTU4
MDBdIEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzIC4uLiAoZWxhcHNlZCAwLjAwMQ0KPiA+
IHNlY29uZHMpIGRvbmUuDQo+ID4gDQo+ID4gWyAgMTMwLjYyODI0N10gT09NIGtpbGxlciBkaXNh
YmxlZC4NCj4gPiANCj4gPiBbICAxMzAuNjM1MzgyXSBGcmVlemluZyByZW1haW5pbmcgZnJlZXph
YmxlIHRhc2tzIC4uLiAoZWxhcHNlZA0KPiA+IDAuMDAxIHNlY29uZHMpIGRvbmUuDQo+ID4gDQo+
ID4gWyAgMTMwLjY0ODA1Ml0gcHJpbnRrOiBTdXNwZW5kaW5nIGNvbnNvbGUocykgKHVzZQ0KPiA+
IG5vX2NvbnNvbGVfc3VzcGVuZCB0byBkZWJ1ZykNCj4gPiANCj4gPiBbICAxMzAuNjg2MDE1XSBE
aXNhYmxpbmcgbm9uLWJvb3QgQ1BVcyAuLi4NCj4gPiANCj4gPiBbICAxMzAuNjg5NTY4XSBJUlEg
MTc6IG5vIGxvbmdlciBhZmZpbmUgdG8gQ1BVMg0KPiA+IA0KPiA+IFsgIDEzMC42OTM0MzVdIEVu
dGVyaW5nIHN1c3BlbmQgc3RhdGUgTFAxDQo+ID4gDQo+ID4gWyAgMTMwLjY5MzQ4OV0gRW5hYmxp
bmcgbm9uLWJvb3QgQ1BVcyAuLi4NCj4gPiANCj4gPiBbICAxMzAuNjk3MTA4XSBDUFUxIGlzIHVw
DQo+ID4gDQo+ID4gWyAgMTMwLjcwMDYwMl0gQ1BVMiBpcyB1cA0KPiA+IA0KPiA+IFsgIDEzMC43
MDQzMzhdIENQVTMgaXMgdXANCj4gPiANCj4gPiBbICAxMzAuNzgxMjU5XSBtbWMxOiBxdWV1aW5n
IHVua25vd24gQ0lTIHR1cGxlIDB4ODAgKDUwIGJ5dGVzKQ0KPiA+IA0KPiA+IFsgIDEzMC43ODk3
NDJdIG1tYzE6IHF1ZXVpbmcgdW5rbm93biBDSVMgdHVwbGUgMHg4MCAoNyBieXRlcykNCj4gPiAN
Cj4gPiBbICAxMzAuNzkyNzkzXSBtbWMxOiBxdWV1aW5nIHVua25vd24gQ0lTIHR1cGxlIDB4ODAg
KDcgYnl0ZXMpDQo+ID4gDQo+ID4gWyAgMTMwLjgyMDkxM10gbW1jMTogcXVldWluZyB1bmtub3du
IENJUyB0dXBsZSAweDAyICgxIGJ5dGVzKQ0KPiA+IA0KPiA+IFsgIDEzMS4zNDU1NjldIE9PTSBr
aWxsZXIgZW5hYmxlZC4NCj4gPiANCj4gPiBbICAxMzEuMzUyNjQzXSBSZXN0YXJ0aW5nIHRhc2tz
IC4uLiBkb25lLg0KPiA+IA0KPiA+IFsgIDEzMS4zNjU0ODBdIFBNOiBzdXNwZW5kIGV4aXQNCj4g
PiANCj4gPiBbICAxMzQuNTI0MjYxXSBhc2l4IDEtMToxLjAgZXRoMDogbGluayB1cCwgMTAwTWJw
cywgZnVsbC1kdXBsZXgsDQo+ID4gbHBhIDB4Q0RFMQ0KPiA+IA0KPiA+IFsgIDI0My43NDU3ODhd
IG5mczogc2VydmVyIDE5Mi4xNjguOTkuMSBub3QgcmVzcG9uZGluZywgc3RpbGwNCj4gPiB0cnlp
bmcNCj4gPiANCj4gPiBbICAyNDMuNzQ1ODExXSBuZnM6IHNlcnZlciAxOTIuMTY4Ljk5LjEgbm90
IHJlc3BvbmRpbmcsIHN0aWxsDQo+ID4gdHJ5aW5nDQo+ID4gDQo+ID4gWyAgMjQzLjc2NzkzOV0g
bmZzOiBzZXJ2ZXIgMTkyLjE2OC45OS4xIG5vdCByZXNwb25kaW5nLCBzdGlsbA0KPiA+IHRyeWlu
Zw0KPiA+IA0KPiA+IFsgIDI0My43NzgyMzNdIG5mczogc2VydmVyIDE5Mi4xNjguOTkuMSBPSw0K
PiA+IA0KPiA+IFsgIDI0My43ODcwNThdIG5mczogc2VydmVyIDE5Mi4xNjguOTkuMSBPSw0KPiA+
IA0KPiA+IFsgIDI0My43ODc1NDJdIG5mczogc2VydmVyIDE5Mi4xNjguOTkuMSBPSw0KPiA+IA0K
PiA+IA0KPiA+IFJ1bm5pbmcgYSBnaXQgYmlzZWN0IEkgd2FzIGFibGUgdG8gdHJhY2sgaXQgZG93
biB0byB0aGUgY29tbWl0DQo+ID4gcmVmZXJlbmNlZA0KPiA+IGluIHRoZSAkc3ViamVjdC4gUmV2
ZXJ0aW5nIHRoaXMgb24gdG9wIG9mIHRoZSBjdXJyZW50IG1haW5saW5lDQo+ID4gZml4ZXMgdGhl
DQo+ID4gcHJvYmxlbSBhbmQgSSBubyBsb25nZXIgc2VlIHRoZXNlIGxvbmcgZGVsYXlzLg0KPiA+
IA0KPiA+IENoZWVycw0KPiA+IEpvbg0KPiA+IA0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
