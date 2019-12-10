Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ED1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1B9206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AX0G8b+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfLJP3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:29:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfLJP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IqNNB/dKQxuX/qVwlQhiRj69dVnohkSLGb0fuGNR99s=; b=AX0G8b+sZ3TuK8AXQITZE7Kwu
        YjAMRx1oi6T96Cq09vlHmVN3AvcvFw5z/WCG2Ed78M16Y2X2hLRtDhul8H6arq028vymoFmP7adR0
        hFIUyj0LMhHErYUVMIpaiZYxgIBxAJ/65VoZFsmA4Oaira+RgBXSenKTCLyx1iNztgj2qeYLIOQpB
        Jjxt4LQAWugO12g67JEwUo4XP2jZsQ7jveyHywwJDgPAQ/Z604nSXCe6wlENfZAjjgNovm4OrJZYN
        Y10fw38MUJEnEjBhSFTq8WiUtSexjf8VFr1LN4uzTyP2Gv2PRURkf9KcOqGHEA/4aZwb3QWNZYoUu
        jwsVw0B4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iehSI-0000ce-2s; Tue, 10 Dec 2019 15:29:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39606300565;
        Tue, 10 Dec 2019 16:28:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2E1729E07075; Tue, 10 Dec 2019 16:29:39 +0100 (CET)
Date:   Tue, 10 Dec 2019 16:29:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH 1/2] perf/x86/intel/bts: Remove a silly warning
Message-ID: <20191210152939.GN2844@hirez.programming.kicks-ass.net>
References: <20191205142853.28894-1-alexander.shishkin@linux.intel.com>
 <20191205142853.28894-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205142853.28894-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 05:28:52PM +0300, Alexander Shishkin wrote:
> There is no comment or record anywhere that would explain the train of
> thought that went into this warning, it probably tried to make sure that
> the high order allocations indeed happened in the ring buffer code.
> 

> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -83,8 +83,6 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
>  	/* count all the high order buffers */
>  	for (pg = 0, nbuf = 0; pg < nr_pages;) {
>  		page = virt_to_page(pages[pg]);
> -		if (WARN_ON_ONCE(!PagePrivate(page) && nr_pages > 1))
> -			return NULL;
>  		pg += 1 << page_private(page);

I'm thinking that because ^^^^ uses page_private(), it wants to make
sure PagePrivate().

I haven't checked the current rules, but using page_private() without
PagePrivate() seems dodgy.

Also consider:

+               __nr_pages = PagePrivate(page) ? 1 << page_private(page) : 1;

>  		nbuf++;
>  	}
> -- 
> 2.24.0
> 
