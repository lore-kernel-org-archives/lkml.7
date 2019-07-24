Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13037C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B9A2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404969AbfGXUMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388645AbfGXUMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:12:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7225E21873;
        Wed, 24 Jul 2019 20:12:09 +0000 (UTC)
Date:   Wed, 24 Jul 2019 16:12:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "George G. Davis" <george_davis@mentor.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] tracing: kmem: convert call_site addresses to user
 friendly symbols
Message-ID: <20190724161207.62f07521@gandalf.local.home>
In-Reply-To: <1563831780-14888-1-git-send-email-george_davis@mentor.com>
References: <1563831780-14888-1-git-send-email-george_davis@mentor.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm, get_maintainers.pl fails to get the people I think should be
maintaining include/trace/events/kmem.h. 

On Mon, 22 Jul 2019 17:42:59 -0400
"George G. Davis" <george_davis@mentor.com> wrote:

> While attempting to debug slub freelist pointer corruption bugs
> caused by a module, I discovered that the kmem call_site addresses are
> not at all user friendly for modules unless you manage to save a copy
> of kallsyms for the running kernel beforehand.
> 
> So convert kmem call_site addresses to user friendly symbols which is
> especially helpful for module callers when you don't have a copy of
> kallsyms for the running kernel.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I can take this if nobody else does.

-- Steve


> ---
> Change history:
> v1:
> - First submission
> v2:
> - Fix kbuild test robot issues as suggested by
>   Steven Rostedt.
> ---
>  include/trace/events/kmem.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index eb57e3037deb..09e1eeb4e44d 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -35,8 +35,8 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>  		__entry->gfp_flags	= gfp_flags;
>  	),
>  
> -	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
> -		__entry->call_site,
> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
> +		(void *)__entry->call_site,
>  		__entry->ptr,
>  		__entry->bytes_req,
>  		__entry->bytes_alloc,
> @@ -88,8 +88,8 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
>  		__entry->node		= node;
>  	),
>  
> -	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
> -		__entry->call_site,
> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
> +		(void *)__entry->call_site,
>  		__entry->ptr,
>  		__entry->bytes_req,
>  		__entry->bytes_alloc,
> @@ -131,7 +131,8 @@ DECLARE_EVENT_CLASS(kmem_free,
>  		__entry->ptr		= ptr;
>  	),
>  
> -	TP_printk("call_site=%lx ptr=%p", __entry->call_site, __entry->ptr)
> +	TP_printk("call_site=%pS ptr=%p",
> +		(void *)__entry->call_site, __entry->ptr)
>  );
>  
>  DEFINE_EVENT(kmem_free, kfree,

