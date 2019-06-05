Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EF9C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDBF2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0RyEuNgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFEUTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:19:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55380 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFEUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g+z8rl+Xnk+hyJFTOmEaUyUD6LMuuoZuScd2+zmF/k4=; b=0RyEuNggsxAYEPYnWLRJDg0KV
        /1Losu3NqHqPKcVN1gPdr/SezAkavzJvVPNwXWFF8DqrtP1m7ryACy70yAbTQOcYuUa6nsqROLms7
        XD3mafLSmR57hUZYLm3v2t+uXGRqNWVzln2ViJsYprgVhvbqBo4hmLeLniUaMMycuiuPi55N81g/+
        n/V5/1HuEyx8kSA+G9jDwmVvPH4AH7xyYl+fZmPk0D3EobDz4NwgqLe52qyZWizjtlDeB185Zu80l
        KkscESH2Utrs7qvOtPrsGCpzYSdEUTuWJqamn0YFsOXEsm+DGUvuLnGXnLq/5MwCIKqp8s15kqymz
        F2B1moiSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYcND-00011A-Sy; Wed, 05 Jun 2019 20:19:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A681207A2CF3; Wed,  5 Jun 2019 22:19:01 +0200 (CEST)
Date:   Wed, 5 Jun 2019 22:19:01 +0200
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
Message-ID: <20190605201901.GB3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-16-longman@redhat.com>
 <20190604092008.GJ3402@hirez.programming.kicks-ass.net>
 <8e7d19ea-f2e6-f441-6ab9-cbff6d96589c@redhat.com>
 <20190604173853.GG3419@hirez.programming.kicks-ass.net>
 <f7f9b778-4f1a-7460-a7ae-1d4e3dd37181@redhat.com>
 <20190604181426.GH3419@hirez.programming.kicks-ass.net>
 <db89a086-3719-cea5-e24e-339085728c29@redhat.com>
 <46e44f43-87fd-251b-3b83-89a8bb3b407f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e44f43-87fd-251b-3b83-89a8bb3b407f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 02:13:27PM -0400, Waiman Long wrote:

> Using cmpxchg_double is actually more risky than I thought. I have been
> trying to try to use cmpxchg_double for down_write, but I kept getting
> kernel panics because the rwsem wasn't 16b-aligned. As rwsem is embedded
> in quite a large number of structures, they all have to align properly
> to make that work or the kernel will panic. That does seem too risky to
> me. So I am dropping the idea of trying to use it.

Urgh, that's another things that's been on the TODO list for a long long
time, write code to verify the alignment of allocations :/ I'm
suspecting quite a lot of that goes wrong all over the place.

