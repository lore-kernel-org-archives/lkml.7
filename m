Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2C5C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3B920850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ePYgcPCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbfHZQ75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:59:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56402 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfHZQ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eS5qZ9oqLSTyPEs2EeKkRnMps4Ow/ixyeXGcE7RbQLc=; b=ePYgcPCzeeFBQU+pSFpNIe3ED
        51CGFi4sQ0Sp0A9LkmtDioAu9CFbePD6J/vTDhmQSZQOEUsZJJ8uiFh6/i+eA18LN0FF0ElFBTp5I
        UgKRZN3rJxkK1y2PQkYvhnTmZ98ZkTqu44bQuP6d5pkWPRvGRQa0fzvro6z9pa/+I/I3timXsWF3f
        X/oU3k0rfIIuqN/nIejmPc7EjgYTkxNkC5NNt8Wb++CqC2f27tgoqykhLeZTQMNmCrtvEt0/rmRFU
        tmC6RXzdj7pRcWo6RZ1UoXuNZcK5eaThkCKTJ1jpgVo5CiBUq77OnS+JFAQ2pWcaeL9hhkUNjECNV
        xWCHF6bVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2IL7-00053a-Ua; Mon, 26 Aug 2019 16:59:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD1EC30759B;
        Mon, 26 Aug 2019 18:58:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C68A20C95709; Mon, 26 Aug 2019 18:59:30 +0200 (CEST)
Date:   Mon, 26 Aug 2019 18:59:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mark gross <mgross@linux.intel.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 01/16] stop_machine: Fix stop_cpus_in_progress
 ordering
Message-ID: <20190826165930.GY2369@hirez.programming.kicks-ass.net>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <0fd8fd4b99b9b9aa88d8b2dff897f7fd0d88f72c.1559129225.git.vpillai@digitalocean.com>
 <20190826161929.GB2680@u1904>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826161929.GB2680@u1904>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 09:19:31AM -0700, mark gross wrote:
> On Wed, May 29, 2019 at 08:36:37PM +0000, Vineeth Remanan Pillai wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Make sure the entire for loop has stop_cpus_in_progress set.
> It is not clear how this commit comment matches the change.  Please explain
> how adding 2 barrier's makes sure stop_cpus_in_progress is set for the entier
> for loop.

Without the barrier the compiler is free to move the stores around. It
probably doesn't do anything bad, but this makes sure it cannot.
