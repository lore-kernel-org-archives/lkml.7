Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB12C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F127F21924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391156AbfIIM7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:59:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbfIIM7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:59:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E08F0AFBA;
        Mon,  9 Sep 2019 12:59:13 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mm/page_ext: support to record the last stack of
 page
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <20190909085339.25350-1-walter-zh.wu@mediatek.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0fd84c7b-a23b-0b09-519f-a006fade1b4f@suse.cz>
Date:   Mon, 9 Sep 2019 14:59:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909085339.25350-1-walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/19 10:53 AM, Walter Wu wrote:
> KASAN will record last stack of page in order to help programmer
> to see memory corruption caused by page.
> 
> What is difference between page_owner and our patch?
> page_owner records alloc stack of page, but our patch is to record
> last stack(it may be alloc or free stack of page).
> 
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>

There's no point in separating this from patch 2 (and as David pointed 
out, doesn't compile).

> ---
>   mm/page_ext.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 5f5769c7db3b..7ca33dcd9ffa 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -65,6 +65,9 @@ static struct page_ext_operations *page_ext_ops[] = {
>   #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
>   	&page_idle_ops,
>   #endif
> +#ifdef CONFIG_KASAN
> +	&page_stack_ops,
> +#endif
>   };
>   
>   static unsigned long total_usage;
> 

