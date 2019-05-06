Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC8C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D493420675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kKO7IttU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEFLtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 07:49:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53698 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFLtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 07:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8UHyDT2NILIE6zelkrFD5LEf4niBe1di0tdn/KNzg4M=; b=kKO7IttUgrME5GjDQi9dLpeY2
        1r8+8i08arpw2i1fcGbhzB1S1Gxyuq02QfioPqX6OJTuaMmK6q+YMOWtSAahAhKasiCQq1p+SwDDd
        qaSyuIql0NxgPJxpWg6OUevUUMXH1OU1OCtty49lC2KlJ8SW34C6fxIdSc7ubma0avVw/aIfL5/dE
        X3fEQc8sN3m+FvbHaT3Ci8vzJo945BTKPhwXVq6yjVHhhH5mUIEdphVJRYsqLBMBH17SZE3hP0QhU
        cVJMStSZxbnChc/zjaGwDHcm1DSxd/ToDF5zPcA//rlvHM8urbCq9MMbcvGXICDraWAMgPrrcked3
        KjfvqJxog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNc7e-00012T-Nd; Mon, 06 May 2019 11:49:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 046F3286B6532; Mon,  6 May 2019 13:49:27 +0200 (CEST)
Date:   Mon, 6 May 2019 13:49:27 +0200
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
Subject: Re: [PATCH-tip v7 11/20] locking/rwsem: Wake up almost all readers
 in wait queue
Message-ID: <20190506114927.GJ2623@hirez.programming.kicks-ass.net>
References: <20190428212557.13482-1-longman@redhat.com>
 <20190428212557.13482-12-longman@redhat.com>
 <20190503165141.GI2623@hirez.programming.kicks-ass.net>
 <1e5e939f-3725-14d9-feec-aabb63998406@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e5e939f-3725-14d9-feec-aabb63998406@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 01:15:22PM -0400, Waiman Long wrote:
> Yes, that can work. However, that will require adding one more pointer
> to the rw_semaphore structure. The performance gain with this
> optimization may not justify increasing the size of the structure by 4/8
> bytes.

Indeed; what was I thinking :-)
