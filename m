Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC71C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B2D23429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MafNGO9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfH3SMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:12:17 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:34059 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbfH3SMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:12:16 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6966fb0000>; Sat, 31 Aug 2019 02:12:11 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 30 Aug 2019 11:12:11 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 30 Aug 2019 11:12:11 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Aug
 2019 18:12:11 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Aug 2019 18:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpBXupuwK6rr4hu6KtDg0qVNNFT3jBDhDqpAY6dM3PjEfk/POJvs0VikVGxM/9d6ll4SalXJ/22s5J9DPt8g72c5+cijVkyg2GFnhZ5saxuUxgs4AsF4EhCi8f1cPpFz0trj4WOEBmVfsiIza3wFYOgUWK1Tzg5VLcNm81uheDd0UZ4Km4dAt6rERNtuDbv/uIiXI29Fi2HA25p6F7DP/e/zvizj6GIrJ9icFU1QjgVXFuS61hRK9P7tzfe0P1WFR+LJuRTDqJ5c6x0Curw47yCajslYS3PkqrAVtJM4Zr4lrKISzUnnv+e1sKyWWNdc31bU3LwPghhJzoMdv+ZmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afkDbhS5QlnNmnCKmQRcQ2VHcTWD0C8t7DOHFHJwYYo=;
 b=ljAdvvTY6dtARATP9DGkBGbCyHnls4AvDjZxAmELKzaBzacrH+UWXJOlOfgUVSpRHT/XSDLS1SmxdGDiVQWF463kb0NyQ3DAsvcCy6FiALKquM4AgmND765PhjGJRVkiDWTFZS+aG8txKWUNxSDyEhAro8iEtWKPY9TVEBTzLbRiFNlDK0ayw3JQaCPRWmiwOLFQqSbd9tuFSqBoVcB0CF8NPb4OY0DlQFaWsI6CvF0uSjXEQ4yDFhVGcJKUZQmbOd/3v6PkGg0lrfwUEZGVUdtbYtkKaCioOH4F9rGqB9W0gXDDXl7iBs8uNOdvwFAHSi3JIHIfUTuyhTHXGq7i6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB3400.namprd12.prod.outlook.com (20.178.196.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Fri, 30 Aug 2019 18:12:08 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56%6]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 18:12:08 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Sachin Nikam <Snikam@nvidia.com>,
        "Thomas Zeng (SW-TEGRA)" <thomasz@nvidia.com>,
        Juha Tukkinen <jtukkinen@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timo Alho <talho@nvidia.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/7] dt-bindings: arm-smmu: Add binding for nvidia,smmu-v2
Thread-Topic: [PATCH 2/7] dt-bindings: arm-smmu: Add binding for
 nvidia,smmu-v2
Thread-Index: AQHVXruKO4f1UhWPvU2lIJwxk9hV3KcTzW4AgAAwllA=
Date:   Fri, 30 Aug 2019 18:12:08 +0000
Message-ID: <BYAPR12MB271012F225E35C1459E58D07B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-3-git-send-email-vdumpa@nvidia.com>
 <37034b76-7e3f-5f3c-25b2-696e25127682@arm.com>
