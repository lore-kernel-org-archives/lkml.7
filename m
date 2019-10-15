Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1173C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BB92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IwQ6tTgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfJOHpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:45:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33518 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfJOHpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Hgn7iVDBV+n+q/nBUSuDJ2Mme2Wkao4IdSyE+LUxiE=; b=IwQ6tTggyHqxATubsClf1JVOH
        Qsg2v646S3Af948s+WcM6EYBwvPYGUJ0Ceu4ZeUx3DIvU3smHQZ2DIffehy5q8jR7qp14p7Ij4MKX
        Yet/dmI2VoYHalcZxFiHZAre9MhepTrI94V/q1X483+jneHAJBBKShqFmWRfvEXv1/6nb402HjDw3
        W/hHo6QxiRPNxC1rL4WRvouBvwp6ZbA7oyBaK+BXnOuPWasB4QuFkEL2S16TWh3VOJNgB0pB1aY6Q
        +ud3rq4a6BY+h6WIXLBY6qLdDFSrv5zjwxp45Jizm+O6D+3bAiyAiyCSmjdGNN2o32bW2R0PB5Z13
        mfezhuHIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKHWI-0008M7-45; Tue, 15 Oct 2019 07:45:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5729B300B8D;
        Tue, 15 Oct 2019 09:44:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B798120238A89; Tue, 15 Oct 2019 09:45:22 +0200 (CEST)
Date:   Tue, 15 Oct 2019 09:45:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 6/6] Documentation/memory-barriers.txt: Clarify cmpxchg()
Message-ID: <20191015074522.GB2311@hirez.programming.kicks-ass.net>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-7-manfred@colorfullife.com>
 <20191014130321.GG2328@hirez.programming.kicks-ass.net>
 <ef45c2ca-942a-df83-22cf-690eaf761fb7@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef45c2ca-942a-df83-22cf-690eaf761fb7@colorfullife.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 07:49:56PM +0200, Manfred Spraul wrote:

> From 61c85a56994e32ea393af9debef4cccd9cd24abd Mon Sep 17 00:00:00 2001
> From: Manfred Spraul <manfred@colorfullife.com>
> Date: Fri, 11 Oct 2019 10:33:26 +0200
> Subject: [PATCH] Update Documentation for _{acquire|release|relaxed}()
> 
> When adding the _{acquire|release|relaxed}() variants of some atomic
> operations, it was forgotten to update Documentation/memory_barrier.txt:
> 
> smp_mb__{before,after}_atomic() is now indended for all RMW operations

"intended"

Otherwise it looks fine, thanks!
