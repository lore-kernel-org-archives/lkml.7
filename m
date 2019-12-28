Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F180EC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 11:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABBD207E0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 11:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cStUo1AA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfL1Ltt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 06:49:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfL1Ltt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 06:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B4N/Pajva8FCKvPVBeM24EtxvHj9mSBvKt6CCr/F2kw=; b=cStUo1AA8SqM/4+GW8ld0Q5qs
        huukWX6L+uFdR9NUBkY+krZtF901qmo9uaV2p0t8wTSnE+O+BD+6zBfASRFY2vq/ILfOsn2G9b/ij
        kkO+2T8TxouMBgM8CO+md57BAa0h2krLClG/+qnfQ0NChbBw79nquEHqQepzYsZ7ddp1KJo4CEwn1
        PYeFGZfv3LGnqbONyEIIx/KkabVMnStGxB12XqVZPQdRSuWtl08GhLkkG+YIq327OKIW3lYZry2MQ
        GBqCoRVTzOUCqj790ppUn0xb8Xmxm2ig4q1I8YCBt90hIf6Je96hOapooJ7d8gMLP0quwZbkJqMsU
        Rw2oTlJ2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ilAav-0003Lw-Og; Sat, 28 Dec 2019 11:49:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B122300596;
        Sat, 28 Dec 2019 12:47:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B495A20E07103; Sat, 28 Dec 2019 12:49:18 +0100 (CET)
Date:   Sat, 28 Dec 2019 12:49:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <20191228114918.GU2827@hirez.programming.kicks-ass.net>
References: <20191226152922.2034-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226152922.2034-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 09:29:22AM -0600, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wrap refcount_dec_and_lock() and refcount_dec_and_lock_irqsave() with
> macros using __cond_lock() so that 'sparse' doesn't report warnings
> about unbalanced locking when using them.
> 
> This is the same thing that's done for their atomic_t equivalents.
> 
> Don't annotate refcount_dec_and_mutex_lock(), because mutexes don't
> currently have sparse annotations.

I so f'ing hate that __cond_lock() crap. Previously I've suggested
fixing sparse instead of making such an atrocious trainwreck of the
code.
