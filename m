Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A58BC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3974D222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570304126;
	bh=2AV4N+2t6XV2T7V3z+wVg4ZZIC+gZEAl81XxyuQYcl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AI/gCAUnk7R6mtm080HhISk63obFKHT6QS1E+4W0U3LG2436RkvSFFGR942H+uRUD
	 nxiYSKRkpxLo3BZpf1l4+oGANQ7nkzcrhvVuodpLa9y+meTgYvkznHKRejYX6yxuyJ
	 eugOCgopPewmw0gitgBP0GfPcAcIPkuh380RAB6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfJETfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 15:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfJETfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 15:35:25 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150B4222BE;
        Sat,  5 Oct 2019 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570304124;
        bh=2AV4N+2t6XV2T7V3z+wVg4ZZIC+gZEAl81XxyuQYcl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NXlIvr4atLhu9hnsyz6hFcgQqApIB9vToxavFStoJDSwSKUDqhvpbalqg+14TTwo8
         iX41QNQvzAD2vM+RhCgHsxCeIpcgoPDY7siAjctJWzLWlkQggvNx6h6kFwgQACOYGx
         cfH3LaTQaq+3wQ4WFBHseuNosoaIoVSE/29IrX70=
Date:   Sat, 5 Oct 2019 12:35:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm/swap: piggyback lru_add_drain_all() calls
Message-Id: <20191005123523.0db4ad1b9f268c419f8a59eb@linux-foundation.org>
In-Reply-To: <157019456205.3142.3369423180908482020.stgit@buzz>
References: <157019456205.3142.3369423180908482020.stgit@buzz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Oct 2019 16:09:22 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> This is very slow operation. There is no reason to do it again if somebody
> else already drained all per-cpu vectors while we waited for lock.
> 
> Piggyback on drain started and finished while we waited for lock:
> all pages pended at the time of our enter were drained from vectors.
> 
> Callers like POSIX_FADV_DONTNEED retry their operations once after
> draining per-cpu vectors when pages have unexpected references.
> 
> ...
>
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

I'm not sure this works as intended.

Suppose CPU #30 is presently executing the for_each_online_cpu() loop
and has reached CPU #15's per-cpu data.

Now CPU #2 comes along, adds some pages to its per-cpu vectors then
calls lru_add_drain_all().  AFAICT the code will assume that CPU #30
has flushed out all of the pages which CPU #2 just added, but that
isn't the case.

Moving the raw_write_seqcount_latch() to the point where all processing
has completed might fix?

