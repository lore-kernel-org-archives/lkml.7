Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A0EC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0722173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="D6ERFH5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbfGPWHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:07:03 -0400
Received: from mail-eopbgr790077.outbound.protection.outlook.com ([40.107.79.77]:11075
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728434AbfGPWHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:07:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnjYN2Y31Z7r+o+9zCebwKOG7bQ4/GWzf+zvlwnAKP4BEkEWozaXaN+aUwNC0+s591TNTwLpK8A3ImP9TWv6yLGnbSlxPXuPkm92GTXFahBm+P5iqmrlYjqDfsKfhTA+eAXiRt1w5Y1nyjT0tgKFWEAdX0t5iEpmcgLQ3cs5OLq+yi04mihhbCrI3q2Yaaw29hFLwlX1TrrvoWkLi4Pq6v2RqjJXN28BpSBWP6mWY9Vc3TeZMVoMtfxRzHeRac2rmetmkFuyZdBxOWGj8ejHXmOyshtaKklp/ap/ivvom/iDcwbMwPS/Ay0usNdWKF/7KgEC+cMe31Ww6x72Tpr3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN8GCeyLGOOfHaAtRy84EtOV0X4h8D0qnJw4tZJ02o4=;
 b=MxIf7aYkzpT1PNZQfLBa7qlnk5w6w3Xg4xtmrpJ1vUK07/Pop50B6gLXCHpBgXn3AprnKhu21WzR81t0ia49QHCkD9VEbpRqmvbht/lpTb/z7/qMdGar0S0Xx0P7/TIIVF5dpIuhGps1VfyaT6zq06MZoVLw3uQgsmZZjadapiV9TSFmJQZ/qALF0bxPg56rEHH2T587jh+G2xkkgxcDPG/Atd0ERHgnX3q+oLJhDHqaMGpyCBsxjp9RVWCa1NP11776gtmsHrSWU0hXJUrl5TiLBFGSayrvkSjDz8oisOl0ZV3aeODq0hyIw2dc/ft5OOfigMNaYZbJKk9SYyuq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN8GCeyLGOOfHaAtRy84EtOV0X4h8D0qnJw4tZJ02o4=;
 b=D6ERFH5Cfc9p6O78XhOj7zATHtxzi/tuPKut+ul216j9dirBUgXmtKJMUPE7w8uRU5nOvX2Of9kXqKgk6XPvdJ3iVHDD9CmRQcwJiZ2AIkMwL+mVzUHrHUe6wceLBXTJW8Imu6hQFTSu2yA6MA7RIB5fZuPBVvyqjUwKyb1OgUE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4104.namprd05.prod.outlook.com (52.135.199.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.8; Tue, 16 Jul 2019 22:06:20 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2094.009; Tue, 16 Jul 2019
 22:06:20 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] resource: find_next_iomem_res() improvements
Thread-Topic: [PATCH 0/3] resource: find_next_iomem_res() improvements
Thread-Index: AQHVIaTGJ7ym4R/nDEy6A26DLGCJOaag/0oAgAC3tYCAAA1/gIAAOaaAgCwCaoCAAAGLAA==
Date:   Tue, 16 Jul 2019 22:06:19 +0000
Message-ID: <536D5DED-FE80-441E-8715-1E5E594C2AF0@vmware.com>
References: <20190613045903.4922-1-namit@vmware.com>
 <CAPcyv4hpWg5DWRhazS-ftyghiZP-J_M-7Vd5tiUd5UKONOib8g@mail.gmail.com>
 <9387A285-B768-4B58-B91B-61B70D964E6E@vmware.com>
 <CAPcyv4hstt+0teXPtAq2nwFQaNb9TujgetgWPVMOnYH8JwqGeA@mail.gmail.com>
 <19C3DCA0-823E-46CB-A758-D5F82C5FA3C8@vmware.com>
 <20190716150047.3c13945decc052c077e9ee1e@linux-foundation.org>
In-Reply-To: <20190716150047.3c13945decc052c077e9ee1e@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b50fc135-9fdc-4069-4141-08d70a39d517
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4104;
x-ms-traffictypediagnostic: BYAPR05MB4104:
x-microsoft-antispam-prvs: <BYAPR05MB4104A92A4A5D1938E67286AED0CE0@BYAPR05MB4104.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(51914003)(189003)(199004)(68736007)(53936002)(476003)(305945005)(14454004)(53546011)(33656002)(5660300002)(6506007)(2906002)(102836004)(76176011)(11346002)(7736002)(186003)(6246003)(446003)(91956017)(76116006)(478600001)(6512007)(8936002)(64756008)(66446008)(4326008)(6116002)(316002)(66556008)(3846002)(66946007)(486006)(81156014)(71200400001)(36756003)(7416002)(256004)(25786009)(71190400001)(6486002)(99286004)(66476007)(8676002)(6436002)(2616005)(26005)(229853002)(66066001)(86362001)(54906003)(81166006)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4104;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CXKkzgrQuAOWtkUTIX3Cf6WphcuLiOGG0RNKZdV0lDVik1QYQqkn1oshdoiENbuxGDRBzS4uDabBmdlnyHU9znQIMJSwWKo5rYPn4FpymsTLoA0degB0+0sF1b4Nu30LxXjdch6VIhHm9p17z8kQSUVyj2rhi9v1lgZQld6Cy8oL1Mkb8DVBhnSITFhbJlvgO0gtBDuzaE9ARMQfF1A4WFAYNUKhfwykXO1uLACcFIJyqjh6/30jYPueiCf2GDoD+deFPS5j6PjmPN6Jv79dzSHRp9oBWVNvCU96WNfJPGsYcnVy4JgHnFoa27YNHZOVYT6GbrJWFodyhpCQrDy3h9qcWR58lu2SMRm25ez526k6YB0XQLEjxRLg+Vy6quOf1S7i8gF0eJRikz5L8AFxzU6Nt+BxFLQMSbjKIQMYIdM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87A6D898D2097248AFF7555FAD128BAC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50fc135-9fdc-4069-4141-08d70a39d517
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 22:06:19.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMTYsIDIwMTksIGF0IDM6MDAgUE0sIEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAxOCBKdW4gMjAxOSAyMTo1Njo0
MyArMDAwMCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4gDQo+Pj4gLi4u
YW5kIGlzIGNvbnN0YW50IGZvciB0aGUgbGlmZSBvZiB0aGUgZGV2aWNlIGFuZCBhbGwgc3Vic2Vx
dWVudCBtYXBwaW5ncy4NCj4+PiANCj4+Pj4gUGVyaGFwcyB5b3Ugd2FudCB0byBjYWNoZSB0aGUg
Y2FjaGFiaWxpdHktbW9kZSBpbiB2bWEtPnZtX3BhZ2VfcHJvdCAod2hpY2ggSQ0KPj4+PiBzZWUg
YmVpbmcgZG9uZSBpbiBxdWl0ZSBhIGZldyBjYXNlcyksIGJ1dCBJIGRvbuKAmXQga25vdyB0aGUg
Y29kZSB3ZWxsIGVub3VnaA0KPj4+PiB0byBiZSBjZXJ0YWluIHRoYXQgZXZlcnkgdm1hIHNob3Vs
ZCBoYXZlIGEgc2luZ2xlIHByb3RlY3Rpb24gYW5kIHRoYXQgaXQNCj4+Pj4gc2hvdWxkIG5vdCBj
aGFuZ2UgYWZ0ZXJ3YXJkcy4NCj4+PiANCj4+PiBObywgSSdtIHRoaW5raW5nIHRoaXMgd291bGQg
bmF0dXJhbGx5IGZpdCBhcyBhIHByb3BlcnR5IGhhbmdpbmcgb2ZmIGENCj4+PiAnc3RydWN0IGRh
eF9kZXZpY2UnLCBhbmQgdGhlbiBjcmVhdGUgYSB2ZXJzaW9uIG9mIHZtZl9pbnNlcnRfbWl4ZWQo
KQ0KPj4+IGFuZCB2bWZfaW5zZXJ0X3Bmbl9wbWQoKSB0aGF0IGJ5cGFzcyB0cmFja19wZm5faW5z
ZXJ0KCkgdG8gaW5zZXJ0IHRoYXQNCj4+PiBzYXZlZCB2YWx1ZS4NCj4+IA0KPj4gVGhhbmtzIGZv
ciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24uIEnigJlsbCBnaXZlIGl0IGEgdHJ5ICh0aGUgbW9t
ZW50IEkgZmluZA0KPj4gc29tZSBmcmVlIHRpbWUpLiBJIHN0aWxsIHRoaW5rIHRoYXQgcGF0Y2gg
Mi8zIGlzIGJlbmVmaWNpYWwsIGJ1dCBiYXNlZCBvbg0KPj4geW91ciBmZWVkYmFjaywgcGF0Y2gg
My8zIHNob3VsZCBiZSBkcm9wcGVkLg0KPiANCj4gSXQgaGFzIGJlZW4gYSB3aGlsZS4gIFdoYXQg
c2hvdWxkIHdlIGRvIHdpdGgNCj4gDQo+IHJlc291cmNlLWZpeC1sb2NraW5nLWluLWZpbmRfbmV4
dF9pb21lbV9yZXMucGF0Y2gNCj4gcmVzb3VyY2UtYXZvaWQtdW5uZWNlc3NhcnktbG9va3Vwcy1p
bi1maW5kX25leHRfaW9tZW1fcmVzLnBhdGNoDQo+IA0KPiA/DQoNCkkgZGlkbuKAmXQgZ2V0IHRv
IGZvbGxvdyBEYW4gV2lsbGlhbXMgYWR2aWNlLiBCdXQsIGJvdGggb2YgdHdvIHBhdGNoZXMgYXJl
DQpmaW5lIG9uIG15IG9waW5pb24gYW5kIHNob3VsZCBnbyB1cHN0cmVhbS4gVGhlIGZpcnN0IG9u
ZSBmaXhlcyBhIGJ1ZyBhbmQgdGhlDQpzZWNvbmQgb25lIGltcHJvdmVzIHBlcmZvcm1hbmNlIGNv
bnNpZGVyYWJseSAoYW5kIHJlbW92ZXMgbW9zdCBvZiB0aGUNCm92ZXJoZWFkKS4gRnV0dXJlIGlt
cHJvdmVtZW50cyBjYW4gZ28gb24gdG9wIG9mIHRoZXNlIHBhdGNoZXMgYW5kIGFyZSBub3QNCmV4
cGVjdGVkIHRvIGNvbmZsaWN0Lg0KDQpTbyBJIHRoaW5rIHRoZXkgc2hvdWxkIGdvIHVwc3RyZWFt
IC0gdGhlIGZpcnN0IG9uZSBpbW1lZGlhdGVseSwgdGhlIHNlY29uZA0Kb25lIHdoZW4gcG9zc2li
bGUu
