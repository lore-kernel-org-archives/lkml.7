Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55576C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5AD20659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fWMRBa9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfLFI5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:57:40 -0500
Received: from mail-eopbgr770047.outbound.protection.outlook.com ([40.107.77.47]:37966
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfLFI5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:57:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwSJXN7ZHNxjAJG2vLaGDyVZWKrB/4VnWjZ4NO+YCCSxZphaB3+XJYHZSoifsS04c0pHbJMf04tRJ/a84AkaBbQ6DSdeFJFVEroli2WWBxWgYXcM1Uw1D/QLIt8k7ZjrlFKiXRb/jFp5kJaPz/CDDSjM+zXwHTzPmTYs34b74drRrRx1j2Cd0X+lxdzSNHMH9MJI4R/Bk9pwnBuY8d1x4HLPs/O6AFlF7NEVi2Ga17RWGpo9pRJuZ48eg3quwLsa1bHjBWwgZbLG1LidFDrL+JHedr0lbNyegDTA5EQTm70jQmxkT0Sr1eK6lpYuUk086e1pLO26newTuRas+/V37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/0nqTuYCUANJbhSzeEIyHfUKRK+UE0WbrRlVNoplbo=;
 b=BMRJoRfKCQ+LAscK2sIxlOMdKmOrPazbR0iY+ECvC08b1aIJdiTSh/FF9ZCIQzRcPnHeTSHldcVqZmpTSJi/zHbeKEu4wrrTqTiToUzVsHHbq50vfeflFMXAdcT3WnV/ZDTJ2BwxITo1afbJfrUaaLE9nLj78UHAYnOYlf99ev4IDZTH3DEPqZl/B250LaSnJZHsZBW+dUZ3Fb1Xlj+wnBormQSQpxHBbLeASimumN1EXLO8dtU8ZtnsbgpcUVPaCtGYeitgupumt7WjTIhh5C+ynBs7sLURsas2tNKn8tarR4qgOihYRjKUrRACuWASEoCZYZJHhRQEsEALmsJLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/0nqTuYCUANJbhSzeEIyHfUKRK+UE0WbrRlVNoplbo=;
 b=fWMRBa9Trkk6Y/Lk/kAracefyiSq0g1C1eoACPWBXpdkbmiM//IO+cTAZuB+hA1y7iZQ7L2cY3womo5Ozt0Fam3ZtaJfnCWdRtIv2XpQVyLS4lqjdUMGAZCyIVE/g0EZ9iyFOBHgys2FyuGxcWs8zeS7UW47igfPwyGaoHnJA3Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1435.namprd12.prod.outlook.com (10.168.240.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Fri, 6 Dec 2019 08:57:34 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.026; Fri, 6 Dec 2019
 08:57:34 +0000
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Lucas Stach <dev@lynxeye.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <5b2097e8c4172a8516fcfc8c56dc98e3d105ffe2.camel@lynxeye.de>
 <MWHPR12MB1358891F2AC2AAA41E9BA835F7430@MWHPR12MB1358.namprd12.prod.outlook.com>
 <MWHPR12MB135851B49EEDEE17DE873506F75D0@MWHPR12MB1358.namprd12.prod.outlook.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3b61c31f-57bd-1fe6-f2e9-52c24f1eb3e4@amd.com>
Date:   Fri, 6 Dec 2019 09:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MWHPR12MB135851B49EEDEE17DE873506F75D0@MWHPR12MB1358.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:200:89::23) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f70376f-1e69-4869-50df-08d77a2a5585
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:|DM5PR12MB1435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB143543C03DED96EF9FFC3269835F0@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(13464003)(189003)(199004)(36756003)(14454004)(230700001)(2616005)(14444005)(229853002)(6486002)(66476007)(2906002)(478600001)(966005)(66946007)(66556008)(45080400002)(23676004)(11346002)(52116002)(65956001)(31686004)(76176011)(305945005)(99286004)(186003)(8936002)(5660300002)(81156014)(81166006)(6666004)(8676002)(50466002)(6506007)(53546011)(316002)(25786009)(86362001)(6512007)(31696002)(58126008)(4326008)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1435;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKiCJCjhda7OoA5hOLSxYpaRvDGANzEvEEQvLLHPbXzEJdQd2/tf+NP/nKoUTrdGyclNwXODQ8N6+iwfhHdpZ/qJc5CS/Y9mKfg4eWeo4BXSv3OaCvM29Q2qzgiZ5/1OkIX3p3VzrPFeAjH22up08CRiO0EEZgD9bden8UMfoY4n34xh9bZE/btB3JvKWgrKt0FwjqkMyMCwu0lDyt/8QjVFrenSBXgw14R5jvNjAtklojHMTmx86jtnL0KbZYVfKMT/toKDL+JZU9YMGuQ1FWUh8SOTdLU9puMJEFdIhn3Msripwi5Y4IIWFJuFUe4O2JoM1kWOvAfjgnGnD3qmVs5yAm9RUItARVoGQEVO6+ABrDZS6E6biesIjHpL13Nq49WtlEb2dVgEJDcY9EVxjgEo83n47Fw1c3G5+6XYqa9yu6jjY9yU74qQUYSZRSI7y4w47FTHWNH5BeReDTj2CYTaQJAO+JzjOX+CMlQZITSyA2ihWFOLw8z3wLdXHqLH8uVDEfA5Ss5yc1K7ZuBgTa/lN9xXpFpc5kVREtllL2M=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f70376f-1e69-4869-50df-08d77a2a5585
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 08:57:34.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gS4bMWVAsA7C9CoQAzWfzujLaS0CKhAodEoTfQ6MmCsDs9BzaX5yvZNGt41/eVhg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.12.19 um 17:08 schrieb Deucher, Alexander:
>> -----Original Message-----
>> From: Deucher, Alexander
>> Sent: Monday, December 2, 2019 11:37 AM
>> To: Lucas Stach <dev@lynxeye.de>; Kai-Heng Feng
>> <kai.heng.feng@canonical.com>; joro@8bytes.org; Koenig, Christian
>> (Christian.Koenig@amd.com) <Christian.Koenig@amd.com>
>> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>> Subject: RE: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
>> systems
>>
>>> -----Original Message-----
>>> From: Lucas Stach <dev@lynxeye.de>
>>> Sent: Sunday, December 1, 2019 7:43 AM
>>> To: Kai-Heng Feng <kai.heng.feng@canonical.com>; joro@8bytes.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
>>> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
>>> systems
>>>
>>> Am Freitag, den 29.11.2019, 22:21 +0800 schrieb Kai-Heng Feng:
>>>> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
>>>>
>>>> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's
>>>> do the same here to avoid screen flickering on 4K monitor.
>>> This doesn't seem like a good solution, especially if there isn't a
>>> method for the user to opt-out.  Some users might prefer having the
>>> IOMMU support to 4K display output.
>>>
>>> But before using the big hammer of disabling or breaking one of those
>>> features, we should take a look at what's the issue here. Screen
>>> flickering caused by the IOMMU being active hints to the IOMMU not
>>> being able to sustain the translation bandwidth required by the high-
>>> bandwidth isochronous transfers caused by 4K scanout, most likely due
>>> to insufficient TLB space.
>>>
>>> As far as I know the framebuffer memory for the display buffers is
>>> located in stolen RAM, and thus contigous in memory. I don't know the
>>> details of the GPU integration on those APUs, but maybe there even is
>>> a way to bypass the IOMMU for the stolen VRAM regions?
>>>
>>> If there isn't and all GPU traffic passes through the IOMMU when
>>> active, we should check if the stolen RAM is mapped with hugepages on
>>> the IOMMU side. All the stolen RAM can most likely be mapped with a
>>> few hugepage mappings, which should reduce IOMMU TLB demand by a
>> large margin.
>>
>> The is no issue when we scan out of the carve out region.  The issue occurs
>> when we scan out of regular system memory (scatter/gather).  Many newer
>> laptops have very small carve out regions (e.g., 32 MB), so we have to use
>> regular system pages to support multiple high resolution displays.  The
>> problem is, the latency gets too high at some point when the IOMMU is
>> involved.  Huge pages would probably help in this case, but I'm not sure if
>> there is any way to guarantee that we get huge pages for system memory.  I
>> guess we could use CMA or something like that.
> Thomas recently sent out a patch set to add huge page support to ttm:
> https://patchwork.freedesktop.org/series/70090/
> We'd still need a way to guarantee huge pages for the display buffer.

