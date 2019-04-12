Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE19C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE0020850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t7yIURud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfDLHF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:05:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfDLHF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ohqIoUyux3kWJtgiMUdgYQWefkSRkqRwL0vAokJo07s=; b=t7yIURudTYVwdtwvmqeydntx1
        I6K9q0gOYRDpZU5U+xZjP6YpsB2v6Ou6Km90AmNd+r+kdfyMdebnvVaTVKSstUYcmihSErWUJM74O
        8823ctd/18o2spwU2FOh8txEF6bJa0PqgucQYvtGgU4gLo89PcdrGrbgpTjPWHiL0tpyag8TwbZzH
        CWPObDEGQu96PzJGbEAXT1wiKcaX3rx+apnQQDEI+lG8N0B4IW7kuxHOF+Zso/3+c1x63oVfW/PMf
        mCji21D++SZ9hWpRBCG+mqtRF4P0vM1mzdmk+D8Pilaj4gE9GNL4SyARjcnUD/krVgXkcBpjuqlq8
        B9RuAjLMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEqFv-0000tm-R5; Fri, 12 Apr 2019 07:05:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BD6E203C087C; Fri, 12 Apr 2019 09:05:45 +0200 (CEST)
Date:   Fri, 12 Apr 2019 09:05:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v3 02/14] locking/rwsem: Make owner available even if
 !CONFIG_RWSEM_SPIN_ON_OWNER
Message-ID: <20190412070545.GF11158@hirez.programming.kicks-ass.net>
References: <20190410184231.6748-1-longman@redhat.com>
 <20190410184231.6748-3-longman@redhat.com>
 <20190411081224.GB4038@hirez.programming.kicks-ass.net>
 <29aca54a-536e-6e46-7e18-658914c34548@redhat.com>
 <20190412070209.GC129493@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412070209.GC129493@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 09:02:09AM +0200, Ingo Molnar wrote:
> 
> * Waiman Long <longman@redhat.com> wrote:
> 
> > On 04/11/2019 04:12 AM, Peter Zijlstra wrote:
> > > On Wed, Apr 10, 2019 at 02:42:19PM -0400, Waiman Long wrote:
> > >> The owner field in the rw_semaphore structure is used primarily for
> > >> optimistic spinning. However, identifying the rwsem owner can also be
> > >> helpful in debugging as well as tracing locking related issues when
> > >> analyzing crash dump. The owner field may also store state information
> > >> that can be important to the operation of the rwsem.
> > >>
> > >> So the owner field is now made a permanent member of the rw_semaphore
> > >> structure irrespective of CONFIG_RWSEM_SPIN_ON_OWNER.
> > > sem->owner is still initialized under CONFIG_RWSEM_SPIN_ON_OWNER.
> > 
> > Oh, you are right. I missed that part. I will fix it in the next version.
> 
> Could you please post the next series against tip:WIP.locking/core, which 
> is already being dogfood-ed in -tip and which I'm running on my desktop? 
> I'll backmerge any fixes as needed/requested.

Urgh, please no, that's going to be hell to review :/
