Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0CFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB4523429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IVfN6iOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfH3SFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:05:30 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:59670 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfH3SF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:05:29 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6965680000>; Sat, 31 Aug 2019 02:05:28 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 30 Aug 2019 11:05:24 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 30 Aug 2019 11:05:24 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Aug
 2019 18:05:24 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.59) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Aug 2019 18:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaE4MjVferQnN9ihleH3WmpzkDQHV8QrAw9DjYnajKPkM5LduYZytajqFSvDISTFDvV6Tv7V8NGvNc2YMeXxuYYNNDDvP/iIkM+/j7Mz3z3/NLfuV3M0UvSQMY+pe638q1v2ffLPilEZZaBKfa0IDc+FmNpI+0Y0R0ggD8lbsYChjWYUVzbYXGgwch4T7akVGWknDEWKaFx5rHbpkD/qyIrtwp4Lsp+Q5ReGDSKKuT44baJrQaVMaDxplTtbxtTT6AjeIvyms6X4WvEEow8dPXH3jIO6+5h8B2fJwz3doZD3lNRX0gtGe414ndmverfs+ha4lplvXZJC/Qxpn4SdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRTzU42oTS+hl/Y9AccE9c/RtuIB71TiWTKJM07i6E0=;
 b=b/7z9ZLDUuO0lW5/Svy7oyBq5Rl+/ijsxSRbPMfM4LcaK9txQ/ndR+vJBz50459F1e9D4mVgMC+JZxY5kaVHGjBVKcJLoVdOA3v0mbd67rN9foTexNZ84FbX363rnTytF6aG7GZrg0TIJwx2+o6BoWZej89qJd7GzxF52o8v/yOKhQ6Ivgjpe6fdp/ITmu6gZFtfo2CWFcqQi2o3d0acKmOm5VKLCybE+KD16JaZRbl71asPPkpJIJrLBW4eH5ZAaNCOaMBa7BKpX1IvDqH3xFdFecrKtc7EKICG8Od8ebzwFQrBjw0MjttowoY5NR3aDb874ly6RK0COfq8zXd1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB2999.namprd12.prod.outlook.com (20.178.53.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 18:05:19 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56%6]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 18:05:19 +0000
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
        <linux-arm-kernel@lists.infradead.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH 3/7] iommu/arm-smmu: Add tlb_sync implementation hook
Thread-Topic: [PATCH 3/7] iommu/arm-smmu: Add tlb_sync implementation hook
Thread-Index: AQHVXruLTOWAUKMP0EGEhzK6CNK386cT0DaAgAAq0XA=
Date:   Fri, 30 Aug 2019 18:05:19 +0000
Message-ID: <BYAPR12MB2710AF5DDCB687C7E78362E5B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-4-git-send-email-vdumpa@nvidia.com>
 <554f8de1-1638-4eb9-59ae-8e1f0d786c44@arm.com>
In-Reply-To: <554f8de1-1638-4eb9-59ae-8e1f0d786c44@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-30T18:05:16.2199634Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=a3d3cc0f-e7fb-4c08-bde5-5c1a13761cab;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1451366-1d2a-4b19-7341-08d72d749ea1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB2999;
x-ms-traffictypediagnostic: BYAPR12MB2999:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB299935878947AE3E3712A615B3BD0@BYAPR12MB2999.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(7696005)(4326008)(64756008)(66476007)(9686003)(33656002)(14454004)(81156014)(81166006)(55016002)(8676002)(86362001)(74316002)(478600001)(316002)(305945005)(7736002)(76116006)(6116002)(6436002)(99286004)(54906003)(66066001)(3846002)(8936002)(6246003)(26005)(476003)(53936002)(66556008)(25786009)(446003)(76176011)(52536014)(71200400001)(14444005)(486006)(102836004)(71190400001)(66446008)(229853002)(66946007)(5660300002)(6506007)(6916009)(11346002)(256004)(186003)(2906002)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2999;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kiwwIu/EbIvxQINTf8n7K/j+rfJTW6SkBDuwYPzTZJzhLq6L5ry/jggY11jLQ+xCbH/nMFz2tqognNcwp0UmA7axrng79+RGkgi988+0RhAdmSdeDZEzo9VAtoRD2h6u2OBXUF+w8y2aHoVuUs4DQMeFIkdvDcbwHJ/2Kwhkf72lTYbDcMOhpRTHG3nonET6zph5XHxkGUYg6p6MpRSypwyo7KKcRUMS14hfVDvDnd5SMtW/GE1pKHyAvxgoh+Xxu0lQNn55Rq2k9ReUSL6QFIRmLcyWvy5V8vwp3DftEWTa+G6iRL4u5WCFSaUwVK/891KHVrqUNrw+Kvmw0C9QVVtGR2geklR6H7X7wjHW91EBUMbb10UDcEz1RF+UzpYc9KFtb8ZpCHqnEKQZF0HOxy4kL++PG0lpIUGwD5upJXk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1451366-1d2a-4b19-7341-08d72d749ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:05:19.5842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFnNSL4eSWx4KGk44GvQYwmM6ehUzY7/S/NWPUZohG6xGKu2h7H93zY7tqCrkAU9R8yAPGLCY0EjYHmjnXCk9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2999
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567188328; bh=wRTzU42oTS+hl/Y9AccE9c/RtuIB71TiWTKJM07i6E0=;
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
        b=IVfN6iOCJaFvdk+1h/4qndIUFRuR5gG4Pq/22jVlN7roS4skt+tj9ettqBAYDIEUn
         rqFeWQ7EpU1lJ7PZ74i78TgjpvZtIoN3VlytnYN/O9vzbNrY5R6f8j0nDM5X9UU3Ln
         LTLwucsY/4Ryq8O4ecASH5dMkRfBWHsucu/56y265lIj5lpG8FH+WrXACIy+2nZDGU
         y/xJ1uLvKDPiuLOsSbITR54sP3Z3XN90ZhWz84YrQ1SY0kuxdzNPLOCVzHW2QUG4ma
         rwrHPEwNRnwQJDoiw+Bkohrl41O71HHzxIiCjQVp9res8znpVAkA19gSoxLrLLERbT
         PD0P2p1DTZB9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKwlmb3IgKGkgPSAwOyBpIDwgdG9fbnNtbXUoc21tdSktPm51bV9pbnN0OyBpKyspDQoNCj5J
