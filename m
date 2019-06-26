Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8342CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C35D214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wu+94Jch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfFZOBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:01:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38265 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfFZOB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:01:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so1656690lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x1UZPvC6jySD6bcWuGMOeB5kHfs+J7Qdhm276494Xu0=;
        b=Wu+94JchBAyS84B61JphaZAKx7TNoDFXvxUTCXPJpwQe9Tcze9sbfjU6U1XAb79Gsq
         x1jZEemqGhxFXCaIA5p08huPs0KgbiLJ7r37JohACYv/3netAPMhzi0hy9cTZ6YbIi4Q
         /56YQrdnFV1MrHINy6BEHfe7mnRTwgw9646HnDJA+6qL58YoXyagJf+2Jpm4F8LIi0gH
         zXg3LSnq1bk21qSkDoXkd4KpUwUSzedYRqbol+GPVvMBKu5Ycw4rtuXakA2deyMoJDyb
         uZXQt0oQaBZVKWg1OOKn/R/vVDC14I3Qxfy9ohKR7oWhMUzQT9YukX9gHDmS2NnJtb3K
         o2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=x1UZPvC6jySD6bcWuGMOeB5kHfs+J7Qdhm276494Xu0=;
        b=bobZgxeORcq3QD8i6N3fWCKdbRb1mFAYKAmlwvAsVitNSMEbzH+8l9I9VvcLmjnm72
         Yc1/sA0yic0n1GBWLJpy++ooah5Pr2GPUuhbPIT2WjOWUOBt+gsqA7mZDr/ok1Y5Sobn
         Gz72Cg6AqTDmEY/xwESWyAC+4fNUm33WpN4Myk/wfIUW992SdkjwCKVteq9CHSuFJdy6
         B4dpdxQ8yBR/ViR4qgk/YMmXXVkmwaBkvSLpMwa7WVpKYiUzCMgiwqE8QbSxxE9WAUXW
         L0pDQxhyy9v/7v8c1eE/zzMltYTfFmdOL9UZMK4PiwvtQgde0MSaopqLSzwmeL9CbDzP
         fBGQ==
X-Gm-Message-State: APjAAAU4pmqBJ7s+d7nLsewO6JZiWhfOwlWA0B15ikQ9tn368a/IXBCp
        3WyCY3NPaLoWP7O8qS4bVuqsYA==
X-Google-Smtp-Source: APXvYqwMUIcvk0OhonGIojoReS6XyCXzw+WPITleyk890WHpWACo13bwV2OljeaobA3sXmDFnWyzyg==
X-Received: by 2002:a19:9152:: with SMTP id y18mr2804059lfj.128.1561557686492;
        Wed, 26 Jun 2019 07:01:26 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id v14sm2834356ljh.51.2019.06.26.07.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 07:01:25 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:01:23 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>, grygorii.strashko@ti.com,
        hawk@kernel.org, brouer@redhat.com, saeedm@mellanox.com,
        leon@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org,
        Network Development <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        jakub.kicinski@netronome.com,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v4 net-next 1/4] net: core: page_pool: add user cnt
 preventing pool deletion
Message-ID: <20190626140122.GH6485@khorivan>
Mail-Followup-To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>, grygorii.strashko@ti.com,
        hawk@kernel.org, brouer@redhat.com, saeedm@mellanox.com,
        leon@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org,
        Network Development <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        jakub.kicinski@netronome.com,
        John Fastabend <john.fastabend@gmail.com>
References: <20190625175948.24771-1-ivan.khoronzhuk@linaro.org>
 <20190625175948.24771-2-ivan.khoronzhuk@linaro.org>
 <CA+FuTSff=+zqxxmCv3+bNxraigNgx_1Wm5Kn2FM7TTSZV4dnOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+FuTSff=+zqxxmCv3+bNxraigNgx_1Wm5Kn2FM7TTSZV4dnOg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:36:15PM -0400, Willem de Bruijn wrote:
>On Tue, Jun 25, 2019 at 2:00 PM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> Add user counter allowing to delete pool only when no users.
>> It doesn't prevent pool from flush, only prevents freeing the
>> pool instance. Helps when no need to delete the pool and now
>> it's user responsibility to free it by calling page_pool_free()
>> while destroying procedure. It also makes to use page_pool_free()
>> explicitly, not fully hidden in xdp unreg, which looks more
>> correct after page pool "create" routine.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>
>> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
>> index f07c518ef8a5..1ec838e9927e 100644
>> --- a/include/net/page_pool.h
>> +++ b/include/net/page_pool.h
>> @@ -101,6 +101,7 @@ struct page_pool {
>>         struct ptr_ring ring;
>>
>>         atomic_t pages_state_release_cnt;
>> +       atomic_t user_cnt;
>
>refcount_t?
yes, thanks.

>
>>  };
>>
>>  struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
>> @@ -183,6 +184,12 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>>         return page->dma_addr;
>>  }
>>
>> +/* used to prevent pool from deallocation */
>> +static inline void page_pool_get(struct page_pool *pool)
>> +{
>> +       atomic_inc(&pool->user_cnt);
>> +}
>> +
>>  static inline bool is_page_pool_compiled_in(void)
>>  {
>>  #ifdef CONFIG_PAGE_POOL
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index b366f59885c1..169b0e3c870e 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -48,6 +48,7 @@ static int page_pool_init(struct page_pool *pool,
>>                 return -ENOMEM;
>>
>>         atomic_set(&pool->pages_state_release_cnt, 0);
>> +       atomic_set(&pool->user_cnt, 0);
>>
>>         if (pool->p.flags & PP_FLAG_DMA_MAP)
>>                 get_device(pool->p.dev);
>> @@ -70,6 +71,8 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
>>                 kfree(pool);
>>                 return ERR_PTR(err);
>>         }
>> +
>> +       page_pool_get(pool);
>>         return pool;
>>  }
>>  EXPORT_SYMBOL(page_pool_create);
>> @@ -356,6 +359,10 @@ static void __warn_in_flight(struct page_pool *pool)
>>
>>  void __page_pool_free(struct page_pool *pool)
>>  {
>> +       /* free only if no users */
>> +       if (!atomic_dec_and_test(&pool->user_cnt))
>> +               return;
>> +
>>         WARN(pool->alloc.count, "API usage violation");
>>         WARN(!ptr_ring_empty(&pool->ring), "ptr_ring is not empty");
>>
>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>> index 829377cc83db..04bdcd784d2e 100644
>> --- a/net/core/xdp.c
>> +++ b/net/core/xdp.c
>> @@ -372,6 +372,9 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
>>
>>         mutex_unlock(&mem_id_lock);
>>
>> +       if (type == MEM_TYPE_PAGE_POOL)
>> +               page_pool_get(xdp_alloc->page_pool);
>> +
>
>need an analogous page_pool_put in xdp_rxq_info_unreg_mem_model? mlx5
>does not use that inverse function, but intel drivers do.
no need, it's put after call to page_pool_free() in unreg workqueue.

>
>>         trace_mem_connect(xdp_alloc, xdp_rxq);
>>         return 0;
>>  err:
>> --
>> 2.17.1
>>

-- 
Regards,
Ivan Khoronzhuk
