Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5A8C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B887D20731
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKUMxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:53:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:51612 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUMxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:53:22 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iXlxI-000251-L0; Thu, 21 Nov 2019 15:53:04 +0300
Subject: Re: [PATCH 1/3] ubsan: Add trap instrumentation option
To:     Kees Cook <keescook@chromium.org>
Cc:     Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20191120010636.27368-1-keescook@chromium.org>
 <20191120010636.27368-2-keescook@chromium.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <35fa415f-1dab-b93d-f565-f0754b886d1b@virtuozzo.com>
Date:   Thu, 21 Nov 2019 15:52:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120010636.27368-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 4:06 AM, Kees Cook wrote:


> +config UBSAN_TRAP
> +	bool "On Sanitizer warnings, stop the offending kernel thread"

That description seems inaccurate and confusing. It's not about kernel threads.
UBSAN may trigger in any context - kernel thread/user process/interrupts... 
Probably most of the kernel code runs in the context of user process, so "stop the offending kernel thread"
doesn't sound right.



> +	depends on UBSAN
> +	depends on $(cc-option, -fsanitize-undefined-trap-on-error)
> +	help
> +	  Building kernels with Sanitizer features enabled tends to grow
> +	  the kernel size by over 5%, due to adding all the debugging
> +	  text on failure paths. To avoid this, Sanitizer instrumentation
> +	  can just issue a trap. This reduces the kernel size overhead but
> +	  turns all warnings into full thread-killing exceptions.

I think we should mention that enabling this option also has a potential to 
turn some otherwise harmless bugs into more severe problems like lockups, kernel panic etc..
So the people who enable this would better understand what they signing up for.

