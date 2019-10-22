Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DC3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132CB2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JuyFt6ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389847AbfJVXtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:49:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13400 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389812AbfJVXs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:48:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5daf956e0000>; Tue, 22 Oct 2019 16:49:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 22 Oct 2019 16:48:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 Oct 2019 16:48:56 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Oct
 2019 23:48:56 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.57) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 22 Oct 2019 23:48:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/i5kEYw48pPVIElu1zgU8gcROQIcLk3LE7zxUtoEtSIhDJ6M3FPOpPUDNiTZqm1Vi9VDDK9F4yv5ugZQMF7hr/BdW0zbLWSiucz/j5mgVB44GR26qjF1SlAySj0WYpjXYyNgZWa+jbjgSmDBz2zVUxvLLwoQLUYcoFLbc4J9zj6goNpbSddNCKnONohQk1eVHyAQWNCHpQ295nn2F0IIb7OPRrk0dhPVCcPj/nbOKWULpWng38rTxnXxXfN540N3PgpJcsGMifbyDq2cdKMksyjEhs2Gz0lfMjn5Pd6JvMW3jzp4m+TUrF/C7NWnmKaMnRvBfIZ0YYsVg3Leg17YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh7MXofScYhBwjHA1E2Rr/9tALzMhSRaxjzSxLclQ4s=;
 b=QfNmE2k3QtO/sJbDMywj5mGgaPSHRpaVPXliRGae2bv72a+FDk1MRHD4mcWSs/0DYPmRqDJRSLcNb3dn1cFmeHthIvQEycEaCAbwgbdj5oyWcmrW0GkNx9G6UwOaiVEvxbB4UCzTqSAVvLDWprR4BtXsgR/rZeZ/T41RfwBjOPT5tN9Yx+TO34H033W32CoBNJSL2QOBVPz+Glj184prMHGKeGRPceGU4iFK+O/Xg6k+io6Ui2zuS2ZQ0UItHMKDwg6t846mV3vQwaCUrI2UojjGa5b/BROy3lEiY1IF2BskQwwwrhJHP1V0P0mMPzdDHjqd4D7qGqb8rqu3q2EHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB2856.namprd12.prod.outlook.com (20.179.93.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.28; Tue, 22 Oct 2019 23:48:55 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::c0fa:c019:dd8e:dd40]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::c0fa:c019:dd8e:dd40%6]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 23:48:55 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        "Yu-Huan Hsu" <YHsu@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        "thomasz@nvidia.com" <thomasz@nvidia.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Juha Tukkinen <jtukkinen@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 0/7] Nvidia Arm SMMUv2 Implementation
Thread-Topic: [PATCH v3 0/7] Nvidia Arm SMMUv2 Implementation
Thread-Index: AQHVhgwr2/1seTuEaUyC0D9/Qf1q8adm9sOAgABg1jA=
Date:   Tue, 22 Oct 2019 23:48:55 +0000
Message-ID: <BYAPR12MB2710879535971E290E8B25D3B3680@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
 <6d9e6425-fa69-9b76-b477-1fe50c459ca5@arm.com>
