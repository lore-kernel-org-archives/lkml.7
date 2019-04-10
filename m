Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1E6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21CA2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b7JYbSQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbfDJPK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:10:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732818AbfDJPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WWF8U355+WLbASZ/XsXG2aSbC6eOyuCHIl+Ne8Kvyqc=; b=b7JYbSQCRsUKU7weIfWKjqsgV
        vHlzJGaNsi6CP+iaC6WLpStjqkuxGI+/V1odk+ThAbU1G4K+P+ZVhfIzI1Qj35l17cq3g+6RvqyzS
        bmnccwF7X0gkCIwb+eVZ6AsP9XQJXhFl4VoB3fPcSviqPlraLFvAZNOgQMW3fwklsaqExeinq32Fu
        jXHYs+QGAR20xFZ2RS7Qb+c40iF4m7WYBUOHfqk+W4yMuoUe27KD5lsYFrlTm4cRDf3aonltmsy77
        d5CouLwUul4gKetDRHLkCFSsb1wW7Q7E2lkNuIDQimvMU8Qc1FTI1upqHPkMGkXww3rYCL8athN5W
        ay/jqotYQ==;
Received: from [89.200.33.100] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEErl-0006Mz-O5; Wed, 10 Apr 2019 15:10:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2A23984F06; Wed, 10 Apr 2019 17:10:18 +0200 (CEST)
Date:   Wed, 10 Apr 2019 17:10:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v2 02/12] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190410151018.GL7905@worktop.programming.kicks-ass.net>
References: <20190405192115.17416-1-longman@redhat.com>
 <20190405192115.17416-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405192115.17416-3-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 03:21:05PM -0400, Waiman Long wrote:
> +#define RWSEM_WAIT_TIMEOUT	((HZ - 1)/200 + 1)

Given the choices in HZ, the above seems fairly 'optimistic'.
