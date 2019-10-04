Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EAC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C03215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570194753;
	bh=K2m1EGYN9uMDiNdq/y8NN8jU/t4QnkUN7ZtdGsM+bo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XCQgQaTOkUVUHKyuNI+lj4hrD+p7wH1NtfMeTg5yKOXQH49YsPq0/p/tvMqQMk7GQ
	 o8QW/ecIb5jL2ALKQOuPwzOu4qw8P7iepiIv24PnSgbpHxZbkoZ6YSO+u9Aa3W5/w1
	 iM6GJ42Tu/EsJUFY9Ptt3Y9Yv+YGhXryHmibaDcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388270AbfJDNMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:12:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:53936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387545AbfJDNMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:12:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF4EBB192;
        Fri,  4 Oct 2019 13:12:30 +0000 (UTC)
Date:   Fri, 4 Oct 2019 15:12:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm/swap: piggyback lru_add_drain_all() calls
Message-ID: <20191004131230.GL9578@dhcp22.suse.cz>
References: <157019456205.3142.3369423180908482020.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157019456205.3142.3369423180908482020.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 16:09:22, Konstantin Khlebnikov wrote:
> This is very slow operation. There is no reason to do it again if somebody
> else already drained all per-cpu vectors while we waited for lock.
> 
> Piggyback on drain started and finished while we waited for lock:
> all pages pended at the time of our enter were drained from vectors.
> 
> Callers like POSIX_FADV_DONTNEED retry their operations once after
> draining per-cpu vectors when pages have unexpected references.

This describes why we need to wait for preexisted pages on the pvecs but
the changelog doesn't say anything about improvements this leads to.
In other words what kind of workloads benefit from it?

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  mm/swap.c |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 38c3fa4308e2..5ba948a9d82a 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -708,9 +708,10 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
>   */
>  void lru_add_drain_all(void)
>  {
> +	static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
>  	static DEFINE_MUTEX(lock);
>  	static struct cpumask has_work;
> -	int cpu;
> +	int cpu, seq;
>  
>  	/*
>  	 * Make sure nobody triggers this path before mm_percpu_wq is fully
> @@ -719,7 +720,19 @@ void lru_add_drain_all(void)
>  	if (WARN_ON(!mm_percpu_wq))
>  		return;
>  
> +	seq = raw_read_seqcount_latch(&seqcount);
> +
>  	mutex_lock(&lock);
> +
> +	/*
> +	 * Piggyback on drain started and finished while we waited for lock:
> +	 * all pages pended at the time of our enter were drained from vectors.
> +	 */
> +	if (__read_seqcount_retry(&seqcount, seq))
> +		goto done;
> +
> +	raw_write_seqcount_latch(&seqcount);
> +
>  	cpumask_clear(&has_work);
>  
>  	for_each_online_cpu(cpu) {
> @@ -740,6 +753,7 @@ void lru_add_drain_all(void)
>  	for_each_cpu(cpu, &has_work)
>  		flush_work(&per_cpu(lru_add_drain_work, cpu));
>  
> +done:
>  	mutex_unlock(&lock);
>  }
>  #else
> 

-- 
Michal Hocko
SUSE Labs
