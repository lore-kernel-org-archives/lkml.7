Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BB3CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845CB21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W+QxxVkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJWQ6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:58:51 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:45039 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfJWQ6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:58:50 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2019 12:58:46 EDT
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db085970000>; Thu, 24 Oct 2019 00:53:44 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 23 Oct 2019 09:53:42 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 23 Oct 2019 09:53:42 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Oct
 2019 16:53:41 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.59) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 23 Oct 2019 16:53:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3ZWCJlaOOKMMDcIE1V8qqbtAFfw5nc7NvYjwV/liJYjiXfgc+rBHhxVbDVX3KgJ3XCVGkOwBUeyKwzxdMktCigbWvCZIW5QCKzhIsqjlfqLi5PTSoaSg2YA2jzEBZUuuoZwHgJxb3rVGL1wECc5229/eafb4BVHCmIen7AZJibiZV8SntjrgQ8vSuKxDX+FKvK0HUQKxWt3i4S87ZT+Pbzzc2DX6DbK46GfQd8aSjAjhYtpMjiivc2Qz2u98FLx4OATDMeIciupXEevBGrtZ0v8bqVs7PO+jzWLYuh91FUZrQPH/ZCdWztEEeGcsxtmfMOQNZtCwqQbQMLgFrpoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi4XzK4tXAVJrLhIawWrtrXOktjCNc2063/Z7qAaP0k=;
 b=GernBwRpzJnam0/63w5AyrVe/H6tED2F6pP6l49We8rJO8c2UT4AzjMlEV27J8nQnGvFrBAqi2JMEnSzAaWcB3ySffCYf6GSNTkAVO6X23K+ENj5QOyoP6EBG2AO2LCEaEJk4Wjf+zlFJcooo2I9ws5DdIovWw6PUyYQBsoCINpeUwJEXSl9qVzaNCo0pGAKXpKhNeHFG8fBMp+myUc82/HfaTponSisebNZ52fsiFnsMnyjyfq0KhT44su9Oo3QsewDasRM1zrM27wq6KMVRSzx/7zfJv8Bd83crr+jHbCqL2a5FrFs0nbM+/huisYkWA35smMdKSO5Cutm1pMOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB3431.namprd12.prod.outlook.com (20.178.54.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 23 Oct 2019 16:53:39 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::c0fa:c019:dd8e:dd40]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::c0fa:c019:dd8e:dd40%6]) with mapi id 15.20.2347.029; Wed, 23 Oct 2019
 16:53:39 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
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
        Nicolin Chen <nicolinc@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>
Subject: RE: [PATCH v3 0/7] Nvidia Arm SMMUv2 Implementation
Thread-Topic: [PATCH v3 0/7] Nvidia Arm SMMUv2 Implementation
Thread-Index: AQHVhgwr2/1seTuEaUyC0D9/Qf1q8adm9sOAgABg1jCAARnGgIAABb5A
Date:   Wed, 23 Oct 2019 16:53:39 +0000
Message-ID: <BYAPR12MB271030490C786A1A209F4FF7B36B0@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
 <6d9e6425-fa69-9b76-b477-1fe50c459ca5@arm.com>
 <BYAPR12MB2710879535971E290E8B25D3B3680@BYAPR12MB2710.namprd12.prod.outlook.com>
 <20191023162716.GA27010@willie-the-truck>
In-Reply-To: <20191023162716.GA27010@willie-the-truck>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-10-23T16:53:35.7984770Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=c4838a45-f850-4dc7-b25a-2499199a20e3;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [71.198.163.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a713936-9dbb-4395-a79d-08d757d98e13
x-ms-traffictypediagnostic: BYAPR12MB3431:|BYAPR12MB3431:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34313CC0297BBA5FDF492D53B36B0@BYAPR12MB3431.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(199004)(189003)(55016002)(6246003)(7736002)(66556008)(6306002)(486006)(9686003)(6506007)(25786009)(229853002)(64756008)(26005)(66946007)(66066001)(76116006)(76176011)(478600001)(71190400001)(99286004)(102836004)(52536014)(66476007)(316002)(558084003)(186003)(6116002)(305945005)(71200400001)(3846002)(7696005)(14454004)(54906003)(476003)(66446008)(6916009)(81156014)(256004)(8676002)(2906002)(86362001)(8936002)(81166006)(107886003)(5660300002)(4326008)(74316002)(33656002)(446003)(11346002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3431;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ajITlW/m9JsQH8P4Vp3I7qtBB5pZiva1jDFC1XnDfmINeQGeFhXdh/LHg7OF97rpIIhA4D7G6Wh2CjeCFvQjYjm1/qq9l+EW8LVfjFZr3TkKVGR0SHh+H6WkqW3hZvfjzG59o+uNWg8ojMiBpXOpXM4f9kx6BaX8X7c99pt11AFVP3eSeOrGbkvzc2kstyo9v2gQP2SPzbvdkhadn/62Vk1AvBbbxm7M70Q7ireaGwh8QK6Bjjx0u3n7A3HInTQpKgwNdg2VpZHrOfInLjj9+zulY5bYtorvy2v+M6LhQzIgN46YiOC3tb1rY6mVS7LvK89N3pN3dgI2UX6DvTYSVNZQUlkrRaFxXlYRcK89avUksPiOqztTADWh+GrHFpFBu2xsRQkZF60DUWIB0toqJ5v1MJQjIVEyiWioMcyKnyOYU5IG9gyGagA8tNYwa4hRiMhRaEjccozYO9rND+QicZlsf/IyBFEypM5yztIuvdA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a713936-9dbb-4395-a79d-08d757d98e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 16:53:39.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkE2ZWcteOaAaQ6DeBCRF5O0v8i9t2o+CO4C6br7sHCyWNL6vVZxvlxOs2lYCBTvilUP5MJAFPrtPujlNGbH+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3431
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571849624; bh=hi4XzK4tXAVJrLhIawWrtrXOktjCNc2063/Z7qAaP0k=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-purlcount:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=W+QxxVkRpIwbtpmz+NlrhB1D4gPBm8N+3y6Az7HCX2lBDvCme32gQ0ssfzkF9qISI
         m4hqHrq6AWdIOcesBqkoB6H1J4ZoyHSi3/DPELrtH9LNA788YUPDOAF+cvbZqetyaK
         BGJWDJiwLK/xf1GsBw54cPLg2SgEhNdk9mPX4w4pUK/6rHd5KdRct2mjY4QJ5ksnjW
         g3cUxSg37mIECR8diy4TBLMm1eWcCc5nkyY+NbELUym27DaXkDWtPp0b+fHJHX5C+B
         KdJoStaUuSXAluX0dyjPW84FCTkK2rMUAAKm8USekED4WXQmnu8F2GCdVr1lN/Dtgq
         db4ibDshWCGwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=3Df=
or-joerg/arm-smmu/updates

Thanks Will! Let me rebase my patches on top of this branch and send it out=
.

-KR

