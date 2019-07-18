Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86ADC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A88121852
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfGRQSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:18:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:41000 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfGRQSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:18:25 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1ho96r-000845-Ln; Thu, 18 Jul 2019 19:18:21 +0300
Subject: Re: [PATCH] kasan: push back KASAN_STACK detection to clang-10
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, Mark Brown <broonie@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20190718141503.3258299-1-arnd@arndb.de>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <0ee5952b-5a76-c8a5-a30a-ee3c46a54814@virtuozzo.com>
Date:   Thu, 18 Jul 2019 19:18:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718141503.3258299-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/19 5:14 PM, Arnd Bergmann wrote:
> asan-stack mode still uses dangerously large kernel stacks of
> tens of kilobytes in some drivers, and it does not seem that anyone
> is working on the clang bug.
> 
> Let's push this back to clang-10 for now so users don't run into
> this by accident, and we can test-build allmodconfig kernels using
> clang-9 without drowning in warnings.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=38809
> Fixes: 6baec880d7a5 ("kasan: turn off asan-stack for clang-8 and earlier")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/Kconfig.kasan | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 4fafba1a923b..2f260bb63d77 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -106,7 +106,7 @@ endchoice
>  
>  config KASAN_STACK_ENABLE
>  	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> -	default !(CLANG_VERSION < 90000)
> +	default !(CLANG_VERSION < 100000)

Wouldn't be better to make this thing for any clang version? And only when the bug is
finally fixed, specify the clang version which can enable this safely.


>  	depends on KASAN
>  	help
>  	  The LLVM stack address sanitizer has a know problem that
> 
