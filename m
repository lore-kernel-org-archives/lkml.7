Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78DFC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ED822BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fk5PxdqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGYSww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:52:52 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42702 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfGYSww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:52:52 -0400
Received: by mail-ua1-f66.google.com with SMTP id a97so20236378uaa.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w30g8iTJZ+UU2qLPrb+evOZb5z9OWHBiOGbGq1jemNU=;
        b=fk5PxdqXwDMPwORg3XCxFG7uAIyVeAxzjCVFr+xY1GzC38VvJWux97NE9QX+CMxCWT
         dW04AcGMPDsLPV36Mle3sHH8SfBxjOIw/qUNl8V7ZhAGicnLTjfSfmoBiocxOZZg4bsX
         GueHeMwj15Cu7ORpM8BNUmrifrXhJs/fxE9WQyPlh1AHJW8e1ZDTzDFM3b2Y8A8cZ5Ee
         Zym/8PjXzAcatIUnO7Fm1FMiiuJMEr9QWCVp9O3lKHrMoKEn4pG7flqM/1RgO/i7Tp5H
         NB1nrOVWLfVvMaxoRs94O2pNu7mq8vhq1LjdJr0p7wEW5WxeQ6k84EitR4kgT4ZHfBrk
         8fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w30g8iTJZ+UU2qLPrb+evOZb5z9OWHBiOGbGq1jemNU=;
        b=rl2eGwZUyfLNb6RNQuDYph5NjSTY/f8P/jVKSUR0aMj/OKwtQzedwSNtsnZeuG7rkE
         Rtol3QXPbS18rxI3MSdxh0ytoHCWZTZlt0CVW4/ffRsJzaC99y5vGuLEMLlDTupyfQRV
         GGAtLZzZ6F9JfQyjaptPnAG2UfR2BA5rjYvnF65LBzBB8oaT7Zp1o5OnWHY42Ummg++c
         JGvfpdn1qsfpeBqwsygnTF7oLyO4qNHXrQmMUeFk5ycQTrBBR9T9NtrM/yYK8zB8uaUG
         9thUtH18TBzmtIB0eAYQmq8iNlDpu7j3zkC2MMViTq/xNP55Q6m/K0elPp7zq+26rWh3
         GnSQ==
X-Gm-Message-State: APjAAAUGDfPjR6spTBJitFV0/cl1eOEWgG7SuV2TpPV6OdFZH/wy1UBr
        phKzbH8/VJ9CbB2e/NNzZAdLUw==
X-Google-Smtp-Source: APXvYqzR+uo0BYzmmM09fGdkgM3r83aj04Jvid8uh+HP6b+ewHzxQIVEd/JNaC3+NAmqGGBGmAZ9Hg==
X-Received: by 2002:a9f:2269:: with SMTP id 96mr55944133uad.80.1564080771058;
        Thu, 25 Jul 2019 11:52:51 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l20sm15288616vkl.2.2019.07.25.11.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 11:52:50 -0700 (PDT)
Message-ID: <1564080768.11067.22.camel@lca.pw>
Subject: Re: [PATCH 00/10] make "order" unsigned int
From:   Qian Cai <cai@lca.pw>
To:     Pengfei Li <lpf.vector@gmail.com>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        aryabinin@virtuozzo.com, osalvador@suse.de, rostedt@goodmis.org,
        mingo@redhat.com, pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 25 Jul 2019 14:52:48 -0400
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-26 at 02:42 +0800, Pengfei Li wrote:
> Objective
> ----
> The motivation for this series of patches is use unsigned int for
> "order" in compaction.c, just like in other memory subsystems.

I suppose you will need more justification for this change. Right now, I don't
see much real benefit apart from possibly introducing more regressions in those
tricky areas of the code. Also, your testing seems quite lightweight.

> 
> In addition, did some cleanup about "order" in page_alloc
> and vmscan.
> 
> 
> Description
> ----
> Directly modifying the type of "order" to unsigned int is ok in most
> places, because "order" is always non-negative.
> 
> But there are two places that are special, one is next_search_order()
> and the other is compact_node().
> 
> For next_search_order(), order may be negative. It can be avoided by
> some modifications.
> 
> For compact_node(), order = -1 means performing manual compaction.
> It can be avoided by specifying order = MAX_ORDER.
> 
> Key changes in [PATCH 05/10] mm/compaction: make "order" and
> "search_order" unsigned.
> 
> More information can be obtained from commit messages.
> 
> 
> Test
> ----
> I have done some stress testing locally and have not found any problems.
> 
> In addition, local tests indicate no performance impact.
> 
> 
> Pengfei Li (10):
>   mm/page_alloc: use unsigned int for "order" in should_compact_retry()
>   mm/page_alloc: use unsigned int for "order" in __rmqueue_fallback()
>   mm/page_alloc: use unsigned int for "order" in should_compact_retry()
>   mm/page_alloc: remove never used "order" in alloc_contig_range()
>   mm/compaction: make "order" and "search_order" unsigned int in struct
>     compact_control
>   mm/compaction: make "order" unsigned int in compaction.c
>   trace/events/compaction: make "order" unsigned int
>   mm/compaction: use unsigned int for "compact_order_failed" in struct
>     zone
>   mm/compaction: use unsigned int for "kcompactd_max_order" in struct
>     pglist_data
>   mm/vmscan: use unsigned int for "kswapd_order" in struct pglist_data
> 
>  include/linux/compaction.h        |  30 +++----
>  include/linux/mmzone.h            |   8 +-
>  include/trace/events/compaction.h |  40 +++++-----
>  include/trace/events/kmem.h       |   6 +-
>  include/trace/events/oom.h        |   6 +-
>  include/trace/events/vmscan.h     |   4 +-
>  mm/compaction.c                   | 127 +++++++++++++++---------------
>  mm/internal.h                     |   6 +-
>  mm/page_alloc.c                   |  16 ++--
>  mm/vmscan.c                       |   6 +-
>  10 files changed, 126 insertions(+), 123 deletions(-)
> 
