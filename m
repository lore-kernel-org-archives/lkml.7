Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04463C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3539217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="puiOLgLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfC1OUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:20:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43686 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1OUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:20:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id v32so23227904qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vay+wlXHA2RDv/GmVToMkpOGJVWOatSpW8U6KZxfJTg=;
        b=puiOLgLDpj0bSc2f54cXIGuxXU6pKazOK5o1k39vQn+ZeEz4KVwkNaMdOZl2QonF4x
         i6nfak3BLBpr6aa1isbefs6c4By+Yyo7jZpV6jp+jufyv2pAuDrrQYCpgs6enS98Qrop
         EtsmxyUqI37t2vgmfc5kwNxPDXqK1JhhUGf/aT19eTbWcP9tp3nnfNs9eV0jOud1x4rA
         w4Wk3rumcyZm+8AAqTWef32+ESKofgV3Zn2oNQOyQtpZbR4TbbC+svP6f+PGer2az6kv
         CnBu4dbykTGr8McngNgvcsTkBHhjjamJIkcOrRRGe3mBYsvnhTb6kmISCmk7r0STqzKZ
         gp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vay+wlXHA2RDv/GmVToMkpOGJVWOatSpW8U6KZxfJTg=;
        b=qGYCvb0Gg/4WbeghQzmOiBqFuVg/qZL12JhkzpoPo48dB+gCVKMyooLyG/As0baCK2
         PZZsVFdmLk8b0h/howF7suF9bcJEjBM7n9Gr/NIZd55o9n3u0dj0lHbf1PIrBiAynKM9
         Nr8znhsH/PWrzRTCltQQhps+y9j/YPgF0M08wJV04PtT/5qkKaEEw17p2as9UlC5HOuy
         NVoeSX1Fz8VUZw5woH2NlGHp6MJNC76ZHr7sMiuqlWRM87W+z2k88eRg2A9pWlley+4n
         PVG5wV8GOTk+9zQRIYtnhx8Bn8HB9jL5wPfLTy5CYidXheUCEricc2YM4595MF6Cvg9I
         /9Xg==
X-Gm-Message-State: APjAAAVBFv+x0X8v21BT1lp8IHu4baiLVrFwPX9m3/cgh90qAuduPIRQ
        UOSESHka3Y/pzzPmzPrnNmPZbg==
X-Google-Smtp-Source: APXvYqxpyAd5tjFgPujzd9DjVH5NTvlWdlmHYlmfhtRAdB6irEXwI1Q+7D9hS4KkcLf5wd0eY9Hxdw==
X-Received: by 2002:a0c:b590:: with SMTP id g16mr35368705qve.146.1553782818161;
        Thu, 28 Mar 2019 07:20:18 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id p46sm18863869qtc.41.2019.03.28.07.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 07:20:17 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:20:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: sum memcg dirty counters as needed
Message-ID: <20190328142016.GA15763@cmpxchg.org>
References: <20190307165632.35810-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307165632.35810-1-gthelen@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 08:56:32AM -0800, Greg Thelen wrote:
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3880,6 +3880,7 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
>   * @pheadroom: out parameter for number of allocatable pages according to memcg
>   * @pdirty: out parameter for number of dirty pages
>   * @pwriteback: out parameter for number of pages under writeback
> + * @exact: determines exact counters are required, indicates more work.
>   *
>   * Determine the numbers of file, headroom, dirty, and writeback pages in
>   * @wb's memcg.  File, dirty and writeback are self-explanatory.  Headroom
> @@ -3890,18 +3891,29 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
>   * ancestors.  Note that this doesn't consider the actual amount of
>   * available memory in the system.  The caller should further cap
>   * *@pheadroom accordingly.
> + *
> + * Return value is the error precision associated with *@pdirty
> + * and *@pwriteback.  When @exact is set this a minimal value.
>   */
> -void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
> -			 unsigned long *pheadroom, unsigned long *pdirty,
> -			 unsigned long *pwriteback)
> +unsigned long
> +mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
> +		    unsigned long *pheadroom, unsigned long *pdirty,
> +		    unsigned long *pwriteback, bool exact)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
>  	struct mem_cgroup *parent;
> +	unsigned long precision;
>  
> -	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
> -
> +	if (exact) {
> +		precision = 0;
> +		*pdirty = memcg_exact_page_state(memcg, NR_FILE_DIRTY);
> +		*pwriteback = memcg_exact_page_state(memcg, NR_WRITEBACK);
> +	} else {
> +		precision = MEMCG_CHARGE_BATCH * num_online_cpus();
> +		*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
> +		*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
> +	}
>  	/* this should eventually include NR_UNSTABLE_NFS */
> -	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
>  	*pfilepages = mem_cgroup_nr_lru_pages(memcg, (1 << LRU_INACTIVE_FILE) |
>  						     (1 << LRU_ACTIVE_FILE));
>  	*pheadroom = PAGE_COUNTER_MAX;
> @@ -3913,6 +3925,8 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
>  		memcg = parent;
>  	}
> +
> +	return precision;

Have you considered unconditionally using the exact version here?

It does for_each_online_cpu(), but until very, very recently we did
this per default for all stats, for years. It only became a problem in
conjunction with the for_each_memcg loops when frequently reading
memory stats at the top of a very large hierarchy.

balance_dirty_pages() is called against memcgs that actually own the
inodes/memory and doesn't do the additional recursive tree collection.

It's also not *that* hot of a function, and in the io path...

It would simplify this patch immensely.
