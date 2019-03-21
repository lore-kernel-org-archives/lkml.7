Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D309C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1A3218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bIi5uLHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfCUPW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:22:58 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:37186 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCUPW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:22:57 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c93ac4e0000>; Thu, 21 Mar 2019 23:22:54 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 Mar 2019 08:22:52 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 21 Mar 2019 08:22:52 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Mar
 2019 15:22:51 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.53) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 21 Mar 2019 15:22:51 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3045.namprd12.prod.outlook.com (20.178.53.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 15:22:48 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 15:22:48 +0000
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
Thread-Index: AQHU2eYrz7rJXhqfvEaftBWgyKLoMaYV7xUAgABPsTA=
Date:   Thu, 21 Mar 2019 15:22:47 +0000
Message-ID: <BYAPR12MB3398F91B190D9B1C56FDC4F7C2420@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFq4ZVaMmvefuVqGs84E7xg5VgvU-Ecq1MYJdmBhuEm7xA@mail.gmail.com>
In-Reply-To: <CAPDyKFq4ZVaMmvefuVqGs84E7xg5VgvU-Ecq1MYJdmBhuEm7xA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30ce3cb6-48fd-40aa-6187-08d6ae111359
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3045;
x-ms-traffictypediagnostic: BYAPR12MB3045:
x-microsoft-antispam-prvs: <BYAPR12MB3045501067AAF8634AB04E49C2420@BYAPR12MB3045.namprd12.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(256004)(6246003)(106356001)(105586002)(33656002)(6506007)(97736004)(486006)(7736002)(14444005)(74316002)(54906003)(25786009)(14454004)(66066001)(26005)(11346002)(476003)(7416002)(446003)(102836004)(305945005)(3846002)(99286004)(478600001)(186003)(6916009)(6116002)(68736007)(8936002)(52536014)(55016002)(9686003)(7696005)(6436002)(2906002)(4326008)(316002)(76176011)(86362001)(229853002)(81166006)(53936002)(81156014)(71190400001)(71200400001)(5660300002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3045;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mW+wr4ggZT2b9AHE+YAn49t3bpMD86xEncP1PolL3lr5qVUiFDRIHPuGF754uYY9OljuBMhKS0ZPpckwEG4OnjeupscDgd+e64YLyco8owqIWM/easQxYTMlFyUjiTb8zr/zvPngoxLQxseWtHh/4xABPbGxRXATSN/UJ7Yc0W1fP6vSE2oCb58bmnyVo/jJk5J8d8sbqmM+xRGALgLLEzSVuCg2pDWfYXvKIZ57B/lNmhoylvTb69gZvnBTzwiDopA9GMKXXha/zeSl+jn4D4uVyJ2NbRqfGyMU+WeQDjDbItBhQ7WYJwl/IeuD2DNxrXNOqPHdkTP7U8UJHYE89za90Y1YkfFuxe8YE5YSf/KrpDDRAILuFABRSYxKgHOe7PmpSn2Zmed377AzyNm1CKZxUYVwjqW1oMQecsuiGmM=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ce3cb6-48fd-40aa-6187-08d6ae111359
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 15:22:47.9313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3045
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553181774; bh=nkjl/UzrtRji24PDPf7kIyoIZEqdkAK+xv1e2uWB/qw=;
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
        b=bIi5uLHu79J2ZDnn3D/WrMsRkeKeyuwTJ1iPU8uFVlyysBhUtbvDOy+9wymrght6y
         yT5V/vY5QHcloTuS2optYbv7UiJeWORvyuyocDQKZd553Rbgc9FYfWzV1T1fsplvih
         S6Bnq9Bdi6Qv9aNHUMxRwnttiPpx9m55hgaEMm2K9mFud6JXBWMbPuBt3uRZ+6xu2B
         QVc36rHl7TvdGjiDDTKhTYYFLPd+eOwFCHwqj4zJkHu08tzog3H1MxT0c/nudiSxx8
         1AbkGQ7uWh/DJsvB8we2gIU0Lq+iCkyAbsr6EkHG0ZRCONbtGxIeInUMlVFquqDvcB
         tuPS1ohkwFTzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gRGVmYXVsdCB0YXAgYW5kIHRyaW0gdmFsdWVzIGFyZSBpbmNvcnJlY3QgZm9yIFRl
Z3JhMTg2IFNETU1DNC4NCj4gPiBUaGlzIHBhdGNoIGZpeGVzIGl0Lg0KPiA+DQo+ID4gVGVzdGVk
LWJ5OiBKb24gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTb3dqYW55YSBLb21hdGluZW5pIDxza29tYXRpbmVuaUBudmlkaWEuY29tPg0KPg0KPiBJcyB0
aGlzIGEgZml4IGFuZC9vciBmb3Igc3RhYmxlPw0KPg0KPiBJbiBlaXRoZXIgY2FzZSwgSSBhbSBs
ZWF2aW5nIHRoaXMgZm9yIGFybS1zb2MuDQo+DQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo+DQoN
ClRoYW5rcyBVZmZlLiBZZXMgdGhpcyBpcyBhcHBsaWNhYmxlIGZvciBzdGFibGUuDQoNCj4gPiAt
LS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmExODYuZHRzaSB8IDQgKyst
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMTg2
LmR0c2kgDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdyYTE4Ni5kdHNpDQo+
ID4gaW5kZXggOTdhZWI5NDZlZDVlLi40NzJmNTVmZTk0ODggMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmExODYuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMTg2LmR0c2kNCj4gPiBAQCAtMzE3LDggKzMxNyw4IEBA
DQo+ID4gICAgICAgICAgICAgICAgIG52aWRpYSxwYWQtYXV0b2NhbC1wdWxsLWRvd24tb2Zmc2V0
LTF2OC10aW1lb3V0ID0gPDB4MGE+Ow0KPiA+ICAgICAgICAgICAgICAgICBudmlkaWEscGFkLWF1
dG9jYWwtcHVsbC11cC1vZmZzZXQtM3YzLXRpbWVvdXQgPSA8MHgwYT47DQo+ID4gICAgICAgICAg
ICAgICAgIG52aWRpYSxwYWQtYXV0b2NhbC1wdWxsLWRvd24tb2Zmc2V0LTN2My10aW1lb3V0ID0g
PDB4MGE+Ow0KPiA+IC0gICAgICAgICAgICAgICBudmlkaWEsZGVmYXVsdC10YXAgPSA8MHg1PjsN
Cj4gPiAtICAgICAgICAgICAgICAgbnZpZGlhLGRlZmF1bHQtdHJpbSA9IDwweDk+Ow0KPiA+ICsg
ICAgICAgICAgICAgICBudmlkaWEsZGVmYXVsdC10YXAgPSA8MHg5PjsNCj4gPiArICAgICAgICAg
ICAgICAgbnZpZGlhLGRlZmF1bHQtdHJpbSA9IDwweDU+Ow0KPiA+ICAgICAgICAgICAgICAgICBu
dmlkaWEsZHFzLXRyaW0gPSA8NjM+Ow0KPiA+ICAgICAgICAgICAgICAgICBtbWMtaHM0MDAtMV84
djsNCj4gPiAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAtLQ0KPiA+
IDIuNy40DQo+ID4NCg==
