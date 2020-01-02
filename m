Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77906C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF62215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgABPUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgABPUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:20:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82F7206E6;
        Thu,  2 Jan 2020 15:20:36 +0000 (UTC)
Date:   Thu, 2 Jan 2020 10:20:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Junyong Sun <sunjy516@gmail.com>
Cc:     mingo@redhat.com, akpm@linux-foundation.org,
        joel@joelfernandes.org, changbin.du@intel.com,
        timmurray@google.com, sunjunyong@xiaomi.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, tracing: Print symbol name for kmem_alloc_node
 call_site events
Message-ID: <20200102102035.15441507@gandalf.local.home>
In-Reply-To: <1577949568-4518-1-git-send-email-sunjunyong@xiaomi.com>
References: <1577949568-4518-1-git-send-email-sunjunyong@xiaomi.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Jan 2020 15:19:28 +0800
Junyong Sun <sunjy516@gmail.com> wrote:

> print the call_site ip of kmem_alloc_node using '%pS' to improve
> the readability of raw slab trace points.
> 
> Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  include/trace/events/kmem.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index ad7e642b..f65b1f6 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
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

