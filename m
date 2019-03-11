Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A629CC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A5721773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UiFtWTE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfCKQch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:32:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46082 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:32:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id i5so3065283qkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pyQXcLatuiGi/bo6uxJQUtm3dUmwK7WB5Ls/qmNHhso=;
        b=UiFtWTE1bEHCF2u3/E+AHCJsZr1xHyCgmuO83rSAJ75cHRKVt7ZV7WFfEifuAI5DAg
         JEHST3DheMpzW9st3pHb2jWx/2NzQeFxTxZ3x6eUFokWc1vhDU4RTGQQohR4PNKiuJMx
         mnPqswekcDWQ/SHL6b7Nm97cSTd/UZOu6mPNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pyQXcLatuiGi/bo6uxJQUtm3dUmwK7WB5Ls/qmNHhso=;
        b=sQ9UT7yp7RqRzauSoJwCk9cBQHEMjV7pTTZgi7ein4DwQuu0GuOueEXauJGczZLFtI
         9dOsNkxv9xQmb7Rvnzm/YpY/OVE/Cqq4uaQWAspMG0L9t8kLl0qJoDNBD5lNUsKQNK+D
         QL9s3zw83WIk1aJjPSU/oF5AYpr0qnGxpxKfA3y7U6B+b326fV485reTKukBmAH+lZ3y
         6L1t7ej0lCiovuWK9mrgt92m7KQdCNDIByRyzdCjech/19/woJvbDi2d6+f0NG7faK0Z
         QaypwsbDVThyvfHJm55PovlXCQ2uK362g4NS6pWRLnBxLcu2iqRCnuXZrOdhFXDFlthz
         60tg==
X-Gm-Message-State: APjAAAU55R/na3ERiy/jsd/JfNjedJlXnLs8WSHF15Psgc2Wf1GQvbV8
        BUUhMlMDOZ6Io3DchF/qiUJaxw==
X-Google-Smtp-Source: APXvYqxC/RiGc1suxXWZsaP2ROw/MyYAIx55Y8nZU9zXj9fZPIx0Tp4vCZU3eG8qbd82nyJDKL4R5g==
X-Received: by 2002:ae9:e901:: with SMTP id x1mr25640741qkf.124.1552321955265;
        Mon, 11 Mar 2019 09:32:35 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id e4sm4037396qta.84.2019.03.11.09.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 09:32:34 -0700 (PDT)
Date:   Mon, 11 Mar 2019 12:32:33 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>, mhocko@kernel.org,
        vbabka@suse.cz, hannes@cmpxchg.org
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190311163233.GA34252@google.com>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310203403.27915-1-sultan@kerneltoast.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 01:34:03PM -0700, Sultan Alsawaf wrote:
[...]
>  
>  	/* Perform scheduler related setup. Assign this task to a CPU. */
>  	retval = sched_fork(clone_flags, p);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3eb01dedf..fd0d697c6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -67,6 +67,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/nmi.h>
>  #include <linux/psi.h>
> +#include <linux/simple_lmk.h>
>  
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
> @@ -967,6 +968,11 @@ static inline void __free_one_page(struct page *page,
>  		}
>  	}
>  
> +#ifdef CONFIG_ANDROID_SIMPLE_LMK
> +	if (simple_lmk_page_in(page, order, migratetype))
> +		return;
> +#endif
> +
>  	list_add(&page->lru, &zone->free_area[order].free_list[migratetype]);
>  out:
>  	zone->free_area[order].nr_free++;
> @@ -4427,6 +4433,13 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
>  		goto nopage;
>  
> +#ifdef CONFIG_ANDROID_SIMPLE_LMK
> +	page = simple_lmk_oom_alloc(order, ac->migratetype);
> +	if (page)
> +		prep_new_page(page, order, gfp_mask, alloc_flags);
> +	goto got_pg;
> +#endif
> +

Hacking generic MM code with Android-specific callback is probably a major
issue with your patch. Also I CC'd -mm maintainers and lists since your patch
touches page_alloc.c. Always run get_maintainer.pl before sending a patch. I
added them this time.

Have you looked at the recent PSI work that Suren and Johannes have been
doing [1]?  As I understand, userspace lmkd may be migrated to use that at some
point.  Suren can provide more details. I am sure AOSP contributions to make
LMKd better by using the PSI backend would be appreciated. Please consider
collaborating on that and help out, thanks. Check the cover-letter of that
patch [1] where LMKd is mentioned.

thanks,

 - Joel

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1951257.html

