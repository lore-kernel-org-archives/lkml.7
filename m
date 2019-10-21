Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64870CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375EA2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sRZ9HnDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfJUK1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:27:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U8nciGtDPR4VxMqPCT0G6y87PJTC0sr+Cxw7PQD89NI=; b=sRZ9HnDb/2i4iXMIzwRA4KF+p
        kGmGwrhBT6EGup3ekX3UJDATVFG3mE/GAbVSWm4OMDW/NvG6TAv4VRKPx5VjE8oMOPlods8efqEAj
        Pp4xN8C7mw4jwADlxFDdNi8v/UUHEY2tg3sDmgu3VAh+5m3i3etI6nDS9ir0Dfh88JlO2Rb+MVZBn
        igBtHqp5bhNm7Pn9rpFq0EArHmpLe0nXwtAtqyza4O0/U5WzM4P7a4Yk0TeDLnWPi5jDUiEFRqES3
        KkatcvY7OkCcl/htuI7zlaYfujfPEX/Tj737MSa2aKvFyfEVk0HGh03+xxLkC+EGD92tCiMEV19ld
        QIR92/pfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMUu6-0003Dj-5f; Mon, 21 Oct 2019 10:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71AD3301124;
        Mon, 21 Oct 2019 12:26:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 897562022BA17; Mon, 21 Oct 2019 12:27:06 +0200 (CEST)
Date:   Mon, 21 Oct 2019 12:27:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] perf/core,x86: introduce sync_task_ctx() method
 at struct pmu
Message-ID: <20191021102706.GE1800@hirez.programming.kicks-ass.net>
References: <0b20a07f-d074-d3da-7551-c9a4a94fe8e3@linux.intel.com>
 <c75134ef-b71b-c080-8ee1-c09fb9fae764@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75134ef-b71b-c080-8ee1-c09fb9fae764@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 12:42:44PM +0300, Alexey Budankov wrote:
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132..60bf17af69f0 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -409,6 +409,13 @@ struct pmu {
>  	 */
>  	size_t				task_ctx_size;
>  
> +	/*
> +	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
> +	 * can be synchronized using this function. See Intel LBR callstack support
> +	 * implementation and Perf core context switch handling callbacks for usage
> +	 * examples.

You're forgetting to mark this: Optional

> +	 */

> +	void (*sync_task_ctx)		(void *one, void *another);

The traditional argment names for context switching functions are prev
and next.
