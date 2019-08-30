Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12E8C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6746323427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I3AOU4gY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfH3RZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:25:17 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6687 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3RZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:25:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d695bfc0000>; Fri, 30 Aug 2019 10:25:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 30 Aug 2019 10:25:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 30 Aug 2019 10:25:14 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Aug
 2019 17:25:13 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Aug
 2019 17:25:13 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.58) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Aug 2019 17:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAQlqwyjG5bfVXbSD8cBchSgnB+VlKokPANq1CYKxbPn4a1V2suKI/OURCFx0X91E9A8LpeZO35bBftL/S50RdrCpNET0maSwO58hmBQyDQIP1vy66M8CstKXnY1pPtZ/V2uIeqTyxkgQdxL5LiqRXsfIyJN+1YbHtKj8KqXpgOjByNIBs/awYpsy+m2E0WvTpO/9h0qYYsOdu1RrXYOyZXrKZoLd0hrDYJnCCgf2Xy7OrSAv2/AnfzTBNxFHRLMT/J7iFFaNduSPMBBVjG4+dDzNcKZQPxpvY+w5hlTag9bbR0QiWa1Pvl2+Ol8I7EFwhb49VAOLma8bC2T4yQKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBYQzXGSSqiSlRRKp0339GbPc2xiTkMeMT/N2OIhMlU=;
 b=GtrvGDePBAbVsHXAQzYrn7LZlUOMd3Cou+It2hn37u/9IV6cOrkzU/63hbXic+KPbO/Q8T3bFN7vqQ111zCmWx7v2SQUpItVL1dlZLctqqTqgkeeVKd9yzsPLuAq9eDilXNMpHWyh3ir9Z4u0KLhj+UnFB79ey865k3fAnQBogTUWhhlS6vSYyKX0yPDT5F0q86zVKtW35vtLPb9pefk8Vy96E49b0BUac7FwwCD22CmNES3MnKpK0Fz62sIqJgXkw9wKi0ItXWZnIMt9YHwRZqqqfPIoJpNUMajrd3z2MJuFTJwuDbDoas63ySJGEhHImzhHFz0bABYnCEKXf+zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB3574.namprd12.prod.outlook.com (20.178.197.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 17:25:12 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56%6]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 17:25:12 +0000
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
Subject: RE: [PATCH 6/7] arm64: tegra: Add DT node for T194 SMMU
Thread-Topic: [PATCH 6/7] arm64: tegra: Add DT node for T194 SMMU
Thread-Index: AQHVXruJJaNjwNgb20yUxCVyNgmdfqcT1imAgAAZ92A=
Date:   Fri, 30 Aug 2019 17:25:11 +0000
Message-ID: <BYAPR12MB2710BDF98FA472A77D106814B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-7-git-send-email-vdumpa@nvidia.com>
 <b834ceb2-b296-0a52-c913-5a8923466cf2@arm.com>
