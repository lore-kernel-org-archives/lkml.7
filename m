Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36589C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DC320872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVS/84be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbfDQKTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:19:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDQKTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PtxPNhcPSDEVq3vvBY5zgEd48XRH8i7KjKjRALWKodY=; b=BVS/84be1IE7J0Q6Y+M+/S4xw
        iQsZsRWvQzaKLZdOOuynb10Y0bR1guVMd1Rqs3j8hgQ2x0YPWB6C6lkIstUtjJLG0Fzlh+0cbL3El
        9McolpLLOiuxJUipQzdzxNRYvyduRzyW+Wa4fQY61Qp2lZ69mTSRySoTHDKuBqdgaP6FBJAzdpAXn
        lSsjBM4wlBOUab/rX3cjRjmzJ5d6wzqZuxG9usezNk8WI0t2++cVpVIeuRJJROz3EK0ZtgvrHPz5m
        HNjDSmXBR6nbDlTODmBPjDKTDPeF8sWMdwavtJmhSI8qdRE5vOgxQ+SkRmbEtbfZ+CdZwF9Iu0PPZ
        let3TKMag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGhek-00080P-4c; Wed, 17 Apr 2019 10:19:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9592529B53433; Wed, 17 Apr 2019 12:19:03 +0200 (CEST)
Date:   Wed, 17 Apr 2019 12:19:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 08/16] locking/rwsem: Make rwsem_spin_on_owner()
 return owner state
Message-ID: <20190417101903.GD4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-9-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-9-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:22:51PM -0400, Waiman Long wrote:
> In the special case that there is no active lock and the handoff bit
> is set, optimistic spinning has to be stopped.

This makes me think this should've been _before_ you added the handoff
bit. So that when you introduce the handoff, everything is solid.
