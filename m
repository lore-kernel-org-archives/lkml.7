Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5DECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3970321D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394092AbfJYJKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:10:18 -0400
Received: from foss.arm.com ([217.140.110.172]:37376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391119AbfJYJKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:10:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 818C031F;
        Fri, 25 Oct 2019 02:10:15 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52F533F71F;
        Fri, 25 Oct 2019 02:10:14 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3] drm/panfrost: fix -Wmissing-prototypes warnings
To:     Yi Wang <wang.yi59@zte.com.cn>, robh@kernel.org
Cc:     tomeu.vizoso@collabora.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        wang.liang82@zte.com.cn, xue.zhihong@zte.com.cn, up2wing@gmail.com
References: <1571967015-42854-1-git-send-email-wang.yi59@zte.com.cn>
Message-ID: <31dc2f01-299c-6a52-4111-3e60e555cb9b@arm.com>
Date:   Fri, 25 Oct 2019 10:10:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571967015-42854-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2019 02:30, Yi Wang wrote:
> We get these warnings when build kernel W=1:
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:35:6: warning: no previous prototype for ‘panfrost_perfcnt_clean_cache_done’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:40:6: warning: no previous prototype for ‘panfrost_perfcnt_sample_done’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:190:5: warning: no previous prototype for ‘panfrost_ioctl_perfcnt_enable’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:218:5: warning: no previous prototype for ‘panfrost_ioctl_perfcnt_dump’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:250:6: warning: no previous prototype for ‘panfrost_perfcnt_close’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:264:5: warning: no previous prototype for ‘panfrost_perfcnt_init’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:320:6: warning: no previous prototype for ‘panfrost_perfcnt_fini’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_mmu.c:227:6: warning: no previous prototype for ‘panfrost_mmu_flush_range’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_mmu.c:435:5: warning: no previous prototype for ‘panfrost_mmu_map_fault_addr’ [-Wmissing-prototypes]
> 
> For file panfrost_mmu.c, make functions static to fix this.
> For file panfrost_perfcnt.c, include header file can fix this.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
> 
> v3: using tab size of 8 other than 4.
> 
> v2: align parameter line and modify comment. Thanks to Steve.
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c     | 9 +++++----
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index bdd9905..871574c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -224,9 +224,9 @@ static size_t get_pgsize(u64 addr, size_t size)
>  	return SZ_2M;
>  }
>  
> -void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
> -			      struct panfrost_mmu *mmu,
> -			      u64 iova, size_t size)
> +static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
> +				    struct panfrost_mmu *mmu,
> +				    u64 iova, size_t size)

Ok, I'll admit I wouldn't have spotted this unless I'd double checked by
applying the patch, but you still seem to have something misconfigured
in your editor. This is out by one character:

static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
>------->------->------->-------    struct panfrost_mmu *mmu,
>------->------->------->-------    u64 iova, size_t size)

There should be an extra space to align correctly.

>  {
>  	if (mmu->as < 0)
>  		return;
> @@ -432,7 +432,8 @@ void panfrost_mmu_pgtable_free(struct panfrost_file_priv *priv)
>  
>  #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
>  
> -int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> +static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
> +					u64 addr)

Here you're off-by-one in the other direction - you need to replace the
final tab with 7 spaces:

static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>------->------->------->------->-------u64 addr)

Sorry to nit-pick over this, but it's good to get your editor setup
correctly to ensure your formatting is correct.

Thanks,

Steve

>  {
>  	int ret, i;
>  	struct panfrost_gem_object *bo;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index 83c57d3..2dba192 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -16,6 +16,7 @@
>  #include "panfrost_issues.h"
>  #include "panfrost_job.h"
>  #include "panfrost_mmu.h"
> +#include "panfrost_perfcnt.h"
>  #include "panfrost_regs.h"
>  
>  #define COUNTERS_PER_BLOCK		64
> 

