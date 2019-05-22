Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E29EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D7021473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558549147;
	bh=G3GMVM5Z9SEJ+DsCdXB8MywohW9z4T+H2D8ZFI7WiOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=esn1VUkRaGh3Wn1LBYrUlHrem0o+69cxzuz+1YN59F6Mn+cDSMh8wag50F/vTXHio
	 gMC84MPKiFJksYp+wuS3fVltRZPNjB2Ggh2KWYVcrkcvKveqlraXxFS5xQmOQRZtUy
	 HyEopnqc/oelMXKGlpLCBiCNycKrfJDfoHQlYjag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfEVSTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfEVSTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:19:06 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A77C120863;
        Wed, 22 May 2019 18:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558549145;
        bh=G3GMVM5Z9SEJ+DsCdXB8MywohW9z4T+H2D8ZFI7WiOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NIM3ZNgr+w+rANybmt+oWUqxREmEIjZmuZPGeUFjBHeJ7w2WDo2hbQsABkc/eX4VF
         FLnuOBI4MeZ3d95cvcVGEF2S9XrPN72H76vec3v/5dMdmgNBkUgV3gGR4Ir1MBp9jb
         tGHk7S/jd3PxckYwQMqdxg7xd/FbKlkpc1BYAfvY=
Date:   Wed, 22 May 2019 11:19:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmap: preload a CPU with one object for split
 purpose
Message-Id: <20190522111904.ff2cd5011c8c3b3207e3f3fa@linux-foundation.org>
In-Reply-To: <20190522150939.24605-2-urezki@gmail.com>
References: <20190522150939.24605-1-urezki@gmail.com>
        <20190522150939.24605-2-urezki@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 17:09:37 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> Introduce ne_fit_preload()/ne_fit_preload_end() functions
> for preloading one extra vmap_area object to ensure that
> we have it available when fit type is NE_FIT_TYPE.
> 
> The preload is done per CPU and with GFP_KERNEL permissive
> allocation masks, which allow to be more stable under low
> memory condition and high memory pressure.

What is the reason for this change?  Presumably some workload is
suffering from allocation failures?  Please provide a full description
of when and how this occurs so others can judge the desirability of
this change.

> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -364,6 +364,13 @@ static LIST_HEAD(free_vmap_area_list);
>   */
>  static struct rb_root free_vmap_area_root = RB_ROOT;
>  
> +/*
> + * Preload a CPU with one object for "no edge" split case. The
> + * aim is to get rid of allocations from the atomic context, thus
> + * to use more permissive allocation masks.
> + */
> +static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
> +
>  static __always_inline unsigned long
>  va_size(struct vmap_area *va)
>  {
> @@ -950,9 +957,24 @@ adjust_va_to_fit_type(struct vmap_area *va,
>  		 *   L V  NVA  V R
>  		 * |---|-------|---|
>  		 */
> -		lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> -		if (unlikely(!lva))
> -			return -1;
> +		lva = __this_cpu_xchg(ne_fit_preload_node, NULL);
> +		if (unlikely(!lva)) {
> +			/*
> +			 * For percpu allocator we do not do any pre-allocation
> +			 * and leave it as it is. The reason is it most likely
> +			 * never ends up with NE_FIT_TYPE splitting. In case of
> +			 * percpu allocations offsets and sizes are aligned to
> +			 * fixed align request, i.e. RE_FIT_TYPE and FL_FIT_TYPE
> +			 * are its main fitting cases.
> +			 *
> +			 * There are few exceptions though, as en example it is

"a few"

s/en/an/

> +			 * a first allocation(early boot up) when we have "one"

s/(/ (/

> +			 * big free space that has to be split.
> +			 */
> +			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> +			if (!lva)
> +				return -1;
> +		}
>  
>  		/*
>  		 * Build the remainder.
> @@ -1023,6 +1045,50 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
>  }
>  
>  /*
> + * Preload this CPU with one extra vmap_area object to ensure
> + * that we have it available when fit type of free area is
> + * NE_FIT_TYPE.
> + *
> + * The preload is done in non-atomic context thus, it allows us

s/ thus,/, thus/

> + * to use more permissive allocation masks, therefore to be more

s/, therefore//

> + * stable under low memory condition and high memory pressure.
> + *
> + * If success, it returns zero with preemption disabled. In case
> + * of error, (-ENOMEM) is returned with preemption not disabled.
> + * Note it has to be paired with alloc_vmap_area_preload_end().
> + */
> +static void
> +ne_fit_preload(int *preloaded)
> +{
> +	preempt_disable();
> +
> +	if (!__this_cpu_read(ne_fit_preload_node)) {
> +		struct vmap_area *node;
> +
> +		preempt_enable();
> +		node = kmem_cache_alloc(vmap_area_cachep, GFP_KERNEL);
> +		if (node == NULL) {
> +			*preloaded = 0;
> +			return;
> +		}
> +
> +		preempt_disable();
> +
> +		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, node))
> +			kmem_cache_free(vmap_area_cachep, node);
> +	}
> +
> +	*preloaded = 1;
> +}

Why not make it do `return preloaded;'?  The
pass-and-return-by-reference seems unnecessary?

Otherwise it all appears solid and sensible.
