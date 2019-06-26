Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A085C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD8F20883
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEllaoY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFZBg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:36:56 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33101 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFZBgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:36:55 -0400
Received: by mail-yw1-f65.google.com with SMTP id v15so281098ywv.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTYwKuXPT5ALk6Fdrn6IzuSHliH6LA0lPjX35sqNWXk=;
        b=LEllaoY4m3xHWsTf7N+j4EKZmEHnZurpJaQ4DfOFpDq5VCrh/Gz2Ay+qnaw+/VsjPx
         NdSVVQpJr40BZE6Igeny8QytRZGs2Q/pWaDuYl3MfRlk2BCtw4EoH94czkdBkZEkG2U2
         pEpjPktRmpofIUWGYnET5+J9dWWu1Nr5Z5HkvrveWaTFPl4wzPfG8fKjVuQDtov0ywD4
         yJc4bdyE/f1Z5EZXXaOuPkm/TbXG//FaJ9D1n/wYXeX9UeS6Nl8vpsriv+kRzCGIiI80
         v6GAgaz0IchTKo6kTwjApTZ4Ga/8zRr/MuhlYpouM1wn78rpueWlK4a5wddrIlqHdaUd
         cyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTYwKuXPT5ALk6Fdrn6IzuSHliH6LA0lPjX35sqNWXk=;
        b=Wabm3byHJwuHcinHCHwI0xfzDDiaZtAVlrRbayellD4dd0XLcrwZzLLze3ntqSR9s+
         iAqsRPvN3qE3nV4aPK/vWDkjzExDjuwa5S6z21Tckb3B5mxRGKNkcIIt7vIgohRLLPF2
         UK2cvSvOf5PAoqmPncCgmmFajGaZMs+l0SmAxt1NXaQhZLSPKtT6Owhm61FA8YFWxZuV
         esDjw/Suo5kxQc6b6sgBNwnWbF2ximQVWzIV7x45rytDehCT8Qtem9b3ddaKiNBu3F9w
         v8Wys1FP92Kn/pUXq45vIi/9n+ve9C5SshYJLz+qVnSqOeLwi8cZgibh1ECX90iYA0PN
         cE9g==
X-Gm-Message-State: APjAAAWL/bpdKfSqKbNFKUQaSL45+M6tWceD0sYofs5AACkN2EpM7CRT
        Vfsk9LC8Wh369jH4r54dPBQqSTt7
X-Google-Smtp-Source: APXvYqzcm6swzp0IYJF3ADzu8h3DeJi2IwePyKEaSDTA32P+JoZfnt+dHEL9kEFHmPE+5JHhJKc5Fg==
X-Received: by 2002:a81:25d1:: with SMTP id l200mr1064233ywl.11.1561513014015;
        Tue, 25 Jun 2019 18:36:54 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id g64sm2572434ywg.11.2019.06.25.18.36.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:36:53 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id j15so366048ybh.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 18:36:52 -0700 (PDT)
X-Received: by 2002:a25:21c2:: with SMTP id h185mr1028553ybh.125.1561513012633;
 Tue, 25 Jun 2019 18:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190625175948.24771-1-ivan.khoronzhuk@linaro.org> <20190625175948.24771-2-ivan.khoronzhuk@linaro.org>
In-Reply-To: <20190625175948.24771-2-ivan.khoronzhuk@linaro.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 25 Jun 2019 21:36:15 -0400
X-Gmail-Original-Message-ID: <CA+FuTSff=+zqxxmCv3+bNxraigNgx_1Wm5Kn2FM7TTSZV4dnOg@mail.gmail.com>
Message-ID: <CA+FuTSff=+zqxxmCv3+bNxraigNgx_1Wm5Kn2FM7TTSZV4dnOg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/4] net: core: page_pool: add user cnt
 preventing pool deletion
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 2:00 PM Ivan Khoronzhuk
<ivan.khoronzhuk@linaro.org> wrote:
>
> Add user counter allowing to delete pool only when no users.
> It doesn't prevent pool from flush, only prevents freeing the
> pool instance. Helps when no need to delete the pool and now
> it's user responsibility to free it by calling page_pool_free()
> while destroying procedure. It also makes to use page_pool_free()
> explicitly, not fully hidden in xdp unreg, which looks more
> correct after page pool "create" routine.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index f07c518ef8a5..1ec838e9927e 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -101,6 +101,7 @@ struct page_pool {
>         struct ptr_ring ring;
>
>         atomic_t pages_state_release_cnt;
> +       atomic_t user_cnt;

refcount_t?

>  };
>
>  struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
> @@ -183,6 +184,12 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>         return page->dma_addr;
>  }
>
> +/* used to prevent pool from deallocation */
> +static inline void page_pool_get(struct page_pool *pool)
> +{
> +       atomic_inc(&pool->user_cnt);
> +}
> +
>  static inline bool is_page_pool_compiled_in(void)
>  {
>  #ifdef CONFIG_PAGE_POOL
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index b366f59885c1..169b0e3c870e 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -48,6 +48,7 @@ static int page_pool_init(struct page_pool *pool,
>                 return -ENOMEM;
>
>         atomic_set(&pool->pages_state_release_cnt, 0);
> +       atomic_set(&pool->user_cnt, 0);
>
>         if (pool->p.flags & PP_FLAG_DMA_MAP)
>                 get_device(pool->p.dev);
> @@ -70,6 +71,8 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
>                 kfree(pool);
>                 return ERR_PTR(err);
>         }
> +
> +       page_pool_get(pool);
>         return pool;
>  }
>  EXPORT_SYMBOL(page_pool_create);
> @@ -356,6 +359,10 @@ static void __warn_in_flight(struct page_pool *pool)
>
>  void __page_pool_free(struct page_pool *pool)
>  {
> +       /* free only if no users */
> +       if (!atomic_dec_and_test(&pool->user_cnt))
> +               return;
> +
>         WARN(pool->alloc.count, "API usage violation");
>         WARN(!ptr_ring_empty(&pool->ring), "ptr_ring is not empty");
>
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 829377cc83db..04bdcd784d2e 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -372,6 +372,9 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
>
>         mutex_unlock(&mem_id_lock);
>
> +       if (type == MEM_TYPE_PAGE_POOL)
> +               page_pool_get(xdp_alloc->page_pool);
> +

need an analogous page_pool_put in xdp_rxq_info_unreg_mem_model? mlx5
does not use that inverse function, but intel drivers do.

>         trace_mem_connect(xdp_alloc, xdp_rxq);
>         return 0;
>  err:
> --
> 2.17.1
>
