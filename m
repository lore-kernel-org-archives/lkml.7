Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC42BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A7820C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uCkHd5t9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbfHFRPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:15:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfHFRPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ADm85E6up7HgxNB5b8bD0Y3ufcYM+XybW3hDfzY6bXc=; b=uCkHd5t9FOtVbg1D0heXOOtUZ
        hSk7tHmFghmitsFCNcGkjUHJ1Ksv9v2QnbvbtzXNczN1Xj/uooEsmZvsNzTm0h3i5bFkFW5t6t23P
        klwdCLFQ0yzVoJaliRrXxHwvymuy7fSag6fyGTO4Ao9aTctap8yDsc4fFEEEYOZdqfiIXPfS/CpYB
        EpPNVChOpkE6zRCZX+n/1XutdbpBeiPzoziR4XtQZJMHKkCPHG5cHnIygOhaU0Is0zrM7xHxL5HNX
        Szd6O2pwiknFtdmT5lOz6o/TCRgUwVc9iBGc/4CqxpdMqMMCwikz+NuyMMIucYER823VvyDv24fs1
        VtTBiQXtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv33O-0000GU-0s; Tue, 06 Aug 2019 17:15:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 556943067E2;
        Tue,  6 Aug 2019 19:14:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B564E201B34E9; Tue,  6 Aug 2019 19:15:15 +0200 (CEST)
Date:   Tue, 6 Aug 2019 19:15:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20190806171515.GR2349@hirez.programming.kicks-ass.net>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190806161741.GC21454@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806161741.GC21454@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 06:17:42PM +0200, Oleg Nesterov wrote:

> but this will also wake all the pending readers up. Every reader will burn
> CPU for no reason and likely delay the writer.
> 
> In fact I'm afraid this can lead to live-lock, because every reader in turn
> will call __percpu_up_read().

I didn't really consider that case important; because of how heavy the
write side is, it should be relatively rare.

> How about 2 wait queues?

That said, I can certainly try that.
