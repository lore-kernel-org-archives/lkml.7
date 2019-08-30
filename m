Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B63C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ABF2343D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cV6CYXZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfH3Wta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:49:30 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:46291 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbfH3Wta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:49:30 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d69a7f80000>; Sat, 31 Aug 2019 06:49:28 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 30 Aug 2019 15:49:24 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 30 Aug 2019 15:49:24 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Aug
 2019 22:49:24 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Aug 2019 22:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMBs5auKlCAHb5A2x5vN4MS9NmmcFdDVprN9AYQLXzt4gazJ4xRWypYzsAHISMS7aH7ls3z8WCmMNGuOr3sShrqQPBPMfe7IGBChZVVrD1MiQe9ADTghA6HVNfGdSI9YnqjAPyDNw47CLT3vARtH5BDToulRz/ofdTE/eXEj+S7q8rLhdfMaX4EYvJVX9o88ozZCpHfGAgSTyepdlD1H5N/QndVzr+Rlu/Gbvlf/DnQIai9EPZdkWFIf7Ddc6SBYCLPo9wFPvcMBgE7v/+YzMuKU6DjrihoqE8r+c5LtJFcpJEJv5FR3HccOnAKwItbUID1FJCLcjx98vpXgZYfdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trBhQKN2D09sqaV5W/nveEfPuUmQkEiWO7RE9DGubmw=;
 b=PXbsT0z9+jZbA1zalD8SiNvgMXHOqIh2RCJGBH+baXAiBwo2Hy2lmEpqPdO5eLx7A8YJV0+Ed5fQ01Fx9dPMCjPSBklupTgyc3LvV3OLQaM/NxDxI37aVZocQr62J2iNnpn6cuCP2WHkJAW6Gs8eCpW+13E5Z7TEPBiKtH0UfH591S9U6YpeZ+cDYelMQvi8G/Soc+yv8wPQ0iTA1fiFHCzh+qM/GoyF1R3UwIz2fw9j43MRnAD0jz80ta+GIg3FxoMja1YHaK6bwD2PEUomoN2uKNpyArQEhl7jsAv53CejZFwpguRliv8KMU0nbfkv+LWl43T7LglZ5JRkg6OtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB3335.namprd12.prod.outlook.com (20.178.55.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Fri, 30 Aug 2019 22:49:21 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56%6]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 22:49:21 +0000
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
Thread-Index: AQHVXruLTOWAUKMP0EGEhzK6CNK386cT0DaAgAAq0XCAAEYjUA==
Date:   Fri, 30 Aug 2019 22:49:21 +0000
Message-ID: <BYAPR12MB271010C629D8DD7AEC0123D4B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-4-git-send-email-vdumpa@nvidia.com>
 <554f8de1-1638-4eb9-59ae-8e1f0d786c44@arm.com>
 <BYAPR12MB2710AF5DDCB687C7E78362E5B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2710AF5DDCB687C7E78362E5B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: eb70e79e-c26a-4e3a-ac7a-08d72d9c4c46
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3335;
x-ms-traffictypediagnostic: BYAPR12MB3335:|BYAPR12MB3335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3335B8B048546DE700BECB45B3BD0@BYAPR12MB3335.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(7696005)(33656002)(316002)(54906003)(486006)(186003)(76176011)(26005)(6506007)(446003)(11346002)(476003)(102836004)(256004)(53936002)(55016002)(9686003)(25786009)(229853002)(4326008)(6246003)(71190400001)(86362001)(71200400001)(6116002)(2906002)(6436002)(6916009)(478600001)(8936002)(4744005)(14454004)(66556008)(66476007)(81156014)(64756008)(66446008)(8676002)(66946007)(66066001)(76116006)(305945005)(7736002)(81166006)(74316002)(3846002)(99286004)(2940100002)(5660300002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3335;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UvKX4JZcb1sAr7wJt/c5xogan1C8OlK1ejZrvLaifvxkW7Xgmk4qHpQQU2koLnRuIc2WpxDCaWIzyv9O9Qcvu+SMmpiLum8pXgVd4EItxQeedmSr0AIeO9a/I/+mDWDDjGbuTtGgXxuoJuKCrPu1IAILmuu7ngRjAGYfrzSn4hhYqyCLrGDisipjJRhMWh+o7kV67gq6kEwr9rDHs+tU26JqVI6bWYKdUuJqdMBf6HPfHXPAknjecdwHFY6UTkiZXU+A/nkxc6aEO8TXVvyJ3LeZ8Zgt1Zvyc+fbQbdpbqTXvYGtUcleraI4z1GAj5jhNBm2D8HBHE1cCMTtOFnusiR6iz58NCv3EHs4poL2e2z3v1dXedeB4Wz5PSFHzgcckbYpcihQLdOl5rhhERk2ubkzwLWI+mBpit8kRunxEqE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eb70e79e-c26a-4e3a-ac7a-08d72d9c4c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 22:49:21.1714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQJYJrVEDn6CWC0pjnAA80o70FE52G1nzQGojtHqIXpBaeGAN6N3TvSH6Titz9R0ClubjYJRMgg8molLu32qNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3335
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567205368; bh=trBhQKN2D09sqaV5W/nveEfPuUmQkEiWO7RE9DGubmw=;
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
        b=cV6CYXZc3XxSgYkbEptzjKUZ2SLaG5bvWH60Sa4BZukhXdpGtUjNgFiWU534j06is
         ogt/ZLsyhVUQetRsJpOIdkbpcoQJJ2Kdm/rKzDzs8JL6sGsYpwQFscAFgWiehqV5BZ
         i56fdTtl+eqds//bY0RACi6F/3lB0TGg3CnS6GI3I7d7cdHXe7xKTe7nxYW0sZq26H
         SOQedgCRScvbP9n/ZiYN49hjRQxBm3nyuiPyCe56ncARCkaC88FB6YlpvzjOr8kGkI
         +mrjOicSeX7G7wacK/JrPzlTYl1tddVrXMCsbskjbrHNCsgDzUH90DgsmDLf+yxdfm
         qHH/v4WuH5xbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKwlpZiAoc21tdS0+aW1wbC0+dGxiX3N5bmMpIHsNCj4+ICsJCXNtbXUtPmltcGwtPnRsYl9z
eW5jKHNtbXUsIHBhZ2UsIHN5bmMsIHN0YXR1cyk7DQoNCj5XaGF0IEknZCBob3BlZCBpcyB0aGF0
IHJhdGhlciB0aGFuIG5lZWRpbmcgYSBob29rIGZvciB0aGlzLCB5b3UgY291bGQganVzdCBvdmVy
cmlkZSBzbW11X2RvbWFpbi0+dGxiX29wcyBmcm9tIC5pbml0X2NvbnRleHQgdG8gd2lyZSB1cCB0
aGUgYWx0ZXJuYXRlIC5zeW5jIG1ldGhvZCBkaXJlY3RseS4gVGhhdCB3b3VsZCBzYXZlIHRoaXMg
ZXh0cmEgbGV2ZWwgb2YgaW5kaXJlY3Rpb24uDQoNCkhpIFJvYmluLCAgb3ZlcnJpZGluZyB0bGJf
b3BzLT50bGJfc3luYyBmdW5jdGlvbiBpcyBub3QgZW5vdWdoIGhlcmUuDQpUaGVyZSBhcmUgZGly
ZWN0IHJlZmVyZW5jZXMgdG8gYXJtX3NtbXVfdGxiX3N5bmNfY29udGV4dCgpLCAgYXJtX3NtbXVf
dGxiX3N5bmNfZ2xvYmFsKCkgZnVuY3Rpb25zLg0KSW4gYXJtLXNtbXUuYy4gIHdlIGNhbiByZXBs
YWNlIHRoZXNlIGRpcmVjdCByZWZlcmVuY2VzIHdpdGggdGxiX29wcy0+dGxiX3N5bmMoKSBmdW5j
dGlvbiBleGNlcHQgaW4gb25lIGZ1bmN0aW9uIGFybV9zbW11X2RldmljZV9yZXNldCgpLiAgDQpX
aGVuIGFybV9zbW11X2RldmljZV9yZXNldCgpIGdldHMgY2FsbGVkLCBkb21haW5zIGFyZSBub3Qg
aW5pdGlhbGl6ZWQgYW5kIHRsYl9vcHMgaXMgbm90IGF2YWlsYWJsZS4gDQpTaG91bGQgd2UgYWRk
IGEgbmV3IGhvb2sgZm9yIGFybV9zbW11X3RsYl9zeW5jX2dsb2JhbCgpIG9yIG1ha2UgdGhpcyBh
cyBhIHJlc3BvbnNpYmlsaXR5IG9mIGltcGwtPnJlc2V0KCkgaG9vayBhcyBpdCBnZXRzDQpjYWxs
ZWQgYXQgdGhlIHNhbWUgcGxhY2U/DQoNCi1LUiANCg==
