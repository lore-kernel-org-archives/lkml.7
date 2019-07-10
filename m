Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E7C73C7E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFA72083D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfGJHbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:31:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbfGJHbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:31:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 40D38EDBC7DF22691293;
        Wed, 10 Jul 2019 15:31:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 10 Jul 2019
 15:31:31 +0800
Subject: Re: [PATCH -next v4] drm/amdgpu: return 'ret' immediately if failed
 in amdgpu_pmu_init
To:     "Kim, Jonathan" <Jonathan.Kim@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>
References: <20190624094850.GQ18776@kadam>
 <20190624112318.149299-1-maowenan@huawei.com>
 <CH2PR12MB3831BE36FF61D74FC529F64F85E00@CH2PR12MB3831.namprd12.prod.outlook.com>
 <2d7c2525-4503-3706-7d00-0b9bf230266d@huawei.com>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <8008fcf8-47a1-111f-4467-1a16171129dd@huawei.com>
Date:   Wed, 10 Jul 2019 15:31:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <2d7c2525-4503-3706-7d00-0b9bf230266d@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


gentle ping


On 2019/6/26 19:35, maowenan wrote:
> 
> 
> On 2019/6/25 1:42, Kim, Jonathan wrote:
>> Immediate return should be ok since perf registration isn't dependent on gpu hw.
>>
>> Reviewed-by: Jonathan Kim <Jonathan.Kim@amd.com>
> 
> thanks for review.
> 
>>
>> -----Original Message-----
>> From: Mao Wenan <maowenan@huawei.com> 
>> Sent: Monday, June 24, 2019 7:23 AM
>> To: airlied@linux.ie; daniel@ffwll.ch; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; dan.carpenter@oracle.com; julia.lawall@lip6.fr
>> Cc: kernel-janitors@vger.kernel.org; amd-gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org; Kim, Jonathan <Jonathan.Kim@amd.com>; Mao Wenan <maowenan@huawei.com>
>> Subject: [PATCH -next v4] drm/amdgpu: return 'ret' immediately if failed in amdgpu_pmu_init
>>
>> [CAUTION: External Email]
>>
>> There is one warning:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>   int ret = 0;
>>       ^
>> amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
>> which will use the return value. So it should return 'ret' immediately if init_pmu_by_type() failed.
>> amdgpu_device_init()
>>         r = amdgpu_pmu_init(adev);
>>
>> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in  amdgpu_pmu_init().
>>  v2->v3: change the subject for this patch; return 'ret' immediately if failed to call init_pmu_by_type().
>>  v3->v4: delete the indenting for init_pmu_by_type() arguments. The original indenting is correct.
>>
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> index 0e6dba9f60f0..c98cf77a37f3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> @@ -254,6 +254,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>>                 ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
>>                                        "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>>                                        DF_V3_6_MAX_COUNTERS);
>> +               if (ret)
>> +                       return ret;
>>
>>                 /* other pmu types go here*/
>>                 break;
>> --
>> 2.20.1
>>
> 
> 
> .
> 

