Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A38FC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5F32075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O9OrxwRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE0I2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:28:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37438 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfE0I2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jG0YRiGucklvYuVZTJyB07fViGd1R8ZrnIAO0vccWRE=; b=O9OrxwRXfF/WgSylBbzJ1LWjx
        Dbva2fgoEgHFoIs/blL2hWLO+Wd0dbGyAlhWcE1e2FeYfCthkC74xYH0ovXWJYF76ag1YmEmZIwLP
        10Ddi93cRD3B1F6FImnovzCk7EJGh1ZA/P3YqjHCDktoQFHJg3+2fkmfuJJEmhcAP80/GplsSyR+i
        K0Mbyrn2jDhanVU/eiLk9KAO7rie+PwX0U3O4vQTuzWJyIhojOsO6f4pI0s7TyAZhbQvuF2n7ZBne
        /CmBtru8IYlZj7FJPwT+VpJFDNYIQvT1eGZBphOB1dQ8NWi9Gl9DQiB54+n+joQmv5mfKbKyblk+a
        w44ehAJxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVAzn-0001QB-O9; Mon, 27 May 2019 08:28:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 211B820137ADA; Mon, 27 May 2019 10:28:36 +0200 (CEST)
Date:   Mon, 27 May 2019 10:28:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 0/6] x86/mm: Flush remote and local TLBs concurrently
Message-ID: <20190527082836.GQ2623@hirez.programming.kicks-ass.net>
References: <20190525082203.6531-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525082203.6531-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 01:21:57AM -0700, Nadav Amit wrote:
> The proposed changes should also improve the performance of other
> invocations of on_each_cpu(). Hopefully, no one has relied on the
> behavior of on_each_cpu() that functions were first executed remotely
> and only then locally.

Oh gawd... I actually have vague memories of code doing exactly that,
but I can't for the life of me remember where :/:
