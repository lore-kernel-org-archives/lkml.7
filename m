Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDECFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA6F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DOVbod45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCMPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:48:05 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4398 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:48:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c8926310000>; Wed, 13 Mar 2019 08:48:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 08:48:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Mar 2019 08:48:02 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 15:48:01 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.59) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 13 Mar 2019 15:48:01 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2646.namprd12.prod.outlook.com (20.176.255.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Wed, 13 Mar 2019 15:47:58 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1709.011; Wed, 13 Mar 2019
 15:47:58 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Asutosh Das <asutoshd@codeaurora.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD
 CMD_TIMING
Thread-Topic: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD
 CMD_TIMING
Thread-Index: AQHU0Le8XNfDXr1Gi0eUvv60djK956X+l9EAgADl9YCAAP/PoIAIapiAgAB8loCAAGCTQA==
Date:   Wed, 13 Mar 2019 15:47:58 +0000
Message-ID: <BYAPR12MB33981C39074E4233461FBD2AC24A0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-7-git-send-email-skomatineni@nvidia.com>
 <a320c841-7e58-4d3e-5df6-61e10520d9d8@intel.com>
 <a544bc6d-7b23-53e8-16d0-ee0eaf576eb2@codeaurora.org>
 <BYAPR12MB33984D80A404EF919F3A86A0C24C0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <05a6e500-9dc9-1984-9576-44b3a9fdc595@codeaurora.org>
 <363DA0ED52042842948283D2FC38E4649C48E59C@IRSMSX106.ger.corp.intel.com>
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C48E59C@IRSMSX106.ger.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cafc29d7-b0bd-48d3-d0dd-08d6a7cb4462
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2646;
x-ms-traffictypediagnostic: BYAPR12MB2646:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjQ2OzIzOmtWaythYXNuc2pnK2lvUzkvU21aK3FBWlpS?=
 =?utf-8?B?am1wL1RXRnFsNHY5N1FIWGREdUU3THhPNXcxSDBKOTdKSSsrU1lRTXBvQUhV?=
 =?utf-8?B?OVorMjR0SnNmLzduSDY1Y0ZsN2JKM3YzWDUvWkJ0N3JYdFhvbnVyY2o3L2Ir?=
 =?utf-8?B?RjdiRnR0Y1ZIK3kwOHoyWWJnTVhVcUEzMTVNZm9uaEdBZFgxbVZXMW00Tkli?=
 =?utf-8?B?ZjBvSmEwYmt5dWhFQk9OS0xLYnJjdW1hV1VyZ0ppZDJySzJBRGxDWHlvWFM0?=
 =?utf-8?B?QlBOMTE3OSt0OGlxcUU5cVJtS2dzRmxxdkQzRkpNTWZwa0JPOXh6enNUTmtS?=
 =?utf-8?B?ajBONUxMMlBrWXdneDNOMjFrMjhSNzhsaTNxV3Vjd2JQU2gwU3BzK2dQeEhu?=
 =?utf-8?B?WTVwb3d0eWNsbG8rRVA4OFI0ZWFhd3AvSzViS0pwUlNIeDF5dVA2VURtQUY2?=
 =?utf-8?B?UVZYZW9tMFFzMjNGZ3BYYzBUTWtYN25IREQwVlFWOVhSWVdJeThqa3I3cWVL?=
 =?utf-8?B?QzBzaEtib05hYnV0TGNUQjRDQ2ljaTdyTVMrc0Z5T0pMNmFIOEZCcXRTYkww?=
 =?utf-8?B?TzBDdXg3dlIrUzBNSjdEUENDbTRUS2UzUGtQcklpRndmTG53QVVlWEZSNGlH?=
 =?utf-8?B?K3hDeDkzS0hyVi84Tm94SUlGd21YRy81dFlvQVBnbU1xRmozOThjUlZoV3F2?=
 =?utf-8?B?MXdXRk1NSFlWRlVrYWh0SzVLaFE5T3RRYk1DWjZJL1NZZzd4b3lmS3hqSHdX?=
 =?utf-8?B?VkpTYVV0MFFQT0lNWWpYQmpWT2VRMzlSK0xPSHdGeDhmZjBhMTJyR1JzaGc0?=
 =?utf-8?B?NmFyTHBCVHNXYkVJdEI5RG1lQlVmTlZJRi90MmVSOHAwSCs2S3ZEc2RMOGJv?=
 =?utf-8?B?eGtySjk2eUtUWFR0Y01udzJuVldpZFRBY3FDSWNleUNHcHE1YXdWL1ZnS3hH?=
 =?utf-8?B?S1A0T0o2eTFPb1l0WUVpVmV0K09EeTFHaEkrWVE3K2o4RTVTL2lyR0h5RTRt?=
 =?utf-8?B?SG5tMFI1eVBIaGJkL2E4bEJWcXMrcUVQaUhWOHZqQ2dZa0JUbzFDVk00bDFH?=
 =?utf-8?B?R0grWnltRzdoVWxnbDlJc3Z2NGdzNXFXVmtreDJQOVZXNW1WYVlzVlJ5MCtF?=
 =?utf-8?B?WlJBc1ZEN3pYZ3ZVL0Q1czU2dGdiQ25JZTR4OHhQN3ZQNnBXOW1hNFBiSVRT?=
 =?utf-8?B?bFhYV2p2WERSd2lYK3RlTTh1K2JnY0VIaDRkbVY2SGZIMFJHY0loeGY0Q1RC?=
 =?utf-8?B?WkNqeC9jSWZiVTZpY0NIazRsQ08yaE11bmZJeEVtS0ZyUGt4WGJNV1p4M1ZI?=
 =?utf-8?B?NVh3bmx3MkZUWFM5T3JzaERLSjg0T1Y2dEVhZ3FucGg4MlhHQTVwcmtva2Za?=
 =?utf-8?B?YzhXQThxUG83Z2l0NHBlK1hVanJhRHExbXFzUEl6WVV3OWZkSmcySUxXRy9i?=
 =?utf-8?B?c1ZuTWQ0bithdU5vcm1lR0ZEY0lOU0FjL2xQdDZWYkdnNHFyYngrNEtDTGQ4?=
 =?utf-8?B?aGlPelFNZDJzNVB0ejJuT1RUSS80ZzNXWlpKaUJvTTAvMmdYbmhPZ0Uxcmwx?=
 =?utf-8?B?bXRnUnFFVDZsUjBMUi9PRnNuNnQrdytwL0VYN1loUmNERGZCMWtaV0dnUHlt?=
 =?utf-8?B?TW1XNGlRMnNwalRRczZJRVZXTEFLai8rMHRla2tiM0NiajhmM2gzSEM5NDd0?=
 =?utf-8?B?UTNDaVJhMW12L0luTEM5NnJUeDNsd2FqSWpUVG82NmhsallRZGNaSmZ4UUJp?=
 =?utf-8?B?Z3IvL25MVXRBMGh6UEFVM3BuVU13QWplSy9qK283RExRQU0xNUhkeWIxZDJH?=
 =?utf-8?B?VGFUYlFEWXJtRWpQWkVaQmhmdjZmKytueXFVeHRIaUJiNEE9PQ==?=
x-microsoft-antispam-prvs: <BYAPR12MB26460F6C7F53D572F8DAFBE2C24A0@BYAPR12MB2646.namprd12.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(376002)(39860400002)(13464003)(189003)(199004)(66066001)(6116002)(486006)(476003)(11346002)(446003)(8936002)(229853002)(3846002)(106356001)(33656002)(55016002)(105586002)(93886005)(316002)(6436002)(97736004)(7416002)(9686003)(102836004)(6346003)(26005)(6506007)(54906003)(110136005)(76176011)(81166006)(2501003)(53936002)(8676002)(81156014)(53546011)(74316002)(99286004)(7736002)(305945005)(25786009)(6246003)(4326008)(7696005)(71190400001)(5660300002)(68736007)(52536013)(71200400001)(14454004)(86362001)(14444005)(2906002)(478600001)(256004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2646;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rrkgx7VmV1ieoMztq3SN8t2uRIrXuF0Kvo0hzoLXYCW0kRF6g15d8BXIeePpjO6mctx1VVToDA4NZzpt/BbW9tOygabzlBG0VcB5jrN+6Y+v8ZaYouuERK8PXfYFRIvO1DXUMsPHyiwCIpRgtjrmp0+zHWfUAht62LBow37DpGIRBN1dkblNWuWHrzp0DyLdhGXrX1d2GpkmZbCG8tlzM7CFdHpzx9ZURM1eM0e6lV06PdctZQQLcHK0WTWEt78YGfT2EdE387OA7aHHRyE7/0Wh1z7o/y7exXS6g0gq7hRBL62Qmb8sy/bLRDGLbL8ItH+QzWN+5nN5RIF0hNvJVGXboxOUUTMOWnmOi7Ixd4Oj3bgVT7x75YkfyEr4N5ua7KAhJKHguiY60mI7FOK6O9Bh9y0yRjTV9YONYL23MCs=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cafc29d7-b0bd-48d3-d0dd-08d6a7cb4462
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 15:47:58.5539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2646
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552492081; bh=ETRo/BWkgLbZxniTkrDui8ZNkAK5cJqqlT8EE3/3Gqw=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-exchange-diagnostics:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:authentication-results:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=DOVbod45Id7efOzn627I3bxQqqEym8fqNTtKJM9fh6yKjeK4fUP/aavLAK723SvGL
         uYjQOw5kYfs8w1TDZ9NCzR6O9CNPO0JEjDLyNLfCSTPRe3kGLmFShgBr7BThQTiN28
         klOpi90rxpxPzqkQL5NWIInGme8IjGY0Q3PidpZz/bUcRKlekiasGf3QTvehDl6FOz
         fQrm7LHuSUkCAAaL2X9UVF7gIoMowB7LID56/tSQQOziUJZv1zk5mjx9sjPxLFTfOP
         WvyJVBL4QQ7J6bmQgohxGHBVFdmyGRKkAXaO72QatGGj6mLf3uF1Of7wn/iWQ6/grv
         i1COhZ3EvrX4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSHVudGVyLCBBZHJpYW4g
PGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPiANCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxMywg
MjAxOSAyOjU3IEFNDQo+IFRvOiBSaXRlc2ggSGFyamFuaSA8cml0ZXNoaEBjb2RlYXVyb3JhLm9y
Zz47IFNvd2phbnlhIEtvbWF0aW5lbmkgPHNrb21hdGluZW5pQG52aWRpYS5jb20+OyB1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29t
OyBBc3V0b3NoIERhcyA8YXN1dG9zaGRAY29kZWF1cm9yYS5vcmc+DQo+IENjOiB0aGllcnJ5LnJl
ZGluZ0BnbWFpbC5jb207IEpvbmF0aGFuIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+OyBB
bmlydWRkaGEgVHZzIFJhbyA8YW5yYW9AbnZpZGlhLmNvbT47IGxpbnV4LXRlZ3JhQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1jQHZnZXIua2Vy
bmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRD
SCBWMSAwNy8xMV0gbW1jOiBjcWhjaTogYWRkIHF1aXJrIGZvciBzZXR0aW5nIERDTUQgQ01EX1RJ
TUlORw0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogUml0ZXNo
IEhhcmphbmkgW21haWx0bzpyaXRlc2hoQGNvZGVhdXJvcmEub3JnXQ0KPiA+IFNlbnQ6IFdlZG5l
c2RheSwgTWFyY2ggMTMsIDIwMTkgNDozMSBBTQ0KPiA+IFRvOiBTb3dqYW55YSBLb21hdGluZW5p
IDxza29tYXRpbmVuaUBudmlkaWEuY29tPjsgSHVudGVyLCBBZHJpYW4gDQo+ID4gPGFkcmlhbi5o
dW50ZXJAaW50ZWwuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgcm9iaCtkdEBrZXJuZWwu
b3JnOyANCj4gPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgQXN1dG9zaCBEYXMgPGFzdXRvc2hkQGNv
ZGVhdXJvcmEub3JnPg0KPiA+IENjOiB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IEpvbmF0aGFu
IEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+OyANCj4gPiBBbmlydWRkaGEgVHZzIFJhbyA8
YW5yYW9AbnZpZGlhLmNvbT47IGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZzsgDQo+ID4gbGlu
dXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IA0K
PiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBW
MSAwNy8xMV0gbW1jOiBjcWhjaTogYWRkIHF1aXJrIGZvciBzZXR0aW5nIERDTUQgDQo+ID4gQ01E
X1RJTUlORw0KPiA+IA0KPiA+IA0KPiA+IE9uIDMvNy8yMDE5IDExOjQ2IFBNLCBTb3dqYW55YSBL
b21hdGluZW5pIHdyb3RlOg0KPiA+ID4+IE9uIDMvNi8yMDE5IDY6MzAgUE0sIEFkcmlhbiBIdW50
ZXIgd3JvdGU6DQo+ID4gPj4+IE9uIDIvMDMvMTkgNzoyMCBBTSwgU293amFueWEgS29tYXRpbmVu
aSB3cm90ZToNCj4gPiA+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIHF1aXJrIGZvciBzZXR0aW5nIENN
RF9USU1JTkcgdG8gMSBpbiBkZXNjcmlwdG9yIA0KPiA+ID4+Pj4gZm9yIERDTUQgd2l0aCBSMUIg
cmVzcG9uc2UgdHlwZSB0byBhbGxvdyB0aGUgY29tbWFuZCB0byBiZSBzZW50IA0KPiA+ID4+Pj4g
dG8gZGV2aWNlIGR1cmluZyBkYXRhIGFjdGl2aXR5IG9yIGJ1c3kgdGltZS4NCj4gPiA+Pj4+DQo+
ID4gPj4+PiBUZWdyYTE4NiBDUUhDSSBob3N0IGhhcyBidWcgd2hlcmUgaXQgc2VsZWN0cyBEQVRB
X1BSRVNFTlRfU0VMRUNUDQo+ID4gdG8NCj4gPiA+Pj4+IDEgYnkgQ1FIQ0kgY29udHJvbGxlciBm
b3IgRENNRHMgd2l0aCBSMUIgcmVzcG9uc2UgdHlwZSBhbmQgc2luY2UgDQo+ID4gPj4+PiBEQ01E
IGRvZXMgbm90IHRyaWdnZXIgYW55IGRhdGEgdHJhbnNmZXIsIERDTUQgdGFzayBjb21wbGV0ZQ0K
PiA+IGhhcHBlbnMNCj4gPiA+Pj4+IGxlYXZpbmcgdGhlIERBVEEgRlNNIG9mIGhvc3QgY29udHJv
bGxlciBpbiB3YWl0IHN0YXRlIGZvciBkYXRhLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFRoaXMgZWZm
ZWN0cyB0aGUgZGF0YSB0cmFuc2ZlciB0YXNrIGlzc3VlZCBhZnRlciBSMUIgRENNRCB0YXNrIA0K
PiA+ID4+Pj4gYW5kIG5vIGludGVycnVwdCBpcyBnZW5lcmF0ZWQgZm9yIHRoZSBkYXRhIHRyYW5z
ZmVyIHRhc2suDQo+ID4gPj4+Pg0KPiA+ID4+Pj4gU1cgV0FSIGZvciB0aGlzIGlzc3VlIGlzIHRv
IHNldCBDTURfVElNSU5HIGJpdCB0byAxIGluIERDTUQgdGFzayANCj4gPiA+Pj4+IGRlc2NyaXB0
b3IgYW5kIGFzIERDTUQgdGFzayBkZXNjcmlwdG9yIHByZXBhcmF0aW9uIGlzIGRvbmUgYnkgDQo+
ID4gPj4+PiBjcWhjaSBkcml2ZXIsIHRoaXMgcGF0Y2ggYWRkcyBjcWVxdWlyayB0byBoYW5kbGUg
dGhpcy4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBTb3dqYW55YSBLb21hdGlu
ZW5pIDxza29tYXRpbmVuaUBudmlkaWEuY29tPg0KPiA+ID4+Pj4gLS0tDQo+ID4gPj4+PiAgICBk
cml2ZXJzL21tYy9ob3N0L2NxaGNpLmMgfCA1ICsrKystDQo+ID4gPj4+PiAgICBkcml2ZXJzL21t
Yy9ob3N0L2NxaGNpLmggfCAxICsNCj4gPiA+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPj4+Pg0KPiA+ID4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuYyANCj4g
PiA+Pj4+IGluZGV4IGE4YWY2ODJhOTE4Mi4uYjM0YzA3MTI1ZjMyIDEwMDY0NA0KPiA+ID4+Pj4g
LS0tIGEvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5jDQo+ID4gPj4+PiArKysgYi9kcml2ZXJzL21t
Yy9ob3N0L2NxaGNpLmMNCj4gPiA+Pj4+IEBAIC01MjEsNyArNTIxLDEwIEBAIHN0YXRpYyB2b2lk
IGNxaGNpX3ByZXBfZGNtZF9kZXNjKHN0cnVjdA0KPiA+IG1tY19ob3N0ICptbWMsDQo+ID4gPj4+
PiAgICAJfSBlbHNlIHsNCj4gPiA+Pj4+ICAgIAkJaWYgKG1ycS0+Y21kLT5mbGFncyAmIE1NQ19S
U1BfUjFCKSB7DQo+ID4gPj4+PiAgICAJCQlyZXNwX3R5cGUgPSAweDM7DQo+ID4gPj4+PiAtCQkJ
dGltaW5nID0gMHgwOw0KPiA+ID4+Pj4gKwkJCWlmIChjcV9ob3N0LT5xdWlya3MgJg0KPiA+IENR
SENJX1FVSVJLX0NNRF9USU1JTkdfUjFCX0RDTUQpDQo+ID4gPj4+PiArCQkJCXRpbWluZyA9IDB4
MTsNCj4gPiA+Pj4+ICsJCQllbHNlDQo+ID4gPj4+PiArCQkJCXRpbWluZyA9IDB4MDsNCj4gPiA+
Pj4gSSB3YXMgdGhpbmtpbmcgaXQgd291bGQgYmUgbmljZSBpZiB0aGVyZSB3YXMgYSBnZW5lcmlj
IHdheSBmb3IgDQo+ID4gPj4+IGRyaXZlcnMgdG8gbWFrZSBjaGFuZ2VzIHRvIGRlc2NyaXB0b3Jz
IGJlZm9yZSBhIHRhc2sgaXMgc3RhcnRlZC4NCj4gPiA+Pj4gQ3VycmVudGx5IHRoZXJlIGlzDQo+
ID4gPj4+IGhvc3QtPm9wcy0+d3JpdGVfbCgpIHdoaWNoIHdvdWxkIG1ha2UgaXQgcG9zc2libGUg
YnkgY2hlY2tpbmcgZm9yIA0KPiA+ID4+PiBob3N0LT5vcHMtPkNRSENJX1REQlINCj4gPiA+Pj4g
cmVnaXN0ZXIgYW5kLCBpbiB0aGlzIGNhc2UsIHRoZSBEQ01EIHRhZy4gIFdlIHdvdWxkIG5lZWQg
dG8gZXhwb3J0IA0KPiA+ID4+PiBnZXRfZGVzYygpLCBwZXJoYXBzIHJlbmFtZSBpdCBjcWhjaV9n
ZXRfZGVzYygpIGFuZCBwdXQgaXQgaW4gDQo+ID4gPj4+IGNxaGNpLmggc2luY2UgaXQgaXMgYW4g
aW5saW5lIGZ1bmN0aW9uLg0KPiA+ID4+IFdlIHRha2Ugc3Bpbl9sb2NrX2lycXNhdmUgYWZ0ZXIg
dGhlIGRlc2NyaXB0b3IgaXMgcHJlcGFyZWQgYW5kIA0KPiA+ID4+IGJlZm9yZQ0KPiA+IHdyaXRp
bmcgdG8gVERCUi4NCj4gPiA+PiBOb3Qgc3VyZSBidXQgdG9tb3Jyb3cgdGhpcyBtYXkgYmVjb21l
IGEgbGltaXRhdGlvbiBmb3IgZHJpdmVycyB0byANCj4gPiA+PiBtYWtlDQo+ID4gY2hhbmdlcyB0
byBkZXNjcmlwdG9ycyBpZiB0aGV5IGVkaXQgZGVzY3JpcHRvcnMgaW4gaG9zdC0+b3BzLT53cml0
ZV9sKCkgY2FsbC4NCj4gPiA+PiBUaG91Z2ggaW4gdGhpcyBjYXNlIGl0IGlzIG5vdCByZXF1aXJl
ZCBoZXJlLg0KPiA+ID4+DQo+ID4gPj4+IEFsdGVybmF0aXZlbHkgd2UgY291bGQgYWRkIGhvc3Qt
Pm9wcyBmb3IgZGVzY3JpcHRvciBwcmVwYXJhdGlvbi4NCj4gPiA+PiBCb3RoIHdheXMgc291bmRz
IGdvb2QgdG8gbWUuDQo+ID4gPj4gQnV0IG1heWJlIGFkZGluZyBhIGhvc3QtPm9wcyBmb3IgZGVz
Y3JpcHRvciBwcmVwYXJhdGlvbiBpcyBiZXR0ZXIgDQo+ID4gPj4gd2F5IHRvIGdvLCBzaW5jZSB0
aGF0IHdpbGwgYmUgdGhlIHJpZ2h0IGludGVyZmFjZSBleHBvc2VkIHRvIG1ha2UgDQo+ID4gPj4g
Y2hhbmdlcyB0byBkZXNjcmlwdG9ycy4NCj4gPiA+Pg0KPiA+ID4gRENNRCBkZXNjcmlwdG9yIGF0
dHJpYnV0ZXMgcmVtYWluIHNhbWUgZm9yIGFueSBob3N0IGFuZCBhbHNvIHRhc2sNCj4gPiBwYXJh
bWV0ZXJzIGFzIFFCUiBuZWVkIHRvIGJlIGVuYWJsZWQgd2l0aCBEQ01ELg0KPiA+ID4gU28gSSBi
ZWxpZXZlIGl0IHNob3VsZCBiZSBvayBpZiB3ZSBqdXN0IGFkZCBjYWxsYmFjayB0byBhbGxvdyBo
b3N0cyANCj4gPiA+IHRvIHVwZGF0ZQ0KPiA+IGNvbW1hbmQgcGFyYW1ldGVycyBvZiBEQ01EIGRl
c2NyaXB0b3Igb25seSB0aHJ1IGNxaGNpX2hvc3Rfb3BzLg0KPiA+IA0KPiA+IEZvciBub3cgd2Ug
Y2FuIGFkZCBob3N0LT5vcHMgYXMgdXBkYXRlX2RjbWRfZGVzYyBhbmQgcGFzcyB0aGUgDQo+ID4g
dGFza19kZXNjIG9mIERDTUQgZm9yIHVwZGF0aW5nIGFueSBwYXJhbXMgd2hpY2ggaG9zdCBtYXkg
d2FudCB0byB1cGRhdGUuDQo+ID4gDQo+ID4gPg0KPiA+ID4gQWxzbywgZG9u4oCZdCBzZWUgYW55
IHJlcXVpcmVtZW50IGZvciBob3N0IHNwZWNpZmljIFRhc2sgcGFyYW1ldGVyIA0KPiA+ID4gdXBk
YXRlcw0KPiA+IGluIFRhc2sgZGVzY3JpcHRvciBzbyBub3Qgc3VyZSBpZiB0aGVyZSBpcyBhbnkg
bmVlZCB0byBwcm92aWRlIA0KPiA+IGNhbGxiYWNrIGZvciB0YXNrIGRlc2NyaXB0b3IgZGF0YSBw
cmVwYXJhdGlvbiB0byBob3N0cy4NCj4gPiA+IFBsZWFzZSBjb25maXJtLg0KPiA+IA0KPiA+IFN1
cmUsIGZvciBub3cgdGhlIHJlcXVpcmVtZW50IGhhcyBjb21lIHVwIG9ubHkgZm9yIERDTUQgZGVz
YyB1cGRhdGUuDQo+ID4gU3VyZSB3ZSBjYW4gYWRkIHRhc2sgZGVzY3JpcHRvciBvcHMgaW4gdGhl
IHNpbWlsYXIgd2F5IGxhdGVyIHdoZW4gcmVxdWlyZWQuDQo+ID4gDQo+ID4gQWRyaWFuLCBwbGVh
c2UgY29uZmlybSBpZiB5b3UgYXJlIGZpbmUgd2l0aCBib3RoIG9mIGFib3ZlPw0KPg0KPiBZZXMs
IEkgYWdyZWUuICBTb3dqYW55YSdzIFYyIDA2LzEwIHBhdGNoIGlzIHF1aXRlIG5hcnJvd2x5IGZv
Y3VzZWQsIHdoZXJlYXMgdXBkYXRlX2RjbWRfZGVzYyBhcyB5b3UgZGVzY3JpYmVkIHNlZW1zIGp1
c3QgYXMgZWFzeSB0byBpbXBsZW1lbnQsIGJ1dCBJcyBtb3JlIGZsZXhpYmxlLg0KPg0KSW4gY2Fz
ZSBpZiBteSByZXNwb25zZSB0byBmZWVkYmFjayBnb3QgbWlzc2VkLCBEQ01EIGRlc2NyaXB0b3Ig
YXR0cmlidXRlcyBhbmQgdGFzayBwYXJhbWV0ZXJzIHJlbWFpbiBzYW1lIGZvciBhbnkgaG9zdCBp
bmNsdWRpbmcgUUJSIGFzIGl0cyBtdXN0IHRvIGVuYWJsZSB3aXRoIERDTUQuDQpEQ01EIGNvbW1h
bmQgcGFyYW1ldGVycyBpbmNsdWRlIG9wY29kZSwgdGltaW5nLCBhbmQgcmVzcG9uc2UgdHlwZSB3
aGVyZSBvcGNvZGUgYW5kIHJlc3BvbnNlIHR5cGUgc3RheXMgc2FtZS4NClNvIGFkZGVkIGludGVy
ZmFjZSBvbmx5IHRvIGFsbG93IGNvbW1hbmQgdGltaW5nIHBhcmFtZXRlciB3aGljaCBob3N0IGNh
biBzZXQgZWl0aGVyIDEgb3IgMCBpbiBWMi4NCg0KSXJyZXNwZWN0aXZlIG9mIERDTUQgZGVzY3Jp
cHRvciB1cGRhdGUgcG9zc2liaWxpdGllcyBuZWVkZWQgZm9yIGhvc3RzLCB3ZSBjYW4gZXhwb3Nl
IGNvbXBsZXRlIERDTUQgZGVzY3JpcHRvciBkYXRhIHRvIGhvc3RzLg0KDQpCYXNlZCBvbiB5b3Vy
IGJvdGggZmVlZGJhY2tzLCBXaWxsIGdvIGFoZWFkIGFuZCB1cGRhdGUgdG8gYWxsb3cgY29tcGxl
dGUgRENNRCBkZXNjcmlwdG9yIGRhdGEgdXBkYXRlIGZvciBob3N0cyBmb3IgbW9yZSBmbGV4aWJp
bGl0eS4NCg0KPiA+IA0KPiA+ID4NCj4gPiA+Pj4gV2hhdCBkbyBwZW9wbGUgdGhpbms/DQo+ID4g
Pj4+DQo+ID4gPj4+PiAgICAJCX0gZWxzZSB7DQo+ID4gPj4+PiAgICAJCQlyZXNwX3R5cGUgPSAw
eDI7DQo+ID4gPj4+PiAgICAJCQl0aW1pbmcgPSAweDE7DQo+ID4gPj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oIA0KPiA+
ID4+Pj4gaW5kZXggOWU2ODI4NmEwN2I0Li5mOTZkODU2NWNjMDcgMTAwNjQ0DQo+ID4gPj4+PiAt
LS0gYS9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmgNCj4gPiA+Pj4+ICsrKyBiL2RyaXZlcnMvbW1j
L2hvc3QvY3FoY2kuaA0KPiA+ID4+Pj4gQEAgLTE3MCw2ICsxNzAsNyBAQCBzdHJ1Y3QgY3FoY2lf
aG9zdCB7DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gICAgCXUzMiBxdWlya3M7DQo+ID4gPj4+PiAgICAj
ZGVmaW5lIENRSENJX1FVSVJLX1NIT1JUX1RYRlJfREVTQ19TWgkweDENCj4gPiA+Pj4+ICsjZGVm
aW5lIENRSENJX1FVSVJLX0NNRF9USU1JTkdfUjFCX0RDTUQJMHgyDQo+ID4gPj4+Pg0KPiA+ID4+
Pj4gICAgCWJvb2wgZW5hYmxlZDsNCj4gPiA+Pj4+ICAgIAlib29sIGhhbHRlZDsNCj4gPiA+ID4+
Pj4NCg==
