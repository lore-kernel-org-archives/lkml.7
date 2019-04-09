Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384DFC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBC12133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XO9xNChp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDIQdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:33:43 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:35571
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbfDIQdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az/K+onyhoxx2Ww4scP1ZCp3wMtn7Eh3EZqD+IZndfQ=;
 b=XO9xNChpAUyymRTmS9iUHO28/QqFF0CaxOUNswBm4+amVxCVAb6jfFGpjUhiQRY1qsa3Vyub1d/SwKEPB+gCr3MS2UR9X1/V1e9QXSw1uuIyq5JJIKRa0TKZkXBnHEy5LPwB4Fuhl0E/+KYNAtl099KHvsmFnjzlmPDLXp7v4gQ=
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com (20.178.84.149) by
 DB7PR08MB4601.eurprd08.prod.outlook.com (20.178.85.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 16:33:38 +0000
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::e86b:208d:988e:119f]) by DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::e86b:208d:988e:119f%4]) with mapi id 15.20.1771.019; Tue, 9 Apr 2019
 16:33:38 +0000
From:   =?utf-8?B?UmFwaGHDq2wgR2F1bHQ=?= <Raphael.Gault@arm.com>
To:     Julien Thierry <Julien.Thierry@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>
Subject: Re: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Thread-Topic: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Thread-Index: AQHU7tulYY+OqZKg/k6QJwe1WY2Za6Y0ADkAgAADb4CAAAD3AIAAAaCA
Date:   Tue, 9 Apr 2019 16:33:38 +0000
Message-ID: <2ebce265-d544-4943-6ddb-3f4858aab6a4@arm.com>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-4-raphael.gault@arm.com>
 <20190409161204.GS11158@hirez.programming.kicks-ass.net>
 <20190409162420.GB32587@lakrids.cambridge.arm.com>
 <bc258aae-1f2f-0674-2eeb-43e4cff6bb29@arm.com>
