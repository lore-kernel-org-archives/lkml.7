Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A99C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E8622CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S22mIGBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfIDMUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:20:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfIDMUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Awvpdgkqn6/w+tezauopO9pT/rkCwfPb/ThYPnLC8xo=; b=S22mIGBDa3bIDmaOJah99xsFD
        /c7IULtxrQCz9AmzLPMibuTKx1dhSVAEaa8hVdn2c5xYy1TMv/KQpCVGApDA9ay043sxNlo+ZwlH4
        2UD4R/xW5ypUAhsJFI92Iu5uKj7NNmte0VHT1ijvIvIamRVshOmawFJykKiK8M84mlaeVfnwxALWa
        wkLFq0jmhjSk8hIzLtgM7M8AlKLiny42Kq0RJ9YzY4jzIUn7Bm+7ALkbABGEFsKO43qgsyyfhgWJV
        WlUWnaaQm2anLlACQIeN3YVISvlpuqijNJ8wT0lD1QPg1LOXHVW52GFlg7UBpWWrtrUJS9pmU/Lce
        HofrjIoPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5UGK-0004fb-Er; Wed, 04 Sep 2019 12:19:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD860306029;
        Wed,  4 Sep 2019 14:19:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BA2329D94A62; Wed,  4 Sep 2019 14:19:46 +0200 (CEST)
Date:   Wed, 4 Sep 2019 14:19:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: numlist_pop(): Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190904121946.GZ2369@hirez.programming.kicks-ass.net>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820081518.3r3cagzggtifsvhz@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820081518.3r3cagzggtifsvhz@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:15:18AM +0200, Petr Mladek wrote:

> 	do {
> 		tail_id = atomic_long_read(&nl->tail_id);
> 
> 		/*
> 		 * Read might fail when the tail node has been removed
> 		 * and reused in parallel.
> 		 */
> 		if (!numlist_read(nl, tail_id, NULL, &next_id))
> 			continue;
> 
> 		/* Make sure the node is not the only node on the list. */
> 		if (next_id == tail_id)
> 			return NULL;
> 
> 		/* cC: Make sure the node is not busy. */
> 		if (nl->busy(tail_id, nl->busy_arg))
> 			return NULL;
> 
> 	while (atomic_long_cmpxchg_relaxed(&nl->tail_id, tail_id, next_id) !=
> 			tail_id);

Both you and John should have a look at atomic*_try_cmpxchg*(); with
that you can write the above as:

	tail_id = atomic_long_read(&nl->tai_id);
	do {
		...
	} while (!atomic_long_try_cmpxchg_relaxed(&nl->tail_id, &tail_id, next_id));

And get better code-gen to boot.
