Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94519C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6861620449
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfCEQNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:13:47 -0500
Received: from relay.sw.ru ([185.231.240.75]:34556 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfCEQNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:13:46 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1h1ChE-0006No-Bx; Tue, 05 Mar 2019 19:13:36 +0300
Subject: Re: [PATCH] kasan: fix coccinelle warnings in kasan_p*_table
To:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kostya Serebryany <kcc@google.com>,
        kbuild test robot <lkp@intel.com>
References: <1fa6fadf644859e8a6a8ecce258444b49be8c7ee.1551716733.git.andreyknvl@google.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <67536e1d-2819-553d-521c-bae21a51e0f7@virtuozzo.com>
Date:   Tue, 5 Mar 2019 19:14:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <1fa6fadf644859e8a6a8ecce258444b49be8c7ee.1551716733.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/19 8:04 PM, Andrey Konovalov wrote:
> kasan_p4d_table, kasan_pmd_table and kasan_pud_table are declared as
> returning bool, but return 0 instead of false, which produces a coccinelle
> warning. Fix it.
> 
> Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>


>  mm/kasan/init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index 45a1b5e38e1e..fcaa1ca03175 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -42,7 +42,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
>  #else
>  static inline bool kasan_p4d_table(pgd_t pgd)
>  {
> -	return 0;
> +	return false;
>  }
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 3
> @@ -54,7 +54,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
>  #else
>  static inline bool kasan_pud_table(p4d_t p4d)
>  {
> -	return 0;
> +	return false;
>  }
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 2
> @@ -66,7 +66,7 @@ static inline bool kasan_pmd_table(pud_t pud)
>  #else
>  static inline bool kasan_pmd_table(pud_t pud)
>  {
> -	return 0;
> +	return false;
>  }
>  #endif
>  pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
> 
