Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34390C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B49218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8VRpRki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfC2RuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:50:20 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38616 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfC2RuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:50:20 -0400
Received: by mail-qt1-f202.google.com with SMTP id v18so3022627qtk.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3iU4vJFcmV9tYu+4R51hGMcqNX2SfyXVOH+cKpv41qc=;
        b=p8VRpRkiNLGTt+JwfmkMCjck5+ZN90gGIfV39oRcXXfCX7p0KdhLO03SC0Fcwtzezq
         pGGK6NO7b+KM9v8IkREWVQn1cySl44ZwGMldSnBDGRWDFmzlsUd291E8aKx89jG1tChK
         5v/+y1SCpf7XKxV0iXISvJxjucT7VtbD+Uh2hqlbwNopqiUOilQY4tu23N4a8B8VSLvj
         kVpuqtKNlhvG1AlVGfthUS7AgDZ3yjflcLaS6Eg6VnkqE0ZA1hUmzAeZkq5DEYiZlBEN
         SO8zHK1KhdHvYuDvGumtVbcfuvHnuFty5ORfeUbePVHMnkNL+0x2VCXipOiRMrCNeSAy
         33mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3iU4vJFcmV9tYu+4R51hGMcqNX2SfyXVOH+cKpv41qc=;
        b=rW5uF3ukguvdebFQcgOY28tYDS3mWNTbCFqkzi4hVe5iiuoDUXXRRqbc3yku4/FqIV
         TFdBlFKwOYCc6o+1MWImpxj4lwiWOhQa8ZfAx7+k48JsZg2AFtA1MJFIN7zVlkH28dsO
         Wm1UihYix2+97NUQFtpfFEuZyHSnp2NfEd0lNErLDAHCZxLDZeyRBKj65yXOiaTbLX2E
         VOoxdmTT0a3LrIBPe9S9IjhhKRFboK/BqkBBlNK3/JGVLAjcYOlOjdkPI12IzAtYwgiv
         v3ZStDFoC6zd7IUfT8KtB7eQ7gRmv6q0O2BJrL2mkbn5uD7kvO0t+AQQPrQG69cOskWk
         27Kg==
X-Gm-Message-State: APjAAAXWF1+AY86UPuaO4gSGtP/rbAFqTGB7K0PNWHNl2mEsI9x0Me9c
        NfiGPv3oUudUzLG3IhhVyUkBUoN3IEsi
X-Google-Smtp-Source: APXvYqyNIuH84GzZGVP+fs2+r/hVUGR1UWcRbxODGazD/ZTe7ozxd5xNj2A37KLfPmKPx5sBVd2cgLQ3IWX0
X-Received: by 2002:a0c:af53:: with SMTP id j19mr4158438qvc.19.1553881819416;
 Fri, 29 Mar 2019 10:50:19 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:50:17 -0700
In-Reply-To: <20190328142016.GA15763@cmpxchg.org>
Message-Id: <xr93imw1wox2.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20190307165632.35810-1-gthelen@google.com> <20190328142016.GA15763@cmpxchg.org>
Subject: Re: [PATCH] writeback: sum memcg dirty counters as needed
From:   Greg Thelen <gthelen@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Thu, Mar 07, 2019 at 08:56:32AM -0800, Greg Thelen wrote:
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3880,6 +3880,7 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
>>   * @pheadroom: out parameter for number of allocatable pages according to memcg
>>   * @pdirty: out parameter for number of dirty pages
>>   * @pwriteback: out parameter for number of pages under writeback
>> + * @exact: determines exact counters are required, indicates more work.
>>   *
>>   * Determine the numbers of file, headroom, dirty, and writeback pages in
>>   * @wb's memcg.  File, dirty and writeback are self-explanatory.  Headroom
>> @@ -3890,18 +3891,29 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
>>   * ancestors.  Note that this doesn't consider the actual amount of
>>   * available memory in the system.  The caller should further cap
>>   * *@pheadroom accordingly.
>> + *
>> + * Return value is the error precision associated with *@pdirty
>> + * and *@pwriteback.  When @exact is set this a minimal value.
>>   */
>> -void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>> -			 unsigned long *pheadroom, unsigned long *pdirty,
>> -			 unsigned long *pwriteback)
>> +unsigned long
>> +mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>> +		    unsigned long *pheadroom, unsigned long *pdirty,
>> +		    unsigned long *pwriteback, bool exact)
>>  {
>>  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
>>  	struct mem_cgroup *parent;
>> +	unsigned long precision;
>>  
>> -	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
>> -
>> +	if (exact) {
>> +		precision = 0;
>> +		*pdirty = memcg_exact_page_state(memcg, NR_FILE_DIRTY);
>> +		*pwriteback = memcg_exact_page_state(memcg, NR_WRITEBACK);
>> +	} else {
>> +		precision = MEMCG_CHARGE_BATCH * num_online_cpus();
>> +		*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
>> +		*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
>> +	}
>>  	/* this should eventually include NR_UNSTABLE_NFS */
>> -	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
>>  	*pfilepages = mem_cgroup_nr_lru_pages(memcg, (1 << LRU_INACTIVE_FILE) |
>>  						     (1 << LRU_ACTIVE_FILE));
>>  	*pheadroom = PAGE_COUNTER_MAX;
>> @@ -3913,6 +3925,8 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>>  		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
>>  		memcg = parent;
>>  	}
>> +
>> +	return precision;
>
> Have you considered unconditionally using the exact version here?
>
> It does for_each_online_cpu(), but until very, very recently we did
> this per default for all stats, for years. It only became a problem in
> conjunction with the for_each_memcg loops when frequently reading
> memory stats at the top of a very large hierarchy.
>
> balance_dirty_pages() is called against memcgs that actually own the
> inodes/memory and doesn't do the additional recursive tree collection.
>
> It's also not *that* hot of a function, and in the io path...
>
> It would simplify this patch immensely.

Good idea.  Done in -v2 of the patch:
https://lore.kernel.org/lkml/20190329174609.164344-1-gthelen@google.com/
