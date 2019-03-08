Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657F7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A8520851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="BqQYPCE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCHTfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:35:21 -0500
Received: from mail-eopbgr780070.outbound.protection.outlook.com ([40.107.78.70]:53678
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfCHTfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3PO8npZ45L/vP6qgV33Wfe/anwH2o6PnX/r27F4+zc=;
 b=BqQYPCE30oPmuSZucN+Kw1YdiHqanwH/10dJqf0utomq7nw/q5pwzsMnnQ16pUexWzj8Mf99plyP70L3InXW0ayj2xSv3Z1u32D0WcddqbWJ6xha9M63gDjHF3YXrGWgAIAVW4FE5pvbjo0yM4gSIwT+tIKFjxf4drZ0DreKWD0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4885.namprd05.prod.outlook.com (52.135.235.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.6; Fri, 8 Mar 2019 19:35:17 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5%4]) with mapi id 15.20.1686.019; Fri, 8 Mar 2019
 19:35:17 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] x86/percpu semantics and fixes
Thread-Topic: [PATCH 0/5] x86/percpu semantics and fixes
Thread-Index: AQHUzoWJaf0Z+yLnPU65WpuGGs/UqqYB34KAgABPjwA=
Date:   Fri, 8 Mar 2019 19:35:17 +0000
Message-ID: <64526663-1F10-42A6-A005-92657264D587@vmware.com>
References: <20190227101252.413192716@infradead.org>
 <20190308145031.GY32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190308145031.GY32494@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a1aeebb-05f5-47f4-dada-08d6a3fd31d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4885;
