Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D1FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C81206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Vajw0Xpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfG2KFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:05:40 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:7908
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfG2KFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:05:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNFU91FKOOap94HeSdysxk6zKHQmBXaLHg38tx+C4yXV/t9ZGE/UzlSIc4hr3bWSOTz7m+MeUUDRLDfOrt1gdGsp5AN5L4FIJ7oGMXEA670rw+V0DL1iZ0q1wJbO/VPyUkK/xavo5YUj33L4Yl3ZIhvT4lskL8tGCYjPI8xnMJzbpmsK/ULXZg+6UsiL7B2YjXzipN/YL6zODLgsRuStObElNNQpbztCoojrTij5jmEw+i7VGqAzZ2zBeHkyoy1hd5Hbz/8yfJWWCC+2kDTsoL3ys5z72HNtUgW8ZhoVVogv6a855uNqRGARVUq7AvmvNRuTo+DSPLgwiXP65NE9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLTNMBLnkkinvXCOiYzWj7Gydxy53mxl3gYwInIdyAo=;
 b=L5iJ81ThjwuwEvKnT3pnRPmv9aUFidtBQzsnLoQ/IATJ6wMqh0yEsIy/AGt8rNfO6MJfXCS2BUKH0lpzowXPxhBqxaqTq7t0DtZMR97HCJEmeo4vJv1NGSrkiOoRyTplswQjClmzw/1mt1e0Xq9QmzB1eZZ2EECHAb90EHuHcN+yCnQzeoDvY9xVJp+G63S1bQgq3hz8MAFDbFoJOA0LS+5xQqSN8P1wr+SFtvKIMPRXEYgSxbu/kWw2D4NElKoYiKxujd4lMIImrCdg3/2fW/8XdtFcCuAkzUCZEuRrbcqI47/BV36McSYoiAhA0L7kOVqweEJknghQtr0nvm1WnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLTNMBLnkkinvXCOiYzWj7Gydxy53mxl3gYwInIdyAo=;
 b=Vajw0Xprqv8CvX1j7VIvib8nKQI33jOM8fqPsQ1nBqkUtL2kKPkON7AGrEXJy6sGj3iIGPCPlluM+jIZzH/ejWu08Djvrhoj1e0NEPhm6AnxyLIU9CgAJo3AaXHya2hpyHTaweeZKMxyRoilKQ3lEaVd9c4rsmkcBlpytUlrsAo=
