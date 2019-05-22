Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793F7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D06320821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IwuuKdaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfEVOt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:49:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfEVOt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=88Bkxm9ztLilz68byouxZeMuCjfn14K5AGbgcj+vwJg=; b=IwuuKdaHaTgi65AI5e8ASar/W
        EtitAewX8g1AtFG6RhFIEE5kGDhKgYeuAhtrY568kZbEUxz4GIqYOb45ZElE+NXhx1Sl51Jzp6qHi
        6XqCt2CQEudrkLQaC7qQBJGBilKYKlBoh8NfB4QQZYa8F4275qPug/ufzwhyl4jtc1ULhdEr8D4Cn
        QFT0DyTi3Ssuo5mnJMr8S5mc/ptWsyYMrq+n/NjdVaremhxQIn0JQrbN/B2mC0/V0KjdAycpbOul2
        p7KgkabCwQZ3xMukJ4H9QR63+UOf01vMu67Q9sxPD5ynvinQHjL1bZPUJvzkvq7iqPH5ph4IFrbmh
        JVbPlW3vw==;
Received: from [31.161.185.207] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTSYV-0005zq-5e; Wed, 22 May 2019 14:49:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 884BF984E0B; Wed, 22 May 2019 16:49:18 +0200 (CEST)
Date:   Wed, 22 May 2019 16:49:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp,cpumask: Don't call functions on offline CPUs
Message-ID: <20190522144918.GH16275@worktop.programming.kicks-ass.net>
References: <20190522111537.27815-1-andrew.murray@arm.com>
 <20190522140921.GD16275@worktop.programming.kicks-ass.net>
 <20190522143711.GC8268@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522143711.GC8268@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 03:37:11PM +0100, Andrew Murray wrote:
> > Is perhaps the problem that on_each_cpu_cond() uses cpu_onlne_mask
> > without protection?
> 
> Does this prevent racing with a CPU going offline? I guess this prevents
> the warning at the expense of a lock - but is only beneficial in the
> unlikely path. (In the likely path this prevents new CPUs going offline
> but we don't care because we don't WARN if they aren't they when we
> attempt to call functions).
> 
> At least this is my limited understanding.

Hmm.. I don't think it could matter, we only use the mask when
preempt_disable(), which would already block offline, due to it using
stop_machine().

So the patch is a no-op.

What's the WARN you see? TLB invalidation should pass mm_cpumask(),
which similarly should not contain offline CPUs I'm thinking.
