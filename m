Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25CAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FB72070D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jG7iG1mL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDKTmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:42:45 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:32255 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKTmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:42:45 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf98b20000>; Fri, 12 Apr 2019 03:42:42 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 12:42:40 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 11 Apr 2019 12:42:40 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 19:42:39 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.58) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 11 Apr 2019 19:42:39 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3126.namprd12.prod.outlook.com (20.178.54.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Thu, 11 Apr 2019 19:42:35 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::a426:a072:b48b:530c]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::a426:a072:b48b:530c%5]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 19:42:35 +0000
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
Thread-Index: AQHU2eYrz7rJXhqfvEaftBWgyKLoMaYV7xUAgABPsTCAEXGWAIAPOb4AgACe6pA=
Date:   Thu, 11 Apr 2019 19:42:35 +0000
Message-ID: <BYAPR12MB3398FC694371926446B377D3C22F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFq4ZVaMmvefuVqGs84E7xg5VgvU-Ecq1MYJdmBhuEm7xA@mail.gmail.com>
 <BYAPR12MB3398F91B190D9B1C56FDC4F7C2420@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB339845B4C5A37468841E256AC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
 <CAPDyKFqwESQ9_gDxLXhzBzu236+8p6rnqricULA7GrZguVZQWQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqwESQ9_gDxLXhzBzu236+8p6rnqricULA7GrZguVZQWQ@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ef62547-4598-4ce2-6a38-08d6beb5d8f1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR12MB3126;
x-ms-traffictypediagnostic: BYAPR12MB3126:
x-microsoft-antispam-prvs: <BYAPR12MB3126B23C8DCBD2D972C3824DC22F0@BYAPR12MB3126.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(366004)(136003)(346002)(189003)(199004)(71190400001)(71200400001)(6916009)(229853002)(6436002)(54906003)(316002)(7696005)(5660300002)(99286004)(97736004)(55016002)(105586002)(106356001)(53936002)(9686003)(25786009)(66066001)(7736002)(8936002)(305945005)(74316002)(7416002)(8676002)(81166006)(81156014)(6116002)(3846002)(4326008)(6246003)(2906002)(52536014)(186003)(102836004)(26005)(446003)(478600001)(14454004)(33656002)(476003)(86362001)(68736007)(93886005)(486006)(6506007)(11346002)(76176011)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3126;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1w2n7kK4us6nLKdceL2kCZOALvRLNxLcOSjfCGFAsnYX3p4emtWvB5zCtKMLTKNEMRFS4x3A5OTql+HR96dWT02zjWfpYvJn9TLX9e1y+ZAZj9IsESChczUwFfBCHeO5wLB/Dcp6RFxsSwWOmmZ6lW2zExInEz9QAZp/bUKfjoT5N91vwLi+XKfO5MPkqg1C0zgKwU5G3MJVCCL67ImVJqmu7t1Q8gcQ9H3ypITO2y4kAivtuRV2dFCyUgiXVn+Mw0T0chMd8WrN3sE0EB4m9xqlFjLLZtEQ53fNGA3nMozQ3RlCXQWqQ9zFRoZGXiWno02/7pEYEK3t0uq8z2bRA1Vijysg55APi3zZVOuACxTWyBP84TqzgPRwcgBVxrGAi//VNke+NYrVLEpeLE7a86bqKi3389oZDW1Azd+OXN4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef62547-4598-4ce2-6a38-08d6beb5d8f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 19:42:35.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555011762; bh=STSg+0793E2B49lWm6LMsy7Rb+hHHI/ABn+tK261yP0=;
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
        b=jG7iG1mLI0/rQuv999h2GBGlH3S5TgxDcj8SaWYF+0uyguupvmvLx5n0Ncz9G+PVz
         v8tHdR/+riy2d3Q44JZKr2qWP4GKXjjzqv9GRY++yIxBBFEY8XF1K17vSANogjgMDX
         n0AGj50huXHpMIXzR5mzeLJ2HDErV/kEIXzXrYEqoACNJ34yrPqOceUHsPBWrjy1bz
         mxgw3uwuOpE2hegqLYkxvtNBrjBHAI+h7AfG0x60/V0Gc3fzg54Llox/Phknncfhyz
         N/5y3/4jjd6CeldBZElX2W3OsQxgnZCv3vT899hiz19MHOpG/B+qLGuidND/T+Mvj+
         ImpbtBe6YMAxg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNb24sIDEgQXByIDIwMTkgYXQgMTk6NDMsIFNvd2phbnlhIEtvbWF0aW5lbmkgPHNrb21h
