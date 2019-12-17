Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C7AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E778E20716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H7Qpu+WL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLQKf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:35:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52336 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLQKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cpguh3IDeCnxmoBZl/VM0JnqhlGLFdyEGgb+VrtQl8g=; b=H7Qpu+WLL1B0AHle/9R8MNW2E
        I0GB2ODZAWckMRmP9XPilPQ0SIr8T2qBqKoicFwRsHkLiNIFZLAJ9tExilRyFUUe0t90DcOB6rSdM
        eett1zSJyl2cJeXHnMMmzoKhcy+4IDxDsmP0/oy4tf7QeELqt9PKT3xmhnZB0pqIMHqv+Be44+QNQ
        bLbnST3mgcGcDZmqKZaDQNaOAkV/XqzaJ8+2PqTrusgK3GSC6P1RMJHjZgZmXU9cKt5jZbT/i20eg
        rCR1bcEfylxaVZdvHh34jvLwfJM758dgv8/W+UDXykdBHF2acWzAahl/58V+rFJ89LHKRI8hpbCi7
        KStGBOhHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihACj-00056i-7M; Tue, 17 Dec 2019 10:35:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 632733035D4;
        Tue, 17 Dec 2019 11:34:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8CD729E71042; Tue, 17 Dec 2019 11:35:47 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:35:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, jack@suse.com
Subject: Re: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20191217103547.GC2844@hirez.programming.kicks-ass.net>
References: <20191113102115.116470462@infradead.org>
 <20191113102855.925208237@infradead.org>
 <20191118195304.b3d6fg4jmmj7kmfh@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118195304.b3d6fg4jmmj7kmfh@linux-p48b>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 11:53:04AM -0800, Davidlohr Bueso wrote:
> On Wed, 13 Nov 2019, Peter Zijlstra wrote:
> > @@ -54,23 +52,23 @@ static bool __percpu_down_read_trylock(s
> > 	 * the same CPU as the increment, avoiding the
> > 	 * increment-on-one-CPU-and-decrement-on-another problem.
> 
> Nit: Now that you've made read_count more symmetric, maybe this first
> paragraph can be moved down to __percpu_rwsem_trylock() reader side,
> as such:
> 
> 	/*
> 	 * Due to having preemption disabled the decrement happens on
> 	 * the same CPU as the increment, avoiding the
> 	 * increment-on-one-CPU-and-decrement-on-another problem.
> 	 */
> 	preempt_disable();
> 	ret = __percpu_down_read_trylock(sem);
> 	preempt_enable();

There's another callsite for that function too, so I think the current
place still works best.