x-ms-traffictypediagnostic: BYAPR05MB4885:
x-microsoft-antispam-prvs: <BYAPR05MB4885F734E03FE55B6AEF7B09D04D0@BYAPR05MB4885.namprd05.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(97736004)(53546011)(71200400001)(54906003)(6436002)(2906002)(53936002)(83716004)(229853002)(256004)(68736007)(86362001)(71190400001)(8936002)(81166006)(81156014)(8676002)(6512007)(33656002)(82746002)(5024004)(106356001)(6486002)(14444005)(6506007)(478600001)(66066001)(14454004)(25786009)(102836004)(4326008)(7736002)(186003)(6916009)(3846002)(5660300002)(99286004)(26005)(6116002)(446003)(6246003)(76176011)(316002)(476003)(486006)(36756003)(11346002)(2616005)(305945005)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4885;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1AI+pSAA+eo4gZi26dmoy+Vtj8MVOXJIwhHUC5WQPBEx8Q+YDkhurWTKDL+XV0nBZ36FuQ1WbQEYnqm5+jvOBZZXu87WWj8aXjh770xMJJtw3ogqsaaHk0ykdNx+JB+peoHyt6QCw5RjsfOXierRAd+mEEEC+6HU5KG5m66nM0Fd5f+ImlFsVLQh+1NPSsm/gWFcKZTxh6xz/qzmhVNTdiGCoFBXeZ/sdG8/fRoQXCz35fKAK7v7WlOURKfUI0D5nj+apHOOifEPwUzvzCmjL1Sbx0cvFXwDUH445IdhKbljHpcp71iZUnj4U/FuwUAIEl4+B9SBkBolYydqT4OTGneIuIn1AB5RRjrBJXlibDmnptDijiwRKMmljFvDt+LbJLGmbwVj0/jGkIYwtkGxPAZXjF+MbLCIXPwjsju1yTs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B89C9A420C322B4CA03C15AF969349CD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1aeebb-05f5-47f4-dada-08d6a3fd31d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 19:35:17.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXIgOCwgMjAxOSwgYXQgNjo1MCBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgRmViIDI3LCAyMDE5IGF0IDExOjEyOjUy
QU0gKzAxMDAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiANCj4+IFRoaXMgaXMgYSBjb2xsZWN0
aW9uIG9mIHg4Ni9wZXJjcHUgY2hhbmdlcyB0aGF0IEkgaGFkIHBlbmRpbmcgYW5kIGdvdCByZW1p
bmRlZA0KPj4gb2YgYnkgTGludXMnIGNvbW1lbnQgeWVzdGVyZGF5IGFib3V0IF9fdGhpc19jcHVf
eGNoZygpLg0KPj4gDQo+PiBUaGlzIHRpZGllcyB1cCB0aGUgeDg2L3BlcmNwdSBwcmltaXRpdmVz
IGFuZCBmaXhlcyBhIGJ1bmNoIG9mICdmYWxsb3V0Jy4NCj4gDQo+IChTb3JyeTsgdGhpcyBpcyBn
b2luZyB0byBoYXZlIF93aWRlXyBvdXRwdXQpDQo+IA0KPiBPSywgc28gd2hhdCBJIGRpZCBpcyBJ
IGJ1aWxkIDQga2VybmVscyAoTz1kZWZjb25maWctYnVpbGR7LDEsMiwzfSkgd2l0aA0KPiByZXNw
IHRoYXQgbWFueSBwYXRjaGVzIG9mIHRoaXMgc2VyaWVzIGFwcGxpZWQuDQo+IA0KPiBXaGVuIEkg
bG9vayBhdCBqdXN0IHRoZSB2bWxpbnV4IHNpemUgb3V0cHV0Og0KPiANCj4gJCBzaXplIGRlZmNv
bmZpZy1idWlsZCovdm1saW51eA0KPiB0ZXh0ICAgIGRhdGEgICAgIGJzcyAgICAgZGVjICAgICBo
ZXggZmlsZW5hbWUNCj4gMTk1NDA2MzEgICAgICAgIDUwNDAxNjQgMTg3MTk0NCAyNjQ1MjczOSAg
ICAgICAgMTkzYTMwMyBkZWZjb25maWctYnVpbGQvdm1saW51eA0KPiAxOTU0MDYzNSAgICAgICAg
NTA0MDE2NCAxODcxOTQ0IDI2NDUyNzQzICAgICAgICAxOTNhMzA3IGRlZmNvbmZpZy1idWlsZDEv
dm1saW51eA0KPiAxOTU0MDY4NSAgICAgICAgNTA0MDE2NCAxODcxOTQ0IDI2NDUyNzkzICAgICAg
ICAxOTNhMzM5IGRlZmNvbmZpZy1idWlsZDIvdm1saW51eA0KPiAxOTU0MDY4NSAgICAgICAgNTA0
MDE2NCAxODcxOTQ0IDI2NDUyNzkzICAgICAgICAxOTNhMzM5IGRlZmNvbmZpZy1idWlsZDMvdm1s
aW51eA0KPiANCj4gVGhpbmdzIGFwcGVhciB0byBnZXQgc2xpZ2h0bHkgbGFyZ2VyOyBob3dldmVy
IHdoZW4gSSBsb29rIGluIG1vcmUNCj4gZGV0YWlsIHVzaW5nIG15IChuZXdseSB3cml0dGVuIGNv
bXBhcmUgc2NyaXB0LCBmaW5kIGF0dGFjaGVkKSwgSSBnZXQNCj4gdGhpbmdzIGxpa2U6DQoNCk5p
Y2Ugc2NyaXB0ISBJIGtlZXAgYXNraW5nIG15c2VsZiBob3cgY29tcGFyaW5nIHR3byBiaW5hcmll
cyBjYW4gcHJvdmlkZQ0Kc29tZSDigJxudW1iZXLigJ0gdG8gaW5kaWNhdGUgaG93IOKAnGdvb2Ti
gJ0gdGhlIGJpbmFyeSBpcyAoYXQgbGVhc3QgcmVsYXRpdmVseSB0bw0KYW5vdGhlciBvbmUpIC0g
ZWl0aGVyIGR1cmluZyBjb21waWxhdGlvbiBvciBhZnRlci4gQ29kZSBzaXplLCBhcyB5b3Ugc2hv
dywNCmlzIHRoZSB3cm9uZyBtZXRyaWMuDQoNCkFueWhvdywgSSBhbSBhIGxpdHRsZSBkaXNhcHBv
aW50ZWQgKGFuZCBzdXJwcmlzZWQpIHRoYXQgaW4gbW9zdCBjYXNlcyB0aGF0IEkNCnBsYXllZCB3
aXRoLCB0aGlzIGtpbmQgb2Ygb3B0aW1pemF0aW9ucyBoYXZlIG1hcmdpbmFsIGltcGFjdCBvbiBw
ZXJmb3JtYW5jZQ0KYXQgYmVzdCwgZXZlbiB3aGVuIHRoZSBiaW5hcnkgY2hhbmdlcyDigJxhIGxv
dOKAnSBhbmQgd2hlbiBtaWNyb2JlbmNobWFya3MgYXJlDQp1c2VkLg0KDQo=
