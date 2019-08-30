Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A042FC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638C623427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IwAsu7mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfH3TAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:00:11 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7233 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfH3TAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:00:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6972380004>; Fri, 30 Aug 2019 12:00:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 30 Aug 2019 12:00:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 30 Aug 2019 12:00:08 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Aug
 2019 19:00:08 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Aug 2019 19:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwpTExgUkknHDlbQRc3kHV4Qk/2l8SxYiPL20LkTxLt02MpkR0sQrCtI+LJlj2euthn9wq/o6n3aRqbcqdrPERWa4Y8smmwiS5jU/7pX5w7UmpqrzlNWFdywnPh44kj4YfbgY9x7FO3P7WemZefMosUTP0kloMBQeK8dFCCC8BYJGQYow7pyDh8LZONccxRrjJl4oJQ1n+UfLeysmbBTYy8UftGgXQFI7qSDz9/oCGQXHlrmQVB0CnVG/Uzy963A8brwE0kGPyqwj2Y13xcg50dwuwvbILTHS37XkPsLbyeuLV8ypI3z6fcGLfZF7w5oiaP6cTzpeLt1zBAf8/adKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhBJyUeeBMWlb5MwS/4aa5ADzd8lFV3Wa8GKZs9whsY=;
 b=P2XfL3aXaKsAbJt9xZIsWQA9nDEGoKpTPsow5MAbGjqvok/Xugt9ZWsrkCV4VOW8CIGDvNslSnXbGKvQQaX9D5LltTnoyEhFUcZnyPTfyKRQ+OIYK8EAnJl5eBZryJ7z4MMWr3ZZH6K4ZkeGC8EipVjK7FcOEXjed5wcv9/ErRR+Tt4iF4V750dRGsyJ4wB6A70fRMm60MgszwIQN8eTlQBJRXzKhdE03HnBVPaCdfRmrV7K5vZxZNcmkw70crcDbmJkBvfUI2eJ3lm5r9ynZ40tmUPiUEl8YTAKcoGPhjOe6aWMEUh/2ODdan5x7stXGDF//SovITJ0cvDo6MSuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB3128.namprd12.prod.outlook.com (20.178.54.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Fri, 30 Aug 2019 19:00:05 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56%6]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 19:00:05 +0000
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
Subject: RE: [PATCH 3/7] iommu/arm-smmu: Add tlb_sync implementation hook
Thread-Topic: [PATCH 3/7] iommu/arm-smmu: Add tlb_sync implementation hook
Thread-Index: AQHVXruLTOWAUKMP0EGEhzK6CNK386cTissAgACAtPA=
Date:   Fri, 30 Aug 2019 19:00:05 +0000
Message-ID: <BYAPR12MB27106B630A0E1A2A0CBC79D9B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-4-git-send-email-vdumpa@nvidia.com>
 <20190830111446.GC23902@ulmo>
In-Reply-To: <20190830111446.GC23902@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-30T19:00:00.9073949Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=0fb73aaa-99c5-444c-8088-3fc4ea15b944;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8cd9ed4-a895-46a1-eb13-08d72d7c4533
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3128;
x-ms-traffictypediagnostic: BYAPR12MB3128:|BYAPR12MB3128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB312833BB4AFDCB3B576B2292B3BD0@BYAPR12MB3128.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(52314003)(11346002)(66066001)(446003)(476003)(256004)(71190400001)(71200400001)(14454004)(26005)(102836004)(6506007)(6916009)(186003)(74316002)(3846002)(76176011)(478600001)(8936002)(7736002)(305945005)(6116002)(6436002)(486006)(54906003)(99286004)(316002)(86362001)(66476007)(66946007)(81166006)(7696005)(76116006)(81156014)(33656002)(5660300002)(64756008)(66446008)(53936002)(4744005)(66556008)(4326008)(9686003)(55016002)(52536014)(25786009)(229853002)(6246003)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3128;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PDr+Sli4zRyUzDC5kHHZmyZd3GdMJWSSu2OPqYlDB7PEDZT8P0Y1U4jllh5eN7IrvovDdM/QvUY1CkxhgCe9ReQY/ku+XdSpSLQ+ai7MyrmyTm8IScV1CxynhHlyw4DFaLlwMjrj0DD8WBQeBmx9lbBg9ihKolP4c9K5ExQKdAh+rRXbeVHAK7n58LZ2tGFe+OvxTt16N08WDCHrLdNIt91FFxAPE1eHooiX1LScZpfryiW7gbQJgag26aCWY0VLfKTGvb5HiPwlFX3HJ227u58dnEud+Bz5dKyo7EmY/q5/O3TXcx5Ui2TZUpq5KhzL/uNfYr9ZO2aq1Ln7WKvolYeSWQgzK7XMstQ7M8XpZq4aBzcFql0WQevfz3ycEnzqYmUVx2TZKZIfLh8Xw4KwU+b2ChF9f4Nreb9ZyU0uV10=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cd9ed4-a895-46a1-eb13-08d72d7c4533
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 19:00:05.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJtRLGLcAHmAphaiEH0+da2Iqk91PAUb97h3+KBCT7OEvXBEj98jcMuwsU+DWzEAp+BLNCEjK18Ej14P2hG9UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3128
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567191609; bh=zhBJyUeeBMWlb5MwS/4aa5ADzd8lFV3Wa8GKZs9whsY=;
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
        b=IwAsu7mf9ASt1Rv5AP7niQoslQdfFlFxjtE3Ud6sT8RaED1zn+CtfVLvT0fbtee9F
         XkuQPsLw6O41UPyCmyYUTyHKrWkcMlEp/+AOI0M4b2PjDlAOZPP3F+WT4XcxN6m5YN
         RCbBBdFx3bBc/wq8LR6Dbhu2h49BBsIYvMTlWjI/B9LO/HssalUn927ZcramPlgmjh
         rivyNI+uQJcHQxRy/dTRk8RrzALwc94OqKaTzMyrlvV5qQDKZfo0EwwuKeaN/h5nc4
         BlCQZKOYfdcrsv8clfPAtTgp095fWvRUbRNHpDwejp3qmR8N16bbomm59rj0QqPATG
         HTfepYYbPfu6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Wouldn't it work if you replaced all calls of __arm_smmu_tlb_sync() by
>smmu->impl->tlb_sync() and assign __arm_smmu_tlb_sync() as default for
>devices that don't need to override it? That makes this patch slightly lar=
ger, but it saves us one level of indirection.

The tlb_ops->tlb_sync can be overridden directly in arm-smmu-nvidia.c speci=
fic implementation as pointed by Robin. Will be updating in next patch.


>> +	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
>> +			 int status);

>Can't page, sync and status all be unsigned?

This is to be uniform with original tlb_sync definition is arm-smmu.c.  Any=
way, this hook is not necessary as tlb_ops->tlb_sync can be overridden dire=
ctly.

-KR