In-Reply-To: <37034b76-7e3f-5f3c-25b2-696e25127682@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-30T18:12:05.1263803Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=95932347-7c76-49bd-9d4a-388d72b92c7b;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93d802a6-50f7-4835-5cbb-08d72d759233
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3400;
x-ms-traffictypediagnostic: BYAPR12MB3400:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3400D4A911FD3BE3E9238CC8B3BD0@BYAPR12MB3400.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(366004)(376002)(199004)(189003)(7736002)(54906003)(6506007)(86362001)(5660300002)(229853002)(486006)(71190400001)(9686003)(6436002)(99286004)(74316002)(76176011)(11346002)(4744005)(55016002)(102836004)(476003)(316002)(52536014)(26005)(7696005)(6116002)(3846002)(6246003)(256004)(33656002)(6916009)(76116006)(446003)(186003)(66946007)(53936002)(66556008)(64756008)(71200400001)(305945005)(66066001)(81156014)(14454004)(8936002)(4326008)(81166006)(66446008)(25786009)(66476007)(478600001)(2906002)(8676002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3400;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3PqVvmI6GIYh8oTFFZZ/coh+01+yUXp8EGuGYw5MGYV0K6XIADIHfQDFINe73bk+WNi/TZsUhmryhFy+IFzE+imJjG63xCgOJWsUdcvnEMwjeidiWkxrDeAVVJptsUdu4RkftMF0cNFkMnzZbU0Luu0L7O6o6YeOsiSgdpIRVUUcxDARCsPen2F5nQA3KCmnVizckDGsXQeIiUtgfeCJzRlLIr7kUzMf9Upf9iVHcxL/my6w3iLq7x9d63GSbyU094bX51KGa0o1zUxbRRyav83pdrnQLXwRwpc8wKDfI6xYkoVCWW3VxV68jm0k4GbjB3msE1z5RAYXavIpRJW4oj1oovbZFUB8sP34TocxSukIts+Kg3zxwhACFkA4Tmfg+EsXmEn1/xmT00/AnWeBoz2JuJBxzRQltXwyq+7iURc=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d802a6-50f7-4835-5cbb-08d72d759233
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:12:08.2298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1TgTOLpMuHg+fSx0Bix1MVsfkuljfIqXKye436zSyDnycwTQ2TlVDMDcrFeFjGRLz+dVKfA85tSMWwYchPkVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3400
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567188731; bh=afkDbhS5QlnNmnCKmQRcQ2VHcTWD0C8t7DOHFHJwYYo=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=MafNGO9y5FPOyLgc4gHSnPBpPuD7B5+I9NEgnkkt1Wu82aE9QQ83rvrEa1LBB5gcM
         HasetZfr8V+pX63W5WtwdkaCjm8N5S7KixzdasA/DNu6GFGly3qZUaSMbXeBBgNTwm
         +hKJfuIcaB9K8MsqFUYH8Ud7PWsRj5zwESOVT+UWrWNbZJw4p3BCb8+4njIUVwD4Af
         GYXIbwE4fy0EAv+zbTAvRdlDHO8Tepn3Qjkl0mdYLvdLNd2LG+X47pIS0nRDix9AnN
         /7XNo8huQD+KGPsbjSEGRdCKuKOxDqf/7ZUdc4luLY8LtHJ61MXP7UoiCAIhe8afEK
         kqlJbI8slxtgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICJuaWRpYSxzbW11LXYyIg0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAicWNvbSxzbW11LXYyIg0KDQo+SSBhZ3JlZSB3aXRoIE1pa2tvIHRo
YXQgdGhlIGNvbXBhdGlibGUgbXVzdCBiZSBhdCBsZWFzdCBTb0Mtc3BlY2lmaWMsIGJ1dCBwb3Rl
bnRpYWxseSBldmVuIGluc3RhbmNlLXNwZWNpZmljIChlLmcuICJudmlkaWEsdGVncmExOTQtZ3B1
LXNtbXUiKQ0KPiBkZXBlbmRpbmcgb24gaG93IG1hbnkgb2YgdGhlc2UgcGFyYWxsZWwtU01NVSBj
b25maWd1cmF0aW9ucyBtaWdodCBiZSBoaWRpbmcgaW4gY3VycmVudCBhbmQgZnV0dXJlIFNvQ3Mu
DQoNCkkgYW0gY29ycmVjdGluZyB0aGUgc3BlbGxpbmcgbWlzdGFrZSBwb2ludGVkIGJ5IE1pa2tv
LiAgVGhlIE5WSURJQSBTTU1VdjIgaW1wbGVtZW50YXRpb24gaXMgZ2V0dGluZyB1c2VkIGJleW9u
ZCAgVGVncmExOTQgU09DLiAgDQpUbyBiZSBhYmxlIHRvIHVzZSB0aGUgc21tdSBjb21wYXRpYmxl
IHN0cmluZyBhY3Jvc3MgbXVsdGlwbGUgU09DJ3MsICJudmlkaWEsc21tdS12MiIgY29tcGF0aWJs
ZSBzdHJpbmcgaXMgY2hvc2VuLg0KQXJlIHlvdSBzdWdnZXN0aW5nIHRvIG1ha2UgaXQgc29jIHNw
ZWNpZmljIGFuZCBhZGQgYW5vdGhlciBvbmUgaW4gZnV0dXJlPw0KDQotS1INCiANCg==