Received: from VI1PR05MB5295.eurprd05.prod.outlook.com (20.178.12.80) by
 VI1PR05MB6750.eurprd05.prod.outlook.com (10.186.162.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Mon, 29 Jul 2019 10:05:29 +0000
Received: from VI1PR05MB5295.eurprd05.prod.outlook.com
 ([fe80::ec21:2019:cb6f:44ae]) by VI1PR05MB5295.eurprd05.prod.outlook.com
 ([fe80::ec21:2019:cb6f:44ae%7]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 10:05:29 +0000
From:   Vlad Buslov <vladbu@mellanox.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
CC:     Vlad Buslov <vladbu@mellanox.com>, Joerg Roedel <jroedel@suse.de>,
        Maor Gottlieb <maorg@mellanox.com>,
        Ran Rozenstein <ranro@mellanox.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Failure to recreate virtual functions
Thread-Topic: Failure to recreate virtual functions
Thread-Index: AQHVQ89+orWUWzIuXEaLp1PfOC9kjabdupoAgAOm2YA=
Date:   Mon, 29 Jul 2019 10:05:29 +0000
Message-ID: <vbfzhkx9n32.fsf@mellanox.com>
References: <vbf8sskwyiv.fsf@mellanox.com>
 <d4166595-ec4a-fc4a-3b5f-463b79c42936@linux.intel.com>
In-Reply-To: <d4166595-ec4a-fc4a-3b5f-463b79c42936@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0314.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::14) To VI1PR05MB5295.eurprd05.prod.outlook.com
 (2603:10a6:803:b1::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.13.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 107dfd6b-aa63-4488-90f2-08d7140c4907
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6750;
x-ms-traffictypediagnostic: VI1PR05MB6750:
x-microsoft-antispam-prvs: <VI1PR05MB675016FF1672125A95B62FD3ADDD0@VI1PR05MB6750.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(54906003)(66066001)(6506007)(386003)(53546011)(76176011)(5660300002)(14454004)(102836004)(186003)(26005)(316002)(25786009)(99286004)(229853002)(81156014)(81166006)(8676002)(8936002)(52116002)(6116002)(3846002)(7736002)(2906002)(4326008)(36756003)(6916009)(6486002)(86362001)(6512007)(476003)(6436002)(256004)(2616005)(6246003)(66946007)(66476007)(66556008)(53936002)(14444005)(71190400001)(66446008)(64756008)(486006)(478600001)(71200400001)(68736007)(446003)(11346002)(305945005)(5024004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6750;H:VI1PR05MB5295.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kHjsQgA3Zxbdy9I4bxu1RJXlqfm1pF/tIoOSvX0B24+PPnZLeol16TJzNt+QaoAkIAEdYXr7wbxKXSuSecElghnM+M0jUqSsEUDO94pynPFG01ngm144pVAE23GOJ/NWLS5BtG5Gxb4bXNctQDJRJ7xKcoki4lwtooOjan3ca4ca9VQHtCdKrOJMKyn0MIJnh6DnNmBBwa0AGZ9YcwCJ2eZFVL2Afac/HBXikMItFGkVOLm9pOym2RMFUgo2DJcpeE1cNKK+FAYwfmO/N634abk2EMeSuPT0VEMLBDkK6tyBAN6dUrob3BEYbdgvDz2MKx7DUgUVwQxWkMfvJdmWYLRE1X4xGsV7Q9/XHwL8p3IpCpocGRe6WOezsSuN7gSCG+uynVDdcYdgIBLg/MM1leAIWMlBh8qv3zOlaguo/kE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107dfd6b-aa63-4488-90f2-08d7140c4907
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 10:05:29.5269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vladbu@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 27 Jul 2019 at 05:15, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> Hi Vilad,
>
> On 7/27/19 12:30 AM, Vlad Buslov wrote:
>> Hi Lu Baolu,
>>
>> Our mlx5 driver fails to recreate VFs when cmdline includes
>> "intel_iommu=3Don iommu=3Dpt" after recent merge of patch set "iommu/vt-=
d:
>> Delegate DMA domain to generic iommu". I've bisected the failure to
>> patch b7297783c2bb ("iommu/vt-d: Remove duplicated code for device
>> hotplug"). Here is the dmesg log for following case: enable switchdev
>> mode, set number of VFs to 0, then set it back to any value
>>> 0.
>>
>> [  223.525282] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: =
nvfs(2) mode (1)
>> [  223.562027] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active v=
ports(3)
>> [  223.663766] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
>> [  223.663864] pci 0000:81:00.2: enabling Extended Tags
>> [  223.665143] pci 0000:81:00.2: Adding to iommu group 52
>> [  223.665215] pci 0000:81:00.2: Using iommu direct mapping
>> [  223.665771] mlx5_core 0000:81:00.2: enabling device (0000 -> 0002)
>> [  223.665890] mlx5_core 0000:81:00.2: firmware version: 16.26.148
>> [  223.889908] mlx5_core 0000:81:00.2: Rate limit: 127 rates are support=
ed, range: 0Mbps to 97656Mbps
>> [  223.896438] mlx5_core 0000:81:00.2: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  223.896636] mlx5_core 0000:81:00.2: Assigned random MAC address 56:1f=
:95:e0:51:d6
>> [  224.012905] mlx5_core 0000:81:00.2 ens1f0v0: renamed from eth0
>> [  224.041651] pci 0000:81:00.3: [15b3:101a] type 00 class 0x020000
>> [  224.041711] pci 0000:81:00.3: enabling Extended Tags
>> [  224.043660] pci 0000:81:00.3: Adding to iommu group 53
>> [  224.043738] pci 0000:81:00.3: Using iommu direct mapping
>> [  224.044196] mlx5_core 0000:81:00.3: enabling device (0000 -> 0002)
>> [  224.044298] mlx5_core 0000:81:00.3: firmware version: 16.26.148
>> [  224.268099] mlx5_core 0000:81:00.3: Rate limit: 127 rates are support=
ed, range: 0Mbps to 97656Mbps
>> [  224.274983] mlx5_core 0000:81:00.3: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  224.275195] mlx5_core 0000:81:00.3: Assigned random MAC address a6:1e=
:56:0a:d9:f2
>> [  224.388359] mlx5_core 0000:81:00.3 ens1f0v1: renamed from eth0
>> [  236.325027] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: active v=
ports(3) mode(1)
>> [  236.362766] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: =
nvfs(2) mode (2)
>> [  237.290066] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  237.350215] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  237.373052] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
>> [  237.390768] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  237.447846] ens1f0_0: renamed from eth0
>> [  237.460399] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active v=
ports(3)
>> [  237.526880] ens1f0_1: renamed from eth1
>> [  248.953873] pci 0000:81:00.2: Removing from iommu group 52
>> [  248.954114] pci 0000:81:00.3: Removing from iommu group 53
>> [  249.960570] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: active v=
ports(3) mode(2)
>> [  250.319135] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  250.559431] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
>> [  258.819162] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: =
nvfs(2) mode (1)
>> [  258.831625] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active v=
ports(3)
>> [  258.936160] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
>> [  258.936258] pci 0000:81:00.2: enabling Extended Tags
>> [  258.937438] pci 0000:81:00.2: Failed to add to iommu group 52: -16
>
> It seems that an EBUSY error returned from iommu_group_add_device(). Can
> you please hack some debug messages in iommu_group_add_device() so that
> we can know where the EBUSY returns?
>
> Best regards,
> Baolu

