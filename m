Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B6C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA66F206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbfILOj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:39:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:64597 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732592AbfILOj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:39:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 07:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,497,1559545200"; 
   d="scan'208";a="186146677"
Received: from avrahamr-mobl1.ger.corp.intel.com (HELO [10.252.3.203]) ([10.252.3.203])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2019 07:39:54 -0700
Subject: Re: [Intel-gfx] [PATCH] Revert "drm/i915/userptr: Acquire the page
 lock around set_page_dirty()"
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, torvalds@linux-foundation.org
Cc:     tiwai@suse.de, linux-kernel@vger.kernel.org, leho@kraav.com,
        Jani Nikula <jani.nikula@intel.com>, MKoutny@suse.com,
        stable@vger.kernel.org, Martin.Wilck@suse.com
References: <CAHk-=wjKv_Zw2zGHduyrQH_VQzxXYzwKdwwzzpsdnsdx=EK30Q@mail.gmail.com>
 <20190912125634.29054-1-chris@chris-wilson.co.uk>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <ae31587d-bd36-5f6a-6479-df23f3eda590@linux.intel.com>
Date:   Thu, 12 Sep 2019 15:39:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912125634.29054-1-chris@chris-wilson.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/09/2019 13:56, Chris Wilson wrote:
> The userptr put_pages can be called from inside try_to_unmap, and so
> enters with the page lock held on one of the object's backing pages. We
> cannot take the page lock ourselves for fear of recursion.
> 
> Reported-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> Reported-by: Martin Wilck <Martin.Wilck@suse.com>
> Reported-by: Leo Kraav <leho@kraav.com>
> Fixes: aa56a292ce62 ("drm/i915/userptr: Acquire the page lock around set_page_dirty()")
> References: https://bugzilla.kernel.org/show_bug.cgi?id=203317
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> index 74da35611d7c..11b231c187c5 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> @@ -672,15 +672,7 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object *obj,
>   
>   	for_each_sgt_page(page, sgt_iter, pages) {
>   		if (obj->mm.dirty)
> -			/*
> -			 * As this may not be anonymous memory (e.g. shmem)
> -			 * but exist on a real mapping, we have to lock
> -			 * the page in order to dirty it -- holding
> -			 * the page reference is not sufficient to
> -			 * prevent the inode from being truncated.
> -			 * Play safe and take the lock.
> -			 */
> -			set_page_dirty_lock(page);
> +			set_page_dirty(page);
>   
>   		mark_page_accessed(page);
>   		put_page(page);
> 

Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko
