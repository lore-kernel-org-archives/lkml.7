Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3760C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8377420672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="cwuJLrMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKUU4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:56:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43321 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:56:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id p14so4343814qkm.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jo8ATEWyaSv/vLCn6HnPEaOlsTqvflPgdCXI72jAtAM=;
        b=cwuJLrMBZhPa5DBRo45PuWX50UB2Z5+gnbtBmxVA7l/W0adG0YbnCA+7EREee4ihMc
         /RtO2VS4M4autGBGzWZTC46Jv/LvU147g9Fe9ZrChLgdMY+2MhaYCoaBjmPAKML/GefK
         VsbDCS5rx0r5a8Yr8KgX4nvZa37JnXmMlmF9QekitglonB7f4EXFQTtRmVDQb2Zbltlx
         KwQpiRpPbM2LMBteWoe4r9FvgKpzKFjVlySacY13KC2eiNkTNw4bwv7DtJGh5FIwLoM2
         eD8G2mK3gounHPRVqZB7S/qn3WcDBAFP289D4mndKgQmZUjv19S70bmW84IqqAvtTHWJ
         c2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jo8ATEWyaSv/vLCn6HnPEaOlsTqvflPgdCXI72jAtAM=;
        b=dLi8bHBM6RzrG3oH9RkiCKY70TUV0NjEfKMI6KhVZ+LW1M4H7ohHvRzaryweywAd+J
         BGsjEYJYhRvRkL9RdFMYMYJuFBkvrKr25jqj3Dsd/mIGW36Ph8VxIex6hr0UJBrU9km7
         X6Jnlp79dBiXEyX69aWo0TsuAksElKLBa47OuHetHHLjo64x0A7N3Nx1MVfl189Jq11I
         PUk9bSARJ73o/NiYm54t4TQgLd1NwjTcCuxCP7RBOLmu+bNCGUfCUofHbC+bpRaPIhCz
         ljJMvr2JeW0tpXsuepCdJOMEMy3IJ4YBWp/2dPZ8ZpZCBRRqU5eUy74asALu+0XpI3Xz
         IfOg==
X-Gm-Message-State: APjAAAW7TWb86GSIiEJKfYuP5iORhMn08xH3eUyr0xPVQPMG/wtMUgJu
        bXAkb/rtaA7RnC+vXYU2pquK8Yc9q7/vVA==
X-Google-Smtp-Source: APXvYqzsNvwhS/lTU40H0qPMgE9W+CAi3eGFu6U08L2WuddkClqPGbs73rv7JHDvuvP81IsNUVvndg==
X-Received: by 2002:a05:620a:1653:: with SMTP id c19mr2834381qko.482.1574369793110;
        Thu, 21 Nov 2019 12:56:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:dbed])
        by smtp.gmail.com with ESMTPSA id b4sm1934576qka.75.2019.11.21.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:56:32 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:56:31 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: fix unsafe page -> lruvec lookups with cgroup charge
 migration
Message-ID: <20191121205631.GA487872@cmpxchg.org>
References: <20191120165847.423540-1-hannes@cmpxchg.org>
 <alpine.LSU.2.11.1911201836220.1090@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1911201836220.1090@eggly.anvils>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 07:15:27PM -0800, Hugh Dickins wrote:
> It like the way you've rearranged isolate_lru_page() there, but I
> don't think it amounts to more than a cleanup.  Very good thinking
> about the odd "lruvec->pgdat = pgdat" case tucked away inside
> mem_cgroup_page_lruvec(), but actually, what harm does it do, if
> mem_cgroup_move_account() changes page->mem_cgroup concurrently?
> 
> You say use-after-free, but we have spin_lock_irq here, and the
> struct mem_cgroup (and its lruvecs) cannot be freed until an RCU
> grace period expires, which we rely upon in many places, and which
> cannot happen until after the spin_unlock_irq.

You are correct, I missed the rcu locking implied by the
spinlock. With this, the justification for this patch is wrong.

But all of this is way too fragile and error-prone for my taste. We're
looking up a page's lruvec in a scope that does not promise at all
that the lruvec will be the page's. Luckily we currently don't touch
the lruvec outside of the PageLRU branch, but this subtlety is
entirely non-obvious from the code.

I will put more thought into this. Let's scrap this patch for now.
