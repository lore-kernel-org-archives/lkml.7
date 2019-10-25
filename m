Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1AECA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB30B21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XaiGMHIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfJYVI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:08:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36549 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfJYVI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:08:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23so2338911pgk.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dTwx/JjKBwPW6sZ06ysYvFl3kZ/YdB0UaChMs4crqCs=;
        b=XaiGMHIYXGHoCAEZDWHURZfURQ54T0lzfOD4OkWbsntZbjBQ+4AGzqHjvoAweZpl7T
         6NtcpZFyUkEQhxSG+DB5XyUtlNarXPU2yeGak/RzJndqXahGDP6VCkcQDGvho64htRmV
         QVuuVjsjhAcRQu6TcoIaj7DxWNOHC8zfkgB22d+559KsdhR8kpufB81E/t0zC7WYKC1W
         yqfXubNU3ivU4B4WpIFH+vsXx11XMovXAy75r1c1a1+c6+HLE6O2fQIySoFnqGE3oeZV
         eiZc7jeoMM7UE8zDhDC5fWCRsxBcCwsT5u/ToRHU58pY6LOPgMvRDiRAJnwFe+VT4PjF
         quFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dTwx/JjKBwPW6sZ06ysYvFl3kZ/YdB0UaChMs4crqCs=;
        b=Wqo3h3SqKqRKTBjb/NrPzHvdhxiJeYijvMLs8V3P+2jeKgGd5DMFpnZxDPA/LfG1oP
         1pyE2gt764zRjzItBIM6IL6e+ym+80bwIkB7d+zi5pgQxsAiAqqRJr7si7Qvk8ZinSEQ
         mWjq5JCoJVapdSPpDF0PZ6bUA8N5QwnUSDpqD4Nq6i2WfUUIzjk0sLTAMSFxQgXPeEis
         OKJQO66P+mXIxq3TDurMpPLjc/Nu/kXw+wuGwLHbvllzfPWYeUSuoYlGrqznR8rlN79f
         fEFD9+0x02zVQePHjz0HGUgTD3GmKMbI01bwIOfFEBQp6rNVkdVVLHLafCfHlVSADgPW
         2ySg==
X-Gm-Message-State: APjAAAX9F+m2udhHX29T7n2DAAQboOLFmyOZjY+W4I3EEhVd8kt+ZNrh
        tcgCOYYm4l/AYEBZBUwrnXEK6Q==
X-Google-Smtp-Source: APXvYqzqO0iRM2YfCDmg6tFvM3zUERjScrLgQ+IHqgTKuIgMxweznsy90HYJlCJ4SBIWEJjlDbpkQA==
X-Received: by 2002:a63:4902:: with SMTP id w2mr6691954pga.77.1572037733679;
        Fri, 25 Oct 2019 14:08:53 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u36sm4208041pgn.29.2019.10.25.14.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:08:51 -0700 (PDT)
Date:   Fri, 25 Oct 2019 14:08:50 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
In-Reply-To: <20191025072610.18526-3-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.21.1910251407000.194984@chino.kir.corp.google.com>
References: <20191025072610.18526-1-mhocko@kernel.org> <20191025072610.18526-3-mhocko@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
> This is not really nice because it blocks both any interrupts on that
> cpu and the page allocator. On large machines this might even trigger
> the hard lockup detector.
> 
> Considering the pagetypeinfo is a debugging tool we do not really need
> exact numbers here. The primary reason to look at the outuput is to see
> how pageblocks are spread among different migratetypes and low number of
> pages is much more interesting therefore putting a bound on the number
> of pages on the free_list sounds like a reasonable tradeoff.
> 
> The new output will simply tell
> [...]
> Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100000  41019  31560  23996  10054   3229    983    648
> 
> instead of
> Node    6, zone   Normal, type      Movable 399568 294127 221558 102119  41019  31560  23996  10054   3229    983    648
> 
> The limit has been chosen arbitrary and it is a subject of a future
> change should there be a need for that.
> 
> While we are at it, also drop the zone lock after each free_list
> iteration which will help with the IRQ and page allocator responsiveness
> even further as the IRQ lock held time is always bound to those 100k
> pages.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

I think 100k is a very reasonable threshold.

Acked-by: David Rientjes <rientjes@google.com>

> ---
>  mm/vmstat.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4e885ecd44d1..ddb89f4e0486 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1383,12 +1383,29 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
>  			unsigned long freecount = 0;
>  			struct free_area *area;
>  			struct list_head *curr;
> +			bool overflow = false;
>  
>  			area = &(zone->free_area[order]);
>  
> -			list_for_each(curr, &area->free_list[mtype])
> -				freecount++;
> -			seq_printf(m, "%6lu ", freecount);
> +			list_for_each(curr, &area->free_list[mtype]) {
> +				/*
> +				 * Cap the free_list iteration because it might
> +				 * be really large and we are under a spinlock
> +				 * so a long time spent here could trigger a
> +				 * hard lockup detector. Anyway this is a
> +				 * debugging tool so knowing there is a handful
> +				 * of pages in this order should be more than
> +				 * sufficient
> +				 */
> +				if (++freecount >= 100000) {

I suppose it's most precise to check freecount > 1000000 to print >100000, 
but I doubt anybody cares :)

> +					overflow = true;
> +					break;
> +				}
> +			}
> +			seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
> +			spin_unlock_irq(&zone->lock);
> +			cond_resched();
> +			spin_lock_irq(&zone->lock);
>  		}
>  		seq_putc(m, '\n');
>  	}
