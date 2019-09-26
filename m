Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36326C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0814217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mSJPHGU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfIZJQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:16:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34537 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfIZJQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:16:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id p10so1320330edq.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C50uCIRZXB+UBz8ksrHz9YHG9QxeChHhVCa2axN7YVA=;
        b=mSJPHGU/Ii+qAyY9nTYzRFKSjkSgZt6UkVNixHRAHp1jNX3v/0QS78MRlpljP3iJi+
         SDIqvf6Wn0OgQC+/GARBKIi3QYM3XIDXSqGe1pM4k4T7nKELUuJeYBdKCiQI1kWeQcgH
         gfrbuiziptUfyaZIGLK6MZNAxcP3V6g/AybE4oiJtZggPIKHtCa4RizDg6P9BOGIhQU6
         AXlY1MuMM/Ui4aEPbgx3ea7J8cGIicX9itpZxSUjTYHeFaN/hxr2Yx61+hIZeJ5legVF
         kc34oxQhXIyJPMZEOk5ybbP6dLn6aVo5aFZeZxkoaqeJtmI/SrGYWeNLAeLJXPojQDeF
         KLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C50uCIRZXB+UBz8ksrHz9YHG9QxeChHhVCa2axN7YVA=;
        b=gSmMs7HYusW/NLS2SxF39K9boVDQX0o8wOZNiQYdXhbNqb1O1gNSrnTUnTQdYYcy3+
         lnc72ItN3UEdOFflLX8hS+9iXbKjKSAj2mEayww8H4i3TjzSBRZhhMtshdnTw4Gz9HNV
         JeYHdEZTKOWTPjpiEjVkXNq6N46GnTl3RmdXu/N//CsV3y/dUkxs38ISnjYIw0/62V2s
         LUKTUfBlK9tt3riry2VvlX2lhVWSiUXTddBOSYuXfM1dfRqKYsgWVZmX732hp3inmSPo
         Z/j65KGK008BywDJrCDu8j6NLr43k070YR51qRa2cekRHnGzAG+RKWWJX/cz19SsmP8y
         XbgQ==
X-Gm-Message-State: APjAAAW978G0CJR9Pl4mWBHaLlqfNdS+/fi2CrjTI8Zf6oQ6SkIpOukE
        r/UlhUAOVPBaIehguz8Tjzr5vQ==
X-Google-Smtp-Source: APXvYqyqkf1tIwLWoAatOKH01Tl0xCiTI1zaafbU9IHBWlAXKRm98sUt/8DWULgxHHYfuiRGLBjntQ==
X-Received: by 2002:a50:ac03:: with SMTP id v3mr2407789edc.113.1569489361850;
        Thu, 26 Sep 2019 02:16:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o31sm352089edd.17.2019.09.26.02.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 02:16:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 105B1102322; Thu, 26 Sep 2019 12:16:04 +0300 (+03)
Date:   Thu, 26 Sep 2019 12:16:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Qian Cai <cai@lca.pw>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 2/3] mm, debug, kasan: save and dump freeing stack trace
 for kasan
Message-ID: <20190926091604.axt7uqmds6sd3bnu@box>
References: <20190925143056.25853-1-vbabka@suse.cz>
 <20190925143056.25853-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925143056.25853-3-vbabka@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:30:51PM +0200, Vlastimil Babka wrote:
