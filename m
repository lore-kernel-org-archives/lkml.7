Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2573BC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1FD205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DVMY6tpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfLDOCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:02:36 -0500
Received: from mail-eopbgr790043.outbound.protection.outlook.com ([40.107.79.43]:6368
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbfLDOCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:02:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNsxNaDqD83acX7khCw3bG2u/hWVlj6u6BOowfW72TqmZHKIe6FcRRL9Xm2ydCa7B/n+mM1SL13O6grJnMSPM3JqsZ4ZxtTrUOZ6zrQEd/yTaOhqJqjHD+DTsu7DTIrjM0bejPQsf3dL0vz0r+mjQ3490cZx0SlfyselaP709XItRQsxgqLaqtI7bvcT5ButFSH9yrFY1ky30+Gen3zjIAYFHb+St10qJvbVZkFPS8Oapd1IUktUKMsfFALSf+t1KgP14VwLdAWnTL8mAvyXWkdmrJ7iv0wCkqv0P/dKSMHeGK6c0voa9BUVKViwist53inRmXzXvfE0KlxsxPBbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bGm5JMQnAFU8Ntt4xg3rbAARi/QoRFtqLwpDTU8S/I=;
 b=ffzHVvDt0Uu8v2fjY+/r3w7s+nOQhPJVO7QNBApeuyyWhAWyv9oazS0aVMy9roPS24InVR1D2Te6w5sAjbXxzn7n86lVsRYqBp/xfM4nULyXSCauJLtbkH2kj6F/bBlY4IRegmYm39qxsO6PsQF5uGv/EbiztlJsNgMBqkWFqe8SMcEWJnw898o+vykJJfEUs4d50F9fNfS/e5LoJvSOigUOHwUN1ZKQARSzvT+Yv1DYM1jpUtJswI9m+4fplDHDYO30RSsGRn7Om+WqRRTZaBrQDjZAbVZ/q7bqVXfJWXf6OsluEatEip3X0eavWz5IzA8/cfuQL3vJHEEDAtm0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bGm5JMQnAFU8Ntt4xg3rbAARi/QoRFtqLwpDTU8S/I=;
 b=DVMY6tpkLy+xbpxeGw0xK0dBJ6nTV1p03Pp51CD6p5cQIYj4r0/Lnfn7d2GJqUYjv0gUXW9ltnvwk2g6J+IR7FJs+exgMo5MqsV073McckDjHr3aXgCLri+tOJDdpt2u83povdijqRQ+yW/ExC5EHoeC1m4RHPVtlRj7iOLccoM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1372.namprd12.prod.outlook.com (10.168.238.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 4 Dec 2019 14:02:32 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 14:02:31 +0000
Subject: Re: [PATCH 7/8] drm/ttm: Introduce a huge page aligning TTM range
 manager.
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191203132239.5910-1-thomas_os@shipmail.org>
 <20191203132239.5910-8-thomas_os@shipmail.org>
 <39b9d651-6afd-1926-7302-aa2a8d4ca626@amd.com>
 <7223bee1-cb3f-3d88-a70b-f4e1a5088b76@shipmail.org>
 <f87a03da-ea9d-fe2b-8069-8fe0bda57c12@amd.com>
 <6ae46281-195c-2803-fc3d-16e7bc830639@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <34a91568-cd07-9d95-d2f1-89cc1ff5fa90@amd.com>
Date:   Wed, 4 Dec 2019 15:02:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <6ae46281-195c-2803-fc3d-16e7bc830639@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0083.eurprd07.prod.outlook.com
 (2603:10a6:207:6::17) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28fd6849-05b2-44d1-d9a5-08d778c29adf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1372:
X-Microsoft-Antispam-PRVS: <DM5PR12MB137250FF6223B34CCF49DF65835D0@DM5PR12MB1372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(316002)(31696002)(6246003)(5660300002)(52116002)(7736002)(305945005)(31686004)(7416002)(81156014)(99286004)(23676004)(53546011)(66574012)(14454004)(478600001)(8676002)(8936002)(58126008)(4326008)(6506007)(54906003)(25786009)(186003)(6666004)(2906002)(81166006)(66946007)(2616005)(36756003)(66556008)(66476007)(86362001)(2870700001)(11346002)(50466002)(65956001)(6116002)(6486002)(76176011)(6512007)(6436002)(229853002)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1372;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1K+9QHOm0Xg6m/SYFwQB0uhyhWaUxA7FkAmh1RDMQYfxJPu2dqWUXYUrYgd2AJCRWQkL7IuegUQsiQqCFf8jxpwn0/GYp8aBQXvVUzoBxoaMwId3L6f4d2oAFCaV6wk27vENANbl6FtmAkB9DtwBwd4T7NxhnzMltMAQvaKLvlErRfl9qPV2YBag/zdjOfiq+C5TqeCNRb90lSwf3sWnjyJpormiHENkSuAYOI1EOTOfwuqOmSZWoC6QyV3/k/5U3eMWvm/Tlty+p7ljQW9XcM07yVzq55o9DQnr2RS5N/5mJsjRCxkV/oeq3cBLlKTDKUM1wkzYmYMkoZZdWkghlUeMLB1QnP81PRNEtgFE/Mf+8b0f7cZ1RVF1KZ/9yL+Q7YgkRyMvsFzdsXIoy8zUWQoN8Ue4PV2SIbrEfqCq3ty3kyKdvKYDUJJNOIBfKWLh3bpC9n4HwhVSoxxoE2h6XnEs5cj++4woFPYD8Co27pdO5FvS1IDgYmVQQrXFFpF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fd6849-05b2-44d1-d9a5-08d778c29adf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 14:02:31.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbV1Nj1lAP0/u7jsjhFR5hVXtkEMurP4uSsVZR+uYy4tmg/hB3NBidgoUScb2dPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.12.19 um 14:18 schrieb Thomas Hellström (VMware):
> On 12/4/19 1:16 PM, Christian König wrote:
>> Am 04.12.19 um 12:45 schrieb Thomas Hellström (VMware):
>>> On 12/4/19 12:13 PM, Christian König wrote:
>>>> Am 03.12.19 um 14:22 schrieb Thomas Hellström (VMware):
>>>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>>>>
>>>>> Using huge page-table entries require that the start of a buffer 
>>>>> object
>>>>> is huge page size aligned. So introduce a ttm_bo_man_get_node_huge()
>>>>> function that attempts to accomplish this for allocations that are 
>>>>> larger
>>>>> than the huge page size, and provide a new range-manager instance 
>>>>> that
>>>>> uses that function.
>>>>
>>>> I still don't think that this is a good idea.
>>>
>>> Again, can you elaborate with some specific concerns?
>>
>> You seems to be seeing PUD as something optional.
>>
>>>>
>>>> The driver/userspace should just use a proper alignment if it wants 
>>>> to use huge pages.
>>>
>>> There are drawbacks with this approach. The TTM alignment is a hard 
>>> constraint. Assume that you want to fit a 1GB buffer object into 
>>> limited VRAM space, and _if possible_ use PUD size huge pages. Let's 
>>> say there is 1GB available, but not 1GB aligned. The proper 
>>> alignment approach would fail and possibly start to evict stuff from 
>>> VRAM just to be able to accomodate the PUD alignment. That's bad. 
>>> The approach I suggest would instead fall back to PMD alignment and 
>>> use 2MB page table entries if possible, and as a last resort use 4K 
>>> page table entries.
>>
>> And exactly that sounds like a bad idea to me.
>>
>> Using 1GB alignment is indeed unrealistic in most cases, but for 2MB 
>> alignment we should really start to evict BOs.
>>
>> Otherwise the address space can become fragmented and we won't be 
>> able de-fragment it in any way.
>
> Ah, I see, Yeah that's the THP tradeoff between fragmentation and 
> memory-usage. From my point of view, it's not self-evident that either 
> approach is the best one, but the nice thing with the suggested code 
> is that you can view it as an optional helper. For example, to avoid 
> fragmentation and have a high huge-page hit ratio for 2MB pages, You'd 
> either inflate the buffer object size to be 2MB aligned, which would 
> affect also system memory, or you'd set the TTM memory alignment to 
> 2MB. If in addition you'd like "soft" (non-evicting) alignment also 
> for 1GB pages, you'd also hook up the new range manager. I figure 
> different drivers would want to use different strategies.
>
> In any case, vmwgfx would, due to its very limited VRAM size, want to 
> use the "soft" alignment provided by this patch, but if you don't see 
> any other drivers wanting that, I could definitely move it to vmwgfx.

Ok, let's do it this way then. Both amdgpu and well as nouveau have 
specialized allocators anyway and I don't see the need for this in radeon.

Regards,
Christian.

>
> /Thomas
>
>
>