dCBtaWdodCBtYWtlIG1vcmUgc2Vuc2UgdG8gbWFrZSB0aGlzIHRoZSBpbm5lcm1vc3QgbG9vcCwg
aS5lLjoNCglmb3IgKGkgPSAwOyBpIDwgbnNtbXUtPm51bV9pbnN0OyBpKyspDQoJCXJlZyAmPSBy
ZWFkbF9yZWxheGVkKG5zbW11X3BhZ2Uoc21tdSwgaSwgcGFnZSkuLi4NCj5zaW5jZSBwb2xsaW5n
IHRoZSBpbnN0YW5jZXMgaW4gcGFyYWxsZWwgcmF0aGVyIHRoYW4gaW4gc2VyaWVzIHNlZW1zIGxp
a2UgaXQgbWlnaHQgYmUgYSBiaXQgbW9yZSBlZmZpY2llbnQuDQoNClN5bmMgcmVnaXN0ZXIgaXMg
cHJvZ3JhbW1lZCBhdCB0aGUgc2FtZSB0aW1lIGZvciBib3RoIGluc3RhbmNlcy4gVGhlIHN0YXR1
cyBjaGVjayBpcyBzZXJpYWxpemVkLg0KSSBjYW4gdXBkYXRlIGl0IHRvIGNoZWNrIHN0YXR1cyBv
ZiBib3RoIGF0IHRoZSBzYW1lIHRpbWUuDQoNCj4+ICsJaWYgKHNtbXUtPmltcGwtPnRsYl9zeW5j
KSB7DQo+PiArCQlzbW11LT5pbXBsLT50bGJfc3luYyhzbW11LCBwYWdlLCBzeW5jLCBzdGF0dXMp
Ow0KDQo+V2hhdCBJJ2QgaG9wZWQgaXMgdGhhdCByYXRoZXIgdGhhbiBuZWVkaW5nIGEgaG9vayBm
b3IgdGhpcywgeW91IGNvdWxkIGp1c3Qgb3ZlcnJpZGUgc21tdV9kb21haW4tPnRsYl9vcHMgZnJv
bSAuaW5pdF9jb250ZXh0IHRvIHdpcmUgdXAgdGhlIGFsdGVybmF0ZSAuc3luYyBtZXRob2QgZGly
ZWN0bHkuIFRoYXQgd291bGQgc2F2ZSB0aGlzIGV4dHJhIGxldmVsIG9mIGluZGlyZWN0aW9uLg0K
DQpXaXRoIGFybV9zbW11X2RvbWFpbiBub3cgYXZhaWxhYmxlIGluIGFybS1zbW11LmgsICBhcm0t
c21tdS1udmlkaWEuYyBjYW4gZGlyZWN0bHkgdXBkYXRlIHRoZSB0bGJfb3BzLT50bGJfc3luYyBh
bmQgYXZvaWQgaW5kaXJlY3Rpb24uDQpXaWxsIHVwZGF0ZSBpbiBuZXh0IHZlcnNpb24uDQoNCi1L
UiANCg==
