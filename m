Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840C5C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B3E2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EW4PziXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfGJOPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:15:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47690 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfGJOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oP0gIGEEx6vBWbdTS/L8mSLxPp1+udys1WsnbGP0k70=; b=EW4PziXcJ7fiQlFhzwZ/7WMV8
        i0F9eimJo3/kcrvfcT5B//zjqgHB2Yfx0dtSiVWdmSJ4BpPaHPVMho50d6NFjDBkDapFEwisQUv4+
        11ZNGycHQcwPgro5eauJIS7Ua1QK+oauNoNjoaL4bdrs7DfRGZVAvUB0QqwP+8FgZyAUk2+YVgiDN
        sY4QmsltkG3CAp9d/swzvMdIHPEUdAedz1DnW7WMsZTo2Qsgx0TDavv/DqeRaOKlqk+ch2QjyxRa3
        e5Swp8gdRIDgg8awYsUG8IlxYv2WmZwtXyQuLwqa0rMTujuu9EEK3iVVoMxkbmNRgCx5GXGtc/n27
        FbjiTQmxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlDN8-00055x-1x; Wed, 10 Jul 2019 14:15:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D0FC20976EE7; Wed, 10 Jul 2019 16:15:00 +0200 (CEST)
Date:   Wed, 10 Jul 2019 16:15:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cputime: remove duplicate code in
 account_process_tick
Message-ID: <20190710141500.GQ3402@hirez.programming.kicks-ass.net>
References: <20190709060100.214154-1-alex.shi@linux.alibaba.com>
 <20190709060100.214154-2-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709060100.214154-2-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 02:01:00PM +0800, Alex Shi wrote:
> In funcation account_process_tick, func actually do same things with
> irqtime_account_process_tick, whenever if IRQ_TIME_ACCOUNTING set or
> if sched_clock_irqtime enabled.
> 
> So it's better to reuse one function for both.

But it's not the exact same.. and you didn't say, not did you say why
that is fine.