dGluZW5pQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBEZWZh
dWx0IHRhcCBhbmQgdHJpbSB2YWx1ZXMgYXJlIGluY29ycmVjdCBmb3IgVGVncmExODYgU0RNTUM0
Lg0KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggZml4ZXMgaXQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBU
ZXN0ZWQtYnk6IEpvbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPg0KPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFNvd2phbnlhIEtvbWF0aW5lbmkgPHNrb21hdGluZW5pQG52aWRpYS5jb20+
DQo+ID4gPiA+DQo+ID4gPiA+IElzIHRoaXMgYSBmaXggYW5kL29yIGZvciBzdGFibGU/DQo+ID4g
PiA+DQo+ID4gPiA+IEluIGVpdGhlciBjYXNlLCBJIGFtIGxlYXZpbmcgdGhpcyBmb3IgYXJtLXNv
Yy4NCj4gPiA+ID4NCj4gPiA+ID4gS2luZCByZWdhcmRzDQo+ID4gPiA+IFVmZmUNCj4gPiA+ID4N
Cj4gPiA+DQo+ID4gPiBUaGFua3MgVWZmZS4gWWVzIHRoaXMgaXMgYXBwbGljYWJsZSBmb3Igc3Rh
YmxlLg0KPiA+DQo+ID4gSSBkb27igJl0IHNlZSBhbnkgY29uZmlybWF0aW9uIG9mIHRoaXMgYmVp
bmcgYXBwbGllZCBieSBhcm0tc29jLg0KPiA+IFNvIHRob3VnaHQgdG8gcmUtY2hlY2sgaWYgdGhp
cyBpcyBhcHBsaWVkPw0KPg0KPiBQZXJoYXBzIHJlcG9zdCBpdCB0byByZW1pbmQgdGhlIHNvYyBt
YWludGFpbmVyIHRvIHBpY2sgaXQgdXAuDQo+DQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo+DQoN
ClJlcG9zdGVkIHBhdGNoIDUgYW5kIDEwIGluIHRoaXMgc2VyaWVzIHRoYXQgYXJlIHdhaXRpbmcg
Zm9yIHNvYyBtYWludGFpbmVycyBhcyBmcmVzaCBpbmRpdmlkdWFsIHBhdGNoZXMuDQoNClRoYW5r
cw0KU293amFueWENCg0KPiA+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbnZpZGlhL3RlZ3JhMTg2LmR0c2kgfCA0ICsrLS0NCj4gPiA+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdyYTE4Ni5k
dHNpDQo+ID4gPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdyYTE4Ni5kdHNp
DQo+ID4gPiA+ID4gaW5kZXggOTdhZWI5NDZlZDVlLi40NzJmNTVmZTk0ODggMTAwNjQ0DQo+ID4g
PiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmExODYuZHRzaQ0KPiA+
ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMTg2LmR0c2kNCj4g
PiA+ID4gPiBAQCAtMzE3LDggKzMxNyw4IEBADQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIG52
aWRpYSxwYWQtYXV0b2NhbC1wdWxsLWRvd24tb2Zmc2V0LTF2OC10aW1lb3V0ID0gPDB4MGE+Ow0K
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICBudmlkaWEscGFkLWF1dG9jYWwtcHVsbC11cC1vZmZz
ZXQtM3YzLXRpbWVvdXQgPSA8MHgwYT47DQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIG52aWRp
YSxwYWQtYXV0b2NhbC1wdWxsLWRvd24tb2Zmc2V0LTN2My10aW1lb3V0ID0gPDB4MGE+Ow0KPiA+
ID4gPiA+IC0gICAgICAgICAgICAgICBudmlkaWEsZGVmYXVsdC10YXAgPSA8MHg1PjsNCj4gPiA+
ID4gPiAtICAgICAgICAgICAgICAgbnZpZGlhLGRlZmF1bHQtdHJpbSA9IDwweDk+Ow0KPiA+ID4g
PiA+ICsgICAgICAgICAgICAgICBudmlkaWEsZGVmYXVsdC10YXAgPSA8MHg5PjsNCj4gPiA+ID4g
PiArICAgICAgICAgICAgICAgbnZpZGlhLGRlZmF1bHQtdHJpbSA9IDwweDU+Ow0KPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICBudmlkaWEsZHFzLXRyaW0gPSA8NjM+Ow0KPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICBtbWMtaHM0MDAtMV84djsNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDIuNy40DQo+ID4gPiA+
ID4NCg==
