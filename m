Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD63C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38A22146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UpqdSARn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGATNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:13:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38282 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfGATNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ipn4fix027HY4nDGg4ZOEnVhpfAVctRuNAZ2QjAiS5g=; b=UpqdSARnV7FfcONeqXzNCy0EI
        DfBNv33im8tXzEphgieqWUaMIsGAxnYOm3bob+51nLyp246R8hWDi1sDgf6lr5YWFlKF3SghT0ZzS
        Vx4XeXfvRzye3mgCOEVb9nT4RD6e/jCwHRnOyln5a6SzTPCmLM2l2F0bxPIn5yc+9lfGZSq5oF3m6
        HfNRaDqnEp49sOihn9f3VpVRCQT98ipZe+y2YVbYE/Xg+2cYU5SOA6kIlSv057KtYGVYAHMFQpaB0
        jeaBCwJAWMs746NOdgU9Vwmime6gqDOmoME02wIW7L+fr0VnFxga0ZhmC4ulwqy5AESxXmnGWftB6
        ZEjI4QNuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi1jh-0001s4-OA; Mon, 01 Jul 2019 19:13:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7148020963E39; Mon,  1 Jul 2019 21:13:08 +0200 (CEST)
Date:   Mon, 1 Jul 2019 21:13:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v8 8/8] rcu/tree: Setschedule gp ktread to SCHED_FIFO
 outside of atomic region
Message-ID: <20190701191308.GE3402@hirez.programming.kicks-ass.net>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-9-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628080618.522-9-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:06:18AM +0200, Juri Lelli wrote:
> sched_setscheduler() needs to acquire cpuset_rwsem, but it is currently
> called from an invalid (atomic) context by rcu_spawn_gp_kthread().
> 
> Fix that by simply moving sched_setscheduler_nocheck() call outside of
> the atomic region, as it doesn't actually require to be guarded by
> rcu_node lock.

Maybe move this earlier in the series such that the bug doesn't manifest
in bisection?
