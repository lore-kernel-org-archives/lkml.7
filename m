Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863ACA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FA42083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gWLZxKI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfKADwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:52:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41967 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfKADwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:52:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so3745019plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gpLAkkycQDbDSOC/PvJc50WAQNQl23mAQ5YOyKoCOKQ=;
        b=gWLZxKI+6uMuqF40oThzg5PiQfqKMClcPLLmmIBAaR/wDZwWjVijkJEPF2sNBmIV9i
         nbhYZRcBYedLAs1ObXvZI/Okuk9JFPb0HVSronSamG3Tn5t+wO/JGam+3rhKDB6IcVCm
         h3TDS+boW/VYKcZb32f4zY+kqosE4Bztz0cUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gpLAkkycQDbDSOC/PvJc50WAQNQl23mAQ5YOyKoCOKQ=;
        b=IPkAcnKnYElExBqHaftxJDhy5rilnZxZopFb3E8FDrjOvIqrvOODadnFJRRExF9T3v
         nKCqIW1+hOd5XnMwJn2lfBv5iFJrngDjqw/66ynCC4MfRlvfggl9x98ZKbqKqYlg9W7u
         z7Xj2VwDIxHfpSn/Aisu3/aHH1c2BXM8SatD5z4uSAYcmCcVArxG8RoX32+xv9Fo6Bm8
         GBf89HkpvkWB2IlMxrwoXx0abizai6Q6wbG9LliDj5PD7HGVAMxMwqdDY6X4r+gmvoaK
         +hNn2XjL0YvoLJeJ86wiSRS5AattZmKs5kPidbLOa8efoVtXHnt361eI4FGAFYgtXKoc
         mrag==
X-Gm-Message-State: APjAAAWnF64+OZfR6TP0GMvaifTRmaiC4O2vYx/QMekg0qrwCSmPfyG8
        Qq+etR15V4b+b/GYmUtWoRjBlA==
X-Google-Smtp-Source: APXvYqw6XqTv8yGHR0KsVVwCNMe9mcWfZe/TNMu5crisql/X0YT5TGuvZ2U2c5cD7WTUXY1GQs1CEA==
X-Received: by 2002:a17:902:b604:: with SMTP id b4mr10080726pls.219.1572580366145;
        Thu, 31 Oct 2019 20:52:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21sm570165pfd.74.2019.10.31.20.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:52:45 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:52:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     samitolvanen@google.com
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/17] scs: add accounting
Message-ID: <201910312052.0ADF21F@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-7-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:26AM -0700, samitolvanen@google.com wrote:
> This change adds accounting for the memory allocated for shadow stacks.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

