Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD81C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B4A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfCYULR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfCYULR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:11:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31CAC20863;
        Mon, 25 Mar 2019 20:11:16 +0000 (UTC)
Date:   Mon, 25 Mar 2019 16:11:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     mingo@redhat.com, roopa@cumulusnetworks.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: events: fix  error directive in argument list
Message-ID: <20190325161114.6a54bed0@gandalf.local.home>
In-Reply-To: <20190325195303.GA20629@hari-Inspiron-1545>
References: <20190325195303.GA20629@hari-Inspiron-1545>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 01:23:03 +0530
Hariprasad Kelam <hariprasad.kelam@gmail.com> wrote:


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

Not sure why the added pin6 assignment was there to begin with:

<code-snippet>
                pin6 = (struct in6_addr *)__entry->primary_key6;
                p32 = (__be32 *)__entry->primary_key4;

                if (n->tbl->family == AF_INET)
                        *p32 = *(__be32 *)n->primary_key;
                else
                        *p32 = 0;

#if IS_ENABLED(CONFIG_IPV6)
                if (n->tbl->family == AF_INET6) {
                        pin6 = (struct in6_addr *)__entry->primary_key6;
                        *pin6 = *(struct in6_addr *)n->primary_key;
                } else
#endif
                {
                        ipv6_addr_set_v4mapped(*p32, pin6);
                }
</code-snippet>

It was already assigned. Looks fine to me, at least from a tracing
point of view.

-- Steve
