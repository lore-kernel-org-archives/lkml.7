Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFA6C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5B120640
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbfIYTYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:24:40 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:57883 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbfIYTYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:24:40 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Wed, 25 Sep 2019 19:23:43 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 25 Sep 2019 19:21:16 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 25 Sep 2019 19:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djKvKjy909BIIjK4lA7RFGJpuUIoOU28hIMlGGCjGH7bXKM4O9P5NR1ClLlJSl8vmn2q+lJH4ac0eIG3fPeFBUKx+GLEM0I1AW/j2FQgIrSalifeEXtEttLEiQt8WAW88KIlKt1pHzF58J06360IaQ82P+scImzX6VVkaeABQevwgWfdmdbadZrAgL0QAbjnr6jv4GtfwQkWsC5vIn+GrkiVIm37Zrcd5Lm8ZFAnB4X2eo3IYS9JujSr0mLe26X6hP93WcQZS/OD40FNzJIhaFhbv+VqZAVIhFWgeQeMwepZy8u6tWPxJfVldKLGDD2RN6Y2ml06mp+VMMlvrpFZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkzlXf1zHjhifCKMt3Vcrb8euIr9tbCFfl3ii5IvDsg=;
 b=OKR6DvRaUWeM/3eJZyohs2zw12KUsAuBiqnDKqhgRWaQs7GUpfV0OOh3CtHDZ817qYRBGrNwpls8kO7xiOkSOguGS6he2AU4Qk6U4odoff9Jfw07pKa2Hf6DzXdgom/tm8GGIYXTzux9fbiD7eITs76vJ/R33qS5t0Cxhb8yLFr7EPO5uKPL+9TfIHnoL/9eJ1okjNJeO6O3pFTkJEzdfOcRQIW2+CgNfgXPsR2aNH0BbBCRlCiFREJbp7MWtO6sDm4t310JXIbE/UOHUjO39MDy/Ae6/Edma7Vxw5KaIsNAwBvLoyK08yVMHUb0ytlRN1HXu/scmpe1mcDfsbZ87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CY4PR1801MB1848.namprd18.prod.outlook.com (10.171.255.11) by
 CY4PR1801MB1943.namprd18.prod.outlook.com (10.171.253.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 19:21:14 +0000
Received: from CY4PR1801MB1848.namprd18.prod.outlook.com
 ([fe80::385d:2356:c3b4:5af2]) by CY4PR1801MB1848.namprd18.prod.outlook.com
 ([fe80::385d:2356:c3b4:5af2%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 19:21:14 +0000
From:   Tony Jones <TonyJ@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "florian.schmidt@nutanix.com" <florian.schmidt@nutanix.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tracing, vmscan: add comments for perf script
 page-reclaim
Thread-Topic: [PATCH 2/2] tracing, vmscan: add comments for perf script
 page-reclaim
Thread-Index: AQHVbi7xrrpo0QOXLUOiqyb6wYY3Mqc80GUA
Date:   Wed, 25 Sep 2019 19:21:14 +0000
Message-ID: <08afb22b-de50-7a2b-6d37-136d1bc41b23@suse.com>
References: <1568817522-8754-1-git-send-email-laoar.shao@gmail.com>
 <1568817522-8754-3-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1568817522-8754-3-git-send-email-laoar.shao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:301:4a::22) To CY4PR1801MB1848.namprd18.prod.outlook.com
 (2603:10b6:910:7a::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=TonyJ@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [76.115.16.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2846dce0-0fb4-415d-9a98-08d741ed87e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR1801MB1943;
x-ms-traffictypediagnostic: CY4PR1801MB1943:
x-microsoft-antispam-prvs: <CY4PR1801MB19439944FC8F6E8C4101F813C3870@CY4PR1801MB1943.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(316002)(110136005)(4326008)(31696002)(8676002)(81156014)(14444005)(256004)(99286004)(36756003)(76176011)(6436002)(2501003)(6246003)(52116002)(478600001)(26005)(66066001)(14454004)(102836004)(31686004)(186003)(6512007)(4744005)(71200400001)(3846002)(25786009)(8936002)(7416002)(229853002)(71190400001)(86362001)(305945005)(66556008)(66946007)(66446008)(64756008)(6486002)(386003)(476003)(7736002)(66476007)(80792005)(53546011)(2201001)(5660300002)(11346002)(446003)(81166006)(6116002)(54906003)(2906002)(486006)(6506007)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1801MB1943;H:CY4PR1801MB1848.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UFpHfQKX3CCVL6/l0s/zFAL3+7lSOQ7S5ipOPvGMr4PrCczW5uSA93POrNeMpXYafUQukRByrA/jUa5cqOiphRByM3usgt7zmwsT4nNJDKHvfE9nZ52mGWbIkbeyV9Gs8qCpZRwYrbauh96i+1GuBhuMQYoAmT4o6T4aH29e24rN2VKzVr0Z+QfDD2hDLd2E8u1RR+krmIitfrKqKebv34ktTSsTQl1TBAa6lmAcFe9ANwVp06YD6W5ya6xrJX9MYVVHAJ1E7GIWfepKNCYSG+VXeANWOlck43C2PR9exxd2qpHBk0hOQHATDPwa5Hpap9aEBJkYPbVG7bHucRho7jSdVSnvnGM37iDFXdiyGuyZYOgk5RWKi+OBZLo5wP21nZiO9BMYCkHxjkfoa3MSwln0tn3OkdJTPydsLN6wCNM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AA65A7F42A70B4C977BDE5E83001F2E@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2846dce0-0fb4-415d-9a98-08d741ed87e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:21:14.2397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WdNzCdvyWVH3XFi7FGWXRj6podY98HfyJxyDCgke71S3/ImNYKxWG/HC7XCen9F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB1943
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xOC8xOSA3OjM4IEFNLCBZYWZhbmcgU2hhbyB3cm90ZToNCj4gQ3VycmVudGx5IHRoZXJl
J3Mgbm8gZWFzeSB3YXkgdG8gbWFrZSBwZXJmIHNjcmlwdHMgaW4gc3luYyB3aXRoDQo+IHRyYWNl
cG9pbnRzLiBPbmUgcG9zc2libGUgd2F5IGlzIHRvIHJ1biBwZXJmJ3MgdGVzdHMgcmVndWxhcmx5
LCBhbm90aGVyIHdheQ0KPiBpcyBvbmNlIHdlIGNoYW5nZXMgdGhlIGRlZmluaXRpb25zIG9mIHRy
YWNlcG9pbnRzIHdlIG11c3Qga2VlcCBpbiBtaW5kIHRoYXQNCj4gdGhlIHBlcmYgc2NyaXB0cyB3
aGljaCBhcmUgdXNpbmcgdGhlc2UgdHJhY2Vwb2ludHMgbXVzdCBiZSBjaGFuZ2VkIGFzIHdlbGwu
DQo+IFNvIEkgYWRkIHRoaXMgY29tbWVudCBmb3IgdGhlIG5ldyBpbnRyb2R1Y2VkIHBhZ2UtcmVj
bGFpbSBzY3JpcHQgYXMgYQ0KPiByZW1pbmRlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWWFmYW5n
IFNoYW8gPGxhb2FyLnNoYW9AZ21haWwuY29tPg0KDQpUaGlzIHNlZW1zIGxpa2UgdGhlIHRhaWwg
d2FnZ2luZyB0aGUgZG9nIHRvIG1lLsKgIElmIHdlIGFkZGVkIHRoaXMgdG8gZXZlcnkgdHAgZGVm
biB0aGF0IGlzIHVzZWQgYnkgYSBwZXJmIHBlcmwvcHl0aG9uIHNjcmlwdCB0aGUgdHAgaGVhZGVy
cyB3b3VsZCBiZSBsaXR0ZXJlZCB3aXRoIHN1Y2ggY29tbWVudHMuDQoNCg==
