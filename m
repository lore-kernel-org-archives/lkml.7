Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1BDC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59EC204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aovxQVXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfDQHNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:13:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQHNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ay6pB6Tao4Oq8JNPjAEYYOWN5BO2WLe+exSGHeFUb9g=; b=aovxQVXAIDWql2opzekWL9IKc
        ZiQHOQe2VfXodYFiWW3TP/AZT18u0n9Xxr25nPVWcQiBqNl2TshVj4ycDuH+fMJ5iHKo4hp0q91pW
        SJmRr4Hol9lHgNCc8+Ls56QjqwXVeQ3wLs2Nz3IA+KRe6YwnfQ0yPZoAwxo8vjL3ejiD/vq3/tMj3
        nEJ0Aep+iz+GwcoDi0rIZL8RZUFkz23bXqm2k4jc09nn6MZFLQBIPmbCnBFyCeuBlcWtZv7CrpRnI
        XY6a6e7uRFZjx3HTW4lT5rm78PONwKBtYZRuJt5w9XlyA973w4eqnqNI7eByWWq2FBgH0MLYAZNWM
        FpT5UG/EQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGekm-0005ey-Vl; Wed, 17 Apr 2019 07:13:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 910FD200BFB38; Wed, 17 Apr 2019 09:13:06 +0200 (CEST)
Date:   Wed, 17 Apr 2019 09:13:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 07/16] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190417071306.GX4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-8-longman@redhat.com>
 <20190416141205.GK12232@hirez.programming.kicks-ass.net>
 <4b36b0a5-8507-f90c-d4a7-3f821ee8da6d@redhat.com>
 <55474839-269f-4dbc-23af-a9c873db6c66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55474839-269f-4dbc-23af-a9c873db6c66@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 05:07:26PM -0400, Waiman Long wrote:

> Thinking about it again. I think I will just change its definition to
> "((HZ + 249)/250)" for now to make sure that it is at least 1. The

DIV_ROUND_UP()
