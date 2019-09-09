Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1826C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08A220863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfIIPIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:08:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfIIPIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:08:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7039AFBB;
        Mon,  9 Sep 2019 15:08:38 +0000 (UTC)
Subject: Re: [PATCH 4/5] mm, slab_common: Make 'type' is enum
 kmalloc_cache_type
To:     Pengfei Li <lpf.vector@gmail.com>, akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190903160430.1368-1-lpf.vector@gmail.com>
 <20190903160430.1368-5-lpf.vector@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <02c8e192-542c-4225-4718-67cc00f4dc17@suse.cz>
Date:   Mon, 9 Sep 2019 17:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903160430.1368-5-lpf.vector@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 6:04 PM, Pengfei Li wrote:
> The 'type' of the function new_kmalloc_cache should be
> enum kmalloc_cache_type instead of int, so correct it.

OK

> Signed-off-by: Pengfei Li <lpf.vector@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   mm/slab_common.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8b542cfcc4f2..af45b5278fdc 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1192,7 +1192,7 @@ void __init setup_kmalloc_cache_index_table(void)
>   }
>   
>   static void __init
> -new_kmalloc_cache(int idx, int type, slab_flags_t flags)
> +new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>   {
>   	if (type == KMALLOC_RECLAIM)
>   		flags |= SLAB_RECLAIM_ACCOUNT;
> @@ -1210,7 +1210,8 @@ new_kmalloc_cache(int idx, int type, slab_flags_t flags)
>    */
>   void __init create_kmalloc_caches(slab_flags_t flags)
>   {
> -	int i, type;
> +	int i;
> +	enum kmalloc_cache_type type;
>   
>   	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
>   		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
> 

