Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F6C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C0A2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfEFOzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:55:37 -0400
Received: from relay.sw.ru ([185.231.240.75]:34188 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbfEFOze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:55:34 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hNf1e-0004AM-FZ; Mon, 06 May 2019 17:55:30 +0300
Subject: Re: [PATCH 4.9 09/62] kasan: turn on
 -fsanitize-address-use-after-scope
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190506143051.102535767@linuxfoundation.org>
 <20190506143051.888762392@linuxfoundation.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6636d7cf-03fe-e253-f981-e07d75858b33@virtuozzo.com>
Date:   Mon, 6 May 2019 17:55:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506143051.888762392@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/19 5:32 PM, Greg Kroah-Hartman wrote:
> From: Andrey Ryabinin <aryabinin@virtuozzo.com>
> 
> commit c5caf21ab0cf884ef15b25af234f620e4a233139 upstream.
> 
> In the upcoming gcc7 release, the -fsanitize=kernel-address option at
> first implied new -fsanitize-address-use-after-scope option.  This would
> cause link errors on older kernels because they don't have two new
> functions required for use-after-scope support.  Therefore, gcc7 changed
> default to -fno-sanitize-address-use-after-scope.
> 
> Now the kernel has everything required for that feature since commit
> 828347f8f9a5 ("kasan: support use-after-scope detection").  So, to make it
> work, we just have to enable use-after-scope in CFLAGS.
> 
> Link: http://lkml.kernel.org/r/1481207977-28654-1-git-send-email-aryabinin@virtuozzo.com
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  scripts/Makefile.kasan |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -29,6 +29,8 @@ else
>      endif
>  endif
>  
> +CFLAGS_KASAN += $(call cc-option, -fsanitize-address-use-after-scope)
> +
>  CFLAGS_KASAN_NOSANITIZE := -fno-builtin
>  
>  endif
> 
> 

This shouldn't be in the -stable.
