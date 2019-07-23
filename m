Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE76C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F60520838
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbfGWQYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:24:11 -0400
Received: from foss.arm.com ([217.140.110.172]:57322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfGWQYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:24:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25DE3337;
        Tue, 23 Jul 2019 09:24:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736473F71A;
        Tue, 23 Jul 2019 09:24:08 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:24:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 2/2] lib/test_kasan: Add stack overflow test
Message-ID: <20190723162403.GA56959@lakrids.cambridge.arm.com>
References: <20190719132818.40258-1-elver@google.com>
 <20190719132818.40258-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719132818.40258-2-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 03:28:18PM +0200, Marco Elver wrote:
> Adds a simple stack overflow test, to check the error being reported on
> an overflow. Without CONFIG_STACK_GUARD_PAGE, the result is typically
> some seemingly unrelated KASAN error message due to accessing random
> other memory.

Can't we use the LKDTM_EXHAUST_STACK case to check this?

I was also under the impression that the other KASAN self-tests weren't
fatal, and IIUC this will kill the kernel.

Given that, and given this is testing non-KASAN functionality, I'm not
sure it makes sense to bundle this with the KASAN tests.

Thanks,
Mark.

> 
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kasan-dev@googlegroups.com
> ---
>  lib/test_kasan.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index b63b367a94e8..3092ec01189d 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -15,6 +15,7 @@
>  #include <linux/mman.h>
>  #include <linux/module.h>
>  #include <linux/printk.h>
> +#include <linux/sched/task_stack.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> @@ -709,6 +710,32 @@ static noinline void __init kmalloc_double_kzfree(void)
>  	kzfree(ptr);
>  }
>  
> +#ifdef CONFIG_STACK_GUARD_PAGE
> +static noinline void __init stack_overflow_via_recursion(void)
> +{
> +	volatile int n = 512;
> +
> +	BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROWSUP));
> +
> +	/* About to overflow: overflow via alloca'd array and try to write. */
> +	if (!object_is_on_stack((void *)&n - n)) {
> +		volatile char overflow[n];
> +
> +		overflow[0] = overflow[0];
> +		return;
> +	}
> +
> +	stack_overflow_via_recursion();
> +}
> +
> +static noinline void __init kasan_stack_overflow(void)
> +{
> +	pr_info("stack overflow begin\n");
> +	stack_overflow_via_recursion();
> +	pr_info("stack overflow end\n");
> +}
> +#endif
> +
>  static int __init kmalloc_tests_init(void)
>  {
>  	/*
> @@ -753,6 +780,15 @@ static int __init kmalloc_tests_init(void)
>  	kasan_bitops();
>  	kmalloc_double_kzfree();
>  
> +#ifdef CONFIG_STACK_GUARD_PAGE
> +	/*
> +	 * Only test with CONFIG_STACK_GUARD_PAGE, as without we get other
> +	 * random KASAN violations, due to accessing other random memory (we
> +	 * want to avoid actually corrupting memory in these tests).
> +	 */
> +	kasan_stack_overflow();
> +#endif
> +
>  	kasan_restore_multi_shot(multishot);
>  
>  	return -EAGAIN;
> -- 
> 2.22.0.657.g960e92d24f-goog
> 
