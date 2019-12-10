Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56309C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CCC2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nJQQ5N25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfLJRkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:40:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfLJRkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9j5lu+komvsOIuFYwuLXwgEIPwyUN5cHw5C4lmyttnM=; b=nJQQ5N25crIQg6KM6/qa9iPzi
        Rc25VPA7ktubMNLg/0khzmI9Vg6aKHJDPvqKAW0XQ4LNeZk2I303hTF1tInjUF9ftEqCzVxsMin7R
        Rfn6RMWbP2avR8XEtvfLHBfNTgug7wjDhmXqHe0dzZFV4yKRFDSzKKt0f/nr1X+gyfZ7JQxSH9Qpa
        Z4iBLc8nG8hAMbWUugDA8eFnXA+7EmT8/Um/OhGknEbo0ZAD6pzTYH1em/VDWCjD6OTN2wRlxeHmJ
        +Lk3SxZquhlERVNPkS5z2W/CA8eBhi7aoHI9RrpKG/inS2sBhbqjwNXd12++nU8y04+hQoP6Th+l4
        Bx/npYpng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iejVB-0004lN-4s; Tue, 10 Dec 2019 17:40:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C4CF300565;
        Tue, 10 Dec 2019 18:39:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20A9C29E1B2EA; Tue, 10 Dec 2019 18:40:47 +0100 (CET)
Date:   Tue, 10 Dec 2019 18:40:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 0/2] perf/x86/intel/bts: Small fixes
Message-ID: <20191210174047.GQ2844@hirez.programming.kicks-ass.net>
References: <20191205142853.28894-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205142853.28894-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 05:28:51PM +0300, Alexander Shishkin wrote:
> Hi Peter and Ingo,
> 
> Here are two small fixes that resulted from running perf_fuzzer on a !KPTI
> kernel. One is a misguided and unannotated warning and another is a sketchy
> use of page_private(). The choice between deleting the BTS driver and
> fixing it is not obvious, though. It may theoretically still have users.
> 
> Alexander Shishkin (2):
>   perf/x86/intel/bts: Remove a silly warning
>   perf/x86/intel/bts: Fix the use of page_private()

I'll squash the pair, that makes more sense to me.
