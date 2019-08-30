Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DB1C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CBF23429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WcOLvSMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfH3TQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:16:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11961 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3TQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:16:38 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6976160000>; Fri, 30 Aug 2019 12:16:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 30 Aug 2019 12:16:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 30 Aug 2019 12:16:36 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Aug
 2019 19:16:35 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Aug
 2019 19:16:35 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.59) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Aug 2019 19:16:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeB4m000gAjz/ktlxPOG1uen7E+OHOM6LixyjGfwfWuCzD71aQt6BQufODqbtPn2Zawo32ZjTptaV5PVFAMJUQr26hWErf7hGbqspZYSZ9BzadrLS0ApLd4aTQ76fyJoxI7570OgZFhXV+ZYk6a1ZWfLSC8CfFXXFv9R5MHmICRe7LI7GxksKDqMRLKpwuQWGWQ/AlZjtYeMbtwvWfM5s2+vhCETpGgN+YS9MnReem+r8FUwPHvSX+wre+0qZQrCMQ02e70iyn8Fa17WK2lg9wAkK9vaeXp2X5IkgdQqUS6sc94kfwwZa0/dDklgpMT8/u0fErvQ/0b2E1/SV3u87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqFbOfHlHxl+PHSSdHh256Wvxcc8/fJG63tSzVGI4p0=;
 b=SLuZRwIYWJQ2+iHxhRdpQUZ/Ifd4PZ0zcDJitOUL00A/qVU31y50L/gJj97rw0ZJ6fR6a5KBpfwqTwP19urdun9H1c9WfLD+Q5N7K1AZ249cP1C+sarGawed+OPcOf0oZDAhJ0TN2naRFdMWll9fsUKKXkuZW5liOKzVDBDFtJck+lhnhg4G1njIwtbsKxF0WQtDRSHcWLzKpycXp9BPh/PCHVmkFk4WR5zFTg66w1Yq9r0NSun30jUc37WzsGZnrtTYOnyYx543DK4psBbOYjVoUaoPr5EdvBM8Gj1KXFLpexpS9ZyikqVlViJ0fNOjcCL65CLOevfkA9psMfv1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB3302.namprd12.prod.outlook.com (20.179.93.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 30 Aug 2019 19:16:34 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56%6]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 19:16:34 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        "Yu-Huan Hsu" <YHsu@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        "Thomas Zeng (SW-TEGRA)" <thomasz@nvidia.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Juha Tukkinen <jtukkinen@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH 4/7] iommu/arm-smmu: Add global/context fault
 implementation hooks
Thread-Topic: [PATCH 4/7] iommu/arm-smmu: Add global/context fault
 implementation hooks
Thread-Index: AQHVXruKZbtcs6ei/UWKtdObCjFLnacTi3OAgACDQrA=
Date:   Fri, 30 Aug 2019 19:16:34 +0000
Message-ID: <BYAPR12MB27106FD6B6CC9E148B65EC00B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-5-git-send-email-vdumpa@nvidia.com>
 <20190830111707.GD23902@ulmo>
In-Reply-To: <20190830111707.GD23902@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-30T19:16:31.2138242Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=b0a80692-08dd-4053-81e6-c9ad30e09d0b;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd8bd4a6-5fda-49f7-3e61-08d72d7e9285
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3302;
x-ms-traffictypediagnostic: BYAPR12MB3302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB33025AA63FDB763F7AB8BCDEB3BD0@BYAPR12MB3302.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(366004)(396003)(346002)(189003)(199004)(7736002)(5660300002)(66476007)(6116002)(2906002)(54906003)(86362001)(9686003)(14454004)(4326008)(4744005)(66066001)(71190400001)(25786009)(476003)(71200400001)(316002)(478600001)(6916009)(256004)(53936002)(33656002)(14444005)(81166006)(6246003)(76116006)(446003)(7696005)(186003)(99286004)(55016002)(66946007)(6436002)(66446008)(102836004)(229853002)(64756008)(8936002)(76176011)(8676002)(3846002)(52536014)(6506007)(11346002)(486006)(305945005)(74316002)(81156014)(26005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3302;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hThOQPOD4UyBBJDssS49O8vPXdX/+3YtkJW0M/AEFvuna3eei0/SSWzR+Y3Y6n9xta8K58e4UT3oF/7lEKPoy2SrzkiJVIREHvgkPBUmi3vU3xqwEsx6qBJs8proKyXkm2SDLOGto0iO6KG+pzd0YccRnrRUI2sQzhg6vW7TUOe9AGKQsguGNeM+9VWQgXkNQaKG4gJKSOpGMYH/X+SotWh7sIJB6ITsvVDuamdNaU8HAx0t1FCCk0WNJOEi5ddfJkamfCiGjlknqdr71l/LZTPUAGlR1OdsggcyyAQlVOhXU9oEt6ArUGJqVHm3B2MFRrvz30jV98S4rkKQ6VxDiuFPlAwIoyfH6uuFx5DY0XiOkNEfSuF3mXIFN9U0ye2KC2ooBNiHQcQDB2uuQYLoxmABRocC8NWnDEwjHx0zJFI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8bd4a6-5fda-49f7-3e61-08d72d7e9285
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 19:16:34.1580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ua89oU9l2jLakWNC86UDmgNC2QsrinsJJdMFzYabhIc1RA/fqeDWmahRTxGjr/dz7uTqBBX38ZeR54Pyh3Ctkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3302
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567192598; bh=UqFbOfHlHxl+PHSSdHh256Wvxcc8/fJG63tSzVGI4p0=;
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
        b=WcOLvSMP/HN4EkQuZ5sh/9j2Cz12E6x5uQxWqWsq0CtUfrk/4lECssd/b78fndLy0
         DWhyXOdYxXhonEyJ7GRMKY5xYzw5/kT/FPvd8eyf75VH/aOXvFKoiEig84IMQ4xpCW
         0I0C2P0R5hFBiGG95RrCQJWiIxoLn8ExuTKa7MmWLDqlPwWsKDZ6zlIXomoPeKBef4
         YewkKMgBI1TjDjzTax0eOsi+9QVAlr5gJk5rV6bUcFmxMDtICE0LWdP2VjMUPjfvwA
         MrXWQyJN5y34nYM/16mbgKzmI+lO99KqzuLAuY9qE8LfPW45sh1FM0sSYHLF1OyyjQ
         STnf4FY0pbn6w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static irqreturn_t nsmmu_context_fault_inst(int irq,
>> +					    struct arm_smmu_device *smmu,
>> +					    int idx, int inst);

>More of these signed integers that could be unsigned. Also why the need to=
 predeclare this? Can you not just put the definition of the function up he=
re?

The singed integers are based on original function prototype from arm-smmu.=
c.  inst can be updated to unsigned.
This is because I was checking context faults from global fault handler as =
well.  This can avoided by using interrupt lines of all the instances acros=
s global and context irq entries.  Let me update.
=20
> +	if (smmu->impl->global_fault)
> +		return smmu->impl->global_fault(irq, smmu);
>>... and here about the extra level of indirection.

Fixing in next version.

-KR

