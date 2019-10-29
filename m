Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC0CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DF020856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rvC5HmMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbfJ2Pq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:46:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45218 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389836AbfJ2Pq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:46:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id q70so12668902qke.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jBEwENFPDiTI0Tv4ACPfDqixaIF+4KZzeWBvvR41YGk=;
        b=rvC5HmMFf5bwMJE3zaaRWuN/o3uk+Xf9Sjy9wlzUFKA2J57CaA/HJDOQtTEJHklqGf
         TxoDmUQOl3BAShSIht19b+SUSV8F+VZ6DArhKMDtJN5aF/otuMSa0xtQbPN1sW4de1E/
         bn2xzKsyHDkKfPMwDNHCTu6PvHb32vdambEssrzMgw9ejfIDHxt+nHJsDsijQuu+9jIA
         bnFWEndUd6h3PulCgdjyhHQi5oWwxSP2bw7ijkRMjXQZZSuQJXRFQOqawN/b0d0YM0B+
         RGMxbbFtGZTAnX5vo0pVCmn+eaMrfp4kefWYskSM1OV3OPzuc4sKvSzRxzH1Hdw62l2A
         S5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jBEwENFPDiTI0Tv4ACPfDqixaIF+4KZzeWBvvR41YGk=;
        b=EuUsrWR1aVDSD4Qc0wNBvq739DAZtfxFLl+xa/r8PuaxhgQfMauuGhjDfbBFv1hQnW
         zYAM/i+l0jNWr9G7Up+vB0DaX+gHgqXGcWNOw6OKI0NLYv5GW9soS5/OUZC6wIYLIMHm
         JZK99Ov8k8L+FM9R16nwJ+hw3lm9fRqsu/uH4CALf3momatya6RlEfTLwKyPJtaiPqfV
         kmGSiSBTlYKQWjpCQsLeMmsag0JsMtCL9xuwuRBZYGEW6eZ6MVIX4m17zGZ4lwVqZEh9
         sQ0yUMrPa3olKBTRM+syPej7UZPQpf7XvhqZXGvYBC6D7EExQ+ejL01+DBQK4nsXp1c0
         GrFg==
X-Gm-Message-State: APjAAAUX8IADhfB3zyP2ZWiBimewmqnpxxJ274OobbO4/whib2ROn5yV
        8ZsSLsdMgcv94sP0R/FlIy6kNQ==
X-Google-Smtp-Source: APXvYqzvfVlH6Qzt1fNDHXNsPvdxY2oSMZPG3j/+toG2nE9AepD/WBgdPrObyFNX7JaUNuh+tx2Z0Q==
X-Received: by 2002:a37:9d12:: with SMTP id g18mr13783697qke.157.1572364016081;
        Tue, 29 Oct 2019 08:46:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::7081])
        by smtp.gmail.com with ESMTPSA id v186sm8285216qkb.42.2019.10.29.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 08:46:55 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:46:54 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC v2] memcg: add memcg lru for page reclaiming
Message-ID: <20191029154654.GC33522@cmpxchg.org>
References: <20191026110745.12956-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026110745.12956-1-hdanton@sina.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 07:07:45PM +0800, Hillf Danton wrote:
> 
> Currently soft limit reclaim is frozen, see
> Documentation/admin-guide/cgroup-v2.rst for reasons.
> 
> This work adds memcg hook into kswapd's logic to bypass slr,
> paving a brick for its cleanup later.
> 
> After b23afb93d317 ("memcg: punt high overage reclaim to
> return-to-userland path"), high limit breachers are reclaimed one
> after another spiraling up through the memcg hierarchy before
> returning to userspace.
> 
> We can not add new hook yet if it is infeasible to defer that
> reclaiming a bit further until kswapd becomes active.
> 
> It can be defered however because high limit breach looks benign
> in the absence of memory pressure, or we ensure it will be
> reclaimed soon in the presence of kswapd.

I have no idea what this patch is actually trying to do. But this
premise here, as well as the implementation, are seriously flawed.

memory.high needs to be enforced synchronously. Current users expect
workloads to be strictly contained or throttled by memory.high in
order to ensure consistent behavior regardless of the host
environment, as well as prevent interference with other workloads
whose startup time could be slowed down by this lack of containment.

On the implementation side, it appears you patched out reclaim but
left in the throttling that's supposed to make up for failing
reclaim. That means that once a cgroup tree's cache footprint grows
past its memory.high, instead of simply picking up the cold cache
pages, it'll get throttled heavily and see extreme memory pressure. It
could take ages for it to grow to the point where kswapd wakes up.

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
