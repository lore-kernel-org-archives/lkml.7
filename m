Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB20C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD6C208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Z/qYdCij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfGaLTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:19:51 -0400
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:63548
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbfGaLTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:19:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqcnwNQWbjFrpO3/BIAJtqPBfZMu8IQY2dUTkUspqx/mbpuY9FMo1SrdlMJpI+UXeNTLvsp8rLf8k0J2Yu1u2at15scQxq+fBlQs6chuj3HdihpKshgbu4NDn9LZ58pGG7BFr6oD1qnckhynvYcyjDh6JesFsQeIkhJnR4+vvcgJFy7hwkVsR2xPl53HEDW5M8NmYliggZeLKWQBJ/yP65Cp7bbLfp/c5S0vFesdzFXEjUsC6G1ot6zKaKZ4ACtpAHhp/K0LjfidPZOYGuOFiyp2DzVuQPUa/yCz+eoaCqaQGdCH+xijI5EjAIFBMQ1K9XWXFjPwtLPRC7dSrGZHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDIYGYXnjQCcuaEqk/dTvdrPpQz3tFsU1BjsDE28lC4=;
 b=Bq9afRPndJP44I32D1CLPta9+6VraSGqsAnWgicPA3fcBjBbDubYZoYonCGgXaHlqpzql3vJ10uY2uDfVmWsF1UmKYyk9iJoAxB5ByDb3k3ddzLvXqODxreufzundvWOl0xNRMNpU4LPwdYI1HdPUxXKrGBsAmxEzm4RgKINYZgL5PW+yI98W+Uy7H8ExGQq5lUV6CggLCOS6RgJDq+TTKAeqK4O83Ti3FfZOZOHTBrUuZNsk/pd6s2R4HLOVWnu5V9B4sUEJa2U2Qu9Ih0tV3fnk9ugMIT1z7l4nMDB/ypCLYoDhZ7XvH5uggOGpL++XyeSjW50Mywb1SBOFFbVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDIYGYXnjQCcuaEqk/dTvdrPpQz3tFsU1BjsDE28lC4=;
 b=Z/qYdCijbKlRX9spFcZ/jqeeQvfwmbv+OpxmssKsZD5/gAER67dcWvt3Uy9bhnHOCbtPCcgm9rba56ngT0qxSD+7hz3JQonua68lNPeJnc4bdz7yrNO5BVesnCQ7Qr6yBSsDWrLmVhV+XFo3yjisLUdZLxy+CQMxgTV9FAPPld8=
