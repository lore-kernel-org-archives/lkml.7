Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56139C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198D9205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JResApjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfLDOk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:40:59 -0500
Received: from mail-eopbgr720043.outbound.protection.outlook.com ([40.107.72.43]:55693
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbfLDOk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:40:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lauH1XxRrRaKV0euBSVPIqwTAS65cFq9/CV8ZJiWGDoW8FHVSfDr4p9q5gSKYqDoK3SnUTnSB3FeK289Na/prfzlM5CsRWX9lfNcVI3SaTMEeQC6GVxkTogVXR39RE9AWxcaRu36mjWUnN5Ys/tf0FpJiwpGCXqXgToVopK9LCwSm+H23n/rftyY0C0Udg4O7/4jokke5y/scX31T5GpdckKFX0jbd6hOmQ2jJXo6pXZycq227xU8QY7tziEYHacBCrQUf8N/zJVoenMiUaxP0gBaOJtFT6sLfJMIvB9couNRRBAmH4+RuAHiamrB/jjsDZvM4uHo2YSOJcAYWAxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7maORSLxBa/fM9ZC3e6AtmZ747yE/Vw1umcD10aHEbc=;
 b=AbGpPnB8V9UwAkNkqWMGF6iylzNyo3bdw+3JvNEBgTORxqfgf8Ja2CNGflmb1qfrSBFtWAHvqnypPtQeae6csaDYP5ecACTKF+ZSmctGRL+7htzd7uZcHsdYoFyG114f+oAa4pPBqQDwdyUKagmsn3crPTn+bmSYNakjZp2K4gDs3azPZzHy34ujDb2oiVWdTjIjQf/l0/6bGKY1sxSu5g1QNk5huDzZVpGnf2vsnrwnIii1ztSV3tV/EoO+NI8QQl+CAYfYotySPazhOqvICozVqemmo9AcRAPqtjZXX2A5sErN9UW+Q1Y4QEva/gF6xlitTuP4GN4RVRIrIzyBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7maORSLxBa/fM9ZC3e6AtmZ747yE/Vw1umcD10aHEbc=;
 b=JResApjHxZXSzA3oYBHSoe5kTxHCUAyvzb9KuGQHdTIMozvUB+HJj6SCmIIuy0U9X1okHyO6wSUrWfQ2pzFg4WZV5nbzNO41N8pl/Jvnonrjs1G0Gutb4KD4lTF/cdKwEdJ56WvGJXcCY1CUwXugPNRVPRJ1u7hrIjR7k+SwD20=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1740.namprd12.prod.outlook.com (10.175.89.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 14:40:16 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 14:40:16 +0000
Subject: Re: [PATCH 6/8] drm: Add a drm_get_unmapped_area() helper
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
 <20191203132239.5910-7-thomas_os@shipmail.org>
 <e091063c-2c4a-866e-acdb-9efb1e20d737@amd.com>
 <98af5b11-1034-91fa-aa38-5730f116d1cd@shipmail.org>
 <3cc5b796-20c6-9f4c-3f62-d844f34d81b7@amd.com>
 <90a8d09a-b3ab-cd00-0cfb-1a4c72e91836@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <016a9187-1703-2d7d-0114-7fc0cbf1d121@amd.com>
Date:   Wed, 4 Dec 2019 15:40:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <90a8d09a-b3ab-cd00-0cfb-1a4c72e91836@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0077.eurprd02.prod.outlook.com
 (2603:10a6:208:154::18) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ccc1b038-24b9-47bf-de8a-08d778c7e09f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1740:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1740DF38F5A73FB310F22000835D0@DM5PR12MB1740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(6246003)(54906003)(4326008)(6512007)(76176011)(23676004)(52116002)(99286004)(66946007)(229853002)(6436002)(58126008)(6486002)(186003)(66574012)(2616005)(316002)(25786009)(5660300002)(31686004)(11346002)(66476007)(66556008)(53546011)(36756003)(6506007)(478600001)(14454004)(2870700001)(86362001)(31696002)(50466002)(6116002)(2906002)(7416002)(7736002)(6666004)(65956001)(8936002)(81166006)(81156014)(14444005)(8676002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1740;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: to/4mVMmvC44r+2bDlsxB5yPlcelvjFMGhgPe05NhrTY14Q9nQ8Ft5AfHqf5ZKOSAwXN9aKt0D1SCCChzONLVfUQsM9WDfV9rAD9HNuCyA9izdmcAAVpg9siy38DwM/fSXejrgfKyjCcQAUL2snHBPo/lYSJCP+gI4bZX7YcTfK8LZ0uIbal/GSXzQU8lOvoG2CsBwk/r/anV4gV8emTBazDGxz4IA36w+9jWh76yCRIT7WQpkNlWF8s9NwMXDlGEnpaZXQyl6rxT1D78kOl7tC1iXBjcWa/NHEFm8SXhqPoH76I/Uot/tM74Ry/k7z1MgOVBZxq45/h7Rgt6AaOtopTHSj+JsxUX7zc0EYCLfJdluweXybdMAActOx37NgiYwnUpSOYtyiUf1BdWORRZScspCS61KIgJXdgBHmVftwx6KWbcAC+ONqeWijcUG1W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc1b038-24b9-47bf-de8a-08d778c7e09f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 14:40:16.2361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/bUay1ut2yBf9X0Mmym4izIdlpvuTAUW7XgGPHAlDVQdkoRxC2SM2vxeAP6zGnE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.12.19 um 13:32 schrieb Thomas Hellström (VMware):
> On 12/4/19 1:08 PM, Christian König wrote:
>> Am 04.12.19 um 12:36 schrieb Thomas Hellström (VMware):
>>> On 12/4/19 12:11 PM, Christian König wrote:
>>>> Am 03.12.19 um 14:22 schrieb Thomas Hellström (VMware):
>>>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>>>>
>>>>> This helper is used to align user-space buffer object addresses to
>>>>> huge page boundaries, minimizing the chance of alignment mismatch
>>>>> between user-space addresses and physical addresses.
>>>>
>>>> Mhm, I'm wondering if that is really such a good idea.
>>>
>>> Could you elaborate? What drawbacks do you see?
>>
>> Main problem for me seems to be that I don't fully understand what 
>> the get_unmapped_area callback is doing.
>
> It makes sure that, if there is a chance that we could use huge 
> page-table entries, virtual address huge page boundaries are perfectly 
> aligned to physical address huge page boundaries, which is if not a 
> CPU hardware requirement, at least a kernel requirement currently.
>
>
>>
>> For example why do we need to use drm_vma_offset_lookup_locked() to 
>> adjust the pgoff?
>>
>> The mapped offset should be completely irrelevant for finding some 
>> piece of userspace address space or am I totally off here?
>
>
> Because the unmodified pgoff assumes that physical address boundaries 
> are perfectly aligned with file offset boundaries, which is typical 
> for all other subsystems.
>
> That's not true for TTM, however, where a buffer object start physical 
> address may be huge page aligned, but the file offset is always page 
> aligned. We could of course change that to align also file offsets to 
> huge page size boundaries, but with the above adjustment, that's not 
> needed. I opted for the adjustment.

I would opt for aligning the file offsets instead.

Now that you explained it that the rest of the kernel enforces this 
actually makes sense.

Regards,
Christian.

>
> Thanks,
>
> Thomas
>
>