In-Reply-To: <bc258aae-1f2f-0674-2eeb-43e4cff6bb29@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::22) To DB7PR08MB3865.eurprd08.prod.outlook.com
 (2603:10a6:10:32::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Raphael.Gault@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc42cbcc-0537-4131-5907-08d6bd091e2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB4601;
x-ms-traffictypediagnostic: DB7PR08MB4601:
x-microsoft-antispam-prvs: <DB7PR08MB46011B8701706956228DB0A9ED2D0@DB7PR08MB4601.eurprd08.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(40434004)(199004)(189003)(6512007)(102836004)(52116002)(97736004)(446003)(11346002)(6506007)(4326008)(2616005)(72206003)(476003)(31686004)(110136005)(76176011)(386003)(53546011)(486006)(256004)(106356001)(5024004)(14444005)(85202003)(71200400001)(186003)(105586002)(25786009)(54906003)(316002)(99286004)(26005)(71190400001)(53936002)(14454004)(81156014)(66066001)(229853002)(6116002)(3846002)(6436002)(31696002)(7736002)(5660300002)(81166006)(2906002)(6486002)(86362001)(478600001)(6246003)(93886005)(68736007)(36756003)(8676002)(8936002)(85182001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB4601;H:DB7PR08MB3865.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ca4AU1PK/kmzlP5AogkbJO1AXPxXsA3fmB6E3jd9gyoQG/koc4K0hzPU91iFtqn/MXY3WPZRtQQeu4M2I7qx9bNvBTc54fePYxm4ZBlBS4j12EqbL1OjEeW63pipU7o7ooSvalQn8HwqTWgyoJuwWa0AV2Bh00lm3eqLrY1Eb6TXmV6pgNASXwS9X4jwfkPXHEJWheWyALlR1P85jSYK+ld4blKj0lvf3dT084w+y/vVKCo9iUqYfk2JDTaRHXGtysz00TUStrUhVYfd6hi8hx6w1ialevuzz38oj7gXI6yem6bN9ilYoUVNdHutu6Yh/VOgJU4FyO5uM4y2+MzhqLOldSCqSw0VYOmleon/FI4W+mFKQ+9XKK8zTNRuR3z6RDQ+GK0Nnt39oi2cF2V2giGt4kH9ufj6HPi1breg384=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A4657ED86250246A95FEC4DD6E4B80D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc42cbcc-0537-4131-5907-08d6bd091e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 16:33:38.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB4601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDQvOS8xOSA1OjI3IFBNLCBKdWxpZW4gVGhpZXJyeSB3cm90ZToNCj4NCj4NCj4g
T24gMDkvMDQvMjAxOSAxNzoyNCwgTWFyayBSdXRsYW5kIHdyb3RlOg0KPj4gT24gVHVlLCBBcHIg
MDksIDIwMTkgYXQgMDY6MTI6MDRQTSArMDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+Pj4N
Cj4+PiBJJ20ganVzdCBkb2luZyBteSBpbml0aWFsIHJlYWQtdGhyb3VnaCwuLiBob3dldmVyDQo+
Pj4NCj4+PiBPbiBUdWUsIEFwciAwOSwgMjAxOSBhdCAwMjo1Mjo0MFBNICswMTAwLCBSYXBoYWVs
IEdhdWx0IHdyb3RlOg0KPj4+PiAraWYgKCEoc2VjLT5zaC5zaF9mbGFncyAmIFNIRl9FWEVDSU5T
VFIpDQo+Pj4+ICsmJiAoc3RyY21wKHNlYy0+bmFtZSwgIi5hbHRpbnN0cl9yZXBsYWNlbWVudCIp
IHx8ICFJR05PUkVfU0hGX0VYRUNfRkxBRykpDQo+Pj4+ICAgY29udGludWU7DQo+Pj4NCj4+PiBj
b3VsZCB5b3UgcGxlYXNlIG5vdCBmb3JtYXQgY29kZSBsaWtlIHRoYXQuIE9wZXJhdG9ycyBnbyBh
dCB0aGUgZW5kIG9mDQo+Pj4gdGhlIGxpbmUsIGFuZCBjb250aW51YXRpb24gc2hvdWxkIG1hdGNo
IHRoZSBpbmRlbnRhdGlvbiBvZiB0aGUgb3BlbmluZw0KPj4+IHBhcmVuLiBTbyB0aGUgYWJvdmUg
d291bGQgbG9vayBsaWtlOg0KPj4+DQo+Pj4+ICtpZiAoIShzZWMtPnNoLnNoX2ZsYWdzICYgU0hG
X0VYRUNJTlNUUikgJiYNCj4+Pj4gKyAgICAoc3RyY21wKHNlYy0+bmFtZSwgIi5hbHRpbnN0cl9y
ZXBsYWNlbWVudCIpIHx8ICFJR05PUkVfU0hGX0VYRUNfRkxBRykpDQo+Pj4+ICAgY29udGludWU7
DQo+Pj4NCj4+PiBZb3UgYXBwZWFyIHRvIGJlIGRvaW5nIHRoYXQgcXVpdCBjb25zaXN0ZW50bHks
IGFuZCBpdCBpcyBhZ2FpbnN0IHN0eWxlLg0KDQpUaGFuayB5b3UgZm9yIHRoZXNlIHJlbWFya3Ms
IEkgd2lsbCBjb3JyZWN0IHRoaXMhDQoNCj4+DQo+PiBSYXBoYWVsLCBhcyBhIGhlYWRzLXVwLCAu
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCBjYW4gY2F0Y2ggaXNzdWVzIGxpa2UNCj4+IHRoaXMuIFlv
dSBjYW4gcnVuIGl0IG92ZXIgYSBsaXN0IG9mIHBhdGNoZXMsIHNvIGZvciBhIHBhdGNoIHNlcmll
cyB5b3UNCj4+IGNhbiBydW46DQo+Pg0KPj4gICAkIC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsICou
cGF0Y2gNCj4+DQo+PiAuLi4gYW5kIGhvcGVmdWxseSBtb3N0IG9mIHRoZSBvdXRwdXQgd2lsbCBi
ZSByZWFzb25hYmxlLg0KPj4NCj4NCj4gRm9yIHRoaXMgcGFydGljdWxhciBjYXNlLCBjaGVja3Bh
dGNoIG9ubHkgd2FybnMgYWJvdXQgaXQgaWYgeW91IHBhc3MgaXQNCj4gIi0tc3RyaWN0IiBvcHRp
b24uIFNvIGluIGdlbmVyYWwgaXQgbWlnaHQgYmUgdXNlZnVsIHRvIGluY2x1ZGUgdGhpcw0KPiBv
cHRpb24gYXQgbGVhc3QgZm9yIHRoZSBmaXJzdCBwYXNzIGF0IGluY2x1ZGluZyBsYXJnZSBwaWVj
ZXMgb2YgY29kZS4NCj4NCg0KSW5kZWVkIHRoYXQgc291bmRzIHVzZWZ1bGwsIHRoYW5rcywNCg0K
PiBDaGVlcnMsDQo+DQoNCkNoZWVycywNCg0KLS0NClJhcGhhZWwgR2F1bHQNCklNUE9SVEFOVCBO
T1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJl
IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3Qg
dGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24s
IHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9u
IGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
