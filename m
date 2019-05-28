Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6C6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789B920645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tRxTW6Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfE1NtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:49:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50440 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfE1Ns7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qgTnBXEzwmfX6lbLKAn+6i4FK+YKb4F4c1v8oOpqOnQ=; b=tRxTW6FbPmzoq52/Y2rIsSGM1
        7XlUyuEkXMaawJG9xRNbo5MvuUf24kGtHSJub61k9DjaNEpLYMRC2pC2x1BC41OxMSQ+kZtgWESqH
        WLHri6asNVqcZjWpye7Y32ZoEWyemGQTNTvxJphIK2DUbiDUrIvHq2W7OIH6nHpGfSibSOLOga4R1
        78RjMJj80fAyDqt0xU4Amr8B4AXdlHUedpjjMowRu43ypsc6pRJe7ddW/LaEi3aw8hn3qSxWdeKuH
        qql772bBRILsbs6QrnSXvZ+CGDamzZ7XrawT3K2c6RFJgEbtqZ6dwU1Ly6+slaaH82Sjhc0DbnggU
        Ma70lJ5KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVcT8-0004Ky-Ns; Tue, 28 May 2019 13:48:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 818C420756A00; Tue, 28 May 2019 15:48:45 +0200 (CEST)
Date:   Tue, 28 May 2019 15:48:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190528134845.GQ2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521214055.31060-5-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index b980b9e95d2a..0d7081434d1d 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -133,6 +133,11 @@ struct hw_perf_event {
>  
>  			struct hw_perf_event_extra extra_reg;
>  			struct hw_perf_event_extra branch_reg;
> +
> +			u64		saved_metric;
> +			u64		saved_slots;
> +			u64		last_slots;
> +			u64		last_metric;

This is really sad, and I'm thinking much of that really isn't needed
anyway, due to how you're not using some of the other fields.

>  		};
>  		struct { /* software */
>  			struct hrtimer	hrtimer;
> -- 
> 2.14.5
> 