Received: from VI1PR05MB5295.eurprd05.prod.outlook.com (20.178.12.80) by
 VI1PR05MB5869.eurprd05.prod.outlook.com (20.178.125.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 11:19:41 +0000
Received: from VI1PR05MB5295.eurprd05.prod.outlook.com
 ([fe80::ec21:2019:cb6f:44ae]) by VI1PR05MB5295.eurprd05.prod.outlook.com
 ([fe80::ec21:2019:cb6f:44ae%7]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 11:19:41 +0000
From:   Vlad Buslov <vladbu@mellanox.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ran Rozenstein <ranro@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: Failure to recreate virtual functions
Thread-Topic: Failure to recreate virtual functions
Thread-Index: AQHVQ89+orWUWzIuXEaLp1PfOC9kjabdupoAgAOm2YCAATVtAIAAc6GAgAFRTwCAAEA+AA==
Date:   Wed, 31 Jul 2019 11:19:41 +0000
Message-ID: <vbf36imsb79.fsf@mellanox.com>
References: <vbf8sskwyiv.fsf@mellanox.com>
 <d4166595-ec4a-fc4a-3b5f-463b79c42936@linux.intel.com>
 <vbfzhkx9n32.fsf@mellanox.com>
 <838a00c4-d5bd-08db-e39c-5f00686858b5@linux.intel.com>
 <6ece232e-3fe8-4bd9-cd4b-c8d90a106a30@arm.com>
 <abba9e2b-4bd4-bca5-dd50-05ca9ad96d1f@linux.intel.com>
In-Reply-To: <abba9e2b-4bd4-bca5-dd50-05ca9ad96d1f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::26) To VI1PR05MB5295.eurprd05.prod.outlook.com
 (2603:10a6:803:b1::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.13.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dde54c2-ab07-4594-ecb0-08d715a8fb9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5869;
x-ms-traffictypediagnostic: VI1PR05MB5869:
x-microsoft-antispam-prvs: <VI1PR05MB5869F3F8A95606F14E02C328ADDF0@VI1PR05MB5869.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(199004)(189003)(316002)(86362001)(6512007)(54906003)(7736002)(53936002)(66066001)(81156014)(81166006)(8676002)(8936002)(2906002)(6916009)(6486002)(229853002)(53546011)(6506007)(386003)(76176011)(102836004)(52116002)(14454004)(26005)(186003)(68736007)(6436002)(99286004)(66946007)(64756008)(66446008)(66476007)(66556008)(2616005)(446003)(11346002)(476003)(305945005)(5660300002)(71190400001)(71200400001)(5024004)(486006)(256004)(14444005)(478600001)(36756003)(3846002)(4326008)(6246003)(6116002)(25786009)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5869;H:VI1PR05MB5295.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o0dcHN5V7yEcwtpG8VG1bfh8llfLVKkz4Pi1wyLUHN86VkyjTAFnMvxaWy5UG2MgFhLPE3hqAhJzt1Oq7iUPmFKeaSOgsghhgHO/eAzn4S7hK9doF7cNiIn2ljKtJlrjuoJmAYXazFC1Hvt/YQMWYSCUCXat8A1EgEb63Sm+rnPRX/1erIhVm9IOV5WwKiNW/K1e4vKiIq4E96K3kYjCj8DSenMYHnSJVqwEef04YPQVGVerqRHO69PFCqzXyZQOJ9f0j6NglNBfObhe3ZaYUOlUxwNCOVl7+WfSDKsETsO2UJv9ifIz62u10HEy6V76wuvj9EZsu2DUJqUJ/0EEQRkNvCkC4kiJuO1XEWXZ+4U+XgZSNPp1kf1wO097tFxv1d//5IxZ2RtEmPKrxf46CxJFrgbIreQ4mAUKfHTQfYM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dde54c2-ab07-4594-ecb0-08d715a8fb9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 11:19:41.7633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vladbu@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5869
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 31 Jul 2019 at 10:29, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> Hi,
>
> On 7/30/19 7:22 PM, Robin Murphy wrote:
>> On 30/07/2019 05:28, Lu Baolu wrote:
>>> Hi,
>>>
>>> On 7/29/19 6:05 PM, Vlad Buslov wrote:
>>>> On Sat 27 Jul 2019 at 05:15, Lu Baolu<baolu.lu@linux.intel.com>  wrote=
:
>>>>> Hi Vilad,
>>>>>
>>>>> On 7/27/19 12:30 AM, Vlad Buslov wrote:
>>>>>> Hi Lu Baolu,
>>>>>>
>>>>>> Our mlx5 driver fails to recreate VFs when cmdline includes
>>>>>> "intel_iommu=3Don iommu=3Dpt" after recent merge of patch set "iommu=
/vt-d:
>>>>>> Delegate DMA domain to generic iommu". I've bisected the failure to
>>>>>> patch b7297783c2bb ("iommu/vt-d: Remove duplicated code for device
>>>>>> hotplug"). Here is the dmesg log for following case: enable switchde=
v
>>>>>> mode, set number of VFs to 0, then set it back to any value
>>>>>>> 0.
>>>>>> [  223.525282] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRI=
OV:
>>>>>> nvfs(2) mode (1)
>>>>>> [  223.562027] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: acti=
ve
>>>>>> vports(3)
>>>>>> [  223.663766] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
>>>>>> [  223.663864] pci 0000:81:00.2: enabling Extended Tags
>>>>>> [  223.665143] pci 0000:81:00.2: Adding to iommu group 52
>>>>>> [  223.665215] pci 0000:81:00.2: Using iommu direct mapping
>>>>>> [  223.665771] mlx5_core 0000:81:00.2: enabling device (0000 -> 0002=
)
>>>>>> [  223.665890] mlx5_core 0000:81:00.2: firmware version: 16.26.148
>>>>>> [  223.889908] mlx5_core 0000:81:00.2: Rate limit: 127 rates are
>>>>>> supported, range: 0Mbps to 97656Mbps
>>>>>> [  223.896438] mlx5_core 0000:81:00.2: MLX5E: StrdRq(1) RqSz(8)
>>>>>> StrdSz(2048) RxCqeCmprss(0)
>>>>>> [  223.896636] mlx5_core 0000:81:00.2: Assigned random MAC address
>>>>>> 56:1f:95:e0:51:d6
>>>>>> [  224.012905] mlx5_core 0000:81:00.2 ens1f0v0: renamed from eth0
>>>>>> [  224.041651] pci 0000:81:00.3: [15b3:101a] type 00 class 0x020000
>>>>>> [  224.041711] pci 0000:81:00.3: enabling Extended Tags
>>>>>> [  224.043660] pci 0000:81:00.3: Adding to iommu group 53
>>>>>> [  224.043738] pci 0000:81:00.3: Using iommu direct mapping
>>>>>> [  224.044196] mlx5_core 0000:81:00.3: enabling device (0000 -> 0002=
)
>>>>>> [  224.044298] mlx5_core 0000:81:00.3: firmware version: 16.26.148
>>>>>> [  224.268099] mlx5_core 0000:81:00.3: Rate limit: 127 rates are
>>>>>> supported, range: 0Mbps to 97656Mbps
>>>>>> [  224.274983] mlx5_core 0000:81:00.3: MLX5E: StrdRq(1) RqSz(8)
>>>>>> StrdSz(2048) RxCqeCmprss(0)
>>>>>> [  224.275195] mlx5_core 0000:81:00.3: Assigned random MAC address
>>>>>> a6:1e:56:0a:d9:f2
>>>>>> [  224.388359] mlx5_core 0000:81:00.3 ens1f0v1: renamed from eth0
>>>>>> [  236.325027] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: acti=
ve
>>>>>> vports(3) mode(1)
>>>>>> [  236.362766] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRI=
OV:
>>>>>> nvfs(2) mode (2)
>>>>>> [  237.290066] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8)
>>>>>> StrdSz(2048) RxCqeCmprss(0)
>>>>>> [  237.350215] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8)
>>>>>> StrdSz(2048) RxCqeCmprss(0)
>>>>>> [  237.373052] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
>>>>>> [  237.390768] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8)
>>>>>> StrdSz(2048) RxCqeCmprss(0)
>>>>>> [  237.447846] ens1f0_0: renamed from eth0
>>>>>> [  237.460399] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: acti=
ve
>>>>>> vports(3)
>>>>>> [  237.526880] ens1f0_1: renamed from eth1
>>>>>> [  248.953873] pci 0000:81:00.2: Removing from iommu group 52
>>>>>> [  248.954114] pci 0000:81:00.3: Removing from iommu group 53
>>>>>> [  249.960570] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: acti=
ve
>>>>>> vports(3) mode(2)
>>>>>> [  250.319135] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8)
>>>>>> StrdSz(2048) RxCqeCmprss(0)
>>>>>> [  250.559431] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
>>>>>> [  258.819162] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRI=
OV:
>>>>>> nvfs(2) mode (1)
>>>>>> [  258.831625] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: acti=
ve
>>>>>> vports(3)
>>>>>> [  258.936160] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
>>>>>> [  258.936258] pci 0000:81:00.2: enabling Extended Tags
>>>>>> [  258.937438] pci 0000:81:00.2: Failed to add to iommu group 52: -1=
6
>>>>> It seems that an EBUSY error returned from iommu_group_add_device(). =
Can
>>>>> you please hack some debug messages in iommu_group_add_device() so th=
at
>>>>> we can know where the EBUSY returns?
>>>>>
>>>>> Best regards,
>>>>> Baolu
>>>> The error code is returned by __iommu_attach_device().
>>>>
>>>
>>> Thanks!
>>>
>>> It looks like the system has already a domain for specific pci bdf
>>> device. Does this VF share the bdf with other devices? Or has been
>>> previously created, and system failed to get chance to remove it?
>>
>> At a glance, it looks like it might be down to intel_iommu_remove_device=
() not
>> calling dmar_remove_one_dev_info() like the old notifier did. If the gro=
up is
>> getting torn down and recreated, but the driver still has a stale pointe=
r to
>> the old default domain cached, which dmar_insert_one_dev_info() finds an=
d
>> returns, that would seem to explain the observed behaviour.
>
> Yes agreed.
>
> Vlad,
>
> Can you please try below change?
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index baf21001c339..abffc520fe05 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5575,6 +5575,8 @@ static void intel_iommu_remove_device(struct device=
 *dev)
>         if (!iommu)
>                 return;
>
> +       dmar_remove_one_dev_info(dev);
> +
>         iommu_group_remove_device(dev);
>
>         iommu_device_unlink(&iommu->iommu, dev);
>
> Best regards,
> Baolu

Hi Baolu,

This patch fixes the issue for me.

Thanks,
Vlad
