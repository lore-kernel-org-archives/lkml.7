Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CC5C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C8322CEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghGPFq1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbfIEMVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:21:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387522AbfIEMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XxjNlzSh4Idu5yXZCZUqJQ0HxpndVHuWT8vcHQ66Uxw=; b=ghGPFq1Yqlxm6/HHyDi2mP656
        mn4vc5Iiky/79SM9AWLU0wM5+3bbLallTOVW6khFCmIImfN4dgYPgfYBxeTky3hnM1P8R80bskdB9
        KR7/KpAboHiP/zCA62zBKopVtUZsOS24u4P7Ytx/W3d9kGCFyxKTKdLwWaeYBf+WH7NgGu0ZEGPrW
        eGLGB5MdJEcT2WXZIROxvaxY7JD8cFliORszSaG9hQhbpLg+ti/OOyOozPkttYXSZext6bN0FGbU3
        9ZxnzceoMGa9KBG7BEQmTkXV9Y6dWsKK0wafqq32iUPZ786ALJy5p5Rh2jbcuPwtK7qf7oYS0bKWZ
        Xrah31sVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5qlC-0007wK-Gv; Thu, 05 Sep 2019 12:21:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1300303121;
        Thu,  5 Sep 2019 14:20:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB7E429CD33B9; Thu,  5 Sep 2019 14:21:08 +0200 (CEST)
Date:   Thu, 5 Sep 2019 14:21:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 5/6] posix-cpu-timers: Sanitize thread clock permissions
Message-ID: <20190905122108.GO2349@hirez.programming.kicks-ass.net>
References: <20190905120339.561100423@linutronix.de>
 <20190905120540.068959005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905120540.068959005@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:03:44PM +0200, Thomas Gleixner wrote:
> The thread clock permissions are restricted to tasks of the same thread
> group, but that also prevents a ptracer from reading them. This is
> inconsistent vs. the process restrictions and unnecessary strict.
> 
> Relax it to ptrace permissions in the same way as process permissions are
> handled.

More of a meta comment on the added permission checking; so where
clock_getcpuclockid() is allowed to return -EPERM, it doesn't because
that's in glibc and it has no clue.

And these patches implement the ptrace checks and result in -EINVAL for
timer_create() and clock_gettime(), even though it should arguably be
-EPERM, but we're not allowed to return that here.
