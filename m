Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EB220830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D9OaVzZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfDARnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:43:19 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:9841 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730448AbfDARnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:43:08 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca24da60005>; Tue, 02 Apr 2019 01:43:02 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 01 Apr 2019 10:43:02 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 01 Apr 2019 10:43:02 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Apr
 2019 17:43:02 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.52) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 1 Apr 2019 17:43:02 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2984.namprd12.prod.outlook.com (20.178.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Mon, 1 Apr 2019 17:42:59 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 17:42:59 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 05/10] arm64: tegra: fix default tap and trim values
Thread-Topic: [PATCH V3 05/10] arm64: tegra: fix default tap and trim values
Thread-Index: AQHU2eYrz7rJXhqfvEaftBWgyKLoMaYV7xUAgABPsTCAEXGWAA==
Date:   Mon, 1 Apr 2019 17:42:58 +0000
Message-ID: <BYAPR12MB339845B4C5A37468841E256AC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFq4ZVaMmvefuVqGs84E7xg5VgvU-Ecq1MYJdmBhuEm7xA@mail.gmail.com>
 <BYAPR12MB3398F91B190D9B1C56FDC4F7C2420@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3398F91B190D9B1C56FDC4F7C2420@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4554f72-5208-45bc-ed70-08d6b6c97b2e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB2984;
