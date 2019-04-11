Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD12C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A5E20873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nn+R0jOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDKIMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:12:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Wb+8kDvOTlNP0v2y55MV3piIexTa+9FKS9+7edDCGE=; b=Nn+R0jOvISCE6gcqwEQXdfzDG
        Lg6jiuX2huUH+4WE/N1ncAGaU5Merd6ByA4KMCK2+q4ZNmkEKZ+XHds8pk4u4pQIjEGhZprFCmWxs
        odG97uDtlJYE3/uc8WekvR0PxgltJtU0IAxIztAJHhxkLk+cbj4HulS9U2AlmHnEH7fVhaPWz3avn
        tAi4k6ZtFXRE6FwCdb2WFs56gdInsCYwvqUUkzkSoTyWFSsjFPSJpSRSnDkqd6445j96oPoaHQywL
        qaphlFncrC8CotaAh/f+TCpF+oNGvsoum+TiFR3nrfsXlAeoxmj1zXlJ/SX8yiAiDEzIQ6W9Ck3Bc
        VStixML1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEUot-00086s-82; Thu, 11 Apr 2019 08:12:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 802A129AA8DC4; Thu, 11 Apr 2019 10:12:24 +0200 (CEST)
Date:   Thu, 11 Apr 2019 10:12:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v3 02/14] locking/rwsem: Make owner available even if
 !CONFIG_RWSEM_SPIN_ON_OWNER
Message-ID: <20190411081224.GB4038@hirez.programming.kicks-ass.net>
References: <20190410184231.6748-1-longman@redhat.com>
 <20190410184231.6748-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410184231.6748-3-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:42:19PM -0400, Waiman Long wrote:
> The owner field in the rw_semaphore structure is used primarily for
> optimistic spinning. However, identifying the rwsem owner can also be
> helpful in debugging as well as tracing locking related issues when
> analyzing crash dump. The owner field may also store state information
> that can be important to the operation of the rwsem.
> 
> So the owner field is now made a permanent member of the rw_semaphore
> structure irrespective of CONFIG_RWSEM_SPIN_ON_OWNER.

sem->owner is still initialized under CONFIG_RWSEM_SPIN_ON_OWNER.