In-Reply-To: <b834ceb2-b296-0a52-c913-5a8923466cf2@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-30T17:25:08.1305198Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=27c1526a-15e9-4826-93e8-329f3444bf1f;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 177d8ee7-67bd-455b-ccb7-08d72d6f03ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3574;
x-ms-traffictypediagnostic: BYAPR12MB3574:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3574EA79B6B4F8776EF29C02B3BD0@BYAPR12MB3574.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(446003)(256004)(52536014)(14454004)(5660300002)(186003)(6246003)(7736002)(305945005)(486006)(25786009)(71200400001)(71190400001)(4326008)(4744005)(86362001)(316002)(478600001)(33656002)(6916009)(229853002)(26005)(6506007)(11346002)(66066001)(66446008)(66946007)(66476007)(66556008)(99286004)(64756008)(55016002)(476003)(81156014)(81166006)(76176011)(7696005)(8676002)(74316002)(6436002)(6116002)(3846002)(54906003)(53936002)(102836004)(76116006)(2906002)(8936002)(14444005)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3574;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vv1qDg0j9Z36PuJi5cFFCBaZE8WkMB3f1ZgN6yJDSXMpKkEOPaKPqOQ3MyLq0ITRe/LzRzVtpK/1IDJtRKjpDCOZmK/Z4H01XQKcANM/88Imv04ce65mKfsnStzbEbll5KVuVoNGu4kdZY1cvlpxXomBBfy2lZ0HCy+PMfQB02hDDdbz51CSQ6YV5OgfrWaGBJ7UwQ64DOXUpaKrhgfMJcPa2B63dSOA2jcRfV7nWvQTZBoxViO8a1UhUhXGjHzuaxJPG26uZtmfawBBy5ikL+cgh59zKv86YwfFmx0bv6M0K8ThQV9DgOFy7Wb8ZAdSp/+uOG0RTPPm//ERgEjxOT2fcW6zMXpg1aMWgF9+16ZZw2NMISoy+Pi0ENEvTeiJut6F7qXUfhPjXokwi/keqmiexSMsXm2k0sFdtREiHc8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 177d8ee7-67bd-455b-ccb7-08d72d6f03ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 17:25:11.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qazTpIEnqfmVXCUzxG6Phze+I9RVmDL/w16KUfalKe2ImOvoJkf6+/AVhzXEIrKVAFDUs+ZtL5JPyM4glgb/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3574
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567185916; bh=hBYQzXGSSqiSlRRKp0339GbPc2xiTkMeMT/N2OIhMlU=;
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
        b=I3AOU4gYw3gBtNvcJt06i/GXDwcKXX4STHTsLZRGJj+3VvfCKxmWhh88jznceHO3q
         qpwtwWUFXv9i9KR0rOZbIWjv5kGljd5QYFmAATWrSebSTwTNH886UNoNbwM1S6Qh9Q
         Ft3abSwDUv/w4jFyoMGfH8q//4ZGMKhNCaXRUdkCjL16JksCUnYiWqUFUBfAFAZdu1
         4XmYazhfYi9jAtn7K+3ek4xrdq50PBI/fpxn50MxUgK3NziWuRsW7n//Xnzfek60vb
         7TLiQtlu6ASdANsruhvXDgvFsoOWzJ9VCZXJmxpIveIbY3AC8SX9+/6XsRKOhAfbSa
         BBbzaxWHVu5KA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKwkJI2dsb2JhbC1pbnRlcnJ1cHRzID0gPDE+Ow0KDQo+U2hvdWxkbid0IHRoYXQgYmUgMz8N
Cg0KSW50ZXJydXB0IGxpbmUgaXMgc2hhcmVkIGJldHdlZW4gZ2xvYmFsIGFuZCBhbGwgY29udGV4
dCBmYXVsdHMgZm9yIGVhY2ggU01NVSBpbnN0YW5jZS4NCk52aWRpYSBpbXBsZW1lbnRhdGlvbiBj
aGVja3MgZm9yIGJvdGggR2xvYmFsIGFuZCBjb250ZXh0IGZhdWx0cyBvbiBlYWNoIGludGVycnVw
dCB0byBhbiBTTU1VIGluc3RhbmNlLiANCkl0IGNhbiBiZSBlaXRoZXIgMSBvciAzLiAgSWYgd2Ug
bWFrZSBpdCAzLCB3ZSBuZWVkIHRvIGFkZCB0d28gbW9yZSBpcnEgZW50cmllcyBpbiBub2RlIGZv
ciBjb250ZXh0IGZhdWx0cy4gDQpJbiB0aGUgZnV0dXJlLCB3ZSBjYW4gdXBkYXRlIGFybS1zbW11
LmMgdG8gc3VwcG9ydCBzaGFyZWQgaW50ZXJydXB0IGxpbmUgYmV0d2VlbiBnbG9iYWwgYW5kIGFs
bCBjb250ZXh0IGZhdWx0cy4NCg0KDQogLUtSDQo=
