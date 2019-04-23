Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A160C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0621820843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ugxlEb4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfDWJrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:47:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfDWJrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZG2dlcWtNNZxXUbPH3bRjuZncLwEfGlDXtch5CgLX/Q=; b=ugxlEb4sjNIY7tZ9fUhvPMHXXL
        dXph+KhM7zeyt15QyBaGwE6z3hplR611VfhoWEnpYrCFyeVwt1CiJmkU+ZUgYpUBZBzZ8xMkVC0Bd
        Cuyt2hcODWc7MePUpOEx04npM6xiW5Og/Xg5BSH1pv/xvWluPRm78OoWtdweWgAW/yQhlacPCsy2+
        /GS59LBtvC680KFoiyN8Kwx9tGyCZUf1UbSteH7UUMaH/N+HDON84XC/sY+qJy4polvo72cGFRit+
        tzpzGj1CDVDCE0N31jhJRk7yVvsrJ0Qx5cEawHUkBckIXuiK6VwoVEzSMxwlIZ1cXO2WXNPcoQA02
        PDecM9Zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIs0j-00020N-RA; Tue, 23 Apr 2019 09:46:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A37A29BF8E8B; Tue, 23 Apr 2019 11:46:44 +0200 (CEST)
Date:   Tue, 23 Apr 2019 11:46:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/5] numa: append per-node execution info in
 memory.numa_stat
Message-ID: <20190423094644.GL11158@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <7be82809-79d3-f6a1-dfe8-dd14d2b35219@linux.alibaba.com>
 <20190423085248.GE11158@hirez.programming.kicks-ass.net>
 <8c3ad96d-7f3d-d966-6acc-8327023ae3f9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c3ad96d-7f3d-d966-6acc-8327023ae3f9@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 05:36:25PM +0800, 王贇 wrote:
> 
> 
> On 2019/4/23 下午4:52, Peter Zijlstra wrote:
> > On Mon, Apr 22, 2019 at 10:12:20AM +0800, 王贇 wrote:
> >> This patch introduced numa execution information, to imply the numa
> >> efficiency.
> >>
> >> By doing 'cat /sys/fs/cgroup/memory/CGROUP_PATH/memory.numa_stat', we
> >> see new output line heading with 'exectime', like:
> >>
> >>   exectime 24399843 27865444
> >>
> >> which means the tasks of this cgroup executed 24399843 ticks on node 0,
> >> and 27865444 ticks on node 1.
> > 
> > I think we stopped reporting time in HZ to userspace a long long time
> > ago. Please don't do that.
> 
> Ah I see, let's make it us maybe?

ms might be best I think.
