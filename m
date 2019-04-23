Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E69C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F166820685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kgA5DLjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDWIwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:52:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWIwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l21441oHLnK9oVeQ4gnC65uBIN32WtWZE/gHPIisLWw=; b=kgA5DLjmKDrcmj1FrTMFaqf1XB
        E/x9JKVM34KNwPxbgHhdKrN/iVMK9XkeF/7yoFA9QGsy6Ck4ud3zKMSGh6auPpU8SXPpG4zkvcdST
        KsiL+a3hpVGT1nnQQqMDBDq8eTyxW0im9mkmxBZ4QzDVtr2rvPWinHPRaBjawhI12NLWWPJXSfHil
        Pwix2KdGI9smoDmdhoBDJKDK9kzvaAFfdKM4utX9OJ9pXtOJtu5mm9P50ve0kHBwN8V3AWv7S67Oy
        PhxYcROSzP7UT2Z1x32CD6L+jTYLrAqrVUQdITivscU2LbSInG//SPRToWzsKbqrn63VbfsCBLwpN
        yApA1c7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIrAY-0002WP-HT; Tue, 23 Apr 2019 08:52:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0683F29B47DCB; Tue, 23 Apr 2019 10:52:49 +0200 (CEST)
Date:   Tue, 23 Apr 2019 10:52:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/5] numa: append per-node execution info in
 memory.numa_stat
Message-ID: <20190423085248.GE11158@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <7be82809-79d3-f6a1-dfe8-dd14d2b35219@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7be82809-79d3-f6a1-dfe8-dd14d2b35219@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:12:20AM +0800, 王贇 wrote:
> This patch introduced numa execution information, to imply the numa
> efficiency.
> 
> By doing 'cat /sys/fs/cgroup/memory/CGROUP_PATH/memory.numa_stat', we
> see new output line heading with 'exectime', like:
> 
>   exectime 24399843 27865444
> 
> which means the tasks of this cgroup executed 24399843 ticks on node 0,
> and 27865444 ticks on node 1.

I think we stopped reporting time in HZ to userspace a long long time
ago. Please don't do that.