The error code is returned by __iommu_attach_device().

>
>
>> [  258.938053] mlx5_core 0000:81:00.2: enabling device (0000 -> 0002)
>> [  258.938196] mlx5_core 0000:81:00.2: firmware version: 16.26.148
>> [  258.938229] mlx5_core 0000:81:00.2: mlx5_function_setup:923:(pid 265)=
: Failed initializing command interface, aborting
>> [  258.938315] mlx5_core 0000:81:00.2: init_one:1308:(pid 265): mlx5_loa=
d_one failed with error code -12
>> [  258.938540] mlx5_core: probe of 0000:81:00.2 failed with error -12
>> [  258.938597] pci 0000:81:00.3: [15b3:101a] type 00 class 0x020000
>> [  258.938657] pci 0000:81:00.3: enabling Extended Tags
>> [  258.939431] pci 0000:81:00.3: Failed to add to iommu group 52: -16
>> [  258.939928] mlx5_core 0000:81:00.3: enabling device (0000 -> 0002)
>> [  258.940039] mlx5_core 0000:81:00.3: firmware version: 16.26.148
>> [  258.940071] mlx5_core 0000:81:00.3: mlx5_function_setup:923:(pid 265)=
: Failed initializing command interface, aborting
>> [  258.940158] mlx5_core 0000:81:00.3: init_one:1308:(pid 265): mlx5_loa=
d_one failed with error code -12
>> [  258.940400] mlx5_core: probe of 0000:81:00.3 failed with error -12
>>
>>
>> On previous patch 0e31a7266508 ("iommu/vt-d: Remove startup parameter
>> from device_def_domain_type()") in the series same sequence of actions
>> doesn't trigger any iommu errors:
>>
>> [  164.252254] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: =
nvfs(2) mode (1)
>> [  164.288724] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active v=
ports(3)
>> [  164.394839] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
>> [  164.394938] pci 0000:81:00.2: enabling Extended Tags
>> [  164.396087] pci 0000:81:00.2: Adding to iommu group 52
>> [  164.396154] pci 0000:81:00.2: Using iommu direct mapping
>> [  164.396679] mlx5_core 0000:81:00.2: enabling device (0000 -> 0002)
>> [  164.396803] mlx5_core 0000:81:00.2: firmware version: 16.26.148
>> [  164.619320] mlx5_core 0000:81:00.2: Rate limit: 127 rates are support=
ed, range: 0Mbps to 97656Mbps
>> [  164.625754] mlx5_core 0000:81:00.2: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  164.625922] mlx5_core 0000:81:00.2: Assigned random MAC address 5e:1e=
:9b:ca:c8:e5
>> [  164.739694] mlx5_core 0000:81:00.2 ens1f0v0: renamed from eth0
>> [  164.774637] pci 0000:81:00.3: [15b3:101a] type 00 class 0x020000
>> [  164.774709] pci 0000:81:00.3: enabling Extended Tags
>> [  164.775816] pci 0000:81:00.3: Adding to iommu group 53
>> [  164.775886] pci 0000:81:00.3: Using iommu direct mapping
>> [  164.776610] mlx5_core 0000:81:00.3: enabling device (0000 -> 0002)
>> [  164.776734] mlx5_core 0000:81:00.3: firmware version: 16.26.148
>> [  164.999360] mlx5_core 0000:81:00.3: Rate limit: 127 rates are support=
ed, range: 0Mbps to 97656Mbps
>> [  165.007118] mlx5_core 0000:81:00.3: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  165.007327] mlx5_core 0000:81:00.3: Assigned random MAC address 82:4a=
:7a:5f:81:55
>> [  165.123927] mlx5_core 0000:81:00.3 ens1f0v1: renamed from eth0
>> [  172.063665] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: active v=
ports(3) mode(1)
>> [  172.103306] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: =
nvfs(2) mode (2)
>> [  173.033033] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  173.091605] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  173.129258] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
>> [  173.129863] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  173.203879] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active v=
ports(3)
>> [  173.204002] ens1f0_0: renamed from eth1
>> [  173.289454] ens1f0_1: renamed from eth0
>> [  186.720692] pci 0000:81:00.2: Removing from iommu group 52
>> [  186.720994] pci 0000:81:00.3: Removing from iommu group 53
>> [  187.771549] mlx5_core 0000:81:00.0: E-Switch: disable SRIOV: active v=
ports(3) mode(2)
>> [  188.141758] mlx5_core 0000:81:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  188.394072] mlx5_core 0000:81:00.0 ens1f0: renamed from eth0
>> [  191.116400] mlx5_core 0000:81:00.0: E-Switch: E-Switch enable SRIOV: =
nvfs(2) mode (1)
>> [  191.128965] mlx5_core 0000:81:00.0: E-Switch: SRIOV enabled: active v=
ports(3)
>> [  191.235151] pci 0000:81:00.2: [15b3:101a] type 00 class 0x020000
>> [  191.235250] pci 0000:81:00.2: enabling Extended Tags
>> [  191.236463] pci 0000:81:00.2: Adding to iommu group 52
>> [  191.236531] pci 0000:81:00.2: Using iommu direct mapping
>> [  191.237037] mlx5_core 0000:81:00.2: enabling device (0000 -> 0002)
>> [  191.237161] mlx5_core 0000:81:00.2: firmware version: 16.26.148
>> [  191.457369] mlx5_core 0000:81:00.2: Rate limit: 127 rates are support=
ed, range: 0Mbps to 97656Mbps
>> [  191.463355] mlx5_core 0000:81:00.2: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  191.463509] mlx5_core 0000:81:00.2: Assigned random MAC address e6:f2=
:0c:b4:e3:2e
>> [  191.572884] mlx5_core 0000:81:00.2 ens1f0v0: renamed from eth0
>> [  191.608592] pci 0000:81:00.3: [15b3:101a] type 00 class 0x020000
>> [  191.608664] pci 0000:81:00.3: enabling Extended Tags
>> [  191.609434] pci 0000:81:00.3: Adding to iommu group 53
>> [  191.609466] pci 0000:81:00.3: Using iommu direct mapping
>> [  191.609760] mlx5_core 0000:81:00.3: enabling device (0000 -> 0002)
>> [  191.609862] mlx5_core 0000:81:00.3: firmware version: 16.26.148
>> [  191.826324] mlx5_core 0000:81:00.3: Rate limit: 127 rates are support=
ed, range: 0Mbps to 97656Mbps
>> [  191.832558] mlx5_core 0000:81:00.3: MLX5E: StrdRq(1) RqSz(8) StrdSz(2=
048) RxCqeCmprss(0)
>> [  191.832730] mlx5_core 0000:81:00.3: Assigned random MAC address a2:dc=
:76:30:18:6c
>> [  191.949625] mlx5_core 0000:81:00.3 ens1f0v1: renamed from eth0
>>
>> Thanks,
>> Vlad
>>

