Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3667C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8F320855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUM1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:27:17 -0500
Received: from relay.sw.ru ([185.231.240.75]:49600 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfKUM1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:27:17 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iXlXu-00015y-97; Thu, 21 Nov 2019 15:26:50 +0300
Subject: Re: [PATCH v4 1/2] kasan: detect negative size in memory operation
 function
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
References: <20191112065302.7015-1-walter-zh.wu@mediatek.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <040479c3-6f96-91c6-1b1a-9f3e947dac06@virtuozzo.com>
Date:   Thu, 21 Nov 2019 15:26:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191112065302.7015-1-walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/19 9:53 AM, Walter Wu wrote:

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 6814d6d6a023..4bfce0af881f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
>  #undef memset
>  void *memset(void *addr, int c, size_t len)
>  {
> -	check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> +	if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> +		return NULL;
>  
>  	return __memset(addr, c, len);
>  }
> @@ -110,8 +111,9 @@ void *memset(void *addr, int c, size_t len)
>  #undef memmove
>  void *memmove(void *dest, const void *src, size_t len)
>  {
> -	check_memory_region((unsigned long)src, len, false, _RET_IP_);
> -	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> +	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> +	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> +		return NULL;
>  
>  	return __memmove(dest, src, len);
>  }
> @@ -119,8 +121,9 @@ void *memmove(void *dest, const void *src, size_t len)
>  #undef memcpy
>  void *memcpy(void *dest, const void *src, size_t len)
>  {
> -	check_memory_region((unsigned long)src, len, false, _RET_IP_);
> -	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> +	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> +	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> +		return NULL;
>  

I realized that we are going a wrong direction here. Entirely skipping mem*() operation on any
poisoned shadow value might only make things worse. Some bugs just don't have any serious consequences,
but skipping the mem*() ops entirely might introduce such consequences, which wouldn't happen otherwise.

So let's keep this code as this, no need to check the result of check_memory_region().