That unfortunately won't help in this case since the TTM work Thomas is 
doing only affects the CPU page tables.

Additional to that we already allocate huge pages for the display buffer 
in a best effort manner and it doesn't seem to help.

If I understood the hardware guys correctly even transparent mode adds 
to much latency so that the display block might run into an underflow.

The only solution documented to work is to either disabling the IOMMU or 
not using scan-out from system memory.

Alex, we should probably kick of another internal discussion with the 
hardware guys about that.

Christian.

>
> Alex
>
>> Alex
>>
>>> Regards,
>>> Lucas
>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Bug:
>>>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
>>>> tl
>>>>
>> ab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F961&amp;data=02%7C01%
>>> 7Calexa
>> nder.deucher%40amd.com%7C30540b2bf2be417c4d9508d7765bf07f%7C3dd
>>> 8961fe4
>> 884e608e11a82d994e183d%7C0%7C0%7C637108010075463266&amp;sdata=1
>>> ZIZUWos
>>>> cPiB4auOY10jlGzoFeWszYMDBQG0CtrrOO8%3D&amp;reserved=0
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> v2:
>>>> - Find Stoney graphics instead of host bridge.
>>>>
>>>>   drivers/iommu/amd_iommu_init.c | 13 ++++++++++++-
>>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/amd_iommu_init.c
>>>> b/drivers/iommu/amd_iommu_init.c index 568c52317757..139aa6fdadda
>>>> 100644
>>>> --- a/drivers/iommu/amd_iommu_init.c
>>>> +++ b/drivers/iommu/amd_iommu_init.c
>>>> @@ -2516,6 +2516,7 @@ static int __init early_amd_iommu_init(void)
>>>>   	struct acpi_table_header *ivrs_base;
>>>>   	acpi_status status;
>>>>   	int i, remap_cache_sz, ret = 0;
>>>> +	u32 pci_id;
>>>>
>>>>   	if (!amd_iommu_detected)
>>>>   		return -ENODEV;
>>>> @@ -2603,6 +2604,16 @@ static int __init early_amd_iommu_init(void)
>>>>   	if (ret)
>>>>   		goto out;
>>>>
>>>> +	/* Disable IOMMU if there's Stoney Ridge graphics */
>>>> +	for (i = 0; i < 32; i++) {
>>>> +		pci_id = read_pci_config(0, i, 0, 0);
>>>> +		if ((pci_id & 0xffff) == 0x1002 && (pci_id >> 16) == 0x98e4) {
>>>> +			pr_info("Disable IOMMU on Stoney Ridge\n");
>>>> +			amd_iommu_disabled = true;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>>   	/* Disable any previously enabled IOMMUs */
>>>>   	if (!is_kdump_kernel() || amd_iommu_disabled)
>>>>   		disable_iommus();
>>>> @@ -2711,7 +2722,7 @@ static int __init state_next(void)
>>>>   		ret = early_amd_iommu_init();
>>>>   		init_state = ret ? IOMMU_INIT_ERROR :
>>> IOMMU_ACPI_FINISHED;
>>>>   		if (init_state == IOMMU_ACPI_FINISHED &&
>>> amd_iommu_disabled) {
>>>> -			pr_info("AMD IOMMU disabled on kernel command-
>>> line\n");
>>>> +			pr_info("AMD IOMMU disabled\n");
>>>>   			init_state = IOMMU_CMDLINE_DISABLED;
>>>>   			ret = -EINVAL;
>>>>   		}

