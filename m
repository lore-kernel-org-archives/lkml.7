Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4ADC73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B55521537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5PzqdSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfGIO7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:59:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50917 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGIO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:59:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so3455240wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N67Qa6q9CITh5hKRJQifXm/LEYOhI8c6TcpZdYd27zA=;
        b=I5PzqdSHsvp5rRiQg3IHSmXPUNbpfzjZCJWETQgBq0gGsY2dpSwITCpqwfNyNu4SQu
         Nwlk8JtsMvbxgY9Km67zmwGKh+YHkPSZytNXGX7RVmoGPcnIfOJkQrFpCK/MmlaTt9X7
         Bb3qZba9bfRr0/BAyZzIsVaZaBTGifOpOdr8mgjoXqZiYnXkZ/bEzzlnN9hgvRd0OSKY
         OjcCPcO6DyEFUUq5gh6YIEcj9ZOv26RKmAEUBnsXv5kleW+sQfik2d2Q1fnj6V5VomEd
         CnJfkLzQzLxjCdd1w4u6UhmFu70ZwXTcYNBqe3mWXw3aHXJpp2PNK0GixoX9+JT9sZrp
         ydkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N67Qa6q9CITh5hKRJQifXm/LEYOhI8c6TcpZdYd27zA=;
        b=CH/mctkEk543piaFOcYcpkXOKif2td/bLSWFNt3+S6BoOyLNxQ5YjBaDQTuuRD+gzi
         7ae6oB/LvtYeGrH4BkWVxm1U+KiiOrPy7z4+GLk5M8rIzEokK/bPokX74JVXKigRF/PB
         kQo+SLN5gu7bM2Bu41hjQyzF4s2TaINu/ZhK1swXudUDCCpZiqtaZKbUU+48N7B+YVmP
         t/lC4/+8CnZWQExE+wJF3AYINI341mRhcNLUHj6CtQ9aOcI45vs6x+OZhPpWObBgKwlC
         AyNdbYUyjtkCp3mxT3Ey/ZBgiPxA7sxcxymqzfEuK+GRT72ezhPg8TjnjSh6Iyh9FAAJ
         yQUA==
X-Gm-Message-State: APjAAAWdeN6wu0hcu11qwCkXrPfAsCwkKSx3yiDzgc74kKX8iDnhbndg
        aVquJDqPl9ycohvio2WwpT2T/g==
X-Google-Smtp-Source: APXvYqzNFbm8ko779athQfkca7KYeM7dPD+SSU+3KMi9EyHqgswDqcv64VrseTODuZghVuVmRqSeQA==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr390611wmm.108.1562684386373;
        Tue, 09 Jul 2019 07:59:46 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v4sm2986480wmg.22.2019.07.09.07.59.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:59:45 -0700 (PDT)
Date:   Tue, 9 Jul 2019 15:59:43 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: [PATCH] kgdb: Don't use a notifier to enter kgdb at panic; call
 directly
Message-ID: <20190709145943.zfwvs7inlngtxwfe@holly.lan>
References: <20190703170354.217312-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703170354.217312-1-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 10:03:54AM -0700, Douglas Anderson wrote:
> Right now kgdb/kdb hooks up to debug panics by registering for the
> panic notifier.  This works OK except that it means that kgdb/kdb gets
> called _after_ the CPUs in the system are taken offline.  That means
> that if anything important was happening on those CPUs (like something
> that might have contributed to the panic) you can't debug them.
> 
> Specifically I ran into a case where I got a panic because a task was
> "blocked for more than 120 seconds" which was detected on CPU 2.  I
> nicely got shown stack traces in the kernel log for all CPUs including
> CPU 0, which was running 'PID: 111 Comm: kworker/0:1H' and was in the
> middle of __mmc_switch().
> 
> I then ended up at the kdb prompt where switched over to kgdb to try
> to look at local variables of the process on CPU 0.  I found that I
> couldn't.  Digging more, I found that I had no info on any tasks
> running on CPUs other than CPU 2 and that asking kdb for help showed
> me "Error: no saved data for this cpu".  This was because all the CPUs
> were offline.
> 
> Let's move the entry of kdb/kgdb to a direct call from panic() and
> stop using the generic notifier.  Putting a direct call in allows us
> to order things more properly and it also doesn't seem like we're
> breaking any abstractions by calling into the debugger from the panic
> function.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

This patch changes the way kdump and kgdb interact with each other.
However it would seem rather odd to have both tools simultaneously
armed and, even if they were, the user still has the option to
use panic_timeout to force a kdump to happen. Thus I think the
change of order is acceptable:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> diff --git a/kernel/panic.c b/kernel/panic.c
> index 4d9f55bf7d38..e2971168b059 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -12,6 +12,7 @@
>  #include <linux/debug_locks.h>
>  #include <linux/sched/debug.h>
>  #include <linux/interrupt.h>
> +#include <linux/kgdb.h>
>  #include <linux/kmsg_dump.h>
>  #include <linux/kallsyms.h>
>  #include <linux/notifier.h>
> @@ -219,6 +220,13 @@ void panic(const char *fmt, ...)
>  		dump_stack();
>  #endif
>  
> +	/*
> +	 * If kgdb is enabled, give it a chance to run before we stop all
> +	 * the other CPUs or else we won't be able to debug processes left
> +	 * running on them.
> +	 */
> +	kgdb_panic(buf);
> +
>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
>  	 * everything else.
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