x-ms-traffictypediagnostic: BYAPR12MB2984:
x-microsoft-antispam-prvs: <BYAPR12MB29845304A11A830E47E77EF0C2550@BYAPR12MB2984.namprd12.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(9686003)(186003)(256004)(26005)(6116002)(6506007)(316002)(229853002)(53936002)(6436002)(25786009)(54906003)(3846002)(76176011)(476003)(74316002)(97736004)(71200400001)(11346002)(446003)(486006)(55016002)(102836004)(14444005)(106356001)(66066001)(105586002)(4326008)(6246003)(68736007)(81166006)(305945005)(8936002)(93886005)(7416002)(6916009)(71190400001)(99286004)(2906002)(52536014)(81156014)(8676002)(7696005)(5660300002)(14454004)(478600001)(7736002)(33656002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2984;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TM48CKAkw2ovRz/02rJYc9vJr1K+5xvCD6PPSBDuV0Injo/j+TQdzPva1MZNMKS3DXfanmhF92EzRvlGJUbKP7d8Tpg3pHXGr7Hfw91Ax2nI8hWpqLc0tgwGPHJoO3861TcR5XQ3JfhyMs/Q8IQbLEZlwKG5DSD8HQnWo66sMLqP7dupPWqOqY1SfNGeLJ+Mc0auZePUdKG4FoeUTgtH2La2qHniZTSXK8QS2bIzHsz5jJE7X2hslyxVeTE19PQ1KwhfKOx1TKLXJ0liLB3O+39ZyzYNlwknUNIZXual+/IfFtdbeqcaV+NUlxZ7rzBE9C/EJ3gMo+ITVd8nbRtljfg+7a9mms5KqQ/BySN6cRxB4ckCYPwpcifGpRQlap/zxRuLwjoV5E2VnZkOriWpxZJ2P/Ae35L3o+enlgGpPWI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f4554f72-5208-45bc-ed70-08d6b6c97b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 17:42:58.9047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2984
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554140583; bh=EXafO2Zjfby5HHtUNu4oeaHAol1htohIMPQAQq2/ges=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=D9OaVzZtgqGgVUgxFnA3WyYCnaghKCA8+JZ4TBFzFtYpDW9wENl/HGWJ2DEQvMIvs
         FOQS3QUFjtrK9ni4uxJzccTedmvkeBQd/mnkfG2wZFKQHDZJZCnGr6qnorJyqQEc4F
         mfy6SA/mMCZVvY+gdjhMAL0o8aRMsoeIstJfw8mnTl7Rickpl2OTQjKdnmyux3e0FK
         Qf9f8xsR5ZYisSweGu4lPccjNSg4OF7rhb2j4nj8eiBBLhix5/fBe1c01QB/Q4+OwW
         jTUcpg2VJsHXVNaMysi/GdfZGx8AJhlVewrA7Zss1kzFQEYiUBUkVMv+VytmOgJDeg
         +6E5RjujW9lDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4NCj4gPiA+IERlZmF1bHQgdGFwIGFuZCB0cmltIHZhbHVlcyBhcmUgaW5jb3JyZWN0IGZv
ciBUZWdyYTE4NiBTRE1NQzQuDQo+ID4gPiBUaGlzIHBhdGNoIGZpeGVzIGl0Lg0KPiA+ID4NCj4g
PiA+IFRlc3RlZC1ieTogSm9uIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBTb3dqYW55YSBLb21hdGluZW5pIDxza29tYXRpbmVuaUBudmlkaWEuY29t
Pg0KPiA+DQo+ID4gSXMgdGhpcyBhIGZpeCBhbmQvb3IgZm9yIHN0YWJsZT8NCj4gPg0KPiA+IElu
IGVpdGhlciBjYXNlLCBJIGFtIGxlYXZpbmcgdGhpcyBmb3IgYXJtLXNvYy4NCj4gPg0KPiA+IEtp
bmQgcmVnYXJkcw0KPiA+IFVmZmUNCj4gPg0KPg0KPiBUaGFua3MgVWZmZS4gWWVzIHRoaXMgaXMg
YXBwbGljYWJsZSBmb3Igc3RhYmxlLg0KDQpJIGRvbuKAmXQgc2VlIGFueSBjb25maXJtYXRpb24g
b2YgdGhpcyBiZWluZyBhcHBsaWVkIGJ5IGFybS1zb2MuDQpTbyB0aG91Z2h0IHRvIHJlLWNoZWNr
IGlmIHRoaXMgaXMgYXBwbGllZD8NCg0KPiA+ID4gLS0tDQo+ID4gPiAgYXJjaC9hcm02NC9ib290
L2R0cy9udmlkaWEvdGVncmExODYuZHRzaSB8IDQgKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMTg2LmR0c2kgDQo+ID4gPiBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMTg2LmR0c2kNCj4gPiA+IGluZGV4IDk3YWVi
OTQ2ZWQ1ZS4uNDcyZjU1ZmU5NDg4IDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9udmlkaWEvdGVncmExODYuZHRzaQ0KPiA+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9udmlkaWEvdGVncmExODYuZHRzaQ0KPiA+ID4gQEAgLTMxNyw4ICszMTcsOCBAQA0KPiA+ID4g
ICAgICAgICAgICAgICAgIG52aWRpYSxwYWQtYXV0b2NhbC1wdWxsLWRvd24tb2Zmc2V0LTF2OC10
aW1lb3V0ID0gPDB4MGE+Ow0KPiA+ID4gICAgICAgICAgICAgICAgIG52aWRpYSxwYWQtYXV0b2Nh
bC1wdWxsLXVwLW9mZnNldC0zdjMtdGltZW91dCA9IDwweDBhPjsNCj4gPiA+ICAgICAgICAgICAg
ICAgICBudmlkaWEscGFkLWF1dG9jYWwtcHVsbC1kb3duLW9mZnNldC0zdjMtdGltZW91dCA9IDww
eDBhPjsNCj4gPiA+IC0gICAgICAgICAgICAgICBudmlkaWEsZGVmYXVsdC10YXAgPSA8MHg1PjsN
Cj4gPiA+IC0gICAgICAgICAgICAgICBudmlkaWEsZGVmYXVsdC10cmltID0gPDB4OT47DQo+ID4g
PiArICAgICAgICAgICAgICAgbnZpZGlhLGRlZmF1bHQtdGFwID0gPDB4OT47DQo+ID4gPiArICAg
ICAgICAgICAgICAgbnZpZGlhLGRlZmF1bHQtdHJpbSA9IDwweDU+Ow0KPiA+ID4gICAgICAgICAg
ICAgICAgIG52aWRpYSxkcXMtdHJpbSA9IDw2Mz47DQo+ID4gPiAgICAgICAgICAgICAgICAgbW1j
LWhzNDAwLTFfOHY7DQo+ID4gPiAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gPiA+IC0tDQo+ID4gPiAyLjcuNA0KPiA+ID4NCg==
