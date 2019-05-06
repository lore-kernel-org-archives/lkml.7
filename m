Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22D3C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B454E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TJIaPdzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEFJSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:18:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52806 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfEFJSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/N7SUDa/gI8AZnczIXgTCi121TwWRxcH95NFsebJoxY=; b=TJIaPdzn44sjScjIcJmc8VaFr
        G3iKS7JTjEmIu+R4wWpV2pQtT3CC6QjHGXOU5Hob2owR89vp6rVblnZLixvO/VGp5PYkpzcDPtEhJ
        M+JSC0Smbujz1NNzjz3vTEqHrIhv3eTsoEv7Vx1Y8B9jw9o4MEj8qCLr5oUZJ/95iBdODko18l+vg
        ahWcJkIzMjehXLdll2kW+tmpOiL4yqpfc6RvpG4iL4VogkoLgfbf4LptX4NO/zZEFjLDOprg8Ypee
        1seJISgG0qjh9ftcZAwuwBNXVO7n0/H3RepxYxlSz2fuJSVjhFzinMpGyJ5T1QjATRL1KrmxFyTXr
        mR1iXhAEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNZlR-0006jg-0W; Mon, 06 May 2019 09:18:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A45A0286AB2AC; Mon,  6 May 2019 11:18:23 +0200 (CEST)
Date:   Mon, 6 May 2019 11:18:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
Message-ID: <20190506091823.GF2650@hirez.programming.kicks-ass.net>
References: <20190505115732.9844-1-qais.yousef@arm.com>
 <20190505115732.9844-5-qais.yousef@arm.com>
 <20190506090859.GK2606@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506090859.GK2606@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 11:08:59AM +0200, Peter Zijlstra wrote:
> Also; I _really_ hate how fat they are. Why can't we do simple straight
> forward things like:
> 
> 	trace_pelt_cfq(cfq);
> 	trace_pelt_rq(rq);
> 	trace_pelt_se(se);
> 
> And then have the thing attached to the event do the fat bits like
> extract the path and whatnot.

ARGH, because we don't export any of those data structures (for good
reason).. bah I hate all this.
