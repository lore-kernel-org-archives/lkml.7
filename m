Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78330C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447922147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kK93kaC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfFZMj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:39:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46294 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfFZMj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:39:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so1439712lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/5pqjxKZWlKDR2ZDFgBswr7u/dOAyk73PfPEL4Lr1c=;
        b=kK93kaC+eBF7nrDlGk4YkEZ6fO78C+OSAIhMBez1SBiIsW0d2wqmg4qpvVPay5BoHM
         S8Aq6E5ku5LpTApgci7j6dBPVLtLb5jfVbn7mnb5FOfnlN/N9Vpd33+rnyX2EAsEXwCr
         hKYy6xU8MKBfiej486Y2ko5wBPr7eEU1Ko50jzXUzFLFHDJXUCAESFFHNHKisuYcxot/
         yckVwRSDg5kGqtvzpT60MZNGcaTQouuTXdLjHBVwSQxPh/tVWLt+qJgaMxcSVyn4dv4X
         CXm9L2FbTIsvjefvW2fzT1FD5OTvgydSuOe48HTxSAAAgawAmqwzYfYvnQk9/5jzThzI
         8xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=K/5pqjxKZWlKDR2ZDFgBswr7u/dOAyk73PfPEL4Lr1c=;
        b=Ii4I4BrATmRMvLD0E1A06a3mqx0GZ/fKCWGIWxSYtdy00VxJrjTQAK5MJ9pZ4R9F09
         0JlooCDkWLDVpVUm+ss19i4MXTLudyvhhCbBpbl4mPW3l0QSmLBOS+/hLBut7hSfCwh1
         DyHd6bd6ZYH7Qp8kVlY9doGnx8SYpxrn69xwjdlcjStvgmtfUPPbfrmXrV7wDmFlzHv3
         5p15pR2B83hYAi0/NxjZXTNwdFcudqieMlz3MpqScqkfbiyiWqqOVhnEnqZDdjv4yMZv
         SXfYbHd9y35iA/8Z4P2oFBsyo7hiD7OgVT/cBVA+Qw5GKx+OoCbsVnUiGlfHhhG/bsvM
         uFWA==
X-Gm-Message-State: APjAAAWlA/3fDsHOZcBQmaGytxdGEX4GKz1Bt2khxNB/fsuFZEFEDYG7
        v8RgDOUwR40hgh+fwPi4zUBQ8Q==
X-Google-Smtp-Source: APXvYqwH1GYG0SmYu+rN+iI+a/V3nBemmI2M2OVoLwDDnJf3nAKtZOQczWsTs1B9Y5aAt+FDKUUjlw==
X-Received: by 2002:ac2:5094:: with SMTP id f20mr2641207lfm.186.1561552765268;
        Wed, 26 Jun 2019 05:39:25 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id u11sm2073765ljd.90.2019.06.26.05.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 05:39:24 -0700 (PDT)
Date:   Wed, 26 Jun 2019 15:39:22 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     davem@davemloft.net, grygorii.strashko@ti.com, saeedm@mellanox.com,
        leon@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, ilias.apalodimas@linaro.org,
        netdev@vger.kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com
Subject: Re: [PATCH v4 net-next 1/4] net: core: page_pool: add user cnt
 preventing pool deletion
Message-ID: <20190626123920.GG6485@khorivan>
Mail-Followup-To: Jesper Dangaard Brouer <brouer@redhat.com>,
        davem@davemloft.net, grygorii.strashko@ti.com, saeedm@mellanox.com,
        leon@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, ilias.apalodimas@linaro.org,
        netdev@vger.kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com
References: <20190625175948.24771-1-ivan.khoronzhuk@linaro.org>
 <20190625175948.24771-2-ivan.khoronzhuk@linaro.org>
 <20190626124216.494eee86@carbon>
 <20190626104948.GF6485@khorivan>
 <20190626135128.5724f40e@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190626135128.5724f40e@carbon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 01:51:28PM +0200, Jesper Dangaard Brouer wrote:
