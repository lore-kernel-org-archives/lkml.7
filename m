Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFF3C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455B722CED
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFGwhVLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfHZJZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:25:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbfHZJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AYY21M19zx8FMLZ0hdxNGSVGO72qMoETVC6sYSM50Z8=; b=SFGwhVLebobrVZKf90FpOOQyV
        wsMKLWtMlSvAFmxGn+g/8f8+6/2a3fzsY+ecqlpDoM7yFFTCn1xFmU4IpWRqONMwozni9YuUS71OT
        rJYQUXEnLPGfV7Xw30wrXG1a+47fIDGpN0zIP2vqxeYdpiGvhMM4qDmIsS9QiolkuPcgRn8Hp5hAZ
        KY8mHAKykc84RpmFz6sshjc1j/sC7+QFj027+x1zYO0OOa/7AahLBUJCfKPou/RBOPeYpTd2dB+Se
        YCy3N8i2mgBM2cA9AQbPmAix+zi8MMDOT94eSqheOKang4RWAtRUmx7IE8vUhMiZ5BsJH3eHFDFhs
        FZF9cOHgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2BFN-0006aa-7Q; Mon, 26 Aug 2019 09:25:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27A81307602;
        Mon, 26 Aug 2019 11:24:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 841672022F842; Mon, 26 Aug 2019 11:25:06 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:25:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liangyan <liangyan.peng@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, shanpeic@linux.alibaba.com,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH v2] sched/fair: don't assign runtime for throttled cfs_rq
Message-ID: <20190826092506.GO2369@hirez.programming.kicks-ass.net>
References: <20190824091558.86296-1-liangyan.peng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824091558.86296-1-liangyan.peng@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 05:15:58PM +0800, Liangyan wrote:
> do_sched_cfs_period_timer() will refill cfs_b runtime and call
> distribute_cfs_runtime() to unthrottle cfs_rq, sometimes cfs_b->runtime
> will allocate all quota to one cfs_rq incorrectly.
> This will cause other cfs_rq can't get runtime and will be throttled.
> We find that one throttled cfs_rq has non-negative
> cfs_rq->runtime_remaining and cause an unexpetced cast from s64 to u64
> in snippet: distribute_cfs_runtime() {
> runtime = -cfs_rq->runtime_remaining + 1; }.
> This cast will cause that runtime will be a large number and
> cfs_b->runtime will be subtracted to be zero at last.
> According to Ben Segall, the throttled cfs_rq can have
> account_cfs_rq_runtime called on it because it is throttled before
> idle_balance, and the idle_balance calls update_rq_clock to add time
> that is accounted to the task.

That is distinctly unreadable. Please try again with a little bit of
whitespace added.

> This commit prevents cfs_rq to be assgined new runtime if it has been
> throttled to avoid the above incorrect type cast.
> 
> Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>
> Reviewed-by: Ben Segall <bsegall@google.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
