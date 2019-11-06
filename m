Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437A0C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126402075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfKFJAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:00:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:56526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726903AbfKFJAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:00:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B67A1B24B;
        Wed,  6 Nov 2019 09:00:00 +0000 (UTC)
Date:   Wed, 6 Nov 2019 09:59:59 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ioannis Ilkos <ilkos@google.com>,
        minchan@google.com, primiano@google.com, fmayer@google.com,
        hjd@google.com, joaodias@google.com, joelaf@google.com,
        lalitm@google.com, rslawik@google.com, sspatil@google.com,
        timmurray@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rss_stat: Add support to detect RSS updates of external
 mm
Message-ID: <20191106085959.ae2dgvmny3njnk7n@pathway.suse.cz>
References: <20191106024452.81923-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106024452.81923-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-11-05 21:44:51, Joel Fernandes (Google) wrote:
> Also vsprintf.c is refactored a bit to allow reuse of hashing code.

I agree with Sergey that it would make sense to move this outside
vsprintf.c.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index dee8fc467fcf..401baaac1813 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -761,11 +761,34 @@ static int __init initialize_ptr_random(void)
>  early_initcall(initialize_ptr_random);
>  
>  /* Maps a pointer to a 32 bit unique identifier. */
> +int ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
> +{
> +	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";

str is unused.

> +	unsigned long hashval;

IMHO, this local variable unnecessarily complicates the code.
I would use the pointer directly and let compiler to optimize.

> +	if (static_branch_unlikely(&not_filled_random_ptr_key))
> +		return -EAGAIN;
> +
> +#ifdef CONFIG_64BIT
> +	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
> +	/*
> +	 * Mask off the first 32 bits, this makes explicit that we have
> +	 * modified the address (and 32 bits is plenty for a unique ID).
> +	 */
> +	hashval = hashval & 0xffffffff;
> +#else
> +	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
> +#endif
> +	*hashval_out = hashval;
> +	return 0;
> +}

Best Regards,
Petr
