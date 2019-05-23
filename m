Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D24CC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06412081C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfEWIwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:52:50 -0400
Received: from relay.sw.ru ([185.231.240.75]:35024 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWIwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:52:49 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hTjSu-0000Q9-Mk; Thu, 23 May 2019 11:52:44 +0300
Subject: Re: [PATCH v2] kasan: Initialize tag to 0xff in __kasan_kmalloc
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
References: <20190502153538.2326-1-natechancellor@gmail.com>
 <20190502163057.6603-1-natechancellor@gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <126d5884-b906-f85b-e893-a6a30ac0082c@virtuozzo.com>
Date:   Thu, 23 May 2019 11:53:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190502163057.6603-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/19 7:30 PM, Nathan Chancellor wrote:
> When building with -Wuninitialized and CONFIG_KASAN_SW_TAGS unset, Clang
> warns:
> 
> mm/kasan/common.c:484:40: warning: variable 'tag' is uninitialized when
> used here [-Wuninitialized]
>         kasan_unpoison_shadow(set_tag(object, tag), size);
>                                               ^~~
> 
> set_tag ignores tag in this configuration but clang doesn't realize it
> at this point in its pipeline, as it points to arch_kasan_set_tag as
> being the point where it is used, which will later be expanded to
> (void *)(object) without a use of tag. Initialize tag to 0xff, as it
> removes this warning and doesn't change the meaning of the code.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/465
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Fixes: 7f94ffbc4c6a ("kasan: add hooks implementation for tag-based mode")
Cc: <stable@vger.kernel.org>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

> ---
> 
> v1 -> v2:
> 
> * Initialize tag to 0xff at Andrey's request
> 
>  mm/kasan/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 36afcf64e016..242fdc01aaa9 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -464,7 +464,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  {
>  	unsigned long redzone_start;
>  	unsigned long redzone_end;
> -	u8 tag;
> +	u8 tag = 0xff;
>  
>  	if (gfpflags_allow_blocking(flags))
>  		quarantine_reduce();
> 
