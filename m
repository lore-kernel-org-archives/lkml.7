Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F39C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBDA206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfIIOy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfIIOy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:54:27 -0400
Received: from oasis.local.home (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAF2C206CD;
        Mon,  9 Sep 2019 14:54:25 +0000 (UTC)
Date:   Mon, 9 Sep 2019 10:54:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: simplify ftrace hash lookup code
Message-ID: <20190909105424.6769b552@oasis.local.home>
In-Reply-To: <20190909003159.10574-1-changbin.du@gmail.com>
References: <20190909003159.10574-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Sep 2019 08:31:59 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> Function ftrace_lookup_ip() will check empty hash table. So we don't
> need extra check outside.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> ---
> v2: fix incorrect code remove.
> ---
>  kernel/trace/ftrace.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f9821a3374e9..92aab854d3b1 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1463,8 +1463,7 @@ static bool hash_contains_ip(unsigned long ip,
>  	 */
>  	return (ftrace_hash_empty(hash->filter_hash) ||
>  		__ftrace_lookup_ip(hash->filter_hash, ip)) &&
> -		(ftrace_hash_empty(hash->notrace_hash) ||
> -		 !__ftrace_lookup_ip(hash->notrace_hash, ip));
> +	       !ftrace_lookup_ip(hash->notrace_hash, ip);

I don't care for this part. I've nacked this change in the past. Why?
let's compare the changes:

	return (ftrace_hash_empty(hash->filter_hash) ||
		__ftrace_lookup_ip(hash->filter_hash, ip)) &&
		(ftrace_hash_empty(hash->notrace_hash) ||
		 !__ftrace_lookup_ip(hash->notrace_hash, ip));

 vs:

	return (ftrace_hash_empty(hash->filter_hash) ||
		__ftrace_lookup_ip(hash->filter_hash, ip)) &&
		!ftrace_lookup_ip(hash->notrace_hash, ip);

The issue I have with this is that it abstracts out the difference
between the filter_hash and the notrace_hash. Sometimes open coded
works better if it is compared to something that is similar.

The current code I see:

	Return true if (filter_hash is empty or ip exists in filter_hash
		 and notrace_hash is empty or it does not exist in notrace_hash

With your update I see:

	Return true if filter_hash is empty or ip exists in filter_hash
                and ip does not exist in notrace_hash

It makes it not easy to see if what happens if notrace_hash is empty

Hmm, come to think of it, perhaps we should change ftrace_lookup_ip()
to include what to do on empty.

Maybe:

bool ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip, bool empty_result)
{
	if (ftrace_hash_empty(hash))
		return empty_result;

	return __ftrace_lookup_ip(hash, ip);
}

Then we can change the above to:

	return ftrace_lookup_ip(hash->filter_hash, ip, true) &&
	       !ftrace_lookup_ip(hash->notrace_hash, ip, false);

That would probably work better.

Want to send that update?

-- Steve


>  }
>  
>  /*
> @@ -6036,11 +6035,7 @@ clear_func_from_hash(struct ftrace_init_func
> *func, struct ftrace_hash *hash) {
>  	struct ftrace_func_entry *entry;
>  
> -	if (ftrace_hash_empty(hash))
> -		return;
> -
> -	entry = __ftrace_lookup_ip(hash, func->ip);
> -
> +	entry = ftrace_lookup_ip(hash, func->ip);
>  	/*
>  	 * Do not allow this rec to match again.
>  	 * Yeah, it may waste some memory, but will be removed

