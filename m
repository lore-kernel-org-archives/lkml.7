Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A06C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F120214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="LI0rw6Yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfIPM4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:56:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39313 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfIPM4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:56:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so8624964wrj.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Qvf/tFB1NW9gGSqT/wR7yVJwgXaFo5u9eZ6TcvIymQ=;
        b=LI0rw6YwWN8ZIfFY1x3z7d6DQpjq1QMQHKmc7RC7CC750QO/kXXnllfg27qnoqAVwj
         eOrs7Ok0zw8+0mC4k4Jas6ArWZ1toc9mxNIsx2MGIjCIOcF6TgNm28y0xTH98tDtjPvu
         z6tuz4dguo1cVBhI1ATSthZKAKNTJDFbcS59WGmsG1v5ES0TckZ2dtl9VnI6EtbL3yL1
         nHOVapGTD/Ab1h2qi8Z5Vo6nyxPqUu++h8xLt+tZK/mdN2jQHtbw1gKF2BwoPBLN4+ey
         zop2FPw30hJ4cV7Q+Rttu+1PEwp0yQnXa9Ou3W/AI2BZ/RImBrdhOkEdR6QzE4EkXBUT
         yCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Qvf/tFB1NW9gGSqT/wR7yVJwgXaFo5u9eZ6TcvIymQ=;
        b=amPgI/awnbTnP0jKrd80HcLVhf3KHsN50rBZy9Fz534v/YZYsoA4lRAtLXeyTkgKgN
         iLouIIjRjH/gtNlSe/JDmvtigR+5foIx6rJHlzfJubcjqDe1nNSuZtfnv+cA9emAqI+U
         IbgJNIjxR4HRo2zU2HJpM3NOKBa9KhoCGuonQzcG2esjIRWcPOGtbrrsoxlwX+lf+/pw
         NWu0bzMKcSDgD3qINVauqP3LPX8Oc1+ftRLxZy6LvCP6D+zV9AVfr3nAgaTEmMAgQSng
         Q02pNKpLNUftmqOmVyTkTgset+/JZJ9BENO3QbwFrkaGZFvAsT/1Bg24gdm0BnTtznHN
         zr4w==
X-Gm-Message-State: APjAAAW5MjVlCZz2iizCxM6Nvsuy53m9KLM3GL7mriK07HbX+siM3a/u
        mSBKmq54wzqOXoW26I84tkPAKA==
X-Google-Smtp-Source: APXvYqytJbglD1pOkKufvUeMbQb432tslSRsIFuH1ov//lw/rbWtIhtIllKqnrzkTkZ5UcG3DSZjlw==
X-Received: by 2002:a5d:46c4:: with SMTP id g4mr11644497wrs.189.1568638579404;
        Mon, 16 Sep 2019 05:56:19 -0700 (PDT)
Received: from localhost (p4FC6B710.dip0.t-ipconnect.de. [79.198.183.16])
        by smtp.gmail.com with ESMTPSA id q15sm11000696wmb.28.2019.09.16.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:56:18 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:56:11 +0200
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC 01/14] mm: memcg: subpage charging API
Message-ID: <20190916125611.GB29985@cmpxchg.org>
References: <20190905214553.1643060-1-guro@fb.com>
 <20190905214553.1643060-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905214553.1643060-2-guro@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:45:45PM -0700, Roman Gushchin wrote:
> Introduce an API to charge subpage objects to the memory cgroup.
> The API will be used by the new slab memory controller. Later it
> can also be used to implement percpu memory accounting.
> In both cases, a single page can be shared between multiple cgroups
> (and in percpu case a single allocation is split over multiple pages),
> so it's not possible to use page-based accounting.
> 
> The implementation is based on percpu stocks. Memory cgroups are still
> charged in pages, and the residue is stored in perpcu stock, or on the
> memcg itself, when it's necessary to flush the stock.

Did you just implement a slab allocator for page_counter to track
memory consumed by the slab allocator?

> @@ -2500,8 +2577,9 @@ void mem_cgroup_handle_over_high(void)
>  }
>  
>  static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -		      unsigned int nr_pages)
> +		      unsigned int amount, bool subpage)
>  {
> +	unsigned int nr_pages = subpage ? ((amount >> PAGE_SHIFT) + 1) : amount;
>  	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
>  	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
>  	struct mem_cgroup *mem_over_limit;
> @@ -2514,7 +2592,9 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (mem_cgroup_is_root(memcg))
>  		return 0;
>  retry:
> -	if (consume_stock(memcg, nr_pages))
> +	if (subpage && consume_subpage_stock(memcg, amount))
> +		return 0;
> +	else if (!subpage && consume_stock(memcg, nr_pages))
>  		return 0;

The layering here isn't clean. We have an existing per-cpu cache to
batch-charge the page counter. Why does the new subpage allocator not
sit on *top* of this, instead of wedged in between?

I think what it should be is a try_charge_bytes() that simply gets one
page from try_charge() and then does its byte tracking, regardless of
how try_charge() chooses to implement its own page tracking.

That would avoid the awkward @amount + @subpage multiplexing, as well
as annotating all existing callsites of try_charge() with a
non-descript "false" parameter.

You can still reuse the stock data structures, use the lower bits of
stock->nr_bytes for a different cgroup etc., but the charge API should
really be separate.
