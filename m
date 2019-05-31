Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DDAC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B45326D69
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="jm8PsdSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfEaRuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:50:37 -0400
Received: from mail-eopbgr770085.outbound.protection.outlook.com ([40.107.77.85]:50831
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbfEaRug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTRhyDpQ+8U3W4BGfVb4ViQ40IaMw4Za6lvqyTItViE=;
 b=jm8PsdSrWJ4v+o1YczyegB2AOaiAS93Y9B9xqwYWEGV3f/5Y9VO//QfKm255jdXh2qqtNGcTtGF/zQvpCd7unrSS/WP3lHzZc/gz7HDl4c0b6IHNJuJtIo7Jyu1pWrF2YD+KMhIp+sOE0iaO6Ma8HOMuU1VGKCv/DmbfGH9XySY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4631.namprd05.prod.outlook.com (52.135.233.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.13; Fri, 31 May 2019 17:50:33 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 17:50:33 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH v2 07/12] smp: Do not mark call_function_data as
 shared
Thread-Topic: [RFC PATCH v2 07/12] smp: Do not mark call_function_data as
 shared
Thread-Index: AQHVF3tHc4RuzwJ8oEm2qpYRIrashKaFBRQAgAB+pAA=
Date:   Fri, 31 May 2019 17:50:33 +0000
Message-ID: <D35EA688-7FCA-4D64-8C9E-9303827BC582@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-8-namit@vmware.com>
 <20190531101716.GN2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190531101716.GN2623@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f740a77-2382-4c7c-5fd9-08d6e5f07aa4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4631;
x-ms-traffictypediagnostic: BYAPR05MB4631:
x-microsoft-antispam-prvs: <BYAPR05MB463171249CBF1D77067BCB44D0190@BYAPR05MB4631.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(53936002)(66066001)(478600001)(186003)(71190400001)(256004)(25786009)(36756003)(83716004)(76116006)(486006)(8936002)(33656002)(446003)(71200400001)(229853002)(476003)(316002)(54906003)(6246003)(14454004)(4326008)(66946007)(11346002)(73956011)(82746002)(2616005)(66476007)(66556008)(64756008)(26005)(6116002)(5660300002)(4744005)(3846002)(86362001)(8676002)(66446008)(6506007)(6916009)(99286004)(76176011)(305945005)(68736007)(102836004)(6436002)(53546011)(81156014)(6486002)(2906002)(14444005)(6512007)(7736002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4631;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 05zwcgWY/Ur1vHeTj336Gd2pBqO2Itqa+yQeS9I3asbg1P5zyQRkQrg2uLBRmLt43toTlJ22K/vm/Sr2a61mtVhDiU8++GqwzR4mY7+QXU5DgKquflFIQoHBvjAf5uOpxaskzjtg7s2v48+y6jEylofyjxh0hB9bFxojObxBTu/9dQGeSp9fLM8/bnI3stfVkhsfcSFFiqeOG561NxsgqAZTmlsdR6bQtv96PBV0Cm98RC1eWYwBo04zN0qw8I9dVokE6zRTsY8wznX3PyRecsrqhZy6jdrfBVRs144Kc7MBWszW9AmmXtryPKdI1LhIfP0aSwQHwCC2S6dzOO6wdUWjbLV05hEqPtqK7cND4maX8YqYK8diT/bFKA7juk4j4yAePc5vdKF2Un7/ach0Fq78uUchoo3jdn9goxVA230=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24121A827D57514BB579860D2E6388A2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f740a77-2382-4c7c-5fd9-08d6e5f07aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 17:50:33.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMzEsIDIwMTksIGF0IDM6MTcgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE1heSAzMCwgMjAxOSBhdCAxMTozNjo0
MFBNIC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gY2ZkX2RhdGEgaXMgbWFya2VkIGFzIHNo
YXJlZCwgYnV0IGFsdGhvdWdoIGl0IGhvbGQgcG9pbnRlcnMgdG8gc2hhcmVkDQo+PiBkYXRhIHN0
cnVjdHVyZXMsIGl0IGlzIHByaXZhdGUgcGVyIGNvcmUuDQo+PiANCj4+IENjOiBQZXRlciBaaWps
c3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+DQo+PiBDYzogUmlrIHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwuY29tPg0K
Pj4gQ2M6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1i
eTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4+IC0tLQ0KPj4ga2VybmVsL3NtcC5j
IHwgMiArLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+PiANCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvc21wLmMgYi9rZXJuZWwvc21wLmMNCj4+IGlu
ZGV4IDZiNDExZWU4NmVmNi4uZjFhMzU4ZjljMzRjIDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL3Nt
cC5jDQo+PiArKysgYi9rZXJuZWwvc21wLmMNCj4+IEBAIC0zMyw3ICszMyw3IEBAIHN0cnVjdCBj
YWxsX2Z1bmN0aW9uX2RhdGEgew0KPj4gCWNwdW1hc2tfdmFyX3QJCWNwdW1hc2tfaXBpOw0KPj4g
fTsNCj4+IA0KPj4gLXN0YXRpYyBERUZJTkVfUEVSX0NQVV9TSEFSRURfQUxJR05FRChzdHJ1Y3Qg
Y2FsbF9mdW5jdGlvbl9kYXRhLCBjZmRfZGF0YSk7DQo+PiArc3RhdGljIERFRklORV9QRVJfQ1BV
KHN0cnVjdCBjYWxsX2Z1bmN0aW9uX2RhdGEsIGNmZF9kYXRhKTsNCj4gDQo+IFNob3VsZCB0aGF0
IG5vdCBiZSBERUZJTkVfUEVSX0NQVV9BTElHTkVEKCkgdGhlbj8NCg0KWWVzLiBJIGRvbuKAmXQg
a25vdyB3aGF0IEkgd2FzIHRoaW5raW5nLiBJ4oCZbGwgY2hhbmdlIGl0Lg0KDQo=
