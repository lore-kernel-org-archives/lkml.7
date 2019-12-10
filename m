Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A814C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6ED20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TKSE5/SV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLJPft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:35:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfLJPfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lZYXwP0ni4XYi2YYlu9VVenpwLLmSfDHgkVywliZ2Ew=; b=TKSE5/SV3Q4191WpyeITcbWKB
        XZEL2twvP0MmrdwQqFpY/fHrfQbsJlr20oT+TNxookvYrvDmzxNtio+KSt956Okbk1TllUeWJaRIr
        Sc1x4KYpvNyibbf3FFOFBwqspqc1x2+vpyfM8DdwJN3kO+q1PZOl3GFz+N1jQNVGFDWEfZkIRhH1F
        j1Yq0zI9C+aJ6AlqeD7nkZ+9yNCVCGG8nEi5O5tfS3vFVoOZYTh4MQ4i4Vg3R7FqkMNWVEgdmOiHe
        y5lYgVu8Tybf9Wl/2vp60WvN1KxEnJ1myRBjH12NWFeqPSKsGCfht9hEO3xn52ERr6gd5qOpmUwAC
        OJvkxljlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iehYC-0003Rl-1Z; Tue, 10 Dec 2019 15:35:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD69C305DD6;
        Tue, 10 Dec 2019 16:34:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66E2229E07076; Tue, 10 Dec 2019 16:35:46 +0100 (CET)
Date:   Tue, 10 Dec 2019 16:35:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 2/2] perf/x86/intel/bts: Fix the use of page_private()
Message-ID: <20191210153546.GO2844@hirez.programming.kicks-ass.net>
References: <20191205142853.28894-1-alexander.shishkin@linux.intel.com>
 <20191205142853.28894-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205142853.28894-3-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 05:28:53PM +0300, Alexander Shishkin wrote:
> Commit
> 
>   8062382c8dbe2 ("perf/x86/intel/bts: Add BTS PMU driver")
> 
> uses page_private(page) without checking the PagePrivate(page) first,

Well, arguably it did check it, but you didn't like that WARN ;-)

> which seems like a potential bug, considering that page->private aliases
> with other stuff in struct page.
> 
> Fix this by checking PagePrivate() first.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Fixes: 8062382c8dbe2 ("perf/x86/intel/bts: Add BTS PMU driver")
> ---
>  arch/x86/events/intel/bts.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index d53b4fb86d87..9e4da1c5a129 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -63,9 +63,17 @@ struct bts_buffer {
>  
>  static struct pmu bts_pmu;
>  
> +static int buf_nr_pages(struct page *page)
> +{
> +	if (!PagePrivate(page))
> +		return 1;
> +
> +	return 1 << page_private(page);
> +}

Yes, that seems like a sensible helper.
