Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7535C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C401C2480D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfFDNMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:12:05 -0400
Received: from verein.lst.de ([213.95.11.211]:36219 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfFDNME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:12:04 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A726F68B05; Tue,  4 Jun 2019 15:11:38 +0200 (CEST)
Date:   Tue, 4 Jun 2019 15:11:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/fpu: Simplify kernel_fpu_begin
Message-ID: <20190604131138.GB22542@lst.de>
References: <20190604071524.12835-1-hch@lst.de> <20190604071524.12835-3-hch@lst.de> <20190604114701.GM3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604114701.GM3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:47:01PM +0200, Peter Zijlstra wrote:
> > +	if (current->mm && !test_thread_flag(TIF_NEED_FPU_LOAD)) {
> 
> Did that want to be: !(current->flags & PF_KTHREAD), instead?
> 
> Because I'm thinking that kernel_fpu_begin() on a kthread that has
> use_mm() employed shouldn't be doing this..

Well, this is intended to not change semantics.  If we should fix
this is should be a separate patch before or after this series.
