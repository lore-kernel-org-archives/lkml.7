Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79248C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA7E2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VnzWlp6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfDZHOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:14:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfDZHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VuY7zu1pTotUfMqAj4cNucA6VxR717avWOjXloOTPUE=; b=VnzWlp6+IsolVsQB95l8xyKvC
        9oCIEXjmI09FNmMEK0o2shAwX3cR24v1HQi352VI6cdeRh5rFZsxwWtQx7+iHkKc+Z2Kl/rdSolkI
        xlnY+RHBzaLAgNJnZRXX1fzr320lZlQED3mtXGXzZU/RBBdPGG5cpu8OG3ot/qQsR075nNjwbiMG8
        3dSbLG6RcGKdIVrCdkmK1afDCaIvBmxnyHFVRz2Bz71y1cQx9Jy3GCkznPMm/DfsGhIFUDDOwc4Oi
        Nj+le3L+RL/SJqtdm1tLtJIg+YnLBfpuunFK/7cF742hGgPTLbrkF8KOTxE+uqmvjkQiah9B9Yu5Q
        fcX3Qn40Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJv47-0004cq-Ga; Fri, 26 Apr 2019 07:14:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6942429C45529; Fri, 26 Apr 2019 09:14:33 +0200 (CEST)
Date:   Fri, 26 Apr 2019 09:14:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] bpf: Fix preempt_enable_no_resched() abuse
Message-ID: <20190426071433.GX4038@hirez.programming.kicks-ass.net>
References: <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net>
 <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
 <20190423193435.GX4038@hirez.programming.kicks-ass.net>
 <88ba7be0-9ec5-941e-1b3f-80fbe05fe3a0@redhat.com>
 <20190423195559.GY4038@hirez.programming.kicks-ass.net>
 <20190425212338.zo3gzg4avfy6ukxf@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425212338.zo3gzg4avfy6ukxf@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:23:40PM -0700, Alexei Starovoitov wrote:
> Applied to bpf tree. Thanks!
> It should have been fixed long ago. Not sure how we kept forgetting about it.

Thanks!
