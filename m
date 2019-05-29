Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87CEC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C84C2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5k5yiAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfE2BWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:22:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38344 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfE2BWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:22:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id b76so459457pfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 18:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7hiqTDVHP7ycUHBATDRFOTjH/h1L38jFsXVu8jDFuS0=;
        b=v5k5yiAEtdR51yLQSHl2C6JH8A1Af23+g41mDYdOwzAoVr8XvhXKy1cPAVR6T0zU9o
         LKnKBxafam9LaCEh3d+X5rKOkdouDjXgxTU6wQdOdlH4rUoGs1PTtm0H8aqJft+sNE/a
         Dw5goKxS0owGNFLVDkYUFBHumuPjbss/4pvtFMe30flVdpHTQRcqv6CtN7yfsHfQvsmY
         LZlFDrSof0jt1RVozI2kRAsyiKNrNpK7UKuZvdFmVfuwmq7CZMGeLiaJc+/zlBjvW1Oc
         x+HA1SC43P3UPEpLYGOotPb8OTta16UBQX0fl66ySL8X1HM9OFvIPgcCpoQt0Vw9J8E1
         pVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7hiqTDVHP7ycUHBATDRFOTjH/h1L38jFsXVu8jDFuS0=;
        b=P0BffdpdD+JiCLN2mrQ0kKdWC7dSTEyyH96ReBZbrOGUNuLAZHOXvS5C6Aj7owbRFt
         OXR11FwQDxHQbXCuhiN682+RaEOBJ+CwMpSdv9IghNisJWwQtLJXpy0u3wLs/xb6Av0p
         JFOlbNlj0OsBW/IakhfGnm03V9EkfTuBH8KEVwGqxnV4ioT8g31/rx8H7UW/EtMQb6Cl
         RiE4c0UlwX+bMIpON6jMrbvx4snM0nrxexha+r3WlKDiemAWA5BHLGYIDVP4SOKn54pb
         G1LxLkSNzPOo3YC+Ek3Ka3csYmTmaXz/dzQBkuo4LJWFa3nNL9vBC7uMG1yc12YylfrY
         FS8g==
X-Gm-Message-State: APjAAAW+RHxzBipR8YOh7q76gpltXfBNZ5SdPLW5H6H8jcUdGUpwxusW
        gsdB8s4aGd8Yj2Ub3+n+I/ldUg==
X-Google-Smtp-Source: APXvYqy1irI5QOZSUt4gtC8U1zUDRgiytinvm+UkUXfHcoCwlJ2WUV+f+Jk3GqWNPCEJQLSYfQ0+Ew==
X-Received: by 2002:a63:490a:: with SMTP id w10mr32183693pga.6.1559092970775;
        Tue, 28 May 2019 18:22:50 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a7sm15705665pgj.42.2019.05.28.18.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 18:22:50 -0700 (PDT)
Date:   Tue, 28 May 2019 18:22:49 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Make deferred split shrinker memcg aware
In-Reply-To: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1905281817090.86034@chino.kir.corp.google.com>
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019, Yang Shi wrote:

> 
> I got some reports from our internal application team about memcg OOM.
> Even though the application has been killed by oom killer, there are
> still a lot THPs reside, page reclaim doesn't reclaim them at all.
> 
> Some investigation shows they are on deferred split queue, memcg direct
> reclaim can't shrink them since THP deferred split shrinker is not memcg
> aware, this may cause premature OOM in memcg.  The issue can be
> reproduced easily by the below test:
> 

Right, we've also encountered this.  I talked to Kirill about it a week or 
so ago where the suggestion was to split all compound pages on the 
deferred split queues under the presence of even memory pressure.

That breaks cgroup isolation and perhaps unfairly penalizes workloads that 
are running attached to other memcg hierarchies that are not under 
pressure because their compound pages are now split as a side effect.  
There is a benefit to keeping these compound pages around while not under 
memory pressure if all pages are subsequently mapped again.

> $ cgcreate -g memory:thp
> $ echo 4G > /sys/fs/cgroup/memory/thp/memory/limit_in_bytes
> $ cgexec -g memory:thp ./transhuge-stress 4000
> 
> transhuge-stress comes from kernel selftest.
> 
> It is easy to hit OOM, but there are still a lot THP on the deferred split
> queue, memcg direct reclaim can't touch them since the deferred split
> shrinker is not memcg aware.
> 

Yes, we have seen this on at least 4.15 as well.

> Convert deferred split shrinker memcg aware by introducing per memcg deferred
> split queue.  The THP should be on either per node or per memcg deferred
> split queue if it belongs to a memcg.  When the page is immigrated to the
> other memcg, it will be immigrated to the target memcg's deferred split queue
> too.
> 
> And, move deleting THP from deferred split queue in page free before memcg
> uncharge so that the page's memcg information is available.
> 
> Reuse the second tail page's deferred_list for per memcg list since the same
> THP can't be on multiple deferred split queues at the same time.
> 
> Remove THP specific destructor since it is not used anymore with memcg aware
> THP shrinker (Please see the commit log of patch 2/3 for the details).
> 
> Make deferred split shrinker not depend on memcg kmem since it is not slab.
> It doesn't make sense to not shrink THP even though memcg kmem is disabled.
> 
> With the above change the test demonstrated above doesn't trigger OOM anymore
> even though with cgroup.memory=nokmem.
> 

I'm curious if your internal applications team is also asking for 
statistics on how much memory can be freed if the deferred split queues 
can be shrunk?  We have applications that monitor their own memory usage 
through memcg stats or usage and proactively try to reduce that usage when 
it is growing too large.  The deferred split queues have significantly 
increased both memcg usage and rss when they've upgraded kernels.

How are your applications monitoring how much memory from deferred split 
queues can be freed on memory pressure?  Any thoughts on providing it as a 
memcg stat?

Thanks!