A nice bit of stats to have.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/base/node.c    |  6 ++++++
>  fs/proc/meminfo.c      |  4 ++++
>  include/linux/mmzone.h |  3 +++
>  kernel/scs.c           | 19 +++++++++++++++++++
>  mm/page_alloc.c        |  6 ++++++
>  mm/vmstat.c            |  3 +++
>  6 files changed, 41 insertions(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 296546ffed6c..111e58ec231e 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -415,6 +415,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>  		       "Node %d AnonPages:      %8lu kB\n"
>  		       "Node %d Shmem:          %8lu kB\n"
>  		       "Node %d KernelStack:    %8lu kB\n"
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +		       "Node %d ShadowCallStack:%8lu kB\n"
> +#endif
>  		       "Node %d PageTables:     %8lu kB\n"
>  		       "Node %d NFS_Unstable:   %8lu kB\n"
>  		       "Node %d Bounce:         %8lu kB\n"
> @@ -438,6 +441,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>  		       nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
>  		       nid, K(i.sharedram),
>  		       nid, sum_zone_node_page_state(nid, NR_KERNEL_STACK_KB),
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +		       nid, sum_zone_node_page_state(nid, NR_KERNEL_SCS_BYTES) / 1024,
> +#endif
>  		       nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
>  		       nid, K(node_page_state(pgdat, NR_UNSTABLE_NFS)),
>  		       nid, K(sum_zone_node_page_state(nid, NR_BOUNCE)),
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 8c1f1bb1a5ce..49768005a79e 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -103,6 +103,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
>  	seq_printf(m, "KernelStack:    %8lu kB\n",
>  		   global_zone_page_state(NR_KERNEL_STACK_KB));
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +	seq_printf(m, "ShadowCallStack:%8lu kB\n",
> +		   global_zone_page_state(NR_KERNEL_SCS_BYTES) / 1024);
> +#endif
>  	show_val_kb(m, "PageTables:     ",
>  		    global_zone_page_state(NR_PAGETABLE));
>  
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index bda20282746b..fcb8c1708f9e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -200,6 +200,9 @@ enum zone_stat_item {
>  	NR_MLOCK,		/* mlock()ed pages found and moved off LRU */
>  	NR_PAGETABLE,		/* used for pagetables */
>  	NR_KERNEL_STACK_KB,	/* measured in KiB */
> +#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
> +	NR_KERNEL_SCS_BYTES,	/* measured in bytes */
> +#endif
>  	/* Second 128 byte cacheline */
>  	NR_BOUNCE,
>  #if IS_ENABLED(CONFIG_ZSMALLOC)
> diff --git a/kernel/scs.c b/kernel/scs.c
> index 7c1a40020754..7780fc4e29ac 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -11,6 +11,7 @@
>  #include <linux/scs.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/vmstat.h>
>  #include <asm/scs.h>
>  
>  static inline void *__scs_base(struct task_struct *tsk)
> @@ -74,6 +75,11 @@ static void scs_free(void *s)
>  	vfree_atomic(s);
>  }
>  
> +static struct page *__scs_page(struct task_struct *tsk)
> +{
> +	return vmalloc_to_page(__scs_base(tsk));
> +}
> +
>  static int scs_cleanup(unsigned int cpu)
>  {
>  	int i;
> @@ -107,6 +113,11 @@ static inline void scs_free(void *s)
>  	kmem_cache_free(scs_cache, s);
>  }
>  
> +static struct page *__scs_page(struct task_struct *tsk)
> +{
> +	return virt_to_page(__scs_base(tsk));
> +}
> +
>  void __init scs_init(void)
>  {
>  	scs_cache = kmem_cache_create("scs_cache", SCS_SIZE, SCS_SIZE,
> @@ -135,6 +146,12 @@ void scs_task_reset(struct task_struct *tsk)
>  	task_set_scs(tsk, __scs_base(tsk));
>  }
>  
> +static void scs_account(struct task_struct *tsk, int account)
> +{
> +	mod_zone_page_state(page_zone(__scs_page(tsk)), NR_KERNEL_SCS_BYTES,
> +		account * SCS_SIZE);
> +}
> +
>  int scs_prepare(struct task_struct *tsk, int node)
>  {
>  	void *s;
> @@ -145,6 +162,7 @@ int scs_prepare(struct task_struct *tsk, int node)
>  
>  	task_set_scs(tsk, s);
>  	scs_set_magic(tsk);
> +	scs_account(tsk, 1);
>  
>  	return 0;
>  }
> @@ -164,6 +182,7 @@ void scs_release(struct task_struct *tsk)
>  
>  	WARN_ON(scs_corrupted(tsk));
>  
> +	scs_account(tsk, -1);
>  	task_set_scs(tsk, NULL);
>  	scs_free(s);
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ecc3dbad606b..fe17d69d98a7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5361,6 +5361,9 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  			" managed:%lukB"
>  			" mlocked:%lukB"
>  			" kernel_stack:%lukB"
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +			" shadow_call_stack:%lukB"
> +#endif
>  			" pagetables:%lukB"
>  			" bounce:%lukB"
>  			" free_pcp:%lukB"
> @@ -5382,6 +5385,9 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  			K(zone_managed_pages(zone)),
>  			K(zone_page_state(zone, NR_MLOCK)),
>  			zone_page_state(zone, NR_KERNEL_STACK_KB),
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +			zone_page_state(zone, NR_KERNEL_SCS_BYTES) / 1024,
> +#endif
>  			K(zone_page_state(zone, NR_PAGETABLE)),
>  			K(zone_page_state(zone, NR_BOUNCE)),
>  			K(free_pcp),
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 6afc892a148a..9fe4afe670fe 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1118,6 +1118,9 @@ const char * const vmstat_text[] = {
>  	"nr_mlock",
>  	"nr_page_table_pages",
>  	"nr_kernel_stack",
> +#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
> +	"nr_shadow_call_stack_bytes",
> +#endif
>  	"nr_bounce",
>  #if IS_ENABLED(CONFIG_ZSMALLOC)
>  	"nr_zspages",
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
