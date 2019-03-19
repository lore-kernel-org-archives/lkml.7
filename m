Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC45C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96F92146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u/9/gD9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfCSNO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:14:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfCSNO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WRstAW54K9DAQxY5wYUSu8t8dwJsGuL5Of2XWyuuB5o=; b=u/9/gD9w1tGqz0YeMxjZADZ61
        FVIFdjQ/bdQQS0BvlN/vUZp3r1f95o1s9npm7MKLB8zI1PVhErYZJ/aNU7RTdMjHz0/oOlqjTlyET
        z2RSHLZy9b+9/y8jfIVV6Q+7JzLD8C1Ehjv7AXNMQrIrrXrIJbtJOt4jjC6Ca4jiIuYjM7j1U/6OY
        kJKOJtIkNJDW+96qoKo/0LoLJuWnx0oQbseQDfm0FF8xcKrEvZVv/STItPZ7z5TWo47EDiYnIWUsF
        TzEoL3b7gXtYf10rePu9ozqxyj+uzDvY8JaNUgztcCFEy0/RZCxUqKWzhdySWo27XS/j6foiGzdUF
        qqQJGCk3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6EZz-0003HN-Bl; Tue, 19 Mar 2019 13:14:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF34723E8CA32; Tue, 19 Mar 2019 14:14:53 +0100 (CET)
Date:   Tue, 19 Mar 2019 14:14:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 02/22] perf/x86/intel: Extract memory code PEBS parser
 for reuse
Message-ID: <20190319131453.GG5996@hirez.programming.kicks-ass.net>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318214144.4639-3-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:41:24PM -0700, kan.liang@linux.intel.com wrote:
> @@ -1125,34 +1125,50 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
>  	return 0;
>  }
>  
> -static inline u64 intel_hsw_weight(struct pebs_record_skl *pebs)
> +static inline u64 intel_hsw_weight(u64 tsx_tuning)

That function name is now completely insane. It used to be a reference
to the hsw pebs format, but you just destroyed that.

>  {
> -	if (pebs->tsx_tuning) {
> -		union hsw_tsx_tuning tsx = { .value = pebs->tsx_tuning };
> +	if (tsx_tuning) {
> +		union hsw_tsx_tuning tsx = { .value = tsx_tuning };
>  		return tsx.cycles_last_block;
>  	}
>  	return 0;
>  }
>  
> -static inline u64 intel_hsw_transaction(struct pebs_record_skl *pebs)
> +static u64 intel_hsw_transaction(u64 tsx_tuning, u64 ax)

Guess what...

>  {
> -	u64 txn = (pebs->tsx_tuning & PEBS_HSW_TSX_FLAGS) >> 32;
> +	u64 txn = (tsx_tuning & PEBS_HSW_TSX_FLAGS) >> 32;
>  
>  	/* For RTM XABORTs also log the abort code from AX */
> -	if ((txn & PERF_TXN_TRANSACTION) && (pebs->ax & 1))
> -		txn |= ((pebs->ax >> 24) & 0xff) << PERF_TXN_ABORT_SHIFT;
> +	if ((txn & PERF_TXN_TRANSACTION) && (ax & 1))
> +		txn |= ((ax >> 24) & 0xff) << PERF_TXN_ABORT_SHIFT;
>  	return txn;
>  }
