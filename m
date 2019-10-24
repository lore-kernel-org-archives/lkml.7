Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFEECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB6621655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZMs2V4fS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391313AbfJXNwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:52:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfJXNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+CloHryu+Y2JAtCHRYP2gfrRzMk74Qm1X2JFp8azpkw=; b=ZMs2V4fS2HmOMBrX62c/zCbZR
        wlT8brspJtgAyEhMeebZ/bTk4e475xMHIMowD84/WYgpzCsqG+o2xrhaFosqbVkNQMA538wwKmRLu
        ZBHaZWpspRT85nCSR7VMUVHhL49XLLx5YPZN0hCZaNfBGHYErqKLiMdXN/uTeMAYwMCIv/0ErQaVb
        7XH9SVaO7j+r8kF6P1ZLyJhiLv2f9xB/UOlZx5UqEVjZPRppUpJ5dfH97vDyJCN0suvU8TSQDWF/l
        +NgRLhEzLdUsxqf8I2Ymz/PAPYqzTKIqfFIJQbRzqo+u8NxyndTJG47L+EXphN/zWSKm+1RwBeeYy
        +H7rYth0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNdX4-0003VX-Dm; Thu, 24 Oct 2019 13:52:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E77C300489;
        Thu, 24 Oct 2019 15:51:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F2BB2B1D7CA1; Thu, 24 Oct 2019 15:52:04 +0200 (CEST)
Date:   Thu, 24 Oct 2019 15:52:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH v2 1/4] perf: Allow using AUX data in perf samples
Message-ID: <20191024135204.GD4114@hirez.programming.kicks-ass.net>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
 <20191022095812.67071-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022095812.67071-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:58:09PM +0300, Alexander Shishkin wrote:

> @@ -964,6 +979,7 @@ struct perf_sample_data {
>  		u32	reserved;
>  	}				cpu_entry;
>  	struct perf_callchain_entry	*callchain;
> +	u64				aux_size;
>  
>  	/*
>  	 * regs_user may point to task_pt_regs or to regs_user_copy, depending
> @@ -996,6 +1012,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>  	data->weight = 0;
>  	data->data_src.val = PERF_MEM_NA;
>  	data->txn = 0;
> +	data->aux_size = 0;
>  }
>  

That is really sad; so far we've managed to only touch a single
cacheline there, you just wrecked that.
