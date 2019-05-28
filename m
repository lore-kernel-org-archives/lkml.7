Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CAFC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F2220883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PpvBwG42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfE1MFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:05:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49136 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1MFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ftNsAuf2ZIGaGmzJ8tp0H6vv9flP6yOPkxjrapmoDHQ=; b=PpvBwG42pyiuVFoap759dYsMq
        oj5RxxPGDtf1+0QaQRXh06yBpFdxZNByut+WFQ+uoDKdY0Gsc4xaN2qPusaYL/Fkz6ibyD4Cet7jW
        acci7FNmSReo3OMN4dTCjn52ykzEjfsm9EPa71Y49tekrHF2JUwLuqmCYx5i4VHOCJcMyEvVxJREG
        ccK9CefDEd0OC7fp0XQpWAK5OkVnUh9raEM34VPX5BITXFGkt19Dy/1+Y+w4j0TBAAJUwZ+Q5C27O
        6e5fXuWdytGGe6vAqRg62rBvpTTklSmbowOxdYhEYz3KHH9fkbkVTD73SjnX3HGKx1/RBgHGeZME8
        6uKseOd0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVarC-0003Ei-Ci; Tue, 28 May 2019 12:05:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 954652074C650; Tue, 28 May 2019 14:05:28 +0200 (CEST)
Date:   Tue, 28 May 2019 14:05:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 2/9] perf/x86/intel: Basic support for metrics counters
Message-ID: <20190528120528.GR2606@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521214055.31060-3-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:40:48PM -0700, kan.liang@linux.intel.com wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Metrics counters (hardware counters containing multiple metrics)
> are modeled as separate registers for each TopDown metric events,
> with an extra reg being used for coordinating access to the
> underlying register in the scheduler.
> 
> This patch adds the basic infrastructure to separate the scheduler
> register indexes from the actual hardware register indexes. In
> most cases the MSR address is already used correctly, but for
> code using indexes we need a separate reg_idx field in the event
> to indicate the correct underlying register.

That doesn't parse. What exactly is the difference between reg_idx and
idx? AFAICT there is a fixed relation like:

  reg_idx = is_metric_idx(idx) ? INTEL_PMC_IDX_FIXED_SLOTS : idx;

Do we really need a variable for that?

Also, why do we need that whole enabled_events[] array. Do we really not
have that information elsewhere?

I shouldn've have to reverse engineer patches :/
