Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A55C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA52820449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfC0Pxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfC0Pxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:53:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B2520449;
        Wed, 27 Mar 2019 15:53:32 +0000 (UTC)
Date:   Wed, 27 Mar 2019 11:53:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     mingo@redhat.com, roopa@cumulusnetworks.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: events: fix  error directive in argument list
Message-ID: <20190327115330.04b5b481@gandalf.local.home>
In-Reply-To: <20190325195303.GA20629@hari-Inspiron-1545>
References: <20190325195303.GA20629@hari-Inspiron-1545>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 01:23:03 +0530
Hariprasad Kelam <hariprasad.kelam@gmail.com> wrote:

> This patch fixes below spare errors.
> 
> Sparse error:
> make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
> ./include/trace/events/neigh.h:73:1: error: directive in argument list
> ./include/trace/events/neigh.h:78:1: error: directive in argument list
> ./include/trace/events/neigh.h:150:1: error: directive in argument list
> ./include/trace/events/neigh.h:155:1: error: directive in argument list
> 

I have nothing really against these patches, but why is the current
code considered wrong?

Note, TRACE_EVENTS() are "special macros". They hold structure
definitions and full code inside the argument list. There should be no
reason that this is causing a warning.

Perhaps we should blacklist the include/trace directory from sparse
checking for these types of "errors".

-- Steve


> Changes below two lines to signle line to avoid sparse error
>  #if IS_ENABLED(CONFIG_IPV6)
>                if (n->tbl->family == AF_INET6) {
> to if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> 
> and removes reassigning pin6 pointer when IPV6 is enabled
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  include/trace/events/neigh.h | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
> index 0bdb085..6e310ea 100644
> --- a/include/trace/events/neigh.h
> +++ b/include/trace/events/neigh.h
> @@ -70,15 +70,11 @@ TRACE_EVENT(neigh_update,
>  		else
>  			*p32 = 0;
>  
> -#if IS_ENABLED(CONFIG_IPV6)
> -		if (n->tbl->family == AF_INET6) {
> -			pin6 = (struct in6_addr *)__entry->primary_key6;
> +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
>  			*pin6 = *(struct in6_addr *)n->primary_key;
> -		} else
> -#endif
> -		{
> +		else
>  			ipv6_addr_set_v4mapped(*p32, pin6);
> -		}
> +
>  		__entry->confirmed = n->confirmed;
>  		__entry->updated = n->updated;
>  		__entry->used = n->used;
> @@ -147,15 +143,10 @@ DECLARE_EVENT_CLASS(neigh__update,
>  		else
>  			*p32 = 0;
>  
> -#if IS_ENABLED(CONFIG_IPV6)
> -		if (n->tbl->family == AF_INET6) {
> -			pin6 = (struct in6_addr *)__entry->primary_key6;
> +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
>  			*pin6 = *(struct in6_addr *)n->primary_key;
> -		} else
> -#endif
> -		{
> +		else
>  			ipv6_addr_set_v4mapped(*p32, pin6);
> -		}
>  
>  		__entry->confirmed = n->confirmed;
>  		__entry->updated = n->updated;

