Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A78C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786F321734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfC0NYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfC0NYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:24:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0132146F;
        Wed, 27 Mar 2019 13:24:23 +0000 (UTC)
Date:   Wed, 27 Mar 2019 09:24:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] trace/page_ref: print out the page migratetype name
Message-ID: <20190327092422.3cf2c7a3@gandalf.local.home>
In-Reply-To: <20190327050937.5395-1-sjhuang@iluvatar.ai>
References: <20190327050937.5395-1-sjhuang@iluvatar.ai>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 13:09:37 +0800
Huang Shijie <sjhuang@iluvatar.ai> wrote:

> Print out the page migratetype name which is more readable.

Except that it breaks perf and trace-cmd, as they wont know what a
migratetype_names array contains.

See how writeback does it. Which would be something like this for you.

/* enums need to be exported to user space */
#undef EM
#undef EMe
#undef EM_CMA
#undef EM_ISOLATE
#define EM(a)	 	TRACE_DEFINE_ENUM(MIGRATE_##a);
#define EMe(a)		TRACE_DEFINE_ENUM(MIGRATE_##a);

#ifdef CONFIG_CMA
# define EM_CMA		TRACE_DEFINE_ENUM(MIGRATE_CMA);
#else
# define EM_CMA
#endif

#ifdef CONFIG_MEMORY_ISOLATION
# define EM_ISOLATE	TRACE_DEFINE_ENUM(MIGRATE_ISOLATION);
#else
# define EM_ISOLATE
#endif

#define MIGRATE_ENUM_TYPES	\
	EM(UNMOVABLE)		\
	EM(MOVABLE)		\
	EM(RECLAIMABLE)		\
	EM(PCPTYPES)		\
	EM(HIGHATOMIC)		\
	EM_CMA			\
	EM_ISOLATE		\
	EMe(TYPES)

MIGRATE_ENUM_TYPES

#undef EM
#undef EMe
#undef EM_CMA
#undef EM_ISOLATE
#define EM(a)		{ MIGRATE_##a, #a },
#define EMe(a)		{ MIGRATE_##a, #a }

#ifdef CONFIG_CMA
# define EM_CMA		{ MIGRATE_CMA, "CMA" },
#else
# define EM_CMA
#endif

#ifdef CONFIG_MEMORY_ISOLATION
# define EM_ISOLATE	{ MIGRATE_ISOLATION, "ISOLATION" }
#else
# define EM_ISOLATE
#endif

> 
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> ---
>  include/trace/events/page_ref.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
> index 5d2ea93956ce..94df979c2d6b 100644
> --- a/include/trace/events/page_ref.h
> +++ b/include/trace/events/page_ref.h
> @@ -36,11 +36,12 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
>  		__entry->val = v;
>  	),
>  
> -	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
> +	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%s val=%d",
>  		__entry->pfn,
>  		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
>  		__entry->count,
> -		__entry->mapcount, __entry->mapping, __entry->mt,
> +		__entry->mapcount, __entry->mapping,
> +		migratetype_names[__entry->mt],

Then here you add:

		print_symbolic(__entry->mt, MIGRATE_ENUM_TYPES),

>  		__entry->val)
>  );
>  
> @@ -86,11 +87,12 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
>  		__entry->ret = ret;
>  	),
>  
> -	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
> +	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%s val=%d ret=%d",
>  		__entry->pfn,
>  		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
>  		__entry->count,
> -		__entry->mapcount, __entry->mapping, __entry->mt,
> +		__entry->mapcount, __entry->mapping,
> +		migratetype_names[__entry->mt],
>  		__entry->val, __entry->ret)
>  );
>  

