Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CD7C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1812073D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ULnLJ4K8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfLLSw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:52:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbfLLSw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UAW1ah/zMEVPrM4BrmmG4oJa5oj8GN7NGMTEj+zIUkg=; b=ULnLJ4K88qx9pqI8htlKdv8uO
        O+EPeMwQcSUZCfSP5T87ceHqiwQ4dPXTqvjbpvNG6TiLDb9btREGZlonxY3nHcxyDMsKG/TLt+Ryx
        lOHwjLmc/e6p2wL8AYCjbyn9UUBpljEEUo6d6/FnhNn2n93AbeJO3r4p+b8BmtvWYrjQeprCuJ/in
        quMmKEi+98akirRwxnMCVT9XXzHE83iqwHBCuF55jf6siYfarJ3uvg/D/lfnliOm+SXZlR0vK+8tp
        m0EedonGDyEJWLIl7+uBKScoP1VTzjJYHMJCHvSvrslM3zYd6mmB6DHbwX+67aznTYC6znbpKFTlC
        c2xUAatmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifTZX-0005VT-B1; Thu, 12 Dec 2019 18:52:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46659306BF0;
        Thu, 12 Dec 2019 19:51:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD3132B195D76; Thu, 12 Dec 2019 19:52:20 +0100 (CET)
Date:   Thu, 12 Dec 2019 19:52:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8] perf: Sharing PMU counters across compatible events
Message-ID: <20191212185220.GD2827@hirez.programming.kicks-ass.net>
References: <20191207002447.2976319-1-songliubraving@fb.com>
 <20191212153947.GY2844@hirez.programming.kicks-ass.net>
 <990C21F3-A93B-414A-9DB7-C17AADF037C7@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <990C21F3-A93B-414A-9DB7-C17AADF037C7@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 03:45:49PM +0000, Song Liu wrote:
> > On Dec 12, 2019, at 7:39 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > Yuck!
> > 
> > Why do you do a full reschedule when you take out a master?
> 
> If there is active slave using this master, we need to schedule out
> them before removing the master. 
> 
> We can improve the check though. We only need to do it if the master
> is in state PERF_EVENT_STATE_ENABLED. 
> 
> Or we can add a different function to only schedule out slaves. 

So I've been thinking, this is because an NMI from another event can
come in and then does PERF_SAMPLE_READ which covers our event, right?

AFAICT every other case will run under ctx->lock, which we own at this
point.

So can't we:

 1 - stop the current master (such that the counts are frozen)
 2 - pick the new master
 3 - initialize the new master (such that the counts match)
 4 - set the new master on all other events
 5 - start the new master (counters run again)

Then, no matter where the NMI lands, it will always find either the old
or the new master and their counts will match.

You really don't need to stop all events.
