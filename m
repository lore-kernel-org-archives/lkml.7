Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F64EC28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F56C21BF1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Td5FIUii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfFDJO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:14:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34530 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfFDJO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DgNpdU17akAPklawfBcHfi1blxtQXT3PKnl2KsNaRgw=; b=Td5FIUiiAyWISjpDw8L/Gsvqp
        ZCod+BEgR89Pvtr145ojdn8ftRmWolFwTcGD2IIb+/yyispNTEmfUtjGbRbnw9h5k4twWWC/Y5IHp
        vyhr857+AMcfx9YtnVafDNV72Q0iw+IAFIIKsB1vfkKd3UroqQUrehaNe2S86NJMhPj/eYqLE49/t
        4P3FUhHKfSWtaHIKW6ouqWTfZsN4zAA/m/r1fIp6GKczvM3GCjGOAmzWIN/qMwgIr8HLuAd+egYzc
        S6yaroznMaYO11heWdxJ7OLbDGuy2Q2y6oXWdagtwAEtIYxiE08mxKEgCV8j1Zc/L+gxtwV7SVAR/
        aden0FqIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY5WL-000370-A1; Tue, 04 Jun 2019 09:14:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 189442083FE28; Tue,  4 Jun 2019 11:14:16 +0200 (CEST)
Date:   Tue, 4 Jun 2019 11:14:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
Message-ID: <20190604091416.GI3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-16-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520205918.22251-16-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:59:14PM -0400, Waiman Long wrote:
> On a 2-socket 40-core 80-thread Skylake system, the page_fault1 test of
> the will-it-scale benchmark was run with various number of threads. The
> number of operations done before reader optimistic spinning patches,
> this patch and after this patch were:
> 
>   Threads  Before rspin  Before patch  After patch    %change
>   -------  ------------  ------------  -----------    -------
>     20        5541068      5345484       5455667    -3.5%/ +2.1%
>     40       10185150      7292313       9219276   -28.5%/+26.4%
>     60        8196733      6460517       7181209   -21.2%/+11.2%
>     80        9508864      6739559       8107025   -29.1%/+20.3%

'rspin' is patch 12 in this series, right?
