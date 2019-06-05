Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7D320874
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0mGIO0a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfFEQ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:56:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39435 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbfFEQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:56:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so9900466plm.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hZ4cGeRHDextu5CN92g1Wv5jExw3YnRMZLIMsV5cvAM=;
        b=0mGIO0a16PwCvvaR5KVekuEHAAI6Q2Au9fzMg0rq9cIQZseDxcLyQnlnpLFqWAhwqe
         Yt+8W6m4lRuJQWYFUXD9kuuXHzivkv9+YZ8UX3eujcruue8CDe5Piz47SrGxpOX96mJ0
         ypMmdVL54li0Got7Cg0OG7+PNhDYXWUkLW82vaBWqVdjlLNaQ8uMIUrLZE072HIgWWHw
         iSPt/Wakz0VQISfqlzp3LI0Yq1DyQh6PFNSW0qKy89hSNq1VtvE5zOv9q4A7nI4ezK1L
         e07s/PovVfIg66ebjPwJvd25lYq0FNCUJvMgh1gTZa/ieLe5bRjaMJ7PKI0/rNFseEek
         lqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZ4cGeRHDextu5CN92g1Wv5jExw3YnRMZLIMsV5cvAM=;
        b=KUoiDBurSJishJRofoJuLPdsEEPgbBcF65DewSSqyQzjG9gRY+LgbmzBIcy/lVjMiG
         JBDSaKHDFzKCeOWl8nQpnjr+70ggPS6lvHVCuPC709d+9bOsGaSHtPvlr59zN6JY6/7G
         WWdVoiC/QOpzTcWjf580IAYp93vagaFAQnSyxEAuRpzqLiEW3mb6N/T+7xmlCkdMWuRW
         X6NSKlTY+iwuwyXit6JXoMxF54651tTWuhPNDR0i/cXTx8pQUD+jARIs4nFXOsXDhwHJ
         xEUY7NE6DuHQLt62HOSTiVksBgYX9E+rZtlbh4DgKDJh22EBChPQbrX3YsA7kj0Qj1w7
         nOqQ==
X-Gm-Message-State: APjAAAUqCDeKsKCGn/33qARU69cV/21e9hxN8Z+f2h1l69AhWycgz79h
        /dkCTuyfYwjBv+d2OprUf550Cg==
X-Google-Smtp-Source: APXvYqzQNjLq7UOy1q7ENsNpX55jr/E9IvuPhShPS6v+kZtEcqMLpCvregQ854wv8sSR3be+MXorkw==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr41291953plq.261.1559753778277;
        Wed, 05 Jun 2019 09:56:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:cd0c])
        by smtp.gmail.com with ESMTPSA id d10sm23208447pgh.43.2019.06.05.09.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 09:56:17 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:56:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 07/10] mm: synchronize access to kmem_cache dying flag
 using a spinlock
Message-ID: <20190605165615.GC12453@cmpxchg.org>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-8-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024454.1393507-8-guro@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:44:51PM -0700, Roman Gushchin wrote:
> Currently the memcg_params.dying flag and the corresponding
> workqueue used for the asynchronous deactivation of kmem_caches
> is synchronized using the slab_mutex.
> 
> It makes impossible to check this flag from the irq context,
> which will be required in order to implement asynchronous release
> of kmem_caches.
> 
> So let's switch over to the irq-save flavor of the spinlock-based
> synchronization.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/slab_common.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 09b26673b63f..2914a8f0aa85 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -130,6 +130,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
>  #ifdef CONFIG_MEMCG_KMEM
>  
>  LIST_HEAD(slab_root_caches);
> +static DEFINE_SPINLOCK(memcg_kmem_wq_lock);
>  
>  void slab_init_memcg_params(struct kmem_cache *s)
>  {
> @@ -629,6 +630,7 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
>  	struct memcg_cache_array *arr;
>  	struct kmem_cache *s = NULL;
>  	char *cache_name;
> +	bool dying;
>  	int idx;
>  
>  	get_online_cpus();
> @@ -640,7 +642,13 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
>  	 * The memory cgroup could have been offlined while the cache
>  	 * creation work was pending.
>  	 */
> -	if (memcg->kmem_state != KMEM_ONLINE || root_cache->memcg_params.dying)
> +	if (memcg->kmem_state != KMEM_ONLINE)
> +		goto out_unlock;
> +
> +	spin_lock_irq(&memcg_kmem_wq_lock);
> +	dying = root_cache->memcg_params.dying;
> +	spin_unlock_irq(&memcg_kmem_wq_lock);
> +	if (dying)
>  		goto out_unlock;

What does this lock protect? The dying flag could get set right after
the unlock.