In-Reply-To: <6d9e6425-fa69-9b76-b477-1fe50c459ca5@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-10-22T23:48:52.8304322Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=2963f581-b925-41a1-8109-ed18d39e57e8;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1005c41b-ffcf-4272-7641-08d7574a667a
x-ms-traffictypediagnostic: BYAPR12MB2856:|BYAPR12MB2856:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB28563C77B9A8FAD795B84917B3680@BYAPR12MB2856.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(76116006)(86362001)(25786009)(6246003)(6436002)(4744005)(229853002)(107886003)(55016002)(52536014)(4326008)(66066001)(64756008)(54906003)(66446008)(66556008)(66946007)(66476007)(33656002)(9686003)(11346002)(476003)(7696005)(8676002)(186003)(6506007)(71200400001)(74316002)(5660300002)(486006)(71190400001)(446003)(305945005)(81166006)(81156014)(102836004)(478600001)(26005)(256004)(8936002)(6116002)(2906002)(2501003)(3846002)(14454004)(316002)(7736002)(76176011)(99286004)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2856;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3f6s9SPPqph/UZ7Lx2+MRvotk/0sckXSYrhNvMobFSAvMFKnzWqzv3Hjl93sqIPhC1k2mLTKgCs06TUzoiqk0bVf216/dYhGWz5BG6mEssHeIbcJ/lTyGHLyjm7x8jm+ABcyMmt7QFRPb1Aw3Jhf3ZYIKVhKvpkqgwXv8rN1EFWdyCxniqH4uD7Rfd8NxV0Ks6bjp6GVXKXedecjAAZOqt8NWAzjb94HExlIrCNMzq5gSBvh6yNAFXXiYiXv2hseNn/I6DA+3SV33zaUieXBdFFrygTHHgKJ6jj3hvcPYOtdzeCGJCQS/GcdG+/BaW586pekfsMPsc7xDQ6sxIbIFDyRU8LsxPrFiKiV64tXTdTCLKYJcksRygp37GzgMmy2A80tKVCCF2uR88KB1VpRK4S6kz2LxO4YUkZ8dvJ7Vrd4ggKmugvjste7BeEEf/ti
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1005c41b-ffcf-4272-7641-08d7574a667a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 23:48:55.3573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdK44H9I2DwMtfaoWTLZ6nAKu7UhfyztEEBJYk7aGtI2Ny0uUudihfHiikgkabZEHwwvSohvf6T89t4UIO5m1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571788142; bh=hh7MXofScYhBwjHA1E2Rr/9tALzMhSRaxjzSxLclQ4s=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=JuyFt6ousahItj4lJXzCbpeM1/og4cXzKIGryozbYvks1k2aWV9vxmpPO4RDjixzc
         TKgKfJ/+q/GxgdMr8Ln9+QBDBzwgSSuwPWh2ZNBsmep3VyMSJwYsvfMWxCPY7TkiPW
         hHl23rs5jd9hUgAY5q9X1A8bskIr29kAzvCfmgm2RGqHqALu4pAtW0wM5ENwm0pbg0
         613g2Jbx3WCpWwxjJHHkVhaJcD8O92lsfZuDp5Una/bwyxbjwrE2MWFPrcPVPjCajm
         COg+YGU/fHcmJ9TtyRD5FGotUwd8+D8rNuiB+UP/l68rjnfQIzpSzPeC/X+AxU6IMi
         ho6XcFoEqH3Bg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQo+PkFwb2xvZ2llcyBmb3IgY3Jvc3NlZCB3aXJlcywgYnV0IEkgaGFkIGEgc2Vy
aWVzIGdldHRpbmcgcmlkIG9mIGFybV9zbW11X2ZsdXNoX29wcyB3aGljaCB3YXMgYWxzbyBtZWFu
dCB0byBlbmQgdXAgbWFraW5nIHRoaW5ncyBhIGJpdCBlYXNpZXIgZm9yIHlvdToNCg0KSSB3YXMg
bG9va2luZyB0byByZWJhc2Ugb24gdG9wIG9mIHlvdXIgY2hhbmdlcyBmaXJzdC4gIFRoZW4gSSBy
ZWFkIFdpbGwncyByZXBseSB0aGF0IHNhaWQgeW91ciB3b3JrIGlzIHF1ZXVlZCBmb3IgNS41LiAN
CkxldCBtZSBrbm93IGlmIHRoZXNlIHBhdGNoZXMgbmVlZCB0byByZWJhc2VkIG9uIHRvcCBvZiBp
b21tdS9kZXZlbCBvciBhIGRpZmZlcmVudCBicmFuY2guIEkgY2FuIHJlc2VuZCB0aGUgcGF0Y2gg
c2V0IG9uIHRvcCBvZiBuZWNlc3NhcnkgYnJhbmNoLg0KDQotS1INCg==
