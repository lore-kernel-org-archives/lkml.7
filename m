Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E69BC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49812206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfETJVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:21:15 -0400
Received: from foss.arm.com ([217.140.101.70]:41536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfETJVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:21:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73538374;
        Mon, 20 May 2019 02:21:14 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB4DF3F575;
        Mon, 20 May 2019 02:21:11 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] drm: shmem: Add drm_gem_shmem_map_offset() wrapper
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190516141447.46839-1-steven.price@arm.com>
 <20190516141447.46839-3-steven.price@arm.com>
 <20190516202644.GE3851@phenom.ffwll.local>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b4d04dfd-3f45-e456-e944-9c337a6538a5@arm.com>
Date:   Mon, 20 May 2019 10:21:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516202644.GE3851@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2019 21:26, Daniel Vetter wrote:
> On Thu, May 16, 2019 at 03:14:46PM +0100, Steven Price wrote:
>> Provide a wrapper for drm_gem_map_offset() for clients of shmem. This
>> wrapper provides the correct semantics for the drm_gem_shmem_mmap()
>> callback.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 20 ++++++++++++++++++++
>>  include/drm/drm_gem_shmem_helper.h     |  2 ++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index 1ee208c2c85e..9dbebc4897d1 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -400,6 +400,26 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>>  }
>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
>>  
>> +/**
>> + * drm_gem_map_offset - return the fake mmap offset for a gem object
>> + * @file: drm file-private structure containing the gem object
>> + * @dev: corresponding drm_device
>> + * @handle: gem object handle
>> + * @offset: return location for the fake mmap offset
>> + *
>> + * This provides an offset suitable for user space to return to the
>> + * drm_gem_shmem_mmap() callback via an mmap() call.
>> + *
>> + * Returns:
>> + * 0 on success or a negative error code on failure.
>> + */
>> +int drm_gem_shmem_map_offset(struct drm_file *file, struct drm_device *dev,
>> +			     u32 handle, u64 *offset)
>> +{
>> +	return drm_gem_map_offset(file, dev, handle, offset);
>> +}
>> +EXPORT_SYMBOL_GPL(drm_gem_shmem_map_offset);
> 
> Not seeing the point of this mapper, since drm_gem_shmem_map_offset isn't
> speficic at all. It works for dumb, shmem, cma and private objects all
> equally well. I'd drop this and just directly call the underlying thing,
> no need to layer helpers.
> -Daniel

Ok, I'll drop it. I may have misunderstood, but I think Chris Wilson was
asking for it because shmem is the source of the particular requirements
of what can be mmap()d. But I think a helper can be added very easily if
anything changes, so this patch is probably premature.

I'll resend the series with this patch dropped.

Thanks,
Steve