>On Wed, 26 Jun 2019 13:49:49 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> On Wed, Jun 26, 2019 at 12:42:16PM +0200, Jesper Dangaard Brouer wrote:
>> >On Tue, 25 Jun 2019 20:59:45 +0300
>> >Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>> >
>> >> Add user counter allowing to delete pool only when no users.
>> >> It doesn't prevent pool from flush, only prevents freeing the
>> >> pool instance. Helps when no need to delete the pool and now
>> >> it's user responsibility to free it by calling page_pool_free()
>> >> while destroying procedure. It also makes to use page_pool_free()
>> >> explicitly, not fully hidden in xdp unreg, which looks more
>> >> correct after page pool "create" routine.
>> >
>> >No, this is wrong.
>> below.
>>
>> >
>> >> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> >> ---
>> >>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 +++++---
>> >>  include/net/page_pool.h                           | 7 +++++++
>> >>  net/core/page_pool.c                              | 7 +++++++
>> >>  net/core/xdp.c                                    | 3 +++
>> >>  4 files changed, 22 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> >> index 5e40db8f92e6..cb028de64a1d 100644
>> >> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> >> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> >> @@ -545,10 +545,8 @@ static int mlx5e_alloc_rq(struct mlx5e_channel *c,
>> >>  	}
>> >>  	err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
>> >>  					 MEM_TYPE_PAGE_POOL, rq->page_pool);
>> >> -	if (err) {
>> >> -		page_pool_free(rq->page_pool);
>> >> +	if (err)
>> >>  		goto err_free;
>> >> -	}
>> >>
>> >>  	for (i = 0; i < wq_sz; i++) {
>> >>  		if (rq->wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ) {
>> >> @@ -613,6 +611,8 @@ static int mlx5e_alloc_rq(struct mlx5e_channel *c,
>> >>  	if (rq->xdp_prog)
>> >>  		bpf_prog_put(rq->xdp_prog);
>> >>  	xdp_rxq_info_unreg(&rq->xdp_rxq);
>> >> +	if (rq->page_pool)
>> >> +		page_pool_free(rq->page_pool);
>> >>  	mlx5_wq_destroy(&rq->wq_ctrl);
>> >>
>> >>  	return err;
>> >> @@ -643,6 +643,8 @@ static void mlx5e_free_rq(struct mlx5e_rq *rq)
>> >>  	}
>> >>
>> >>  	xdp_rxq_info_unreg(&rq->xdp_rxq);
>> >> +	if (rq->page_pool)
>> >> +		page_pool_free(rq->page_pool);
>> >
>> >No, this is wrong.  The hole point with the merged page_pool fixes
>> >patchset was that page_pool_free() needs to be delayed until no-more
>> >in-flight packets exist.
>>
>> Probably it's not so obvious, but it's still delayed and deleted only
>> after no-more in-flight packets exist. Here question is only who is able
>> to do this first based on refcnt.
>
>Hmm... then I find this API is rather misleading, even the function
>name page_pool_free is misleading ("free"). (Now, I do see, below, that
>page_pool_create() take an extra reference).
In feneral "free" looks not bad after "create".
It's called after "create" if some error with registering it rxq.
and it looks logical, if it's called after no need in pool.

obj = create()
 /* a lot of different stuff */
free(obj);


>
>But it is still wrong / problematic.  As you allow
>__page_pool_request_shutdown() to be called with elevated refcnt.  Your
>use-case is to have more than 1 xdp_rxq_info struct using the same
>page_pool.  Then you have to call xdp_rxq_info_unreg_mem_model() for
>each, which will call __page_pool_request_shutdown().
>
>For this to be safe, your driver have to stop RX for all the
>xdp_rxq_info structs that share the page_pool.  The page_pool already
>have this requirement, but it comes as natural step when shutting down
>an RXQ.  With your change, you have to take care of stopping the RXQs
>first, and then call xdp_rxq_info_unreg_mem_model() for each
>xdp_rxq_info afterwards.  I assume you do this, but it is just a driver
>bug waiting to happen.
All rxq queues are stopped before this, and only after this the pools are freed,
exactly as it required for one xdp_rxq_info_unreg_mem_model(), w/o exclusions,
as it requires the API.

>
>> >> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> >> index b366f59885c1..169b0e3c870e 100644
>> >> --- a/net/core/page_pool.c
>> >> +++ b/net/core/page_pool.c
>[...]
>> >> @@ -70,6 +71,8 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
>> >>  		kfree(pool);
>> >>  		return ERR_PTR(err);
>> >>  	}
>> >> +
>> >> +	page_pool_get(pool);
>> >>  	return pool;
>> >>  }
>> >>  EXPORT_SYMBOL(page_pool_create);
>
>The thing (perhaps) like about your API change, is that you also allow
>the driver to explicitly keep the page_pool object across/after a
>xdp_rxq_info_unreg_mem_model().  And this way possibly reuse it for
>another RXQ.
>The problem is of-cause that on driver shutdown, this
>will force drivers to implement the same shutdown logic with
>schedule_delayed_work as the core xdp.c code already does.
I see.

The cpsw dosn't re-use it, so here all is fine, but if a driver needs
to re-use it again, lets suppose, as it can happen, the pool needs to
be registered with xdp_rxq_info_reg_mem_model() again, and for that
potentially can be added verification on in-flight packets
or some register state...but better mention in some place
to not do this, frankly, I don't know where it should be at this moment.

-- 
Regards,
Ivan Khoronzhuk
