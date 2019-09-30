Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F63C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F0720815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nrkpJjQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfI3QWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:22:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55358 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfI3QWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tudo8CMoQ3j7K20rsYG/56HXQk4N1es+5/nb+YFHKVc=; b=nrkpJjQLISxc+dVJV/OrUItwk
        Rapd3GszP7bwfw4oxz60ivmIxG/oP4qAawl+kiEf0YB0/lFgC5pP+HDzKp+zPG6QHVFDS36yc/h4r
        U16esCZWcW9AwLffLHS1IdzYfVGJ3lPEqE48VuJCQVMfqjzVC3D+JUxnDxhlWeajjRKPNDDXUFwVk
        qxUkI2UbVhlnS8cIUnntBfycgYNbv3OodGRj1fQhdUXsMgPetT/xYRrLOxrs7r8/b5q/I8DlA3vk1
        jXClCEMHbRubzF7C2uh7D8bTxAvnUwG/bDohu21k0wAuUVFDqBLD8W0/R6kS58piWBODhw+ijMUJB
        lYSmUv8RQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEyQs-00065f-Jd; Mon, 30 Sep 2019 16:21:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4439F305DE2;
        Mon, 30 Sep 2019 18:21:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EED325D64796; Mon, 30 Sep 2019 18:21:53 +0200 (CEST)
Date:   Mon, 30 Sep 2019 18:21:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V4 07/14] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190930162153.GG4519@hirez.programming.kicks-ass.net>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
 <20190916134128.18120-8-kan.liang@linux.intel.com>
 <20190930130615.GN4553@hirez.programming.kicks-ass.net>
 <20190930140755.GE4581@hirez.programming.kicks-ass.net>
 <20190930145321.GF4581@hirez.programming.kicks-ass.net>
 <06e16f73-f6af-5019-3d85-bc33740e0c8f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06e16f73-f6af-5019-3d85-bc33740e0c8f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 12:17:57PM -0400, Liang, Kan wrote:
> 
> 
> On 9/30/2019 10:53 AM, Peter Zijlstra wrote:
> > 
> > After that, I think we can simply do something like:
> > 
> > icl_update_topdown_event(..)
> 
> We should call this function in x86_pmu_commit_txn()?

Nah, we could use that TXN_READ stuff, but I don't think we have to. We
just raely on having done all ->read() callbacks before doing
perf_event_count().

> > {
> > 	int idx = event->hwc.idx;
> > 
> > 	if (is_metric_idx(idx))
> > 		return;
> > 
> > 	// must be FIXED_SLOTS
> 
> The FIXED_SLOTS may not be in the group.

Argh.. can we mandate that it is? that is, if you want a metric thing,
you have to have a slots counter first?
