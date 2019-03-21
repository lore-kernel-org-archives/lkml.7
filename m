Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C508C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08814218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XOHm4lEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfCUVRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:17:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfCUVRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=018CXVSVwft/EmWph41zPEaJ2HQbGhFsoYhYSDGRE34=; b=XOHm4lEGdQwPphRsUgNIxNSrG
        zoJtjgaluD5xeyE67K2AAHYmrb6oCN2HIjodt1I94Ph20QoqNXQzMp8oRdS53GWRPJjKy2SvrVq0l
        bE+qGovnyUCSH4N9HuNq71dPFDrbzgoLbdBHvuodGmtTGh3wHXHOg9T62Pzj86pnq9UIzfVwSSceZ
        D/djmcX7M4nPhKSBvhOyi4mCwao0I9habecxhAQjFV7neiL4NKMy0yd2wjKONE6I3R6GCGddlYTVw
        KOk8tRQ9QUC4LLPgF+otB4JV5by3qvsmCmdk08BzNzDd+dTxyvixd6d+OtUMFk0i+572R09lIWBzu
        rtjXJNSLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h753o-000384-PL; Thu, 21 Mar 2019 21:17:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC9E8984EEA; Thu, 21 Mar 2019 22:17:10 +0100 (CET)
Date:   Thu, 21 Mar 2019 22:17:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V2 04/23] perf/x86/intel: Support adaptive PEBSv4
Message-ID: <20190321211710.GC7905@worktop.programming.kicks-ass.net>
References: <20190321205703.4256-1-kan.liang@linux.intel.com>
 <20190321205703.4256-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321205703.4256-5-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:56:44PM -0700, kan.liang@linux.intel.com wrote:
> +static inline void *next_pebs_record(void *p)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	unsigned int size;
> +
> +	if (x86_pmu.intel_cap.pebs_format < 4)
> +		size = x86_pmu.pebs_record_size;
> +	else
> +		size = cpuc->pebs_record_size;
> +	return p + size;
> +}

> @@ -1323,19 +1580,19 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
>  	if (base == NULL)
>  		return NULL;
>  
> -	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
> -		struct pebs_record_nhm *p = at;
> +	for (at = base; at < top; at = next_pebs_record(at)) {
> +		unsigned long status = get_pebs_status(at);

afaict we do not mix base and adaptive records, and thus the above
really could use cpuc->pebs_record_size unconditionally, right?


