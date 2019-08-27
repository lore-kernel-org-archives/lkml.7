Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3112CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0013E2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZK51FUwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfH0WuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:50:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45150 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfH0WuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:50:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so678989qki.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 15:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wvbxx4ccqSopo6dw1T9H2ot9rAMHA6WLEPDaHjHucJY=;
        b=ZK51FUwvHLccMgAA0yWjpHkLs4LFcK2g5UlZlz76bZcr7FZPe2gjulNbPgD0jnIyar
         XXNn9AS3YfLa6c8O1XeFpP5YJXbcLHD4VcvJEtpEKVjcit7ToBwdJn7yqNz2POkatc6L
         ncshO5DzUExnF8JCtaP1I3KWUBarRmFWt9q0XNKiBE49HzCXPI2p1xxXOe04ytzaMFpn
         dnrKpg6aQBozNfP03E/nvYIxXNjYKB3Qx2GJCg5gytAUq0CSVOryjn/VA6GX4L3+of9e
         mmre0FUekO9C8vzem6bChjRnbmQziqa31OY44dR7wF2ErUekuM7GwNU3EwayaSQJ/GwU
         Ungg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wvbxx4ccqSopo6dw1T9H2ot9rAMHA6WLEPDaHjHucJY=;
        b=Kb1NadhitlUezwBVlpt+lUAoUdTCHFNeJED9yW2Ye6Z1QFl3uIpPNmBTBZoqQYPiab
         TK9vcDbyHNf4kpBil8GZi/m7Ri3ekcQBa6DqeY5IYhSKF0w9p9xMOAhBMGgGTNTTlFoW
         2OSr2JV/LoB2n1T67iE5zetroMso0kYN6LZLvKmxIH370sPx99W/gIYxo8ziD0DxxdQz
         g5YvGFiQB2LqWKhUQxm9oe8kaVbX2UspPDuHdTdWJMwAZC9tnh0R2GrxcuABxDvhDfP1
         f5oI1syZVIMmBt2wJSj3OOJG9dhmWkGJ4cCuBX+lqdED4drazTSS68SdZuSm3QDhQc5+
         nDGg==
X-Gm-Message-State: APjAAAWJNnNSrKucVeTeNVetY4qxbj35Dhg/oBOTG2XeMproHwmBvlZR
        38C8j0spkG34XUdZmypCUwownA==
X-Google-Smtp-Source: APXvYqxqh4ld+dCY1F+Gxi2MvhzLzUFGX5vkgAecdyGzetWgXsgxRnoQk74kx0sQLjgzbiYeDG4CYw==
X-Received: by 2002:a05:620a:1181:: with SMTP id b1mr1065290qkk.390.1566946203681;
        Tue, 27 Aug 2019 15:50:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id n21sm267524qtc.70.2019.08.27.15.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 15:50:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2kHq-0002zw-Kb; Tue, 27 Aug 2019 19:50:02 -0300
Date:   Tue, 27 Aug 2019 19:50:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/5] kernel.h: Add non_block_start/end()
Message-ID: <20190827225002.GB30700@ziepe.ca>
References: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
 <20190826201425.17547-4-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826201425.17547-4-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 4fa360a13c1e..82f84cfe372f 100644
> +++ b/include/linux/kernel.h
> @@ -217,7 +217,9 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
>   * might_sleep - annotation for functions that can sleep
>   *
>   * this macro will print a stack trace if it is executed in an atomic
> - * context (spinlock, irq-handler, ...).
> + * context (spinlock, irq-handler, ...). Additional sections where blocking is
> + * not allowed can be annotated with non_block_start() and non_block_end()
> + * pairs.
>   *
>   * This is a useful debugging help to be able to catch problems early and not
>   * be bitten later when the calling function happens to sleep when it is not
> @@ -233,6 +235,25 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
>  # define cant_sleep() \
>  	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
>  # define sched_annotate_sleep()	(current->task_state_change = 0)
> +/**
> + * non_block_start - annotate the start of section where sleeping is prohibited
> + *
> + * This is on behalf of the oom reaper, specifically when it is calling the mmu
> + * notifiers. The problem is that if the notifier were to block on, for example,
> + * mutex_lock() and if the process which holds that mutex were to perform a
> + * sleeping memory allocation, the oom reaper is now blocked on completion of
> + * that memory allocation. Other blocking calls like wait_event() pose similar
> + * issues.
> + */
> +# define non_block_start() \
> +	do { current->non_block_count++; } while (0)
> +/**
> + * non_block_end - annotate the end of section where sleeping is prohibited
> + *
> + * Closes a section opened by non_block_start().
> + */
> +# define non_block_end() \
> +	do { WARN_ON(current->non_block_count-- == 0); } while (0)

check-patch does not like these, and I agree

#101: FILE: include/linux/kernel.h:248:
+# define non_block_start() \
+	do { current->non_block_count++; } while (0)

/tmp/tmp1spfxufy/0006-kernel-h-Add-non_block_start-end-.patch:108: WARNING: Single statement macros should not use a do {} while (0) loop
#108: FILE: include/linux/kernel.h:255:
+# define non_block_end() \
+	do { WARN_ON(current->non_block_count-- == 0); } while (0)

Please use a static inline?

Also, can we get one more ack on this patch?

Jason
