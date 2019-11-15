Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355EBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4E520729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TNzmAWCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKOOHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:07:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lAZYg3lS135TwSE30pNm6foCygkKVQSy8A1PI6nH2bM=; b=TNzmAWCCScOR2GxCFXUW0B9z6
        Tu9V8WfQkcTEmTnlofuupVMf4k+D8zlIKu5xM7xLUlAPNYFh4evZ+fzTa7jHk7G41vcch05E32xvQ
        ZTzXogv37+1W6ffGTnP9Zj/XpuDm0y1vdPchaII8iZPkUW5XThG5k+10Y44PZE8h63Y2zzCP3nTEy
        q2V3LrcA/6OnoHuQ4xI/PW4SQWLy6fCeLZjyCmtJKWtKv8c7Y/u620R/tSkAXsSVKJiqgqA18pFdQ
        MwsIRwzQDxxQAuWuD0G684VqYqIv6M8FAQz9ZmdmxJK0lvZPFtU2XU/1peO9A8GPEJJp6Ue9gpPKm
        BxCuXhzOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVcGC-0000rB-Qe; Fri, 15 Nov 2019 14:07:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13AE9303D9F;
        Fri, 15 Nov 2019 15:06:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 338A02B12E7AC; Fri, 15 Nov 2019 15:07:39 +0100 (CET)
Date:   Fri, 15 Nov 2019 15:07:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH] perf/x86/intel: Avoid PEBS_ENABLE MSR access in PMI
Message-ID: <20191115140739.GM4131@hirez.programming.kicks-ass.net>
References: <20191115133917.24424-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115133917.24424-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 05:39:17AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The perf PMI handler, intel_pmu_handle_irq(), currently does
> unnecessary MSR accesses when PEBS is enabled.
> 
> When entering the handler, global ctrl is explicitly disabled. All
> counters do not count anymore. It doesn't matter if the PEBS is
> enabled or disabled. Furthermore, cpuc->pebs_enabled is not changed
> in PMI. The PEBS status doesn't change. The PEBS_ENABLE MSR doesn't need
> to be changed either.

PMI can throttle, and iirc x86_pmu_stop() ends up in
intel_pmu_pebs_disable()
