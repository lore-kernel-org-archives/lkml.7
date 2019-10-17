Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2FBFA3733
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD47321835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408908AbfJQKjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:39:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:43456 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408885AbfJQKjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:39:33 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iL3Bf-0005sq-P7; Thu, 17 Oct 2019 13:39:19 +0300
Subject: Re: [PATCH v3 1/3] kasan: Archs don't check memmove if not support
 it.
To:     Nick Hu <nickhu@andestech.com>, alankao@andestech.com,
        paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        glider@google.com, dvyukov@google.com, corbet@lwn.net,
        alexios.zavras@intel.com, allison@lohutok.net, Anup.Patel@wdc.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        atish.patra@wdc.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
References: <cover.1570514544.git.nickhu@andestech.com>
 <c9fa9eb25a5c0b1f733494dfd439f056c6e938fd.1570514544.git.nickhu@andestech.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <ba456776-a77f-5306-60ef-c19a4a8b3119@virtuozzo.com>
Date:   Thu, 17 Oct 2019 13:39:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c9fa9eb25a5c0b1f733494dfd439f056c6e938fd.1570514544.git.nickhu@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/19 9:11 AM, Nick Hu wrote:
> Skip the memmove checking for those archs who don't support it.
 
The patch is fine but the changelog sounds misleading. We don't skip memmove checking.
If arch don't have memmove than the C implementation from lib/string.c used.
It's instrumented by compiler so it's checked and we simply don't need that KASAN's memmove with
manual checks.

> Signed-off-by: Nick Hu <nickhu@andestech.com>
> ---
>  mm/kasan/common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 6814d6d6a023..897f9520bab3 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -107,6 +107,7 @@ void *memset(void *addr, int c, size_t len)
>  	return __memset(addr, c, len);
>  }
>  
> +#ifdef __HAVE_ARCH_MEMMOVE
>  #undef memmove
>  void *memmove(void *dest, const void *src, size_t len)
>  {
> @@ -115,6 +116,7 @@ void *memmove(void *dest, const void *src, size_t len)
>  
>  	return __memmove(dest, src, len);
>  }
> +#endif
>  
>  #undef memcpy
>  void *memcpy(void *dest, const void *src, size_t len)
> 
