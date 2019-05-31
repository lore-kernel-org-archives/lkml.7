Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EA8C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A866C268FD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fu7jv48T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfEaMx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:53:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DlL4wtoEGkM4QG59LQfepPzxOPYXU06TZvlBD/LeQrE=; b=fu7jv48TN/LLMHW7NxBKy9n6V
        oa90QMWRwGSIAA+Ez7MUsd/icARLqJbeKfE8YkpDmkkNjcci5ianBURtaFBWs7I3xc5Zifzoc/b4E
        ayO8XhPVrk1fznnqjxmHi7TeLlyFKtZaSeV1coUmLhJOVSvxgzlZnx1S+Mzp+QnjMWPYtxkIQJxez
        IIukJ084dlZvyjvoBsVf/k0LMXaM4S7RgfA8Xs7LJ5c5SMrDajFa3HrzHe/zuSZH04udJ2Z2EbhmJ
        TBC6INGpKn7+yIV7PqVgXGsEC19R4q/T6IprHUrEoksjrNZKZCcm0dts8aFnfpAT++x+pzT0hNNEc
        6xUUNIWrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWh2C-0003Mk-NZ; Fri, 31 May 2019 12:53:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64ABA20274AFF; Fri, 31 May 2019 14:53:22 +0200 (CEST)
Date:   Fri, 31 May 2019 14:53:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
Message-ID: <20190531125322.GY2606@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095607.GC17637@hirez.programming.kicks-ass.net>
 <274e29d102133f3be1f309c66cb0af36@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274e29d102133f3be1f309c66cb0af36@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 01:15:21PM +0200, Roman Penyaev wrote:
> On 2019-05-31 11:56, Peter Zijlstra wrote:
> > On Thu, May 16, 2019 at 10:58:03AM +0200, Roman Penyaev wrote:

> > > +		i = __atomic_fetch_add(&ep->user_header->tail, 1,
> > > +				       __ATOMIC_ACQUIRE);
> > 
> > afaict __atomic_fetch_add() does not exist.
> 
> That is gcc extension.  I did not find any API just to increment
> the variable atomically without using/casting to atomic.  What
> is a proper way to achieve that?

That's C11 atomics, and those shall not be used in the kernel. For one
they're not available in the minimally required GCC version (4.6).

The proper and only way is to use atomic_t, but also you cannot share
atomic_t with userspace.

The normal way of doing something like this is to have a kernel private
atomic_t and copy the value out to userspace using smp_store_release().