> The commit 8974558f49a6 ("mm, page_owner, debug_pagealloc: save and dump
> freeing stack trace") enhanced page_owner to also store freeing stack trace,
> when debug_pagealloc is also enabled. KASAN would also like to do this [1] to
> improve error reports to debug e.g. UAF issues. This patch therefore introduces
> a helper config option PAGE_OWNER_FREE_STACK, which is enabled when PAGE_OWNER
> and either of DEBUG_PAGEALLOC or KASAN is enabled. Boot-time, the free stack
> saving is enabled when booting a KASAN kernel with page_owner=on, or non-KASAN
> kernel with debug_pagealloc=on and page_owner=on.

I would like to have an option to enable free stack for any PAGE_OWNER
user at boot-time.

Maybe drop CONFIG_PAGE_OWNER_FREE_STACK completely and add
page_owner_free=on cmdline option as yet another way to trigger
'static_branch_enable(&page_owner_free_stack)'?

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=203967
> 
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
>  Documentation/dev-tools/kasan.rst |  4 ++++
>  mm/Kconfig.debug                  |  4 ++++
>  mm/page_owner.c                   | 31 ++++++++++++++++++-------------
>  3 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index b72d07d70239..434e605030e9 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -41,6 +41,10 @@ smaller binary while the latter is 1.1 - 2 times faster.
>  Both KASAN modes work with both SLUB and SLAB memory allocators.
>  For better bug detection and nicer reporting, enable CONFIG_STACKTRACE.
>  
> +To augment reports with last allocation and freeing stack of the physical
> +page, it is recommended to configure kernel also with CONFIG_PAGE_OWNER = y

Nit: remove spaces around '=' or write "with CONFIG_PAGE_OWNER enabled".

> +and boot with page_owner=on.
> +
>  To disable instrumentation for specific files or directories, add a line
>  similar to the following to the respective kernel Makefile:
>  
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 327b3ebf23bf..1ea247da3322 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -62,6 +62,10 @@ config PAGE_OWNER
>  
>  	  If unsure, say N.
>  
> +config PAGE_OWNER_FREE_STACK
> +	def_bool KASAN || DEBUG_PAGEALLOC
> +	depends on PAGE_OWNER
> +
>  config PAGE_POISONING
>  	bool "Poison pages after freeing"
>  	select PAGE_POISONING_NO_SANITY if HIBERNATION
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index d3cf5d336ccf..f3aeec78822f 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -24,13 +24,14 @@ struct page_owner {
>  	short last_migrate_reason;
>  	gfp_t gfp_mask;
>  	depot_stack_handle_t handle;
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> +#ifdef CONFIG_PAGE_OWNER_FREE_STACK
>  	depot_stack_handle_t free_handle;
>  #endif
>  };
>  
>  static bool page_owner_disabled = true;
>  DEFINE_STATIC_KEY_FALSE(page_owner_inited);
> +static DEFINE_STATIC_KEY_FALSE(page_owner_free_stack);
>  
>  static depot_stack_handle_t dummy_handle;
>  static depot_stack_handle_t failure_handle;
> @@ -91,6 +92,8 @@ static void init_page_owner(void)
>  	register_failure_stack();
>  	register_early_stack();
>  	static_branch_enable(&page_owner_inited);
> +	if (IS_ENABLED(CONFIG_KASAN) || debug_pagealloc_enabled())
> +		static_branch_enable(&page_owner_free_stack);
>  	init_early_allocated_pages();
>  }
>  
> @@ -148,11 +151,11 @@ void __reset_page_owner(struct page *page, unsigned int order)
>  {
>  	int i;
>  	struct page_ext *page_ext;
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> +#ifdef CONFIG_PAGE_OWNER_FREE_STACK
>  	depot_stack_handle_t handle = 0;
>  	struct page_owner *page_owner;
>  
> -	if (debug_pagealloc_enabled())
> +	if (static_branch_unlikely(&page_owner_free_stack))
>  		handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
>  #endif
>  
> @@ -161,8 +164,8 @@ void __reset_page_owner(struct page *page, unsigned int order)
>  		return;
>  	for (i = 0; i < (1 << order); i++) {
>  		__clear_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> -		if (debug_pagealloc_enabled()) {
> +#ifdef CONFIG_PAGE_OWNER_FREE_STACK
> +		if (static_branch_unlikely(&page_owner_free_stack)) {
>  			page_owner = get_page_owner(page_ext);
>  			page_owner->free_handle = handle;
>  		}
> @@ -450,14 +453,16 @@ void __dump_page_owner(struct page *page)
>  		stack_trace_print(entries, nr_entries, 0);
>  	}
>  
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> -	handle = READ_ONCE(page_owner->free_handle);
> -	if (!handle) {
> -		pr_alert("page_owner free stack trace missing\n");
> -	} else {
> -		nr_entries = stack_depot_fetch(handle, &entries);
> -		pr_alert("page last free stack trace:\n");
> -		stack_trace_print(entries, nr_entries, 0);
> +#ifdef CONFIG_PAGE_OWNER_FREE_STACK
> +	if (static_branch_unlikely(&page_owner_free_stack)) {
> +		handle = READ_ONCE(page_owner->free_handle);
> +		if (!handle) {
> +			pr_alert("page_owner free stack trace missing\n");
> +		} else {
> +			nr_entries = stack_depot_fetch(handle, &entries);
> +			pr_alert("page last free stack trace:\n");
> +			stack_trace_print(entries, nr_entries, 0);
> +		}
>  	}
>  #endif
>  
> -- 
> 2.23.0
> 
> 

-- 
 Kirill A. Shutemov
