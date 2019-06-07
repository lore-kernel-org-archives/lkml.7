Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5527C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F366212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E234jJcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfFGNgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:36:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46432 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbfFGNgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lVEgFqucFox4g1IviFAgPH+wq2tolwksp9dr8CFQhYQ=; b=E234jJcArQlGrReDPRTDlQHQw
        /51XA81tWbNBlNGxjegBAG8xYGT10JhKdGURd6yq4uCPjy6al62Aq3+i5MqZmTBQWE2Jxd9aEgq/b
        wJN1kFrziNof1cTWsCOA+Kro46LMQL8l0tTMmo20PPlvS2PC9TbtRQUqklSoDNjY5uEhSQLS9nXow
        R0foGNit83P0n3Jp6w76ssk7IkHaJl4axBNuofWSbBG9wzs4ALgYpEcy6+azMIrtkFq5rBdT76H7y
        IVGo9zhzexKE60uh1YvVJPfp2JQ2kTZPq0+6O6pfvn828eCNoKFIUwfGg9DdWWPruXIHZExArLGYS
        XtVrEgXIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZF22-0001XU-1L; Fri, 07 Jun 2019 13:35:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5C8D20216EFA; Fri,  7 Jun 2019 15:35:41 +0200 (CEST)
Date:   Fri, 7 Jun 2019 15:35:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, hch@lst.de,
        oleg@redhat.com, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
Message-ID: <20190607133541.GJ3436@hirez.programming.kicks-ass.net>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 09:04:02AM -0600, Jens Axboe wrote:
> How about the following plan - if folks are happy with this sched patch,
> we can queue it up for 5.3. Once that is in, I'll kill the block change
> that special cases the polled task wakeup. For 5.2, we go with Oleg's
> patch for the swap case.

OK, works for me. I'll go write a proper patch.

Thanks!
