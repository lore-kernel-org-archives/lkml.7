Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCDEC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02E420880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfDONXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:23:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfDONXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:23:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CBAB3092648;
        Mon, 15 Apr 2019 13:23:47 +0000 (UTC)
Received: from treble (ovpn-120-105.rdu2.redhat.com [10.10.120.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B92060150;
        Mon, 15 Apr 2019 13:23:43 +0000 (UTC)
Date:   Mon, 15 Apr 2019 08:23:39 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch V4 01/32] mm/slab: Fix broken stack trace storage
Message-ID: <20190415132339.wiqyzygqklliyml7@treble>
References: <20190414155936.679808307@linutronix.de>
 <20190414160143.591255977@linutronix.de>
 <CALCETrUhVc_u3HL-x7wMnk9ukEbwQPvc9N5Na-Q55se0VwcCpw@mail.gmail.com>
 <alpine.DEB.2.21.1904141832400.4917@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1904151101100.1729@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904151101100.1729@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 15 Apr 2019 13:23:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:02:58AM +0200, Thomas Gleixner wrote:
> kstack_end() is broken on interrupt stacks as they are not guaranteed to be
> sized THREAD_SIZE and THREAD_SIZE aligned.
> 
> Use the stack tracer instead. Remove the pointless pointer increment at the
> end of the function while at it.
> 
> Fixes: 98eb235b7feb ("[PATCH] page unmapping debug") - History tree
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: linux-mm@kvack.org
> ---
> V4: Made the code simpler to understand (Andy) and make it actually compile
> ---
>  mm/slab.c |   30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1470,33 +1470,31 @@ static bool is_debug_pagealloc_cache(str
>  static void store_stackinfo(struct kmem_cache *cachep, unsigned long *addr,
>  			    unsigned long caller)
>  {
> -	int size = cachep->object_size;
> +	int size = cachep->object_size / sizeof(unsigned long);
>  
>  	addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
>  
> -	if (size < 5 * sizeof(unsigned long))
> +	if (size < 5)
>  		return;
>  
>  	*addr++ = 0x12345678;
>  	*addr++ = caller;
>  	*addr++ = smp_processor_id();
> -	size -= 3 * sizeof(unsigned long);
> +	size -= 3;
> +#ifdef CONFIG_STACKTRACE
>  	{
> -		unsigned long *sptr = &caller;
> -		unsigned long svalue;
> -
> -		while (!kstack_end(sptr)) {
> -			svalue = *sptr++;
> -			if (kernel_text_address(svalue)) {
> -				*addr++ = svalue;
> -				size -= sizeof(unsigned long);
> -				if (size <= sizeof(unsigned long))
> -					break;
> -			}
> -		}
> +		struct stack_trace trace = {
> +			/* Leave one for the end marker below */
> +			.max_entries	= size - 1,
> +			.entries	= addr,
> +			.skip		= 3,
> +		};
>  
> +		save_stack_trace(&trace);
> +		addr += trace.nr_entries;
>  	}
> -	*addr++ = 0x87654321;
> +#endif
> +	*addr = 0x87654321;

Looks like stack_trace.nr_entries isn't initialized?  (though this code
gets eventually replaced by a later patch)

Who actually reads this stack trace?  I couldn't find a consumer.

-- 
Josh
