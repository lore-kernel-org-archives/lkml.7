Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D669DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2F820820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDDCCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:02:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35426 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDDCCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:02:15 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [10.3.19.204])
        by Forcepoint Email with ESMTP id B9008DB6D5746784416C;
        Thu,  4 Apr 2019 10:02:12 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Apr 2019
 10:02:08 +0800
Subject: Re: [PATCH] drm/msm/a6xx: Fix build with !CONFIG_DEBUG_FS
To:     <robdclark@gmail.com>, <sean@poorly.run>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <linux-kernel@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>
References: <20190403064811.25832-1-yuehaibing@huawei.com>
 <20190403153639.GA13713@jcrouse1-lnx.qualcomm.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a9871f50-f8f9-917d-9a6a-798805d698ad@huawei.com>
Date:   Thu, 4 Apr 2019 10:02:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190403153639.GA13713@jcrouse1-lnx.qualcomm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/3 23:36, Jordan Crouse wrote:
> On Wed, Apr 03, 2019 at 02:48:11PM +0800, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> When building CONFIG_DEBUG_FS is not set
>> gcc warn this:
>>
>> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c: In function a6xx_show:
>> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:1124:2: error: implicit declaration of function adreno_show; did you mean adreno_dump? [-Werror=implicit-function-declaration]
>>   adreno_show(gpu, state, p);
>>   ^~~~~~~~~~~
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
>> index e686331..d327eb5 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
>> @@ -1121,7 +1121,9 @@ void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
>>  	if (IS_ERR_OR_NULL(state))
>>  		return;
>>  
>> +#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
>>  	adreno_show(gpu, state, p);
>> +#endif
> 
> I agree that this is a problem, but I think I would prefer if we just made a
> stub function for adreno_show instead of doing a inline ifdef, so in
> adreno_gpu.c:
> 
> #ifdef defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
> ...
> #else
> void adreno_show(struct msm_gpu *gpu, msm_gpu_state *state,
> 	struct drm_printer *p)
> {
> }
> #endif
> 
> If you want, I can do a quick patch.

Sure, it's ok for me.

> 
> Jordan
> 

